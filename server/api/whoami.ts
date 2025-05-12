import { defineEventHandler, getHeader } from 'h3'

export default defineEventHandler((event) => {
    /**
     * getHeaders() gives you a plain object that maps
     * header names → value | string[] | undefined
     */
    const raw = getHeaders(event)

    /** Optional: coerce array values to comma‑separated strings
     * so everything is serialisable without surprises.
     */
    const headers = Object.fromEntries(
        Object.entries(raw).map(([key, value]) => [
            key,
            Array.isArray(value) ? value.join(', ') : value,
        ]),
    )

    return { headers }
})