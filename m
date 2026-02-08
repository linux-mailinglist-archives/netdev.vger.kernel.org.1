Return-Path: <netdev+bounces-257869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEHjKPMUiWko2QQAu9opvQ
	(envelope-from <netdev+bounces-257869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9910A8B3
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE393034DC7
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0773816EF;
	Sun,  8 Feb 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="bWHPh5Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884A19F137
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770591375; cv=none; b=rJ79pP5fNxmdSAqTa159nBD1fwTbWCNiQwpaWte4841eoGgmO1oquPXHbQd2IdQDjvAv+oVOOx82XEDhhNzO4c8i46tvG2J/oEdUt+L6+lrwUbZrBSzw37tqkXzizOGnlPdo59A0O6pM6yGfbfVDNzye6AhDgD8ADp6BEFDUAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770591375; c=relaxed/simple;
	bh=s8VGpGMSGaZ2+p5mTzzQyysE0AJW/x8r5xi6k/4c5gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agToPY24hW2sY4pIyMcPn+ea/TKa4efyjhh6F0mbZZ5VUmq0aZujUlOdhwMB8Deeh5DY7IbkhLWtgjtqPWbCECgGzsJAbJUgcKBDP2eYUASR01J5Le6W6ccw6QMy40NxiUOKLogWi2meAUC/gLfCMqCABnCf0yXhyA27I56A/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=bWHPh5Oh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6aaf3cd62so386764485a.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770591374; x=1771196174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsIvHDz2axLyTXF6o/p1gIQLrDHj0fdiTLIqaKocJCQ=;
        b=bWHPh5Ohn9PgORxTg3OTBVQK1BShO75ZjuRFk2hoJBJ6je749OxI28mZugXYsiuN5b
         6cLFMq+SwmdN53hW2+PfSj388B4slEIeRbYhaYWpxV1IZ6ZtKx9XcyFf64MYelhRomyq
         LLrBMrNiNgaW7rPO0cK1a07YKLQ69JMRicXIeCSTuMiZkedRm4l6Kpz4Fw4Q7mGnqrJq
         ckn8i1VEqbWpnJQnn0CM7u7P4KC5S8WZ3tHrKNUinkrAraSu3qZjUsyL01pPiaaSFrXr
         Gg+FPZTgHP5W6yzVpwOy3R4wa+6PctvgOdYIVQBKIsJdqr1yzg0e3XmcBegPS+sz+yLd
         ZaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770591374; x=1771196174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsIvHDz2axLyTXF6o/p1gIQLrDHj0fdiTLIqaKocJCQ=;
        b=gMcBh2s/3IJqw1vf8IfcSVUsKcpVNNqHcODbr2JJy2mBnkf4KfA35l0iT9lXllURKL
         FfgiY37izdBQzFCIhPh4HoUI1QDXqYwypFdaURcgkCHHSqmwzWAL2BPMxuQYhQDKm9zA
         99092uZ8HxkEHPi8fzX3bmApRIQq+K+t/8YABAqRJfW4FcseyEOh9evn3tovLFW8stZx
         Nku1LYdo2bD2d1ioa8kpoGw8FbGf/IuenV1gqKKMLwpO1j8oR4H1tiZLuGiVeKJjdtqk
         r1BkCpTn+QZsAGTo12ELqzYbStFnQgBBCLmcimo3hJ1ZpMvYDn0Vo4F7/rcd+LbkVZZG
         zFXg==
X-Forwarded-Encrypted: i=1; AJvYcCU4s38ySGgEoGZNNFOrzDE/MWiUtY4FP2jg6hYa2ya3hm/s5WjMZXfMeaf3ItkF3UGOZlXZynM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGSy1pUbAC6c7JDxlZOBHMORS2EVBQYvsuBJ3Ul9b9OD/KJG6
	dSqz1bP+ON5Y+0NqyQlZ77GykMSeTeF1dCd52Xf0QAANa9dNJ6sK18ZY2s94EonhJEc=
X-Gm-Gg: AZuq6aJJlRHY+K14NhPrO0S5dfpgNn6JkdbNQR2rAqMymnaFJCJbzJLLasJgqYnThk2
	l+Nliy8aO+nWwceQFQu9YFzyhZddirrbbFZs90FVGwBT4ePWKPf/skhCSB7xgwdQoSkqtLMLeVO
	MDHeswZlZw4hqOIl6Tomgd9KGfxojatv+S1GoLPaoas9V4+R1BAOOrGfSe+1FWIISF4vMq4pkIW
	YCtg/4ssFkh/iQAfddjsztMWshSUmkCiuCKTJDRDlC8nPmrQouOqe/ssEMWsuao3w+4nb0FHvCM
	RpYNG2gJVKkTcVnqf93vSLTfw+InUtPhI1lEadkJ45JX2YzZ6Vhf9ysYQ8HmJQQOMzD+/l3Y5tK
	pLFIZkC3Sq40TcGQx8Ul03jroeiYQHCGc/tgTxhu6rjFTfmuZrJ9I/t+mf2nlNDybV3sySnKobg
	5dglFL5LbwpIRFK2dp4ogoS6ZhCdY7jh2cab2CV9IBX2TXZ/PfOXtiyepaX04EbHLBqZWxBuL8g
	6mE5TqRp9W65TiV7tpbOY8gSTX2l+A=
X-Received: by 2002:a05:620a:458e:b0:8c6:de6f:898e with SMTP id af79cd13be357-8caefcca7d5mr1105942585a.9.1770591373816;
        Sun, 08 Feb 2026 14:56:13 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9efasm679622485a.43.2026.02.08.14.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:56:13 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v3 3/3] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit_inj()
Date: Sun,  8 Feb 2026 22:56:02 +0000
Message-Id: <20260208225602.1339325-4-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
References: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u-northwestern-edu.20230601.gappssmtp.com:dkim,u.northwestern.edu:mid,northwestern.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0D9910A8B3
X-Rspamd-Action: no action

ocelot_port_xmit_inj() calls ocelot_can_inject() and
ocelot_port_inject_frame() without holding the injection group lock.
Both functions contain lockdep_assert_held() for the injection lock,
and the correct caller felix_port_deferred_xmit() properly acquires
the lock using ocelot_lock_inj_grp() before calling these functions.

Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() around the register
injection path to fix the missing lock protection. The FDMA path is not
affected as it uses its own locking mechanism.

Fixes: c5e12ac3beb0 ("net: mscc: ocelot: serialize access to the injection/extraction groups")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index d6b0936beca2..9fd8ac7e875c 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -597,14 +597,22 @@ static netdev_tx_t ocelot_port_xmit_inj(struct sk_buff *skb,
 	int port = priv->port.index;
 	u32 rew_op = 0;
 
-	if (!ocelot_can_inject(ocelot, 0))
+	ocelot_lock_inj_grp(ocelot, 0);
+
+	if (!ocelot_can_inject(ocelot, 0)) {
+		ocelot_unlock_inj_grp(ocelot, 0);
 		return NETDEV_TX_BUSY;
+	}
 
-	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
+	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op)) {
+		ocelot_unlock_inj_grp(ocelot, 0);
 		return NETDEV_TX_OK;
+	}
 
 	ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
 
+	ocelot_unlock_inj_grp(ocelot, 0);
+
 	consume_skb(skb);
 
 	return NETDEV_TX_OK;
-- 
2.34.1


