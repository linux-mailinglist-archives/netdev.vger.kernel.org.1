Return-Path: <netdev+bounces-251704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEHrJq83cGmWXAAAu9opvQ
	(envelope-from <netdev+bounces-251704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 292544FA66
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5B0DA28C23
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C929B8E8;
	Wed, 21 Jan 2026 02:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52190305064;
	Wed, 21 Jan 2026 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961869; cv=none; b=EEko+tUqEhL1b8NVsrJzNqb88SttIjeaj5xpWqshXnB7x4jM8RYTCIyEaG83SMIGBShgCJx0TUrYTcbrFxePR/BLyzJbFhbeqGivWPeZgonf5/Dc2RVKmmwngcGVFEXzTwcGnEcR6NykHnrnHOTGwAbBOJ4Ejib3SLY6FxpK11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961869; c=relaxed/simple;
	bh=K65pF9m8TZOykztqSsjFqV3pLM01hu/wEsXWil4paQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F68epQkdqXyTkdcq4Z6kAdQvnjz2Ia0PFPkpJME99g0hxdmsYx+MVEmWEE9XA+QKnlHIKtC4/KkUQB0UfcjqaiCu3laYUTCdXRn7to5TxsgbZwnLPNTR6Z2I4urmSHDnS7PPxT3gOZrhfQU87cLgA5ernDs2OKefXzNT6cX6QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowADH5NswN3BpnmUNBg--.11234S2;
	Wed, 21 Jan 2026 10:17:21 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 21 Jan 2026 10:17:18 +0800
Subject: [PATCH net v2] net: spacemit: Clarify stat timeout comments and
 messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAC03cGkC/42PS27DMAxEr2JoHQWU/ImdVe5RZEFRVE00thNJM
 RoEvnsFtwcouJoh+Gb4VomjcFLn6q0ir5JkmYuwh0rRiPMna/FFKwu2A2NBfxnNeeQ4c9Z0wyj
 hpVPGrLNMvDyz9taaQL5GxF4VzD1ykO894kOVK3X9NSM/niUu/20cJta0TJPkc4VDaE7QDg21g
 M54H2zrrEEAwsbXpuugPYXa7axRUl7ia39hNTvs/21Xo8tAT2GwvTeuvkgiTEekI83qum3bD8q
 D2vUjAQAA
X-Change-ID: 20260120-k1-ethernet-clarify-stat-timeout-d221fcd3aaa8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowADH5NswN3BpnmUNBg--.11234S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13AFyxKFyDKw4UtFW8JFb_yoW5Wry5p3
	yYyasavry8tr4avFsFvr4UXws5Za1vgFyUuF12y3yrXFn0yF18Ar10kFWY9ryqkrW8WryY
	qr4UAan8CF4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251704-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 292544FA66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Someone did run into this timeout in the wild [1], and it turns out to
be related to the PHY reference clock stopping.

Improve the comments and error message prints around this to reflect the
better understanding of how this could happen.

This patch isn't a fix for the problem per se, since it is hardware
behavior. The new message and comments, however, should direct those
running into this on new hardware towards a fix.

Link: https://lore.kernel.org/r/20260119141620.1318102-1-amadeus@jmu.edu.cn/ # [1]
Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v2:
- Add "Fixes" and retarget to net (Andrew)
- Link to v1: https://lore.kernel.org/r/20260120-k1-ethernet-clarify-stat-timeout-v1-1-108cf928d1b3@iscas.ac.cn
---
 drivers/net/ethernet/spacemit/k1_emac.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..387f26ff7714 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1099,7 +1099,14 @@ static int emac_read_stat_cnt(struct emac_priv *priv, u8 cnt, u32 *res,
 					100, 10000);
 
 	if (ret) {
-		netdev_err(priv->ndev, "Read stat timeout\n");
+		/*
+		 * If you run into this, one possibility is that even though the
+		 * interface is up the PHY may have stopped its clock anyway for
+		 * power saving. This MAC doesn't like that, so configure your
+		 * PHY to not do that.
+		 */
+		dev_err_ratelimited(&priv->ndev->dev,
+				    "Read stat timeout. PHY clock stopped?\n");
 		return ret;
 	}
 
@@ -1148,16 +1155,20 @@ static void emac_stats_update(struct emac_priv *priv)
 	assert_spin_locked(&priv->stats_lock);
 
 	if (!netif_running(priv->ndev) || !netif_device_present(priv->ndev)) {
-		/* Not up, don't try to update */
+		/*
+		 * Not up, don't try to update. If the PHY is stopped, reading
+		 * stats would time out.
+		 */
 		return;
 	}
 
 	for (i = 0; i < sizeof(priv->tx_stats) / sizeof(*tx_stats); i++) {
 		/*
-		 * If reading stats times out, everything is broken and there's
-		 * nothing we can do. Reading statistics also can't return an
-		 * error, so just return without updating and without
-		 * rescheduling.
+		 * If reading stats times out anyway, the stat registers will be
+		 * stuck, and we can't really recover from that.
+		 *
+		 * Reading statistics also can't return an error, so just return
+		 * without updating and without rescheduling.
 		 */
 		if (emac_tx_read_stat_cnt(priv, i, &res))
 			return;

---
base-commit: a9f470594c50ab1ddf25b21a00ca4d3166057f3b
change-id: 20260120-k1-ethernet-clarify-stat-timeout-d221fcd3aaa8

Best regards,
-- 
Vivian "dramforever" Wang


