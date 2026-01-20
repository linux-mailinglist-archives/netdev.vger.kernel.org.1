Return-Path: <netdev+bounces-251549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE1MBwW9b2lHMQAAu9opvQ
	(envelope-from <netdev+bounces-251549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:36:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F948A89
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C38BF840BC9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60042315D39;
	Tue, 20 Jan 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7qh+lF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D830148D
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926584; cv=none; b=j3dV+r/e/WoqKD72aMV7/p5Rd6Ja+3ArkQiAh19J+RN92l09S7vucmqdbY8f3JjeoM+4MXQp32hfiuC+zCnc+3WIAkecsCoW7oZCiMcxNXgfQtuWOvEeOFG0gUuoRfzwD+vpQ4AjI1Cp2ZjhGBWeBHC8f4qHN89sclNKYstysbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926584; c=relaxed/simple;
	bh=apk87Dee/Cxfz6Ep8pQTt6khD8mITgr3FiU+0g3v4o4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEK9oWcpxaceOtg0jkjUyEmzZdfqFUMYKGBcSgrngpn+5ekTG9FsZkL0G8MYJQhNmRxgYDN8U5z0rB3xli/YGvoy9OOcTsiriBiABeNXZrZx61YBnpOy6espnAfscETxF5O90hxbMysUU5SyxZ1VmSH5VXjIoY8evpVT7WwgNs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7qh+lF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E48C16AAE;
	Tue, 20 Jan 2026 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926583;
	bh=apk87Dee/Cxfz6Ep8pQTt6khD8mITgr3FiU+0g3v4o4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7qh+lF38sdUDVdih9bMjbNeWq1K6zyHt8yxyczmtQLvv4USnX5lkdoPywBgkEs+0
	 Z+RB6phvFqRyhQdJMlfvIsPnqKZuEUqr3jVnajZW+781BW6Kae8m91DzrpxD3k3rum
	 Zez8VtvxIPAP2KMuXtum/DboegGHHX3uBLN2t1uzazQWHyaWfkoimIEHrkkSARr9iL
	 Vxjmxx+/clXbjzH2lh6yosi9X+EjpaNWKcfUnT65Bwo5y/o1lGOBSMj9ht3q5RlgeJ
	 jPo5s+ufEyvMug0Btq7CAdYRKYbHaRJGMY/jvSFcfFoeuKWod5N6AHXucO5Dxu0tQp
	 Fmj7g9O1j8jpQ==
Date: Tue, 20 Jan 2026 08:29:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
Message-ID: <20260120082942.3c62738b@kernel.org>
In-Reply-To: <CANn89iJUh-3xDWkXhNatmBj2tWd1dLHXLbE6YT9EA2Lmb_yCLQ@mail.gmail.com>
References: <20260118175215.2871535-1-edumazet@google.com>
	<20260120073057.5ef3a5e1@kernel.org>
	<CANn89iL-w7ES=OsNQhLTZjxVdfOJxU2s7wRXJF6HkKSAZM2FBg@mail.gmail.com>
	<CANn89iJUh-3xDWkXhNatmBj2tWd1dLHXLbE6YT9EA2Lmb_yCLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-251549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: B00F948A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 16:44:52 +0100 Eric Dumazet wrote:
> On Tue, Jan 20, 2026 at 4:41=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> > > Still not good?
> > >
> > > net/ipv6/udp_offload.c:136:17: error: static declaration of =E2=80=98=
udp6_gro_receive=E2=80=99 follows non-static declaration
> > >   136 | struct sk_buff *udp6_gro_receive(struct list_head *head, stru=
ct sk_buff *skb)
> > >       |                 ^~~~~~~~~~~~~~~~
> > > In file included from net/ipv6/udp_offload.c:16:
> > > ./include/net/gro.h:408:17: note: previous declaration of =E2=80=98ud=
p6_gro_receive=E2=80=99 with type =E2=80=98struct sk_buff *(struct list_hea=
d *, struct sk_buff *)=E2=80=99
> > >   408 | struct sk_buff *udp6_gro_receive(struct list_head *, struct s=
k_buff *);
> > >       |                 ^~~~~~~~~~~~~~~~
> > > net/ipv6/udp_offload.c:168:29: error: static declaration of =E2=80=98=
udp6_gro_complete=E2=80=99 follows non-static declaration
> > >   168 | INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff =
*skb, int nhoff)
> > >       |                             ^~~~~~~~~~~~~~~~~
> > > ./include/net/gro.h:409:5: note: previous declaration of =E2=80=98udp=
6_gro_complete=E2=80=99 with type =E2=80=98int(struct sk_buff *, int)=E2=80=
=99
> > >   409 | int udp6_gro_complete(struct sk_buff *, int);
> > >       |     ^~~~~~~~~~~~~~~~~ =20
> >
> > Oh well, I thought I tested this stuff. =20
>=20
> Interesting... clang (our default compiler for kernel) does not complain =
at all.

Well, at least I _think_ it's this series, haven't tested.
It breaks in the kselftests, no allmodconfig, here's the full config:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill-dbg/results/4820=
21/config

Also possible that it's a silent conflict with another pending series.

