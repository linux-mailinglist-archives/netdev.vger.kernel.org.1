Return-Path: <netdev+bounces-125721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5C96E5D8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18ADB203FC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAEE19882F;
	Thu,  5 Sep 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRPpZ0rI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494114F121;
	Thu,  5 Sep 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725576339; cv=none; b=cX+9v9WWyBA3eLwiuLTf3kbQ49a8ZX77semunXa5E0MOxtZM93Y40i+iES4g/0BzLU2nr0hpYWoy2tO/Yi5AsKvderKGnvsXLby1hR8MK22D6U7IF6HPCyZIvzrCU4K4/MzGGgl0+veK0WW+LSraxMJAjUZoz8hPO1Rh/ijMFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725576339; c=relaxed/simple;
	bh=+VQpzNPKWK9Gs6pPPjuKIh62rHIX/AnfYSyWJgGlf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XACq0odyQoRMBtALhKMnSGIIG9yi7pePqxEVPg4xB/LouNBu7YYLERutfwNtiKR888bSOJmhrzdpphDH1+1jcdIijcSYQfZeazyEL52ARTiRcODIX2zLpEHGWEhjKdWsFaUcKw6S9Nm5km+LhoELeeSogLGZr1KKlRg/4IhVhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRPpZ0rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A6C4CEC3;
	Thu,  5 Sep 2024 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725576338;
	bh=+VQpzNPKWK9Gs6pPPjuKIh62rHIX/AnfYSyWJgGlf8o=;
	h=From:To:Cc:Subject:Date:From;
	b=bRPpZ0rIthZ9UAu5TNdXSfqF9Sy/SynP3IiAg1cTCwO0oGpO2qy7mRxrhMmoGLmCF
	 6+StOZOrmLXJvnG/+iNMcchiqkwk5IuWmCnqUvHhNH27Ku4aAB/duqe1tz/cW6ab+t
	 SKBHbhbdP+S7+o/GM3csS3E9CFGU/9xoxJKKo+GzC7stII/VJd4pVONC2YH2o0YePa
	 V7sQJYRWZeNGz9rR6EVoaeZTCvUDhSpUpUgdd4BuqkKX/67PAHPirSKzpJeYL4UxVw
	 NjXJIYlMxStKWlHaEYG9aOs1qE95V3Mb6OzlCoVRgh3osPKXljPbViWQ6tvgsgjVTg
	 DbbvPA5EfxMSQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.11-rc7
Date: Thu,  5 Sep 2024 15:45:37 -0700
Message-ID: <20240905224537.2051389-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 0dd5dd63ba91d7bee9d0fbc2a6dc73e595391b4c:

  Merge tag 'net-6.11-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-08-30 06:14:39 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc7

for you to fetch changes up to 031ae72825cef43e4650140b800ad58bf7a6a466:

  ila: call nf_unregister_net_hooks() sooner (2024-09-05 14:57:12 -0700)

----------------------------------------------------------------
Including fixes from can, bluetooth and wireless.

No known regressions at this point. Another calm week, but chances are
that has more to do with vacation season than the quality of our work.

Current release - new code bugs:

 - smc: prevent NULL pointer dereference in txopt_get

 - eth: ti: am65-cpsw: number of XDP-related fixes

Previous releases - regressions:

 - Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over
   BREDR/LE", it breaks existing user space

 - Bluetooth: qca: if memdump doesn't work, re-enable IBS to avoid
   later problems with suspend

 - can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

 - eth: r8152: fix the firmware communication error due to use
   of bulk write

 - ptp: ocp: fix serial port information export

 - eth: igb: fix not clearing TimeSync interrupts for 82580

 - Revert "wifi: ath11k: support hibernation", fix suspend on Lenovo

Previous releases - always broken:

 - eth: intel: fix crashes and bugs when reconfiguration and resets
   happening in parallel

 - wifi: ath11k: fix NULL dereference in ath11k_mac_get_eirp_power()

Misc:

 - docs: netdev: document guidance on cleanup.h

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Arkadiusz Kubalewski (1):
      tools/net/ynl: fix cli.py --subscribe feature

Baochen Qiang (3):
      wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()
      Revert "wifi: ath11k: restore country code during resume"
      Revert "wifi: ath11k: support hibernation"

Breno Leitao (1):
      net: dqs: Do not use extern for unused dql_group

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (1):
      igc: Unlock on error in igc_io_resume()

David S. Miller (1):
      Merge branch 'mctp-serial-tx-escapes'

Dawid Osuchowski (1):
      ice: Add netif_device_attach/detach into PF reset flow

Douglas Anderson (1):
      Bluetooth: qca: If memdump doesn't work, re-enable IBS

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Guillaume Nault (1):
      bareudp: Fix device stats updates.

Hayes Wang (1):
      r8152: fix the firmware doesn't work

Jakub Kicinski (7):
      MAINTAINERS: exclude bluetooth and wireless DT bindings from netdev ML
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'linux-can-fixes-for-6.11-20240830' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'for-net-2024-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'wireless-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      docs: netdev: document guidance on cleanup.h

Jamie Bainbridge (1):
      selftests: net: enable bind tests

Jens Emil Schulz Østergaard (1):
      net: microchip: vcap: Fix use-after-free error in kunit test

Jeongjun Park (1):
      net/smc: prevent NULL pointer dereference in txopt_get

Jinjie Ruan (1):
      net: phy: Fix missing of_node_put() for leds

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Kalle Valo (1):
      Merge tag 'ath-current-20240903' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kuniyuki Iwashima (2):
      can: bcm: Remove proc entry when dev is unregistered.
      fou: Fix null-ptr-deref in GRO.

Larysa Zaremba (6):
      ice: move netif_queue_set_napi to rtnl-protected sections
      ice: protect XDP configuration with a mutex
      ice: check for XDP rings instead of bpf program when unconfiguring
      ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
      ice: remove ICE_CFG_BUSY locking from AF_XDP code
      ice: do not bring the VSI up, if it was down before the XDP setup

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type

Marc Kleine-Budde (4):
      Merge patch series "can: m_can: Fix polling and other issues"
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
      Merge patch series "can: mcp251xfd: fix ring/coalescing configuration"

Markus Schneider-Pargmann (7):
      can: m_can: Reset coalescing during suspend/resume
      can: m_can: Remove coalesing disable in isr during suspend
      can: m_can: Remove m_can_rx_peripheral indirection
      can: m_can: Do not cancel timer from within timer
      can: m_can: disable_all_interrupts, not clear active_interrupts
      can: m_can: Reset cached active_interrupts on start
      can: m_can: Limit coalescing to peripheral instances

Martin Jocic (1):
      can: kvaser_pciefd: Use a single write when releasing RX buffers

Matt Johnston (2):
      net: mctp-serial: Add kunit test for next_chunk_len()
      net: mctp-serial: Fix missing escapes on transmit

Oliver Neukum (1):
      usbnet: modern method to get random MAC

Paolo Abeni (2):
      Merge branch 'net-ethernet-ti-am65-cpsw-fix-xdp-implementation'
      Merge branch 'ptp-ocp-fix-serial-port-information-export'

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
      net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
      net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and XDP_REDIRECT

Sean Anderson (1):
      net: xilinx: axienet: Fix race in axienet_stop

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (2):
      can: m_can: Release irq on error in m_can_open
      MAINTAINERS: wifi: cw1200: add net-cw1200.h

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Toke Høiland-Jørgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Tze-nan Wu (1):
      bpf, net: Fix a potential race in do_sock_getsockopt()

Vadim Fedorenko (4):
      ptp: ocp: convert serial ports to array
      ptp: ocp: adjust sysfs entries to expose tty information
      docs: ABI: update OCP TimeCard sysfs entries
      MAINTAINERS: fix ptp ocp driver maintainers address

 Documentation/ABI/testing/sysfs-timecard           |  33 ++--
 Documentation/process/maintainer-netdev.rst        |  16 ++
 MAINTAINERS                                        |   5 +-
 drivers/bluetooth/hci_qca.c                        |   1 +
 drivers/net/bareudp.c                              |  22 +--
 drivers/net/can/kvaser_pciefd.c                    |  18 +-
 drivers/net/can/m_can/m_can.c                      | 116 +++++++-----
 drivers/net/can/spi/mcp251x.c                      |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c      |  11 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |  34 +++-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  10 +-
 drivers/net/ethernet/intel/ice/ice.h               |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c          |  11 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           | 201 ++++++++-------------
 drivers/net/ethernet/intel/ice/ice_lib.h           |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  54 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  18 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  10 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   1 +
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  14 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  22 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  82 +++++----
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   3 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   8 +
 drivers/net/mctp/Kconfig                           |   5 +
 drivers/net/mctp/mctp-serial.c                     | 113 +++++++++++-
 drivers/net/phy/phy_device.c                       |   2 +
 drivers/net/usb/r8152.c                            |  17 +-
 drivers/net/usb/usbnet.c                           |  11 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             | 119 ++++--------
 drivers/net/wireless/ath/ath11k/core.h             |   4 -
 drivers/net/wireless/ath/ath11k/hif.h              |  12 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |  12 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |   3 +-
 drivers/net/wireless/ath/ath11k/pci.c              |  44 +----
 drivers/net/wireless/ath/ath11k/qmi.c              |   2 +-
 drivers/ptp/ptp_ocp.c                              | 168 ++++++++++-------
 include/linux/bpf-cgroup.h                         |   9 -
 include/net/bluetooth/hci_core.h                   |   5 -
 include/net/bluetooth/hci_sync.h                   |   4 +
 include/net/mana/mana.h                            |   2 +
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_sync.c                           |  42 ++++-
 net/bluetooth/mgmt.c                               | 144 +++++++--------
 net/bluetooth/smp.c                                |   7 -
 net/bridge/br_fdb.c                                |   6 +-
 net/can/bcm.c                                      |   4 +
 net/core/net-sysfs.c                               |   2 +-
 net/ipv4/fou_core.c                                |  29 ++-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv6/ila/ila.h                                 |   1 +
 net/ipv6/ila/ila_main.c                            |   6 +
 net/ipv6/ila/ila_xlat.c                            |  13 +-
 net/sched/sch_cake.c                               |  11 +-
 net/sched/sch_netem.c                              |   9 +-
 net/smc/smc.h                                      |   3 +
 net/smc/smc_inet.c                                 |   8 +-
 net/socket.c                                       |   4 +-
 tools/net/ynl/lib/ynl.py                           |   7 +-
 tools/testing/selftests/net/Makefile               |   3 +-
 62 files changed, 867 insertions(+), 681 deletions(-)

