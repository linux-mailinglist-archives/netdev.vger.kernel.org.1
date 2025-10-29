Return-Path: <netdev+bounces-234140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F4C1D1DA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AC318882C2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDEB26D4F7;
	Wed, 29 Oct 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p7MCeK9b"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176C2BDC05
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768053; cv=none; b=o4UKvkXz9o7Kg7tDNRtYCiJWVwBVQNlVmxwl4Wluvy43PcBBm97C6zyz3F1+rCVsV7CMBWjlWps9+6rqWA838vSNGXCttEnTmlzEqqGU+n/4RN+RMlvyB+gYNYd2xdV+1v/Dg86ztCUaijurkWQ46OkrRZCjY1o4xlbLo6CyoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768053; c=relaxed/simple;
	bh=cAl8PTzwlCfv/ZSCIc8Jmo++UMAa37FmLHixN//+s+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeqn6aXRtknUkNtb/Xbh9Dfiyudv/OE9KCBGh2HIJ70u4uw7q+tBa8upPCUab2o0plfAi1j8ChWNy8uGwbtUUPTq0c1rqNM81KJkpat50o1JyNU8+KAV5XluQyv0wkNVTuOrZRGUM6Awji6f6pvCuChdt/CRGSjOSLKmxAb0L3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p7MCeK9b; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E9F13C0DA92;
	Wed, 29 Oct 2025 20:00:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29213606E8;
	Wed, 29 Oct 2025 20:00:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2E18117FD2C2;
	Wed, 29 Oct 2025 21:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761768045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bXshXnMKFZiIa2RH1dRuubi2wGIQvRRV+/Dk8h2OBkM=;
	b=p7MCeK9bmuC9IRnnF1FYFFgP27vTSlPONTdMICb+qDQ5KODhOcXI1HsJJPhGhAGytv7aM4
	6Zmkx+CuTBd70yduXTlVkUNCayTedUBAt2+D0ioUFc7nJQwvrSys2Cl1w6EdmiJ9JvUmOP
	GFwVNSn18nyh66qEWKyy3h9XChY2TfPBGIgU/n1mTnZrXkJ53gytuDDbrBcdaO+0oMt1pG
	lcdIABXXTIsBiVNO2tZyvhKLEoei50qciXGNKggGBJ/7BHnD3OKhRr2+7cqnndZaHk2y7M
	DsfjveZvaWM8GakhbdCAuqBCk06KzTxsx2AzehizXyTe6IevvNgODC+zaRKlGg==
Message-ID: <462415bb-92dd-418c-9fd6-90f1f3194d68@bootlin.com>
Date: Wed, 29 Oct 2025 21:00:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
 <20251029190116.3220985-4-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251029190116.3220985-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 29/10/2025 20:01, Raju Rangoju wrote:
> Adds support for jumbo frame selftest. Works only for
> mtu size greater than 1500.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v4:
>  - remove double semicolon
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  2 ++
>  drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 23 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index ffc7d83522c7..b646ae575e6a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -211,6 +211,7 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
>  	}
>  
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
> +	pdata->sph = true;
>  }
>  
>  static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
> @@ -223,6 +224,7 @@ static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
>  
>  		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
>  	}
> +	pdata->sph = false;
>  }

looks like this hunk belongs to the previous patch for split header :)

Maxime


