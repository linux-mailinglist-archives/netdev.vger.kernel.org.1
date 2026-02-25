Return-Path: <netdev+bounces-260837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBVsEUjAnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:26:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD91194F0F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A27A3010143
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEE38E5C4;
	Wed, 25 Feb 2026 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlFU4BBW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD23EA90;
	Wed, 25 Feb 2026 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011513; cv=none; b=E9jCUviu7oPM8aPtSEKhL8dui5VN2622yTE7D7q1A/EvdSNarST6NtokTtZZLgfMV87SLdhzhEvsrMBw/p4ELzcoJKuunGIAQq7NdWENi4RTgzPpjp8CWgY1NnEI7O2eDO4vg/psddQX18BMMpbC2YdDo8Idso9g4dYNhehgJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011513; c=relaxed/simple;
	bh=NVl0XIW72KAhGvaPeyo/7NTd/1b/tlHpMZEcCiTlegM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZf4Jhl40ejVum3UdtZg+gX23MC7BIFVKPnfJSRQP+Y/jy4tB7bTAdt4K9PhHuCE2e4ASwInjf4R4GSuwTy2vvZ5RjaEq3ws6z4uF1klGaWjOlI1cFDwhLGlGSfMJGOh4xxK5c7QUBhhqZ25mQFCEozII8/oaUdfbSz5RPDV4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlFU4BBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C5DC19422;
	Wed, 25 Feb 2026 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772011512;
	bh=NVl0XIW72KAhGvaPeyo/7NTd/1b/tlHpMZEcCiTlegM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlFU4BBWC1HPasx276GWqfaq/QOBboToGp0pvjjvuj1GJAEAIP1IVxHdQ229N1nJ1
	 cH5zb92QVL+SPBmBIzFGM17hk4NsxeQg+eQvsCCb01wQ7FZ0mNNmZu9pT5aRUWaJqT
	 7beomQPmrFZFEHjyuOGfgbeKw2a9KjIorAW2fSboKnnUwoWy1c7JacDG4JYhV80+1w
	 U07ANgmSqXtfa0TkFaPk3mq4GYWLh4DeBO18ffsWZsqR4xlFTV47rAtd/1kxZIQQGT
	 hMfuqOW4kbN1o4c/c5499KlPCxm//TtzFnfmgIZdm/1TvJBxwgG9hsb/hpQJyMe45g
	 shnTEi0SQ4oTQ==
From: Simon Horman <horms@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Simon Horman <horms@kernel.org>,
	alexandre.torgue@foss.st.com,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	chester62515@gmail.com,
	s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	davem@davemloft.net,
	mbrugger@suse.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	s32@nxp.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	robh@kernel.org,
	kuba@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	ghennadi.procopciuc@oss.nxp.com,
	kernel@pengutronix.de,
	shawnguo@kernel.org,
	edumazet@google.com,
	mcoquelin.stm32@gmail.com,
	imx@lists.linux.dev
Subject: Re: [v5,1/4] net: stmmac: platform: read channels irq
Date: Wed, 25 Feb 2026 09:24:56 +0000
Message-ID: <20260225092456.174241-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223-dwmac_multi_irq-v5-1-8fc699a5fac4@oss.nxp.com>
References: <20260223-dwmac_multi_irq-v5-1-8fc699a5fac4@oss.nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,vger.kernel.org,gmail.com,pengutronix.de,lists.infradead.org,davemloft.net,suse.com,lunn.ch,nxp.com,redhat.com,st-md-mailman.stormreply.com,oss.nxp.com,google.com,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-260837-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.954];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9CD91194F0F
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: platform: read channels irq

This commit adds support for reading IRQ resources for all rx/tx channels
in the stmmac platform driver to enable Multi-IRQ mode for platform glue
drivers.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 5c9fd91a1db9..6166a9b0c0bb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -700,6 +700,9 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	char name[16];
> +	int i;
> +
>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -735,7 +738,42 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>
> -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> +	if (IS_ERR(stmmac_res->addr))
> +		return PTR_ERR(stmmac_res->addr);
> +
> +	/* RX channels irq */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		scnprintf(name, sizeof(name), "rx-queue-%d", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev,
> +									 name);
> +		if (stmmac_res->rx_irq[i] <= 0) {
> +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_dbg(&pdev->dev, "IRQ rx-queue-%d not found\n", i);
> +
> +			/* Stop on first unset rx-queue-%i property member */
> +			stmmac_res->rx_irq[i] = 0;
> +			break;
> +		}
> +	}
> +
> +	/* TX channels irq */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		scnprintf(name, sizeof(name), "tx-queue-%d", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev,
> +									 name);
> +		if (stmmac_res->tx_irq[i] <= 0) {
> +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_dbg(&pdev->dev, "IRQ tx-queue-%d not found\n", i);
> +
> +			/* Stop on first unset tx-queue-%i property member */
> +			stmmac_res->tx_irq[i] = 0;
> +			break;
> +		}
> +	}

This isn't a bug, but the RX and TX channel IRQ handling blocks follow an
identical 14-line pattern that differs only in the queue name format string
and target array. Both blocks format the IRQ name with scnprintf(), call
platform_get_irq_byname_optional(), check for -EPROBE_DEFER, log a debug
message on error, and break on the first missing IRQ.

Could this duplication be reduced with a helper function? Note that the
existing code in this function already contains similar non-factored
patterns for wol_irq and sfty_irq handling, so this level of duplication
may be acceptable in this file's style.

> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);

