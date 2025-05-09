Return-Path: <netdev+bounces-189254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E866AB1577
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E636501025
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917B2918D0;
	Fri,  9 May 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWObHqMo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959B29189C;
	Fri,  9 May 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798215; cv=none; b=HQcL04SCKLzWHBLzPQJsRK4WK2uHBh0BM1SIM3ms4yGkxd2U9hfZJNdDcnOZf/Ftz4qeTyJJKuHcFY3qDRrK9eX9sshea0zdOz8S3R8p+9lXQ8YWGm/2/+x/blNai76IgoE4BNYaZPejkkhgqMbpn6Ci+R+MHoZCD/JsHhYyRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798215; c=relaxed/simple;
	bh=1a2He2AHyt/Yk+/HK2TUi1W13SOfDoecgjaIdRQTRhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h77gSqMsvW96eldHQOhWNwoc5EOulczcpwMYPmOh8DjzkQT96ybn3MqlNql9vZBjbb3/d+puOc0UcUa71dw87DwdZVxyBuMtKMkAs1PJIVN7XVg2ryX/w/IlzvIiyd3zUsOZ9DdH4C73nM5odyX2qaslavKkPZZW2biHsz9qHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWObHqMo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746798212; x=1778334212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1a2He2AHyt/Yk+/HK2TUi1W13SOfDoecgjaIdRQTRhE=;
  b=VWObHqMoXnSbQkoi2F0dPqH4NdknHAQLpyurWzdEoF7GFpQduFltkpZ2
   NfkscgLExJzAWJHhl/qyOH7GwcQ5Qbm751fyx7N8y04NvNUajMDYRENmt
   u3h+t0aBWZ6xcHXqfl4Dt4PX7NbIAGLpzMgGa9Sadnv0IMZ5isnnlfv9r
   tDCJO10R1Jw3DMRR2jGcDv8AN4TSLXhhB55oMjCZf5sjfvixzk47xJ/Pw
   Nnccf25LkbKsTc1+GXUNNBiQxCS8jxjLEvqUP7CWDv0LMol272PAxECHB
   hWBs9a1nFB4M3x+ovUuEWb2orSrLY8ny5QSELRY9Tq5nnwFzAxeVqqVOF
   Q==;
X-CSE-ConnectionGUID: 5NMWxcgETfmXApVzWL3i4Q==
X-CSE-MsgGUID: C9tw2Q76Q7GBkoPIlIUl8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48532777"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48532777"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 06:43:30 -0700
X-CSE-ConnectionGUID: lmxUnMBrRnqLQKRgwboekQ==
X-CSE-MsgGUID: mOlxcZw7RCy7O4JNkl5QpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136323158"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2025 06:43:22 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 045AD33BCC;
	Fri,  9 May 2025 14:43:19 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v3 00/15] Introduce iXD driver
Date: Fri,  9 May 2025 15:42:57 +0200
Message-ID: <20250509134319.66631-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the iXD driver, which supports the Intel(R)
Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
exposed by the same card. The reason for the separation is to be able
to offload the control plane to the host different from where the data
plane is running.

This is the first phase in the release of this driver where we implement the
initialization of the core PCI driver. Subsequent phases will implement
advanced features like usage of idpf ethernet aux device, link management,
NVM update via devlink, switchdev port representors, data and exception path,
flow rule programming, etc.

The first phase entails the following aspects:

1. Additional libie functionalities:
Patches 1-6 introduces additional common library API for drivers to
communicate with the control plane through mailbox communication.
A control queue is a hardware interface which is used by the driver
to interact with other subsystems (like firmware). The library APIs
allow the driver to setup and configure the control queues to send and
receive virtchnl messages. The library has an internal bookkeeping
(XN API) mechanism to keep track of the send messages. It supports both
synchronous as well as asynchronous way of handling the messages. The
library also handles the timeout internally for synchronous messages
using events. This reduces the driver's overhead in handling the timeout
error cases.

The current patch series supports only APIs that are needed for device
initialization. These include APIs in the libie_pci module:
* Allocating/freeing the DMA memory and mapping the MMIO regions for
  BAR0, read/write APIs for drivers to access the MMIO memory

and libie_cp module:
* Control queue initialization and configuration
* Transport initialization for bookkeeping
* Blocking and asynchronous mailbox transactions

Once the mailbox is initialized, the drivers can send and receive virtchnl
messages to/from the control plane.

The modules above are not supposed to be linked witn the main libie library,
but do share the folder with it.

2. idpf :
Patches 7-10 refactor the idpf driver to use the libie APIs for control
queue configuration, virtchnl transaction, device initialization and
reset and adjust related code accordingly.

3. ixd:
Patches 11-14 add the ixd driver and implement multiple pieces of the
initialization flow as follows:
* Add the ability to load
* A reset is issued to ensure a clean device state, followed by
  initialization of the mailbox
* Device capabilities:
  As part of initialization, the driver has to determine what the device is
  capable of (ex. max queues, vports, etc). This information is obtained from
  the firmware and stored by the driver.
* Enable initial support for the devlink interface

v2->v3:
* non-trivial rebase affecting idpf refactoring patches
* add include/linux/intel under both Tony and NETWORKING DRIVERS
* due to rebase, in libie account for libeth_rx now using netmem instead
  of plain pages
* make libie_ctlq_release_rx_buf() take only one argument, as the producing
  queue is not actually needed to release a page pool buffer
* fix return value not being set in idpf_send_get_rx_ptype_msg()
* fix kdoc comments, so libie and ixd generate it cleanly
* separate idpf refactoring into 2 patches: pci+mmio and ctlq+xn
* suplement idpf refactoring commit message with information about module size
  and resource usage changes
* reformat commit messages to reduce the number of wasted lines

v1->v2:
* rename libeth_cp and libeth_pci to libie_cp and libie_pci respectively,
  move them into an appropriate folder
* rebase on top of recent PTP changes, this alters idpf refactor
* update maintainers after moving headers
* cast resource_size_t to unsigned long long when printing
* add ixd devlink documentation into index
* fix xn system kdoc problems
* fix indentation in libeth_ctlq_xn_deinit()
* fix extra kdoc member vcxn_mngr in idpf_adapter

Amritha Nambiar (1):
  ixd: add devlink support

Larysa Zaremba (5):
  idpf: make mbx_task queueing and cancelling more consistent
  idpf: print a debug message and bail in case of non-event ctlq message
  ixd: add basic driver framework for Intel(R) Control Plane Function
  ixd: add reset checks and initialize the mailbox
  ixd: add the core initialization

Pavan Kumar Linga (4):
  libeth: allow to create fill queues without NAPI
  idpf: remove 'vport_params_reqd' field
  idpf: refactor idpf to use libie_pci APIs
  idpf: refactor idpf to use libie control queues

Phani R Burra (3):
  libie: add PCI device initialization helpers to libie
  libie: add control queue support
  libie: add bookkeeping support for control queue messages

Victor Raj (2):
  virtchnl: create 'include/linux/intel' and move necessary header files
  virtchnl: introduce control plane version fields

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/ixd.rst     |   39 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixd.rst      |   35 +
 MAINTAINERS                                   |    6 +-
 drivers/infiniband/hw/irdma/i40iw_if.c        |    2 +-
 drivers/infiniband/hw/irdma/main.h            |    2 +-
 drivers/infiniband/hw/irdma/osdep.h           |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    4 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
 .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |    2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |    2 +-
 drivers/net/ethernet/intel/ice/ice.h          |    2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h        |   47 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 ------
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   91 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   37 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   60 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   87 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   89 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1678 ++++++-----------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   89 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  303 ++-
 drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
 drivers/net/ethernet/intel/ixd/Makefile       |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h          |   58 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  148 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   33 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |   89 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c  |  105 ++
 drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   44 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  166 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  150 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  178 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |    2 +-
 drivers/net/ethernet/intel/libeth/rx.c        |    9 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   14 +
 drivers/net/ethernet/intel/libie/Makefile     |    8 +
 drivers/net/ethernet/intel/libie/adminq.c     |    2 +-
 drivers/net/ethernet/intel/libie/controlq.c   | 1185 ++++++++++++
 drivers/net/ethernet/intel/libie/pci.c        |  184 ++
 drivers/net/ethernet/intel/libie/rx.c         |    2 +-
 include/linux/{net => }/intel/i40e_client.h   |    0
 include/linux/{net => }/intel/iidc.h          |    0
 include/linux/{net => }/intel/libie/adminq.h  |    0
 include/linux/intel/libie/controlq.h          |  419 ++++
 include/linux/intel/libie/pci.h               |   54 +
 include/linux/{net => }/intel/libie/rx.h      |    0
 include/linux/{avf => intel}/virtchnl.h       |    0
 .../idpf => include/linux/intel}/virtchnl2.h  |    6 +-
 .../linux/intel}/virtchnl2_lan_desc.h         |    0
 include/net/libeth/rx.h                       |    4 +-
 80 files changed, 4010 insertions(+), 2707 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 Documentation/networking/devlink/ixd.rst
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 rename include/linux/{net => }/intel/i40e_client.h (100%)
 rename include/linux/{net => }/intel/iidc.h (100%)
 rename include/linux/{net => }/intel/libie/adminq.h (100%)
 create mode 100644 include/linux/intel/libie/controlq.h
 create mode 100644 include/linux/intel/libie/pci.h
 rename include/linux/{net => }/intel/libie/rx.h (100%)
 rename include/linux/{avf => intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (99%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)

-- 
2.47.0


