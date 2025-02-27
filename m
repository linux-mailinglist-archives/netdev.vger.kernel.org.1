Return-Path: <netdev+bounces-170194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158EA47BDC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52CC188DACE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA9022A816;
	Thu, 27 Feb 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0GodFDM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60321324D;
	Thu, 27 Feb 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655094; cv=none; b=cOAeawn0surdDQ5G+QIe7xWdSW5TfBV4b/wjDK/p4LmViyrIfHJ7y/ec2+9muNrWbF48QVzsHnx7HYfMX3s+irHVPXpMK0npNdx1+ol4jaA8vTHa7UGulbougsQE7ernID/vwEKHtx2FaPC8+trj6vbmOjS5NR9b2UqT43UYA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655094; c=relaxed/simple;
	bh=K9BvBv3hLYw0IGq8eJuii6hDq4mM87UTjkwNlZVz44I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFpyTHGNuT56YvViZTgeEZP6zPFf69BmGST18z++eSQylmWgDKLKj/6RbOgxHlJ5aL70Ml/Em5ORstvzgrTtM5SokMyglm6Q07sPN4XfFkUwBF4bs764ps9JITVnj1/yVhfBNzzrrzQJgyWS5oCgQLa81WWfpp6ok7SMYSspcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0GodFDM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740655093; x=1772191093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K9BvBv3hLYw0IGq8eJuii6hDq4mM87UTjkwNlZVz44I=;
  b=P0GodFDMBoFSHwz64pmcR4XSAZAWAyn1z8UM4Z4Kyz+Q37iAnXhhRpPx
   ySANvXdGi63KdLMqnPNwDYFNhoNabHj4jAzX0yVCCdQniiCnmAvhZLTxi
   zpbHaol7t+MCM/9JKOSHPC9RmW79+BQRnOrZvQSwGJAxBvd2DOnhfQS2W
   1hu7e7FadgT8vTDwh8MPbRaB0Sx8gvObMEkdIFSJ067I8j3nwgA1LE3W5
   1Z9bp2otGB1+f7wLT13XT/NX5WkJ+Lc2Nyr8knWvXHd8Unw4oaaKUF91x
   BaBb7SRGblN3/tBZZqSEizuWKbhqI+C5pJlutaznhlLWooWO/WR4uqSSa
   Q==;
X-CSE-ConnectionGUID: mW5lYEBvQP6jsUfHuph8KQ==
X-CSE-MsgGUID: 6IVdGN9EQ7GXMv7SWfPOCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58955533"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="58955533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:18:12 -0800
X-CSE-ConnectionGUID: PDI93uncReGm6znVKxCg+w==
X-CSE-MsgGUID: 4PYYlND1R6+gWOxBvTmk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117172348"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.81.210]) ([10.247.81.210])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:18:04 -0800
Message-ID: <55ddacb9-dc00-4477-aeab-9b8861563194@linux.intel.com>
Date: Thu, 27 Feb 2025 19:18:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/6] net: pcs: xpcs: re-initiate clause 37
 Auto-negotiation
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
 <20250226074837.1679988-3-yong.liang.choong@linux.intel.com>
 <Z78141ZNWEYDSi5l@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z78141ZNWEYDSi5l@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/2/2025 11:40 pm, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 03:48:33PM +0800, Choong Yong Liang wrote:
>> diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
>> index fc52f7aa5f59..f73ab04d09f0 100644
>> --- a/drivers/net/pcs/pcs-xpcs-wx.c
>> +++ b/drivers/net/pcs/pcs-xpcs-wx.c
>> @@ -172,11 +172,9 @@ int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
>>   		return 0;
>>   	}
>>   
>> -	if (xpcs->interface == interface && !txgbe_xpcs_mode_quirk(xpcs))
>> +	if (!txgbe_xpcs_mode_quirk(xpcs))
>>   		return 0;
>>   
>> -	xpcs->interface = interface;
>> -
> 
> ...
> 
>> --- a/drivers/net/pcs/pcs-xpcs.c
>> +++ b/drivers/net/pcs/pcs-xpcs.c
>> @@ -602,12 +602,37 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
>>   		__set_bit(compat->interface, interfaces);
>>   }
>>   
>> +static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
>> +				      phy_interface_t interface)
>> +{
>> +	int ret = 0;
>> +
>> +	if (xpcs->interface != interface) {
>> +		if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
>> +			ret = txgbe_xpcs_switch_mode(xpcs, interface);
>> +			if (ret)
>> +				return ret;
> 
> The above modification changes the functionality.
> 
> In the old code, txgbe_xpcs_switch_mode() does its work when
> xpcs->interface is not the same as interface OR txgbe_xpcs_mode_quirk()
> is true.
> 
> Your replacement code calls txgbe_xpcs_switch_mode() when
> xpcs->interface is not the same as interface, *and* it can do its
> work when txgbe_xpcs_mode_quirk() returns true.
> 
> So, e.g. when txgbe_xpcs_mode_quirk() returns false, but the interface
> changes, txgbe_xpcs_mode_quirk() used to do its work, but as a result
> if your changes, it becomes a no-op.
> 
> The point of txgbe_xpcs_mode_quirk() is to always do the work if it
> returns true, even if the interface mode doesn't change.
> 
> Therefore, this patch is logically incorrect, and likely breaks TXGBE.
> 
Thank you for pointing out the oversight. I will review the logic and make 
the necessary corrections to ensure the patch does not disrupt the expected 
behavior.

