Return-Path: <netdev+bounces-302682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4JxrKeiEQmrt8wkAu9opvQ
	(envelope-from <netdev+bounces-302682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3F6DC33B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VdMXQgGN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302682-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302682-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A38032F125E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A6833263F;
	Mon, 29 Jun 2026 14:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4F1DED4C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:23:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742988; cv=pass; b=Cp+JOMcvQzTH6cGTZl8AilIa6hissae6ABXy3rzGqYu8i/oP3o6VKrc72nyey+r3aBrh2cxcYPWgQQW/Z925VGzawjRiP0ATZvi+RbpIFbJd0vArCL6fSwhNHFsi29cVNyzlLwUZJr8nYiSyErX3cjUbFb8eLsPgS9JnMOYJN2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742988; c=relaxed/simple;
	bh=wiXq41bdBk83YHqf1MVi12r95Q6R/cZ8huPoVZGBeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1xXCNUxV0wMo9hfTKW99H0aXRat2TcoFfH5Jw3x55HIJyvtSPkddnYNX5zH44sfOXfwoYqzkMPcZK1M3sMIcqWm9/XwKHZ87X/m3fWmy5X3+/G4wbpnUei5xG1+Wf1y9m6f6jc+5Zl1L8P0IdcwDv6IqOYuiMVvXH9dnxH6cY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdMXQgGN; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845e47133c9so428438b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742985; cv=none;
        d=google.com; s=arc-20260327;
        b=Bz5qPGqOZuadt1OSzONjcHUTdJ/a1VwZY3h/yZuB/8XkwDz3EvNEtdLZ9rvUnmUFBL
         NRHi2TkMRTG7Xp9ozdM8fWLSiuMcnX9+kiX1X3TAKjR3/54yY3WYP7w0VkbI1zYrv3xh
         QolFEV10W+N9pzIMLAfy0wWwjVjqO8evxKaU+R1lM45ZFMXGt0k9mw61xSlkqjJNWd4z
         +zJzWZXyvx5h4Fj2SubsAFD3OVYAs4RTrlabemjtAVM9rlffPAXY3ObMDC0oXGxl2ZSE
         I1pWcNONzQQKaSBA6rD0YgcdV3PkWD+P8vb1NmA9IfQLFBgcvXLRWJhjYDrTqOvFG3Ta
         ji9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        fh=MPVuupPxULEPckBkA1Mfx5l7Bwsavy1xoEIOSRmGhlc=;
        b=LpoVgll/oQb6bEHQ9cmW2MP5hhXvBzXostRLc3Qw4fMCxvVCwsk5sJ6FAgBGAdXLbW
         KS1V4dD4N4iumAFjH6MMrCKgcNwPc5PCSq+L4ZjxEShtotsVMMFjZlnrnSajDGPAqD35
         NYcFlIrMPn5zLe2VM2D5c0LHu4BzLbHUR6cLdjNABr4a/Yt0cVJgb4Gr/N4uaEpG5k6D
         kGxaTQN0fQ7hvDMRL+4CY2tuwjwGyMjZN6gxl0sQ0eaztVa5SsZhBw31n4mniYlyEK57
         9uW7BWC6Raup+IPOJLhWPFlTKCM7+jQsVbtK7U4fGtgI4vVOitb1/r+9V2Mtjkgki0Bg
         hH+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742985; x=1783347785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        b=VdMXQgGNdq87zEURJeYmtTrz+9/5t4hCB+f00IjXNGfdAfsqUHYngnt34PZqSjREh0
         ktcME8C6XemNoCisbyI+B8nMwk8ap3qTcTb62sSol/0zD8NEnLR/Y4C0etrKHs3hPM3Q
         KbnqR306u2Cq6liKmuD9cWoB5io7zac8CkovdRWgTsjPETnFIEreP0gVLGYktZgPGCJX
         xDxV/RwMB9QaeNqdJ6MDDy1x9R590QGQ4ipvnUFw4cr1bOaogpImemH62jr7sznzArNz
         iIhBdl2RIjtzbe8toVxmUsmx41alIbv8R59d1rsrUl1weLd4t7FAYq2SxvWXjkZzzOB6
         yCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742985; x=1783347785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        b=T8XUtPQ2AiFJc1z3/tqjc3H+mtsaWtyEE7zeXehNLGCaRVIZKsnET0EI5X4p51rwdP
         vRRX7rpMbE/q5RGwMBQRszsFKHEyPPSijraN70H9YUk/dWvLSqqQeOUTPzEk5pY4eiDb
         T4nvNys6iHfZuzclhry0ucbeSB2KMHgZlRbnrweDkKsnTd417yjg6TB/tqQUyUj1ENwS
         6fRZeGyK4kItYQL4/iHYdEshzwkDBw+ea65CqZzTzUj/KGQdci3TPlNu8mTp3Y7Oqn0F
         hR+1rL2d2MLu5A1QA0INrIlIPT0aZukyAXQHfIC7GOxC34j/4HMDFtunY91r80Nc9SZS
         OHOg==
X-Forwarded-Encrypted: i=1; AHgh+RqzeV5iCte3Q2ovixIqBERz4yS92rdsePcy8qCftEy97+P3tNYH5mJrpo0N1/9nVAbS0rMvd8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAyBdjvt1hCTA3U05znFS1Hl6p7eGsRWrVvXCMxwNJUHIjbEJ
	0tjCHzJ/StHenq3PzfqZABiPuNaZQSRIzwfMQSELk5iqjuxyQA0XdtHy5IsvMr4ue3Zb8cDcyma
	zrwfdJU2G2mlbMCeUHpTdIp0ctmaNEQTZtpSo
X-Gm-Gg: AfdE7clzha89eCOQQEW6ZOlJf+avRRVeUPySJKfAjHgk7kZia9BqUxho1ifD/sMdf1l
	xIC0y+cF/myD3+6OTR3+p7UZS/LWPssOm+x0HqjW7VCbVOVvCXE6m+uM4cl01GSVsR1jwuQW3lE
	j6oz4Y63dWUSPfu/XP0BVbIM7UcPRBYZkbGPMZAt2NFVAFT78A70qdRCF8j52LK+lDOZyXt1Zs5
	lywMtAuFRpjCOvWVk4CsXiCnKHMnaDmtougMkGv/ak4N3EDusYbD6hP8qazBDwawCUbX8wbH7fl
	QrAU+sVZHTX4qX6qlC5mT5pPweN5xFPZeQVwZLQTpsxIJTVx9iJLwDZjuNzmAy0fi5PAVelxops
	L9b7CnQ==
X-Received: by 2002:a05:6a00:b53:b0:847:8bd0:1b96 with SMTP id
 d2e1a72fcca58-8478bd026dbmr2120595b3a.23.1782742985236; Mon, 29 Jun 2026
 07:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
 <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
In-Reply-To: <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 29 Jun 2026 10:22:53 -0400
X-Gm-Features: AVVi8Cc0LriEm6penJth8F-rFoWHt7QeBo7GRJOclqZWHvFXGZ2zmHrD3gGImbY
Message-ID: <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: avoid auth_enable sysctl UAF during netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	roxy520tt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lzu.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,lzu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1C3F6DC33B

On Mon, Jun 29, 2026 at 10:04=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Zhiling Zou <roxy520tt@gmail.com>
> >
> > proc_sctp_do_auth() updates the SCTP control socket after changing
> > net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> > ctl->data, so an already opened sysctl file can still target a network
> > namespace while that namespace is being torn down.
> >
> > SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> > sctp_ctrlsock_exit() runs earlier because the control-socket pernet ops
> > are registered after the defaults ops.  This leaves a teardown window
> > where auth_enable is still writable after inet_ctl_sock_destroy() has
> > released net->sctp.ctl_sock, leading to a use-after-free when the sysct=
l
> > handler locks and dereferences the stale socket.
> >
> > Unregister the per-net SCTP sysctl table before destroying the control
> > socket.  Make sctp_sysctl_net_unregister() tolerate a missing header an=
d
> > clear the saved pointer so the later defaults exit path and init-error
> > path can safely share the same unregister helper.
> >
> > Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->n=
sproxy")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/sctp/protocol.c | 3 +++
> >  net/sctp/sysctl.c   | 9 +++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index 587b0017a67d..ae381d304bd5 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct =
net *net)
> >
> >  static void __net_exit sctp_ctrlsock_exit(struct net *net)
> >  {
> > +       sctp_sysctl_net_unregister(net);
> > +
> >         /* Free the control endpoint.  */
> >         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> > +       net->sctp.ctl_sock =3D NULL;
> >  }
> >
> >  static struct pernet_operations sctp_ctrlsock_ops =3D {
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 15e7db9a3ab2..fca840484ebf 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> >
> >  void sctp_sysctl_net_unregister(struct net *net)
> >  {
> > +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
> >         const struct ctl_table *table;
> >
> > -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> > -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> > +       if (!header)
> > +               return;
> > +
> > +       table =3D header->ctl_table_arg;
> > +       unregister_net_sysctl_table(header);
> >         kfree(table);
> > +       net->sctp.sysctl_header =3D NULL;
> >  }
> >
> >  static struct ctl_table_header *sctp_sysctl_header;
> > --
> > 2.43.0
> >
>
> Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), and =
call
> it AFTER sctp_ctl_sock_init().
>
> This is not just for being symmetric, but also fixes two problems:
>
> 1. A regression caused by this patch:
>
> If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(),
> there's no place to call sctp_sysctl_net_unregister() on the err path.
>
> 2. A pre-existing issue reported by sashiko-gemini:
>
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 15e7db9a3ab2e..fca840484ebf7 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> >
> > void sctp_sysctl_net_unregister(struct net *net)
> > {
> > + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > const struct ctl_table *table;
> This is a pre-existing issue, but I noticed a potential race condition
> during SCTP module initialization related to the sysctls modified here.
> During sctp_init(), sctp_defaults_ops registers the sysctls globally befo=
re
> sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
> sctp_init() {
> ...
> status =3D register_pernet_subsys(&sctp_defaults_ops);
> if (status)
> goto err_register_defaults;
> ...
> status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
> ...
> }
> If userspace accesses the sysctls in this window, proc_sctp_do_auth() cou=
ld
> dereference a NULL pointer since it assumes ctl_sock is ready:
> proc_sctp_do_auth() {
> ...
> struct sock *sk =3D net->sctp.ctl_sock;
> net->sctp.auth_enable =3D new_value;
> /* Update the value in the control socket */
> lock_sock(sk);
> ...
> }
> Can we hit a kernel panic here if the sysctl is modified during automatic
> module loading?
> [...]
>

Also, if you don't mind, please try to address another issue reported
in sashiko-gemini:

> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 587b0017a67d5..ae381d304bd53 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct ne=
t *net)
>
> static void __net_exit sctp_ctrlsock_exit(struct net *net)
> {
This isn't a bug introduced by this patch, but while reviewing the netns
teardown sequence, I noticed the SCTP UDP tunnel sockets appear to leak.
In sctp_defaults_exit():
sctp_defaults_exit() {
/* Free the local address list */
sctp_free_addr_wq(net);
sctp_free_local_addr_list(net);
...
}
Should sctp_defaults_exit() call sctp_udp_sock_stop(net) to ensure the
UDP tunnel sockets are closed?
If a user creates a network namespace, writes to the net.sctp.udp_port sysc=
tl
to allocate the sockets, and then destroys the namespace, could these socke=
ts
remain active and cause a use-after-free of struct net when packets arrive?
[...]

maybe by adding sctp_udp_sock_stop() in sctp_ctrlsock_exit(), and call it A=
FTER
sctp_sysctl_net_unregister() in a separate patch.

Thanks.

