Return-Path: <netdev+bounces-275828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDqIL4dn1GnptgcAu9opvQ
	(envelope-from <netdev+bounces-275828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF433A8E2D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F3730166F6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DB27CCF0;
	Tue,  7 Apr 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/XT+t2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8042264C7;
	Tue,  7 Apr 2026 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527801; cv=none; b=NhlCIOhXq2vrxpiYwk4zky9dh9qVWrTBT1luCnJQ+OYM5C1PxeUIG3sXdkJz0i5Jh6TZwGuwnoxntzmchKdtFKGaLaKUFRBOSQJncdl7MzBd8TCXEBDkZs4xWseqLuv5busUnuPlGZVqTZlKXJwFYwHb89zBb95mnwsnd/V+KaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527801; c=relaxed/simple;
	bh=l09qNxpZb2Z1OjdsheCfqqB6WqqZEIYEjhtnuPN66eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU7r10X/fGJy3IH2UoOa3jd1J4Ha7E8K6KSJq5iDgCbJWTYlsyYFdAcfdj5Hl4eG147FLIOCDoFiC7udoXQnAGpOBUFIwCVzei3VY8qad9Qt+XHsr4NQmncKUSFxsD2/xbw4sYvYrzvj1Y8gbgAhj+GcMfV6bZk7+k5S9cz3k5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/XT+t2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965B2C2BC9E;
	Tue,  7 Apr 2026 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527801;
	bh=l09qNxpZb2Z1OjdsheCfqqB6WqqZEIYEjhtnuPN66eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/XT+t2dUq4UZUpycoC/TjCJryznGtdzS7KsFBX/zOgT6p/Dyu+gZjCGebF8q1Fsu
	 tRc3uUvMRPSl8hAEGe+1yUuM2rM4yAPo1wvlPy6dRkrt7xS5EAVniNWzawuJT5q57v
	 j2ElEqf7orzMg09jO30j1Bh10HhlVMiHh/oQcS1V/zAw59MJ2LDfLXsJ5wNK2bc88T
	 O6e8KRDP2qyeDnLJW0qagfnBY7YC/XJHzWTKYNUp947c+jndZsiz6lax+fu8i0dZwg
	 nfE9ST9hBXBB1/oEuTje5L2oNyFWaw96a5IRopzwr6d3RMT6tulObgZ5Bne0+G7g0z
	 hYJkTyeJLAh9g==
From: Jakub Kicinski <kuba@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 2/4] net: stmmac: Integrate dw25gmac into hwif handling
Date: Mon,  6 Apr 2026 19:09:58 -0700
Message-ID: <20260407020958.3674568-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402213629.1996133-3-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,foss.st.com,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-275828-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FF433A8E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: Integrate dw25gmac into hwif handling

Integrate dw25gmac support into stmmac hardware interface handling.
Added a new entry to the stmmac_hw table in hwif.c.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 511b0fd5e8343..a69f558c0db06 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -287,6 +287,26 @@ static const struct stmmac_hwif_entry {
>  		.mmc = &dwxgmac_mmc_ops,
>  		.est = &dwmac510_est_ops,
>  		.setup = dwxlgmac2_setup,
> +	}, {
> +		.core_type = DWMAC_CORE_25GMAC,
> +		.min_id = DW25GMAC_CORE_3_20,

Are there other areas where the core capabilities will be misidentified?

Throughout stmmac_main.c and stmmac_ethtool.c, hardware features branch
explicitly on core_type == DWMAC_CORE_XGMAC instead of including
DWMAC_CORE_25GMAC.

This seems to cause a few side effects:
- stmmac_ethtool_get_drvinfo() misreports the driver as MAC100_ETHTOOL_NAME
  (st_mac100).
- stmmac_main.c enforces legacy MTU limits rather than XGMAC_JUMBO_LEN.
- stmmac_dma_cap_show() debugfs output treats the 25GMAC count of multiple
  MAC address registers as a simple boolean and omits Timestamp System Time
  Source details.

Does this also break MDIO communication for the PHY?

In stmmac_mdio_register(), XGMAC MDIO accessors are assigned strictly if
priv->plat->core_type == DWMAC_CORE_XGMAC. Because 25GMAC is omitted, it
falls into the else block and assigns legacy GMAC callbacks like
stmmac_mdio_read_c22().

The GMAC accessors format the control word using GMAC bitfields (checking
MII_ADDR_GBUSY at bit 0), while the XGMAC register layout expects
MII_XGMAC_BUSY at bit 22.

Could this misconfiguration write invalid bit patterns to the register and
wait on the wrong bit?

> +		.regs = {
> +			.ptp_off = PTP_XGMAC_OFFSET,
> +			.mmc_off = MMC_XGMAC_OFFSET,
> +			.est_off = EST_XGMAC_OFFSET,

Will this misconfigure the Time-to-Output Value for EST (802.3 Qbv)?

In stmmac_est.c, est_configure() and est_irq_status() use
if (priv->plat->core_type == DWMAC_CORE_XGMAC) to differentiate XGMAC from
GMAC5.

Without 25GMAC in that check, it falls through to the GMAC5 logic, applying
the EST_GMAC5_PTOV mask (bits 31:24) instead of the EST_XGMAC_PTOV mask
(bits 31:23) to the EST control register at EST_XGMAC_OFFSET.

> +		},
> +		.desc = &dwxgmac210_desc_ops,
> +		.dma = &dw25gmac400_dma_ops,
> +		.mac = &dwxgmac210_ops,

Does adding these ops introduce a buffer overflow during ethtool register
dumps?

Since stmmac_ethtool_get_regs_len() does not match DWMAC_CORE_25GMAC, it
falls back to returning REG_SPACE_SIZE (4192 bytes, or 1048 u32 elements).

However, these ops use the dwxgmac2_dump_regs() and dwxgmac2_dma_dump_regs()
callbacks, which write far beyond the 1048-element buffer:

- dwxgmac2_dump_regs() writes up to index XGMAC_MAC_REGSIZE (1309 elements).
- dwxgmac2_dma_dump_regs() writes from XGMAC_DMA_MODE / 4 (3072) to
  XGMAC_REGSIZE (3647 elements).

Will this corrupt kernel memory when a privileged user runs ethtool -d?

> +		.vlan = &dwxgmac210_vlan_ops,
> +		.hwtimestamp = &stmmac_ptp,
> +		.ptp = &stmmac_ptp_clock_ops,
> +		.mode = NULL,
> +		.tc = &dwmac510_tc_ops,
> +		.mmc = &dwxgmac_mmc_ops,
> +		.est = &dwmac510_est_ops,
> +		.setup = dw25gmac_setup,
> +		.quirks = NULL,
>  	},
>  };

