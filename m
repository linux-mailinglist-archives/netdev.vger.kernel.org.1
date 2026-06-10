Return-Path: <netdev+bounces-297618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 04ipOuY/KWoATAMAu9opvQ
	(envelope-from <netdev+bounces-297618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D5668657
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ACpRCugQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297618-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297618-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FD8E3086F6C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113D3FB072;
	Wed, 10 Jun 2026 10:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239E3EDADA;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088101; cv=none; b=WjjaAFhvI+U1hl13VReh0pQONiFw5tIJpJHkPFs1sdXKcHpPn++a/A5nN8hZZnEyyLU7P7P7KpcE5S7yRPNVUAn//bcUdXWkagUhmyy1sHliFsN7TNCt6tOPTSebrbc1jsV/xTamrIOEsvi/LfVV8PZAiD+KiTFyFTfDbgOxIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088101; c=relaxed/simple;
	bh=sRPSrsi3qtGr4DHQFJuDqxiNEQyCSqA+5wyOzywBEP0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cl+2IX6y1ZFl1Q/KsAX1i7GWbsIq8p/s4Z0pZ/OvcJEx2CshtKfnx76LVKcCoDBdES7ARVlEY7hogTohdxuvsGngXNeTOVh2dFN/i+mdBv31Fx09aYYQcsrH+nMY+oFOjnPtz0izY8s0BsLI4F0CTV0Pgzh6eYLuzxmFXxe7N4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACpRCugQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28BEFC2BCB8;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781088101;
	bh=sRPSrsi3qtGr4DHQFJuDqxiNEQyCSqA+5wyOzywBEP0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ACpRCugQ9ccCBmONqS39GS6qemE7evcbVg5ywOPxubgVs0brwyW1OGzUAOOdpUw52
	 0wvc9mVzu9adyB59NUqnJ0qw4aGJMis1PMfb6E0EOUHNUvPGwEhco/JHxrJs/nOdNW
	 ATdUu/fs5ftYfHBS8Dnstms/DQvrXS04YyFAlOCwObJWd2nZv4BiipO+CSKIPKEbt8
	 +wMF5iCLXtHk3tNs86qhPmXnOWzP7t4SZu0e+OjMTsZCBbh+yAG0nzxB/3lNFmiTtw
	 ABZvGzUlods72R0opElF0RCa9hePU3F4m5tYcGGd7TJb0e0c3+tuvUVXAU/oEfa2f+
	 wfc8/vyMm2FYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E36CD8CB2;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Subject: [PATCH v2 0/7] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Date: Wed, 10 Jun 2026 18:41:03 +0800
Message-Id: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8/KWoC/3WNywrCMBBFf6XM2kgSW2Nd+R9SSptM7Ih9kNRQK
 f13k7oWBi4H7j2zgkdH6OGareAwkKdxiCAPGeiuGR7IyEQGyeWZF7Jkc7kstXEU0NVBMKHy3F4
 aq9SphDiaHFpaduG9+rF/t0/Uc7KkRkd+Ht1n/xhE6v2Vx+OsNa1FqbnAQt302E/N6xgDqm3bv
 s5+poO/AAAA
X-Change-ID: 20260529-t9xx_driver_v1-1744f8af7739
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781088081; l=10848;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=sRPSrsi3qtGr4DHQFJuDqxiNEQyCSqA+5wyOzywBEP0=;
 b=5TRmLewPIjGmmchStaGKC4dBDuCp2Cr7bNA5ljqc+e0ClPPNfjS1ucF9tQNJ1XHC/Gn/UhJVs
 dcFtWAlOINaALKIvgF4rgBtkGoB0ecN7NbAn70qgmob4HqVSXv/xPv9
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297618-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jackbb_wu@compal.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,compal.com:replyto,compal.com:email,compal.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A86D5668657

T9XX is the PCIe host device driver for MediaTek's
t900 modem. The driver uses the WWAN framework
infrastructure to create the following control ports
and network interfaces for data transactions.
* /dev/wwan0at0 - Interface that supports AT commands.
* /dev/wwan0mbim0 - Interface conforming to the MBIM
  protocol.
* wwan0-X - Primary network interface for IP traffic.

The main blocks in the T9XX driver are:
* HW layer - Abstracts the hardware bus operations for
   the device, and provides generic interfaces for the
   transaction layer to get the device's information and
   control the device's behavior. It includes:

   * PCIe - Implements probe, removal and interrupt
     handling.
   * MHCCIF (Modem Host Cross-Core Interface) - Provides
     interrupt channels for bidirectional event
     notification such as handshake and port enumeration.

* Transaction layer - Implements data transactions for
   the control plane and the data plane. It includes:

   * DPMAIF (Data Plane Modem AP Interface) - Controls
     the hardware that provides uplink and downlink
     queues for the data path. The data exchange takes
     place using circular buffers to share data buffer
     addresses and metadata to describe the packets.
   * CLDMA (Cross Layer DMA) - Manages the hardware
     used by the port layer to send control messages to
     the device using MediaTek's CCCI (Cross-Core
     Communication Interface) protocol.
   * TX Services - Dispatch packets from the port layer
     to the device.
   * RX Services - Dispatch packets to the port layer
     when receiving packets from the device.

* Port layer - Provides control plane and data plane
   interfaces to userspace. It includes:

   * Control Plane - Provides device node interfaces
     for controlling data transactions.
   * Data Plane - Provides network link interfaces
     wwanX (0, 1, 2...) for IP data transactions.

* Core logic - Contains the core logic to keep the
   device working. It includes:

   * FSM (Finite State Machine) - Monitors the state
     of the device, and notifies each module when the
     state changes.

The compilation of the T9XX driver is enabled by the
CONFIG_MTK_T9XX and CONFIG_MTK_T9XX_PCI config option
which depends on CONFIG_WWAN.

This v2 submission covers the control plane only
(patches 1-6). The data plane will follow in a
separate series once the control plane is accepted.

---
Changes in v2:
- Split series into control plane (this v2) and data plane (follow-up)
- Patch 1 (Add PCIe core):
  - Rename BAR_NUM to MTK_PCI_BAR_NUM for driver prefix consistency
  - Replace magic numbers in mtk_pci_setup_atr() with named defines
  - Remove redundant ATR register comments, use blank line separators
  - Add kernel-doc comments to all non-static functions
  - Convert 4 MMIO wrapper functions to static inline in header [sashiko]
  - Remove unnecessary unlikely() from IRQ validation paths
  - Add irq_cnt == 0 and irq_id < 0 guards in mtk_pci_get_virq_id() [sashiko]
  - Initialize hw_bits at declaration for consistency
  - Merge same-type variable declarations into single lines
  - Add #else/#endif comments for CONFIG_ACPI blocks
  - Add newlines in mtk_pci_pldr() for readability
  - Move return into default case in mtk_pci_dev_reset()
  - Simplify mtk_mhccif_init() error path to use direct returns
  - Change -EFAULT to -ENOLINK for PCIe link check failure
  - Rename goto label "out" to "log_err" in mtk_pci_probe()
  - Wrap long lines to stay within 80 columns
  - Fix IRQ vector leak: add pci_free_irq_vectors() on error path [sashiko]
  - Fix mtk_pci_remove() ordering: free IRQ before cancel_work_sync [sashiko]
  - Fix mtk_pci_pldr() ACPI buffer leak: free first result before second call [sashiko]
  - Replace msleep(500) with MTK_PLDR_POWER_OFF_DELAY_MS define
  - Remove unused EXT_EVT_H2D_DRM_DISABLE_AP and related register define [sashiko]
  - Increase MTK_IRQ_NAME_LEN from 20 to 32 to fix W=1 format-truncation warning [sashiko]
- Patch 2 (Add control plane transaction layer):
  - Add kernel-doc comments to mtk_ctrl_init() and mtk_ctrl_exit()
  - Change mtk_ctrl_exit() return type from int to void
  - Set mdev->ctrl_blk to NULL after freeing in mtk_ctrl_exit() [sashiko]
  - Change ctrl_blk from void* to typed struct mtk_ctrl_blk* [sashiko]
  - Remove redundant "depends on MTK_T9XX" from MTK_T9XX_PCI Kconfig [sashiko]
  - Use mtk_dev_free() instead of devm_kfree() in mtk_pci_probe() error path [sashiko]
- Patch 3 (Add control DMA interface):
  - Add @ops kernel-doc parameter for mtk_ctrl_init()
  - Rename 'err' to 'ret' consistently throughout the patch
  - Reorder variable declarations to follow reverse Christmas tree style
  - Change mtk_cldma_txq_free() return type from int to void
  - Change mtk_cldma_rxq_free() return type from int to void
  - Change mtk_cldma_exit() return type from int to void
  - Remove unnecessary zero-initialization of ret in mtk_cldma_start_xfer()
  - Remove unnecessary zero-initialization of ret in mtk_cldma_tx()
  - Use direct return instead of goto out in mtk_cldma_submit_tx() error paths
  - Move software state before HWO flag in mtk_cldma_submit_tx()
  - Squash variable declarations in mtk_cldma_check_intr_status()
  - Remove unlikely() from validation paths in mtk_cldma_check_ch_cfg()
  - Clamp data_recv_len with min_t to prevent skb_over_panic in mtk_cldma_rx_skb_adjust() [sashiko]
  - Use READ_ONCE() for HWO flag polling in mtk_cldma_check_rx_req() [sashiko]
  - Fix mtk_cldma_rx_done_work() to always unmask interrupt on error path [sashiko]
  - Add DMA address guard in mtk_cldma_txq_free() teardown loop [sashiko]
  - Add IS_ERR() check for kthread_run() in mtk_ctrl_trb_srv_init() [sashiko]
  - Fix queue_info memory leak on validation failure in mtk_pcie_hif_init() [sashiko]
  - Handle non-EAGAIN errors in mtk_ctrl_trb_handler() TX path [sashiko]
  - Fix 'err' typo to 'ret' in mtk_cldma_txbuf_set() error message
  - Remove unused variable mdev in mtk_cldma_rx_check_again() [sashiko]
  - Remove unused variables trans and ctrl_blk in mtk_cldma_txq_free() and mtk_cldma_rxq_free() [sashiko]
- Patch 4 (Add control port):
  - Add @cfg kernel-doc parameter for mtk_ctrl_init()
  - Update mtk_ctrl_init() return description to cover additional error codes
  - Fix double list_del in mtk_port_stale_list_grp_cleanup() [sashiko]
  - Fix direct mtk_port_trb_free() call to use kref_put() in mtk_port_ch_enable() error path [sashiko]
  - Fix direct mtk_port_trb_free() call to use kref_put() in mtk_port_ch_disable() error path [sashiko]
  - Add mtk_port_tbl_destroy() in mtk_port_mngr_init() error path to prevent port memory leak [sashiko]
  - Change port_ops exit/reset/enable/disable callbacks from int to void
  - Move -EIO dispatch comment to where the code was introduced
- Patch 5 (Add FSM thread):
  - Add bounds check for rtft_entry in mtk_fsm_parse_hs2_msg() [sashiko]
  - Add skb length validation before accessing ctrl_msg_header in mtk_fsm_sap_ctrl_msg_handler() [sashiko]
  - Fix skb leak on CTRL_MSG_HS2 mismatch return in mtk_fsm_sap_ctrl_msg_handler() [sashiko]
  - Add skb length validation before accessing ctrl_msg_header in mtk_fsm_md_ctrl_msg_handler() [sashiko]
  - Replace devm_kzalloc/devm_kfree with kzalloc/kfree for FSM events [sashiko]
  - Fix mtk_fsm_evt_submit() to return -ETIMEDOUT on blocking event timeout [sashiko]
  - Change FSM kthread from TASK_INTERRUPTIBLE to TASK_UNINTERRUPTIBLE [sashiko]
  - Remove unused variable hw_id in mtk_cldma_dev_exit() [sashiko]
- Patch 6 (Add AT & MBIM WWAN ports):
  - Use imperative mode in commit message
  - Remove unnecessary zero-initialization of ret in mtk_port_copy_data_from()
  - Change copy_from_user() error code from -EFAULT to -EINVAL in mtk_port_copy_data_from()
  - Return -EINVAL for zero-length write in mtk_port_common_write()
  - Change mtk_port_wwan_exit/enable/disable() return type from int to void
  - Fix packet_size to account for CCCI header reservation in mtk_port_common_write() [sashiko]
  - Fix WWAN tx callbacks to consume skb and return 0 per wwan_port_ops contract [sashiko]
  - Fix wwan_create_port() error path: clear ERR_PTR to NULL and call mtk_port_ch_disable() [sashiko]
- Patch 7 (Add maintainers entry): new patch
- Link to v1: https://patch.msgid.link/20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com

---
Jack Wu (7):
      net: wwan: t9xx: Add PCIe core
      net: wwan: t9xx: Add control plane transaction layer
      net: wwan: t9xx: Add control DMA interface
      net: wwan: t9xx: Add control port
      net: wwan: t9xx: Add FSM thread
      net: wwan: t9xx: Add AT & MBIM WWAN ports
      net: wwan: t9xx: Add maintainers entry

 MAINTAINERS                                     |    9 +
 drivers/net/wwan/Kconfig                        |   17 +
 drivers/net/wwan/Makefile                       |    1 +
 drivers/net/wwan/t9xx/Makefile                  |   14 +
 drivers/net/wwan/t9xx/mtk_ctrl_plane.c          |  111 ++
 drivers/net/wwan/t9xx/mtk_ctrl_plane.h          |   88 ++
 drivers/net/wwan/t9xx/mtk_dev.c                 |   55 +
 drivers/net/wwan/t9xx/mtk_dev.h                 |  114 ++
 drivers/net/wwan/t9xx/mtk_fsm.c                 |  948 +++++++++++++++
 drivers/net/wwan/t9xx/mtk_fsm.h                 |  140 +++
 drivers/net/wwan/t9xx/mtk_port.c                |  968 ++++++++++++++++
 drivers/net/wwan/t9xx/mtk_port.h                |  176 +++
 drivers/net/wwan/t9xx/mtk_port_io.c             |  573 +++++++++
 drivers/net/wwan/t9xx/mtk_port_io.h             |   41 +
 drivers/net/wwan/t9xx/mtk_utility.h             |   33 +
 drivers/net/wwan/t9xx/pcie/Makefile             |   15 +
 drivers/net/wwan/t9xx/pcie/mtk_cldma.c          | 1411 +++++++++++++++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_cldma.h          |  173 +++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c      |  371 ++++++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.h      |  174 +++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c |  177 +++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.h |  101 ++
 drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c  |   55 +
 drivers/net/wwan/t9xx/pcie/mtk_pci.c            | 1114 ++++++++++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_pci.h            |  232 ++++
 drivers/net/wwan/t9xx/pcie/mtk_pci_drv_m9xx.c   |   69 ++
 drivers/net/wwan/t9xx/pcie/mtk_pci_reg.h        |   71 ++
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c     |  603 ++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h     |  105 ++
 29 files changed, 7959 insertions(+)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260529-t9xx_driver_v1-1744f8af7739

Best regards,
--  
Jack Wu <jackbb_wu@compal.com>



