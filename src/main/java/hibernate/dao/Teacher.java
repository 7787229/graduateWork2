package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 04.04.2017.
 */
@Entity
@Table(name = "users")
public class Teacher extends UsersEntity {
    public Teacher(){
        super();
        super.setRole("teacher");
    }
    //связь с потоиком
    private Set<TestsEntity> tests = new HashSet<TestsEntity>();
    @OneToMany(mappedBy = "teacher",cascade=CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)

    public Set<TestsEntity> getTests() {
        return this.tests;
    }

    public void setTests(Set<TestsEntity> tests) {
        this.tests = tests;
    }

    public void addTest(TestsEntity test) {
        test.setTeacher(this);
        this.tests.add(test);
    }
    //связь с потоиком
    private Set<GroupsEntity> groups = new HashSet<GroupsEntity>();
    @OneToMany(mappedBy = "teacher", fetch = FetchType.LAZY,cascade=CascadeType.ALL, orphanRemoval = true)

    public Set<GroupsEntity> getGroups() {
        return this.groups;
    }

    public void setGroups(Set<GroupsEntity> groups) {
        this.groups = groups;
    }

    public void addGroup(GroupsEntity group) {
        group.setTeacher(this);
        this.groups.add(group);
    }

    //связь с потоиком
    private Set<ResultsEntity> results = new HashSet<ResultsEntity>();
    @OneToMany(mappedBy = "teacher", fetch = FetchType.LAZY,cascade=CascadeType.ALL, orphanRemoval = true)

    public Set<ResultsEntity> getResults() {
        return this.results;
    }

    public void setResults(Set<ResultsEntity> results) {
        this.results = results;
    }

    public void addResult(ResultsEntity result) {
        result.setTeacher(this);
        this.results.add(result);
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
