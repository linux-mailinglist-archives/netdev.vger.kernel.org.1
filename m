Return-Path: <netdev+bounces-283038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEzLNtf182ne9AEAu9opvQ
	(envelope-from <netdev+bounces-283038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 02:37:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39734A93C3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0C713006922
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E79233722;
	Fri,  1 May 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPxRUb2A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372622652D;
	Fri,  1 May 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777595857; cv=none; b=NKUNUPfz5fqHQE16NKSnAtOVK3cNM8v8QFGM6sXpRFImY+jjwEYBkv28rmp+peyTMnh5XBdMPhWifO6kvO3ywe5XQGIe6zTvj6ZRXITfvZwET+nd1q/P9S5zckTZnt47Estv074AiUWQhL8/DtiLzzROqH7wp2hMWw/5gTGyCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777595857; c=relaxed/simple;
	bh=AMSmLpDFO5M47bJSS+6rh5+c+dU3Tgm4kdfrwRVJMIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZr/SX1dT8QufRmTSC7oKBeW+gnj1jXym0qnihbrsnucYbamtme4XC5W9xOj1yfHefdYwfhJxeUTxugZgyoG8iikG4FrSaD1r2nFoAlLyOcWzSlogm4soQmm3Z3D408Jgon3wUnJW4l+YHDb1Tk6YiygVWQjpu5IEed3Ka3KC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPxRUb2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF0CC2BCB3;
	Fri,  1 May 2026 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777595857;
	bh=AMSmLpDFO5M47bJSS+6rh5+c+dU3Tgm4kdfrwRVJMIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPxRUb2AW0BDZgMg+ojwZVgu0K+tQhU6vfY6z01z1n1zCd9emltjDTQUGJHyKHcsb
	 tqX40ssrytesCFvxOD93O4qh74VeVkzDv7ZIgBUNeNvrP9VLdAUSgiI8USMZL+26WR
	 feHZVzwvrCkZnA/E5XRxk1ZMlHEIh/E2YHscKQSKGXpkHZhd46Et5IImGBuDi6+mVm
	 LhdR6wzWUnPRx1b4U3R4ReizXybdVhaKYLvzHYJKnERIlLijNtdw82WHeT5WMIN5q8
	 6geVhoedKs4dW/645B8i6lL3Pw3YlgGblrMJSqr5N619sEpkFRVJGX59P1HZNYoh+9
	 HghTw7ymM9GqA==
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Use interrupt mode INTM=1 for per channel irq
Date: Thu, 30 Apr 2026 17:37:35 -0700
Message-ID: <20260501003735.3120766-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429062428.18438-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260429062428.18438-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F39734A93C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: Use interrupt mode INTM=1 for per channel irq

This commit adds programming of the XGMAC DMA_MODE.INTM=1 bit on xgmac2
to deliver per-channel TX/RX interrupts via shared peripheral interrupts
(SPI), mirroring the approach of the earlier MSI-oriented commit
6ccf12ae111e. New fields are added to stmmac_dma_cfg and
plat_stmmacenet_data to drive the new path.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b0..94cbf24b3118 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -320,6 +320,9 @@
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
>  #define XGMAC_SWR			BIT(0)
> +#define DMA_MODE_INTM_MASK		GENMASK(13, 12)
> +#define DMA_MODE_INTM_SHIFT		12
> +#define DMA_MODE_INTM_MODE1		0x1

Should these three macros carry the XGMAC_ prefix used by every other
symbol in dwxgmac2.h (XGMAC_DMA_MODE, XGMAC_SWR, XGMAC_DMA_SYSBUS_MODE,
and so on)?  The dwmac4 sibling header defines analogous symbols as
DMA_BUS_MODE_INTM_MASK / DMA_BUS_MODE_INTM_MODE1, but within dwxgmac2.h
the established convention appears to be XGMAC_*.

The referenced precedent commit 6ccf12ae111e uses FIELD_PREP() /
u32_replace_bits() rather than a hand-rolled SHIFT constant.  Would it
be cleaner to drop DMA_MODE_INTM_SHIFT and use FIELD_PREP() here too?

>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
>  #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 03437f1cf3df..3789b62cd2e3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->multi_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~DMA_MODE_INTM_MASK;
> +		value |= (DMA_MODE_INTM_MODE1 << DMA_MODE_INTM_SHIFT);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }

Is this new block reachable on any platform?

A tree-wide search for multi_irq_en returns only three references: this
read site and the two struct declarations added below.  Nothing assigns
dma_cfg->multi_irq_en anywhere, so the condition appears to always be
false and INTM=1 would never be programmed.

For comparison, the analogous multi_msi_en is set up in stmmac_main.c:

    priv->plat->dma_cfg->multi_msi_en =
            (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);

and is consumed from glue drivers such as dwmac-intel.c, dwmac-loongson.c,
and dwmac-s32.c.  Should an equivalent assignment and a corresponding
plat flag (or the new plat->multi_irq_en field) be wired up in this
patch so the feature actually takes effect?

The commit message also states:

    The TX/RX NORMAL interrupt check is decoupled since the NIS bit is
    not asserted for TI/RI events when INTM=1.

but the diff touches only dwxgmac2_dma_init() and does not modify
dwxgmac2_dma_interrupt() or any other ISR/interrupt-status path.  The
existing dwxgmac2_dma_interrupt() already tests XGMAC_RI and
XGMAC_TI | XGMAC_TBU independently of XGMAC_NIS:

    if (likely(intr_status & XGMAC_RI)) {
            ...
    }
    if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
            ...
    }

Is this paragraph carried over from the earlier dwmac4 commit
6ccf12ae111e, or is a companion hunk missing from this patch?

>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 4430b967abde..5deaa1a797a5 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -122,6 +122,7 @@ struct stmmac_dma_cfg {
>  	bool eame;
>  	/* multi_msi_en: stmmac core internal */
>  	bool multi_msi_en;
> +	bool multi_irq_en;
>  	/* atds: stmmac core internal */
>  	bool atds;
>  };
> @@ -349,6 +350,11 @@ struct plat_stmmacenet_data {
>  	u8 vlan_fail_q;
>  	bool provide_bus_info;
>  	int int_snapshot_num;
> +	int ext_snapshot_num;
> +	bool int_snapshot_en;
> +	bool ext_snapshot_en;
> +	bool multi_msi_en;
> +	bool multi_irq_en;
>  	int msi_mac_vec;
>  	int msi_wol_vec;
>  	int msi_sfty_ce_vec;

Are these five new plat_stmmacenet_data fields used by anything?

A tree-wide search finds no reader or writer for ext_snapshot_num,
int_snapshot_en, ext_snapshot_en, plat->multi_msi_en, or
plat->multi_irq_en, and they are not mentioned in the commit message.
The commit message scope is limited to enabling INTM=1 per-channel SPI
IRQs, which would only require stmmac_dma_cfg::multi_irq_en.

The same concepts already appear to be represented via plat->flags bits
(STMMAC_FLAG_MULTI_MSI_EN, STMMAC_FLAG_INT_SNAPSHOT_EN,
STMMAC_FLAG_EXT_SNAPSHOT_EN) and the existing int_snapshot_num member.
Could the four unrelated fields be dropped from this patch and, if
still needed, be introduced in a separate series that actually wires
them up?  Having both a flags bit and a bool for the same concept
risks future drift about which representation is authoritative.
-- 
pw-bot: cr

