Return-Path: <netdev+bounces-240672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B423C77816
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F6F4E5D9E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205F29D29C;
	Fri, 21 Nov 2025 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coHAvNQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0863824BD;
	Fri, 21 Nov 2025 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705310; cv=none; b=f447O7FhSh7ObWZObQ+x7Orn7Rw3N7Nvs39gSFkehPTaT8frNTs7AKdhYr9qzCFrdoQRPEx/HhUqgkDHUfbCkLkzATWTgIXaenOoGdqFKG9rS+Fs615xKYW8XPlVHxEKLrD0qDQVyj1w4sG2CXNQxkU9yxtTTm8v9cktE8o3pSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705310; c=relaxed/simple;
	bh=cNczm5/+RlqqJ1v2QtDGwSCsVdfhdW3CsC3t9AGYG9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcL2ZS626j7cvJzp2ccyRgH/kTNi8KuWDonOY0v+yWvB+TWVE5gfAN6mX+MzEqg0PIYaI8R7FNl+GtUQMlVkydMwycF+uBgxbYe1iNXv9dMlsx7j/EzwNGO57cs64fz06w7WobphagpuTlkkx7/GKsuZdX6YIg8FzV31xP3PceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coHAvNQ6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763705309; x=1795241309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cNczm5/+RlqqJ1v2QtDGwSCsVdfhdW3CsC3t9AGYG9Q=;
  b=coHAvNQ6/FuE4MVvBijq93yKqSLXOGcIh/fxj3icNXrFXbXR1j3Yq7ig
   AXwPOwNaYmi5F6rkNLYo2iggHZ1WKqshSjg9Ql95WHdzlHEm//LQvGUWW
   RlsitRuUnUIkZyCkDd159oqLjdFKg12oyKZ5ml0kQBz6VJ6Nm2YraJaE8
   94hqk9pOt7WDuJxKMv59fEfCP74Pm59QT0l3UmCTj2eIvToTXfM5mCUFm
   TY6+B+g4jBOEWhBIxj9eqmUViMz/aIlwU4W9FxIPc6r38o7MCPH0mA8Cm
   /k/yZuqhb0OEKN0e7ra+7Ohul/kzXP4l2EmS8CgijDiecZufk/3Gvvzz7
   A==;
X-CSE-ConnectionGUID: H8JrM/lsSguBthFz+RrL2A==
X-CSE-MsgGUID: b3cGRm43TBGPCCkJbBCLEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65725384"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="65725384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 22:08:28 -0800
X-CSE-ConnectionGUID: PXAzYCOBSb2AU1iRA1t0BQ==
X-CSE-MsgGUID: 7Mb+5zsyTWyAh+tiTzKgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="192059215"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 20 Nov 2025 22:08:26 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 211F396; Fri, 21 Nov 2025 07:08:25 +0100 (CET)
Date: Fri, 21 Nov 2025 07:08:25 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ian MacDonald <ian@netstatz.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad
 bonding
Message-ID: <20251121060825.GR2912318@black.igk.intel.com>
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>

Hi Ian,

On Thu, Nov 20, 2025 at 03:59:15PM -0500, Ian MacDonald wrote:
> Hi,
> 
> Using two Thunderbolt network interfaces as slaves in a bonding device
> in mode 802.3ad (LACP) fails because the bonding driver cannot set the
> MAC address on the thunderbolt_net interfaces. The same setup works in
> mode active-backup.
> 
> Hardware: AMD Strix Halo (Framework connect to Sixunited AXB35 USB4 ports)
> Kernel:  6.12.57 (also reproduced on 6.16.12 and 6.18~rc6)

Okay "breaks" is probably too strong word here. It was never even supported
:)

> 
> Steps to reproduce:
> 1. Create a bond with mode 802.3ad and add thunderbolt0 and thunderbolt1
>    as slaves.
> 2. Bring up the bond and slaves.

Can you describe what are the actual commands you run so I can try to
setup on my side and see how this could be implemented?

> 3. Observe that bonding fails to set the slave MAC addresses and logs:
> 
>    [   25.922317] bond0: (slave thunderbolt0): The slave device
>    specified does not support setting the MAC address
>    [   25.922328] bond0: (slave thunderbolt0): Error -95 calling
>    set_mac_address
>    [   25.980235] bond0: (slave thunderbolt1): The slave device specified
>    does not support setting the MAC address
>    [   25.980242] bond0: (slave thunderbolt1): Error -95 calling
>    set_mac_address
> 
> Expected result:
> - bond0 and both Thunderbolt interfaces share bond0's MAC address.
> - 802.3ad operates normally and the link comes up.
> 
> Actual result:
> - dev_set_mac_address(thunderboltX, bond0_mac) fails with -EOPNOTSUPP.
> - bonding reports that the slave does not support setting the MAC address
>   and cannot use the interfaces in 802.3ad mode.
> 
> >From reading drivers/net/thunderbolt/main.c:
> 
> - thunderbolt_net generates a locally administered MAC from the
>   Thunderbolt UUID and sets it with eth_hw_addr_set().
> - The net_device_ops for thunderbolt_net currently define:
>     .ndo_open
>     .ndo_stop
>     .ndo_start_xmit
>     .ndo_get_stats64
>   but do not implement .ndo_set_mac_address.
> 
> As a result, dev_set_mac_address() returns -EOPNOTSUPP and bonding treats
> the device as not supporting MAC address changes.
> 
> A bit of research suggests it should be possible to implement
> ndo_set_mac_address using
> eth_mac_addr(), and, if appropriate, mark the device with
> IFF_LIVE_ADDR_CHANGE so MAC changes while the interface is up are
> allowed.   I have a feeling there is a lot more to it;

Probably, I need to check this but first I need some way how to reproduce
this :)

> 
> There is a corresponding downstream Debian bug with additional
> hardware details https://bugs.debian.org/1121032
> 
> Thanks,
> Ian

