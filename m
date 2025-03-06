Return-Path: <netdev+bounces-172685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9AA55B1F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8785177911
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328D27D784;
	Thu,  6 Mar 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="n7Vb1JAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5F1DDC3E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304990; cv=none; b=IpzK6eQL1Vtp3VhTgcn2J1N/oQ1e8WXBYN5fiaoRSqWN6TAOG8b1EFRFHI65mqvEiDFq+bCzGxtCbp7Za4622EHr/qlx58yD/hq4bYd7QipPHEixkaVzl+/noXKuB19Re23lO7kJ9VAh0ZqVmYN6P5izSGQs+K8caEB7kzvcE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304990; c=relaxed/simple;
	bh=TjTyGrcYB8Jm7rM3KapsODrBwAs8Avyb2414zXyldW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTJ6WZZP9vpX5L0s5WeunApwe1jWSftZIn1jS9MOEdcQtfwAlkfvbvPwL04n+h27hqqgb7ynaHJp2/1STCvd0HN+ZYmUx9+mfgUdDBY2u9K84ML/Obxl+89XMWjuD7/5hT/TeDY/jU1oNjMHOJVVjaj4+GD0VXrdJQMpfl7limg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=n7Vb1JAF; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741304987;
 bh=oDJmvAX7nAqa4Vhl4U1zjfFrd0jhOQ7wzffB0eGRfkE=;
 b=n7Vb1JAF/9Vr2FA2koxoteaV37h94JNwOwSXZLNLWY45dDlxDlqAdXX8tsFo1FGY1YGhL2P03
 xKYVrghET35Em4rJZEV9U4GtdlZMA4TxpZHQqdKepRpt2wc5zPvGDcTaAts+xiBT4WIQsAztHKc
 nKY0zh1fY2Xr5Mn72fu2t698jkJbVcPocNxs3PcAU4zEYeKdzv0mKtoPmCRwxM6pYvVlgYB/aKM
 3ub0ybRtqfiikAAE6qMg0BbDn3ajTM+stuUSbsjPZj3afNCxJSeVcsOOQgXMnvGG8PwjWLSxRFg
 h6HZJ1RcaRHtOfrh2CuPAjV40Vrgd1IKU8YB+CVsvGFg==
X-Forward-Email-ID: 67ca3498c1763851c065d4e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
Date: Fri, 7 Mar 2025 00:49:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
 <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:37, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 09:09:46PM +0000, Jonas Karlman wrote:
>> All Rockchip GMAC variants require writing to GRF to configure e.g.
>> interface mode and MAC rx/tx delay. The GRF syscon regmap is located
>> with help of a rockchip,grf and rockchip,php-grf phandle.
> 
>> @@ -1813,8 +1564,24 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>>  
>>  	bsp_priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>>  							"rockchip,grf");
>> -	bsp_priv->php_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>> -							    "rockchip,php-grf");
>> +	if (IS_ERR(bsp_priv->grf)) {
>> +		ret = PTR_ERR(bsp_priv->grf);
>> +		dev_err_probe(dev, ret, "failed to lookup rockchip,grf\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	bsp_priv->php_grf =
>> +		syscon_regmap_lookup_by_phandle_optional(dev->of_node,
>> +							 "rockchip,php-grf");
>> +	if ((of_device_is_compatible(dev->of_node, "rockchip,rk3588-gmac") ||
>> +	     of_device_is_compatible(dev->of_node, "rockchip,rk3576-gmac")) &&
>> +	    !bsp_priv->php_grf)
>> +		bsp_priv->php_grf = ERR_PTR(-ENODEV);
> 
> It seems odd you say all variants need this property, and then you
> look for two specific variants here and do something different? Why
> are these two special?

rockchip,grf is required for all GMACs, rockchip,php-grf is also needed
on rk3576 and rk3588 (+rk3562 that has been posted on ML) :-S

Above use of of_device_is_compatible() was my attempt at requiring the
syscon regmap for those variants that make use of php_grf. And still not
break rk3562 depending on the order these would land.

Should probably clarify a little bit with a code comment in a v2.

Regards,
Jonas

> 
> 	Andrew


