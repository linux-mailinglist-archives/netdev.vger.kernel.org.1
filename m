Return-Path: <netdev+bounces-251525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENmJAIG0b2nHMAAAu9opvQ
	(envelope-from <netdev+bounces-251525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:59:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D94831D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA99E63D7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B5314B76;
	Tue, 20 Jan 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4urcpMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C3314B64
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923059; cv=none; b=YJN+kecu1osu4M2gpUTzG/38urEmnPSngqGEgFXeCpUODZom87VLY0fRpXTyHexFI6O1qi4EOdrmS4aAw/PS0UTnQ8On4i5gO+W1H3+Gw4qCN+pL3nl9A7WtVEJYSjf+0gUrar6E8ZG8GSqIOnc/JZDDR2GuH1KypTNQsW5Y/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923059; c=relaxed/simple;
	bh=eqsZ9rR7BAnPlyZg7QbRGJtts72j3wIprxCN3FKSxT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C98Yjo2AUW2bIDnaXekwIWd+NTv8EcRE8lmtRT7pmmr9FpNVeWyAemCG3yeMo6Z1N0HoKvG5o+oeTrvuoIbIvvfRjIrzuDYETihpw05kuGZg/OxljlL1fYL4nE+WjVTyouvK1q1GeZJtHotvuOSMuXGMsJXD3mt7xqUCGAmfxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4urcpMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F5C16AAE;
	Tue, 20 Jan 2026 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923058;
	bh=eqsZ9rR7BAnPlyZg7QbRGJtts72j3wIprxCN3FKSxT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4urcpMX701tF/pRWJ2o6lQoDQluJReCUWOdok1MxEYQxjsTAeTrrVEspCSsVy1/u
	 eR7Klh1R53dHZ2wFIDpGUdIGs5aDC4a3UrX0wKKwAK/XK6VPSlvXMxio0xYVYQ7M+C
	 RNu1AJZF+2FoapdzSKYCBTwedj+8EeajVLEQzN84I/u5P1lpNXux+0whKBtyadOpmH
	 u8ac/cQtwyK1/VJm+ZzuzhL0zLTJ2MT2PJa+MwMqoE6FReZoy1rIIaOtshS9U4z7X2
	 nCZzUz6IeGu2BdCh8d0i/fqD1sG4V5gp52W6Rv/vlYqDdSddDB13L/u+FWSvmJsOkS
	 R8AQCYbT89qvQ==
Date: Tue, 20 Jan 2026 07:30:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
Message-ID: <20260120073057.5ef3a5e1@kernel.org>
In-Reply-To: <20260118175215.2871535-1-edumazet@google.com>
References: <20260118175215.2871535-1-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-251525-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 794D94831D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 17:52:12 +0000 Eric Dumazet wrote:
> On some platforms, GRO stack is too deep and causes cpu stalls.
>=20
> Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
> (32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10,0=
00 flows)
>=20
> We can go further by inlining ipv6_gro_{receive,complete}
> and take care of IPv4 if there is interest.
>=20
> Note: two temporary __always_inline will be replaced with
>       inline_for_performance when available.
>=20
> v2: dealt with udp6_gro_receive()/udp6_gro_complete()
>     missing declarations (kernel test robot <lkp@intel.com>)
>     for CONFIG_MITIGATION_RETPOLINE=3Dn

Still not good?

net/ipv6/udp_offload.c:136:17: error: static declaration of =E2=80=98udp6_g=
ro_receive=E2=80=99 follows non-static declaration
  136 | struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_=
buff *skb)
      |                 ^~~~~~~~~~~~~~~~
In file included from net/ipv6/udp_offload.c:16:
./include/net/gro.h:408:17: note: previous declaration of =E2=80=98udp6_gro=
_receive=E2=80=99 with type =E2=80=98struct sk_buff *(struct list_head *, s=
truct sk_buff *)=E2=80=99
  408 | struct sk_buff *udp6_gro_receive(struct list_head *, struct sk_buff=
 *);
      |                 ^~~~~~~~~~~~~~~~
net/ipv6/udp_offload.c:168:29: error: static declaration of =E2=80=98udp6_g=
ro_complete=E2=80=99 follows non-static declaration
  168 | INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, =
int nhoff)
      |                             ^~~~~~~~~~~~~~~~~
./include/net/gro.h:409:5: note: previous declaration of =E2=80=98udp6_gro_=
complete=E2=80=99 with type =E2=80=98int(struct sk_buff *, int)=E2=80=99
  409 | int udp6_gro_complete(struct sk_buff *, int);
      |     ^~~~~~~~~~~~~~~~~
--=20
pw-bot: cr

