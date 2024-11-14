Return-Path: <netdev+bounces-144686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62E9C8204
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA221F233B2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5C1632F3;
	Thu, 14 Nov 2024 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAcOnSpE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556C15C14B;
	Thu, 14 Nov 2024 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559069; cv=none; b=L73TbdidH1DBw7eFaJEuuslh5Q6J2B9/xaP7BjKYm3b/lxQVyjhaWsgQ9ly4Iq4UwqgZblGHdzlKC1EEo9pTpiSg8T7lM14UInu+R9LQ++JvWbsBNjbvPIKZynl7ewtSijONYEOkEAJo3q2lvJ1BJM1+6OArxxgUYJt0RVR2SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559069; c=relaxed/simple;
	bh=WKOXFnXXfoup+z1HHcm+BHwMVCrgMUWLaq9XXRMUTgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIpn2Saktd3MysbhKfoCdyLcX5+cXrOi2NV5b7zVwosdDjk2KR9/9oD0JWXh3rjmeRHWmrA8Y9YSViqtZktUGHnvLF7JhCCrucEpUSSFvzTTOfXAs7foIaft/MWzCLRLJOuZygC1VYzoTfeGaPgCtg4+8It74+kiukPFzE4Zp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAcOnSpE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731559068; x=1763095068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WKOXFnXXfoup+z1HHcm+BHwMVCrgMUWLaq9XXRMUTgQ=;
  b=FAcOnSpEF369yVyPG4brHjCewKY5ClxQJ8fx/h8r3Zini0tXt1ZgLMiX
   UfkHNULZHnyivnEatfzIhNHWZjk8vT/YlTACe1/QmfX36GBBTv3oEvz+G
   Rf17FoNEbTykTa99Ce1ZNLPMUylO/E7yTU5KOcs/sLY2YCKMLAL4U6cvG
   7+NPKd8uxLejOmniomQ5SCZhGYoRIecEzuvL8lP3J+6969wyPX0PqGnRc
   8kjSNAkjvWZCzW213L1jnTsZJ7wII9n9M0uuxST9H9pJtsnLnIpAnRBKO
   mCNQwmLydexOSeZ8n9oz0m7bzMLfEDX97hhHK54je5tSPZxDsombnOSPo
   w==;
X-CSE-ConnectionGUID: OBE/FOYpSn+tHlXKqzTcNQ==
X-CSE-MsgGUID: Qks7mo02RiSNx1+qfYAyxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42864454"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42864454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:37:47 -0800
X-CSE-ConnectionGUID: kE45sCQ0RsO5lvNHx0MVow==
X-CSE-MsgGUID: f67o2F7qRBenNM1uR0308g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88261207"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.16.168]) ([10.247.16.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:37:43 -0800
Message-ID: <1a94d554-c043-4444-85a1-d30d07e7580f@linux.intel.com>
Date: Thu, 14 Nov 2024 12:37:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update
 eee_cfg values
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
 <b61a9c36-dfd5-4b90-88a6-90e43cfae000@lunn.ch>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <b61a9c36-dfd5-4b90-88a6-90e43cfae000@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 7:05 am, Andrew Lunn wrote:

> tx_lpi_timer is a MAC property, but phylib does track it across
> --set-eee calls and will fill it in for get-eee. What however is
> missing it setting its default value. There is currently no API the
> MAC driver can call to let phylib know what default value it is using.
> Either such an API could be added, e.g. as part of phy_support_eee(),
> or we could hard code a value, probably again in phy_support_eee().
> 
> tx_lpi_enabled is filled in by phy_ethtool_get_eee(), and its default
> value is set by phy_support_eee(). So i don't see what is wrong here.
> 

Thank you for your detailed explanation. I will follow your suggestion to 
set the default value for tx_lpi_timer in phy_support_eee().

>> Currently, we are facing 3 issues:
>> 1. When we boot up our system and do not issue the 'ethtool --set-eee'
>> command, and then directly issue the 'ethtool --show-eee' command, it always
>> shows that EEE is disabled due to the eeecfg values not being set. However,
>> in the Maxliner GPY PHY, the driver EEE is enabled. If we try to disable
>> EEE, nothing happens because the eeecfg matches the setting required to
>> disable EEE in ethnl_set_eee(). The phy_support_eee() was introduced to set
>> the initial values to enable eee_enabled and tx_lpi_enabled. This would
>> allow 'ethtool --show-eee' to show that EEE is enabled during the initial
>> state. However, the Marvell PHY is designed to have hardware disabled EEE
>> during the initial state. Users are required to use Ethtool to enable the
>> EEE. phy_support_eee() does not show the correct for Marvell PHY.
> 
> We discussed what to set the initial state to when we reworked the EEE
> support. It is a hard problem, because changing anything could cause
> regressions. Some users don't want EEE enabled, because it can add
> latency and jitter, e.g. to PTP packets. Some users want it enabled
> for the power savings.
> 
> We decided to leave the PHY untouched, and will read out its
> configuration. If this is going wrong, that is a bug which should be
> found and fixed.
> 

I do agree with your point about leaving the PHY untouched and reading out 
its configuration as the default values in phy_support_eee() instead of 
setting the existing values to true for eee_enabled and tx_lpi_enabled.

> We want the core to be fixed, not workaround added to MAC
> drivers. Please think about this when proposing future patches.
> 
> 	Andrew
I will create different small patch fixes for each of the implementations. 
Thank you.

