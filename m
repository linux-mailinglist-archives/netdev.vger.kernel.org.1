Return-Path: <netdev+bounces-257295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GkaLrHphGkj6gMAu9opvQ
	(envelope-from <netdev+bounces-257295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:04:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF9F6AE9
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F8E63022912
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCE30DEAA;
	Thu,  5 Feb 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMDa/Xk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE430DD3B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318245; cv=pass; b=FOLli/sOODWIXqbrgH2bE3b0d/QSEInhMGCU3xAf0MThRObaQVhOH3OXaIC2hVbbgYzrBWpNnodW3tN+yueYJfTmzCWwM795tsTYqD447Vhvrpl819o8wIUDQllzOI4UM1/n/fX6pps7vuFsmffIlCtvlLawwfnklANFck2L31Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318245; c=relaxed/simple;
	bh=mMoJ2tLJEBg9sKf8yUPINOdmAZsdGLwl34VanWm6tos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql4G2PVXK5rBV4Hp9z4nW8bvP+OxJ+n3Go1AQ8rnORLIw9PWozLXfo7zDzkqbiuA5Uh+UHuboZ36gj6JGotmobHgOqw73AV+qCcl2Wpm6QMEpniVFdwh2o3/qd4ny4qnkCVi40xfO5B9BoFffx9xb2boMW6YOmZXiYUX4RhS6/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMDa/Xk3; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c551edc745eso580740a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770318244; cv=none;
        d=google.com; s=arc-20240605;
        b=QcEGZeM+gfLqy/2ii1Y0rer2o38ASmqh/DQxbR5eJ/KXwI7vWIsEpXzA5GpB6ZdkkJ
         Ifu+71BN51woxM9oZMaBN9SWlE2yRRy4mxm5wxpGVZs8uvL0JjaN96XpoWQgCAMfdVaj
         9xAXk6sdwHite5hlx6J8Z/ubTqrNhi7EnNdocyWn8cYFrt32BZpXvvv8aLSM2u4FKTEQ
         LBk4V44vimMAVL8yqPHp2fEw8FHWA0EZM57vD/pi6OT4vtBXL9AKqNdHikGMx7/NmCt5
         LmjlrIyW/9goOgjBJeQuBrbrBR+EuRpOIDpivmHDtiTuEhA6IpmvO8PHktZwWc3r6Kab
         9aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTcUAmNhDbXfJ1YkCH2MncVbNEMdAOiqZyjVuJUmYMI=;
        fh=/Huj/+7LSpY5r59oYAho4kQHjRu4aILcaxGXoQsyj+c=;
        b=BdVhCkjyrZfFq4A2OoKl31P1aEzVKtQpo8ARLniJ+8/07Zd1zZHcuYZu09Sb+4krsi
         QuSpWcHaDNQ70u/qM+gFrx/gKHsPns5sfzh+NKJ2tsJMLM5XjUYq9AbItIGFzPKe3DET
         B3o0nIZGJNwop0MjNpdZg8GVdhOO3VgdL/rovgAev49GUDJLwStpVkt9Cue+B4K8MXKK
         /NIDJRngl1/6kAG1ClSe+XdlFeoVFhJAC7i8TViq49Ad+bYNspz5sLuYXRu7EbdnshUB
         4CR+cgmAcTOaaWlVSLVpafWuiWZkxCuEkYI+H4tNTf2zH4CcSNXOo4PD4afxXcRl3qOW
         oAMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318244; x=1770923044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTcUAmNhDbXfJ1YkCH2MncVbNEMdAOiqZyjVuJUmYMI=;
        b=QMDa/Xk30DRKgmkdkkEslf3SM1xGEWJjjS+zzBpbP8CNWmxaRpfi5A9hzJQ/WJsL88
         eyFehtYhrd/s5V9Mz347pl9uzIbelL6799QNMsUWZS5x76AizUe4PeAm2iDDtWxB2PK4
         jOGvaCVwz1C+Le3ooI97AquLmMVt7xTIo6gPRDQ4K/8jajS1uaTSHMNHGBxfdlUasrbC
         pfZQME4OJFMTTsVlx75v6w7rFosR/KSpscSicbCia3GbHw11hFisi4ED3GLpQ8VnO9mb
         2MN/ZfD5yrA4oDeGLzTtWZzGbjJ5TtXYJXPswFXVi70hre19XUR+3nN2Vx9JL6qZpWPw
         wL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318244; x=1770923044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTcUAmNhDbXfJ1YkCH2MncVbNEMdAOiqZyjVuJUmYMI=;
        b=d1dfhtbbIZJrUDFxq6M40bvZIHh9HfFwdBWlK+aoCAEEGvnVG6mnfsnSxjbdDctr5Y
         BuH/Ss5v8NUjXcR77iYf0l/uBHLwNiSA4o3MRgx4MQiddV6YoEKVNZRwo4nsIZjlfKUH
         f1gnW2OvYwPg/N4x8AU2nuYMhMYHJSzO6VwK5bbQj7d+AEJ9Uk1kJ49KzspqFm1SqEBC
         7H9K0OBObNfugalkps7moE1xz2h5rCCk/IRfwB73gjmvnNTtenMqiEbK9IMNnoN/jiSB
         Pf5K6uyQf+4qC2ymKoxYekWEMohuEz0BtU6dnRxJHoR1/X4ZpsGBDjC60/oS7rrU3vPV
         C2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMtilN3NmbOoNpRp1ROFmS/b9LPoDL7GSMGpYYJj+FWvSSie+owVYiuZqsIp6hcCOpjsF4/fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUW75/pwzUu3pWABK68I6ATr/+t4NHKOyk1JD3OkzuLdTlsUvk
	tnrE72JJHNtTONHt8sMJJ5pzRU0B4sVuNfW6mAFF1a84llfAQkDOcKUIllrUz1KtS1Runtbhs1b
	i2Tvlq04pZO4kosfoMaRQmGGmJNKPp34=
X-Gm-Gg: AZuq6aL++BMia6fKC4/p09mkwgwPioTq8QKmNFRFY5bGYS78n3bIpOimSM0030IurUZ
	VgKc4Ap0QTnLpv0S/pYzoFgBxF1lvzgY3LLtfUhQUee2gR2x6QZfj+U0nVz3NGh1ntJtEWcxKh/
	gYt1xpUEb07gFiE8yHTB4baYxLm7rTI9O5aTl3B/wUde/CPPgJk7/Vp+546a+7b6FHTClxGbm1M
	wXp3kZbHwzAui+wee/+zF038MmesacXw3Bn/VUf0kNt6OmhGmL4enrzq1zPBNYASd5UBcM4/832
	3xQ032mxpMtAJ+HhaEswR3wNyrUl
X-Received: by 2002:a17:903:32c2:b0:2a8:fc90:c8b7 with SMTP id
 d9443c01a7336-2a9516299a0mr3095915ad.19.1770318244425; Thu, 05 Feb 2026
 11:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28a1e36188b1a84193ef2d78f12ecbc0e43ae7f1.1770042461.git.lucien.xin@gmail.com>
 <20260205115423.2195277-1-horms@kernel.org> <e9b073b0-60b7-4a45-9b6d-85c15b51fb4f@redhat.com>
In-Reply-To: <e9b073b0-60b7-4a45-9b6d-85c15b51fb4f@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 14:03:52 -0500
X-Gm-Features: AZwV_Qjjs7kCqix60p3yMSgDkQ3vg6ybhk9GbXkeFBD_k4Da4kanmC-HbStnhiw
Message-ID: <CADvbK_eFXJB-JqL7w-50Jb=GNzzmSFD_cRGSmRscZ2Hq0o=6ZQ@mail.gmail.com>
Subject: Re: [net-next,v9,02/15] net: build socket infrastructure for QUIC protocol
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, steved@redhat.com, marcelo.leitner@gmail.com, 
	aahringo@redhat.com, alibuda@linux.alibaba.com, jbaron@akamai.com, 
	hare@suse.de, kuba@kernel.org, tom@talpey.com, linux-cifs@vger.kernel.org, 
	daniel@haxx.se, quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	matttbe@kernel.org, netdev@vger.kernel.org, smfrench@gmail.com, 
	metze@samba.org, mbuhl@openbsd.org, chuck.lever@oracle.com, dreibh@simula.no, 
	davem@davemloft.net, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 72AF9F6AE9
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 7:48=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/5/26 12:54 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> > ---
> > net: build socket infrastructure for QUIC protocol
> >
> > This patch lays the groundwork for QUIC socket support in the kernel.
> > It defines the core structures and protocol hooks needed to create
> > QUIC sockets, without implementing any protocol behavior at this stage.
> > Basic integration is included to allow building the module via
> > CONFIG_IP_QUIC=3Dm. This provides the scaffolding necessary for adding
> > actual QUIC socket behavior in follow-up patches.
> >
> >> diff --git a/net/quic/protocol.c b/net/quic/protocol.c
> >> new file mode 100644
> >> index 000000000000..6ab81f1c50cc
> >> --- /dev/null
> >> +++ b/net/quic/protocol.c
> >
> > [ ... ]
> >
> >> @@ -0,0 +1,369 @@
> >
> > [ ... ]
> >
> >> +static int quic_protosw_init(void)
> >> +{
> >> +    int err;
> >> +
> >> +    err =3D proto_register(&quic_prot, 1);
> >> +    if (err)
> >> +            return err;
> >> +
> >> +    err =3D proto_register(&quicv6_prot, 1);
> >> +    if (err) {
> >> +            proto_unregister(&quic_prot);
> >> +            return err;
> >> +    }
> >> +
> >> +    inet_register_protosw(&quic_stream_protosw);
> >> +    inet_register_protosw(&quic_dgram_protosw);
> >> +    inet6_register_protosw(&quicv6_stream_protosw);
> >> +    inet6_register_protosw(&quicv6_dgram_protosw);
> >> +
> >> +    return 0;
> >> +}
> >
> > Can the return values from inet6_register_protosw() be checked?
> >
> > Looking at the implementation, inet6_register_protosw() returns int and
> > can fail with -EINVAL (if p->type >=3D SOCK_MAX) or -EPERM (if trying t=
o
> > override a permanent protocol). The calls at lines 234-235 don't check
> > these return values, so if registration fails, quic_protosw_init() stil=
l
> > returns 0 (success).
> >
> > More critically, quic_protosw_exit() unconditionally calls
> > inet6_unregister_protosw() on both structures:
> >
> > static void quic_protosw_exit(void)
> > {
> >       inet_unregister_protosw(&quic_dgram_protosw);
> >       inet_unregister_protosw(&quic_stream_protosw);
> >       proto_unregister(&quic_prot);
> >
> >       inet6_unregister_protosw(&quicv6_dgram_protosw);
> >       inet6_unregister_protosw(&quicv6_stream_protosw);
> >       proto_unregister(&quicv6_prot);
> > }
> >
> > If a protosw was never successfully registered, its list field remains
> > zero-initialized (NULL pointers). inet6_unregister_protosw() calls
> > list_del_rcu(&p->list), which with NULL pointers will dereference NULL
> > in __list_del_entry() -> __list_del(NULL, NULL), causing a kernel crash=
.
> >
> > Note that inet_register_protosw() returns void (cannot fail from caller=
's
> > perspective), but inet6_register_protosw() returns int (can fail). The
> > code correctly checks errors from proto_register() but not from
> > inet6_register_protosw().
> >
> > Should the return values from inet6_register_protosw() be checked, and
> > should the cleanup path track which registrations succeeded so only tho=
se
> > are unregistered?
>
> I think it's easy to infer that that such failures are impossible, but
> since a repost is needed please drop some sentence in the commit message
> to help AI see the point.
>
Will do, thanks.

