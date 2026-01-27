Return-Path: <netdev+bounces-253731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFl2BMNmeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C290ABB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C62A03003738
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B896223DFB;
	Tue, 27 Jan 2026 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N/xjwSX/"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C622D4C8
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498301; cv=none; b=hNm36I/XP/0oyLAjt61O79IarAXgvoI0N83IDQYgnNYgYq5NlO+q17VOcAqqLqLyAPi7dD93ymaDZUrMDxgf1d8shdCSTax/dLwLE6zTsK+mss4yceEdcj3T596OoO25ZOU0/ZzkDKvGXcU3jFI4dbBP5UA6QcqWLuJNmRPDtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498301; c=relaxed/simple;
	bh=CuiTJOOmsW+aFYNMJm5VXa6RQE5Ls9xLs9QS3bXmUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJiMGZXtGJLmUppKVTe9Y02dMT7QfhiCoX//c8xc/ifXOh71oasxdAI1hq0hmV8U3yV/OdnBuFpwCEwV1/dqouOJ7dLFiPX622A9YDwWtS7ARjh8W3VQuUwhkNvPtVI3jRSWpkrJHBWYmUZAr+ClfrBq1I9Ri16V7PTUGP/k+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N/xjwSX/; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498299; bh=9m60tMj2busabF/Oy+HOZ18Gf7Iev+cYqYon9NoGSWc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=N/xjwSX/pKtzQQkqUNFlXxJ3R/p/6IC5g02NfuTRRtOAIxnD5d+49EiY3Vmn+IxFQPbDVocZeuARkoOAiQs/fbLKfC1Xq3cARJAw2Ur8VOoQskejzY65PFqI3eH54MF0Ph+xpJeq4M0NIAMxqnbHGyEezZ0vYFFqlo3o3/2pgOim07zwWJRL6VsuSDacr+T8TOSLlLr20Tj7tJxFz/6jAfjhc/kxEt4wIRkQhOvGutGlwIvz/7SrrMn/tJKsIpv28vcAhptGimeH+e8+SApXDZq5axN+enOu1eg5OKpMTX+2RnJP20uM0isAzHYiZ4biepksD/HEHRHXJ2tLm88lBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498299; bh=+H9ksomlBDcUZIc7ND4jsVObMuGg9uJhBDkXt114H3/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ed4g5ukEYbNNKLeqslbsHsseW24rUYwJgnp1SN2ypfD/qzSUPFs4YSv74nF878Xp4JvhIhMGrLOcQo0vzKnVF+JFyLvVvlFt428Mv0tFvOZciLgM90h7xAZhFgyef463fctBd35rlVO08+bWzc0qSUMw8zkzLRLZYdCYlLUcOBg+4j++xwfzDaNmVbsFkrZapKAQ0zTi7NpDoM1FYTSwB3kVsK3MZEfTgUKPYZrPfn6Dd7IlPy4VjQTBFj15vUvK4yyj60vqlP2/MJc+YLPoRUO11M6AK4D4nfgL65KHffhH2Tr0B4Ypa2+lRfiEoiaadU7BF1XQVZSa0abM2lQccg==
X-YMail-OSG: iwN_hmYVM1msb5RutNMY2XnB03wJ9KlKKMKNHWffnLlYCrJ8602UHzPleq9fXr2
 xqJK8i_nWim2C2EUpN2TzHGJ0M7gQg8VyeZdmYNTzDrwSLWYIWHtfEbdeNLgqVhbwa0r.B9hg50y
 ajhMjALpaNCJ.mKWomDC5fMBdyNel1.4wHXd61KZMGUvg4GWhkfvV3e0pQp6059_dk7diOq4VEux
 ZLM0PzS_4..5IUYIGZMbI7JtiCbvc2zdmWV.tFv7SCOTZNwfu7I1PMpsPr3TZL54586ziW1g7vyS
 MF7vptIqZBvDlgqHZbcBU9iql6TDUkDpI5Lu.8auskTQ_oeg1idIAOOogmcqlWHQIsI3_eB9sruZ
 W4TIrw1pD_GFTD4W1vmkmictWPN77ffXKJdrmYjhOsaDMHFpwM5gYob258FLWrigpmoYmKSzLG5s
 6rgroxS9tWBFOpamk_U5fEiR1UsvIWhzW8nZvsbjARICcGhM_jJkFWi7PPqDI9D1qfUno2nZPGsU
 Mg93rIVGE.3jMoAQtBvg3aYRytA_LXareBoDSVr.th5w2j_21_H3cmKmTVCw_jH6DSABlnTTs.I.
 NIbkwnITg3l7.Jqg8V0epz4FWaseNH2_4IXdvgNaVvTNGQOHB8y63ydA.khXW0cTeYnCO727Y5Cg
 FSYawsfu8f6bE_hgEYFnK7cdbcaawIUkK_ngRrtE2T.wM64DhR.pnvkFLDSYBq8a.vANCIBVMuJ9
 tuPtxXHxZmJiH_3wjaAnkTOQMuePmiks4DMmZ3KdYpFB_BTVa.868qud3ebzVM8mgkZOKCGlzFO.
 Igwcou4eO3gMUMs.GT_PMvoV51hqjDUrx0KK3xTJEqSMEJ9m4EYTQsDzQLujFyzBgT.478.9YGe9
 DO3dFdyf_jFn2bYKWThp4pUymUYDoTehJfY4oWC0otrPRVMIdxmOBpU1y1elPNV5raeYV4T9uqeD
 vRwrdMzdbymROxzsI1wyMH0k68RFY3oqudIeRsh1H2VvvwhxJzJQFLp3bGqVFFA3ushJjJCXrOFy
 Azyvr6JzZE55lD7LuDbf_dhGbs2utMmWj44P4iBftRfH..TgBq1DIGJqZhvKIONqIIeWsfzHE42V
 Xy5RGuUYATIN3hvvR8sc_vXF1IA1wBWkwlMmbTenVlQhgp3RQB1Lj08kmOE90LcOiZD6immY0QiX
 ecs4YNMaE3kKc5lDoHrH6IiwISYVtEqtRTK0rn.rqDDRxHcpfoR.eWMAglBOrcMUMnoTDKxJgeh8
 ZryYGMNIg0W.HUDlAu13kX5_XXRnd5V9GTrZJqVCDlEdxPKFxfUAOqko_aEcYh7OL6jW.UAaX2FO
 rjfZ9o4fDZds5RUVTWaoWKLmUckJfs2qYcaj_lCeNT1Tyyc7BM8oPY0IEiHDSHKQTsNuJBXpmPbY
 iQN34pAHQh._JJoueYptjAmpBarxYkwy036aOqlRS.9I2Suu2jjmm38noF2V5fS5H6qUFR6AQrm2
 yvZMHs.FhHrCbx4DASSHBAE0M8MQa78mRNFQImWEIMqsfYfAcHkyMPG0KNDqfRIUCegYCG22Aki_
 jVrAY1werbFqWcP.euuy0nIFYF2ehGVXlGBb_blPIgfqhGpYFUlakrU.rd_4jigr7phVcbXcg4pH
 tg8dpJAT4FlpbGHSJ9tpXLV0ISBWf8Wp_6N2HH1_xnL5UFRSNcC6etlN8rXA9G.YVsePpwWF4_sk
 z8n4RfbUAbn0ydBsB9U_FFApAwszetbP6XCAv353Wh82wdx7Nnt27rGHsKNJdxQnxCELgk4luSQZ
 iolyCsCm2us9rUSo4_LgP_Na1iMTq5FyQCVabXOEWp0gHTzlhIWhoaxUqZSNBG0g2A_G5VKEt5Ci
 6ERLTH_OGWLZ2kIiKU.FSjvf5lA1JX0c_uCMdu4ENw5FGhtuK7I2CHBQupSw8m_xSVnvu52Fw4BS
 XnqTHj9RhUqBhY1vqS8RvFsDhtTGZQ.Pqh0GNzu4qzBlZAvZWv_tP8DAoqS4npyIy4sxzQ3cfCiG
 jQUT.WNH.pyi0.kZqS7BVmfM1JBqDtg6fol0.USeYgV_5XG3IyU2iKnP9QLhDv8Jl.W2kiPjILra
 ijjrQNKlktQvaS2jWBGwthh0iaetu9nLryapipDQKAXZUE7pd_RONWXa4gjElrFO8YzG7dE5JWZ5
 M5_9IKL7VmBoKig4P.Egzdtzik5fLJZmIMnYRB595mg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 7e152f15-0bb7-4907-b186-f536c82a60df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:18:19 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:08:10 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 06/11] wireguard: socket: convert send{4,6} to use a noref dst when possible
Date: Tue, 27 Jan 2026 08:04:47 +0100
Message-ID: <20260127070452.6581-7-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 338C290ABB
X-Rspamd-Action: no action

send{4,6} unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for the wireguard send{4,6} functions.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/wireguard/socket.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index ee7d9c675909..b311965269a1 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -46,7 +46,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl4_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		rt = dst_cache_get_ip4(cache, &fl.saddr);
+		rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 
 	if (!rt) {
 		security_sk_classify_flow(sock, flowi4_to_flowi_common(&fl));
@@ -78,14 +78,15 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
-	ip_rt_put(rt);
+	if (!cache)
+		ip_rt_put(rt);
 	goto out;
 
 err:
@@ -127,7 +128,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl6_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		dst = dst_cache_get_ip6(cache, &fl.saddr);
+		dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 
 	if (!dst) {
 		security_sk_classify_flow(sock, flowi6_to_flowi_common(&fl));
@@ -146,14 +147,15 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip6(cache, dst, &fl.saddr);
+			dst_cache_steal_ip6(cache, dst, &fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
-	dst_release(dst);
+	if (!cache)
+		dst_release(dst);
 	goto out;
 
 err:
-- 
2.51.0


