Return-Path: <netdev+bounces-240683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D91C77CE3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9AD2C2AFE3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A77338930;
	Fri, 21 Nov 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2IpuauI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE05337B8A;
	Fri, 21 Nov 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712695; cv=none; b=eCaGaWRadNL4b16yxqD2W3istVOwtfMqCC0E+Qt+2LjZjjxoR32h2qUDy0OEZWcLutrHglYcO7IX8AhsWjEiyxbq5ppHKBIATh9noq3as5QY2XPKa3fZgRsyTJ4IL8U9F1w3OQgcd/Wm271RjLk+MgTDPhNFWYeWOD1jO+lRFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712695; c=relaxed/simple;
	bh=pW0UtR10YWkUN13SUy+0a/yKHaL/ruwN9XKz/Ak5/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPieTxjLdHhmwBf/zmfpTolv3SidSlI4VLqiIf9o7gq3fvbkJcYPT/yY5Vl1lyqoBTybny44lx8nmgJPjygdUsxqZn8OobmHJ0iqtfvqTT4O4s9u4tP8mepKUE1Mqrvjprr+YHREYlamybtUtZGvmeCSA3+v+uj302REJV+ggR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2IpuauI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763712693; x=1795248693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pW0UtR10YWkUN13SUy+0a/yKHaL/ruwN9XKz/Ak5/4Q=;
  b=j2IpuauIfZd6o10OhBUk2dbrXtNrCzojKMLuW7Vqhi7MSNSLWp9IRzs1
   J90hVY4AzxrZzPukjMq27qXYuNxJDan6UNhpo5XD7/OIo8JEXVYSyk3te
   JFIVn/1DkMdOVLTsI6zYwupTFU+UxFKMsGciAU3hJxHFFloncQc47nykJ
   H/fXzPUh241nbpseuymXSTs1DE+LwuAhDnefoMZNrw4Z5kex/Eks8YkFE
   8amXEYRFmQ+aNaB6r+fRldLwuQxlnmKO+9EbITH6lMlBxUiLs2Bi38x2u
   K7P5n5kz/+dYfSKgA5HrxEkX7jcSWGuInqcBYsPcc+HCe77JI0djc+RID
   A==;
X-CSE-ConnectionGUID: 5WrbQiBOQtedvSsgyb0VEQ==
X-CSE-MsgGUID: oxa8D5KgRM+hNQAni3eBrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="53373997"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="53373997"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 00:11:31 -0800
X-CSE-ConnectionGUID: j2r2rfMMS+OlQfqZjrItYg==
X-CSE-MsgGUID: aVeG8Nx5QAW9TNl/j3miGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="222275426"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2025 00:11:29 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id EC88096; Fri, 21 Nov 2025 09:11:27 +0100 (CET)
Date: Fri, 21 Nov 2025 09:11:27 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ian MacDonald <ian@netstatz.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad
 bonding
Message-ID: <20251121081127.GS2912318@black.igk.intel.com>
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121060825.GR2912318@black.igk.intel.com>

Hi,

On Fri, Nov 21, 2025 at 07:08:25AM +0100, Mika Westerberg wrote:
> Hi Ian,
> 
> On Thu, Nov 20, 2025 at 03:59:15PM -0500, Ian MacDonald wrote:
> > Hi,
> > 
> > Using two Thunderbolt network interfaces as slaves in a bonding device
> > in mode 802.3ad (LACP) fails because the bonding driver cannot set the
> > MAC address on the thunderbolt_net interfaces. The same setup works in
> > mode active-backup.
> > 
> > Hardware: AMD Strix Halo (Framework connect to Sixunited AXB35 USB4 ports)
> > Kernel:  6.12.57 (also reproduced on 6.16.12 and 6.18~rc6)
> 
> Okay "breaks" is probably too strong word here. It was never even supported
> :)
> 
> > 
> > Steps to reproduce:
> > 1. Create a bond with mode 802.3ad and add thunderbolt0 and thunderbolt1
> >    as slaves.
> > 2. Bring up the bond and slaves.
> 
> Can you describe what are the actual commands you run so I can try to
> setup on my side and see how this could be implemented?

Okay since the MAC address is not really being used in the USB4NET protocol
it should be fine to allow it to be changed.

The below allows me to change it using "ip link set" command. I wonder if
you could try it with the bonding case and see it that makes any
difference?

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index dcaa62377808..57b226afeb84 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops = {
 	.ndo_open = tbnet_open,
 	.ndo_stop = tbnet_stop,
 	.ndo_start_xmit = tbnet_start_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_get_stats64 = tbnet_get_stats64,
 };
 
@@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *dev)
 	hash = jhash2((u32 *)xd->local_uuid, 4, hash);
 	addr[5] = hash & 0xff;
 	eth_hw_addr_set(dev, addr);
+
+	/* Allow changing it if needed */
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 }
 
 static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
-- 
2.51.0


