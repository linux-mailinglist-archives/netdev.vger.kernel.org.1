Return-Path: <netdev+bounces-86533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5B89F200
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473C51C20B97
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F177159909;
	Wed, 10 Apr 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWso3RQz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546F1119F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751987; cv=none; b=usc50vlxdbUZKimzUd2yxShawjff7kVsuw0q8+78ohArepwrRcGGr5ZhFYz0eVG7TPTmlNYi7FsP+I5Fy6OXzbG9UfQ77jflBfzTSh0CFEaH6j6hM+i7OoG2GFjg3DbtAEDTdMMCRFNgQ47N+tAsBWJ+aUhmV+CaqXBJ24jj4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751987; c=relaxed/simple;
	bh=Hp1CjwTDJtidXzEYtDBFVsJk68cIcszM+43YBzlpMYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDBvdZjmDVu5ZMOb7HD2lAqO/3QHoG7BFPibfUbAm+mbzqNn7cQ/J11mZU+lfjTz3sR9bdmO5swh9Qm7F/ulYFGZEz3kB90KQT2pQ0cj01uxCYdPdhJBAqNnB3pbAkwkJkwDgUthT0NC3dVEs/31rSOf0ttsL7EZ6m5SPaiLOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWso3RQz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712751985; x=1744287985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hp1CjwTDJtidXzEYtDBFVsJk68cIcszM+43YBzlpMYs=;
  b=XWso3RQzKosbT5tKER2iVET2EIVvhXLD1B8urWzQ2OfSSpaTw5rsoixi
   m9PftsZyqkDaqYZ4b/vDzEOMXI1oaGciZVbkhd4hH21ZEfMXy4uYl7pOZ
   bRv4CtpDKAE10er8yfMRzqP0xfvg8iOxgUdpAtNbxl/YAmJJjxrXtF5Q7
   VXltuwSpeyDOOgEPCEtEcUy6GUhhC2m1aeALtD4pQHE+VrBzj0WTZr4M8
   rP4IitAbhB+RRoKb5Rft3pusVvHoM4AHqLyu+57eCsZ47JN3jfgE8zJRO
   zRs8XoZN3uZsxbG5yFxAEzDDKHYpjSKr2R3SkV18ZOepGINpCGKrg0tXN
   g==;
X-CSE-ConnectionGUID: Aom2OA2JTk+azJ8OqCrgFQ==
X-CSE-MsgGUID: EKPaVEnoSC6ScXkWruFUHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7982169"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7982169"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:26:25 -0700
X-CSE-ConnectionGUID: oAZ0Rw0wTweE8C/NApTgiA==
X-CSE-MsgGUID: D2lsq+FRQ6iA5ikevjMIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51760024"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 05:26:23 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 405DD28798;
	Wed, 10 Apr 2024 13:26:22 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v4 00/12] Add support for Rx timestamping for both ice and iavf drivers.
Date: Wed, 10 Apr 2024 08:16:54 -0400
Message-Id: <20240410121706.6223-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially, during VF creation it registers the PTP clock in
the system and negotiates with PF it's capabilities. In the
meantime the PF enables the Flexible Descriptor for VF.
Only this type of descriptor allows to receive Rx timestamps.

Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Enable timestamping should be done using SIOCSHWTSTAMP ioctl,
e.g.
hwstamp_ctl -i $VF -r 14

In order to report the timestamps to userspace, the VF extends
timestamp to 40b.

To support this feature the flexible descriptors and PTP part
in iavf driver have been introduced.

---
v4:
- fixed duplicated argument in iavf_virtchnl.c reported by coccicheck

v3:
- added RB in commit 6
- removed inline keyword in commit 9
- fixed sparse issues in commit 9 and commit 10
- used GENMASK_ULL when possible in commit 9
https://lore.kernel.org/netdev/20240403131927.87021-1-mateusz.polchlopek@intel.com/

v2:
- fixed warning related to wrong specifier to dev_err_once in
  commit 7
- fixed warnings related to unused variables in commit 9
https://lore.kernel.org/netdev/20240327132543.15923-1-mateusz.polchlopek@intel.com/

v1:
- initial series
https://lore.kernel.org/netdev/20240326115116.10040-1-mateusz.polchlopek@intel.com/
---

Jacob Keller (10):
  virtchnl: add support for enabling PTP on iAVF
  virtchnl: add enumeration for the rxdid format
  iavf: add support for negotiating flexible RXDID format
  iavf: negotiate PTP capabilities
  iavf: add initial framework for registering PTP clock
  iavf: add support for indirect access to PHC time
  iavf: periodically cache PHC time
  iavf: refactor iavf_clean_rx_irq to support legacy and flex
    descriptors
  iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
  iavf: add support for Rx timestamps to hotpath

Mateusz Polchlopek (1):
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  33 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 242 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 530 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  46 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 424 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  26 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 150 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 236 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 127 ++++-
 17 files changed, 1761 insertions(+), 161 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h

-- 
2.38.1


