Return-Path: <netdev+bounces-145119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD49CD522
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CC4283E3F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115584D02;
	Fri, 15 Nov 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1HXVmgW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A33211;
	Fri, 15 Nov 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635176; cv=none; b=WxBzT2z82P2aMlY0Q0Rm7/dNBp9spzknLZFAL4D8hNTL5cQ7C330qahOSTE1sc4C5UzJ59/ZnyJ7SHAs9F3dOyvl5lGlEOCaCD0kQzB5oZVJAzuQ6JBzIJ5eQ+dd5pyki+fwUKJf1nxvPmrlFOC0Jk1dUBcqhe/P9+1A/f/UE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635176; c=relaxed/simple;
	bh=m5vc2Wizx2rJbKoJg3DIZCEwDfTT1ErdANobu7oKqtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZiCsE4wGVtlDXnie2Zoo1a6JTKA8r46kHH0bexOt0h7ReP6aQa/Chx0WXRqJWJA6VDHtoeOvzWlG+e1CNurcL+P+9vOx/ZtUUvO3PXZISQKHo28Dc5uAS+KA+TuvxXdxIuKGct3QOplC4odNrltCEZB2PQYJGnLcAUvEgRj/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1HXVmgW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731635175; x=1763171175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m5vc2Wizx2rJbKoJg3DIZCEwDfTT1ErdANobu7oKqtg=;
  b=U1HXVmgWvkxkK2UNWVgFDd1wQfG8Imsl1E/dML+bE3G0hOPOWLz0Za9J
   CTrLDj4mgf72ijAx/cSjTkr/McmkmQuyFgb7FbbnSfYxj2kwAZ+tShItz
   CxllunPogJLyZoxlV5ozkV3qeeo63z7Cuv16W/6wHGQS3SLxQmOgwFMew
   Gny4YDKmKjisj84VBdQeWm7nRONv9GP8QuileNCQSGXtIWIdS7a/ninPj
   CCy5pnnBAEq0bI6yW2GtrAk3W9YNPfUSMocBLMlYcAE3eSzel/EchbeD4
   ORtHjEbZjuuNWTdAImgrPmDSMc06jK7U4Dq9Nlks8x7X6CQZXw6AxSvsT
   Q==;
X-CSE-ConnectionGUID: kApCyZCkT5+0zs+74UEDLw==
X-CSE-MsgGUID: ovvIFsGuSZOXMZ/3BJQAnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31028346"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="31028346"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 17:46:13 -0800
X-CSE-ConnectionGUID: 5je70P8PRcmZc2W8TeLARg==
X-CSE-MsgGUID: RJOEMptXRAm1HGWlvPOq5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="89153309"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.75.68]) ([10.247.75.68])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 17:46:09 -0800
Message-ID: <6c023200-5e81-432c-b21d-d7a9cf1bfc92@linux.intel.com>
Date: Fri, 15 Nov 2024 09:46:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: set eee_cfg based on PHY
 configuration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
 <20241114081653.3939346-2-yong.liang.choong@linux.intel.com>
 <ZzXBpEHs0y2_elqK@shell.armlinux.org.uk>
 <ZzXLgEjElnJD1445@shell.armlinux.org.uk>
 <ZzXOAvc__iQscSb4@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZzXOAvc__iQscSb4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 6:16 pm, Russell King (Oracle) wrote:
> On Thu, Nov 14, 2024 at 10:05:52AM +0000, Russell King (Oracle) wrote:
>> On Thu, Nov 14, 2024 at 09:23:48AM +0000, Russell King (Oracle) wrote:
>>> On Thu, Nov 14, 2024 at 04:16:52PM +0800, Choong Yong Liang wrote:
>>>> Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
>>>> designed to have EEE hardware disabled during the initial state, and it
>>>> needs to be configured to turn it on again.
>>>>
>>>> This patch reads the PHY configuration and sets it as the initial value for
>>>> eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled instead of having them set to
>>>> true by default.
>>>
>>> eee_cfg.tx_lpi_enabled is something phylib tracks, and it merely means
>>> that LPI needs to be enabled at the MAC if EEE was negotiated:
>>>
>>>   * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
>>>   *      that eee was negotiated.
>>>
>>> eee_cfg.eee_enabled means that EEE mode was enabled - which is user
>>> configuration:
>>>
>>>   * @eee_enabled: EEE configured mode (enabled/disabled).
>>>
>>> phy_probe() reads the initial PHY state and sets things up
>>> appropriately.
>>>
>>> However, there is a point where the EEE configuration (advertisement,
>>> and therefore eee_enabled state) is written to the PHY, and that should
>>> be config_aneg(). Looking at the Marvell driver, it's calling
>>> genphy_config_aneg() which eventually calls
>>> genphy_c45_an_config_eee_aneg() which does this (via
>>> __genphy_config_aneg()).
>>>
>>> Please investigate why the hardware state is going out of sync with the
>>> software state.
>>
>> I think I've found the issue.
>>
>> We have phydev->eee_enabled and phydev->eee_cfg.eee_enabled, which looks
>> like a bug to me. We write to phydev->eee_cfg.eee_enabled in
>> phy_support_eee(), leaving phydev->eee_enabled untouched.
>>
>> However, most other places are using phydev->eee_enabled.
>>
>> This is (a) confusing and (b) wrong, and having the two members leads
>> to this confusion, and makes the code more difficult to follow (unless
>> one has already clocked that there are these two different things both
>> called eee_enabled).
>>
>> This is my untested prototype patch to fix this - it may cause breakage
>> elsewhere:
> 
> As mentioned in the other thread:
> 
> Without a call to phy_support_eee():
> 
> EEE settings for eth2:
>          EEE status: disabled
>          Tx LPI: disabled
>          Supported EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>          Advertised EEE link modes:  Not reported
>          Link partner advertised EEE link modes:  100baseT/Full
>                                                   1000baseT/Full
> 
> With a call to phy_support_eee():
> 
> EEE settings for eth2:
>          EEE status: enabled - active
>          Tx LPI: 0 (us)
>          Supported EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>          Advertised EEE link modes:  100baseT/Full
>                                      1000baseT/Full
>          Link partner advertised EEE link modes:  100baseT/Full
>                                                   1000baseT/Full
> 
> So the EEE status is now behaving correctly, and the Marvell PHY is
> being programmed with the advertisement correctly.
> 

Thank you for all the suggestions, the provided prototype, and the tested 
results.

I will study the suggestions in depth, test the provided prototype, and 
provide more feedback.

