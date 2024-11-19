Return-Path: <netdev+bounces-146155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F99D2223
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE98B20C95
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896C1925B3;
	Tue, 19 Nov 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqFZP3J9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6F12CDAE;
	Tue, 19 Nov 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007201; cv=none; b=VJV1872FJiLNe8ay4dJj4LlRLTiMuvDRCTPQ4Ap+uxJZGTiAbaPlTtPs4g+GDJ10Q5kB+9aH18CToc1KjS+8bRP79YGdCnItHaEsPhdYzirJxmUNiGeYu5vDwMgAF+haFbDjIfrGZ3X+9U1r3NOKuaewu/gaX/fxXz+5iD32pBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007201; c=relaxed/simple;
	bh=HtjEr6MyQAiTzXqILd1meE2GmGtMVF3rg86A6w3dlq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=celBKSwspmyhnDu669PUmMjQlm1pYq9qIFPVgQde+Fp96ctjQeBVwuX8D/iYZcUJWWaGSPIqGToOUlx5PwxUTR26YxNB9SsMzYJqu5GvFDfuNK/5JK54OHT0nmmQjTjxuZ62OsK+3zSaXem6oIwkfZOAyEP0Beiac1c0Nrw+2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqFZP3J9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732007200; x=1763543200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HtjEr6MyQAiTzXqILd1meE2GmGtMVF3rg86A6w3dlq4=;
  b=PqFZP3J9s/1aoYNP4DglFf9JQGx6QGRSCKGUrXbQL7e2SF1todx4MyjB
   15snAYVIKjrylBAeFPu3lSpzvSEFMOLAlP59VUd4kpD/5G1bHbAEqrqQr
   ZIXdaMohJTLU3FsII2kidyEKczbTRvG94tnUQcbFtTXnxsAS5a7Krhcq9
   hYq2buEM03o4PrRbsx81PnJ/fBtF+qvvsqP0aUMVx5WbKpMhl15xyIXNe
   OtNI8TfRogQClKVze5HeHN9OMC/yfefjFXN3ljaGWACi/6Nxvz+Fwj795
   h012i0BJuYVtMzm0QME8ySgcRCsTnyIBtavYjUzV6q2VgjgoGPZSH6kqr
   g==;
X-CSE-ConnectionGUID: ObkncoqLQG2EihhT+blugg==
X-CSE-MsgGUID: qMs+8ouDT0eNEuenTXYg5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="19605052"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="19605052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:06:39 -0800
X-CSE-ConnectionGUID: zsvHZ+PwTi68k0a9K6UDpA==
X-CSE-MsgGUID: 4tKkEW0eSyiBbNpB7+8d9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89905283"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.75.104]) ([10.247.75.104])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 01:06:36 -0800
Message-ID: <c1bb831c-fd88-4b03-bda6-d8f4ec4a1681@linux.intel.com>
Date: Tue, 19 Nov 2024 17:06:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: phy: replace phydev->eee_enabled with
 eee_cfg.eee_enabled
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
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
 <ZzdOkE0lqpl6wx2d@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZzdOkE0lqpl6wx2d@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/11/2024 9:37 pm, Russell King (Oracle) wrote:
> On Fri, Nov 15, 2024 at 07:11:50PM +0800, Choong Yong Liang wrote:
>> Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
>> designed to have EEE hardware disabled during the initial state.
>>
>> In the initial stage, phy_probe() sets phydev->eee_enabled to be disabled.
>> Then, the MAC calls phy_support_eee() to set eee_cfg.eee_enabled to be
>> enabled. However, when phy_start_aneg() is called,
>> genphy_c45_an_config_eee_aneg() still refers to phydev->eee_enabled.
>> This causes the 'ethtool --show-eee' command to show that EEE is enabled,
>> but in actuality, the driver side is disabled.
>>
>> This patch will remove phydev->eee_enabled and replace it with
>> eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(),
>> it will follow the master configuration to have software and hardware
>> in sync.
> 
> Hmm. I'm not happy with how you're handling my patch. I would've liked
> some feedback on it (thanks for spotting that the set_eee case needed
> to pass the state to genphy_c45_an_config_eee_aneg()).
> 
> However, what's worse is, that the bulk of this patch is my work, yet
> you've effectively claimed complete authorship of it in the way you
> are submitting this patch. Moreover, you are violating the kernel
> submission rules, as the Signed-off-by does not include one for me
> (which I need to explicitly give.) I was waiting for the results of
> your testing before finalising the patch.
> 
> The patch needs to be authored by me, the first sign-off needs to be
> me, then optionally Co-developed-by for you, and then your sign-off.
> 
> See Documentation/process/submitting-patches.rst
> 
> Thanks.
> 
> pw-bot: cr
> 

Sorry for the late reply; I just got back from my sick leave. I wasn't 
aware that you had already submitted a patch. I thought I should include it 
in my patch series. However, I think I messed up the "Signed-off" part. 
Sorry about that.

The testing part actually took quite some time to complete, and I was 
already sick last Friday. I was only able to complete the patch series and 
resubmit the patch, and I thought we could discuss the test results from 
the patch series. The issue was initially found with EEE on GPY PHY working 
together with ptp4l, and it did not meet the expected results. There are 
many things that need to be tested, as it is not only Marvell PHY that has 
the issue.

With your patch, most of the issues were resolved based on the testing. 
However, the set_eee was using the old value of eee_enabled and was not 
able to turn EEE on or off. I think Heiner's patch already solved that part.

With all the solutions provided, I think the only patch left that I need to 
submit is the one calling 'phy_support_eee()' from stmmac.

