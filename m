Return-Path: <netdev+bounces-302702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tZapMG+SQmrS9wkAu9opvQ
	(envelope-from <netdev+bounces-302702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:42:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A06DCD7C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:42:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zz8Q8muc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302702-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302702-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C6930775E8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BCA37CD48;
	Mon, 29 Jun 2026 15:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F837CD32
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:31:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747112; cv=pass; b=NRulUypWEneEjwxN17xL6kUjVHUAogljD4rYfUHIwzW1PBuo9OZL/SwXhv9CkzN9Arr4girJxT2DTM9GXh/b+qpakNJRIKMCnVqthkO3klBsfxJOFgygg/Y0y+GfyhaqMtuVYYY/j0mKECe4eJHtL+NL7P92hW9Mmk6XyKrXDLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747112; c=relaxed/simple;
	bh=dgQq7uOtRk1Fieb4AjgFns8G5xGk1jK0JDbMwPCnVVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKUZ6IuimsB/9lgGBD7cnZr2zI4yodTl+JVoHmGiUeRYY46gvGyzUQ7lWXyZio/mG7OW6BwlnP7AQz7NZOK44ovsAzl7YOSZuYXd+4XyisM3ZMr5hIsvh9QajvsGkorYNVefhsmuvmwOMBgJz7N+EFP7IV18dzedkGvNjfciqpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz8Q8muc; arc=pass smtp.client-ip=209.85.218.68
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-c124c3c876aso270347866b.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782747109; cv=none;
        d=google.com; s=arc-20260327;
        b=BmvTrKIDZKJyLPNiB6Mk95V+aJv/GI0UlIWyhCumlUQQZh3e84hZ2rP4F3PDJc5iL3
         UzsipNY0AiYinOOgG/nLKn403dSWKo90AIwOoKC5cZbbQ9bCywe0YrvWEt3poI+2dtvU
         6Y3cg0/9B7EXsPOCa3SiTQbNbw/UtS59kPtUkyL4lmlLGyx3CQAjaj5git+qNH8qW91b
         JWH0gmRJ0rb+l+FUQ5+zMqS7iuf8c12FEivlStHZkkuisr/iLyPUGwu4TTkCBxLOfySY
         qw6rpvy8qxws0Fv0jLIG/ZvY+74tq104CRt9rA0IoTfxwnL2yyJp8osC4+J5u5uzv+e5
         wRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        fh=ni2Y+XPrQJTcgDUGK5SIO8N4iDPgI7oCb/Hg1GVvXAI=;
        b=hSnqt3hOMxAzz8/9aA03Q9ORTNKLWlRR0EYEw6FZjbDhgxG+2WAsTPcGH6tnA786Lx
         swkB7VjQUPs1XWMIvhzeFunKeSwVx7LCl91h1SxLJxY8sTluJ00WtDNGTPGi2NQx6U9n
         gdwZ7TEulE5myvtkVmJxcIBocjgYIywxZ/PouvxyOY1+eHdN7Xn1mD1KONIgU2dB5UE1
         FD0nprpxmOMcHK/vmiR+OWyx5HONVFxCRmzJKBoR/Gtz+3laXEj/vJwwI5dGxB8mO9+t
         VFgieDn4Aa3DO0i0NeJpe66cnLku0YGY2jOGJXufmycHqvEzazgs8dOvRIni0+kYcppc
         wOPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747109; x=1783351909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        b=Zz8Q8mucCXSuIJQ0dFhAbQdvwstPbz0TFHGHqcKaADUqX2zFCgtQHbsQmTjD1z7aIm
         ghy0dU6oeqZjeW0iSPGrtEG+hkWZeDZcVWcgXQmxiAaWD9mcXpsPJC40tBPxTjtg1ZiN
         zMnlRbUuoA34ejRvP0bSfrgEVw9pp7EMTUb3gSA7DHwHSdhCbkzZstvQSfo14FNH4Exr
         hqFrNxjKgivv9iBYksNXnEgJJv37FnmbMzZr8qyozup9jdJT2vCCStxDYpO4Ozk8NFhW
         dSDwIAM/oXuoE8A3D1Ajrmn7GnMMJVaepiGs3qQgiZ+Ubnx6CecBATMyreqHJv8QpDn6
         3PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747109; x=1783351909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        b=W0UA4mp5Z7fkLF9aV/qX9/8PW7uSWR+9izTVW5PaGpTSx/CdglkkDrviiSwPdkzwcg
         4Gly3c88H6TXliLVj+xbjju2JNhrPWPZGzGG7f+qziLTDf3W4EaJ/s5nNPIw8QL0b4uC
         FGmjeQ1AZMP2bK2kEETrrMZSbnMmUExiSe29tcw1Zw7v+04EJOQQZD2Zt1txWLxRVxbH
         XkYDLHGdXQYAa4RGpTNDkNIaPVi0hlLsBjfnd9NwXQK0sDzEpoYWI5vSvyZry9995N9W
         2g8ro6QT2SCpflPdTneR92WjU0sOvV3UhOQOU5aAAZCDAr6YBGyNSDCgDTpujH403wnY
         D6BQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVq7L/MPtO0+aCiLOGExfF1f/6MaCXbkaDt0WzSZlK39CjFPQXPX9DYtOYObzo1EA/xy7TOTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu7pF33ZgYATbuQsgugXpXLKGjK7eEfEJiJtApCtij1tm7OiC
	tYpidHbuFXoq7EvtKKJSg18QtbQ7R3Zjug8f28i1YNn/EbT6aHutJ2k2aewY+KH8O0eNUdcadfD
	4sHOsA2VjUgohzGPqa3BIT1J3pHFnlEc=
X-Gm-Gg: AfdE7clzlRL7o2c0KfLCOZun8r3o3FOG26bOYrlp5mllPezBOUZpP/eByhttW7Jcp04
	xb4VxVmumJCtsY7E/jiEfNRb1ZFDOmtQgedD2t9HbUGJqed3NmwviMU9fDLzG5RRLLSneTEUGOZ
	tZebT1dQ7GDsHVUXhAv6phY7sgqOrmSJQdwZojQdeHQKWETPcybX5dqAr0ePgcNMA6sLgcpuf2a
	7pV/9N9Eb9VgpT8a11Q3kd2cKHUg5o3bNHWpLztb/b3xYSSNXlb/nxXw7MoTenzjRWdp66AEInf
	3NTpzCk=
X-Received: by 2002:a17:906:6a0f:b0:c12:67e9:bf25 with SMTP id
 a640c23a62f3a-c1267e9ec2cmr210780766b.42.1782747108817; Mon, 29 Jun 2026
 08:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
 <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com> <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
In-Reply-To: <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
From: tt roxy <roxy520tt@gmail.com>
Date: Mon, 29 Jun 2026 23:31:35 +0800
X-Gm-Features: AVVi8CcQjQMp_xcdx0xwS5kqGRWw-qKmoeiNy_pIdDDyyaU1tDfx-MgT7CJLDQo
Message-ID: <CALMqdkR5M5oTTLS9Cisq6C5kM4byoCL3XHBWKXdq3awD1j3X9w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: avoid auth_enable sysctl UAF during netns teardown
To: Xin Long <lucien.xin@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[roxy520tt@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302702-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roxy520tt@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 385A06DCD7C

On Mon, Jun 29, 2026 at 10:23=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Mon, Jun 29, 2026 at 10:04=E2=80=AFAM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrot=
e:
> > >
> > > From: Zhiling Zou <roxy520tt@gmail.com>
> > >
> > > proc_sctp_do_auth() updates the SCTP control socket after changing
> > > net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> > > ctl->data, so an already opened sysctl file can still target a networ=
k
> > > namespace while that namespace is being torn down.
> > >
> > > SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> > > sctp_ctrlsock_exit() runs earlier because the control-socket pernet o=
ps
> > > are registered after the defaults ops.  This leaves a teardown window
> > > where auth_enable is still writable after inet_ctl_sock_destroy() has
> > > released net->sctp.ctl_sock, leading to a use-after-free when the sys=
ctl
> > > handler locks and dereferences the stale socket.
> > >
> > > Unregister the per-net SCTP sysctl table before destroying the contro=
l
> > > socket.  Make sctp_sysctl_net_unregister() tolerate a missing header =
and
> > > clear the saved pointer so the later defaults exit path and init-erro=
r
> > > path can safely share the same unregister helper.
> > >
> > > Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current-=
>nsproxy")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > > Assisted-by: Codex:gpt-5.4
> > > Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> > > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > > ---
> > >  net/sctp/protocol.c | 3 +++
> > >  net/sctp/sysctl.c   | 9 +++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > > index 587b0017a67d..ae381d304bd5 100644
> > > --- a/net/sctp/protocol.c
> > > +++ b/net/sctp/protocol.c
> > > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struc=
t net *net)
> > >
> > >  static void __net_exit sctp_ctrlsock_exit(struct net *net)
> > >  {
> > > +       sctp_sysctl_net_unregister(net);
> > > +
> > >         /* Free the control endpoint.  */
> > >         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> > > +       net->sctp.ctl_sock =3D NULL;
> > >  }
> > >
> > >  static struct pernet_operations sctp_ctrlsock_ops =3D {
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 15e7db9a3ab2..fca840484ebf 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> > >
> > >  void sctp_sysctl_net_unregister(struct net *net)
> > >  {
> > > +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > >         const struct ctl_table *table;
> > >
> > > -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> > > -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> > > +       if (!header)
> > > +               return;
> > > +
> > > +       table =3D header->ctl_table_arg;
> > > +       unregister_net_sysctl_table(header);
> > >         kfree(table);
> > > +       net->sctp.sysctl_header =3D NULL;
> > >  }
> > >
> > >  static struct ctl_table_header *sctp_sysctl_header;
> > > --
> > > 2.43.0
> > >
> >
> > Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), an=
d call
> > it AFTER sctp_ctl_sock_init().
> >
> > This is not just for being symmetric, but also fixes two problems:
> >
> > 1. A regression caused by this patch:
> >
> > If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(=
),
> > there's no place to call sctp_sysctl_net_unregister() on the err path.
> >
> > 2. A pre-existing issue reported by sashiko-gemini:
> >
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 15e7db9a3ab2e..fca840484ebf7 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> > >
> > > void sctp_sysctl_net_unregister(struct net *net)
> > > {
> > > + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > > const struct ctl_table *table;
> > This is a pre-existing issue, but I noticed a potential race condition
> > during SCTP module initialization related to the sysctls modified here.
> > During sctp_init(), sctp_defaults_ops registers the sysctls globally be=
fore
> > sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
> > sctp_init() {
> > ...
> > status =3D register_pernet_subsys(&sctp_defaults_ops);
> > if (status)
> > goto err_register_defaults;
> > ...
> > status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
> > ...
> > }
> > If userspace accesses the sysctls in this window, proc_sctp_do_auth() c=
ould
> > dereference a NULL pointer since it assumes ctl_sock is ready:
> > proc_sctp_do_auth() {
> > ...
> > struct sock *sk =3D net->sctp.ctl_sock;
> > net->sctp.auth_enable =3D new_value;
> > /* Update the value in the control socket */
> > lock_sock(sk);
> > ...
> > }
> > Can we hit a kernel panic here if the sysctl is modified during automat=
ic
> > module loading?
> > [...]
> >
>
> Also, if you don't mind, please try to address another issue reported
> in sashiko-gemini:
>
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index 587b0017a67d5..ae381d304bd53 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct =
net *net)
> >
> > static void __net_exit sctp_ctrlsock_exit(struct net *net)
> > {
> This isn't a bug introduced by this patch, but while reviewing the netns
> teardown sequence, I noticed the SCTP UDP tunnel sockets appear to leak.
> In sctp_defaults_exit():
> sctp_defaults_exit() {
> /* Free the local address list */
> sctp_free_addr_wq(net);
> sctp_free_local_addr_list(net);
> ...
> }
> Should sctp_defaults_exit() call sctp_udp_sock_stop(net) to ensure the
> UDP tunnel sockets are closed?
> If a user creates a network namespace, writes to the net.sctp.udp_port sy=
sctl
> to allocate the sockets, and then destroys the namespace, could these soc=
kets
> remain active and cause a use-after-free of struct net when packets arriv=
e?
> [...]
>
> maybe by adding sctp_udp_sock_stop() in sctp_ctrlsock_exit(), and call it=
 AFTER
> sctp_sysctl_net_unregister() in a separate patch.
>
> Thanks.

Thanks for the review.

I addressed both comments in v2. Patch 1 moves the per-net SCTP sysctl

registration after sctp_ctl_sock_init() and keeps the unregister before

destroying the control socket. Patch 2 separately stops the SCTP UDP tunnel

sockets after sysctl unregistration during netns teardown.

I will send the v2 series as a new threaded 0/2, 1/2, 2/2 patch series.

Thanks,

Zhiling

