Return-Path: <netdev+bounces-253721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZzPPDO5jeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:06:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FE90959
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C3DC3004DA2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3F223DFB;
	Tue, 27 Jan 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VxwrPrk3"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47113153BE9
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497575; cv=none; b=n31gpbYPRW7VIrZSb5LauX+aE8bfyIEkj7Mk2G0A+cm80o5l/iLc0k0MtL7VzokmRZMzx2VrFClznJ2kJYSNfgyG4v8qNFnZV6Zw5c10zkMZkwFqKolle32e98c14hjcxn+bSx2WWGYf8lcV9mRnjwMl64EW0r06XrFUI33MLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497575; c=relaxed/simple;
	bh=Mh+fukemG12IV6djAX0xSDnQDO+rWTNO+xAgEnSZzJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=A0MEyqodeMRFp+rwEtPWPEYuUdnQ9Utm57PwAJwSQtBk1Rz+PihkucB52zgumF2nnDIquiN1XLmjlh4vn6a2Za9uOv9AuihB67C8EcrQXyw8Tr86NBl/abQoE2KmmrI06wH0A3YxFK1JaMIdwUfY/iQ1JoWW67VkXTu/7uCxjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VxwrPrk3; arc=none smtp.client-ip=66.163.184.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497566; bh=GOun6ZKdVhaWJG7kCJ41kOP24SQGULqkd1XCTvNryBI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=VxwrPrk3Yqsn7StXn2FIL4HJxtkgW/xK9lb/cKPpouVgtL/oKak5H7QozWNQQJgbimp/8Q1xJ0exu5AMBBz8UDGVQ15xKtnLgMTTTiZ9yIzBpUh2kiSK01F/DhOWIzHIgxTxF/01HFOn0p0lWgWqDux9UPd3xk4Pc9rPdMANUWZgAODIAD77Mh6GkcuuD5NaDnUrMpHpUq1GepjLrBQCD2/NA7IEYn/sMScC9vMWSpfFghmFpw6vl6LXtxUZU1HUSl8dSVsYCbWJsQNBy1epLwwrrfEIxPTmjLnWqfmtYrdS+HwK13FzsAcONnkPv6rKpBq3J4o4v81AxY7TUDZJGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497566; bh=6RPFHUfaQKWm3z8Y5pA/9sqxhYaOJ+MY5aU0eklD7e+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Wx24LFJ8KA18VwqtYifNoMYclEhQDUpWxFGzkfXY9tEAYsyvqJMIi9MxOmHSZjIJhyKk+V2mjUGJYl2kGCUZyRxBvQnWRmcDRuq54NxSUB41uuArgH6qSaAc6p4QlQloMtpaT1KWISFZVQPcYfUf2en0QGK8R3dwu+edBWqeJypCXyMziT9G901L/I6wxhGnGVTcQKDCaGXaNqG2bt6qyuO1c1lPry7A5Cjl8D/RTXRcz3RUeeQDhuwgKosDkxQZepJkx8Fzs3qgtSZC9gfg+4rod9T0SSjWlR9MJi6zDGgJ0B2jd3zwIruoegYerRGisXjrjWGj4mzXhkGf5rDE9w==
X-YMail-OSG: xr8vqIgVM1nfwsHhaKLKrw3uT2baor9K8iJkRjgC3RoJxyNP5asyJ31O6JLCIB7
 LarsclzTiNIQ4GeHWwqSFG47Y_OGa6sIee_rYQsCITwLrk9XSYctREjvYzb2gV4.6UJfLAd_WCWP
 IN6CG71qCA8yNubGNrY.d8kdJZfPyri0f2Waob.8rYA9nEAEYAAv44wRJ_omX7Y6AS3_vBsRgqNK
 dts7gLzUj1IWV9LNcxEx252CyEj5iCCWV7asoJFp.7B60JS7TmI8Cy4Jnrx.rW4IaMkU6KZJ.c_f
 hYKa9k9PdTzQOb5hzot8ghzkftnyV2IQLchzT5GTxQomjFSxyU7DzkFDfEddZRl3.9KHdqdCXDeg
 MkcQmvoMzVM6RDj_dnsWUMBzGC9jlfgwPKBcETKnaJ1hFQg3RPYEqk6_5EDChCyxPZowfLlABxRP
 uLpWeHhC8P3moPY9d8C7nx7hTHBBAbjMH9lIiiT9wQVWWzfaJTNLnjmfQrZxtpccZzmfhH4JWpxT
 Or1Ob37AZAIrSlF9xOlreiu4NjtCqlt54Idx2HNOmNpE7tphZoc8qUG.5Ec.KOhMSsVEKNsUjP55
 hrUbj5cWnIgTO3WC7kyhh5dINHLDp5j1frD0zkExwD2FP8AizRRX5x6NeccfHys9BEXUUnHLMzL0
 JOBngFu_0ugbiveaIxlt5b4YKwvCnxg896o5c4ALfsf9m9gJnWYkPAvH33A1u.Wbfh7Qj7sKYFuo
 4NxqgBk4OKwfYnFE4HiiHYxpwu.CsGIBOUsEsrVyy17yt4FI5kMA_67wfoOjIKIkWLp4WXpuLuVC
 EzoTo6fLYbZC6I2ozSnqBeuU1uKnV_3mF4GPQ81ZYj2gKKGe.intBcOwO23exXf3DNzf2nzi2n_H
 gRP1B_MQAxKUEIgSoKeraVs5vNphfWjgpmvJF4_R68g6aeEn2LIq2ByFl2cPRE0M7vV92pQ5o9ey
 311e3JOrFcK.CtEpOyxQjMYTh88vKwkqHGkjPYVxSnVXK2qp.9iPKsX4zvCbsmTKxEojOty1en3z
 6B8j1O85HKAS0Jl38KBE09ksTuRpDtYLaBkicaruxHK5HKMfUAk1Vx7mrOry5HhZi6kXce12G1y_
 2fau0a52LDGiv0rV0PmXIH.gt41x1SBEMooQ1xAbiUvikTYa6.B7TUkYzc.o6qrVqEtEZIw6lGs1
 mcstWmWUXlBn7gkNdOlmoXh_B90RWJR1KbvC0Ntb34tkF7tf2v46qFmVMKoToVCP0WuPHo5qXVov
 mBR.lk_UhasxJkzqL4Xjx5k04yDYsU5ZjhF8MKtV9RBlnlMN66FrlY49mK70KS3j8BftZ3Lc4S6m
 ners5CltA21lkw6_lxVSUdLFnZKmoA1WLX61nC.0.2N8gv.oybHZhxcvFKUsHQUBl1Q4wYKSdP2s
 J2d9AgtnL0tv7csVLFsInXwMuf1RAcCny0R01uNGik5FLuBKYfoOoRExKSd5Rykqb.4ZEDCNaSIA
 qMI1JuWEgVVP0dUNzkO6cIDs0qMTBptCP8huJ2S0nag6MWQK8ryWlsZ4.UDmWXocczN1bmHY0DRA
 EJdNjGzLtvl8tOqnmvJk7WE_7h7PKgg0ga5yKcZFJ686MQT6vz6nLppUgOWLxEYEtTH9N25Jz30.
 eRMzyKUme8fY5HvZE0UaTgu.zEp7X0N2wGnNtKtFPh0JxoSaEbH4vGKWPsKZNSUUfg0CH58WTM44
 AZYgY87EIYYF0Ar3mrAgTHuPOwBQH84F5g3xfx8ykymXsNBP8qrg_8d.GHNF4UNowygg1ClMVdkG
 XCt7BBx7eFMSfqQDFsRbhICUQ_r3VI13dx4PrI5R9eKy02_noodGINWB6GHRDIKn722xUpbCtFVd
 o1bduLRljeMAuKmFzuNrThtvzD1YpYts7hUqw.xZXzeAWpSKITFA8YsrMKbFN7524U7g_sxs4JLD
 UqzXV14_2fa9r_OZEgZ2.QI7_.AlZ2AXQnGBULTYB4Hwpahm.u2dh8O01sWJUUYmJJ0vyEDBV.IF
 Zd1qc7rIEIQonYJkyMf2FNnbG022AWreuHeIsbIvI55cNndsblj0t6waOoZIs2UJ0M.zfS_AHP0A
 DFx0VFXHJWt1AkIe5At4C9IY1913T3A8ZmlrMhfz8sOicgBtgZShvzmDT9Jmq9eV75PjUap_Wj1P
 f.zeMZpNEl7238HdWYpfe5uKmqmBPx21AKyW.
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 6f6ba4c2-8ad3-4b68-a6eb-e8a5d463e963
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:06:06 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:06:00 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 00/11] net: tunnel: introduce noref xmit flows for tunnels
Date: Tue, 27 Jan 2026 08:04:41 +0100
Message-ID: <20260127070452.6581-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260127070452.6581-1-mmietus97.ref@yahoo.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D0FE90959
X-Rspamd-Action: no action

Currently, tunnel xmit flows always take a reference on the dst_entry
for each xmitted packet. These atomic operations are redundant in some
flows.

This patchset introduces the infrastructure required for converting
the tunnel xmit flows to noref, and converts them where possible.

These changes improve tunnel performance, since less atomic operations
are used.

There are already noref optimizations in both ipv4 and ip6.
(See __ip_queue_xmit, inet6_csk_xmit)
This patchset implements similar optimizations in ip and udp tunnels.

Benchmarks:
I used a vxlan tunnel over a pair of veth peers and measured the average
throughput over multiple samples.

I ran 100 samples on a clean build, and another 100 on a patched
build. Each sample ran for 120 seconds. These were my results:

clean:      71.95 mb/sec, stddev = 1.71
patched:    74.92 mb/sec, stddev = 1.35

TL;DR - This patchset results in a 4% improvement in throughput for
vxlan. It's safe to assume that we might see similar results when testing
other tunnels.

Changes in v7:
 - Added missing calls to rcu_read_lock/unlock in gtp_genl_send_echo_req
 - Updated bareudp_xmit_skb to only call dst_release if dst isn't noref
 - Updated patches to work independently (added missing rcu_read_lock/unlock to early commits)

Link to v6: https://lore.kernel.org/netdev/20260120162451.23512-1-mmietus97@yahoo.com/

Marek Mietus (11):
  net: dst_cache: add noref versions for dst_cache
  net: tunnel: convert iptunnel_xmit to noref
  net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
  net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
  net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
  wireguard: socket: convert send{4,6} to use a noref dst when possible
  net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when
    possible
  net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
  net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
  net: sit: convert ipip6_tunnel_xmit to use a noref dst
  net: tipc: convert tipc_udp_xmit to use a noref dst

 drivers/net/amt.c              |   3 +
 drivers/net/bareudp.c          |  31 ++++++--
 drivers/net/geneve.c           |  59 ++++++++++-----
 drivers/net/gtp.c              |   7 ++
 drivers/net/ovpn/udp.c         |   8 +-
 drivers/net/vxlan/vxlan_core.c |  39 +++++++---
 drivers/net/wireguard/socket.c |  12 ++-
 include/net/dst_cache.h        |  71 ++++++++++++++++++
 include/net/udp_tunnel.h       |   6 +-
 net/core/dst_cache.c           | 133 ++++++++++++++++++++++++++++++---
 net/ipv4/ip_tunnel.c           |  47 +++++++-----
 net/ipv4/ip_tunnel_core.c      |   2 +-
 net/ipv4/udp_tunnel_core.c     |  16 ++--
 net/ipv6/ip6_udp_tunnel.c      |  19 +++--
 net/ipv6/sit.c                 |  14 +---
 net/sctp/ipv6.c                |   6 +-
 net/sctp/protocol.c            |   7 +-
 net/tipc/udp_media.c           |   6 +-
 18 files changed, 381 insertions(+), 105 deletions(-)

-- 
2.51.0


