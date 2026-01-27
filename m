Return-Path: <netdev+bounces-253724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIgGKZ5keGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:09:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCC909BB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D133067783
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6C329C74;
	Tue, 27 Jan 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JL6CZ7Ul"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5423909C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497616; cv=none; b=nUjUGpvl1OR16QveChB7eQqPRBnj2t3jGlHtWnGyNVjSti2WYeRhpUt82g2SXyjbKt4SLOf+b2tejcdT30Gflja7VbPAElhnocWlqeSRTYSzAQDY6ToERjfLUJiTLGrAoEJODipXJuBsHESTJOC4K8zb6JyFOHasCCigd9QZiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497616; c=relaxed/simple;
	bh=8H7UH55hKOXYY6A9HtEYjin22aUf4+r8lanQdEeaIOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmA1B3pZ/jscLts7Nm+xG2tcwTw/Smhe1RmOn2j66hgOjv0U54yVb1M68upPcD01mux+Hqspk5BwNzA8aoptIhZdXSuB3XzOoZBZ/zYNX1Oq98PhCvp5RCUGg1rbbGg7HFkhBPxYtics5LraE9R0jz7brc1vqz/uWvKT9GTJZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JL6CZ7Ul; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497614; bh=bJhf8FJ1SZnV1n+lEmAVmQammdfQ339DftNkx2GsMj4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JL6CZ7Ulz020eWSelHylTUK9pKZBt+4QL3opi4uRl4gsvBb0VgXq2SoTVEptmK9w7d0HTCTUNXsWftmI7AqirHYQsX/ESVg4t9kgsA2jEDUQbUSSbsCBl5shP0Uo7gJEnjRjklAH/0QnXRkG0uP9fS2iJUxp/ONDVempEkO637SCuxD0BtycdEtxKQKoBzMwMuCCkXKx73Lg1sppiTI1EHcvxK1GR8LJVDWEe2JC7YVJLyN1qW9BmFTBCKCCqWwIOZz/78rYS8gBDHW8sVw4w17AYz4Ee2s87P4NRSzPm+SU5ISDdYMK78WuQD0U2dtExRl7xqaKJFvgNsuyMSJA7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497614; bh=RUi6r06WgXZs9vcHhEeOHIcq9Dkhf6Lgl4N/YQu5f6C=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nBndOORV4pkPlAVnm7Tj5b5lSR2/Qpsio9tts3rIHv4RHh3t0DxBGkf4kbeUAb6yqLz5edWQB8USDa1QYcHXNqouLCAmjYY4SAkhl+3TaL4hYbmMs3QV8aT59DJRyqJ/7g+3KiPU6l4sracQy3QwwErWYhePgvyBYi0U3ENlgGZ9AJjrs0tDTmJDARBRZtX0EQb5XMpodblJ1VU6XUOmjDbR89a1fGxMV2oLgw/PST5sikoiyE77fEevcqGO13qEitkUbb/uvBmXPNIRss2HLWUyfgNvMzib4WayyiRLwVnZhavWtwkCjQCbKyZqBqnFN0Qa32qpBObYRQqGty04Og==
X-YMail-OSG: 2C591wIVM1lFicJ7f2RrjxE_F1pKTy8s5kqBJ3G2LTKnKGiZTNYxH67c8wHyhoN
 mYZDikJYgmXOsbsXYA4I8W5m1Zngr6dtQJT5NB0UsTfvFaaMoodwGKunslHxnOKlmXBL_P7pvTnf
 n5LH.k.qTurV8LOKsTE93WCcfMUduBhqYsNdq3KTHG03lToq929opYHLzPgHZ4KIU3EhNZ1dPT25
 4W7PTKPK9qo8hlnHgsFruFZpnbpHWJqD0hEMe66n9Go6HY4EKTOE.a6uDKr1sHpxf_euIjmFN_ub
 GZ6lRleAxWDBdxbEreR3Sk1imG8oTD9ZDR1Xrn7QgpLuf36gOUtHPVnjEVwOzdQRBpFfjd0R1l7c
 cnr5yRgKtHqCno2HIXVhq7hSkkbFig_3l1ZfcpzpJkfdgwgo1YRnz9.fy88kvd1BtN8Vj6B4AeZB
 jH2Wgl1Q3vNTGi5HTc.ntH9gHHIfZOHsU20LedLaUuiKg0LUPx8gtoIFJkaUrzTpQ5izsc5ZSP9C
 s56DgrRYQtYMW1FzMYvsj2jch9nqL5TcUl9ypVpr_pWwwnRE2TewBsX86H3rZYpgwU1UUGjyMvT8
 6XYx5UWwmAUIFwBG2Q.WxP0eCepvfqj6rHcsgKfThmcHWSGwJoKh7.uVQ7uhF6SVCqYoSFw_S3vy
 V2zVi7T06MdM1ILgiKN5K5YsOC.okFkmt.9vwJ3z2wX6_LTT2hbEIBDvbsUp6wCm5gZZU4vXpch9
 MlbLSXu6dEdBc_AeEyTh2fiRMXMAo0bdZifhjY3yYLfzskZpHCt0o3SJ1qxVxJEq1SGDdx5zH8pm
 pfFANst5jGILltiPzYglf96Ntb2pAMPC9iYcTps3OtVXMlVsNcN2MXW2i1.hJ6lIAs7Uh.lR1ZfH
 _sQRrNFGWiynMPrXfkPWs94phLYZLCfPXpYuR_IswcUv0DdNcKk3soHab0qlLiYtJoNL4STBQkxN
 Q8lU8_Mr4Vj8LoXf_MY7RvZG9nlWqztHCAyFl62.YwxE_SmbN7J7datjsFGsv1Ww7jhluCmypjhj
 sR.3sIf7_fnh7Gd9VKraioPZovYRZLmAgZCRhBGSUjU2vqXGaTM_dXAWNW7qxbz.juHRe7wOeeEW
 CDAbFRzWwBgaTLH3fvoZVyjOTbF.tA2i6gpQd8X5xJxv4YzcoBkIN0CqDXy3FTw_Q_5n2zdLoMxK
 9vT_OdZedFZEVj058EWR690_fUAd1KSvlGUz4xDMG4SF3vYlUU2wtsqSZ_tbOLgogmqUsjtOAc9h
 t3U_OARsz.6yIaakeo0gqg7586j05t1ihANlGll2_vC4pT83joxr8WwRyczcd46.FdO0WOX8uK_i
 EpztiKjb_TeCrX_fMlEvFea6yhWscEOKSPcFF7OxoTq4fVXAJYoYZB0W.9inC1RybesH531vUQ.L
 ACcgILvyrWiRNYCNMwjgyBzzQnAsyajdQBsAfuT_s7SohigxUkfL18EIpjBOWKdy_rsUfl0aNmqI
 NnkDQtm0KOJ6FMs4IpoqKuPzjEehpEUI.bE1aidPtSXlLSbc2CDz1PJCp96TBf2f5qSb0vLgXYnk
 F0OwaHT1_kCMDDtoYQN5G3m3guAWk1PkIvjxXHkmgB_uMzXjCMRr9tt_9Sx0IQR8E_Rt1rJDTfQh
 v12hMpxQI5y.BeF2.EdWUvueKwgwxfEKd9BcpzTWQPfTpaxA_8k0zMawRs2YwN.bUbSpGzpE8BuN
 ENFhVKepu0GgfVkouE6IE1jFKtz2X950Deb5uVAEbpDGNO.BzbrQeefqFn3VBBh32W55.PJMHUSg
 .gCaMebceVWWzCuhPGiNWz0xY3RL61DcbOS4irxEwOYHyv.h_O5G0xoGzq1bohKzSjDyMG9yMiXp
 7qr9bzD91ov_RPikwxT5SL8W3eCxindxwzCKVKuFfj7p7rYz_IrNzPGvZQd.rsa2B76_fZbQzjnU
 n0IuyGjRDdN1Zgw8CITK2m.jyeoTisyqfMrZRKtQ5jd4QzV0vel7gcJ2X3T26P.O9vzIxk2en8w_
 8js4TuQOJpiqpuRqgKlcp6rsnm1lbB1r3Yuo6EMtrvQfK4FkOi9EN9JEavb_4onT1JU6jm7B5.rn
 YAFGqfCNGPmg_hmNBNPiPAolv.WKnNLRFkGZwLsS77tSv3W2aTwJPas71VDPCuygQZf.doIPZXia
 09DNDR0xDOHgDYrffQs435jGgVjiXSU0WJkWAMOLPUg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: dcbe36e9-b20c-49c5-8bb8-a88abc0fe378
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:06:54 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:06:48 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 02/11] net: tunnel: convert iptunnel_xmit to noref
Date: Tue, 27 Jan 2026 08:04:43 +0100
Message-ID: <20260127070452.6581-3-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21BCC909BB
X-Rspamd-Action: no action

iptunnel_xmit assumes that a reference was taken on the dst passed to it,
and uses that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert iptunnel_xmit to be noref and drop the requirement that a ref be
taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c       | 2 ++
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/ipv4/udp_tunnel_core.c | 3 +++
 net/ipv6/sit.c             | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..2136a46bcdc5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -655,6 +655,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
@@ -844,6 +845,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..70f0f123b0ba 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -61,7 +61,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
+	skb_dst_set_noref(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..8a91f36cc052 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -190,8 +190,11 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
+	rcu_read_lock();
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
+	rcu_read_unlock();
+	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cf37ad9686e6..a0d699082747 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1028,6 +1028,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


