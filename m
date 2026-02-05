Return-Path: <netdev+bounces-257144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHEUOWKFhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:56:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548EF21B7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58DE30036EE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B9D3AEF29;
	Thu,  5 Feb 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8TAesqi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37F38B7BF;
	Thu,  5 Feb 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292553; cv=none; b=fijMnllBwilKXBHfVJo9+9hLOaNDIAYMWuiMwiqO+gY0UoLD8T0GPb7HOH1jxkwkq0fuz7sxfYu88ZYmZydENBufTFh7OMMPkVqrCsWFQrl3EvEu+iTGXIs9JLMS0IAjwX9fYrT2bmPiUHjNWw4IZIHiCvpv6YUJ3V2C0mct0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292553; c=relaxed/simple;
	bh=/WDmwFhXb2jXaRmYe0iGQmf5ISXkCS9JwDb/iMvVvv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HighDj7Ai9Yn02e23o5p9EBeUNHP97xCB+M2b6+DOBcsVEKilKlhUcCKxgOfC2xY52ajqUA7LtlB4IPS6m0XprwOo+OvO3/uGaMsmrh04/6Zd1gLWsEdboHwjH1f8ZyFJeRBFj9gwgphgpiq/Ma9yYXHtDcG71L1WqXAwCgfGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8TAesqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8233AC4CEF7;
	Thu,  5 Feb 2026 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770292553;
	bh=/WDmwFhXb2jXaRmYe0iGQmf5ISXkCS9JwDb/iMvVvv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8TAesqiDYdX817ZT9CgpJmx1Zww+daXstoDCcBCVaJn6CsuOJ6MuOMM2APivYzbx
	 YHoyGuPHoE4TPUOFyQh0Yf/fotn2lOii+KNV6idJqKbx4k7cd3Xmym1UqEq3m2XsHr
	 JlcemS17SUdjyVS8VRqOgFdQ1tOv3j1VzgjVzLxldzgyMViADvziMbrQ810U4ZgxL3
	 6DouWY6KgK3bEQ7lQQZf5K7yIeh0B1R/lqKhnBrZKjZ5rfAFB4SeWsFFNZ8YvZxoab
	 2VHH6fthufoejKLqbGOj0xGEJQrynB1qCWN5nnnOqt0zwSlaFtqjfGvsGvKU4t/aGG
	 WvAbXDr+8dekg==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	steved@redhat.com,
	marcelo.leitner@gmail.com,
	aahringo@redhat.com,
	alibuda@linux.alibaba.com,
	jbaron@akamai.com,
	hare@suse.de,
	kuba@kernel.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	daniel@haxx.se,
	quic@lists.linux.dev,
	jlayton@kernel.org,
	tfanelli@redhat.com,
	dhowells@redhat.com,
	linkinjeon@kernel.org,
	hepengtao@xiaomi.com,
	pc@manguebit.com,
	kernel-tls-handshake@lists.linux.dev,
	illiliti@protonmail.com,
	xiyou.wangcong@gmail.com,
	andrew.gospodarek@broadcom.com,
	mail@johnericson.me,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	smfrench@gmail.com,
	metze@samba.org,
	mbuhl@openbsd.org,
	chuck.lever@oracle.com,
	dreibh@simula.no,
	davem@davemloft.net,
	sd@queasysnail.net
Subject: Re: [net-next,v9,15/15] quic: add packet parser base
Date: Thu,  5 Feb 2026 11:55:42 +0000
Message-ID: <20260205115542.2195362-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <431335747d3604c46f2e57a32d839a73aa8a8536.1770042461.git.lucien.xin@gmail.com>
References: <431335747d3604c46f2e57a32d839a73aa8a8536.1770042461.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8548EF21B7
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
quic: add packet parser base

This patch uses 'quic_packet' to handle packing of QUIC packets on the
receive (RX) path. It introduces mechanisms to parse the ALPN from client
Initial packets to determine the correct listener socket, routes received
packets accordingly, and adds support for ICMP-based MTU updates by
locating the relevant socket and updating the stored PMTU.

> diff --git a/net/quic/packet.c b/net/quic/packet.c
> index cf64a6aaa795..16a7db6ccd87 100644
> --- a/net/quic/packet.c
> +++ b/net/quic/packet.c

[ ... ]

> @@ -14,6 +14,637 @@
>
>  #define QUIC_HLEN		1
>
> +/* Handle ICMP Toobig packet and update QUIC socket path MTU. */
> +static int quic_packet_rcv_err(struct sock *sk, struct sk_buff *skb)
> +{
> +	union quic_addr daddr, saddr;
> +	u32 info;
> +
> +	/* All we can do is lookup the matching QUIC socket by addresses. */
> +	quic_get_msg_addrs(skb, &saddr, &daddr);
> +	sk = quic_sock_lookup(skb, &daddr, &saddr, sk, NULL);

Are the address arguments swapped in quic_packet_rcv_err()? Looking at
other call sites in this file, quic_get_msg_addrs is consistently called
with &daddr first, then &saddr:

  Line 476 in quic_packet_get_listen_sock():
    quic_get_msg_addrs(skb, &daddr, &saddr);

  Line 513 in quic_packet_get_sock():
    quic_get_msg_addrs(skb, &daddr, &saddr);

  Line 536 in quic_packet_get_sock():
    quic_get_msg_addrs(skb, &daddr, &saddr);

But here quic_packet_rcv_err() passes &saddr first, then &daddr.

Looking at the implementation of quic_v4_get_msg_addrs() in
net/quic/family.c, the function extracts addresses from the packet as:

  sa->v4.sin_port = uh->source;
  sa->v4.sin_addr.s_addr = ip_hdr(skb)->saddr;
  da->v4.sin_port = uh->dest;
  da->v4.sin_addr.s_addr = ip_hdr(skb)->daddr;

So sa gets the packet's source address (remote), and da gets the packet's
destination address (local).

Then quic_sock_lookup() in net/quic/socket.c expects:

  if (quic_cmp_sk_addr(tmp, quic_path_saddr(paths, 0), sa) &&
      quic_cmp_sk_addr(tmp, quic_path_daddr(paths, 0), da) &&

This compares the socket's local address with sa and the socket's remote
address with da, meaning sa should be the local (packet dest) address and
da should be the remote (packet source) address.

With the swapped arguments, quic_packet_rcv_err() would pass the remote
address where the local is expected and vice versa, causing the socket
lookup to fail. This would prevent ICMP Packet Too Big messages from being
processed correctly, breaking Path MTU Discovery.

> +	if (!sk)
> +		return -ENOENT;
> +
> +	if (quic_get_mtu_info(skb, &info)) {
> +		sock_put(sk);
> +		return 0;
> +	}
> +
> +	/* Success: update socket path MTU info. */
> +	bh_lock_sock(sk);
> +	quic_paths(sk)->mtu_info = info;

[ ... ]

