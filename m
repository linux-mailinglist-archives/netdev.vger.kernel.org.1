Return-Path: <netdev+bounces-134348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA5F998E48
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE11F25909
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023F19C576;
	Thu, 10 Oct 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpGqIe/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61619C567;
	Thu, 10 Oct 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581203; cv=none; b=ThNsU6POEZm+ALDk1MhNlgFqkBlUwNRQvpuvhOMz46qnqi+rT6ruencCfj/wKexXRhYZPQTSm8l/6YU61yQg+nC14aMKLenGZ2iDp7kHRzPdxEeQhaMGBJZIsfuKA3mnAFKry3r9b34d1xua2ZiL7p3TrVY3Iak7+cNk+HvHWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581203; c=relaxed/simple;
	bh=eXNV8gHDwWwsRCGRqYWnmtKvCj0CVemYc0gIjRC/i5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JOwV/Y2j2b77YWYQb1Fo9yi3TQJB/oYfJKcXYK5fSgzSbraPIVtQX8WSNzenubfkkiadPL4GXwxsGY3FCbqFuzkLSDtCcwKxFS+Z/b7GMBhUD0gj3hRxe4bfJSc4jZQ0sw6vVE/22ALZ9SuRZ5Yd/2il30TAVEkMuMS+rv+vmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpGqIe/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E5FC4CEC5;
	Thu, 10 Oct 2024 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728581202;
	bh=eXNV8gHDwWwsRCGRqYWnmtKvCj0CVemYc0gIjRC/i5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=GpGqIe/wjEOCjUq12tUrDGJ7SkbAcgNYReXfHjrt4rzQ5OC7e7Gahr94Qzpd5mlP9
	 VcjImfpO7Duq9VXh7qIHoiLpgajJrioZTheaGK43glK8yHZVZD+/rDxf9HXpwbt9GO
	 C9OSxpRGWdiquIHb0UjUgJ5Hn+1vs+advQCIYSa0tYkMvOfa5MmiYmRSTYKgC9UvAS
	 3v/DLSGpljPZkaoEbhAETpIXaVdMIDvDuKLRoaUfKB90/Pm4TvQSZ4ZYO/0qh1NC8P
	 MfyQ87ttUoexV5rM9SBJYA2f3Gsz7jEzpsPyuz+8qqxf5FGEzl+pKmcK2/DOzkEf6S
	 wzZFxb3b2cCUA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.12-rc3
Date: Thu, 10 Oct 2024 10:26:41 -0700
Message-ID: <20241010172641.1027485-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 8c245fe7dde3bf776253550fc914a36293db4ff3:

  Merge tag 'net-6.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-03 09:44:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc3

for you to fetch changes up to 7b43ba65019e83b55cfacfcfc0c3a08330af54c1:

  Merge branch 'maintainers-networking-file-coverage-updates' (2024-10-10 09:35:51 -0700)

----------------------------------------------------------------
Including fixes from bluetooth and netfilter.

Current release - regressions:

 - dsa: sja1105: fix reception from VLAN-unaware bridges

 - Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"

 - eth: fec: don't save PTP state if PTP is unsupported

Current release - new code bugs:

 - smc: fix lack of icsk_syn_mss with IPPROTO_SMC, prevent null-deref

 - eth: airoha: update Tx CPU DMA ring idx at the end of xmit loop

 - phy: aquantia: AQR115c fix up PMA capabilities

Previous releases - regressions:

 - tcp: 3 fixes for retrans_stamp and undo logic

Previous releases - always broken:

 - net: do not delay dst_entries_add() in dst_release()

 - netfilter: restrict xtables extensions to families that are safe,
   syzbot found a way to combine ebtables with extensions that are
   never used by userspace tools

 - sctp: ensure sk_state is set to CLOSED if hashing fails in
   sctp_listen_start

 - mptcp: handle consistently DSS corruption, and prevent corruption
   due to large pmtu xmit

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abhishek Chauhan (2):
      net: phy: aquantia: AQR115c fix up PMA capabilities
      net: phy: aquantia: remove usage of phy_set_max_speed

Ahmed Zaki (1):
      idpf: fix VF dynamic interrupt ctl register initialization

Aleksandr Loktionov (1):
      i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Andy Roulin (2):
      netfilter: br_netfilter: fix panic with metadata_dst skb
      selftests: add regression test for br_netfilter panic

Arkadiusz Kubalewski (1):
      ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins

Breno Leitao (1):
      net: netconsole: fix wrong warning

Christian Marangi (1):
      net: phy: Remove LED entry from LEDs list on unregister

Christophe JAILLET (2):
      net: phy: bcm84881: Fix some error handling paths
      net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()

D. Wythe (1):
      net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Dave Ertman (1):
      ice: fix VLAN replay after reset

David Howells (2):
      rxrpc: Fix a race between socket set up and I/O thread creation
      rxrpc: Fix uninitialised variable in rxrpc_send_data()

Eric Dumazet (4):
      net/sched: accept TCA_STAB only for root qdisc
      net: do not delay dst_entries_add() in dst_release()
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Florian Westphal (3):
      netfilter: xtables: avoid NFPROTO_UNSPEC where needed
      netfilter: fib: check correct rtable in vrf setups
      selftests: netfilter: conntrack_vrf.sh: add fib test case

Greg Thelen (1):
      selftests: make kselftest-clean remove libynl outputs

Gui-Dong Han (2):
      ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
      ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()

Heiner Kallweit (1):
      net: phy: realtek: Fix MMD access on RTL8126A-integrated PHY

Ignat Korchagin (1):
      net: explicitly clear the sk pointer, when pf->create fails

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Jacky Chou (1):
      net: ftgmac100: fixed not check status from fixed phy

Jakub Kicinski (12):
      Merge branch 'fix-aqr-pma-capabilities'
      Merge branch 'tcp-3-fixes-for-retrans_stamp-and-undo-logic'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'netfilter-br_netfilter-fix-panic-with-metadata_dst-skb'
      Merge branch 'ibmvnic-fix-for-send-scrq-direct'
      Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"
      Merge tag 'for-net-2024-10-04' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'selftests-net-add-missing-gitignore-and-extra_clean-entries'
      Merge branch 'mptcp-misc-fixes-involving-fallback-to-tcp'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'maintainers-networking-file-coverage-updates'

Javier Carrasco (3):
      selftests: net: add msg_oob to gitignore
      selftests: net: rds: add include.sh to EXTRA_CLEAN
      selftests: net: rds: add gitignore file for include.sh

Jijie Shao (1):
      net: hns3/hns: Update the maintainer for the HNS3/HNS ethernet driver

Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

Joshua Hay (1):
      idpf: use actual mbx receive payload length

Kacper Ludwinski (1):
      selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test

Kory Maincent (1):
      net: pse-pd: Fix enabled status mismatch

Kuniyuki Iwashima (6):
      rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
      vxlan: Handle error of rtnl_register_module().
      bridge: Handle error of rtnl_register_module().
      mctp: Handle error of rtnl_register_module().
      mpls: Handle error of rtnl_register_module().
      phonet: Handle error of rtnl_register_module().

Larysa Zaremba (1):
      idpf: deinit virtchnl transaction manager after vport and vectors

Leo Stone (1):
      Documentation: networking/tcp_ao: typo and grammar fixes

Lorenzo Bianconi (1):
      net: airoha: Update tx cpu dma ring idx at the end of xmit loop

Luiz Augusto von Dentz (3):
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
      Bluetooth: btusb: Don't fail external suspend requests

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix race condition for VLAN table access

Marcin Szycik (3):
      ice: Fix entering Safe Mode
      ice: Fix netif_is_ice() in Safe Mode
      ice: Fix increasing MSI-X on VF

Matthieu Baerts (NGI0) (2):
      mptcp: fallback when MPTCP opts are dropped after 1st data
      mptcp: pm: do not remove closing subflows

Michal Swiatkowski (2):
      ice: set correct dst VSI in only LAN filters
      ice: clear port vlan config during reset

Mohamed Khalfella (1):
      igb: Do not bring the device up after non-fatal error

Neal Cardwell (3):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
      tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out

Nick Child (1):
      ibmvnic: Inspect header requirements before using scrq direct

Nicolas Pitre (2):
      net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
      net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix module removal

Paolo Abeni (6):
      Merge branch 'fix-ti-am65-cpsw-nuss-module-removal'
      Merge branch 'net-dsa-b53-assorted-jumbo-frame-fixes'
      mptcp: handle consistently DSS corruption
      tcp: fix mptcp DSS corruption due to large pmtu xmit
      Merge tag 'nf-24-10-09' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'rtnetlink-handle-error-of-rtnl_register_module'

Przemek Kitszel (1):
      ice: fix memleak in ice_init_tx_topology()

Rosen Penev (2):
      net: ibm: emac: mal: fix wrong goto
      net: ibm: emac: mal: add dcr_unmap to _remove

Sebastian Andrzej Siewior (1):
      sfc: Don't invoke xdp_do_flush() from netpoll.

Simon Horman (3):
      docs: netdev: document guidance on cleanup patches
      MAINTAINERS: consistently exclude wireless files from NETWORKING [GENERAL]
      MAINTAINERS: Add headers and mailing list to UDP section

Vitaly Lifshits (1):
      e1000e: change I219 (19) devices to ADP

Vladimir Oltean (2):
      net: dsa: sja1105: fix reception from VLAN-unaware bridges
      net: dsa: refuse cross-chip mirroring operations

Wei Fang (1):
      net: fec: don't save PTP state if PTP is unsupported

Wojciech Drewek (1):
      ice: Flush FDB entries before reset

Xin Long (1):
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

 Documentation/networking/tcp_ao.rst                |  20 +--
 Documentation/process/maintainer-netdev.rst        |  17 +++
 MAINTAINERS                                        |  19 ++-
 drivers/bluetooth/btusb.c                          |  20 ++-
 drivers/net/dsa/b53/b53_common.c                   |  17 ++-
 drivers/net/dsa/lan9303-core.c                     |  29 ++++
 drivers/net/dsa/sja1105/sja1105_main.c             |   1 -
 drivers/net/ethernet/adi/adin1110.c                |   4 +-
 drivers/net/ethernet/amd/mvme147.c                 |   7 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   7 +-
 drivers/net/ethernet/freescale/fec_main.c          |   6 +-
 drivers/net/ethernet/ibm/emac/mal.c                |   4 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   6 +-
 drivers/net/ethernet/intel/e1000e/hw.h             |   4 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   2 +
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  58 ++++----
 drivers/net/ethernet/intel/ice/ice_ddp.h           |   4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   6 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |   5 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  39 +-----
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  19 ++-
 drivers/net/ethernet/intel/ice/ice_switch.c        |   2 -
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  11 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   9 +-
 .../net/ethernet/intel/ice/ice_vf_lib_private.h    |   1 -
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |  57 ++++++++
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h  |   1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |   1 +
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  11 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   4 +
 drivers/net/ethernet/mediatek/airoha_eth.c         |   9 +-
 drivers/net/ethernet/sfc/efx_channels.c            |   3 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  22 +--
 drivers/net/ethernet/ti/icssg/icssg_config.c       |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   2 +
 drivers/net/netconsole.c                           |   8 +-
 drivers/net/phy/aquantia/aquantia_main.c           |  51 ++++---
 drivers/net/phy/bcm84881.c                         |   4 +-
 drivers/net/phy/dp83869.c                          |   1 -
 drivers/net/phy/phy_device.c                       |   5 +-
 drivers/net/phy/realtek.c                          |  24 +++-
 drivers/net/ppp/ppp_async.c                        |   2 +-
 drivers/net/pse-pd/pse_core.c                      |  11 ++
 drivers/net/slip/slhc.c                            |  57 ++++----
 drivers/net/vxlan/vxlan_core.c                     |   6 +-
 drivers/net/vxlan/vxlan_private.h                  |   2 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |  19 ++-
 include/net/mctp.h                                 |   2 +-
 include/net/rtnetlink.h                            |  17 +++
 include/net/sch_generic.h                          |   1 -
 include/net/sock.h                                 |   2 +
 net/bluetooth/hci_conn.c                           |   3 +
 net/bluetooth/rfcomm/sock.c                        |   2 -
 net/bridge/br_netfilter_hooks.c                    |   5 +
 net/bridge/br_netlink.c                            |   6 +-
 net/bridge/br_private.h                            |   5 +-
 net/bridge/br_vlan.c                               |  19 ++-
 net/core/dst.c                                     |  17 ++-
 net/core/rtnetlink.c                               |  29 ++++
 net/dsa/user.c                                     |  11 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |   4 +-
 net/ipv4/tcp_input.c                               |  42 +++++-
 net/ipv4/tcp_output.c                              |   5 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |   5 +-
 net/mctp/af_mctp.c                                 |   6 +-
 net/mctp/device.c                                  |  32 +++--
 net/mctp/neigh.c                                   |  29 ++--
 net/mctp/route.c                                   |  33 +++--
 net/mpls/af_mpls.c                                 |  32 +++--
 net/mptcp/mib.c                                    |   2 +
 net/mptcp/mib.h                                    |   2 +
 net/mptcp/pm_netlink.c                             |   3 +-
 net/mptcp/protocol.c                               |  24 +++-
 net/mptcp/subflow.c                                |   6 +-
 net/netfilter/xt_CHECKSUM.c                        |  33 +++--
 net/netfilter/xt_CLASSIFY.c                        |  16 ++-
 net/netfilter/xt_CONNSECMARK.c                     |  36 +++--
 net/netfilter/xt_CT.c                              | 148 +++++++++++++--------
 net/netfilter/xt_IDLETIMER.c                       |  59 +++++---
 net/netfilter/xt_LED.c                             |  39 ++++--
 net/netfilter/xt_NFLOG.c                           |  36 +++--
 net/netfilter/xt_RATEEST.c                         |  39 ++++--
 net/netfilter/xt_SECMARK.c                         |  27 +++-
 net/netfilter/xt_TRACE.c                           |  35 +++--
 net/netfilter/xt_addrtype.c                        |  15 ++-
 net/netfilter/xt_cluster.c                         |  33 +++--
 net/netfilter/xt_connbytes.c                       |   4 +-
 net/netfilter/xt_connlimit.c                       |  39 ++++--
 net/netfilter/xt_connmark.c                        |  28 +++-
 net/netfilter/xt_mark.c                            |  42 ++++--
 net/netlink/af_netlink.c                           |   3 +-
 net/phonet/pn_netlink.c                            |  28 ++--
 net/rxrpc/ar-internal.h                            |   2 +-
 net/rxrpc/io_thread.c                              |  10 +-
 net/rxrpc/local_object.c                           |   2 +-
 net/rxrpc/sendmsg.c                                |  10 +-
 net/sched/sch_api.c                                |   7 +-
 net/sctp/socket.c                                  |  18 ++-
 net/smc/smc_inet.c                                 |  11 ++
 net/socket.c                                       |   7 +-
 tools/testing/selftests/net/.gitignore             |   1 +
 .../selftests/net/forwarding/no_forwarding.sh      |   2 +-
 tools/testing/selftests/net/netfilter/Makefile     |   1 +
 tools/testing/selftests/net/netfilter/config       |   2 +
 .../selftests/net/netfilter/conntrack_vrf.sh       |  33 +++++
 .../selftests/net/netfilter/vxlan_mtu_frag.sh      | 121 +++++++++++++++++
 tools/testing/selftests/net/rds/.gitignore         |   1 +
 tools/testing/selftests/net/rds/Makefile           |   2 +-
 tools/testing/selftests/net/ynl.mk                 |   4 +
 115 files changed, 1360 insertions(+), 509 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh
 create mode 100644 tools/testing/selftests/net/rds/.gitignore

