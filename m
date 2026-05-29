Return-Path: <netdev+bounces-293075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGb0OG5sGWrGwQgAu9opvQ
	(envelope-from <netdev+bounces-293075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B7600EE9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6249F31A6222
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495D3CB2FC;
	Fri, 29 May 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXfOyCAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598C3CB2DA;
	Fri, 29 May 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050708; cv=none; b=GLtTavlGtBpC+3JNYvtTvvEkTSE8ICWyPoUw7TY77HKJDYTjHzvwc6Z2CWuHIQQHMcmLQ8fBmPBjCZ7qww0N87KGrASZWehremVrYECzA30csbqhe5kC87PlFjqeI4nnci0ebXF1iDPstPlKe3RAKU79vyBmYX/s3n6/XgPos6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050708; c=relaxed/simple;
	bh=Uhk5W8Tuq0902LMgAiqFtam6oLO/82rfu4jgFWKW+a4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Umie5tGPG7EAmLknqq79fLA+mRrJ+SrjPI6QjhRLqK8JZC1wFFFPBdLNV0JUm6F0x/li3D3mClmbFnPDQKWnzCBghPSERb7m9AcLiCkXRPdEchKjNsGTtf8kH7P9BfVsBac8ga+RFjmLjd5gVUZFcw030yWr6KvNYqmWtCf414Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXfOyCAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D102AC2BCB3;
	Fri, 29 May 2026 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780050707;
	bh=Uhk5W8Tuq0902LMgAiqFtam6oLO/82rfu4jgFWKW+a4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AXfOyCALX/3nZQm6Tm38XTkxf2nm/oiUxUNbJ5s0BChero7EYc9JeM4yjTHsT7Mtv
	 u47StDh5RupXr4H4kYa38JCaiZJ/+g/lU5iweO0RAaK8URc2yoPZrtzFiLaQ9P/Gya
	 31uJORWUuLMlMUgpYeOUvp0vfdVyQSeywTS28Yfl5iZBAWbtbU5iOgQmkxn8CKlTZJ
	 fAnC42NBPNlIgZz7XQortiE0DPg2xPScuRxwYr7q9sV73ST6fCLuaZTL7rJYgFuNWR
	 tYSSwLyBkBoywP3MRAXz8gLpcZFKp2W99NKh1S9dYByWclxEUelHBv3taLy0/XuPPo
	 RLBXkUc8msZSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5542CD6E4A;
	Fri, 29 May 2026 10:31:47 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Subject: [PATCH 00/11] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Date: Fri, 29 May 2026 18:31:39 +0800
Message-Id: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtrGWoC/yXMzQ5FMBBA4VeRWWui5eqtVxERP1N3LJApTRPx7
 upafotzTnDIhA6q5ARGT47WJUKmCQy/bplQ0BgNKlNl9lFG7CaEdmTyyK2XQuqisN/Oap0biNH
 GaCn8h3Xz2h39jMP+XOC6bhLEN+pyAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780050704; l=5835;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=Uhk5W8Tuq0902LMgAiqFtam6oLO/82rfu4jgFWKW+a4=;
 b=iqDg+vLGU+X657DStNqZFEAiE7d5rUDTD53nG4CwrDrNfZblbPjZ6fRCVURu6Td8HZy528uDB
 is4E2j+pLqCCnmsI5MFSEce3CnWGORvwT0Hv25O2YwiwvQQ/YwYYvHj
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293075-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,compal.com:replyto,compal.com:mid,compal.com:email]
X-Rspamd-Queue-Id: 8A1B7600EE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

---
Jack Wu (11):
      net: wwan: t9xx: Add PCIe core
      net: wwan: t9xx: Add control plane transaction layer
      net: wwan: t9xx: Add control DMA interface
      net: wwan: t9xx: Add control port
      net: wwan: t9xx: Add FSM thread
      net: wwan: t9xx: Add AT & MBIM WWAN ports
      net: wwan: t9xx: Introduce data plane hardware
      net: wwan: t9xx: Add data plane transaction layer
      net: wwan: t9xx: Introduce WWAN interface
      net: wwan: t9xx: Add power management support
      net: wwan: t9xx: Add maintainers and documentation

 .../networking/device_drivers/wwan/t9xx.rst        |   48 +
 MAINTAINERS                                        |   10 +
 drivers/net/wwan/Kconfig                           |   17 +
 drivers/net/wwan/Makefile                          |    1 +
 drivers/net/wwan/t9xx/Makefile                     |   16 +
 drivers/net/wwan/t9xx/mtk_ctrl_plane.c             |   95 +
 drivers/net/wwan/t9xx/mtk_ctrl_plane.h             |   88 +
 drivers/net/wwan/t9xx/mtk_data_plane.c             |  104 +
 drivers/net/wwan/t9xx/mtk_data_plane.h             |  105 +
 drivers/net/wwan/t9xx/mtk_dev.c                    |   55 +
 drivers/net/wwan/t9xx/mtk_dev.h                    |  114 +
 drivers/net/wwan/t9xx/mtk_fsm.c                    |  931 +++++++
 drivers/net/wwan/t9xx/mtk_fsm.h                    |  140 +
 drivers/net/wwan/t9xx/mtk_port.c                   |  967 +++++++
 drivers/net/wwan/t9xx/mtk_port.h                   |  176 ++
 drivers/net/wwan/t9xx/mtk_port_io.c                |  576 +++++
 drivers/net/wwan/t9xx/mtk_port_io.h                |   41 +
 drivers/net/wwan/t9xx/mtk_utility.h                |   33 +
 drivers/net/wwan/t9xx/mtk_wwan.c                   |  475 ++++
 drivers/net/wwan/t9xx/mtk_wwan.h                   |   17 +
 drivers/net/wwan/t9xx/pcie/Makefile                |   19 +
 drivers/net/wwan/t9xx/pcie/mtk_cldma.c             | 1527 +++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_cldma.h             |  176 ++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c         |  373 +++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.h         |  174 ++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.c    |  177 ++
 drivers/net/wwan/t9xx/pcie/mtk_cldma_drv_m9xx.h    |  101 +
 drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c     |   55 +
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif.c            | 2714 ++++++++++++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif.h            |   16 +
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv.c        | 1586 ++++++++++++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv.h        |  268 ++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_drv_m9xx.c   |  687 +++++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_reg.h        |  387 +++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_reg_m9xx.h   |   37 +
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_ring.c       |  168 ++
 drivers/net/wwan/t9xx/pcie/mtk_dpmaif_ring.h       |  161 ++
 drivers/net/wwan/t9xx/pcie/mtk_pci.c               | 1067 ++++++++
 drivers/net/wwan/t9xx/pcie/mtk_pci.h               |  219 ++
 drivers/net/wwan/t9xx/pcie/mtk_pci_drv_m9xx.c      |   70 +
 drivers/net/wwan/t9xx/pcie/mtk_pci_reg.h           |   72 +
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c        |  593 +++++
 drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.h        |  105 +
 43 files changed, 14761 insertions(+)
---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260529-t9xx_driver_v1-1744f8af7739

Best regards,
--  
Jack Wu <jackbb_wu@compal.com>



