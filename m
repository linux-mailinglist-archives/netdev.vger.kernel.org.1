Return-Path: <netdev+bounces-251472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EeyJjc1cGlzXAAAu9opvQ
	(envelope-from <netdev+bounces-251472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:08:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4729D4F84C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A18ED4E7CF2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E73E8C71;
	Tue, 20 Jan 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPd4ads8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5E3D300C
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911258; cv=none; b=jPeoyZokFDqLtkcD/iL97yERXE90QhQ5usHCcmgexUct8O1fyP1nX4qFOFxjriCDYp48DivLwLtkRxfeZXuIp1nq1GWbFjncW119UhTTAKawL/LtiNSOEiQT8KhuKFFWnt7IzdPbV4l49q/VYiVI18W1Y+1iGiupYW9dAMzUZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911258; c=relaxed/simple;
	bh=xiGkLG1S5yh27n0ezgnAOnPmBrVklu1Dv+Lxsab2jh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nus7fXojHqGPMSRVsi9I9w9m187gx9k63YvFb33AzObvZQmlMq6uXs1+yV7tInxDdDZp4tYln5c32Yq+7bTmh6/TbO3B2MaWAUzSIFiVlp6j+552wKu08dxBX76hFoi1ZFC/WvMaby9au5LAkFeH5oUo1KGpcvtQBVemy2jXYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPd4ads8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A1AC16AAE;
	Tue, 20 Jan 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911257;
	bh=xiGkLG1S5yh27n0ezgnAOnPmBrVklu1Dv+Lxsab2jh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPd4ads8VuCmpCOtHdTO7DBKJNTrRGgvZyjwJMr3awXSwU0r7rtPvZL5+pskvwX9r
	 y1JPB+uJrBmoX4UDUznCjoqJ9QnOYPYPPgvW4lWqWz9TdmNqtodFxUKtECKMeCJR1M
	 1UbIH1+fzCDZ/+8/UwKXVs+ozj9R1OXKjKARO/daF8e49KF2wo3Ew797mrSqcBZaCx
	 NYqOtJwYo8kBiO3AiZG/7l1fM/DmLUjTDS5y94oBNhxc1Nm+uBrqDXKyLy6R7D9QLG
	 A0Px3ATR+WnDGRnggJHivln0mlqONNN8uHWGT5S/q+qjB3OhxkjQhG3ZXYkJ9jBRf9
	 9ARp3x1F6dlaw==
From: Simon Horman <horms@kernel.org>
To: jacky_chou@aspeedtech.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus when it exists
Date: Tue, 20 Jan 2026 12:14:07 +0000
Message-ID: <20260120121407.795529-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 4729D4F84C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/ai-review.html
---
net: ftgmac100: Always register the MDIO bus when it exists

This patch moves MDIO bus registration earlier in the probe function
for FARADAY, AST2400, and AST2500 MACs, simplifying the code by
registering it unconditionally when the hardware has an MDIO controller.

Note: These issues appear to be fixed later in the series by commits
8961daa5f2c0 ("Simplify error handling for ftgmac100_setup_mdio") and
046e51399f0f ("Move DT probe into a helper").

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index f1cb5dc37919..931fdf3d07d1 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1957,6 +1957,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  		priv->txdes0_edotr_mask = BIT(15);
>  	}
>
> +	if (priv->mac_id == FTGMAC100_FARADAY ||
> +	    priv->mac_id == FTGMAC100_AST2400 ||
> +	    priv->mac_id == FTGMAC100_AST2500) {
> +		err = ftgmac100_setup_mdio(netdev);
> +		if (err)
> +			goto err_phy_connect;
> +	}

If ftgmac100_setup_mdio() fails after of_mdiobus_register() returns an
error, it calls mdiobus_free(priv->mii_bus) but does not set priv->mii_bus
to NULL. The goto err_phy_connect then leads to ftgmac100_destroy_mdio()
which checks if (!priv->mii_bus) but finds a dangling pointer, resulting
in mdiobus_unregister() on freed memory followed by a double free.

Could this cause a use-after-free and double-free when MDIO registration
fails? The error path in ftgmac100_setup_mdio() frees mii_bus without
clearing the pointer, and err_phy_connect eventually calls
ftgmac100_destroy_mdio() which operates on the stale pointer.

> +
> +	if (np && of_get_property(np, "use-ncsi", NULL)) {
> +		err = ftgmac100_probe_ncsi(netdev, priv, pdev);
> +		if (err)
> +			goto err_setup_mdio;

Since MDIO is now set up before the NCSI probe for FARADAY/AST2400/AST2500,
if ftgmac100_probe_ncsi() fails, the goto err_setup_mdio skips the MDIO
cleanup at ftgmac100_destroy_mdio(). Does this leak the mii_bus allocation
when NCSI probe fails on these MAC variants?

[ ... ]
-- 
pw-bot: changes-requested

This is an AI-generated review. Report issues at https://example.com

