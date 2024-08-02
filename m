Return-Path: <netdev+bounces-115234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137919458F8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B302825DB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583564D8C1;
	Fri,  2 Aug 2024 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqclBVRo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CB482EF
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584238; cv=none; b=VnSD6pYryQH+bWc4+LwbzJ48hYeKqBm/kqevld6dMXtEx5RUEOzGN6mLCIPUJafoh7tmSgyVsb1I6iT2mhjEC7kLHsHwxDAFLH9k7yQ2qvAu8n9zHY2fipILIrQMvP6fPzIzBFI4aI+Cd5zhNTl7wTAFWOBXAzohNikzlqBs/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584238; c=relaxed/simple;
	bh=ycq+XrYjnqcQRkpIENu5ivOT7v3kv2ICbehnIeyC+yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgpY9Qhx0hL5DLCEwigcO9vzMHoVtAb+ww+YRHJ4aeZS+BVJAYqy23YnQZ8JF/2+MNj81yiWfuI/Glo7JhiH85AqtMaSj2eV61V43NZb69M5WWWvwJQ/p7/9FD58MxHbgEfN5ptuepby66wMuI7xzSERyHLRsL3EbwyYy7l9Gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqclBVRo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722584237; x=1754120237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycq+XrYjnqcQRkpIENu5ivOT7v3kv2ICbehnIeyC+yY=;
  b=gqclBVRoHNIEqh7PRg2pG/NFlN5r8EW4c3u3IeT/ozQ8TpFUWxCqYKfh
   fIXqWIG6gCncp7oMX+gwB/dYvKxTOsJ3VpmVMTTHNdR4/mdr+Ja/nt9sB
   /ixOADDWS5EZ8bOacSTmhMDLMIQ14UNVBRCQBLRudG9E0kHca8mZvlUJ8
   zu51cGu5LC+D7DvkZ8oCRLwE1juLKTVyqHsuymZHXdDngBPa/sZJOilcJ
   C5IGQyMcz741cdB4Pp8zkqVllmPhH0G6DsrLxVaCkxVGut7XJucIIETwx
   wByMxqRNwelQ6goUSpQC7PokpGyJBuK+A2+Q7haaAH7XHv+h454jUBqYe
   w==;
X-CSE-ConnectionGUID: nYPjYh3FRLKvSoPKNeYlTA==
X-CSE-MsgGUID: qvE9llitQPutONQSAc+XEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24459195"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24459195"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:37:16 -0700
X-CSE-ConnectionGUID: TjnjkFfySCGhkKtbVM2e7Q==
X-CSE-MsgGUID: KxYg9q5PQJyin2H+IqNFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55916018"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:37:11 -0700
Date: Fri, 2 Aug 2024 09:35:28 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqyMQPNZQYXPgiQL@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion>
 <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
 <ZqyDNU3H4LSgkrqR@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqyDNU3H4LSgkrqR@nanopsycho.orion>

On Fri, Aug 02, 2024 at 08:56:53AM +0200, Jiri Pirko wrote:
> Fri, Aug 02, 2024 at 07:11:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
> >> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
> >> >Michal Swiatkowski says:
> >> >
> >> >Currently ice driver does not allow creating more than one networking
> >> >device per physical function. The only way to have more hardware backed
> >> >netdev is to use SR-IOV.
> >> >
> >> >Following patchset adds support for devlink port API. For each new
> >> >pcisf type port, driver allocates new VSI, configures all resources
> >> >needed, including dynamically MSIX vectors, program rules and registers
> >> >new netdev.
> >> >
> >> >This series supports only one Tx/Rx queue pair per subfunction.
> >> >
> >> >Example commands:
> >> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> >> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> >> >devlink port function set pci/0000:31:00.1/1 state active
> >> >devlink port function del pci/0000:31:00.1/1
> >> >
> >> >Make the port representor and eswitch code generic to support
> >> >subfunction representor type.
> >> >
> >> >VSI configuration is slightly different between VF and SF. It needs to
> >> >be reflected in the code.
> >> >---
> >> >v2:
> >> >- Add more recipients
> >> >
> >> >v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
> >> 
> >> I'm confused a bit. This is certainly not v2. I replied to couple
> >> versions before. There is no changelog. Hard to track changes :/
> >
> >You can see all changes here:
> >https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/
> >
> >This is pull request from Tony, no changes between it and version from
> >iwl.
> 
> Why the changelog can't be here too? It's still the same patchset, isn't
> it?
> 

Correct it is the same patchset. I don't know, I though it is normal
that PR is starting from v1, feels like it was always like that.
Probably Tony is better person to ask about the process here.

> >

