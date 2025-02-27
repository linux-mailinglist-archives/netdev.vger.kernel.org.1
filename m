Return-Path: <netdev+bounces-170195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5762A47BE0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A248A161162
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B922D7AE;
	Thu, 27 Feb 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZqxDYmG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70322D7A5;
	Thu, 27 Feb 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655118; cv=none; b=Q1pko3WYiDVPWQ0w60x0DVc6vLCGSf1p5xAd7DhwX7dNlwbFqptiZQdraTgP1bSnp5XHaiHNzpEGtklt8m+1Rw1/z3vtMAMEB//lEcuNDlHYfvcl3nlQMNMoaOM209CRw7IyN8lG/Mt10w160GvMMVblCIho42W2RHiF+g7aMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655118; c=relaxed/simple;
	bh=IDZov/Dczn2f/ieNl0tUIoh9CnexHmfb2x1sTLNrFZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sw8D+T4XcqP5S8TJNDWpOa690jhJsF2A8pF1LUZaiDU0O6lTbRMfb1Zhy5p3WFpp5jFPteC+NGElpx9sa8c8f/PtZXlsW+UlMEu/QyDUPqnpS+H+GMHJJ22fdnUgJCbr3K6CgKWL3Q/xNTKJzDLo2oT259umxzkhL2G7nSzilvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZqxDYmG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740655117; x=1772191117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IDZov/Dczn2f/ieNl0tUIoh9CnexHmfb2x1sTLNrFZA=;
  b=bZqxDYmGd8ofzhohhdB4mvgtrSgFqaVnT6LO+Pwl+Cw0mq4pzB4iyfCQ
   P3l3X7C8LYYt/tGhqB9Mx8bdQg+rZn2Of5R9V6beds1xDzk8repbR2UAN
   MGkGG/1hCQvxAOKW7+0PwyAc7naSgzlEVnT2ujba6H0dnbQrQ11RFv98S
   134PJeRAQ7LSGNh51tGCjLuVMelXklr5eONj08WTtxl6vpnjnP9QJ8hpf
   xjUvBxocNzoV0PTX67S8JW07mLEDWIGuE+gh5eh+8muECw6qTDD/Bf8PK
   oLf55cH0qC25/1wMbDI3q+ZZUzbPfJdQs4ZFcH+mA9AsmeXEoUj+mqc15
   w==;
X-CSE-ConnectionGUID: Gjl+TKEYTnm8RlwIKCadJw==
X-CSE-MsgGUID: S6HeA2jpSQWfUP8JkTrgXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58955619"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="58955619"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:18:36 -0800
X-CSE-ConnectionGUID: CyeTxPjwSHeHLctx7MMYQw==
X-CSE-MsgGUID: 9QUOdIUaRUO9MO1mKfn1Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117172376"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.81.210]) ([10.247.81.210])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:18:28 -0800
Message-ID: <8395554a-4aaf-45fb-a89d-34f5b10255fb@linux.intel.com>
Date: Thu, 27 Feb 2025 19:18:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/6] stmmac: intel: configure SerDes according
 to the interface mode
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 David E Box <david.e.box@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-5-yong.liang.choong@linux.intel.com>
 <Z782i67tlpj6d57m@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z782i67tlpj6d57m@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/2/2025 11:43 pm, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 03:48:35PM +0800, Choong Yong Liang wrote:
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index 6d2aa77ea963..af22a11c2b8a 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -236,6 +236,10 @@ struct plat_stmmacenet_data {
>>   	int (*serdes_powerup)(struct net_device *ndev, void *priv);
>>   	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
>>   	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
>> +	int (*mac_finish)(struct net_device *ndev,
>> +			  void *priv,
>> +			  unsigned int mode,
>> +			  phy_interface_t interface);
>>   	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
>>   	int (*init)(struct platform_device *pdev, void *priv);
>>   	void (*exit)(struct platform_device *pdev, void *priv);
> 
> This should be part of patch 5, and the order of patches 4 and 5
> reversed.
> 
> The subject line should also be "net: stmmac: ..."
> 
Thank you for your guidance. I will adjust the patch sequence as suggested 
and update the subject line to "net: stmmac: ...". I appreciate your 
attention to detail.

