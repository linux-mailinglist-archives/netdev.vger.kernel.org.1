Return-Path: <netdev+bounces-236460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE055C3C7D0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 513D03488ED
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E66329C41;
	Thu,  6 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNzxP/TC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166D2EB861;
	Thu,  6 Nov 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446855; cv=none; b=Dt6iKmdxYNN4UN2VPSQAPXOy36c9fPNm1O+PZ34wGctV3lq4kRY7vM9Io16bVcf15Cl6E7SljMUcIakr2aL1mXDKDRWy+EP/SGOtW3CU+dxHUKljwPVUytMm8amVMel1MQPv/ZAJxIF7iwXGF5033YlRfklx/mDlsOgARKwlPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446855; c=relaxed/simple;
	bh=kHJzgBKHA3CArp1jt3i8frJJy0N0TA8HSqhv1du7ESk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t/hGEC9NyrJol2A4owJofaUi4YUPHrulaoBdL93BtheQgL4PqSHArGaq8abRbsN4Nadqn2wjtPjehucwBRc30Z6lA5J6uVxbl+cl6GlsZwlD+lWFE9cePb/GaLb3h5MMHrvlQ+KQj36mGAT4CVCLe8kD6OPa7dqxHdxqn2y9NV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNzxP/TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F2DC4CEF7;
	Thu,  6 Nov 2025 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446854;
	bh=kHJzgBKHA3CArp1jt3i8frJJy0N0TA8HSqhv1du7ESk=;
	h=From:To:Cc:Subject:Date:From;
	b=aNzxP/TC09Z5pQLAOLQRiBrUkYLObQAbtzkiIkJmUgzCFjIs1Kig+r0SyjYyb69Zl
	 PR09gICbwIjrJdIuG2wmFe0a6PcNzpdPmVEYeAtwAyC/TOl4WEIVbjsEy6tV8jImeQ
	 k5b1gQ6QPtJ9mnfESFgmAaiHJV85N/qfoRgy2PG/X8MjPXVDW7kXbdaeknkbv1dNlw
	 49PeDIAp2TihzuUDDMFa873hAiydLuswcGBXzQGR15Smp04KF6G8cZY5JGXBgCEbB1
	 L9v6ePVtJUsIdRLHX8h3er8g6suDo8N7qmlwxCuzSLPBhKQqWWem+uVv94aMUqXgul
	 Ay56HC6Z55tOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.18-rc5
Date: Thu,  6 Nov 2025 08:34:13 -0800
Message-ID: <20251106163413.4144149-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit e5763491237ffee22d9b554febc2d00669f81dee:

  Merge tag 'net-6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-30 18:35:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc5

for you to fetch changes up to 3534e03e0ec2e00908765549828a69df5ebefb91:

  selftests/vsock: avoid false-positives when checking dmesg (2025-11-06 07:34:50 -0800)

----------------------------------------------------------------
Including fixes from bluetooth and wireless.

Current release - new code bugs:

 - ptp: expose raw cycles only for clocks with free-running counter

 - bonding: fix null-deref in actor_port_prio setting

 - mdio: ERR_PTR-check regmap pointer returned by device_node_to_regmap()

 - eth: libie: depend on DEBUG_FS when building LIBIE_FWLOG

Previous releases - regressions:

 - virtio_net: fix perf regression due to bad alignment of
   virtio_net_hdr_v1_hash

 - Revert "wifi: ath10k: avoid unnecessary wait for service ready message"
   caused regressions for QCA988x and QCA9984

 - Revert "wifi: ath12k: Fix missing station power save configuration"
   caused regressions for WCN7850

 - eth: bnxt_en: shutdown FW DMA in bnxt_shutdown(), fix memory
   corruptions after kexec

Previous releases - always broken:

 - virtio-net: fix received packet length check for big packets

 - sctp: fix races in socket diag handling

 - wifi: add an hrtimer-based delayed work item to avoid low granularity
   of timers set relatively far in the future, and use it where it matters
   (e.g. when performing AP-scheduled channel switch)

 - eth: mlx5e:
   - correctly propagate error in case of module EEPROM read failure
   - fix HW-GRO on systems with PAGE_SIZE == 64kB

 - dsa: b53: fixes for tagging, link configuration / RMII, FDB, multicast

 - phy: lan8842: implement latest errata

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (3):
      wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
      isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()

Alok Tiwari (1):
      net: mdio: Check regmap pointer returned by device_node_to_regmap()

Anubhav Singh (2):
      selftests/net: fix out-of-order delivery of FIN in gro:tcp test
      selftests/net: use destination options instead of hop-by-hop

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

Benjamin Berg (4):
      wifi: cfg80211: add an hrtimer based delayed work item
      wifi: mac80211: use wiphy_hrtimer_work for ttlm_work
      wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work
      wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

Bobby Eshleman (1):
      selftests/vsock: avoid false-positives when checking dmesg

Breno Leitao (1):
      netpoll: Fix deadlock in memory allocation under spinlock

Bui Quang Minh (1):
      virtio-net: fix received length check in big packets

Carolina Jubran (1):
      ptp: Allow exposing cycles only for clocks with free-running counter

Dan Carpenter (1):
      octeontx2-pf: Fix devm_kcalloc() error checking

Dragos Tatulea (3):
      net/mlx5e: SHAMPO, Fix header mapping for 64K pages
      net/mlx5e: SHAMPO, Fix skb size check for 64K pages
      net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages

Gal Pressman (1):
      net/mlx5e: Fix return value in case of module EEPROM read error

Gautam R A (1):
      bnxt_en: Fix null pointer dereference in bnxt_bs_trace_check_wrap()

Gustavo Luiz Duarte (1):
      netconsole: Acquire su_mutex before navigating configs hierarchy

Hangbin Liu (2):
      net: vlan: sync VLAN features with lower device
      bonding: fix NULL pointer dereference in actor_port_prio setting

Haotian Zhang (1):
      net: wan: framer: pef2256: Switch to devm_mfd_add_devices()

Horatiu Vultur (3):
      net: phy: micrel: lan8842 errata
      net: phy: micrel: lan8842 errata
      lan966x: Fix sleeping in atomic context

Huiwen He (1):
      sctp: make sctp_transport_init() void

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Jakub Kicinski (11):
      Merge tag 'wireless-2025-10-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2025-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'gve-fix-null-dereferencing-with-ptp-clock'
      Merge branch 'net-dsa-b53-fix-bcm63xx-rgmii-user-ports-with-speed-1g'
      Merge branch 'net-dsa-b53-minor-fdb-related-fixes'
      Merge branch 'net-phy-micrel-lan8842-erratas'
      Merge branch 'fix-sctp-diag-locking-issues'
      Merge branch 'bnxt_en-bug-fixes'
      Merge branch 'net-mlx5e-shampo-fixes-for-64kb-page-size'
      Merge tag 'wireless-2025-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'net-bridge-fix-two-mst-bugs'

Jiawen Wu (1):
      net: libwx: fix device bus LAN ID

Johannes Berg (2):
      Merge tag 'ath-current-20251027' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'ath-current-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonas Gorski (7):
      net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
      MAINTAINERS: add brcm tag driver to b53
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix bcm63xx RGMII port link adjustment
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done
      net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips

Kalesh AP (1):
      bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Kashyap Desai (1):
      bnxt_en: Always provide max entry and entry size in coredump segments

Martin Willi (1):
      wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgroup

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix fdb hash size configuration

Miaoqing Pan (1):
      Revert "wifi: ath12k: Fix missing station power save configuration"

Michael Chan (1):
      bnxt_en: Shutdown FW DMA in bnxt_shutdown()

Michael S. Tsirkin (1):
      virtio_net: fix alignment for virtio_net_hdr_v1_hash

Michal Swiatkowski (1):
      libie: depend on DEBUG_FS when building LIBIE_FWLOG

Mohammad Heib (2):
      net: ionic: add dma_wmb() before ringing TX doorbell
      net: ionic: map SKB after pseudo-header checksum prep

Nikolay Aleksandrov (2):
      net: bridge: fix use-after-free due to MST port state bypass
      net: bridge: fix MST static key usage

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: hci_event: validate skb length for unknown CC opcode

Sebastian Andrzej Siewior (1):
      net: gro_cells: Reduce lock scope in gro_cell_poll

Shantiprasad Shettar (1):
      bnxt_en: Fix warning in bnxt_dl_reload_down()

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Tim Hostetler (2):
      gve: Implement gettimex64 with -EOPNOTSUPP
      gve: Implement settime64 with -EOPNOTSUPP

Tristram Ha (1):
      net: dsa: microchip: Fix reserved multicast address table programming

Vivian Wang (1):
      net: spacemit: Check netif_running() in emac_set_pauseparam()

Wang Liang (1):
      selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh

 MAINTAINERS                                        |   1 +
 drivers/bluetooth/btrtl.c                          |   4 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c              |  18 ++-
 drivers/net/bonding/bond_options.c                 |   9 +-
 drivers/net/dsa/b53/b53_common.c                   |  36 ++++-
 drivers/net/dsa/b53/b53_regs.h                     |   3 +-
 drivers/net/dsa/microchip/ksz9477.c                |  98 +++++++++++--
 drivers/net/dsa/microchip/ksz9477_reg.h            |   3 +-
 drivers/net/dsa/microchip/ksz_common.c             |   4 +
 drivers/net/dsa/microchip/ksz_common.h             |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   4 +-
 drivers/net/ethernet/google/gve/gve_ptp.c          |  15 ++
 drivers/net/ethernet/intel/Kconfig                 |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   2 -
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  24 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  72 ++++-----
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |  18 +--
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   2 -
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   4 +-
 .../ethernet/microchip/lan966x/lan966x_vcap_impl.c |   8 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  34 ++---
 drivers/net/ethernet/spacemit/k1_emac.c            |   3 +
 drivers/net/ethernet/ti/icssg/icssg_config.c       |   7 +
 drivers/net/ethernet/ti/netcp_core.c               |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   4 +-
 drivers/net/mdio/mdio-airoha.c                     |   2 +
 drivers/net/netconsole.c                           |  10 ++
 drivers/net/phy/micrel.c                           | 163 +++++++++++++++++++++
 drivers/net/usb/qmi_wwan.c                         |   6 +
 drivers/net/virtio_net.c                           |  40 +++--
 drivers/net/wan/framer/pef2256/pef2256.c           |   7 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  39 ++---
 drivers/net/wireless/ath/ath12k/mac.c              | 122 +++++++--------
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   7 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   1 +
 drivers/ptp/ptp_chardev.c                          |   4 +
 drivers/soc/ti/knav_dma.c                          |  14 +-
 include/linux/net/intel/libie/fwlog.h              |  12 ++
 include/linux/virtio_net.h                         |   3 +-
 include/net/bluetooth/mgmt.h                       |   2 +-
 include/net/cfg80211.h                             |  78 ++++++++++
 include/uapi/linux/virtio_net.h                    |   3 +-
 net/8021q/vlan.c                                   |   2 +
 net/bluetooth/hci_event.c                          |   7 +
 net/bluetooth/mgmt.c                               |   6 +-
 net/bridge/br_forward.c                            |   2 +-
 net/bridge/br_if.c                                 |   1 +
 net/bridge/br_input.c                              |   4 +-
 net/bridge/br_mst.c                                |  10 +-
 net/bridge/br_private.h                            |  13 +-
 net/core/gro_cells.c                               |   4 +-
 net/core/netpoll.c                                 |   7 +-
 net/dsa/tag_brcm.c                                 |  10 +-
 net/mac80211/chan.c                                |   2 +-
 net/mac80211/ieee80211_i.h                         |   8 +-
 net/mac80211/link.c                                |   4 +-
 net/mac80211/mlme.c                                |  52 +++----
 net/sctp/diag.c                                    |  23 ++-
 net/sctp/transport.c                               |  21 +--
 net/wireless/core.c                                |  56 +++++++
 net/wireless/trace.h                               |  21 +++
 .../selftests/drivers/net/netdevsim/Makefile       |   4 +
 tools/testing/selftests/net/gro.c                  |  12 +-
 tools/testing/selftests/vsock/vmtest.sh            |   8 +-
 72 files changed, 877 insertions(+), 334 deletions(-)

