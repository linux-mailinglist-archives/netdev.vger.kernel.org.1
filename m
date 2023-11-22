Return-Path: <netdev+bounces-50198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438F7F4E65
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9921F219C0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901D24B55;
	Wed, 22 Nov 2023 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF4is3aV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0201A5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700674256; x=1732210256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z8brI9tNy0NrCmpE93Mz4hoKxVhUfqeQxjFpq3MNoCg=;
  b=jF4is3aVp6w6yTi9WqvUdeWCcQ/dSyBfdvpln/ntNkT1HY+Gf4zm1jAm
   uLH21bvADKQFDKc1a545Kh1/7SW64axWOfJFEGDN1G0+mFPrvNb0IFOy4
   /SPwwtofPd9j7I9X4r9TPX9SlNUo73Jm7++cZvhIWkqPGqX2To0HpTumf
   3vvh84novIXrwe45lW1FQ6EfrEHQrQi1YqEnzfJBulO98PbHVLpExICmI
   6PYAKbHrsYMyEcjurZ+Dw38jvXv/WjoOIGApVOnPjni50otiho9irUuPI
   wCchIiHrsF6aU49yTZ7u0uetywjL6GOYKEqAbz1fmEgJ+w3lAgDE3/aXi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478305990"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="478305990"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 09:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="15346038"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 22 Nov 2023 09:30:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: linux-firmware@kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [linux-firmware v1 0/3][pull request] Intel Wired LAN Firmware Updates 2023-11-22
Date: Wed, 22 Nov 2023 09:30:36 -0800
Message-ID: <20231122173041.3835620-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the various ice DDP packages to the latest versions.

Thanks,
Tony

The following changes since commit 9552083a783e5e48b90de674d4e3bf23bb855ab0:

  Merge branch 'robot/pr-0-1700470117' into 'main' (2023-11-20 13:09:23 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware.git dev-queue

for you to fetch changes up to c71fdbc575b79eff31db4ea243f98d5f648f7f0f:

  ice: update ice DDP wireless_edge package to 1.3.13.0 (2023-11-22 09:14:39 -0800)

----------------------------------------------------------------
Przemek Kitszel (3):
      ice: update ice DDP package to 1.3.35.0
      ice: update ice DDP comms package to 1.3.45.0
      ice: update ice DDP wireless_edge package to 1.3.13.0

 WHENCE                                             |   8 ++++----
 ...e_comms-1.3.40.0.pkg => ice_comms-1.3.45.0.pkg} | Bin 725428 -> 733736 bytes
 ...1.3.10.0.pkg => ice_wireless_edge-1.3.13.0.pkg} | Bin 725428 -> 737832 bytes
 .../ice/ddp/{ice-1.3.30.0.pkg => ice-1.3.35.0.pkg} | Bin 692660 -> 692776 bytes
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename intel/ice/ddp-comms/{ice_comms-1.3.40.0.pkg => ice_comms-1.3.45.0.pkg} (89%)
 rename intel/ice/ddp-wireless_edge/{ice_wireless_edge-1.3.10.0.pkg => ice_wireless_edge-1.3.13.0.pkg} (88%)
 rename intel/ice/ddp/{ice-1.3.30.0.pkg => ice-1.3.35.0.pkg} (88%)

