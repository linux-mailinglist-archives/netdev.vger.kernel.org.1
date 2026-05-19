Return-Path: <netdev+bounces-289619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB2sBinaDGrhoQUAu9opvQ
	(envelope-from <netdev+bounces-289619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F05854A0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9142330136B8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E713E5577;
	Tue, 19 May 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH/zNhS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED43191D6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227163; cv=pass; b=XjEGXZrgujU1BxSg+2B3Nv/kz5PmKgBRzEN0oAwkxReWrvsKRA+q+kp8KEYLcrK41y9yrdB9IY6BlRzpMCZz+U440vbI1koUtQpiwqSgEoYh37JCYGTY1NMGtVsUgoZ7BYxrNboWaywHxpTUVQYJ0WeNwQvCHqqIa7Ii4k3XIf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227163; c=relaxed/simple;
	bh=E+tTTb2GqI1vaGquqP1jTXz6HThVzWgXkisHH8EuO8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAjSpJiV0P2lD0i5gpdqbXXZzebmH9cXiLHRD7/4AhMqHpfqxtlW+8dbw2KMd+C1x5I5+2Nx95vJP4RbApf83KuGXEXoSfvKM0Hco+0G0q75vMaxnNv/g/mqJSdoZp2IX7rRYCev+F/819HCL9wiLyN63FRQJOFFfCk9kseJx0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH/zNhS6; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bcda7765d64so995846766b.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779227160; cv=none;
        d=google.com; s=arc-20240605;
        b=fDFuPzjjFJn8+uSzCi11y1eZhK0YpefNTmIExE+KAeqf5/9P0mlRMSB+w1orYd32mv
         Vv1ZkJd/uBbenwqzi5ZUWB3aWeg2VcPgN0wma5h/7y97MYRPLJSJ81P7eIXkGl0nsomk
         YwwBTiC06NBLqzgs5fBjJTsdYvBXGlu2WfyGFr0uxc7iQA8heTiIaOtpiG5UAnBhCt0t
         +0AzcKV9hgaQBfWkDdvaQ7tnD6C6rxAgdLcLO/UpI7V2RnbOMMKWVCOEmorNkV0sQjTR
         QPCRPDWwy+4yYPtleJYjvb0We86U2x3C58BWQxfTnqskxgCdlWBwib3+OQTs+GvzNCc6
         /Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        fh=WjdmtJl5Pd25BodYoV280QC9qA6yiThquUu+rG/plHg=;
        b=fArK2ZNxJTezoMhU60WIns33mjUGZcNazx8zNF2Rb+O6/hbgbpgHPnY9g3lvHzO/9i
         SXQIu5jZ3Tl0HjPpeMNCfPaV7aDLD6eVEQ4w+/tPp/A03N1NvvS5vaccp6z+Wo9nyZPZ
         PZxbO1hshxiiyaJAYuQvFrjLz6M1JPvCSaSDtxPtuyqNv4ELOKOVROTOAhSCAZy1ZNTL
         KGbPtqiYZBh+TQpu1P5ygW1N2HZx1HESaMSStbyLmSTTSih1gIy0WynRWAWNPOxKxbAh
         fYY6UBnnH8rsascxTGwub4KxAnX502ATqsbbcbVwMSITN4wHBRzglqn69m5VXqZGLZk4
         hG8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779227160; x=1779831960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=qH/zNhS6SIUfjxARuMltjUodOjqSlRYKcR0o+zLMBNogXSHqlZQEMROvOJeC4f+f2E
         vLiEwZ0KUkgNGb+zoOfElkOVC713+DtaP4WZV9waekz+vU46a7NoDVWILgMsoDCezKT8
         FSHAz7tLZ3pD2vhTmhUfY6KiKSKdQ4x9dvtDvX6LI85Q6P96xQCCBLJizkqXaw5OtLRj
         jdafE8d7/JlkF70wStQuo26FL+txH1Ro8Fgth/OhWw+uenQEwgf0lMncusjGt0qbig8u
         jOEMJttZd/ZNnsssN5mDfT7QEI1QsqUGrOKAcLYyGfZKDPRihUu1MlMA6ZmuGeSyMXkC
         Irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227160; x=1779831960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=nugppNmkpPkAjBTovdrY4pF0gRfzFy+tY12l6msqEgWglWUDiGhLRn0Imlue907qFq
         j3zY2wcrwi8J5wksvWlpG7Y1pHSJLniFvLz3Ew0LLOlza9zv4eWGDlFCGjJGP9cjNMXW
         vc1y8h4imrMR4k9gIQVm6jdlZR8tuLAqR9pc9pokHS2xqnSdq8tuL9l6bxrXlJu1Hqi8
         Z5UPHpKERE9XLIaS/oRxgnFy5FEst8cbktp1OG4+Ii/DFsjcg59Q3kU23apZ4LpshSll
         M3/9fYtV1wqIBqSjUzEPl+rFKlMiR1FZfj4EbEg5+jZHcbDTaB/T4OriZ26y7zXnLcpX
         82Yg==
X-Forwarded-Encrypted: i=1; AFNElJ/zcRy127HuYR5EngUpJdkD3tArHvPaWvwNTVTLCzCHIiyLNoR1BMx6LbDYql78R4lKgG4E0Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNDKSbo+uKJ/Qm3pImB6C+ewAFHjtcEq4TDTDYLIYuAOXW/Ax
	H2u/JuS7AOGExZJLYLjegv9DNSuLsNhK0KcPtYBeG8z+poRHRO7yjtlcNJ+OQs++9vE0t8kaxVP
	QO510Qc1nb1J9tK5puBeMXSTb/Lc8X0U=
X-Gm-Gg: Acq92OH3wHyK+FuAB8u6gyf3xHkhc0zl08GnijS9gycOisyinTOwt2MmHUsnWY7OKao
	Lm773rQeeNgwXp7FXNGFS41NHx9BKTCetRAbkRfFOuMAbluA3HmSboYTMUtNRmUTpGtH/eD1wuZ
	sb7wwYbujiuaC5eLGeeRzWFezXeUPvP2lOx/T8DEEGtiV2PTwq0ulOB+qnd3WULBeTM0X8v4YIL
	m8wImh2yteBcKacizpw5BbjCZTllt4GT41U3vZhccW6NRoWucCHpKM/qtjD51SYgak2I7myvKPR
	pfFBmqPpFI1Hy1BnP0BS7SjQ0lf84r0P0IKTz8ksbYAqrpX4N51AgVqQdXe4xfoLMSJ1yBXJV/b
	0Ug3QkpxsZOOyfBOYXIu88nVqEeCIhfJYozLPnu6IrgsPOduuGgSbMITQ7GujfGwc21dQ
X-Received: by 2002:a17:907:c10:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bd4f34bd039mr1176086066b.25.1779227159626; Tue, 19 May 2026
 14:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519005206.628071-1-rosenp@gmail.com> <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
In-Reply-To: <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 14:45:47 -0700
X-Gm-Features: AVHnY4L2A3cissyWzUYO1tXUDK8qIVjkmnbUtyGij0zc_S6K7Z3Goo3Q7aTrmVA
Message-ID: <CAKxU2N8_JhZhsSqm15DxFBkXv=ZBYQXQJ7xdw6SHrwG9dsWZVg@mail.gmail.com>
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289619-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 733F05854A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 1:57=E2=80=AFAM Alexandra Winter <wintera@linux.ibm=
.com> wrote:
>
>
>
> On 19.05.26 02:52, Rosen Penev wrote:
> > Store the per-DMB connection pointers in the SMCD device allocation
> > instead of allocating a separate connection array.
> >
> > This keeps the connection table tied to the SMCD device lifetime and
> > simplifies the allocation and cleanup paths.
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> I don't think GPT did a good job here.
> There are many other instances, where smcd->conn is freed,
> those would need adoption as well afaiu.
git grep kfree | grep \\\-\>conn\)
drivers/media/dvb-core/dvbdev.c: kfree(dvbdev->adapter->conn);
net/wireless/sme.c: kfree(wdev->conn);
net/wireless/sme.c: kfree(wdev->conn);

I assume you mean net/wireless/sme.c
>
> I am also not sure that there is enough improvement in the idea
> to warrant a patch, but I leave that to the SMC maintainers.
>
>
>
> >  include/net/smc.h |  2 +-
> >  net/smc/smc_ism.c | 10 ++--------
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/smc.h b/include/net/smc.h
> > index bfdc4c41f019..a2bc3ab88075 100644
> > --- a/include/net/smc.h
> > +++ b/include/net/smc.h
> > @@ -40,7 +40,6 @@ struct smcd_dev {
> >       struct dibs_dev *dibs;
> >       struct list_head list;
> >       spinlock_t lock;
> > -     struct smc_connection **conn;
> >       struct list_head vlan;
> >       struct workqueue_struct *event_wq;
> >       u8 pnetid[SMC_MAX_PNETID_LEN];
> > @@ -50,6 +49,7 @@ struct smcd_dev {
> >       atomic_t lgr_cnt;
> >       wait_queue_head_t lgrs_deleted;
> >       u8 going_away : 1;
> > +     struct smc_connection *conn[];
> >  };
> >
> >  #define SMC_HS_CTRL_NAME_MAX 16
> > diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> > index e0dba2c7b6e3..bde938c5eb39 100644
> > --- a/net/smc/smc_ism.c
> > +++ b/net/smc/smc_ism.c
> > @@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char=
 *name, int max_dmbs)
> >  {
> >       struct smcd_dev *smcd;
> >
> > -     smcd =3D kzalloc_obj(*smcd);
> > +     smcd =3D kzalloc_flex(*smcd, conn, max_dmbs);
> >       if (!smcd)
> >               return NULL;
> > -     smcd->conn =3D kzalloc_objs(struct smc_connection *, max_dmbs);
> > -     if (!smcd->conn)
> > -             goto free_smcd;
> >
> >       smcd->event_wq =3D alloc_ordered_workqueue("ism_evt_wq-%s)",
> >                                                WQ_MEM_RECLAIM, name);
> >       if (!smcd->event_wq)
> > -             goto free_conn;
> > +             goto free_smcd;
> >
> >       spin_lock_init(&smcd->lock);
> >       spin_lock_init(&smcd->lgr_lock);
> > @@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *=
name, int max_dmbs)
> >       init_waitqueue_head(&smcd->lgrs_deleted);
> >       return smcd;
> >
> > -free_conn:
> > -     kfree(smcd->conn);
> >  free_smcd:
> >       kfree(smcd);
> >       return NULL;
> > @@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *di=
bs)
> >       list_del_init(&smcd->list);
> >       mutex_unlock(&smcd_dev_list.mutex);
> >       destroy_workqueue(smcd->event_wq);
> > -     kfree(smcd->conn);
> >       kfree(smcd);
> >  }
> >
>

