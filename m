Return-Path: <netdev+bounces-155106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B8A01152
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 01:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C869D7A041E
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB79171A7;
	Sat,  4 Jan 2025 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F64kzBM+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14F36C
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951412; cv=none; b=ZuCRJNsX0PPgYGzryPzsNYnLfoaM/NvZnqkF/JEikkuq7aB84vGRob78t5uitLFOE94lMYfMJfhwNaW31L3NSWzt1QHS0Az1xV6yq3eeT/BqOIef55pYCi07vfMdb4U/LoQ9aqV8wViGaXFTw8lj6f3NjJr3hMT+wslNcSC7nnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951412; c=relaxed/simple;
	bh=uUMPTxyh/TKv8E1s6ZJSvCjKbS/fkCaSJW1aNxM6fu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV9rWqOlsAjG8t1ah20sizhDmPX9zspW9jiICmPfwfI5FtjIrrPwZFUq5QG0MjdSwiOqgTqkNg22dxVm6O6a6uZDbmU/EqCGejScXV0vnYWaRE3pyFgOMrVW0NcbGPc379LMJigtjFIdedL1Vh0BITXMEPJWKIJT1Y+XTJrpZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F64kzBM+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735951411; x=1767487411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uUMPTxyh/TKv8E1s6ZJSvCjKbS/fkCaSJW1aNxM6fu4=;
  b=F64kzBM+LI6GOJTF1hmY9aIwLoARLr/EqxgUaqskJYbeBTHDYKbXurXl
   qgD46fv68kQkrBxcuCRqoiuMDGbgthLfbj2GT/PLXMskwPwV6ORocAc2M
   91X8IEeWLGM1S9aGRx0z7ELIlFLPN5sogp8rUj0Bo4OUVQz4lK29sm2cq
   7RJenqjo+0dU6Dec6K8bLwL7M4K2SnouZJ9/J7QMIFZT0M/2k33vm98ZX
   kWOcpnFpgWXly5zvSCFsiu3WayugnCyaTEza8k1ZaQRIHFZ8pZxXEcA4X
   J1N2WrAOfvcmi4UuS2J+/qwA9aM1/iw2oaSR1xKiazhJFHJBpO4CqthLe
   A==;
X-CSE-ConnectionGUID: qbGdY1b5QXyXIQwcZ4eVQw==
X-CSE-MsgGUID: nKvtpfcWTxGzerBNS7+A7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="36075933"
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="36075933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:30 -0800
X-CSE-ConnectionGUID: KEO/wRVmRWiVRkBhbUs9Yw==
X-CSE-MsgGUID: Mp+8YN14QT+iRQkxLUxqMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,287,1728975600"; 
   d="scan'208";a="106879712"
Received: from spandruv-desk1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.48])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 16:43:25 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v3 0/6] net: napi: add CPU affinity to napi->config
Date: Fri,  3 Jan 2025 17:43:08 -0700
Message-ID: <20250104004314.208259-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IRQ affinity management to the napi struct. Since there can only
be one IRQ affinity notifier, the ARFS rmap management is moved to CORE
(patches 1 and 2), then the new notifier is extended to save the user-set
IRQ affinity mask in napi_config.

Tested on bnxt, ice and idpf.

v3:
    - Assign one cpu per mask starting from local NUMA node (Shay Drori).
    - Keep the new ARFS and Affinity flags per nedev (Jakub).

v2:
    - https://lore.kernel.org/netdev/202412190454.nwvp3hU2-lkp@intel.com/T/
    - Also move the ARFS IRQ affinity management from drivers to core. Via
      netif_napi_set_irq(), drivers can ask the core to add the IRQ to the
      ARFS rmap (already allocated by the driver).

RFC -> v1:
    - https://lore.kernel.org/netdev/20241210002626.366878-1-ahmed.zaki@intel.com/
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (6):
  net: move ARFS rmap management to core
  net: napi: add internal ARFS rmap management
  net: napi: add CPU affinity to napi_config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 drivers/net/ethernet/amazon/ena/ena_netdev.c |  38 +----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  53 ++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h    |   2 -
 drivers/net/ethernet/intel/ice/ice.h         |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c    |  17 +--
 drivers/net/ethernet/intel/ice/ice_base.c    |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   6 -
 drivers/net/ethernet/intel/ice/ice_main.c    |  47 +------
 drivers/net/ethernet/intel/idpf/idpf_lib.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   6 +-
 include/linux/cpu_rmap.h                     |   1 +
 include/linux/netdevice.h                    |  23 ++-
 lib/cpu_rmap.c                               |   2 +-
 net/core/dev.c                               | 139 ++++++++++++++++++-
 15 files changed, 186 insertions(+), 181 deletions(-)

-- 
2.43.0


