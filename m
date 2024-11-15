Return-Path: <netdev+bounces-145118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDB9CD51C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F31F21F8C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0642A82;
	Fri, 15 Nov 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LG5nQOc6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12E3211;
	Fri, 15 Nov 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635143; cv=none; b=UKb1gR6SgXQ57bzDFziZOCFdSoFdQN0IHpTo+tnu+AbTs3BtVTOYNvreP/LQydt047a+D8Qv9+ePDLtYaGb1b3IfgUlTsNiGhcIuEcstFAs+aqFPhpVkQyJL6zw13vq2gt/E2c1qZPkeU9XpHxL4+IdfUYx1LbKTbxJDRuBzaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635143; c=relaxed/simple;
	bh=yJjdF32OY6zfb+mESQ3VGqFK0PLcIWDQ8VkuY/mylkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hdrh7oEY0bTo5NzaB0A2SFLTxNwYoBUvYgZuZ217SSOSPx25Oa6lnpQIU+cgOygdMnTWJiZiVry9pJnMiEEVrpt4Pza4f+1wt4yNBSBSxUElKE1abRQKBdsN4NTWTP4g9fjUkKzo7CDaYjwvTDl3tenEDZrv4+nVjC5zjEc96dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LG5nQOc6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731635141; x=1763171141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yJjdF32OY6zfb+mESQ3VGqFK0PLcIWDQ8VkuY/mylkw=;
  b=LG5nQOc6bWidUIzqfIEC6zJ8hURAzEhqe4wDzyJl4e/N4R7F0QWf0IY4
   PxMXTfFzC+bw3FwbRjxt/r/n2wWqDZC+ccxOVslvw0xVNxSxRohXjqN0o
   t0UtyxjmikCGpPceetFftzolaa2KcE+dCSpC5ZNAg9dhfYqFXPWzZ+h9t
   hwu3NmR9U2/j1bJMKksCueZ+xOg1di99x4ZfT79NBS6FZqslFn1peA5Vz
   wtusfD5M4VDh5c5kWoyYz0P5Bs1jt/dtzm/YE4WohnWLa0hTHyaOQisVs
   TCV0hE69abNcWU3MtlcR5p41uuxnlQNuhL5vQS9oz4Qp/1uytaRK2Js6W
   A==;
X-CSE-ConnectionGUID: mag7dxuEQ6e+l9G/slUHNQ==
X-CSE-MsgGUID: oFu8wuaFQpqfR/BP2GzQeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31028262"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="31028262"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 17:45:38 -0800
X-CSE-ConnectionGUID: ZSoy7dh8QXaberbAbMlhuA==
X-CSE-MsgGUID: PWUnzZUpRcCKkFqhTZne+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="89153074"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.75.68]) ([10.247.75.68])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 17:45:26 -0800
Message-ID: <fdac60cd-dd7d-4e7b-a65e-2c2a01f4f147@linux.intel.com>
Date: Fri, 15 Nov 2024 09:45:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] net: stmmac: set initial EEE policy
 configuration
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
 <20241114081653.3939346-3-yong.liang.choong@linux.intel.com>
 <a6cbf428-4672-4beb-8c55-e4d3ae684458@lunn.ch>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <a6cbf428-4672-4beb-8c55-e4d3ae684458@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 10:19 pm, Andrew Lunn wrote:
> On Thu, Nov 14, 2024 at 04:16:53PM +0800, Choong Yong Liang wrote:
>> Set the initial eee_cfg values to have 'ethtool --show-eee ' display
>> the initial EEE configuration.
>>
>> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 7bf275f127c9..5fce52a9412e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1204,7 +1204,7 @@ static int stmmac_init_phy(struct net_device *dev)
>>   			netdev_err(priv->dev, "no phy at addr %d\n", addr);
>>   			return -ENODEV;
>>   		}
>> -
>> +		phy_support_eee(phydev);
>>   		ret = phylink_connect_phy(priv->phylink, phydev);
> 
> Is supporting EEE a synthesis option, or is it always available?
> 
> Some EEE code is guarded by:
> 
>          if (!priv->dma_cap.eee)
>                  return -EOPNOTSUPP;
> 
> 	Andrew

It's a synthesis option that should check priv->dma_cap.eee before setting 
EEE. I will update it in the next version.

