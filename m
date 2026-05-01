Return-Path: <netdev+bounces-283228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOW1GIbO9GkYFQIAu9opvQ
	(envelope-from <netdev+bounces-283228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:02:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D595E4ADDE7
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A03A3083D09
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492E3DCDAE;
	Fri,  1 May 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JOF3DMg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42133DC4B6
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650893; cv=none; b=bHTQtKvGPsV8ZF3DBVs6uPXsErwbGND1hiKSbmYHvYu8XaC8fwBCfa8jP0n7CmgpORwtXJoS25hRZNB4o9sxDOEobh0007Z/E7iIzIdO3Tp6ascxR2qp6s3+aq98XzfPPHEt77B/3Q5lAdQHjVvIDb/IK9Wgd6FKHivB9D0es0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650893; c=relaxed/simple;
	bh=sdVoEALgUHLLwTph3KA4x290Mapqipjj87aWWehudsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsoZ+ktdSv/uKi7mU1VGt3Hcq1djHnAw8WO44b3RYo/dLAgHoWXJ6GIPhDO8cEczVPglBK5/PQlYYfh1XIrOz1oOL9ws0FkIj/FdiIHqkCkPfAX6TjOMfdJERVxx+M7yIfbIHutibPKmaCUD96xswW8F1VGVF2k33MH/GHedxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JOF3DMg8; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a5800772f3so13744106d6.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650891; x=1778255691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RGGmioeApSW4Mpcfugq/UHupyYC8IBT0gCB0CxHGJA=;
        b=JOF3DMg8AnITnSLlbsITV4GJ1SJJXvN9eI9iCkMITDyCW+wnTUiLDdq8H2hw2FvvXG
         7S1HiDJU/lzu2K2f/ojbj2+nWLRfN/tT5I7m5lHza+oUD8hngS2Y/iJQTcvCbTlFSgwR
         OL+OPBVwgma0zHpy10xiFDnrDiFCltTE8VE7VGLNXuYwTtF+QcQA8qUcZCZwfj2JK9pi
         lKJ30zHs18eNlEfs3+MnlxBFZ3jg8dvjcxa1K0z82pDmC+1A1+UHLzQ1V9HgHnzwoUtD
         6yWYAjJ9P5oaRhQPwo1gZde9rjg4jPacD/sdMLQjSjJo32qudwdvDx+YBjQ7sgGbsMPV
         sUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650891; x=1778255691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RGGmioeApSW4Mpcfugq/UHupyYC8IBT0gCB0CxHGJA=;
        b=iqx5wJIUzsMhoa5ZKfK7woGAJTerAxjL98JGi7F4ZwEPikgx/SDeDUcSwnbHTN1XbH
         W5PNpUepCDgv0hZIJNHMo7wu5GNy8Sn+LB6udsgbbs8gXp9KmB6gRU/i7eLWrD6VypoH
         ATLJ/3aJflXUbDAb1Ey29OoWgPKzDfnseuY5jEKjcFb3KkZlUOXKzcyH6BRqM8YXRsZB
         GuKHw5fmgge2BqmN1eMVLSpAL3U4XdEAV/jRMmcivn7KZIs7NGBzCPnBi03l/FYqtEiH
         V0bnsxEbW0N1MALuXKRfEzW/yCg3nLPt2AhjwCQUkdNr2TYk7gGtj1TRtfQzuk10h28/
         PkNw==
X-Forwarded-Encrypted: i=1; AFNElJ+3nzdyECjd6qCRDWQfnLhoRNZzhvSQG8xAEiFxuFpq/IRpYfzwGKV6CTaFk3nX8+Wg6bmkyLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKloKq+3ivJBI77Mtie0h349Y8G15pWKi1AYerC1lQIwb1cSaN
	rHGhHuDhczNEHO76czbY6i5l0YoX5T4IQlHuAGCNavY3KOTZAMMnKT4Dhc/8OP35zlE=
X-Gm-Gg: AeBDieuFnQrbIIwf4T3ZuJ76y36yYus+gwejQdDwKkqPVCdXsPKJGlKXYGg9IslXZL2
	jZ8iEG84kRtueOLJHJabPU00Svj7sdXWmA60CDhd5fnELbdg48pDuKnJzZrhlX19VOxTujFBcLP
	NSetOCkLGGIPyCife0FWaqotx7qXjicOZ5/HpeZhHrO4bMK6PS4PMnnsLGiZ+0fmj7v7PGP/2Gy
	5n5J55SSxk0sJQi0d/B+2waKKIfUwSgpGdVnp46t5cLFkWztgx8a0ah94mBHlAEf5zlVNIWmBxe
	0Dj6qO7UZ5/feTvx9mX1SV6ecmI3zmOy6bvmMU5le/yCIDxZMyuI5Ud4dReGLofyvTxR+mmnlDq
	BSKoBGH4fWTy8G+4pCThxzgA4dyA0KDyywZG56Ta1nGu7HwxrN545SAQgiiw8KKu4rHnpm2HgMf
	AbikyBrThvIP8t7A4lt5g0v7WHzAbCecoHciw0b5uMB2RBAfa1wwnADiRM5xlG7/f1LPW2jmPrX
	SWX3BwWagHuOhvA
X-Received: by 2002:a05:6214:dc3:b0:8b4:6df4:87e8 with SMTP id 6a1803df08f44-8b6699cc88fmr282706d6.49.1777650890881;
        Fri, 01 May 2026 08:54:50 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:50 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/12] net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
Date: Fri,  1 May 2026 10:54:15 -0500
Message-ID: <20260501155421.3329862-8-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D595E4ADDE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283228-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:mid,riscstar.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

From: Daniel Thompson <daniel@riscstar.com>

Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially a
small-and-highly-specialised SoC. Ethernet on this chip is provided
by a DesignWare XGMAC.

One consequence of the SoC-like design is that the internal AXI bus
(used by the XGMAC for DMA) maps the PCI DMA space with a non-zero base
address. This requires a translation step (happily just simple addition)
to convert the PCI DMA address to the hardware DMA address.

This is pretty funky so rather than push that translation logic into
the core driver we intend to keep that logic inside the TC956x
platform code. In order to do that we need to export a few symbols
to allow us to override some of the DMA and descriptor op tables.

FWIW this approach to overriding the ops tables is similar to the
mechanism currently found in dwmac-loongson.c (with the exception
that we have also exported a couple of functions so we don't
have to replicate their content in the TC956x platform code).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h |  7 +++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    |  1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 18 ++++++++++--------
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index bcf59ad8a1939..8cecde1bef8a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -468,4 +468,11 @@ extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
 extern const struct stmmac_dma_ops dwxgmac301_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd505..c9547dc6912a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1556,6 +1556,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_setup);
 
 int dwxlgmac2_setup(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b5f200a874840..cc67d8e1a920a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -368,3 +368,4 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_vlan = dwxgmac2_set_vlan,
 	.set_tbs = dwxgmac2_set_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac210_desc_ops);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dc2897e9931d1..ec365e66276f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -62,10 +62,10 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
 	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
 
-static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan)
 {
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -77,11 +77,11 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_rx_chan);
 
-static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan)
 {
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -93,6 +93,7 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_tx_chan);
 
 static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
@@ -671,3 +672,4 @@ const struct stmmac_dma_ops dwxgmac301_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac301_dma_ops);
-- 
2.51.0


