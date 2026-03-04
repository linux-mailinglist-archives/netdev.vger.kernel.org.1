Return-Path: <netdev+bounces-263578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK4vAdqsp2lejAAAu9opvQ
	(envelope-from <netdev+bounces-263578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:54:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA11FA86E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BEBB302DE15
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1D352F87;
	Wed,  4 Mar 2026 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmNS1xoN"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17AC2FF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596438; cv=none; b=Lg5b61f+gUElHywkBBtnvPww/AgY+3tNGfaBtuOiQe4dFLRCpbN1eb+leazWq+q4wBOfNm6j7eAJK5q9TfzR7tjxxyFLHv7om9iN1d0j+FgLO//DsmiMwtY3NzKF/h0uYkhqml7caczrlJl2sugzDQzdFAM2+lGYXwolQ1dO2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596438; c=relaxed/simple;
	bh=P4MHX6mpUzY8WQevzR0Ylrrr6O9fRnzA72+3dvoBbDY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Tx7MCKzxaoHOSu1q7AUIR1U6yuJfatSlv60g7/MDNgssbA9PMeHj++xJWiyFA/u3mFJe+ibH//6HwFxsuRsfpsX3MbVtAZPcVmuIPDIogc08hJHwk6CZrgjo/ybknMbOH07lW1ldA2wWZnMj2VlKAHI4b3/fOi/8OciCD7VanEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmNS1xoN; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772596435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp1olb3UVSz5zVa/Xb05qoa5tdM92+6sUk8+b4EpQUM=;
	b=AmNS1xoNg61o5cT5FIuYpdT4VfeqTdKe+JSLs4NfbIZn46bP7r8bVqyRzTKq5AqkOKm/G/
	/rYFSZcwAhEnYu9bwjqZCJYMHjfVeADOecbFzzQKnBD8e7ySn1dwwkqiSy02g8g4us4tq3
	udzStAyVJexb+ZmF2PUaEwbwwQhqaIk=
Date: Wed, 04 Mar 2026 03:53:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <0983a82f8946d972d2bf6e3a316f8556f68e3d54@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] net: annotate data races around sk->sk_prot
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: netdev@vger.kernel.org, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "David Ahern"
 <dsahern@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CAAVpQUBn7zmPvJB+P0pyD8BAaWdc+g3warvPjahYd_Qb7x54UQ@mail.gmail.com>
References: <20260304031626.356955-1-jiayuan.chen@linux.dev>
 <CAAVpQUBn7zmPvJB+P0pyD8BAaWdc+g3warvPjahYd_Qb7x54UQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2EEA11FA86E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

March 4, 2026 at 11:42, "Kuniyuki Iwashima" <kuniyu@google.com mailto:kun=
iyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E=
 > wrote:


>=20
>=20On Tue, Mar 3, 2026 at 7:16 PM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
>=20>=20
>=20> inet_sendmsg(), inet_recvmsg() and sock_common_recvmsg() access
> >  sk->sk_prot without lock_sock() or any other synchronization.
> >=20
>=20>  sock_replace_proto() (used by sockmap), TLS and MPTCP can change
> >  sk->sk_prot under us, so these functions need READ_ONCE() to avoid
> >  load tearing.
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  net/core/sock.c | 2 +-
> >  net/ipv4/af_inet.c | 8 ++++++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >=20
>=20>  diff --git a/net/core/sock.c b/net/core/sock.c
> >  index f4e2ff23d60e..79b659cebbb1 100644
> >  --- a/net/core/sock.c
> >  +++ b/net/core/sock.c
> >  @@ -3968,7 +3968,7 @@ int sock_common_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t size,
> >  {
> >  struct sock *sk =3D sock->sk;
> >=20
>=20>  - return sk->sk_prot->recvmsg(sk, msg, size, flags);
> >  + return READ_ONCE(sk->sk_prot)->recvmsg(sk, msg, size, flags);
> >  }
> >  EXPORT_SYMBOL(sock_common_recvmsg);
> >=20
>=20None of users seems to be supported by SOCKMAP,
> or am I missing something ?
>=20
>=20include/net/sock.h:1963:int sock_common_recvmsg(struct socket *sock,
> struct msghdr *msg, size_t size,
> net/core/sock.c:3966:int sock_common_recvmsg(struct socket *sock,
> struct msghdr *msg, size_t size,
> net/core/sock.c:3973:EXPORT_SYMBOL(sock_common_recvmsg);
> net/l2tp/l2tp_ip6.c:774: .recvmsg =3D sock_common_recvmsg,
> net/l2tp/l2tp_ip.c:645: .recvmsg =3D sock_common_recvmsg,
> net/ipv6/raw.c:1292: .recvmsg =3D sock_common_recvmsg, /* ok */
> net/ieee802154/socket.c:427: .recvmsg =3D sock_common_recvmsg,
> net/ieee802154/socket.c:989: .recvmsg =3D sock_common_recvmsg,
> net/phonet/socket.c:441: .recvmsg =3D sock_common_recvmsg,
> net/phonet/socket.c:461: .recvmsg =3D sock_common_recvmsg,


You're right. None of the sock_common_recvmsg() users (raw, l2tp,
ieee802154, phonet) support SOCKMAP/TLS/MPTCP, so there is no
concurrent writer to sk->sk_prot for these socket types. I'll drop
that change in v2.

> >=20
>=20> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >  index babcd75a08e2..e95ffa070568 100644
> >  --- a/net/ipv4/af_inet.c
> >  +++ b/net/ipv4/af_inet.c
> >  @@ -852,11 +852,13 @@ EXPORT_SYMBOL_GPL(inet_send_prepare);
> >  int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t siz=
e)
> >  {
> >  struct sock *sk =3D sock->sk;
> >  + const struct proto *prot;
> >=20
>=20>  if (unlikely(inet_send_prepare(sk)))
> >  return -EAGAIN;
> >=20
>=20>  - return INDIRECT_CALL_2(sk->sk_prot->sendmsg, tcp_sendmsg, udp_se=
ndmsg,
> >  + prot =3D READ_ONCE(sk->sk_prot);
> >  + return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udp_sendmsg,
> >  sk, msg, size);
> >  }
> >  EXPORT_SYMBOL(inet_sendmsg);
> >  @@ -882,11 +884,13 @@ int inet_recvmsg(struct socket *sock, struct m=
sghdr *msg, size_t size,
> >  int flags)
> >  {
> >  struct sock *sk =3D sock->sk;
> >  + const struct proto *prot;
> >=20
>=20>  if (likely(!(flags & MSG_ERRQUEUE)))
> >  sock_rps_record_flow(sk);
> >=20
>=20>  - return INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udp_re=
cvmsg,
> >  + prot =3D READ_ONCE(sk->sk_prot);
> >  + return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udp_recvmsg,
> >  sk, msg, size, flags);
> >  }
> >  EXPORT_SYMBOL(inet_recvmsg);
> >  --
> >  2.43.0
> >
>

