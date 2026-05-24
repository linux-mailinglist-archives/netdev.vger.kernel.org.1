Return-Path: <netdev+bounces-291166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NMVNO6zmEmrf5AYAu9opvQ
	(envelope-from <netdev+bounces-291166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 13:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 418BD5C23DC
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC8E300875B
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471037754E;
	Sun, 24 May 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="LQofYPbK"
X-Original-To: netdev@vger.kernel.org
Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBC145FE0;
	Sun, 24 May 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779623592; cv=none; b=Dz+ObL+zYeyL49WJT7NiCKiYOuZTO/JGcKMm0YLH4k8F8y3zM8fOQ7vTgNVtjI41kW/SeaOY6WdKkBRnLB9xXIVZfU7uJuVeeITGZE+Rv3M2W2/S0nSuEKqQs01qMIdEsKgylHNf6cLz/2G9MbxuHfXKSr4UvHY9LWAqeahjBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779623592; c=relaxed/simple;
	bh=jpZM8/zLddTDsq5GlC6TnbfoQOrGlwYCgXANTpOTf3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u11lKiGl90+huAvomVr7CCesqnekinUTCmQle6YiR1Zg5hBXguJ2AmH7/9MoYjtz5qpn9xLk4siVKZrK+rNXbS6pTkVzTqNelnMsPZ46E3HRitVq0LyPCAC1GaQhP5auEd5KU5GoOBYasBQ1LZBUs33jArM2d+BO1JSvhsMS39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=LQofYPbK reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.213.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gNcpT51RNz6tkK;
	Sun, 24 May 2026 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1779623588;
	bh=j7VFnmR8Q2imsbnf/iLbK4SfOgvuJSNYrz/bMqfO1ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQofYPbKaoyo4c3Cs7rJ41Oma/8rPwklkdBzSB1aJPRVsOH/MFGpUOzY81JdNxMC2
	 exzk+/KUf5xL5ifCIuxxebcuLO+qZnQ0+gG1Y5TCfoDqHnD1dCD8e6g8b0CtDhtjw5
	 HsV4QcAyTBnb7nj90s6hUCrqqTviK5jnjeo8ySP8T7PNWbKZjhhwIk1/MqYiARqGr3
	 Tsj6G2Q9pKchZcFC7ArQWpNT9QuOESqIhn/hiUoMKxsCN2Rmp/l50WaEYyxnu1K420
	 rpAbkB1Ne3v2JkCna10AGyMZCV/Ggv+nfYN+mlqT9tCPmiqf01A2bd/kwrePrKsK2o
	 Lnnbv7N+K0Bhg==
From: Rahul <rc@rexion.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rahul <rc@rexion.ai>
Subject: [PATCH net v2] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
Date: Sun, 24 May 2026 17:23:01 +0530
Message-ID: <20260524115301.905478-1-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501164242.419cc17e@kernel.org>
References: <20260501164242.419cc17e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291166-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rexion.ai];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rexion.ai:~];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rexion.ai:mid,rexion.ai:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 418BD5C23DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_rpl_srh_decompress() computes:

    outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);

hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):

    (128 * 16) >> 3 = 256, truncated to 0 as __u8

The caller in ipv6_rpl_srh_rcv() then places the compressed header
at buf + ((ohdr->hdrlen + 1) << 3). With hdrlen=0 this is buf + 8,
but the decompressed region occupies buf[0..2055] (8-byte header
plus 128 full addresses). The compressed header overlaps the
decompressed data, and ipv6_rpl_srh_compress() writes into this
overlap, corrupting the routing header of the forwarded packet.

The existing guard at exthdrs.c:546 checks (n + 1) > 255, which
prevents n+1 from overflowing unsigned char (the segments_left
field), but does not prevent the computed hdrlen from overflowing
__u8. n=127 passes because 128 <= 255, yet hdrlen=256 does not
fit.

Tighten the bound to (n + 1) > 127. This caps n at 126, giving
hdrlen = (127 * 16) >> 3 = 254, which fits in __u8. The compressed
header then lands at buf + ((254 + 1) << 3) = buf + 2040, exactly
past the decompressed region (buf[0..2039]). No overlap. 127
segments is well beyond any realistic RPL deployment.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: Rahul <rc@rexion.ai>
---
 net/ipv6/exthdrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f..35a02584f 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -543,7 +543,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
-- 
2.54.0


