package com.tickit.venue;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "venue", schema = "public", catalog = "tickit")
public class VenueEntity extends PanacheEntityBase {

    @Id
    @SequenceGenerator(
            name = "venueSeq",
            sequenceName = "venue_venue_id_seq",
            schema = "public",
            initialValue = 350,
            allocationSize = 1)
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "venueSeq")
    @Column(name = "venueid", nullable = false)
    public int id;
    @Column(name = "venuename", nullable = false, length = 100)
    public String name;
    @Column(name = "venuecity", nullable = false, length = 30)
    public String city;
    @Column(name = "venuestate", nullable = false, length = 2)
    public String state;
    @Column(name = "venueseats", nullable = false)
    public int seats;
}