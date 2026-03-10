Return-Path: <netdev+bounces-265932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD/KOlvar2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:46:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533342478CF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE1D131CA4A6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335B829DB65;
	Tue, 10 Mar 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="jAvQH7dY"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627C4301AB;
	Tue, 10 Mar 2026 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132152; cv=pass; b=KxRNUjy6DifFPq6uY4kc+FVFrZI3wIqZINf1Bp+qe9n09W+rse2RD82JrFmH/nDLUYsv/JIJ7Sr65T00nXze7q9n53v7DvS0UsLwpJGcQP3oV+p7diBenD+MG3cfKnXQfSJNaxCp3oB6zk+9WYDgjAIOjQUDeRdKUirZsmjllqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132152; c=relaxed/simple;
	bh=zzT6qLQz5v4GiQuUfSzl8hxhZinQmgUWrgxWzt3zb5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lR1Z0Qjv4lxGdZBp/beCP7/14AF9xBztx9lNRH1AZ1bFNYJjzE0qKc3Z8viOvXmxABnM61VkOpe8KO9V7JcS662BCaTk///S9It0Z9+Cd6vNIijWqSLsdtSEUQxRlOcBJgTbsUkjgzIJm0tuz5/UQzoJJgLHmynONvsRxIBRRt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=jAvQH7dY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1773132124; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fHN/YDejH7w5ssQnzgmqEjF15zW3PQKj+L/r4e4PX+u40SoVOWeM1nWubp/qumHjDv5Q/Ur6uVpgSujOQhieXx+RaVsazYWvj0Od3Qnd7Z3g+9Vj+Xiu39SnqM7SJ8zD4qf+JDmwgoO36WwJeYYCnLCm+WNpgT0sIUuYx+QDZqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773132124; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UlReFj6bhbrq3Bjm/1NJVLY/ySYyScqFU6iXvAv6k+w=; 
	b=O5Z31E1CgE8Nq/XCui6XEOhJD4it0G7UlKhQIdHSjPctEq2n6cxS2okOgZBMY6i30oqw+7Tl/4smdOTJjxxJ2v24KTAhQv1cIiqtOfYu6cK/no5VkVu5jnYhw4vD2UriK16OHSKrM3/4BfOKL/XOKjONx/vICZhXDR8ec0HJmHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773132124;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UlReFj6bhbrq3Bjm/1NJVLY/ySYyScqFU6iXvAv6k+w=;
	b=jAvQH7dY2dEvQ+PTMBZ3pT2jNqTZl2qft4X1uByuIpJbtV+TrXa/Qb6SvFSVRP9Q
	qXlxe8jcONQq1mLH9zwkvbFv6wyoFVol07Gb9EGkEZgRTClfXCW13yffv/QKP5qg/Tz
	cvscICuLl2bWhl9uE8dGqmiT7RMLGD2e/CEFQtgQ=
Received: by mx.zohomail.com with SMTPS id 177313212152366.72383087307833;
	Tue, 10 Mar 2026 01:42:01 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 10 Mar 2026 16:33:55 +0800
Subject: [PATCH RFC 2/8] clk: sunxi-ng: sdm: Add dual patterns support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-a733-clk-v1-2-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
In-Reply-To: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773132092; l=6019;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=zzT6qLQz5v4GiQuUfSzl8hxhZinQmgUWrgxWzt3zb5Q=;
 b=ZAnmzntcBAIdnAQKtbrdA8sDq/2rLHFpsYPmLJTOgrJB1M/V6J1i1kWkQzYMq1xPoAaaqHTlQ
 QP5RxipryO4BeHFuhmHPzZcwevhMB6hxGqqJ29WjTsY5ECJICHy1DTf
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 533342478CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pigmoral.tech];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265932-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pigmoral.tech:dkim,pigmoral.tech:email,pigmoral.tech:mid]
X-Rspamd-Action: no action

On newer Allwinner platforms like the A733, the Sigma-Delta Modulation
(SDM) control logic is more complex. The SDM enable bit, which was
previously located in the PLL register, is now moved to a second
pattern register (PATTERN1).

To support this, rename the existing "tuning" members to "pattern0" to
align with the datasheet, and introduce the _SUNXI_CCU_SDM_DUAL_PAT
macro to provide pattern1 register support. Related operations are also
updated.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu_sdm.c | 51 +++++++++++++++++++++++++++++-------------
 drivers/clk/sunxi-ng/ccu_sdm.h | 32 +++++++++++++++++---------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_sdm.c b/drivers/clk/sunxi-ng/ccu_sdm.c
index c564e5f9e610..204e25feaa36 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.c
+++ b/drivers/clk/sunxi-ng/ccu_sdm.c
@@ -18,7 +18,10 @@ bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
 	if (sdm->enable && !(readl(common->base + common->reg) & sdm->enable))
 		return false;
 
-	return !!(readl(common->base + sdm->tuning_reg) & sdm->tuning_enable);
+	if (sdm->pat1_enable && !(readl(common->base + sdm->pat1_reg) & sdm->pat1_enable))
+		return false;
+
+	return !!(readl(common->base + sdm->pat0_reg) & sdm->pat0_enable);
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_is_enabled, "SUNXI_CCU");
 
@@ -37,18 +40,27 @@ void ccu_sdm_helper_enable(struct ccu_common *common,
 	for (i = 0; i < sdm->table_size; i++)
 		if (sdm->table[i].rate == rate)
 			writel(sdm->table[i].pattern,
-			       common->base + sdm->tuning_reg);
+			       common->base + sdm->pat0_reg);
 
 	/* Make sure SDM is enabled */
 	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + sdm->tuning_reg);
-	writel(reg | sdm->tuning_enable, common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
+	writel(reg | sdm->pat0_enable, common->base + sdm->pat0_reg);
 	spin_unlock_irqrestore(common->lock, flags);
 
-	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + common->reg);
-	writel(reg | sdm->enable, common->base + common->reg);
-	spin_unlock_irqrestore(common->lock, flags);
+	if (sdm->enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + common->reg);
+		writel(reg | sdm->enable, common->base + common->reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
+
+	if (sdm->pat1_enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + sdm->pat1_reg);
+		writel(reg | sdm->pat1_enable, common->base + sdm->pat1_reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_enable, "SUNXI_CCU");
 
@@ -61,14 +73,23 @@ void ccu_sdm_helper_disable(struct ccu_common *common,
 	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
 		return;
 
-	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + common->reg);
-	writel(reg & ~sdm->enable, common->base + common->reg);
-	spin_unlock_irqrestore(common->lock, flags);
+	if (sdm->enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + common->reg);
+		writel(reg & ~sdm->enable, common->base + common->reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
+
+	if (sdm->pat1_enable) {
+		spin_lock_irqsave(common->lock, flags);
+		reg = readl(common->base + sdm->pat1_reg);
+		writel(reg & ~sdm->pat1_enable, common->base + sdm->pat1_reg);
+		spin_unlock_irqrestore(common->lock, flags);
+	}
 
 	spin_lock_irqsave(common->lock, flags);
-	reg = readl(common->base + sdm->tuning_reg);
-	writel(reg & ~sdm->tuning_enable, common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
+	writel(reg & ~sdm->pat0_enable, common->base + sdm->pat0_reg);
 	spin_unlock_irqrestore(common->lock, flags);
 }
 EXPORT_SYMBOL_NS_GPL(ccu_sdm_helper_disable, "SUNXI_CCU");
@@ -123,7 +144,7 @@ unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
 	pr_debug("%s: clock is sigma-delta modulated\n",
 		 clk_hw_get_name(&common->hw));
 
-	reg = readl(common->base + sdm->tuning_reg);
+	reg = readl(common->base + sdm->pat0_reg);
 
 	pr_debug("%s: pattern reg is 0x%x",
 		 clk_hw_get_name(&common->hw), reg);
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.h b/drivers/clk/sunxi-ng/ccu_sdm.h
index c1a7159b89c3..c289be28e1b4 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.h
+++ b/drivers/clk/sunxi-ng/ccu_sdm.h
@@ -33,21 +33,31 @@ struct ccu_sdm_internal {
 	u32		table_size;
 	/* early SoCs don't have the SDM enable bit in the PLL register */
 	u32		enable;
-	/* second enable bit in tuning register */
-	u32		tuning_enable;
-	u16		tuning_reg;
+	/* second enable bit in pattern0 register */
+	u32		pat0_enable;
+	u16		pat0_reg;
+	/* on some platforms, the sdm enable bit in pattern1 register */
+	u32		pat1_enable;
+	u16		pat1_reg;
 };
 
-#define _SUNXI_CCU_SDM(_table, _enable,			\
-		       _reg, _reg_enable)		\
-	{						\
-		.table		= _table,		\
-		.table_size	= ARRAY_SIZE(_table),	\
-		.enable		= _enable,		\
-		.tuning_enable	= _reg_enable,		\
-		.tuning_reg	= _reg,			\
+#define __SUNXI_CCU_SDM(_table, _enable, _pat0, _pat0_enable, _pat1, _pat1_enable)	\
+	{								\
+		.table			= _table,			\
+		.table_size		= ARRAY_SIZE(_table),		\
+		.enable			= _enable,			\
+		.pat0_enable		= _pat0_enable,			\
+		.pat0_reg		= _pat0,			\
+		.pat1_enable		= _pat1_enable,			\
+		.pat1_reg		= _pat1,			\
 	}
 
+#define _SUNXI_CCU_SDM(_table, _enable, _pat0, _pat0_enable)	\
+	__SUNXI_CCU_SDM(_table, _enable, _pat0, _pat0_enable, 0, 0)
+
+#define _SUNXI_CCU_SDM_DUAL_PAT(_table, _pat0, _pat0_enable, _pat1, _pat1_enable)	\
+	__SUNXI_CCU_SDM(_table, 0, _pat0, _pat0_enable, _pat1, _pat1_enable)
+
 bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
 			       struct ccu_sdm_internal *sdm);
 void ccu_sdm_helper_enable(struct ccu_common *common,

-- 
2.52.0


