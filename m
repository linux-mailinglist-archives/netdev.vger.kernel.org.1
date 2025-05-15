Return-Path: <netdev+bounces-190784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92853AB8BF3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499721BA0D2E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518002192FD;
	Thu, 15 May 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjCF82W0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F951581F0;
	Thu, 15 May 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325426; cv=none; b=aYGKxIPXzyKMzfuVMF6s2aZr+qtwxbrrpH7QGOO9M48Cb2gIuMEJpV5/KFc7GBPF+Gjpx16so/wuUX08FRDfPXyINDcPu7GNT4ixT/KHwRsu/jcBPVeH0TOIR4W7GFi/OpxydO0Nu53wD5eBDjYVeKmSIPz2caCpyKHudpwFqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325426; c=relaxed/simple;
	bh=8l9FxQ4NNWk4iI5Jr0drECm0F4PxW3dCgiWzcimz06U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdc5b4uMCGUhIrKfcJMRxnhqHOBbuNsqSOhxAgfBUNvdwcfzEOh4NfJf2qvupUCri+4PN29VSmZ/iFyk5BSgFRzqHxXk+p2wAagyv7gOmZC9tStWUgww+0IpAVaDZAp69uTAXc7svKEaNMrfZXKMYFND92ni0US5VJR2JhnUE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjCF82W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DF5C4CEE7;
	Thu, 15 May 2025 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747325425;
	bh=8l9FxQ4NNWk4iI5Jr0drECm0F4PxW3dCgiWzcimz06U=;
	h=From:To:Cc:Subject:Date:From;
	b=XjCF82W0FkHSTCpSCOj8V9p/WiZTXje+aehu3NeAwFNj/tZsAVI9GqAgXQR2Myci4
	 GqHoNgs1dEuO5ubK49qxHSR9n7zJqR+BWLwrk2HFRLZNg4PMPXV/U/5wxldVlwo/zz
	 PSM1CAb88ieapFhyZFanQsqNN/YQoodmQbjQvO/mZY8Qa40M2hQGijGakHNoH9uL2G
	 7WMguQGmxI9C7qVNYN1FONHO/AjhUsi8vJtUw8xKTByUIDrHckhHinkBSdPi0kUp06
	 FXI0qNi58hEiqYfawtBk4JAOBIhsugJkJSkujDPjf1pmyJMyZqjNvfaK3xeqEEv+Nt
	 KZBm/sT9Hsy5A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15-rc7
Date: Thu, 15 May 2025 09:10:24 -0700
Message-ID: <20250515161024.2062444-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 2c89c1b655c0b06823f4ee8b055140d8628fc4da:

  Merge tag 'net-6.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-08 08:33:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc7

for you to fetch changes up to 0afc44d8cdf6029cce0a92873f0de5ac9416cec8:

  net: devmem: fix kernel panic when netlink socket close after module unload (2025-05-15 08:05:32 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth and wireless.

A few more fixes for the locking changes trickling in. Nothing
too alarming, I suspect those will continue for another release.
Other than that things are slowing down nicely.

Current release - fix to a fix:

 - Bluetooth: hci_event: use key encryption size when its known

 - tools: ynl-gen: allow multi-attr without nested-attributes again

Current release - regressions:

 - locking fixes:
   - lock lower level devices when updating features
   - eth: bnxt_en: bring back rtnl_lock() in the bnxt_open() path
   - devmem: fix panic when Netlink socket closes after module unload

Current release - new code bugs:

 - eth: txgbe: fixes for FW communication on new AML devices

Previous releases - always broken:

 - sched: flush gso_skb list too during ->change(), avoid potential
   null-deref on reconfig

 - wifi: mt76: disable NAPI on driver removal

 - hv_netvsc: fix error "nvsp_rndis_pkt_complete error status: 2"

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Andrew Jeffery (1):
      net: mctp: Ensure keys maintain only one ref to corresponding dev

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: fix typo for declaration MT7988 ESW capability

Carolina Jubran (1):
      net/mlx5e: Disable MACsec offload for uplink representor profile

Cong Wang (2):
      net_sched: Flush gso_skb list too during ->change()
      selftests/tc-testing: Add qdisc limit trimming tests

Cosmin Ratiu (2):
      tests/ncdevmem: Fix double-free of queue array
      net: Lock lower level devices when updating features

David S. Miller (1):
      Merge branch 'net_sched-gso_skb-flushing'

Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Gerhard Engleder (1):
      tsnep: fix timestamping with a stacked DSA driver

Hangbin Liu (1):
      tools/net/ynl: ethtool: fix crash when Hardware Clock info is missing

Hariprasad Kelam (2):
      octeontx2-pf: Fix ethtool support for SDP representors
      octeontx2-af: Fix CGX Receive counters

Ido Schimmel (1):
      mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices

Jakub Kicinski (6):
      Merge tag 'for-net-2025-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'batadv-net-pullrequest-20250509' of git://git.open-mesh.org/linux-merge
      netlink: specs: tc: fix a couple of attribute names
      netlink: specs: tc: all actions are indexed arrays
      Merge branch 'hv_netvsc-fix-error-nvsp_rndis_pkt_complete-error-status-2'
      Merge tag 'wireless-2025-05-15' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jiawen Wu (3):
      net: txgbe: Fix to calculate EEPROM checksum for AML devices
      net: libwx: Fix FW mailbox reply timeout
      net: libwx: Fix FW mailbox unknown command

Johannes Berg (1):
      Merge tag 'mt76-fixes-2025-05-15' of https://github.com/nbd168/wireless

Jonas Gorski (1):
      net: dsa: b53: prevent standalone from trying to forward to other ports

Kees Cook (1):
      wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request

Konstantin Shkolnyy (1):
      vsock/test: Fix occasional failure in SIOCOUTQ tests

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
      Bluetooth: hci_event: Fix not using key encryption size when its known

Lukas Wunner (1):
      tools: ynl-gen: Allow multi-attr without nested-attributes again

Mathieu Othacehe (1):
      net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Matt Johnston (1):
      net: mctp: Don't access ifa_index when missing

Matthias Schiffer (1):
      batman-adv: fix duplicate MAC address check

Michael Chan (1):
      bnxt_en: bring back rtnl_lock() in the bnxt_open() path

Michael Kelley (5):
      Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
      hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
      hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
      hv_netvsc: Remove rmsg_pgcnt
      Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl

Nathan Chancellor (1):
      net: qede: Initialize qede_ll_ops with designated initializer

Oleksij Rempel (2):
      net: dsa: microchip: let phylink manage PHY EEE configuration on KSZ switches
      net: phy: micrel: remove KSZ9477 EEE quirks now handled by phylink

Paolo Abeni (1):
      Merge branch 'address-eee-regressions-on-ksz-switches-since-v6-9-v6-14'

Pengtao He (1):
      net/tls: fix kernel panic when alloc_page failed

Subbaraya Sundeep (2):
      octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy
      octeontx2-pf: Do not reallocate all ntuple filters

Taehee Yoo (1):
      net: devmem: fix kernel panic when netlink socket close after module unload

Vladimir Oltean (2):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING
      docs: networking: timestamping: improve stacked PHC sentence

 Documentation/netlink/specs/tc.yaml                |  10 +-
 Documentation/networking/timestamping.rst          |   8 +-
 drivers/hv/channel.c                               |  65 +---------
 drivers/net/dsa/b53/b53_common.c                   |  33 +++++
 drivers/net/dsa/b53/b53_regs.h                     |  14 +++
 drivers/net/dsa/microchip/ksz_common.c             | 137 ++++++++++++++++-----
 drivers/net/dsa/sja1105/sja1105_main.c             |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  36 ++++--
 drivers/net/ethernet/cadence/macb_main.c           |  19 +--
 drivers/net/ethernet/engleder/tsnep_main.c         |  30 +++--
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  10 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   3 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   3 +
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |   7 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  10 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |   8 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   2 +
 drivers/net/hyperv/hyperv_net.h                    |  13 +-
 drivers/net/hyperv/netvsc.c                        |  57 +++++++--
 drivers/net/hyperv/netvsc_drv.c                    |  62 +++-------
 drivers/net/hyperv/rndis_filter.c                  |  24 +---
 drivers/net/phy/micrel.c                           |   7 --
 drivers/net/wireless/mediatek/mt76/dma.c           |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   4 +-
 drivers/scsi/storvsc_drv.c                         |   1 +
 include/linux/hyperv.h                             |   7 --
 include/linux/micrel_phy.h                         |   1 -
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/sch_generic.h                          |  15 +++
 net/batman-adv/hard-interface.c                    |  31 +++--
 net/bluetooth/hci_conn.c                           |  24 ++++
 net/bluetooth/hci_event.c                          |  73 ++++++-----
 net/bluetooth/mgmt.c                               |   9 +-
 net/core/dev.c                                     |   2 +
 net/core/devmem.c                                  |   7 ++
 net/core/devmem.h                                  |   2 +
 net/core/netdev-genl.c                             |  11 ++
 net/mac80211/main.c                                |   6 +-
 net/mctp/device.c                                  |  15 ++-
 net/mctp/route.c                                   |   4 +-
 net/sched/sch_codel.c                              |   2 +-
 net/sched/sch_fq.c                                 |   2 +-
 net/sched/sch_fq_codel.c                           |   2 +-
 net/sched/sch_fq_pie.c                             |   2 +-
 net/sched/sch_hhf.c                                |   2 +-
 net/sched/sch_pie.c                                |   2 +-
 net/tls/tls_strp.c                                 |   3 +-
 tools/net/ynl/pyynl/ethtool.py                     |  22 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   7 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  55 ++++-----
 .../tc-testing/tc-tests/qdiscs/codel.json          |  24 ++++
 .../selftests/tc-testing/tc-tests/qdiscs/fq.json   |  22 ++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json       |  22 ++++
 .../tc-testing/tc-tests/qdiscs/fq_pie.json         |  22 ++++
 .../selftests/tc-testing/tc-tests/qdiscs/hhf.json  |  22 ++++
 .../selftests/tc-testing/tc-tests/qdiscs/pie.json  |  24 ++++
 tools/testing/vsock/vsock_test.c                   |  28 +++--
 64 files changed, 698 insertions(+), 361 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/pie.json

