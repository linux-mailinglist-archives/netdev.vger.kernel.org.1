Return-Path: <netdev+bounces-255822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOtZLtt5gGne8gIAu9opvQ
	(envelope-from <netdev+bounces-255822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:18:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A693CAC04
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 436133009B34
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBB2DE711;
	Mon,  2 Feb 2026 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0Zp3Owb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78750126BF1
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027064; cv=pass; b=Ad88kWE2+DZsTN4yDoEcIMil90+SA5/COLtaWCti0uo+1jLEmGgSuJyiio3x56vDwi5mYrJp247TAdbZl0L3ZLq28F68S6LPev3Y895PsrE58IJtm4tVT61pXfTfWbyII6BQXoeevcjmgElTeJxU67aaDKF9RmQB2CcE3f36pEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027064; c=relaxed/simple;
	bh=s8jkXMkjCGV/E5vW0aAw3oB5IaPoxxZes8GJmqiNvdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSqdp4VXtf1ShpOesgUX29S76Pj5zkfw5vl+W0jFy7tMuSdcby3s8avVtJRXeOIxr5XU/rRL1VW3UqC4FdqjakIqiFEM7NtKpBfsXuF3qC8r4GdP61fQYfyADugwdBbzKHtxd6eTYw8Pn+T7JAKkDkDGnXYTLjfklX2NQS0fYRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0Zp3Owb; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5033a2c4b81so51907301cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:11:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770027062; cv=none;
        d=google.com; s=arc-20240605;
        b=PEsqSwoAioH3C9AhsU1NypqFK7l/+A4Xun6+uofQxstKRiljiIfuNrkfcRW2jf0Xro
         xP4e12XoRjbZD65MqgawKODhNaBx6wCET02izIrYhJVV2+U6YaEh2hAA2T2OAxWRInWO
         D00RV7IiXkYlAQ1UxZxNJpGCMqlTYLPj4eTQtIeOCAZPLw54MtHsBVt9ur0Yw8pIGQSq
         voGcH0W3jTeCCYMs9ADFcpqbHbAJfHMa8xFIzsOwo88sZQjKZZzIu9vav8fc4wHlE2cT
         HUi/UwVNMCY9oAJWqmujwZxEaav6QwoTnGUTB+xGNwr0GH6hYbzCzYUIFPoXzZwBLFQC
         CmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Btp1cSJ3gD5Q5hHrfWq6ySyy2b2lUTGs3ekCWWjad0s=;
        fh=kVh3VRP0gxQbJ/U4EdgL4R6o/NDaGFziGL68Lf5U2RQ=;
        b=GPch9n5PfJjfwg6Pk96/A8WMnl4Aq4fkAp7/+lO/Y8cDHmfA8aZhMxUSuZ7Tw5SF34
         Q66vT1+VtTXOrjsUZX8/o5rpN3mKLjtk4to02ad/fi8Bq06LEUuMqRSuzeDYbMl/ormS
         EGB1LElsWWAYBcX+qS0JLklCc5me4d/8GSvb4Ho0gOH2FkRFYPUvmmh8O2AQZ7ySknDW
         h8yzGWSwYDYK6KT+nrOD3Tl7OBJpCDVUOLr1FwTHhYqn7IK2wMNayg9WRhC28iA0YXJ8
         xfVurPAX5Dc2nfFh8jT7rTSu9jLvIuq8AuSznNc+mBzrIvJxZQh3p3K1Gk6nHeEvOFpI
         yQGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770027062; x=1770631862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btp1cSJ3gD5Q5hHrfWq6ySyy2b2lUTGs3ekCWWjad0s=;
        b=H0Zp3Owb6lmoYYZIw8PRW7oXs0W71kb3i3nHYm86oUGFsAQ45Rf/yLolkSGdTeUzum
         WcDyjty6xZlNNlSPVPnV+NiUY5Q4r+0p/Oj9IEXLQQ+ZddSemMHPhom/KzgJ9AlT0pVL
         PaI4kpG7JFrEwHnGt1YcLMYpSH5qo8OFkEVbm5aJbAw/Oo42/59lZ0BkJBhThA3yDSmd
         IaX3pot7GaWw1EWDWMLJ/Lf2APvVp3KM9ThLH/j0nqRnpTSTzTylawI0cfs2lyCN1rv0
         jn3bX9ySDoa/Y8hvYpF1u35eOLVKqrG7cCp5XLTGRmlx8t3VaVltkcnW7Sb+2MIVh/IE
         RM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027062; x=1770631862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Btp1cSJ3gD5Q5hHrfWq6ySyy2b2lUTGs3ekCWWjad0s=;
        b=GOz2RIeRDvUHP/mHz3BrApVf3akvenB95/1P0NjsDrQs2gn9HMTVmWZZPNd129bIOO
         8QfPZVXOgCGanmkcLCzLD6M3iFZ2t0trMRDSVXtqYlNKEp8hS3BP2UmM65YZxAfheMCF
         9IiwfX68Ckoo7Znm93ck+nhZnL4M7lem5bbe4QgnTtAZWZ6TS82oT3RqtR0gQve6pQyL
         B2kEg25pwtcb0kBaAZpKhmDI5E529B8v2jLLCTp8e9ZxoEabVQfpH6qBkwAHABLsFCpj
         qv/SE1LdvtdFhOpWEAJBXZ7P6uVqlOsRdUCCOczLSdmX0xkcY6fP8WEev3ORl56XtfZ0
         CS6g==
X-Forwarded-Encrypted: i=1; AJvYcCXDSDT6yVe+EjkIiuoI1eqo97qIIEGNi6403T2VPegXY9tQIjQdT2UqX1sOg7fXatKt5Fp4vlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyVuTn7nDcv9lkeHW3vBtMWGwO5QgvUHupPPAj/CvbGI86I9U
	CUkWgy5CRBNSzuMVwaOyH5y7b0I6i3b/mgMaySiyf8NkZp2gJoAKgbekchXU3j6Hv9bdUbB9veO
	gH96YvGHLLOGwsfBrMOxgEhCmgLMyHIqR0l5Qdks/
X-Gm-Gg: AZuq6aJarduj7qbT/bHtEUQRUAe64QpDhXpPSIDZXtIgG8a3uESNzIwFPW992MTg6f5
	fsx1/QPQtZ4uzGmGP6KoZ8dgnSziOAe9wjKFyYMl8Gc8ORhlXQHXHc1Pxpa3VzoukRE0quAHxot
	5t0fB2wze5AYC61uHFSpnejckcrgz7QhDRUN4ETUXmK611V+RqHuGPhK+pU3Oy6U+4WvX6y6YCF
	bWvIDLT3GM1uWVd3Jnv7FYfZUUbmyiWdYNNgImlNBh1JBmVrHONUoVqUDEZJARHjKoyj0M=
X-Received: by 2002:a05:622a:48f:b0:4ee:26ef:7f4c with SMTP id
 d75a77b69052e-505d217c4e4mr137983991cf.17.1770027061826; Mon, 02 Feb 2026
 02:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131212934.2547995-1-edumazet@google.com> <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
 <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com> <CANn89iK95qb_=KWrcsvqEB9Bn0PXi3JkY5h09NiWuVWARABOww@mail.gmail.com>
 <CANn89iJRmEPJiz5-L_yJorU+xH5kBwraFy2_-=TwgkHzzfjKEg@mail.gmail.com>
In-Reply-To: <CANn89iJRmEPJiz5-L_yJorU+xH5kBwraFy2_-=TwgkHzzfjKEg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 11:10:50 +0100
X-Gm-Features: AZwV_QgbqiYSnOe_cp77sJ-3hAskXlj85vMYZZA5bFuBmkAX_OjtT-3sDaoIcHA
Message-ID: <CANn89iJd_jCkYsoey5Zf0zc8ASwt4+sg6bOjgyesQefWkBVE5w@mail.gmail.com>
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	fengwei_yin@linux.alibaba.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-255822-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 3A693CAC04
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Feb 2, 2026 at 9:47=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Mon, Feb 2, 2026 at 9:21=E2=80=AFAM dongchenchen (A)
> > <dongchenchen2@huawei.com> wrote:
> > >
> > >
> > > }
> > >
> > > [2] add delay to pype_seq_next
> > > diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> > > index 160dd729178f..73f5a20ef57c 100644
> > > --- a/net/core/net-procfs.c
> > > +++ b/net/core/net-procfs.c
> > > @@ -230,11 +230,14 @@ static void *ptype_seq_next(struct seq_file *se=
q, void *v, loff_t *pos)
> > >
> > >          pt =3D v;
> > >          nxt =3D pt->list.next;
> > > +       if (pt->dev)
> > > +               mdelay(5000);
> >
> > Waiting 5 seconds while holding RCU is going to fire the soft lockup
> > detection after ~two calls to ptype_seq_next()
> >
> > What is the actual trace you got, and what happens if you reduce to
> > mdelay(1000) ?
>
> OK, I took a look, and ptype_get_idx() needs to return information
> about what list the returned pt is in.
>
> I will send a V2 ,thanks.

Here is what I will squash, the diff against V1 is :

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 160dd729178fd37a6340148d9e35f95bd92aecdb..ad63556c9e0abd15cbfac7777c3=
1894d2eef037b
100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -170,8 +170,15 @@ static const struct seq_operations softnet_seq_ops =3D=
 {
        .show  =3D softnet_seq_show,
 };

+
+struct ptype_iter_state {
+       struct seq_net_private  p;
+       struct net_device       *dev;
+};
+
 static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 {
+       struct ptype_iter_state *iter =3D seq->private;
        struct list_head *ptype_list =3D NULL;
        struct packet_type *pt =3D NULL;
        struct net_device *dev;
@@ -181,12 +188,16 @@ static void *ptype_get_idx(struct seq_file *seq,
loff_t pos)
        for_each_netdev_rcu(seq_file_net(seq), dev) {
                ptype_list =3D &dev->ptype_all;
                list_for_each_entry_rcu(pt, ptype_list, list) {
-                       if (i =3D=3D pos)
+                       if (i =3D=3D pos) {
+                               iter->dev =3D dev;
                                return pt;
+                       }
                        ++i;
                }
        }

+       iter->dev =3D NULL;
+
        list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
                if (i =3D=3D pos)
                        return pt;
@@ -218,6 +229,7 @@ static void *ptype_seq_start(struct seq_file *seq,
loff_t *pos)

 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+       struct ptype_iter_state *iter =3D seq->private;
        struct net *net =3D seq_file_net(seq);
        struct net_device *dev;
        struct packet_type *pt;
@@ -229,19 +241,21 @@ static void *ptype_seq_next(struct seq_file
*seq, void *v, loff_t *pos)
                return ptype_get_idx(seq, 0);

        pt =3D v;
-       nxt =3D pt->list.next;
-       dev =3D rcu_dereference(pt->dev);
+       nxt =3D READ_ONCE(pt->list.next);
+       dev =3D iter->dev;
        if (dev) {
                if (nxt !=3D &dev->ptype_all)
                        goto found;

                for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
-                       if (!list_empty(&dev->ptype_all)) {
-                               nxt =3D dev->ptype_all.next;
+                       nxt =3D READ_ONCE(dev->ptype_all.next);
+                       if (nxt !=3D &dev->ptype_all) {
+                               iter->dev =3D NULL;
                                goto found;
                        }
                }
-               nxt =3D net->ptype_all.next;
+               iter->dev =3D NULL;
+               nxt =3D READ_ONCE(net->ptype_all.next);
                goto net_ptype_all;
        }

@@ -252,20 +266,20 @@ static void *ptype_seq_next(struct seq_file
*seq, void *v, loff_t *pos)

                if (nxt =3D=3D &net->ptype_all) {
                        /* continue with ->ptype_specific if it's not empty=
 */
-                       nxt =3D net->ptype_specific.next;
+                       nxt =3D READ_ONCE(net->ptype_specific.next);
                        if (nxt !=3D &net->ptype_specific)
                                goto found;
                }

                hash =3D 0;
-               nxt =3D ptype_base[0].next;
+               nxt =3D READ_ONCE(ptype_base[0].next);
        } else
                hash =3D ntohs(pt->type) & PTYPE_HASH_MASK;

        while (nxt =3D=3D &ptype_base[hash]) {
                if (++hash >=3D PTYPE_HASH_SIZE)
                        return NULL;
-               nxt =3D ptype_base[hash].next;
+               nxt =3D READ_ONCE(ptype_base[hash].next);
        }
 found:
        return list_entry(nxt, struct packet_type, list);
@@ -279,6 +293,7 @@ static void ptype_seq_stop(struct seq_file *seq, void *=
v)

 static int ptype_seq_show(struct seq_file *seq, void *v)
 {
+       struct ptype_iter_state *iter =3D seq->private;
        struct packet_type *pt =3D v;
        struct net_device *dev;

@@ -286,7 +301,7 @@ static int ptype_seq_show(struct seq_file *seq, void *v=
)
                seq_puts(seq, "Type Device      Function\n");
                return 0;
        }
-       dev =3D rcu_dereference(pt->dev);
+       dev =3D iter->dev;
        if ((!pt->af_packet_net || net_eq(pt->af_packet_net,
seq_file_net(seq))) &&
                 (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
                if (pt->type =3D=3D htons(ETH_P_ALL))
@@ -319,7 +334,7 @@ static int __net_init dev_proc_net_init(struct net *net=
)
                         &softnet_seq_ops))
                goto out_dev;
        if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
-                       sizeof(struct seq_net_private)))
+                       sizeof(struct ptype_iter_state)))
                goto out_softnet;

        if (wext_proc_init(net))

