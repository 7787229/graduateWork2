package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 04.04.2017.
 */
@Entity
@Table(name = "users")
public class Pupil extends UsersEntity {
    public Pupil(){
        super();
        super.setRole("pupil");
    }

    //связь с потоиком
    private Set<ResultsEntity> results = new HashSet<ResultsEntity>();
    @OneToMany(mappedBy = "pupil", fetch = FetchType.LAZY,cascade=CascadeType.ALL, orphanRemoval = true)

    public Set<ResultsEntity> getResults() {
        return this.results;
    }

    public void setResults(Set<ResultsEntity> results) {
        this.results = results;
    }

    public void addResult(ResultsEntity result) {
        result.setPupil(this);
        this.results.add(result);
    }
    //множ связи
    private Set<GroupsEntity> groups =new HashSet<GroupsEntity>();
    @ManyToMany(fetch = FetchType.EAGER,mappedBy = "pupils")
    public Set<GroupsEntity> getGroups() {
        return this.groups;
    }
    public void setGroups(Set<GroupsEntity> groups){
        this.groups=groups;
    }





    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }
    @Basic
    @Column(name = "login", nullable = true, length = -1)
    public String getLogin() {
        return login;
    }
    @Basic
    @Column(name = "password", nullable = true, length = -1)
    public String getPassword() {
        return password;
    }
    @Basic
    @Column(name = "role", nullable = true, length = -1)
    public String getRole() {
        return role;
    }
}
