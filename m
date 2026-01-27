Return-Path: <netdev+bounces-253730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHCPNo9meGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:17:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6990A9E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8035A3003BC8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D79261586;
	Tue, 27 Jan 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cjAXURpl"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-23.consmr.mail.ne1.yahoo.com (sonic311-23.consmr.mail.ne1.yahoo.com [66.163.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB68F149C6F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498250; cv=none; b=AS3KLjYcGv3hFRdfA90vq/BrP5nmshx+DQ/BMbMlDOEyGelpdHnOyP84oJeTyPz1U8HfvPojjaDT2EHVBnuQXUYLs5i6AqUWphmrOxwgalya8Twb9k9JWVQ1iTy+Ku4zjd1zBOAA0Vt4FRk7HEaa1FKR2rf5vAZbLPDy3wl2IT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498250; c=relaxed/simple;
	bh=npG/vWJeKo2UuH4SljRAaXDe1DctVL+EJFSWMupg27o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsBXfygZuRr6gGRt3bjIwrYnWE8lRnkuwBYUDPlTOR82nSmHfGTA5k6jbLy/gwETuU9TjNi23TxuBiL2sUJ47xhMa33yKml0MPquOyQLSRQ6Fq5fZycabMvsq7GdnEdtfGFjrfItC4XJCFrWTVKRzxLH1sn3E64v3Yqvf51f5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cjAXURpl; arc=none smtp.client-ip=66.163.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498247; bh=tu/mseRw64RlNp/thQ4ryhPcV5CpjmbeaD3pA1GGZqw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cjAXURplII39yeMuYZVvePz8Ap2QHJgmrB8AcA1+dpbNw8ZvD55xS6qZ2ApgtgBltCBMFpZ3Rwy9+ZmEX9WFlUUJ9uK5Zr7WbBVV2wwM8JuDvF5eleD57ugLD/XzBU9HXQpGGKq06bgouD7jLJSmAq7FSEtNFRwi6QKfiSGGlDb6u4lVlHzyJxxOWU5J4FQHlNWrZ2Igh+Q4LKGCIP6jtOkpaT9vISNhpi5Shs7v3Ie/4GnFxz2ddUAtfkLqovlZAN6xG9w6wztc4/xqsEB/F7XhEx2nHB7FUE8+kci1vs0ybD3pE2vGhJS5qm49ivcqAzBYxHie099Qq3shsBZ9sA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498247; bh=36Pe6le2SayN0p9zeU92TH+Nc46FoXWmFbocfIFSCye=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fzmsgtvgxw2t2wMceTC6uJoI70bP4HyoaB5BqndKWJb3UUjp1q28Po0r2DjlhEUIerWF35Rq7X8nhepcLFs+1VblL8Nfl9fcF/ZkR7tf8WhU2sa5DCNGlgBQ92aP2KV7cipW9NPBxc1n2m9YJ3cjWLu6/DQNbef74YN5YyDCwh3wo0JaGIm3bRXMlVcH6Q+ad4e5yIisUEwrV5ujJgNt2VX7DOFdU5Uv6KLoLrh3NeFnfhf6NlR1FwWRZbJKqjtKlUNlGCRONJ0y2Mf2o1GN4pp4YQcOk4BNp3jT0ZlLIzsDWPP7TRBbEv95RAr8CpG5bgG/iw716xLcraiyKzaeyg==
X-YMail-OSG: eUnYSvsVM1l4ZauAk4ljPTGA9WIlqOa5xfukXF8ziIGS_nTpCGL5GWVsZC81rAi
 afOw2iw32u79VwvLJjAeB3lx9UcwmaMPGfH9h__gadibEIzUgnpfaOYzDT3zoADUcphOqQEt0GmS
 nYFSM3BbM3g0eOdgJKlyKwk8cm2fJB9R3Cdb1el5YHcW2a9EfVHvmjktFIcun5BsuMyjaKGUe18L
 bOS8Zokio14sV3aI78ygT3YFPuvODrNlXpg1sKg12Cr8PMz3AWuFxxDaPw8P3NjeDd1SpADV23AT
 KzYZTtBY4YuH.DF_vKvMydIdx7CwjYkcUzukFmalt4lBRJrx6Ba9GhUdmUMViloaCCDFeWGLm3F0
 cGfB5sUl4jgBg8gw0chwfBAH1cODcXKKJ79UlKenWj0MfwcTLlgc6h_L1GNn9upeld99gVcnSAep
 4HH78O5XrlFcNhLX5gWwzi4GTsa44YQgIkK_rMD_GUhi1MNEpDz2R9fysDMwgSvSAQiH16WLqJn4
 UocjO5qmCW8fbOOwQr.m9zGfr95FJ7_QM.xmzDMNsVUcpcmJ0i8e1D3e4OvkAz2x.qc1n4UcyuSP
 5ch7niPUtSylFFf0jKxFOe0x.FD2qiPRhlyUpABpFtJ4pHC9bv0XJ65lgBWSuW.6E3o9NtieGHYI
 1DqZrJ8UNYlmgyiMd0N1NuIOQVho_jpYselQsml6zvbWJIl3r63408uX2mWgRUwGsjnWh1XlGW_i
 N.6K4PsNE3ilouIkHxiogUtFtJ2HBu3hant.5PIS8mBaOnJAfwembSQE3GOceHNHa0ToQ_VxLD5v
 YG6U4Z0wUYapDy1I3UPMpYQsGLrWxx4s38PMGuGe37rANsHEPi_xT7qZafjkytS4Rc48OVF0xYZD
 PJ_mULDEoQKvD.sk829.o4qO_JmZ8gox15F0Ncnmf.q6Hepm2LWa8u46muTEEypeNbUbrWa7T_3c
 VxLfKDxQnuH2sjf54nZ0LdgGBsaO94F_fvjnfNEgaUWx7LMwZIhZ2ucb5eCYwe4e1LmDqvzisxU1
 NKFvdxbI47SybpPaWYgkSaMN.yc_icw7r3c7s9JblDRTxU5JZ.ijoy6OnsZ9rUAAi_8daMfLHY1A
 hAiB2gqTeVW9r10nP_uQeMaLqr2Fh4dxGrt6zSaqDBjBenxUV76c9P9vSU56Q8ebwW9lvW65tYd7
 r9IhShO0ohzrJsd4k17v3btspGe5J7RIOuWO7Nbug5lVzw5r29NLo_BjYduo6437pFlqmsqSPBuo
 gszVwHMevPAGOvl7Xnev9xq4xzZdBnDZXcyCMqgbsxdp.Q6vzxsjH5KCs3GxLncnYBXCA3gvYwMQ
 yZ91guA4FJUWjkETgZBQuqg0riW_ZXX840CDNZ4GkmImwHN0jeQv8Mulw7R0hIgiBzeu_wKGxPkf
 VoRUKGl0OHUY.0gq5ffToCkSxSZAqdsaF1sbBXNTJslWTIWEY93K0mJtKPZUNRb9O2H5JWxS7ZeK
 eWnejHjAFEN7.BawfCI_LK4HgOzNmSUm1bnayhsMXZTE9HIJ4UaV6nXypQg9ZBsQxedSnR_hc5aL
 qIVuc5nZ2sDVaymv70jkPk_QHxrMrWB2X_9jygkyNZNtsC9TrGRWv9KsBIqMTJUZHV6sTx93SSjh
 YxHGyXSMgoYHaRnPvSwu10Xb0wWaDWATKun_49DsoF6BSxvJy0aOqF1PdhwbmtrOMmlECS9SiACL
 4gDxMx_Qk.sq9FhjPYrqHtMcRG_h_GIgwEuBW70BllqGIo4S_oI.Eu76RcAwRGBra0KRnQRZjBYC
 9ujhjdU_8Q.3m7JBT2qrOsNJb_am7i4Db.VfxsD8R6zPT.txesO0idn78p_hlAD7ZQJXAy0nwQ8s
 mEfW.JmnVrWWfBpFtuJlgQ8H7YZYU9MDjidvlxMIAQT9pVPGZWwDKHwutFxZWS8H0kLg..7LIFDj
 W.PVQJChKuw9FsuSjePE2KA8WraVV2dhLR_pLMLkToebRVudwyu8Ofq72ARvSpFHgg73.AhDvoZy
 10v7dodP4y5rQvTgg5wID97JP2Eub4wBJLKgqc55zsZ3tWDBeoAN9c7ioV8PukuSH6Yow.2fVtYe
 33TU5gA5t03pq5nJGVnolq5VC08LfDRnVILfORg5vwKK_Jj3prCWDEfgm9sB6GjqDb9d.wMKz1P8
 ZdVXiSaH5ZpOKSeS.TG9rO16Qt1NI1JjAVdiATueNI6Q-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: dabd5261-0c9b-4069-acad-b94455d57396
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:17:27 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:07:07 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
Date: Tue, 27 Jan 2026 08:04:44 +0100
Message-ID: <20260127070452.6581-4-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253730-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E9E6990A9E
X-Rspamd-Action: no action

udp_tunnel{6,}_xmit_skb assume that a reference was taken on the dst
passed to them, and use that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert udp_tunnel{6,}_xmit_skb to be noref and drop the requirement
that a ref be taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/amt.c              | 3 +++
 drivers/net/bareudp.c          | 2 ++
 drivers/net/geneve.c           | 2 ++
 drivers/net/gtp.c              | 7 +++++++
 drivers/net/ovpn/udp.c         | 2 ++
 drivers/net/vxlan/vxlan_core.c | 2 ++
 drivers/net/wireguard/socket.c | 2 ++
 net/ipv4/udp_tunnel_core.c     | 3 ---
 net/ipv6/ip6_udp_tunnel.c      | 2 +-
 net/sctp/ipv6.c                | 3 +++
 net/sctp/protocol.c            | 4 ++++
 net/tipc/udp_media.c           | 2 ++
 12 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 902c817a0dea..e9eeaa7b6fe7 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1050,6 +1050,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
 	return false;
 }
@@ -1108,6 +1109,7 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 }
 
 static bool amt_send_membership_query(struct amt_dev *amt,
@@ -1167,6 +1169,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 0df3208783ad..92ee4a36f86f 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -364,6 +364,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 
 free_dst:
@@ -433,6 +434,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 0949d4579171..cfc8e7b5f8f2 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1396,6 +1396,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1487,6 +1488,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4213c3b2d532..88dd36bb24b0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -449,6 +449,7 @@ static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 
 	return 0;
 }
@@ -708,6 +709,7 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1308,6 +1310,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				    !net_eq(sock_net(pktinfo.pctx->sk),
 					    dev_net(dev)),
 				    false, 0);
+		ip_rt_put(pktinfo.rt);
 		break;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1318,6 +1321,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
 				     false, 0);
+		dst_release(&pktinfo.rt6->dst);
 #else
 		goto tx_err;
 #endif
@@ -2400,6 +2404,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	rcu_read_lock();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
@@ -2409,6 +2414,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	rcu_read_unlock();
+	ip_rt_put(rt);
 	return 0;
 }
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..c82ba71b6aff 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -200,6 +200,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	ip_rt_put(rt);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -275,6 +276,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+	dst_release(dst);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7bd0ae0a6a33..aacef14cd300 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2540,6 +2540,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2615,6 +2616,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
+		dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f..ee7d9c675909 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -85,6 +85,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
+	ip_rt_put(rt);
 	goto out;
 
 err:
@@ -152,6 +153,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
+	dst_release(dst);
 	goto out;
 
 err:
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 8a91f36cc052..b1f667c52cb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -190,11 +190,8 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
-	rcu_read_lock();
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
-	rcu_read_unlock();
-	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e0210744..d58815db8182 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	uh->len = htons(skb->len);
 
-	skb_dst_set(skb, dst);
+	skb_dst_set_noref(skb, dst);
 
 	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 531cb0690007..54f489c4c41f 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,12 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	rcu_read_lock();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	rcu_read_unlock();
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2c3398f75d76..98e5dc217959 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1070,10 +1070,14 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+
+	rcu_read_lock();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	rcu_read_unlock();
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b85ab0fb3b8c..ba4ff5b3354f 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -198,6 +198,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -220,6 +221,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
+		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


