Return-Path: <netdev+bounces-211305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D24B17CD3
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 08:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B54625918
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7361EB9FA;
	Fri,  1 Aug 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMjQWrCx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFD1E7C12
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029201; cv=none; b=LDyMVaEBGUALtuea/rru/14qSSONioxeQMxFWJpd4/TOgm+uBAGb61W5DPi2eu5sBVKtyafbD7GO/mQV1fS5EmkHVnhXWOlcG7dRxTAC6fZzE9jWa80V1p2WqrpvBdcfrfOIQYrTWvAbtwUoLG8KDkh4AG+2g2uTTYQEWFzmUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029201; c=relaxed/simple;
	bh=+58XgPMQxm+Yyfmh1iN1LzA3zS5ostFDsjF4h8tKplY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI5m0ekMjoXwKwL4rUTGI1HevcYu4SyggaOana2qbctcRKpFjCsOpDQqVWOoqeZqt/PxYwr0zJqBNpUBOb/t2Fkqe+44MAaCVrugQeVUeK/eoHoIuuSymMa68fcP52GuNnYcpHntTpXKF4SVdv1tTjI7bSI5TDStQY/0kBcHR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMjQWrCx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754029200; x=1785565200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+58XgPMQxm+Yyfmh1iN1LzA3zS5ostFDsjF4h8tKplY=;
  b=lMjQWrCx7o7kB9moUGErZb8C5zU9hrcOzkVTzeJbdLgMTeDSxh82wCxc
   dLaoda2BsoHJLEMU/pWkZFQqXBJHFNySUSwnG1GuMXOd+LpvbA/lsxGOR
   eooGhjvU9PiFjaqLdWFiU8QkUvaYQRbxzGnJIIJgb79XPIGlJKG5ha54I
   dqkigcIapvEvP4s5gJL363Dy4lhEXMllxPa4lAl5RkSJkzpF8GI4JET93
   ID9aOyoTKDIYvYMi5o8kPUNdlX/ykO9DgNUIyPBTSxdXUg9fvTlfNa0Ru
   gfWzczAQiXKoLtNK8+bUJAFqmV7AGAAPEr8qxGXAnzP7MLEl+iYpQ0vIj
   Q==;
X-CSE-ConnectionGUID: unMpkEotTEm+b/7ujtviZQ==
X-CSE-MsgGUID: IfiEIfWwQfmd6b8tFUoKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67443254"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="67443254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 23:19:59 -0700
X-CSE-ConnectionGUID: ndEXHUc4TgGrX9andVyrvA==
X-CSE-MsgGUID: o3WITpizRmimgjyctwTRQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167655072"
Received: from egraban-mobl1.ger.corp.intel.com (HELO [10.245.83.192]) ([10.245.83.192])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 23:19:50 -0700
Message-ID: <3050f970-5e37-4d93-8a15-f852d4cc8f78@linux.intel.com>
Date: Fri, 1 Aug 2025 08:19:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ftgmac100: fix potential NULL pointer access in
 ftgmac100_phy_disconnect
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
 <ddbfdf8c-53ab-4993-a53a-60c45d36cae9@linux.intel.com>
 <b16f2601-c876-4959-b40a-58a676903594@gmail.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <b16f2601-c876-4959-b40a-58a676903594@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-07-31 9:22 PM, Heiner Kallweit wrote:
> On 7/31/2025 10:58 AM, Dawid Osuchowski wrote:
>> On 2025-07-30 10:23 PM, Heiner Kallweit wrote:
>>> After the call to phy_disconnect() netdev->phydev is reset to NULL.
>>
>> phy_disconnect() in its flow does not set phydev to NULL, if anywhere it happens in of_phy_deregister_fixed_link(), which already calls fixed_phy_unregister() before setting phydev to NULL
> 
> I can't follow this argumentation. Look at phy_detach(), there we have:
> if (phydev->attached_dev)
> 	phydev->attached_dev->phydev = NULL;
> So netdev->phydev is NULL after the call to phy_disconnect, provided that the PHY was attached to the netdev before.
> If use_ncsi is true, then fixed_phy_unregister() will be called with a NULL argument.

You are absolutely correct. Somehow I missed that and I apologize for 
the confusion on my side.

With that cleared up:

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid
> 
> This is independent of whether of_phy_is_fixed_link() is true or not.
> Very likely it's false in the NCSI case.
> 
>>
>>  From my understanding (which very much could be wrong) of ftgmac100_probe(), these two cases are mutually exclusive. The device either uses NCSI or will use a phy based on the DT "fixed-link" property
> 
>>> So fixed_phy_unregister() would be called with a NULL pointer as argument.
>>
>> Given my analysis above, I don't think this case is possible.
>>
>> Best regards,
>> Dawid
>>> Therefore cache the phy_device before this call.
>>>
>>> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>    drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
>>> index 5d0c09068..a863f7841 100644
>>> --- a/drivers/net/ethernet/faraday/ftgmac100.c
>>> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
>>> @@ -1750,16 +1750,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
>>>    static void ftgmac100_phy_disconnect(struct net_device *netdev)
>>>    {
>>>        struct ftgmac100 *priv = netdev_priv(netdev);
>>> +    struct phy_device *phydev = netdev->phydev;
>>>    -    if (!netdev->phydev)
>>> +    if (!phydev)
>>>            return;
>>>    -    phy_disconnect(netdev->phydev);
>>> +    phy_disconnect(phydev);
>>>        if (of_phy_is_fixed_link(priv->dev->of_node))
>>>            of_phy_deregister_fixed_link(priv->dev->of_node);
>>>          if (priv->use_ncsi)
>>> -        fixed_phy_unregister(netdev->phydev);
>>> +        fixed_phy_unregister(phydev);
>>>    }
>>>      static void ftgmac100_destroy_mdio(struct net_device *netdev)
>>
> 


