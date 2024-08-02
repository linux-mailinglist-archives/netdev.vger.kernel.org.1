Return-Path: <netdev+bounces-115236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90AD945913
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C69F1F2321F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE0482CA;
	Fri,  2 Aug 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/ww133O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BD335C0
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584444; cv=none; b=lIEgmgK2tvZPPOexsiEhVVc6z7Lj6xuLojYcBbOSuiTGzcZxA/tRz1jfERO1YdwZwdPqENx2vfKLJWP8OxChHuJCkxiove4PQ10wdk3dMlV4WmdBtvS4Yz2xzfif8xe97B4xNqTc+5FcARMaZd5aaG49utbRtBbreEwLbQJj6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584444; c=relaxed/simple;
	bh=yf7JvjFb12zXoVgaLL+REN5LJTOUXS47VSPFf/+59z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXVBqIPtqvAJbGE48ijK/yWMivQ8Dz5RhCMtpY59SUBmw06MlVluoKqMdHxZFf7Pm0rG32iUHWUVVK/u1H/JPOuvTC6rRkOi9ub+WZIvqN5p0LF+98K4XIejkpTShfv5OQymQKLheTbthZClIhb6UsD78yr744MwNpJDpYDXDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/ww133O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722584443; x=1754120443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yf7JvjFb12zXoVgaLL+REN5LJTOUXS47VSPFf/+59z4=;
  b=U/ww133OWBWFGrKLhhvbjHuO6bnvLGx5Y1MVdtsRMUA35gTeHCGteD+a
   sGsVj1fE3SvRBQApjqZ1ZqUsrTR7L5ehwLvzp4GGCHDUwgpAqMyaGu1zv
   NLeZjb2cVpHoCtWAkeAgS+WztJ3XIJdkKUzHgKbcnk1mSf0K7FdxN959A
   ZTpg31maxGn5Tage852vrXY0fOMQBbcUVTCZtKzj324y7QBRDiyCqtwvs
   pNcaHSDbvddUHAGsfMfAgI1xcZR4/C5fZ0aDPvOCHOfQ+A8WWhfyG5vRT
   uW1dyXEsTIBNKYtHOyhUodvfOzrGCOXRi4oxv8GN131LH++iH+WU/d/1f
   Q==;
X-CSE-ConnectionGUID: n386TayiTDypti82Mkn8jQ==
X-CSE-MsgGUID: XoAzflV9SO27tUtTG9V7Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20172521"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20172521"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:40:42 -0700
X-CSE-ConnectionGUID: RrT9810NSoCGpQgaot80Sw==
X-CSE-MsgGUID: /K/yc8miRe6NoQcDm+qZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55239813"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:40:38 -0700
Date: Fri, 2 Aug 2024 09:38:55 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqyND4Z4217q+zE+@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqyK/xHkGEFEX+8Q@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqyK/xHkGEFEX+8Q@mev-dev.igk.intel.com>

On Fri, Aug 02, 2024 at 09:30:07AM +0200, Michal Swiatkowski wrote:
> On Wed, Jul 31, 2024 at 03:10:11PM -0700, Tony Nguyen wrote:
> > Michal Swiatkowski says:
> > 
> > Currently ice driver does not allow creating more than one networking
> > device per physical function. The only way to have more hardware backed
> > netdev is to use SR-IOV.
> > 
> > Following patchset adds support for devlink port API. For each new
> > pcisf type port, driver allocates new VSI, configures all resources
> > needed, including dynamically MSIX vectors, program rules and registers
> > new netdev.
> > 
> > This series supports only one Tx/Rx queue pair per subfunction.
> > 
> > Example commands:
> > devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> > devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> > devlink port function set pci/0000:31:00.1/1 state active
> > devlink port function del pci/0000:31:00.1/1
> > 
> > Make the port representor and eswitch code generic to support
> > subfunction representor type.
> > 
> > VSI configuration is slightly different between VF and SF. It needs to
> > be reflected in the code.
> > ---
> > v2:
> > - Add more recipients
> > 
> > v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
> > 
> > The following are changes since commit 990c304930138dcd7a49763417e6e5313b81293e:
> >   Add support for PIO p flag
> > and are available in the git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> > 
> > Michal Swiatkowski (8):
> >   ice: treat subfunction VSI the same as PF VSI
> >   ice: make representor code generic
> >   ice: create port representor for SF
> >   ice: don't set target VSI for subfunction
> >   ice: check if SF is ready in ethtool ops
> >   ice: implement netdevice ops for SF representor
> >   ice: support subfunction devlink Tx topology
> >   ice: basic support for VLAN in subfunctions
> > 
> > Piotr Raczynski (7):
> >   ice: add new VSI type for subfunctions
> >   ice: export ice ndo_ops functions
> >   ice: add basic devlink subfunctions support
> >   ice: allocate devlink for subfunction
> >   ice: base subfunction aux driver
> >   ice: implement netdev for subfunction
> >   ice: allow to activate and deactivate subfunction
> > 
> >  drivers/net/ethernet/intel/ice/Makefile       |   2 +
> >  .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
> >  .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> >  .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
> >  .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
> >  drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> >  drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> >  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> >  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
> >  drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> >  drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> >  drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
> >  drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> >  drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> >  .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> >  .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> >  drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> >  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> >  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> >  drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> >  26 files changed, 1396 insertions(+), 137 deletions(-)
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
> > 
> > -- 
> > 2.42.0
> > 
> 
> [offlist]

Sorry, for that, forgot to remove CC, before sending. Hope it is not a
problem.

Mail client should have feature like for attachments:
"There is offlisti keyword, are you sure you want to CC someone" :p

> 
> Hi Tony,
> 
> Am I correct that now I should send v6 to iwl (+CC netdev) when you
> remove the patchset from dev-queue? I am little confused with Jiri
> comment about versioning PR. I though it is usuall thing.
> 
> I already have done the changes that Jiri asked for (and Maciej from
> previous version).
> 
> Thanks,
> Michal

