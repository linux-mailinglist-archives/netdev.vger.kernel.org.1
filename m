Return-Path: <netdev+bounces-172354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77AFA54517
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89CC3A4987
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD86207E11;
	Thu,  6 Mar 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHIcHn8a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122B20766A;
	Thu,  6 Mar 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250391; cv=none; b=ScEWRtA99yQ7VRVwWgGoTRG6DIeEDMPcaLLpl4uL5jO6/5QhkYpbYMPGcrNjgvg/2tRF3I+SO3bmjE3n+ZpoxjM2SDonIjYc/0/glTXoDfn1MA9z9ZDHVFyzOvTvtFAjBXYy+3Yi8l1DQd61yvitmt+RdwrpVDQa+wrZcRoNq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250391; c=relaxed/simple;
	bh=7WIRXk0lkMJA49/eFijGOr0gBbp7GJYo8Y5tLpulrd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0YglU7bgXfubAss58Zs06rshjwxJd740ywIGDFUMInl8O1PawmLbe3wREuRH/+lrmTLtcsPZk23kh265uGkwMlJnk0psjp+mElcgn0Ca1VLhkVHYYTDL8CBCvh5F8LNmt1Al3LNJQB/VOMUG0ffub0MGylsi08f1frXk4Iy1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHIcHn8a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741250390; x=1772786390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7WIRXk0lkMJA49/eFijGOr0gBbp7GJYo8Y5tLpulrd0=;
  b=CHIcHn8aGLF3Rvn83/EBw/A1XT/L8p7LwK2bzwNJ8Z+HAsHI+/0qmXoP
   YCswzTRgOZXzNUrrEpDiRTKpYvXuKn6DyVp+Dn0HofFHAaeRDtjeNVtES
   P41PWn6QXSoqJLeWECDA8OXrpeWS2INs//onMKTOaM1ups9mLRQTbiXAS
   JIECvH5BNQ6nrTizjdMeEyl7eOilVj4cTUxUxz1QUEYWSbCJ8qLitDKRX
   b7aUP/mhclj6FL/27Une+unP8NM/2b1kAiRohQWiLAuON9Lr5c/9j0VPz
   d/bwOyr6LgwG28aiQjlr6Tm2GBAmMQ1hFPIh7s3sZOIHQ7OGAiAtpLUiq
   w==;
X-CSE-ConnectionGUID: 4IE0yel7QMadhQ/krFeRcQ==
X-CSE-MsgGUID: g2r0E/M3QTmuVDSKcpsQgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42162160"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42162160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:39:49 -0800
X-CSE-ConnectionGUID: E3nQX3CgSkGV1z1AAcpQgg==
X-CSE-MsgGUID: ytnhRbI4SIiTiI1GaBHdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118872684"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.67.95]) ([10.247.67.95])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:39:41 -0800
Message-ID: <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
Date: Thu, 6 Mar 2025 16:39:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
 <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
> Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:
>> Intel platform will configure the SerDes through PMC API based on the
>> provided interface mode.
>> This patch adds several new functions below:-
>> - intel_tsn_lane_is_available(): This new function reads FIA lane
>>    ownership registers and common lane registers through IPC commands
>>    to know which lane the mGbE port is assigned to.
>> - intel_mac_finish(): To configure the SerDes based on the assigned
>>    lane and latest interface mode, it sends IPC command to the PMC through
>>    PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
>> - intel_set_reg_access(): Set the register access to the available TSN
>>    interface.
> ...
> 
>> config DWMAC_INTEL
>>   	default X86
>>   	depends on X86 && STMMAC_ETH && PCI
>>   	depends on COMMON_CLK
>> +	depends on ACPI
> Stray and unexplained change. Please, fix it. We don't need the dependencies
> which are not realised in the compile time.
> 
> -- With Best Regards, Andy Shevchenko

Hi Andy,

The dependency on ACPI is necessary because the intel_pmc_ipc.h header 
relies on ACPI functionality to interact with the Intel PMC.

