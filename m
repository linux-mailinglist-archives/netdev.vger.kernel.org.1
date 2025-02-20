Return-Path: <netdev+bounces-167953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0CA3CF45
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4834916EC81
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A91C5D79;
	Thu, 20 Feb 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fplhP5QS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65614AD29;
	Thu, 20 Feb 2025 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017547; cv=none; b=dhFTp/wskWS/3t7Pvi6AmT6/Y7Lgbv3fs2yIOegBh84HEQaPZRem3Bo9f+HGh2r6KuF/4hkbRx7+a4e4YLlZ6LuaoePaLATiKjUbK9c++yVqULIfuWAOgA0+jRGA80toxItrWONjv2l3RDmjsIIgcBrxhb1dnXTB1a39TmWTu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017547; c=relaxed/simple;
	bh=4GOWM9o6duBwNSk0MN9yfWLhHhK9OLJQXgL3slB8rzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ml+p2UJ3V/lfMhkAy5CcC1Ap1TUwTXKuAqrp/gATotGsnOQuQi75rCn9KrAZj0ls+AKz8u09iLKkbXHhAAsK2flLBnj3WFn+5HWrl3wpZnPr81hi3wF2/31c6dhjRT8VxBqOFr+JquTPgcwn1m8Q5xiz/CD38k5NXQwfYQT1yjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fplhP5QS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740017545; x=1771553545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4GOWM9o6duBwNSk0MN9yfWLhHhK9OLJQXgL3slB8rzo=;
  b=fplhP5QSLzoCJGwatTqvOGwjdlloWZohx9a75Sz3slNIMZYVshsNbJQV
   XQKkc+jBlHA55mz4nFGZEssVIU+3tfHxMjwJdnn+rxi/ad4N63TyF+b73
   SCpPSzle8j29Lg+02F0UmQJVJnYrhpJeHB8pD4Or2ykS8PKh9eqAaHR2B
   rkdJBD98HbfJzrOfL8uGOSR4F1L12XoFBa19jrONQbF82LMhdGSinpcah
   3hW/kVYwjZ3RRN/IAP8m6WPr1zA21T+J3vfg3Z8zaQNjTsELMF+i4wO1k
   v6kmoHbgEpQIUbNS2TYZ8lK7/NRb/OxOvACHcCI2tAS7bMOEFvzru/nj1
   g==;
X-CSE-ConnectionGUID: 9Da3u3RZTIW6krSQ3RDifA==
X-CSE-MsgGUID: z8ovE+urTgi9tz7L/TcXQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44554551"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44554551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:12:24 -0800
X-CSE-ConnectionGUID: YqxEkxR6RByijTI3qHobrg==
X-CSE-MsgGUID: cCeY1AXzS7ODnxJwAyxXZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114738857"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.53.67]) ([10.247.53.67])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 18:12:17 -0800
Message-ID: <be0689a5-2202-4231-9e97-49e9576236a2@linux.intel.com>
Date: Thu, 20 Feb 2025 10:12:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/7] net: pcs: xpcs: re-initiate clause 37
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
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-3-yong.liang.choong@linux.intel.com>
 <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/2025 11:30 pm, Russell King (Oracle) wrote:
> Also, if the reset is required, what happens if we're already using
> SGMII, but AN has been disabled temporarily and is then re-enabled?
> Is a reset required?
> 

Hi Russell,

When we use SGMII with XPCS, the AN is disabled and then re-enabled. This 
process does not involve any PCS configuration, so a reset is not required.

I tested it with stmmac (dwmac5) + xpcs + Marvell (88E1510) PHY, and it 
works fine when AN is temporarily disabled and then re-enabled without a reset.

