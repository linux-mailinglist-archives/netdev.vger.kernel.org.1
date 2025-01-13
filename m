Return-Path: <netdev+bounces-157624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF439A0B092
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A8C1668D1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB323315D;
	Mon, 13 Jan 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8Hz6+4Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C15232386
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755569; cv=none; b=SZ66usMViaZCPS2RwORjK5sCUL26sZOJPh53Wtak5ZcjUC+Hmuenc8wARUCqFDNniyDHFVM1WRJGXOYsQ0Owc86gkgf6raqe0RtjEAchaZgLkskyIlYPnQKI7AaZ8tN0iWJ1zzpO39RD/owCQMDbJWJEuapHjR/8Zid8yVvQk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755569; c=relaxed/simple;
	bh=ucfjlokoiM4yL/9+xtO9DJ3OgLN3x7WHiZhI+XJS0rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKao+IjiXzOuvTUsJSdwwpUz2tBGr9GZEWdUuuKf2o4T6T/rozD8nmPNf4tFP9rMhuWwxI2XlmbULiH3qBG/xMffoBaTYBMFOOBqAk3e5g0VF4RIaUZet0wm8pqzX37TarGlR34Lyyp3GH4uEgkLTiYdbB3/UMPCxBjUkRUzCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8Hz6+4Q; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736755559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcuNFQWJylkhPh7t8gonvzvwWsZ6sN4LnbhC8eusAv0=;
	b=X8Hz6+4QavDAiS3Ew+4O7uWu/tOuSMl4stek9qSeQKLJAusNsXpq1L88iuACDbzN77VEkg
	dwdnWW1K6ANumpRwxOSgxq1C3eSzvUt0qkcxWVD99BYd1ErmKtoYhWWYw2jQuObsjnhUpf
	UnCeBErX+lqVQJ7NUvQ5rjqnRMFbWy4=
Date: Mon, 13 Jan 2025 16:05:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] net: stmmac: stm32: Use
 syscon_regmap_lookup_by_phandle_args
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 imx@lists.linux.dev
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/12 21:32, Krzysztof Kozlowski 写道:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 1e8bac665cc9bc95c3aa96e87a8e95d9c63ba8e1..1fcb74e9e3ffacdc7581b267febb55d015a83aed 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -419,16 +419,11 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>   	}
>   
>   	/* Get mode register */
> -	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
> +	dwmac->regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
> +							     1, &dwmac->mode_reg);
The network subsystem still requires that the length of
each line of code should not exceed 80 characters.
So, let's silence the warning:

WARNING: line length of 83 exceeds 80 columns
#33: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:307:
+							     &dwmac->intf_reg_off);


BTW, The other two stmmac patches also need to adjust
the code so that each line doesn't exceed 80 characters.

Thanks,
Yanteng

