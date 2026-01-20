Return-Path: <netdev+bounces-251350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D5D3BE53
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 009324EA750
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E533D4E3;
	Tue, 20 Jan 2026 04:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330033D505;
	Tue, 20 Jan 2026 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882788; cv=none; b=U++h/l/L4XWK4OLEO1zQWMSjEzAErtwkeG5R+0dMq6jZaM+iwWgMrV659msKjkFzES3s9bMU2qA6VgraYIJMlMydXDyfO7i30cwHCLOjsbRBCwAmr1BmDhN8fv2e+yd6cVWTX+0UNg5fw6HS+yfV16AhK02QdAsGDF1/SYcI++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882788; c=relaxed/simple;
	bh=enHYcu960fFoW3PDKIuCWxyuA6jr1IeRQ0MrDK6FHgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=haNElnekydZK335VEzkgw6wmqUCpX15WgOqKDTtk9IfyCy8g4capQ10IfksnDkaP9ucm8wneRwQa7z5FiJTWEgz3xyxLWIfe6MAgjUpq8s7Z9WgXm0wFKDsoeB+zztWenpONy0xtOR6W5FcddKRRRDm9VkfZ6LPkSVChWxXLcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACXKAxPAm9pZCG3BQ--.23154S2;
	Tue, 20 Jan 2026 12:19:28 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 20 Jan 2026 12:19:23 +0800
Subject: [PATCH net-next] net: spacemit: Clarify stat timeout comments and
 messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-k1-ethernet-clarify-stat-timeout-v1-1-108cf928d1b3@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAEoCb2kC/y2N3QqCQBBGX0Xmugl3AylfJQqmdcyhXGt2FEN89
 7afy8Ph+84CiVU4QV0soDxJkiFmcJsCQkfxyihNZvClr0rnS7w5ZOtYIxuGO6m0L0xGhiY9D6N
 h471rQ7Mjoj3km4dyK/M3cYTPKvJscPoZ5eeYm/bXF0qMYeh7sbqYqq07oAZ3XlY4resbjlthk
 awAAAA=
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
X-CM-TRANSID:zQCowACXKAxPAm9pZCG3BQ--.23154S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17KrykAF47AFy7AF4DXFb_yoW5CrWDp3
	yYkasavr1ktF4YvFsrAr4UJw1fZw4vgFyUuFnFy395ZFn8tFy8Xr10kFWj9FyqkrW8WryY
	qr4UCFs8CF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnBTYUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Someone did run into this timeout in the wild [1], and it turns out to
be related to the PHY reference clock stopping.

Improve the comments and error message prints around this to reflect the
better understanding of how this could happen. This patch doesn't fix
the problem, but should direct anyone running into it in the future to
know it is probably a PHY problem, and have a better idea what to do.

Link: https://lore.kernel.org/r/20260119141620.1318102-1-amadeus@jmu.edu.cn/ # [1]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
* Chukun: If you think changing the DTS for the PHY is appropriate, you
can send the DTS patch separately - that one should go through the
spacemit SoC tree.

FWIW, the same timeout thing also happens on the vendor provided OS
images for the OrangePi RV2, and AFAICT at least the statistics part is
not recoverable.

So until/unless we manage to get more information on how this works
under the hood, I think we just don't bother handling the case where the
PHY can just stop running, since the hardware certainly doesn't seem to
expect it.
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
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260120-k1-ethernet-clarify-stat-timeout-d221fcd3aaa8

Best regards,
-- 
Vivian "dramforever" Wang


