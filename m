Return-Path: <netdev+bounces-232519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFFC062EB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859591B873F1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC762E7652;
	Fri, 24 Oct 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JllN/EZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9E1DB127;
	Fri, 24 Oct 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307931; cv=none; b=e8YQ5LJKdFr0C1AsrTRbRXaexhnS2bTFXSy1evlwlcAjQG5LDDXmvnw2zgoWCSmgxNxuTdHf6ADy2qiqb3yh1O6ym24neJrNNa0gJs6LFikqGU18/UEs2cb3fey7JRYX/UWk44J0HDvH9sjtmn9LSvKFi7At6asbB4JdV591JBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307931; c=relaxed/simple;
	bh=/zFFutCPy+n8j87wgq9tHUe0ADsqAV6k9QBgeuL8/0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3xGvqGjAG+8CAqccQHJ8vM+4JW+7AY19K7TjGRR3VAHFrWh0xfP4a8jyqBRjmi906ZN53Y/4yw9NmjyqmxKblKoBVxbo7/ZlokwNUupVxzVFF/ROdCD58038trBYuPX+PT2QXwUYtdb3m52bxm5EOrfCYtpf5ek69SBtJRmEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JllN/EZ/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CBA701A1648;
	Fri, 24 Oct 2025 12:12:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BBC060703;
	Fri, 24 Oct 2025 12:12:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 337CE102F248D;
	Fri, 24 Oct 2025 14:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761307920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JEt/kqGoBRuvo1mSCkAMwChIUVantu5YXampMxAZaZY=;
	b=JllN/EZ/YRLRi+nQ0w7t9ZcaWf1s409bOeKeWf7oYmIbrP/q6TGYFlW4m8WAQ6Nn/EhOt6
	EeJFLluQLB/IQYHO1BxyBTNjXyOXt1abGjxziSrwMJBihy4k9eclU5c8qCDN/9/4VDvHsV
	tyGnQnSP8t8s09/YzWXdsFJMbcivhgXrt1qsPvgF/1fk7bn9VcT+kQgywQ72DOXzErUFKT
	E1cGoTWkUDSx8yYo/xysPbJ+5ISMb76ttfwNCgexU+f5iPXHEd64/I1Z7GttAb5JOm9foI
	nKQWZZbJ0sGGsF0QfVjISMt/t8JnFpedYJRFSrTwUJXYAG6mfCcn3ypxj7reew==
Message-ID: <92e953b8-4581-4647-8173-6c7fa05a7895@bootlin.com>
Date: Fri, 24 Oct 2025 14:11:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] net: stmmac: dwmac-socfpga: don't set has_gmac
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-1-4c4a51159eeb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Steffen

On 24/10/2025 13:49, Steffen Trumtrar wrote:
> Instead of setting the has_gmac or has_xgmac fields, let
> stmmac_probe_config_dt()) fill these fields according to the more
> generic compatibles.
> 
> Without setting the has_xgmac/has_gmac field correctly, even basic
> functions will fail, because the register offsets are different.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 354f01184e6cc..7ed125dcc73ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -497,7 +497,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>  	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>  	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
> -	plat_dat->has_gmac = true;

Note that this field is now gone as per :

  26ab9830beab ("net: stmmac: replace has_xxxx with core_type")

You'll need to rebase the series :)

Maxime


>  
>  	plat_dat->riwt_off = 1;
>  
> 


