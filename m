Return-Path: <netdev+bounces-251473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCBtBmdHcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:26:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3D50646
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EAFF86A798
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142EA40F8F2;
	Tue, 20 Jan 2026 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRw1f7ix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC03ECBC8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911595; cv=none; b=rcHWgC7/WVG9bXY2Be+0jf8jBCa2LwtU2UBf497nEbhqOmHafg53XyuTJWAd7WfUp5lebO5+wcTNepeKL3vCNgcShmC7/cpBpz/nyJLMsdDDGfB8Xn4ldEtjSe5yUDYNpmj+RrDAQTRkjKXaU4JfFI+oNS3NnnDMqINkGFR6eFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911595; c=relaxed/simple;
	bh=KTBSdfXEUKlMArRyj8tBM0WQL1ST+WRjytSw3rNonKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggdkIlLJiLnHIS87L7P66BTA1w8M/MqyWDUBAeDFpD44y9hDrQbS1fO/1nJYSEje2yJXXTws0V7P4+VpP7E0OJxdC7lfDxFPpr2fCM/nRnj9MX7dsKweaxQQITvlEqptvfjGlY2nKAIzUCEl4qYfW+R5EP9fyXm/2r8rxkgFHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRw1f7ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5004C16AAE;
	Tue, 20 Jan 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911595;
	bh=KTBSdfXEUKlMArRyj8tBM0WQL1ST+WRjytSw3rNonKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRw1f7ix629iG43InSM0xs95ncXduFZEd6DPsZY1Miz7gyOs4qEnaWuxQzVxZ1p1y
	 CYGqP6hCcZXpyy63N5IGUq8aaLc+K7nJDDu2kIPikUCxw7drXzjNG7znSREUAnZpCq
	 vBUIF+dy0NWNhlF0iHvPwqwAAwgWls69XNv+G4p4NIS/fiIWNPSV4QDhL4QJX1x/V5
	 79V+6gldpcElWCC1VI2LJK8w9/i5PfWVOw4cOOI/smHgqnRHKoEuH1BRUCz9R/ZYwc
	 kV/61fi3DT7KGWZW1w28kj/kAhnjkBqAvFZ+pIvemvSZoShefjJ/48ju7SOzY7IuNV
	 +2ypRcPCsV4nQ==
From: Simon Horman <horms@kernel.org>
To: jacky_chou@aspeedtech.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2,06/15] net: ftgmac100: Use devm_clk_get_enabled
Date: Tue, 20 Jan 2026 12:19:39 +0000
Message-ID: <20260120121939.795771-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116-ftgmac-cleanup-v2-6-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-6-81f41f01f2a8@aspeedtech.com>
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
	TAGGED_FROM(0.00)[bounces-251473-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7CB3D50646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: ftgmac100: Use devm_clk_get_enabled

This patch converts the ftgmac100 driver to use devm_clk_get_enabled()
and devm_clk_get_optional_enabled() to simplify clock management and
cleanup paths.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index ec2e7ec23ddf..ffd86655bcc8 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1801,13 +1801,10 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
>  	struct clk *clk;
>  	int rc;
>
> -	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
> +	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  	priv->clk = clk;
> -	rc = clk_prepare_enable(priv->clk);
> -	if (rc)
> -		return rc;
>
>  	/* Aspeed specifies a 100MHz clock is required for up to
>  	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
> @@ -1816,21 +1813,15 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
>  	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
>  			  FTGMAC_100MHZ);
>  	if (rc)
> -		goto cleanup_clk;
> +		return rc;
>
>  	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
>  	 * necessary if it's the AST2400 MAC, or the MAC is configured for
>  	 * RGMII, or the controller is not an ASPEED-based controller.
>  	 */
> -	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
> -	rc = clk_prepare_enable(priv->rclk);
> -	if (!rc)
> -		return 0;
> +	priv->rclk = devm_clk_get_optional_enabled(priv->dev, "RCLK");
>
> -cleanup_clk:
> -	clk_disable_unprepare(priv->clk);
> -
> -	return rc;
> +	return 0;
>  }

Should the return value of devm_clk_get_optional_enabled() be checked
here? The old code would fail probe if RCLK existed but
clk_prepare_enable() failed. The new code unconditionally returns 0,
ignoring any potential error from devm_clk_get_optional_enabled().

Looking at other drivers using this API, most check for IS_ERR(). For
example, cctrng_probe() in drivers/char/hw_random/cctrng.c does:

    drvdata->clk = devm_clk_get_optional_enabled(dev, NULL);
    if (IS_ERR(drvdata->clk))
        return dev_err_probe(...);

While the clock is optional (may not exist), if it does exist but fails
to enable, this seems like a condition that should cause probe to fail
rather than succeed silently?

[ ... ]
-- 
pw-bot: changes-requested

