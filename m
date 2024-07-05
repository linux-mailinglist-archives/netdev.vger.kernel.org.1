Return-Path: <netdev+bounces-109389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC59283BC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3471F23824
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2D145FFF;
	Fri,  5 Jul 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2N8wSTK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532C145FE4;
	Fri,  5 Jul 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168522; cv=none; b=jAlYhe7t7KhKDm1UcdfPaH5ydSUY/jOnGX5Y+HhHdBtojph5b7cdNqJ6i9K8DQwMAa5nJF42l6ShOve0G04pKtUzprvNdZBgFuK6EDrHqdA1FD/+NydSsGYUBDYmzmTNi85Qu483Lo0INDUSCO4Ahg4j++KYbdwlPi9qG2stFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168522; c=relaxed/simple;
	bh=gf2Z6osiPRmJiRdRHwZubGcnWfc0XV+O1XIysU4R8HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSt3n+fvPZBjOb/JDkZQUyOtbv3v+YV4C1s0rWhCm70EzFGZndIikajPqSnOA5SxpG7Wd/trcH5Lqj18g0laLeYbbpmAn/CyH5AVp2AYjS1TG6AI0QncURo/v19LiiCF/DZGfAb1md/pcwJmP/GFXoFMBULHniUYJVjy5USsX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2N8wSTK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720168521; x=1751704521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gf2Z6osiPRmJiRdRHwZubGcnWfc0XV+O1XIysU4R8HM=;
  b=c2N8wSTKEq+Ts17+i4fSN8w1z/OzVwQ4OY7P/U6Es1xpaCugBsmjY/3C
   0TefB1/JL5SyvQqqS18HxgXyM7QpIQClhaKje12DQF5jZcKKq1b/xnz44
   aRxkybLJLKmekdTPc7DlDpMTlKDElA4/69k1xxIUDmEmpBTAQ56xVLVUD
   NMFj7nefoarzRyut4AcK5Q4EsX1/dqSsfOqkTpLNT4jZxJjBePCTYkoV6
   0J226RERMDNjnwEhqPaOpzvlc34olW8XY7hlLNRTMnjOXdGSHKXJkQV20
   UBpjD1AszUHUKluAAPawadTAnRCV3qoOfynCzkWy5912thr4fkgjsXMSa
   Q==;
X-CSE-ConnectionGUID: C4hmoIpcTKaGmsDq/XYghw==
X-CSE-MsgGUID: AVLTyq3qS8auey6aT9KMmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17560012"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17560012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 01:35:20 -0700
X-CSE-ConnectionGUID: JWuVa9zHQ0WHVgPiYzImKA==
X-CSE-MsgGUID: HVWb+hhKRSSdq+IVbnzHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46758575"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 01:35:18 -0700
Date: Fri, 5 Jul 2024 10:34:03 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Message-ID: <Zoev+zu3WXyPZ8Hv@mev-dev.igk.intel.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
 <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZoZL7Hc5l3amIxIs@mev-dev.igk.intel.com>
 <CH0PR18MB4339C05B5CC43E7005F2D469CDDE2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB4339C05B5CC43E7005F2D469CDDE2@CH0PR18MB4339.namprd18.prod.outlook.com>

On Thu, Jul 04, 2024 at 01:48:23PM +0000, Geethasowjanya Akula wrote:
> 
> 
> >-----Original Message-----
> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Sent: Thursday, July 4, 2024 12:45 PM
> >To: Geethasowjanya Akula <gakula@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
> >davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> >Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> ><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> >Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
> >representors
> >
> >On Wed, Jul 03, 2024 at 02: 34: 03PM +0000, Geethasowjanya Akula wrote: > >
> >> >-----Original Message----- > >From: Michal Swiatkowski
> ><michal. swiatkowski@ linux. intel. com> > >Sent: Wednesday, July 3, 2024 4: 14
> >PM 
> >On Wed, Jul 03, 2024 at 02:34:03PM +0000, Geethasowjanya Akula wrote:
> >>
> >>
> >> >-----Original Message-----
> >> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >Sent: Wednesday, July 3, 2024 4:14 PM
> >> >To: Geethasowjanya Akula <gakula@marvell.com>
> >> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> >kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> >edumazet@google.com; Sunil Kovvuri Goutham
> ><sgoutham@marvell.com>;
> >> >Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> ><hkelam@marvell.com>
> >> >Subject: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
> >> >representors On Fri, Jun 28, 2024 at 07:05:07PM +0530, Geetha sowjanya
> >wrote:
> >> >> This series adds representor support for each rvu devices.
> >> >> When switchdev mode is enabled, representor netdev is registered
> >> >> for each rvu device. In implementation of representor model, one
> >> >> NIX HW LF with multiple SQ and RQ is reserved, where each RQ and SQ
> >> >> of the LF are mapped to a representor. A loopback channel is
> >> >> reserved to support packet path between representors and VFs.
> >> >> CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
> >> >> adds representor support for both RPM and SDP MAC interfaces.
> >> >>
> >> >> - Patch 1: Refactors and exports the shared service functions.
> >> >> - Patch 2: Implements basic representor driver.
> >> >> - Patch 3: Add devlink support to create representor netdevs that
> >> >>   can be used to manage VFs.
> >> >> - Patch 4: Implements basec netdev_ndo_ops.
> >> >> - Patch 5: Installs tcam rules to route packets between representor and
> >> >> 	   VFs.
> >> >> - Patch 6: Enables fetching VF stats via representor interface
> >> >> - Patch 7: Adds support to sync link state between representors and VFs .
> >> >> - Patch 8: Enables configuring VF MTU via representor netdevs.
> >> >> - Patch 9: Add representors for sdp MAC.
> >> >> - Patch 10: Add devlink port support.
> >> >>
> >> >> Command to create VF representor
> >> >> #devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
> >> >> representors are created for each VF when switch mode is set
> >> >> switchdev on representor PCI device
> >> >
> >> >Does it mean that VFs needs to be created before going to switchdev
> >> >mode? (in legacy mode). Keep in mind that in both mellanox and ice
> >> >driver assume that VFs are created after chaning mode to switchdev
> >> >(mode can't be changed if VFs).
> >> No. RVU representor driver implementation is similar to mellanox and ice
> >drivers.
> >> It assumes that VF gets created only after switchdev mode is enabled.
> >> Sorry, if above commit description is confusing. Will rewrite it.
> >>
> >
> >Ok, but why the rvu_rep_create() is called in switching mode to switchdev
> >function? In this function you are creating netdevs, only for PF representor? It
> >looks like it doesn't called from other context in this patchset, so where the
> >port representor netdevs for VFs are created?
> >
> RVU representors for PF/VFs are created when switchdev mode is set, similar to the bnxt and nfp drivers.
> rvu_rep_create() will create representors based on rep_cnt (which include both PFs and VFs count) 
> 

Sorry, I don't understand now. You wrote in previous message that VFs
should be created after switchdev mode is enabled. Now you are writting
that they are created based on rep_cnt (so assuming VFs have been
created before).

What is the correct order?
# echo 1 x > sriov_numvfs
# devlink dev eswitch set pci/0000:ca:00.0 mode switchdev 
or 
# devlink dev eswitch set pci/0000:ca:00.0 mode switchdev 
# echo 1 x > sriov_numvfs

or you can create VFs before and after? From looking at the drivers code
it looks like driver bnxt supports that.

I am not familiar with nfp and bnxt driver but based on code in current
kernel version it looks like nfp creates representor when switching mode
only for physical and PF types, VF representor type is created when the
VF is created. Bnxt support VF representor creation before and after
switching mode. In ice port representors are created during VFs creation
only.

I am not against your solution, only pointing that it can lead to some
problems.

Thanks,
Michal

> Thanks,
> Geetha.
> 
> >Thanks,
> >Michal
> >
> >> >
> >> >Different order can be problematic. For example (AFAIK) kubernetes
> >> >scripts for switchdev assume that first is switching to switchdev and
> >> >VFs creation is done after that.
> >> >
> >> >Thanks,
> >> >Michal
> >> >
> >> >> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev # ip
> >> >> link show
> >> >> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> >mode
> >> >DEFAULT group default qlen 1000
> >> >>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> >> >> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
> >mode
> >> >DEFAULT group default qlen 1000
> >> >>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> >> >>
> >> >> #devlink dev
> >> >> pci/0002:01:00.0
> >> >> pci/0002:02:00.0
> >> >> pci/0002:03:00.0
> >> >> pci/0002:04:00.0
> >> >> pci/0002:05:00.0
> >> >> pci/0002:06:00.0
> >> >> pci/0002:07:00.0
> >> >>
> >> >> ~# devlink port
> >> >> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller
> >> >> 0 pfnum 1 vfnum 0 external false splittable false
> >> >> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller
> >> >> 0 pfnum 1 vfnum 1 external false splittable false
> >> >> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller
> >> >> 0 pfnum 1 vfnum 2 external false splittable false
> >> >> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller
> >> >> 0 pfnum 1 vfnum 3 external false splittable false
> >> >>
> >> >> -----------
> >> >> v1-v2:
> >> >>  -Fixed build warnings.
> >> >>  -Address review comments provided by "Kalesh Anakkur Purayil".
> >> >>
> >> >> v2-v3:
> >> >>  - Used extack for error messages.
> >> >>  - As suggested reworked commit messages.
> >> >>  - Fixed sparse warning.
> >> >>
> >> >> v3-v4:
> >> >>  - Patch 2 & 3: Fixed coccinelle reported warnings.
> >> >>  - Patch 10: Added devlink port support.
> >> >>
> >> >> v4-v5:
> >> >>   - Patch 3: Removed devm_* usage in rvu_rep_create()
> >> >>   - Patch 3: Fixed build warnings.
> >> >>
> >> >> v5-v6:
> >> >>   - Addressed review comments provided by "Simon Horman".
> >> >>   - Added review tag.
> >> >>
> >> >> v6-v7:
> >> >>   - Rebased on top net-next branch.
> >> >>
> >> >> Geetha sowjanya (10):
> >> >>   octeontx2-pf: Refactoring RVU driver
> >> >>   octeontx2-pf: RVU representor driver
> >> >>   octeontx2-pf: Create representor netdev
> >> >>   octeontx2-pf: Add basic net_device_ops
> >> >>   octeontx2-af: Add packet path between representor and VF
> >> >>   octeontx2-pf: Get VF stats via representor
> >> >>   octeontx2-pf: Add support to sync link state between representor and
> >> >>     VFs
> >> >>   octeontx2-pf: Configure VF mtu via representor
> >> >>   octeontx2-pf: Add representors for sdp MAC
> >> >>   octeontx2-pf: Add devlink port support
> >> >>
> >> >>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> >> >>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> >> >>  .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> >> >>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
> >> >>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> >> >>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
> >> >>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> >> >>  .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> >> >>  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> >> >>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
> >> >>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
> >> >>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
> >> >>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
> >> >>  .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> >> >>  .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> >> >>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> >> >>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> >> >>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> >> >>  .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
> >> >>  .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
> >> >>  .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
> >> >>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
> >> >>  .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
> >> >>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> >> >>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
> >> >> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684
> >> >> ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h  |
> >> >> 53 ++
> >> >>  27 files changed, 1834 insertions(+), 227 deletions(-)  create
> >> >> mode
> >> >> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> >> >>  create mode 100644
> >> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> >> >>  create mode 100644
> >> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >> >>
> >> >> --
> >> >> 2.25.1
> >> >>

