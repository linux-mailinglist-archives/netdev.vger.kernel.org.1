Return-Path: <netdev+bounces-167956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E701A3CF5F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE19F16BBD6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831891D54D1;
	Thu, 20 Feb 2025 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8w2jzFB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420361CDA0B;
	Thu, 20 Feb 2025 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018584; cv=none; b=lsvM96X7z8NQ8/Km8JM6coL5tH5IgYGZ1SSQeR2UkYr3yt7BCanDFUDa4LJkbvcnJdN6F1wCADPNyU3s6vI3MIVkCsbhhsIr8awAdVXbdTBFeR/SdSZWP7//DXbrvujs7SUPmWHl345Gf4Mf1Thf3W3NLppVFfyB7gIbFOS30Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018584; c=relaxed/simple;
	bh=qHJy/wVMlxB0RzaDnffLNI7sYULYz+gIzJ4B57XyBGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQglsCGF3uUNxP0bv3cs6vfzQrbnhT7y/m8Vfe0aFdpqgZlK9OsefjatvMEaqiAre9t3YmkYER99LC2+GgKJdkA4O9YQxqdzvw5q5H0aGQbTwUU7rR+xxki7lpWdc88XTg/PtBfECQ7jA+PydtWe3y36zYnFH/ZrWLt5qOT6fFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8w2jzFB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740018582; x=1771554582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHJy/wVMlxB0RzaDnffLNI7sYULYz+gIzJ4B57XyBGM=;
  b=T8w2jzFBD2L/Lc05xl6Qe+LwU33TLhHTUtsz9GXS3wKy/gHflQblIt17
   qIu3uc5Yjc6zP286KxBq+2JYunNzGqcZKG5q/7uADVfIG9SmWrhyXXNWl
   Qc7VwThWPyJcxD6wdBFoZU3CnJIs/s3tiq+n65SM9R/gZQhLxO1sup1Mb
   jgkwcOp2YgSqU9ky8w6r5w1Jh3526gEq3dhcaMXj83rWwoDiIKkUdgsbE
   Xipucw1VOZeBP9JAwxjbFLKM+kBSzrb4jY7buELHZRDt/gqdxaHNKtRAN
   TE/V1yzbciay77y8O0ZMBDbBZIB4F/6H3CN6bdJ4izQzQBE+1mmtFpKuF
   Q==;
X-CSE-ConnectionGUID: BXsuu4ihQzSUEW78DqUT0A==
X-CSE-MsgGUID: I7Z1Y4dlSw+umG/1IcKWvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="28378259"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="28378259"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:29:41 -0800
X-CSE-ConnectionGUID: ZqGHmeIwRl65QQYDBiVAyw==
X-CSE-MsgGUID: 0W87J4dIQfylMzMyKIP0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115572775"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.53.67]) ([10.247.53.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:29:34 -0800
Message-ID: <0307750b-dd98-4718-8c3c-928df6a80ef5@linux.intel.com>
Date: Thu, 20 Feb 2025 10:29:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/7] arch: x86: add IPC mailbox accessor
 function and add SoC register access
To: david.e.box@linux.intel.com, Dave Hansen <dave.hansen@intel.com>,
 Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-4-yong.liang.choong@linux.intel.com>
 <063bd012-d377-4d3d-9dcc-57e360d8f462@intel.com>
 <4cf99d5f9b63aec22c24c445dea9a80d71f5f024.camel@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <4cf99d5f9b63aec22c24c445dea9a80d71f5f024.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/2/2025 1:01 am, David E. Box wrote:
> On Thu, 2025-02-06 at 08:46 -0800, Dave Hansen wrote:
>> On 2/6/25 05:18, Choong Yong Liang wrote:
>>>
>>> - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
>>> - Add support to use IPC command allows host to access SoC registers
>>> through PMC firmware that are otherwise inaccessible to the host due
>>> to security policies.
>> I'm not quite parsing that second bullet as a complete sentence.
>>
>> But that sounds scary! Why is the fact that they are "otherwise
>> inaccessible" relevant here?
> 
> The PMC IPC mailbox is a host interface to the PMC. Its purpose is to allow the
> host to access certain areas of the PMC that are restricted from direct MMIO
> access due to security policies. Other parts of the PMC are accessible via MMIO
> (most of what the intel_pmc_core driver touches with is MMIO), so I think the
> original statement was trying to explain why the mailbox is needed instead of
> MMIO in this case. However, I agree that the mention of security policies is not
> relevant to the change itself.
> 
>> ...
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 87198d957e2f..631c1f10776c 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -688,6 +688,15 @@ config X86_AMD_PLATFORM_DEVICE
>>>   	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
>>>   	  implemented under PINCTRL subsystem.
>>>   
>>> +config INTEL_PMC_IPC
>>> +	tristate "Intel Core SoC Power Management Controller IPC mailbox"
>>> +	depends on ACPI
>>> +	help
>>> +	  This option enables sideband register access support for Intel
>>> SoC
>>> +	  power management controller IPC mailbox.
>>> +
>>> +	  If you don't require the option or are in doubt, say N.
>>
>> Could we perhaps beef this up a bit to help users figure out if they
>> want to turn this on? Really the only word in the entire help text
>> that's useful is "Intel".
>>
>> I'm not even sure we *want* to expose this to users. Can we just leave
>> it as:
>>
>> 	config INTEL_PMC_IPC
>> 		def_tristate n
>> 		depends on ACPI
>>
>> so that it only gets enabled by the "select" in the other patches?
> 
> I agree with this change Choong. This can be selected by the driver that's using
> it. There's no need to expose it to users.
> 
>>
>>> + * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>>> + *          David E. Box <david.e.box@linux.intel.com>
>>
>> I'd probably just leave the authors bit out. It might have been useful
>> in the 90's, but that's what git is for today.
>>
>>> +	obj = buffer.pointer;
>>> +	/* Check if the number of elements in package is 5 */
>>> +	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count ==
>>> 5) {
>>> +		const union acpi_object *objs = obj->package.elements;
>>> +
>>
>> The comment there is just not super useful. It might be useful to say
>> *why* the number of elements needs to be 5.
>>
>>> +EXPORT_SYMBOL(intel_pmc_ipc);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Intel PMC IPC Mailbox accessor");
>>
>> Honestly, is this even worth being a module? How much code are we
>> talking about here?
> 
> Yeah, this doesn't need to be a module either.
> 
> David
> 

Hi David,

Thank you for the confirmation.
Let's work together to address the comments.

