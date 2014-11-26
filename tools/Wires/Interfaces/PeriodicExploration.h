#pragma once

#include <string>
#include <vector>

#include <Core/EigenTypedef.h>
#include <Mesh.h>
#include <Wires/WireNetwork/WireNetwork.h>
#include <Wires/Parameters/ParameterManager.h>

class PeriodicExploration {
    public:
        PeriodicExploration(const std::string& wire_file,
                Float cell_size,
                Float default_thickness);

        void with_parameters(
                const std::string& orbit_file,
                const std::string& modifier_file);

        void with_refinement(
                const std::string& algorithm,
                size_t order);

    public:
        size_t get_num_dofs() const {
            return m_parameters->get_num_dofs();
        }

        const VectorF get_dofs() const {
            return m_parameters->get_dofs();
        }

        void set_dofs(const VectorF& val) {
            m_parameters->set_dofs(val);
        }

        bool is_thickness_dof(size_t i) const {
            return i < m_parameters->get_num_thickness_dofs();
        }

        void periodic_inflate();

        /**
         * Return true only if tetgen succeeded.
         */
        bool run_tetgen();

        Mesh::Ptr get_mesh() { return m_mesh; }
        MatrixFr get_vertices() const { return m_vertices; }
        MatrixIr get_faces() const { return m_faces; }
        MatrixIr get_voxels() const { return m_voxels; }
        std::vector<MatrixFr> get_shape_velocities() const { return m_shape_velocities; }

    private:
        void compute_shape_velocity();
        void update_mesh();

    private:
        Float m_default_thickness;
        WireNetwork::Ptr m_wire_network;
        ParameterManager::Ptr m_parameters;

        MatrixFr m_vertices;
        MatrixIr m_faces;
        MatrixIr m_voxels;
        VectorI  m_face_sources;
        Mesh::Ptr m_mesh;
        std::vector<MatrixFr> m_shape_velocities;

        std::string m_refine_algorithm;
        size_t m_refine_order;
};