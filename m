Return-Path: <netdev+bounces-25190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2344F773571
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAB328162C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59719B;
	Tue,  8 Aug 2023 00:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED02191
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 00:41:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE0170B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691455258; x=1722991258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bHOZyCnBywYkOQgIxi3XwEQktMM96X8JH2+i1MVsFAE=;
  b=M264C665JWVwdD5+7OD7dyP0ZTBGMx11KaiLKrS9+eJjNIH/vnhudoBe
   BOd/mdKn5c0FnYtgCvBU8XdZwyloeF9vbtET5iMMU/KEOOGzrQRk6906G
   4ohIk4HdeTxhjQAxNDaPhSXNwFKUShd4AIUJOnE3y3ZAv46Wb8/oE3wLK
   2iSNi/ik7ZhGnv026Dpl1KqGmAiELni0g6cdakeiKQU8G1LOdFrhPLrvy
   AC97oiOa8GV+lLcjvP57hFYy34upgxUwPFD1AlbM6KlI7fzANSlRh2ySj
   eg5VVQSZujoGb08StYKg3R4+dDMXayOj+6gYIkVzKWHJdCsdWwHM13qV0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360774019"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360774019"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 17:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061790158"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="1061790158"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 17:40:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	pavan.kumar.linga@intel.com,
	emil.s.tantilov@intel.com,
	jesse.brandeburg@intel.com,
	sridhar.samudrala@intel.com,
	shiraz.saleem@intel.com,
	sindhu.devale@intel.com,
	willemb@google.com,
	decot@google.com,
	andrew@lunn.ch,
	leon@kernel.org,
	mst@redhat.com,
	simon.horman@corigine.com,
	shannon.nelson@amd.com,
	stephen@networkplumber.org
Subject: [PATCH net-next v4 00/15][pull request] Introduce Intel IDPF driver
Date: Mon,  7 Aug 2023 17:34:01 -0700
Message-Id: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pavan Kumar Linga says:

This patch series introduces the Intel Infrastructure Data Path Function
(IDPF) driver. It is used for both physical and virtual functions. Except
for some of the device operations the rest of the functionality is the
same for both PF and VF. IDPF uses virtchnl version2 opcodes and
structures defined in the virtchnl2 header file which helps the driver
to learn the capabilities and register offsets from the device
Control Plane (CP) instead of assuming the default values.

The format of the series follows the driver init flow to interface open.
To start with, probe gets called and kicks off the driver initialization
by spawning the 'vc_event_task' work queue which in turn calls the
'hard reset' function. As part of that, the mailbox is initialized which
is used to send/receive the virtchnl messages to/from the CP. Once that is
done, 'core init' kicks in which requests all the required global resources
from the CP and spawns the 'init_task' work queue to create the vports.

Based on the capability information received, the driver creates the said
number of vports (one or many) where each vport is associated to a netdev.
Also, each vport has its own resources such as queues, vectors etc.
From there, rest of the netdev_ops and data path are added.

IDPF implements both single queue which is traditional queueing model
as well as split queue model. In split queue model, it uses separate queue
for both completion descriptors and buffers which helps to implement
out-of-order completions. It also helps to implement asymmetric queues,
for example multiple RX completion queues can be processed by a single
RX buffer queue and multiple TX buffer queues can be processed by a
single TX completion queue. In single queue model, same queue is used
for both descriptor completions as well as buffer completions. It also
supports features such as generic checksum offload, generic receive
offload (hardware GRO) etc.
---
v4:
Patch 1:
 * s/virtcnl/virtchnl
 * removed the kernel doc for the error code definitions that don't exist
 * reworded the summary part in the virtchnl2 header
Patch 3:
 * don't set local variable to NULL on error
 * renamed sq_send_command_out label with err_unlock
 * don't use __GFP_ZERO in dma_alloc_coherent
Patch 4:
 * introduced mailbox workqueue to process mailbox interrupts
Patch 3, 4, 5, 6, 7, 8, 9, 11, 15:
 * removed unnecessary variable 0-init
Patch 3, 5, 7, 8, 9, 15:
 * removed defensive programming checks wherever applicable
 * removed IDPF_CAP_FIELD_LAST as it can be treated as defensive
   programming
Patch 3, 4, 5, 6, 7:
 * replaced IDPF_DFLT_MBX_BUF_SIZE with IDPF_CTLQ_MAX_BUF_LEN
Patch 2 to 15:
 * add kernel-doc for idpf.h and idpf_txrx.h enums and structures
Patch 4, 5, 15:
 * adjusted the destroy sequence of the workqueues as per the alloc
   sequence
Patch 4, 5, 9, 15:
 * scrub unnecessary flags in 'idpf_flags'
   - IDPF_REMOVE_IN_PROG flag can take care of the cases where
     IDPF_REL_RES_IN_PROG is used, removed the later one
   - IDPF_REQ_[TX|RX]_SPLITQ are replaced with struct variables
   - IDPF_CANCEL_[SERVICE|STATS]_TASK are redundant as the work queue
     doesn't get rescheduled again after 'cancel_delayed_work_sync'
   - IDPF_HR_CORE_RESET is removed as there is no set_bit for this flag
   - IDPF_MB_INTR_TRIGGER is removed as it is not needed anymore with the
     mailbox workqueue implementation
Patch 7 to 15:
 * replaced the custom buffer recycling code with page pool API
 * switched the header split buffer allocations from using a bunch of
   pages to using one large chunk of DMA memory
 * reordered some of the flows in vport_open to support page pool
Patch 8, 12:
 * don't suppress the alloc errors by using __GFP_NOWARN
Patch 9:
 * removed dyn_ctl_clrpba_m as it is not being used
Patch 14:
 * introduced enum idpf_vport_reset_cause instead of using vport flags
 * introduced page pool stats

The following are changes since commit 66244337512fbe51a32e7ebc8a5b5c5dc7a5421e:
  Merge branch 'page_pool-a-couple-of-assorted-optimizations'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alan Brady (4):
  idpf: configure resources for TX queues
  idpf: configure resources for RX queues
  idpf: add RX splitq napi poll support
  idpf: add ethtool callbacks

Joshua Hay (5):
  idpf: add controlq init and reset checks
  idpf: add splitq start_xmit
  idpf: add TX splitq napi poll support
  idpf: add singleq start_xmit and napi poll
  idpf: configure SRIOV and add other ndo_ops

Pavan Kumar Linga (5):
  virtchnl: add virtchnl version 2 ops
  idpf: add core init and interrupt request
  idpf: add create vport and netdev configuration
  idpf: add ptypes and MAC filter support
  idpf: initialize interrupts and enable vport

Phani Burra (1):
  idpf: add module register and probe functionality

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/idpf.rst    |  160 +
 drivers/net/ethernet/intel/Kconfig            |   12 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   18 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  932 ++++
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 +++
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  169 +
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  164 +
 drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 1363 ++++++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |  124 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  293 ++
 .../ethernet/intel/idpf/idpf_lan_vf_regs.h    |  128 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 2357 +++++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  285 ++
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 1185 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 4309 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 1021 ++++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  163 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 3769 ++++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 1266 +++++
 .../ethernet/intel/idpf/virtchnl2_lan_desc.h  |  448 ++
 26 files changed, 19120 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_vf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lib.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2.h
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h

-- 
2.38.1


