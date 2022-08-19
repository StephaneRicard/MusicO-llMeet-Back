const { eventDatamapper } = require('../models');
const { ApiError } = require('../helpers/errorHandler');

module.exports = {

    // récupérer la liste de tous les events
    async getAll(_req, res) {
        const events = await eventDatamapper.findAll();

        // permet d'éviter les doublons dans les groupes liés à l'annonce
        // (lorsque qu'ils ont plusieurs genre musicaux)
        events.forEach((event) => {
            // eslint-disable-next-line no-param-reassign
            event.group_name = [...new Set(event.group_name)];
        });

        return res.json(events);
    },
    // récupérer 1 event
    async getOne(req, res) {
        const eventId = req.params.id;
        const event = await eventDatamapper.findOne(eventId);

        if (!event) {
            throw new ApiError('event not found', { statusCode: 404 });
        }

        // permet d'éviter les doublons dans les groupes liés à l'annonce
        // (lorsque qu'ils ont plusieurs genre musicaux)
        event.group_name = [...new Set(event.group_name)];

        return res.json(event);
    },
    // supprimer 1 event
    async delete(req, res) {
        const eventId = req.params.id;
        const event = await eventDatamapper.findOne(eventId);

        if (!event) {
            throw new ApiError('event does not exists', { statusCode: 404 });
        }
        return res.json();
    },

    // créer un event (appelé annonce)
    async create(req, res) {
        const savedAd = await eventDatamapper.insert(req.body);
        res.json(savedAd);
    },

    // mettre à jour un event(table event uniquement)
    async update(req, res) {
        const eventId = req.params.id;
        const event = await eventDatamapper.findOne(eventId);
        if (!event) {
            throw new ApiError('Event does not exists', { statusCode: 404 });
        }
        const savedevent = await eventDatamapper.update(eventId, req.body);
        return res.json(savedevent);
    },

};
