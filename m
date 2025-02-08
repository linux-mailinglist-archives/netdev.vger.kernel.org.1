Return-Path: <netdev+bounces-164280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280AA2D381
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793403A4549
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB46153BD7;
	Sat,  8 Feb 2025 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrWCyfyD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5A611E;
	Sat,  8 Feb 2025 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738985631; cv=none; b=MYuhKtwlYrH887i1B5PoEajS76d9jwCxArey3Pt1wDSLaLFCYHjQFHRq3OjAQtBaYBIelkc/oTzM06BPoPckRXEGVUjcsdE+UTFmuTTxyQHxE2YsSO2wo8xKrRNUe9bd9ojab4WFTK5AdYg9mHHVIm06dWruedVLlj5ZK/gMKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738985631; c=relaxed/simple;
	bh=E4ef/ftjH8Y83ESfkZ/ek4OwMIc3mSgBksj42G9pEyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul9pRFqSUXXvr9Yc1YIcaYE0qjvZCEVE+Q18dqvfLisHYZ34HyDCEg5aAnlsz5Lgjeo1I4MWZITUj/gSjv+76nofXiM2ugqM8g8uXs2eswBgBGDFM6pqnMmEmSNeHG9/yzfmFLFnuEhXr0AzE6GBm6wpzsw/fPFNmX2js0YZKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrWCyfyD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738985629; x=1770521629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4ef/ftjH8Y83ESfkZ/ek4OwMIc3mSgBksj42G9pEyE=;
  b=JrWCyfyDRTOUk0ngRY1C6TlxxztxhAuYGx0241kebH9QXtskTfEqynL7
   LcP5cQHqCRGFLlx8g/bRNaQh+/b36nGXmXJxGXuWxAlql40gede9SWN2I
   ek4aDW99n4kC+Bixd2+Ep9m24/yDbQJybBqqaM/bvdK9TG0A13tGJ4+RU
   vUMj6cxeF6dvmgJ4aPo6yCJiajnURrPfQxfwkdrhNuuPZoLGX3i9unG1z
   apfqvCfHYdiNR7iNYjCaipJ7uRoI87R8TJp+vIHOOpFxyy1+BiBsJuvZ2
   fKrpQPHhzQaGpkosgpeNSrz62QsfvjrxV4wZGqWMRmGPtc5ETCIT6vkfu
   w==;
X-CSE-ConnectionGUID: IYAVMl0NSkuhQGMCWUWMTg==
X-CSE-MsgGUID: UkVjxFPiS7eiJ1jNRFIsyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39541413"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39541413"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 19:33:48 -0800
X-CSE-ConnectionGUID: KfrjFuMpRnayDLYzhLb9nA==
X-CSE-MsgGUID: nahwQkBJSY+cDoGI/mkrIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111621205"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.21.123]) ([10.247.21.123])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 19:33:41 -0800
Message-ID: <71887246-d30f-4134-8c6d-b379477b2457@linux.intel.com>
Date: Sat, 8 Feb 2025 11:33:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/7] net: pcs: xpcs: re-initiate clause 37
 Auto-negotiation
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
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
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-3-yong.liang.choong@linux.intel.com>
 <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
 <564ede5d-9f53-40be-9305-63f63b384e15@linux.intel.com>
 <12e86fbe-9515-4b81-951c-8bf86e2939d6@lunn.ch>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <12e86fbe-9515-4b81-951c-8bf86e2939d6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/2/2025 9:32 pm, Andrew Lunn wrote:
>> Good point. I cannot find this scenario in the datasheet. Please allow me
>> some time to test this scenario. I will update you with the results.
> 
> By data sheet, do you mean documentation from Synopsis, or is this an
> internal document? Assuming the hardware engineers have not hacked up
> the Synopsis IP too much, the Synopsis documentation is probably the
> most accurate you have.
> 
>>> What about 1000BASE-X when AN is enabled or disabled and then switching
>>> to SGMII?
>>>
>> According to the datasheet, a soft reset is required.
> 
> Do you know if this is specific to Intels integration of the Synopsis
> IP, or this is part of the core licensed IP?
> 
> We need to understand when we need a quirk because intel did something
> odd, or it is part of the licensed IP and should happen for all
> devices using the IP.
> 
> 	Andrew
> 

Hi Andrew,

Thank you for your questions. Just to clarify, when I mention the 
"datasheet," I am referring to the documentation from "Synopsis - 
DesignWare Cores Ethernet PCS" and not specific to Intel's documentation.

