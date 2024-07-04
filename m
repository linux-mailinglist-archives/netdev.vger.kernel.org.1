Return-Path: <netdev+bounces-109273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014A927A3A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7126B1F26057
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1C1AED3D;
	Thu,  4 Jul 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6EtkxeU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813861EB36;
	Thu,  4 Jul 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107231; cv=none; b=sLI81I99SxXvWmFLPHDyWk4SZwzsHYTwTZH6VOf6NEkhxub7vqjhHhX0mQpQQptmAxoc5nADpTfsBh2fS/MMtnNxvFjo3Dk07Q1dZNFBPUflNnD+8gmkgdPnAuu8UtL2W4CYPjEgWYfUOdxITuC7f+5owYsCUrHccg6FMgGvs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107231; c=relaxed/simple;
	bh=4XgdLSk05tD7faKO1bER9T7jrEUmirmnwljRoCtcezw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzzk6Q9yN55NWM5D2ia4VRKiStwJE2U005X3QrmykPiEo/oBJYm8GzkQbQIf9OyomHKf4uhHvCG99lUW4xzfDa2CMn4jWTOhFFTUtXfAt73juqLgZrJJGf/E4yEmojEWZIeo+k3lTue/kEtZhlzYSL+LT8sQTUwRTEU/R8HOaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6EtkxeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD0C3277B;
	Thu,  4 Jul 2024 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720107231;
	bh=4XgdLSk05tD7faKO1bER9T7jrEUmirmnwljRoCtcezw=;
	h=From:To:Cc:Subject:Date:From;
	b=C6EtkxeUdy7StgoSplc4K+aqiL5XtZoeLvsC/As46zkHrK7sBrb1wC5XAbUe/23lG
	 97mpB/RnviAA6HZo99JaJZgY1oS9NAiasiXVNTkfmeklf5NdLTDDEjNfk7vY1Dqr33
	 VjtFVaotvUqQ5ksf5/Eg83Zg1CG+9o0GfHVnwCAAbe1H1fPxkOdwnWS6REFAejAQRR
	 yAWYvenpeN0SzLCbpBIrEuOdXEh75jBRAPRLeKAZDN0mMn2ifDHqNrvlR8rYQcdgvn
	 Gp5OMGpZGnhNiXQcfkP3d7oO9CL80bcLoYpfap1eys9zVKnhjC9T1A7MF2PV9+o3/d
	 RrhJUMGmXnLcg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.10-rc7
Date: Thu,  4 Jul 2024 08:33:50 -0700
Message-ID: <20240704153350.960767-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit fd19d4a492af77b1e8fb0439781a3048d1d1f554:

  Merge tag 'net-6.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-06-27 10:05:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc7

for you to fetch changes up to 5d350dc3429b3eb6f2b1b8ccb78ed4ec6c4d4a4f:

  bnxt_en: Fix the resource check condition for RSS contexts (2024-07-04 07:40:27 -0700)

----------------------------------------------------------------
Including fixes from bluetooth, wireless and netfilter.

There's one fix for power management with Intel's e1000e here,
Thorsten tells us there's another problem that started in v6.9.
We're trying to wrap that up but I don't think it's blocking.

Current release - new code bugs:

 - wifi: mac80211: disable softirqs for queued frame handling

 - af_unix: fix uninit-value in __unix_walk_scc(), with the new garbage
   collection algo

Previous releases - regressions:

 - Bluetooth:
   - qca: fix BT enable failure for QCA6390 after warm reboot
   - add quirk to ignore reserved PHY bits in LE Extended Adv Report,
     abused by some Broadcom controllers found on Apple machines

 - wifi: wilc1000: fix ies_len type in connect path

Previous releases - always broken:

 - tcp: fix DSACK undo in fast recovery to call tcp_try_to_open(),
   avoid premature timeouts

 - net: make sure skb_datagram_iter maps fragments page by page,
   in case we somehow get compound highmem mixed in

 - eth: bnx2x: fix multiple UBSAN array-index-out-of-bounds when
   more queues are used

Misc:

 - MAINTAINERS: Remembering Larry Finger

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksandr Mishin (1):
      mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file

Bartosz Golaszewski (1):
      net: phy: aquantia: add missing include guards

Chris Mi (1):
      net/mlx5: E-switch, Create ingress ACL when needed

Daniel Gabay (1):
      wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK

Daniel Jurgens (3):
      net/mlx5: IFC updates for changing max EQs
      net/mlx5: Use max_num_eqs_24b capability if set
      net/mlx5: Use max_num_eqs_24b when setting max_io_eqs

Dave Jiang (1):
      net: ntb_netdev: Move ntb_netdev_rx_handler() to call netif_rx() from __netif_rx()

David S. Miller (3):
      Merge branch 'mlx5-fixes' into main
      Merge tag 'ieee802154-for-net-2024-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan into main
      Merge tag 'for-net-2024-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth into main

Dima Ruinskiy (1):
      e1000e: Fix S0ix residency on corporate systems

Dmitry Antipov (1):
      mac802154: fix time calculation in ieee802154_configure_durations()

Edward Adam Davis (2):
      Bluetooth: Ignore too large handle values in BIG
      bluetooth/l2cap: sync sock recv cb and release

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't wake up rx_sync_waitq upon RFKILL

Eric Dumazet (1):
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Florian Westphal (1):
      netfilter: nf_tables: unconditionally flush pending work before notifier

Furong Xu (1):
      net: stmmac: enable HW-accelerated VLAN stripping for gmac4 only

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Hector Martin (1):
      Bluetooth: hci_bcm4377: Fix msgid release

Iulia Tanasescu (1):
      Bluetooth: ISO: Check socket flag instead of hcon

Jacob Keller (2):
      ice: Don't process extts if PTP is disabled
      ice: Reject pin requests with unsupported flags

Jakub Kicinski (6):
      Merge tag 'wireless-2024-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      tcp_metrics: validate source addr length
      Merge tag 'linux-can-fixes-for-6.10-20240701' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'intel-wired-lan-driver-updates-2024-06-25-ice'
      Merge branch 'fix-oom-and-order-check-in-msg_zerocopy-selftest'
      Merge tag 'wireless-2024-07-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jianbo Liu (1):
      net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Jiawen Wu (4):
      net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
      net: txgbe: remove separate irq request for MSI and INTx
      net: txgbe: add extra handle for MSI/INTx into thread irq handle
      net: txgbe: free isb resources at the right time

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

Johannes Berg (3):
      wifi: mac80211: disable softirqs for queued frame handling
      wifi: mac80211: fix BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
      wifi: iwlwifi: mvm: avoid link lookup in statistics

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Kalle Valo (2):
      MAINTAINERS: Remembering Larry Finger
      MAINTAINERS: wifi: update ath.git location

Kuniyuki Iwashima (2):
      selftest: af_unix: Add test case for backtrack after finalising SCC.
      tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP AO.

Leon Romanovsky (2):
      net/mlx5e: Present succeeded IPsec SA bytes and packet
      net/mlx5e: Approximate IPsec per-SA payload data bytes count

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix setting of unicast qos interval
      Bluetooth: L2CAP: Fix deadlock

Marek Vasut (1):
      net: phy: phy_device: Fix PHY LED blinking code comment

Milena Olech (1):
      ice: Fix improper extts handling

Miri Korenblit (1):
      wifi: iwlwifi: mvm: check vif for NULL/ERR_PTR before dereference

Neal Cardwell (1):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Enable Power Save feature on startup

Paolo Abeni (2):
      Merge branch 'net-txgbe-fix-msi-and-intx-interrupts'
      Merge tag 'nf-24-07-04' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pavan Chebbi (1):
      bnxt_en: Fix the resource check condition for RSS contexts

Pavel Skripkin (1):
      bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX

Petr Oros (1):
      ice: use proper macro for testing bit

Radu Rendec (1):
      net: rswitch: Avoid use-after-free in rswitch_poll()

Russell King (Oracle) (1):
      wifi: wlcore: fix wlcore AP mode

Sagi Grimberg (1):
      net: allow skb_datagram_iter to be called from any context

Sam Sun (1):
      bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()

Shigeru Yoshida (2):
      af_unix: Fix uninit-value in __unix_walk_scc()
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Sven Peter (1):
      Bluetooth: Add quirk to ignore reserved PHY bits in LE Extended Adv Report

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Vijay Satija (1):
      Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity

Yijie Yang (1):
      net: stmmac: dwmac-qcom-ethqos: fix error array size

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

 CREDITS                                            |   4 +
 MAINTAINERS                                        |  13 +-
 drivers/bluetooth/btintel_pcie.c                   |   2 +-
 drivers/bluetooth/btnxpuart.c                      |   2 +-
 drivers/bluetooth/hci_bcm4377.c                    |  10 +-
 drivers/bluetooth/hci_qca.c                        |  18 ++-
 drivers/net/bonding/bond_options.c                 |   6 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         | 132 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_hwmon.c         |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 131 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   9 ++
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  46 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   4 +-
 .../mellanox/mlx5/core/esw/acl/ingress_ofld.c      |  37 ++++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  22 +++-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  10 ++
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   4 +-
 .../net/ethernet/mellanox/mlxsw/core_linecards.c   |   1 +
 drivers/net/ethernet/renesas/rswitch.c             |   4 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   7 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     | 124 ++++++++-----------
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h     |   2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   9 +-
 drivers/net/ntb_netdev.c                           |   2 +-
 drivers/net/phy/aquantia/aquantia.h                |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  14 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  15 ++-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   3 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |   7 --
 drivers/net/wireless/ti/wlcore/main.c              |  17 ++-
 drivers/net/wireless/ti/wlcore/tx.c                |   7 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h          |   6 +
 include/linux/mlx5/mlx5_ifc.h                      |   6 +-
 include/linux/phy.h                                |   2 +-
 include/net/bluetooth/hci.h                        |  11 ++
 include/net/bluetooth/hci_sync.h                   |   2 +
 include/net/mac80211.h                             |   2 +-
 net/bluetooth/hci_conn.c                           |  15 ++-
 net/bluetooth/hci_core.c                           |  76 ++++--------
 net/bluetooth/hci_event.c                          |  33 +++++-
 net/bluetooth/hci_sync.c                           |  13 ++
 net/bluetooth/iso.c                                |   3 +-
 net/bluetooth/l2cap_core.c                         |   3 +
 net/bluetooth/l2cap_sock.c                         |  14 ++-
 net/core/datagram.c                                |  19 ++-
 net/ipv4/inet_diag.c                               |   2 +
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_metrics.c                             |   1 +
 net/mac80211/main.c                                |   1 +
 net/mac80211/util.c                                |   2 +
 net/mac802154/main.c                               |  14 ++-
 net/mac802154/tx.c                                 |   8 +-
 net/netfilter/nf_tables_api.c                      |   3 +-
 net/unix/garbage.c                                 |   9 +-
 net/wireless/nl80211.c                             |   6 +-
 tools/testing/selftests/net/af_unix/scm_rights.c   |  25 +++-
 tools/testing/selftests/net/msg_zerocopy.c         |  14 ++-
 67 files changed, 629 insertions(+), 377 deletions(-)

