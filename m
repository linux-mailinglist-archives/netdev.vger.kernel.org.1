Return-Path: <netdev+bounces-144355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51A9C6CB5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94F9B224F9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AD1FB895;
	Wed, 13 Nov 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDHGkGYm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A81F80C2;
	Wed, 13 Nov 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492677; cv=none; b=qx8kxFtLN81h7+RFilbUzxkzYBkS1LiZoBktuk5sdnRLeQl4QNTvxxc3Mx+qBuCzRpSIrUpetigX5LiXwTrp/5QTxpFIe2c/olgJQtbO1rrjL/ptbRxYG15yOCFLmR2Rj9Dh4P4btv7dt1bpnOjaV1T+v7lbXy7gpQGonNDQLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492677; c=relaxed/simple;
	bh=Vy8Iqu3OFXniKxvWbng1DoVI0tlBlU/xFf+XDj6PoTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKf8r+ccyvmzRzwNPf7NU8kT2a3vuvgwMz1GaWDANLSNreOP9jR4PsTsOK5EZHVArV7vzRovKACSy47kGwIieu6frfj036IIBvFL9RAOlX7lKhqqNcPFs/ELGGg6N4ysKIr48aNyno1aOQtHKycR3YwxZaPDp+QeyJ0YZHnGYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDHGkGYm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731492676; x=1763028676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vy8Iqu3OFXniKxvWbng1DoVI0tlBlU/xFf+XDj6PoTQ=;
  b=GDHGkGYmvDJVvbjgpSV4HIBAi/wg0mEi+VMB7lro2YbHZ2h4FOAZn2y3
   FV8efEZOTwr56EDdoecoEtqdloN6V2QxcVAShaV9DohSSU1rKIVjoVCe7
   ev+IrdHWIpEoHoKciOwP1rNpFWE+LOohIS2DIIFPQsMMWMLZduKlaG4CR
   c++tiIfWkgXfoH+Oax0Hx8w7/DgHJ6aDPo64vIqRcYYAOnAJVXfMzx93Q
   SFMSD6FRdxm4rluEQURzifezTmKtuxA9BBVBYopnUcGJ1v7e+FY/PhWGI
   irzNKU8wblz0IoJm1LYFAMbtgn5MfzACcfjtAeZClErB2GZZ7q8etm5Gx
   A==;
X-CSE-ConnectionGUID: 37ICXwYsTQC6OXaBsZQXTA==
X-CSE-MsgGUID: OuW50VKARq6O+f23ADmVwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31608046"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31608046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:11:15 -0800
X-CSE-ConnectionGUID: 05tXbYHhRACmOLJ2EKDmjQ==
X-CSE-MsgGUID: uVFc8516StGJKtpbzyMqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87395176"
Received: from hooisan-mobl.gar.corp.intel.com (HELO [10.247.100.100]) ([10.247.100.100])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:11:11 -0800
Message-ID: <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
Date: Wed, 13 Nov 2024 18:10:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update
 eee_cfg values
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/2024 9:04 pm, Andrew Lunn wrote:
> On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
>> In stmmac_ethtool_op_get_eee() you have the following:
>>
>> edata->tx_lpi_timer = priv->tx_lpi_timer;
>> edata->tx_lpi_enabled = priv->tx_lpi_enabled;
>> return phylink_ethtool_get_eee(priv->phylink, edata);
>>
>> You have to call phylink_ethtool_get_eee() first, otherwise the manually
>> set values will be overridden. However setting tx_lpi_enabled shouldn't
>> be needed if you respect phydev->enable_tx_lpi.
> 
> I agree with Heiner here, this sounds like a bug somewhere, not
> something which needs new code in phylib. Lets understand why it gives
> the wrong results.
> 
> 	Andrew
Hi Russell, Andrew, and Heiner, thanks a lot for your valuable feedback.

The current implementation of the 'ethtool --show-eee' command heavily 
relies on the phy_ethtool_get_eee() in phy.c. The eeecfg values are set by 
the 'ethtool --set-eee' command and the phy_support_eee() during the 
initial state. The phy_ethtool_get_eee() calls eeecfg_to_eee(), which 
returns the eeecfg containing tx_lpi_timer, tx_lpi_enabled, and eee_enable 
for the 'ethtool --show-eee' command.

The tx_lpi_timer and tx_lpi_enabled values stored in the MAC or PHY driver 
are not retrieved by the 'ethtool --show-eee' command.

Currently, we are facing 3 issues:
1. When we boot up our system and do not issue the 'ethtool --set-eee' 
command, and then directly issue the 'ethtool --show-eee' command, it 
always shows that EEE is disabled due to the eeecfg values not being set. 
However, in the Maxliner GPY PHY, the driver EEE is enabled. If we try to 
disable EEE, nothing happens because the eeecfg matches the setting 
required to disable EEE in ethnl_set_eee(). The phy_support_eee() was 
introduced to set the initial values to enable eee_enabled and 
tx_lpi_enabled. This would allow 'ethtool --show-eee' to show that EEE is 
enabled during the initial state. However, the Marvell PHY is designed to 
have hardware disabled EEE during the initial state. Users are required to 
use Ethtool to enable the EEE. phy_support_eee() does not show the correct 
for Marvell PHY.

2. The 'ethtool --show-eee' command does not display the correct status, 
even if the link is down or the speed changes to one that does not support EEE.

3. The tx_lpi_timer in 'ethtool --show-eee' always shows 0 if we have not 
used 'ethtool --set-eee' to set the values, even though the driver sets 
different values.

I appreciate Russell's point that eee_enabled is a user configuration bit, 
not a status bit. However, I am curious if tx_lpi_timer, tx_lpi_enabled, 
and other fields are also considered configuration bits.

According to the ethtool man page:
--show-eee
Queries the specified network device for its support of Energy-Efficient 
Ethernet (according to the IEEE 802.3az specifications)

It does not specify which fields are configuration bits and which are 
status bits.

