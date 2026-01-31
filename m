Return-Path: <netdev+bounces-255310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5rBqFdZffWn3RgIAu9opvQ
	(envelope-from <netdev+bounces-255310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:50:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A8BC01A9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A7BC300C004
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F1318BB0;
	Sat, 31 Jan 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLN628Bx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D3DDAB;
	Sat, 31 Jan 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824211; cv=none; b=fR8XaH2KdssCVgYnPxFw8Jihc5IHTbnAB5fEY+uFDkhjcug3KmxK1VWHZe/iGORbrIDirFmvV/jxClpOT3Opbntp5poajW5FS1dYkOhIlmZJUT1e5f924ko83Nc8eTdNsepCfil4iqcOJq9868dA5buUNOKepSZAGa3fRuggTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824211; c=relaxed/simple;
	bh=yZ2ydlBeIEM1kguh/UCzdsK/jkpYCuJzFCaodPIBfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOIamdpGA0hWh/GHBRx4DMl7Lor17i40OES4PG74zDlkDQrsKuo6drOR9jFL3oL1iZvb3gku0ou4N/8TLcuwqBBihguY/gSA5TkiZXNvSih1QD43vhq+2rxRtGn3pzj1r9xaWAsO79/GSNowZteYBHQUzfkvXD4hfbgYi+rVDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLN628Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07668C4CEF7;
	Sat, 31 Jan 2026 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824211;
	bh=yZ2ydlBeIEM1kguh/UCzdsK/jkpYCuJzFCaodPIBfF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLN628BxXGuoHL9Qtmsod7rQPNY34dyHhFXsPj7T2VvVclMks14q8oXxR8pt0zc0A
	 nOfqTI/JVn/lkuhuAAH0dG/qVsAPEk1RbDcePZvbV9u2+MWc2wlQhutVrC1Upwn2VA
	 G1xyGz0UGUOYigVRwkTTR1GrS4nac8TLelDxZrzYaqwfirmUr04JK67qwmf+lbYyDQ
	 HInljldRdfEyrR31FcyuwXxPy3ltyp5vsKGD+VkEjWy4Ac/pd49EbyTmtuXXIH7dNK
	 SKnRh45SZ9QYkRfdSzFc1KReVFwxuKnVizP7I/TAyuDNqHsFO5SmN+8s9UNHtrIhiA
	 MOtJ51o1b9MfA==
From: Jakub Kicinski <kuba@kernel.org>
To: a0987203069@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	ychuang3@nuvoton.com,
	andrew+netdev@lunn.ch,
	linux-stm32@st-md-mailman.stormreply.com,
	yclu4@nuvoton.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	andrew@lunn.ch,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	krzk+dt@kernel.org,
	edumazet@google.com,
	robh@kernel.org,
	schung@nuvoton.com,
	netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Subject: Re: [net-next,v10,3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
Date: Fri, 30 Jan 2026 17:50:08 -0800
Message-ID: <20260131015008.970729-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129054445.416242-4-a0987203069@gmail.com>
References: <20260129054445.416242-4-a0987203069@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,nuvoton.com,lunn.ch,st-md-mailman.stormreply.com,redhat.com,davemloft.net,st.com,synopsys.com,gmail.com,google.com,foss.st.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5A8BC01A9
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family

Adds Gigabit Ethernet support for Nuvoton MA35 series SoCs using
the stmmac driver framework.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

[ ... ]

> +static struct nvt_priv_data *
> +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nvt_priv_data *bsp_priv;

[ ... ]

> +	bsp_priv->regmap =
> +		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
> +	if (IS_ERR(bsp_priv->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(bsp_priv->regmap), "Failed to get sys register\n");
> +		return ERR_PTR(-ENODEV);
                           ^^^^^^

Should this propagate the actual error code from
syscon_regmap_lookup_by_phandle_args() instead of always returning
-ENODEV? If the syscon lookup returns -EPROBE_DEFER, this will lose
that error code and prevent the driver from properly deferring its
probe when dependencies aren't ready yet.

Other dwmac drivers (dwmac-loongson1, dwmac-starfive, dwmac-sun8i) use
something like:

    return dev_err_probe(dev, PTR_ERR(regmap), "...\n");

or

    return PTR_ERR(regmap);

to propagate the error.

> +	}

[ ... ]
-- 
pw-bot: cr

