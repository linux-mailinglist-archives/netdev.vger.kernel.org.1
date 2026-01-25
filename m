Return-Path: <netdev+bounces-253233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I7ZIbOVdmlCSgEAu9opvQ
	(envelope-from <netdev+bounces-253233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:14:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E192E82A33
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904E030048CE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEB30DEBB;
	Sun, 25 Jan 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6akJgre"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B13090C9;
	Sun, 25 Jan 2026 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379248; cv=none; b=OIuc27wEfTDTginLE7l+5G4p0bDZvQj5CuOt1rsfQHihRhUyMjeetD6Ptvl2qolL0lyacM5jkCdQ98jMwPT3EQy21GsKfovex30iCzhQ8FOd4BQkNzvQpZzmJTKLM2u03zbrwJyKrcQFe10kekMLC+HsG9pLp/moDGHeQsYf2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379248; c=relaxed/simple;
	bh=iZlQMjT87MAKVDpNXN3PnkGFzV2iu5aW29TTIBiz4LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTgWM+KE4VPoRSNaYVoGjiJs3fRK5KfhLqXS1jaixddlIbWNJ5OrCHB/zfB0LCLOLvMHrUpLX2XIkZ6Ogbo6Dczadkc5V5uJuAC4jWRLGtVeDCeQULSnIPlhFqzeCnGA4DZBTAhcMD2D455aHLVwx8Tw5Rj/lJV7eTyDyzLMEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6akJgre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED55EC4CEF1;
	Sun, 25 Jan 2026 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379247;
	bh=iZlQMjT87MAKVDpNXN3PnkGFzV2iu5aW29TTIBiz4LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6akJgre43BvTHV/oVpuun6heVrwS1teSyBWH6FuCNcPiuDiEFO1PgpjDWyLdqP8N
	 QOsluSCZROsPBl5eVixeH74A1gNrAVod6jue+z9olPAMdcM6v7L2iSrq5h1cH8v+52
	 6XUIosoZiM4ohYRhYXi2143dPv+iUUh2syQRhIbAJx5NOkLnNCVfklF1UNtAqQ50kS
	 D6bIljup//yXFN3doJv8I4aRgDuvNMdEjZJKQ8s4WFqcLSzfu59UkUrrqWYXtIuQtr
	 SMQP64HzuOLGlgr2mhNknQFPUmOw+okgeif9F50vg+UrLJCvKw8pS3r53domFjqAI4
	 x9N3q6FO5pbdA==
From: Jakub Kicinski <kuba@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	robh@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com,
	kernel@pengutronix.de,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	chester62515@gmail.com,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	festevam@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	krzk+dt@kernel.org,
	mbrugger@suse.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [v3,4/4] stmmac: s32: enable support for Multi-IRQ mode
Date: Sun, 25 Jan 2026 14:14:05 -0800
Message-ID: <20260125221405.3395497-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123-dwmac_multi_irq-v3-4-cc53f2be8961@oss.nxp.com>
References: <20260123-dwmac_multi_irq-v3-4-cc53f2be8961@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,gmail.com,redhat.com,google.com,lunn.ch,nxp.com,oss.nxp.com,foss.st.com,davemloft.net,suse.com,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-253233-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: E192E82A33
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
stmmac: s32: enable support for Multi-IRQ mode

This patch enables Multi-IRQ mode for the S32 DWMAC driver when both
multi-queue and per-queue IRQs are configured. The driver now selects
between Multi-IRQ and MAC IRQ modes based on device tree configuration.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..342091045714 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c

[ ... ]

> @@ -149,6 +149,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  	plat->core_type = DWMAC_CORE_GMAC4;
>  	plat->pmt = 1;
>  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> +
> +	/* Check for multi-IRQ config. Assumption: symetrical rx/tx queues */
> +	if (plat->rx_queues_to_use > 1 &&
> +	    (res.rx_irq[0] >= 0 || res.tx_irq[0] >= 0)) {
                        ^^^^            ^^^^

Should these checks be "> 0" instead of ">= 0"?

stmmac_get_platform_resources() initializes the res structure with
memset(0), then only writes positive IRQ values when per-queue IRQs are
found in the device tree. If no "rx-queue-0" or "tx-queue-0" interrupt
names are defined, rx_irq[0] and tx_irq[0] remain 0 from the memset.

Since 0 >= 0 evaluates to true, this condition will enable Multi-IRQ
mode even when no per-queue IRQs are available. The commit message states
that "queue based IRQs are set" is a prerequisite, but the current check
does not properly verify this.

> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +		dev_info(dev, "Multi-IRQ mode (per queue IRQ) selected\n");

[ ... ]
-- 
pw-bot: cr

