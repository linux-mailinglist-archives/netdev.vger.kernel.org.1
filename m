Return-Path: <netdev+bounces-87269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C58A2678
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575891F24484
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABD241E2;
	Fri, 12 Apr 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOiJcXx4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244721C68A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903170; cv=none; b=nA7LRkWqZRwuhUfN70wm13qxdW/rNi8hUHwxLjDGWGuLqLlPUqRDVMwhxrru+HUT3q1SCQkSpSqVc+khGTW05UFUUrbNU2EbWw+NBsHs41T0AWALWISkBN4hc8YWenaWXrD8t92BkVfg81D+NGCAe9gTLROT/nTKgqzTM7yZCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903170; c=relaxed/simple;
	bh=jRcj2oxklJwGFoMTbd917djM/PGT7350Dviv7MmY+gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vvrpf/ANcvCZ+P6Xmk1Lv0cWLtDrYXIb8fUvtCd6BY/vo4sc+hjWH5VYBAn/T9etaVHHds2GC6CEHqvwx2XKYGbB6MRGig7Ce+qM5H4ISXZ5HantfNCmCMrNDQvOXj8sm30TJZvetRKniFDVRkkUlBE/8oBU2HW7nV4UABHQGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOiJcXx4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903169; x=1744439169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jRcj2oxklJwGFoMTbd917djM/PGT7350Dviv7MmY+gk=;
  b=SOiJcXx4zAFqX684jVr7SJ4AnW/0WLwgGPIYWC9EY/lMelgVcF5QhEd3
   joMTbs3kdy0p2oVp1r5CrnQ7/lhVbaEd3pjyXZAy2btoE6UILfxr3iMLa
   ouRlB9k8Y1lGl/OAmPYAqVBj1ZqpImFFSaeO+Zil5pcpBTBk2riw5HfDi
   koQOKSgQDiS96vKySxNSONr8DZtG5L7BysUlcGeRQeidfXfXl/ABQWytJ
   /LwCK1FtuZEDFbiaR9d4IdYD8lSzwMoaxJ/zR+pOVHXKL3z+kXLNkVxRo
   e3MD9P7vw4XE6HV32K/vjhgkRjNvgNIhv+GV93e4l/BrZnp6zCmOmO3XL
   A==;
X-CSE-ConnectionGUID: J0kfdXAVR8ind81GQU5bwg==
X-CSE-MsgGUID: hpwGaGJZRoO9NCZpjpVdgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18952918"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18952918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:26:08 -0700
X-CSE-ConnectionGUID: 4WEmUjD/S7ye6lxehmcKJA==
X-CSE-MsgGUID: l2RXEORcSDu96fzzPliawA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21105106"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2024 23:26:06 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v3 0/7] ice: support devlink subfunction
Date: Fri, 12 Apr 2024 08:30:46 +0200
Message-ID: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is second patchset split from subfunction patchset [1].
Important changes from previous version:
 * remove unnecessary checks for devlink port type
 * link correct devlink port to subfunction netdev

Follow up patchset with subfunction port representor will be the last
patchset for subfunction implementation in ice. It is a little
unpleasant to split it like that, because devlink port should be linked
with port representor netdev. In this patchset use devlink port without
linking it. It will be done correctly in the follow up when subfunction
port representor is available.

Currently ice driver does not allow creating more than one networking
device per physical function. The only way to have more hardware backed
netdev is to use SR-IOV.

Following patchset adds support for devlink port API. For each new
pcisf type port, driver allocates new VSI, configures all resources
needed, including dynamically MSIX vectors, program rules and registers
new netdev.

This series supports only one Tx/Rx queue pair per subfunction.

Example commands:
devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
devlink port function set pci/0000:31:00.1/1 state active
devlink port function del pci/0000:31:00.1/1

v2 --> v3: [3]
 * fix building issue between the patches; allocating devlink for
 subfunction need to include base subfunction header
 * fix kdoc issues

v1 --> v2: [2]
 * use correct parameters in ice_devlink_alloc() thanks to Mateusz

[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240408103049.19445-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240410050809.125043-1-michal.swiatkowski@linux.intel.com/

*** BLURB HERE ***

Piotr Raczynski (7):
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: allocate devlink for subfunction
  ice: base subfunction aux driver
  ice: implement netdev for subfunction
  ice: allow to activate and deactivate subfunction

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  50 +-
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 512 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  38 ++
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 317 +++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 15 files changed, 1047 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

-- 
2.42.0


