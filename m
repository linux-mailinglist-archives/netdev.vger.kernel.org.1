Return-Path: <netdev+bounces-260838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOviKKvBnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052B195084
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB59302866E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3238E120;
	Wed, 25 Feb 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJXxxlHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF638759D;
	Wed, 25 Feb 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011522; cv=none; b=rmAKFAlc3FV5FhskqnAl/UiQFVmQAkONUVbwi8Y0izmlN4KczugUxfACAUnNOhWUSMkPvPhb9/yMRjL8Efl7Ys7Q962Hfld1O/CgSMxY5eNLGk3z2clxFZt7fQkZgQ/o5Mjutq00cI1LGzQHS0VUpsgTQmXEEz0gVfr5Bghdf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011522; c=relaxed/simple;
	bh=3F7Z5Pfj8Pt/optjPDV9G8Xvyryo9NuHarxp+2EdQZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEyHQFMdKByNwgclp+gwk7Yt3QSPo3FIg8Ok0rBT+1eAKz6Glnn1LnlUasub7ndmzPCM8RIVWtJ8lDiFe8AkyBBknSt2DcNCjxBajzoFUquPzJApzZY2S74KwKcqGSKbuYt9T/GU1ZZtbHH7S08I3ubiydiH/TZU3PZWQFIT4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJXxxlHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE0C2BC86;
	Wed, 25 Feb 2026 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772011522;
	bh=3F7Z5Pfj8Pt/optjPDV9G8Xvyryo9NuHarxp+2EdQZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJXxxlHBV0DRrSf9EXAEusXlJPeHnoT0EXFvLsrldQu/5D1nC+cn49GEzCZn5mSbM
	 A/xtGjS6xvWhP74lBLA/DVb/a4R6aeCiawcKj3TaGKNHT/TXw8XSi16nLSzWcQlnis
	 v0m+TCnAHsyPXyt2AknbqUGNEyD6LZYPnXc76KzrSaqQiZhlkwECxt+w/6vM3LLfHp
	 khpI2max/MI8mlIiNJLbDhcnYr2sSLHsuQBluXaRBJHXwNwXKsHHqzTo30n1Yu2Ss+
	 qSurO9g1H5v2Zq3H06S6xZDG61BdabR3sXwIssrYT/w6bZq7HIzDkIaA3SmP20SxVt
	 Lug+csEN4rnXw==
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
Subject: Re: [v5,4/4] stmmac: s32: enable support for Multi-IRQ mode
Date: Wed, 25 Feb 2026 09:25:13 +0000
Message-ID: <20260225092513.174261-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223-dwmac_multi_irq-v5-4-8fc699a5fac4@oss.nxp.com>
References: <20260223-dwmac_multi_irq-v5-4-8fc699a5fac4@oss.nxp.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,vger.kernel.org,gmail.com,pengutronix.de,lists.infradead.org,davemloft.net,suse.com,lunn.ch,nxp.com,redhat.com,st-md-mailman.stormreply.com,oss.nxp.com,google.com,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-260838-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2052B195084
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
stmmac: s32: enable support for Multi-IRQ mode

This commit enables Multi-IRQ mode for the S32 DWMAC driver, allowing
per-queue IRQs for improved performance. The driver checks for multiple
queues and per-queue IRQs, enabling multi-IRQ mode when both are present.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index af594a096676..4aad7077c9d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c

[ ... ]

> @@ -165,6 +165,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  	plat->core_type = DWMAC_CORE_GMAC4;
>  	plat->pmt = 1;
>  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> +
> +	/* Check for multi-IRQ config. Assumption: symmetrical rx/tx queues */
> +	if (plat->rx_queues_to_use > 1 &&
> +	    (res.rx_irq[0] > 0 && res.tx_irq[0] > 0)) {
> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +		dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
> +	} else {
> +		dev_info(dev, "MAC IRQ mode selected\n");
> +	}

Does this validation check all queues have IRQs? The condition verifies
only res.rx_irq[0] and res.tx_irq[0] but doesn't confirm that higher
queues have IRQs when rx_queues_to_use > 1.

If a device tree specifies multiple queues but only provides IRQs for
queue 0:

    snps,rx-queues-to-use = <2>;
    interrupt-names = "macirq", "rx-queue-0", "tx-queue-0";
                      /* queue 1 IRQs missing */

The driver would enable STMMAC_FLAG_MULTI_MSI_EN, but later in
stmmac_request_irq_multi_msi() (drivers/net/ethernet/stmicro/stmmac/
stmmac_main.c), queues with rx_irq[i] == 0 are silently skipped:

    for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
        if (priv->rx_irq[i] <= 0)
            continue;  /* queue 1+ skipped, no handler registered */
        ...
    }

This would leave higher-numbered queues with no interrupt handler,
causing packet loss when traffic arrives on those queues.

Would it be safer to validate all queue IRQs before enabling multi-IRQ
mode, or fall back to MAC IRQ mode if any queue IRQ is missing?

> +
>  	plat->rx_fifo_size = 20480;
>  	plat->tx_fifo_size = 20480;

