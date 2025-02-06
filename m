Return-Path: <netdev+bounces-163322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5EDA29EB3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D8C167B50
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BB85931;
	Thu,  6 Feb 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZX2O/dE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6C2A1BF;
	Thu,  6 Feb 2025 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808460; cv=none; b=b4ti2rLHBySq4cUrE33ZquVWfTXTpSYvNvXzlQWF/cxKoQ6de2rBGPZzEmUdG9+DS6fqHJTOz0+5m5k8ioksnbz7IUdODr+3u5acBNgyPR/YVOhPkxl1uYbP80Yz9ybaRCbcgW2W+6Iv0CwPLdfa73DBjoqC7OHBepNk/iXh0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808460; c=relaxed/simple;
	bh=zPwqGjttrG32SeOK9jJ5H18H/d8dhdmDbDCuLS50y9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOojUcaX/l5dB8G4nYOWtseuPPnlR1JCSb0WIJdEISmsALagKcfvU3pXqFb4g2fTlrUCvhEf4mrFkiVqJJXrwqyyhZVYO3r0zF3teZcqzDHMsYc7nZkkWP3djKk29/GMOS5DUTAQdr6BI5A8O//bLV5hFnPSatnQCCZ7Do4U2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZX2O/dE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738808459; x=1770344459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zPwqGjttrG32SeOK9jJ5H18H/d8dhdmDbDCuLS50y9c=;
  b=YZX2O/dEC4JOKdFyzrL7lpAso88AjKqh04MMemAbzrQBaHaGsgMSliP2
   2/zjVaQF0UfRPYya3qJ9PuxjbWiJbJkXUX8L8dnKWygjuvoy58R6jaEpW
   5odnCO376fFX59g5O7QL61Hynj9eA6HB89+fJzTBSQn/oK9oZBrVeHXVw
   JZEb0PKztSpN7DU5alSnK0f9/WrcxYuFbKA2npIEMNEDCw2dm99hPpMI9
   8Zrr4f2HyMdHQYlM77I99f9CoXGWHvvnqAJwhSd+7GV0z0t1KJ++lwGSN
   vNzwEjeKE108kIgP/JRFT4JaViMhc+ZAr6MGP+HjO/OQbzH3cM0HFNVZi
   Q==;
X-CSE-ConnectionGUID: jmiwDW0mReST9VbgUAWC3w==
X-CSE-MsgGUID: Jg9ISTuSR86cod8TtLi0lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39293304"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39293304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:20:58 -0800
X-CSE-ConnectionGUID: OK8fuaBZQQK2CspFAUPF7g==
X-CSE-MsgGUID: BWMiBxz9QR6bzBug7zF8uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="116069233"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.114.122]) ([10.247.114.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:20:50 -0800
Message-ID: <b0b9e3d4-5e65-491d-81c1-232520d73ab3@linux.intel.com>
Date: Thu, 6 Feb 2025 10:20:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes according
 to the interface mode
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Halaney <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
 <71b15c65-4790-50e0-fa96-dbc42c90079f@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <71b15c65-4790-50e0-fa96-dbc42c90079f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/2/2025 4:25 pm, Ilpo Järvinen wrote:
> On Tue, 4 Feb 2025, Choong Yong Liang wrote:
> 
> The logic could be reversed + return immediately to reduce the indentation
> of the block below.
> 
> If you just want to have them initialized, it's enough to use {}, no dummy
> 0 is necessary.
> 
> This looks somewhat ugly. Perhaps it would be better if you make the call
> on main level of the function and use local variables to hold the regs
> array and its number of elements until then.
> 
> It would be even better if you could just store the pointer and # of
> elements into some platform info structure so that it wouldn't need to be
> calculated on the fly here (but I don't know this driver well enough to
> know if that's viable/easy to do).
> 
> Why are these arrays in a header and not in the C file that uses them???
> 

Hi Ilpo,

Thank you for your detailed review and comments on the patch.

I'll reverse the logic in intel_tsn_lane_is_available, define the magic 
number, initialize arrays with {}, refactor intel_config_serdes, and move 
the arrays to the C file.


