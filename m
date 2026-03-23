Return-Path: <netdev+bounces-270633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDopOP18wWknTgQAu9opvQ
	(envelope-from <netdev+bounces-270633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:48:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997A2FA709
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00DD2301BDD5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8F3C9429;
	Mon, 23 Mar 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjyTgDzO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55263C5532;
	Mon, 23 Mar 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287663; cv=none; b=WyAJntR/qS6otGaUysCMDjkXuzjB51p4XN5Yoo0x1BXZUbSggsPK7Q1N5qoiIYEeQrm//ZDo1VnRFgjq9l9QSs21FtA9TO8+2tXn1ocIqoLqLSCYmXqOrutUiC1sf3XhkI/I4KjjDRH4YzXf7Vlbws1ljs7sGBMyskxcrDn7kQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287663; c=relaxed/simple;
	bh=qYWxev8vleVpmgYJPWrmDWTpnQtgSMVl5ovVUlobR9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNSX6y40ijuA3un1KItsvhmlUYontBtG3Z/qfo+ulV+17+l9UPvcR35+Jz5rriPPs3nf2XxHXVsjzhN9G/s8i/4Z2SmoJHnkWHA43k3sM0XpNKxZW4oi/vIVK+SfqP7aMMT2/PyIoqbnOC27UP32980t1D5AgGCdXdq6aeZ9E78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjyTgDzO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774287661; x=1805823661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qYWxev8vleVpmgYJPWrmDWTpnQtgSMVl5ovVUlobR9c=;
  b=jjyTgDzOr6oechA0DmW3XCRIo6KHQgHD9TGNuTNWjLTJg9/RJVdK+X+u
   eebwXSb+MZBx0fa3/mBin+2jSkHetnRkWunE6UzwVtcZfJTdiwxpEhEOR
   S1oeFLyI2+k7kqdmVnaVHpUkae0FVYPHVLU+i/p2A8YteUehmtKaIz4vk
   DB3+L/YGkt4sFuazuooBK8eom03Z7y6C6Igqwp9JBQwVGeBZr4IZTUVWJ
   5x6TElGvFqjotgFPTfA4Nw1+SCoakjwTSpkXCMhvNXalw865FNhwuYGGS
   5GwXvB6INbKVzXkMknssZI1XhspIBchCaW1GBFYhsKfJ6Rdocz3fYKWcT
   A==;
X-CSE-ConnectionGUID: xmnrwXd8STO1gUZtbp/xPQ==
X-CSE-MsgGUID: Pc28uYfTTqiuswjqzSuDCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75484613"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75484613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:41:00 -0700
X-CSE-ConnectionGUID: cRtpfw+TSweToxmCf3WbcA==
X-CSE-MsgGUID: VU3nZgdwSwC8pnIHLxMuRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228576615"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 23 Mar 2026 10:40:55 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BBB16312F6;
	Mon, 23 Mar 2026 17:40:52 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v6 00/14] Introduce iXD driver
Date: Mon, 23 Mar 2026 18:40:31 +0100
Message-ID: <20260323174052.5355-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270633-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8997A2FA709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Patches 1-5 introduce additional common library API for drivers to
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
Patches 6-9 refactor the idpf driver to use the libie APIs for control
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

v5->v6:
* improved failure handling and input validation
* removed cp version from devlink in ixd
* patch 8 requires retest

v4->v5:
* rebase on top of queue resources refactor
* overwrite idpf's memory regions management that was merged in the meantime
* introduce libie_pci_unmap_fltr_regs()
* rebase on top on RDMA patchset - patches 8 & 9
* use pcim_* helpers in libie_pci (patch 3)
* fix issue with reset not being triggered (reported by Emil) - patch 8
* introduce idpf_send_mb_msg_kfree function to handle cases, where
  idpf allocates buffers on different size for the same command - patch 8

v3->v4:
* non-trivial rebase affecting patch 1 (moving headers) and idpf refactoring
  patches

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

Victor Raj (1):
  virtchnl: create 'include/linux/intel' and move necessary header files

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/ixd.rst     |   39 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixd.rst      |   30 +
 MAINTAINERS                                   |    6 +-
 drivers/infiniband/hw/irdma/i40iw_if.c        |    2 +-
 drivers/infiniband/hw/irdma/icrdma_if.c       |    2 +-
 drivers/infiniband/hw/irdma/ig3rdma_if.c      |    2 +-
 drivers/infiniband/hw/irdma/main.c            |    2 +-
 drivers/infiniband/hw/irdma/main.h            |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    4 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
 .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |    2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |    2 +-
 drivers/net/ethernet/intel/ice/ice.h          |    2 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |    2 +-
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |    4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |    2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
 .../net/ethernet/intel/ice/virt/virtchnl.h    |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h        |  103 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 ------
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  144 --
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  169 --
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  101 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   28 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   38 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   69 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  117 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   99 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1820 +++++++----------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   95 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  304 ++-
 drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
 drivers/net/ethernet/intel/ixd/Makefile       |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h          |   58 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  149 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   33 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |   89 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c  |   97 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   44 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  166 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  147 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  178 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |    2 +-
 drivers/net/ethernet/intel/libeth/rx.c        |   12 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   14 +
 drivers/net/ethernet/intel/libie/Makefile     |    8 +
 drivers/net/ethernet/intel/libie/adminq.c     |    2 +-
 drivers/net/ethernet/intel/libie/controlq.c   | 1195 +++++++++++
 drivers/net/ethernet/intel/libie/fwlog.c      |    2 +-
 drivers/net/ethernet/intel/libie/pci.c        |  208 ++
 drivers/net/ethernet/intel/libie/rx.c         |    2 +-
 include/linux/{net => }/intel/i40e_client.h   |    0
 include/linux/{net => }/intel/iidc_rdma.h     |    0
 include/linux/{net => }/intel/iidc_rdma_ice.h |    0
 .../linux/{net => }/intel/iidc_rdma_idpf.h    |    0
 include/linux/{net => }/intel/libie/adminq.h  |    0
 include/linux/intel/libie/controlq.h          |  424 ++++
 include/linux/{net => }/intel/libie/fwlog.h   |    2 +-
 include/linux/intel/libie/pci.h               |   56 +
 include/linux/{net => }/intel/libie/pctype.h  |    0
 include/linux/{net => }/intel/libie/rx.h      |    0
 include/linux/{avf => intel}/virtchnl.h       |    0
 .../idpf => include/linux/intel}/virtchnl2.h  |    0
 .../linux/intel}/virtchnl2_lan_desc.h         |    0
 include/net/libeth/rx.h                       |    4 +-
 97 files changed, 4196 insertions(+), 2876 deletions(-)
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
 rename include/linux/{net => }/intel/iidc_rdma.h (100%)
 rename include/linux/{net => }/intel/iidc_rdma_ice.h (100%)
 rename include/linux/{net => }/intel/iidc_rdma_idpf.h (100%)
 rename include/linux/{net => }/intel/libie/adminq.h (100%)
 create mode 100644 include/linux/intel/libie/controlq.h
 rename include/linux/{net => }/intel/libie/fwlog.h (98%)
 create mode 100644 include/linux/intel/libie/pci.h
 rename include/linux/{net => }/intel/libie/pctype.h (100%)
 rename include/linux/{net => }/intel/libie/rx.h (100%)
 rename include/linux/{avf => intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)

-- 
2.47.0


