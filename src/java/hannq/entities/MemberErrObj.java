package hannq.entities;

import java.io.Serializable;

/**
 *
 * @author Han Quang
 */
public class MemberErrObj implements Serializable{
    private String idErr, pwErr, nameErr, confirmErr, id, name;

    public MemberErrObj() {
    }

    public String getIdErr() {
        return idErr;
    }

    public void setIdErr(String idErr) {
        this.idErr = idErr;
    }

    public String getPwErr() {
        return pwErr;
    }

    public void setPwErr(String pwErr) {
        this.pwErr = pwErr;
    }

    public String getNameErr() {
        return nameErr;
    }

    public void setNameErr(String nameErr) {
        this.nameErr = nameErr;
    }

    public String getConfirmErr() {
        return confirmErr;
    }

    public void setConfirmErr(String confirmErr) {
        this.confirmErr = confirmErr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
