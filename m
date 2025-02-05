Return-Path: <netdev+bounces-162890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94139A2849C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F8B3A6189
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862721D5AA;
	Wed,  5 Feb 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhPqipja"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1781ACA;
	Wed,  5 Feb 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738246; cv=none; b=H9/i2u+6qoiQAiBJPLBewl9NxZf5yUzp3gHI9wgqLo2QIvH7QILzriPysVepQTVjcvlz3+5PAYZDQHNMCotpuUV+pvaKpOgLplqsaZ0M6uMHkZOTttrUpq7ZTlrtRaI/5xZIUyaIZEhgw9oVM7ML/L0gI2QpwLjblC34v0MTUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738246; c=relaxed/simple;
	bh=55hxtyx4DMhF2qYY+kBeRk1DqvJKGJ9IUbKzhKO8vbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/EhxuY1VQiw0nvJF3TLZHpji+7makHByp2jbmjKgQFuMCoTmMEnNrRyTQ+5tvoyJ2ntJ/vhpV0UjfF/IzuwusTd+fXBvy9HWEI5ig48oIkCgcPAdofyQaXWY6CP4dOx9NXbSYKhTw+iOFJDlG1isczb4t+6KTagyHRt/N0XbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhPqipja; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738738245; x=1770274245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=55hxtyx4DMhF2qYY+kBeRk1DqvJKGJ9IUbKzhKO8vbg=;
  b=nhPqipjarUlvAQgFPw0DZquSzEriwI7ib5RgFAzJdk267ojoBmHAK8Cy
   tHcEyJtyYY78etwxTeKwx7b7qP2fTdNVKSjDjO+6/dO9zY2OOYH2bJset
   8AJI1Rbg0ihZ3Aouhib5q0cbPUK4t2RBfHRh8TVGgQdmaJAexL7Z/HBJG
   c1EgAtctSooBTjxZ6Y5Xb6Ua+vr2agnxh/k2EFmtrmWSeT8aT2vlCWQi4
   UO+Igk8as8CqNoYLXyk772FCOBE7tZXbBOx4F8eWYL6g/SLyUkfJ5LDcM
   yrSzfV/plUwaPp+0EbbvrRgxnwF2zL8tz/Kn7j2icxVHoSRL9nqLaZm8A
   A==;
X-CSE-ConnectionGUID: n1DyovVeSVm4N8O9bareYg==
X-CSE-MsgGUID: vES0pDkRRKabU9xeLDhYaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39175591"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="39175591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:50:44 -0800
X-CSE-ConnectionGUID: oo32QqH1QrmHW2tYAHIDrw==
X-CSE-MsgGUID: W8AT1xq9Tz+DU8R6MpUXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="111400846"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.100.100]) ([10.247.100.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 22:50:35 -0800
Message-ID: <c25c2da7-18fa-46b7-b992-fb5b17a01749@linux.intel.com>
Date: Wed, 5 Feb 2025 14:50:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/7] net: phylink: use act_link_an_mode to
 determine PHY
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
 Andrew Halaney <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-2-yong.liang.choong@linux.intel.com>
 <Z6ICO06RbJ1ulDh1@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z6ICO06RbJ1ulDh1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/2025 8:04 pm, Russell King (Oracle) wrote:
> On Tue, Feb 04, 2025 at 02:10:14PM +0800, Choong Yong Liang wrote:
>> When the interface mode is SGMII and act_link_an_mode is MLO_AN_INBAND,
>> switching to the 2500BASE-X interface mode will trigger
>> phylink_major_config, and act_link_an_mode will be updated to MLO_AN_PHY
>> in phylink_pcs_neg_mode when the PCS does not support in-band mode.
>> The MAC and PCS will configure according to the interface mode
>> and act_link_an_mode.
> 
> act_link_an_mode must only ever be updated by phylink_major_config()
> since it defines state for the currently configured mode, and must
> stay in sync with how the hardware has been programmed at all times.
> 
>> However, when the interface goes link down and then link up again, the MAC
>> will attempt to attach the PHY.
> 
> Why is the MAC trying to disconnect and reconnect the PHY on link
> changes? Do you really mean "link down" and "link up" as in "connection
> with the link partner" or do you mean administratively taking the
> interface down and up (which is a completely different thing.)
> 

The "link down" and "link up" I mention in this part refer to using the 
command:
ifconfig <interface> down/up

>> The interface mode remains as 2500BASE-X,
>> but cfg_link_an_mode still holds MLO_AN_INBAND. This causes a failure to
>> attach the PHY.
> 
> Hmm.
> 
> pl->link_interface is the configured setting from firmware etc and doesn't
> change.
> 
> pl->cfg_link_an_mode is the configured mode from firmware etc which was
> passed to phylink_create(), and again doesn't change.
> 
> So there should be no difference unless something weird is going on,
> which as you're talking about stmmac, could be the case.
> 

Thank you for pointing that out.

I think I was confused between pl->link_interface and
pl->link_config.interface. The function phylink_attach_phy() uses
pl->link_interface, whereas phylink_expects_phy() uses
pl->link_config.interface.

When the interface switches from SGMII to 2500BASE-X,
pl->link_config.interface is updated by phylink_major_config().
So, when the STMMAC link goes down and comes up again,
it is blocked by phylink_expects_phy().
At this point, pl->cfg_link_an_mode is MLO_AN_INBAND and 
pl->link_config.interface is 2500BASE-X.

Since phylink_expects_phy() is trying to achieve the same checking 
condition as phylink_attach_phy(), it should use pl->link_interface for the 
check as well.

Does that make sense to you?

> More information needed, but as this patch currently stands, I deem it
> to be incorrect, sorry.
> 


