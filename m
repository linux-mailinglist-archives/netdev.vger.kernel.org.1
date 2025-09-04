Return-Path: <netdev+bounces-219992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2AB441BB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F553A6C5D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A32D3731;
	Thu,  4 Sep 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klDvDzMW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652F288C14;
	Thu,  4 Sep 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001590; cv=none; b=EUhVtqvdvaVqS/HDt0CYLNUu6dDIWXdqidzdvtfvnEDSE7AAeQAuWgmOzPOjioACJbd9inu9xoHCJnLxSYD5WYTRPWAeweTQYcIYrtuNEpeK9aLJeM2hUrt5oFDlRYkhgO+xGLpQh7llV/ed6aBYPiRLQFsfINh2PbIdhF100dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001590; c=relaxed/simple;
	bh=gxUB9zU4m7qTPIRXDKd0aj3mgFfne/NRRsqPXdlVvxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeu1DmqWxBxdg6YlE451UvoGew18U83uhdEAC69k2b46uonw1FS94uKQZiR5/hZsuLUrFAHorZ7Gu/q3IPIPUtilfvfKLl041trDPozW/tmzrqZbgfzsWsq0TF2HSD+5djULaxRdFMgx9++NWVnAjQ6SY1KNBkHWupK/CH2wbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klDvDzMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8D0C4CEF0;
	Thu,  4 Sep 2025 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001590;
	bh=gxUB9zU4m7qTPIRXDKd0aj3mgFfne/NRRsqPXdlVvxE=;
	h=From:To:Cc:Subject:Date:From;
	b=klDvDzMW6ep2WzqPW0JvnK7vAr6lLO7Nklz1PZaJKNN69LLkLn3yvdmaLNlIW24EE
	 e+KwMGbTV5/FQVaz7cIm0i6u53Y4Z3l+bjAWDwRb9ZG1pU20pvQJwcoEmiyEOXa0ID
	 J5+liHBgE4cuwC+Pk0vRQyoyu/GUzgPJqIMAzmBchC5lb0LT3UqY9/lrLCg2LqlYzR
	 JdopNkY3F+7i9wmzLd8kkVRy+4HXEYBHzYmDFIR0mkGIVJIREgp81KtO8SiZIG18oP
	 u4gjDbekKH/+GQkD+/mtGTDr4O98HrNSIl3O18Vje637DaPItfdBfI12grCbVdzEUQ
	 lY1TqdM5333Pg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.17-rc5
Date: Thu,  4 Sep 2025 08:59:48 -0700
Message-ID: <20250904155948.3679807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 9c736ace0666efe68efd53fcdfa2c6653c3e0e72:

  Merge tag 'net-6.17-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-28 17:35:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc5

for you to fetch changes up to 9b2bfdbf43adb9929c5ddcdd96efedbf1c88cf53:

  phy: mscc: Stop taking ts_lock for tx_queue and use its own lock (2025-09-04 07:48:29 -0700)

----------------------------------------------------------------
Including fixes from netfilter, wireless and Bluetooth.

We're reverting the removal of a Sundance driver, a user has appeared.
This makes the PR rather large in terms of LoC.

There's a conspicuous absence of real, user-reported 6.17 issues.
Slightly worried that the summer distracted people from testing.

Previous releases - regressions:

 - ax25: properly unshare skbs in ax25_kiss_rcv()

Previous releases - always broken:

 - phylink: disable autoneg for interfaces that have no inband,
   fix regression on pcs-lynx (NXP LS1088)

 - vxlan: fix null-deref when using nexthop objects

 - batman-adv: fix OOB read/write in network-coding decode

 - icmp: icmp_ndo_send: fix reversing address translation for replies

 - tcp: fix socket ref leak in TCP-AO failure handling for IPv6

 - mctp:
   - mctp_fraq_queue should take ownership of passed skb
   - usb: initialise mac header in RX path, avoid WARN

 - wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz,
   respect device limitations

 - wifi: wilc1000: avoid buffer overflow in WID string configuration

 - wifi: mt76:
   - fix regressions from mt7996 MLO support rework
   - fix offchannel handling issues on mt7996
   - fix multiple wcid linked list corruption issues
   - mt7921: don't disconnect when AP requests switch to a channel which
     requires radar detection
   - mt7925u: use connac3 tx aggr check in tx complete

 - wifi: intel:
   - improve validation of ACPI DSM data
   - cfg: restore some 1000 series configs

 - wifi: ath:
   - ath11k: a fix for GTK rekeying
   - ath12k: a missed WiFi7 capability (multi-link EMLSR)

 - eth: intel:
   - ice: fix races in "low latency" firmware interface for Tx timestamps
   - idpf: set mac type when adding and removing MAC filters
   - i40e: remove racy read access to some debugfs files

Misc:

 - Revert "eth: remove the DLink/Sundance (ST201) driver"

 - netfilter: conntrack: helper: Replace -EEXIST by -EBUSY, avoid confusing
   modprobe

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abin Joseph (1):
      net: xilinx: axienet: Add error handling for RX metadata pointer retrieval

Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for FLYPRO copper SFP+ module

Alok Tiwari (4):
      xirc2ps_cs: fix register access when enabling FullDuplex
      bnxt_en: fix incorrect page count in RX aggr ring log
      ixgbe: fix incorrect map used in eee linkmode
      mctp: return -ENOPROTOOPT for unknown getsockopt options

Arnd Bergmann (2):
      wifi: rt2800: select CONFIG_RT2X00_LIB as needed
      wifi: rt2x00: fix CRC_CCITT dependency

Asbjørn Sloth Tønnesen (1):
      tools: ynl-gen: fix nested array counting

Benjamin Berg (1):
      wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz

Chad Monroe (1):
      wifi: mt76: mt7996: use the correct vif link for scanning/roc

Christoph Paasch (1):
      net/tcp: Fix socket memory leak in TCP-AO failure handling for IPv6

Dan Carpenter (4):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()
      ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Duoming Zhou (2):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
      ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

Emil Tantilov (1):
      idpf: set mac type when adding and removing MAC filters

Emmanuel Grumbach (1):
      wifi: iwlwifi: if scratch is ~0U, consider it a failure

Eric Dumazet (3):
      net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y
      net: lockless sock_i_ino()
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bläse (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Felix Fietkau (9):
      wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
      wifi: mt76: mt7996: disable beacons when going offchannel
      wifi: mt76: mt7996: fix crash on some tx status reports
      wifi: mt76: do not add non-sta wcid entries to the poll list
      wifi: mt76: mt7996: add missing check for rx wcid entries
      wifi: mt76: mt7915: fix list corruption after hardware restart
      wifi: mt76: free pending offchannel tx frames on wcid cleanup
      wifi: mt76: fix linked list corruption
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Florian Westphal (2):
      netfilter: nft_flowtable.sh: re-run with random mtu sizes
      selftests: netfilter: fix udpclash tool hang

Harshit Mogalapalli (1):
      wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Horatiu Vultur (1):
      phy: mscc: Stop taking ts_lock for tx_queue and use its own lock

Ido Schimmel (3):
      vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
      vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects
      selftests: net: Add a selftest for VXLAN with FDB nexthop groups

Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files early

Jacob Keller (3):
      ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
      ice: fix NULL access of tx->in_use in ice_ll_ts_intr
      i40e: remove read access to debugfs files

Jakub Kicinski (14):
      Merge tag 'wireless-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-25-08-27' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'microchip-lan865x-fix-probing-issues'
      Merge tag 'for-net-2025-08-29' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      selftests: drv-net: csum: fix interface name for remote host
      Merge tag 'batadv-net-pullrequest-20250901' of https://git.open-mesh.org/linux-merge
      Revert "eth: remove the DLink/Sundance (ST201) driver"
      eth: sundance: fix endian issues
      Merge branch 'net-fix-optical-sfp-failures'
      Merge branch 'vxlan-fix-npds-when-using-nexthop-objects'
      Merge tag 'wireless-2025-09-03' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-25-09-04' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      MAINTAINERS: add Sabrina to TLS maintainers

Janusz Dziedzic (1):
      wifi: mt76: mt7921: don't disconnect when CSA to DFS chan

Jeremy Kerr (2):
      net: mctp: mctp_fraq_queue should take ownership of passed skb
      net: mctp: usb: initialise mac header in RX path

Jeroen de Borst (1):
      gve: update MAINTAINERS

Johannes Berg (8):
      wifi: iwlwifi: acpi: check DSM func validity
      wifi: iwlwifi: uefi: check DSM item validity
      Merge tag 'mt76-fixes-2025-08-27' of https://github.com/nbd168/wireless
      wifi: iwlwifi: cfg: restore some 1000 series configs
      wifi: iwlwifi: fix byte count table for old devices
      wifi: iwlwifi: cfg: add back more lost PCI IDs
      Merge tag 'iwlwifi-fixes-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-current-20250902' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Joshua Hay (1):
      idpf: fix UAF in RDMA core aux dev deinitialization

Kohei Enju (1):
      docs: remove obsolete description about threaded NAPI

Kuniyuki Iwashima (2):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      selftest: net: Fix weird setsockopt() in bind_bhash.c.

Lachlan Hodges (1):
      wifi: mac80211: increase scan_ies_len for S1G

Lad Prabhakar (1):
      net: pcs: rzn1-miic: Correct MODCTRL register offset

Liao Yuanhong (1):
      wifi: mac80211: fix incorrect type for ret

Liu Jian (1):
      net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()

Mahanta Jambigi (1):
      net/smc: Remove validation of reserved bits in CLC Decline message

Miaoqian Lin (3):
      mISDN: Fix memory leak in dsp_hwec_enable()
      eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
      net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: fix the wrong bss cleanup for SAP
      wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
      wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass conn_state for sta_cmd

Nathan Chancellor (1):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for ndev

Phil Sutter (2):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY
      netfilter: nf_tables: Introduce NFTA_DEVICE_PREFIX

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ramya Gnanasekar (1):
      wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Russell King (Oracle) (4):
      net: phy: add phy_interface_weight()
      net: phylink: provide phylink_get_inband_type()
      net: phylink: disable autoneg for interfaces that have no inband
      net: phylink: move PHY interrupt request to non-fail path

Sabrina Dubroca (1):
      macsec: read MACSEC_SA_ATTR_PN with nla_get_uint

Sean Anderson (1):
      net: macb: Fix tx_ptr_lock locking

Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

Stefan Wahren (3):
      net: ethernet: oa_tc6: Handle failure of spi_setup
      microchip: lan865x: Fix module autoloading
      microchip: lan865x: Fix LAN8651 autoloading

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (2):
      netfilter: br_netfilter: do not check confirmed bit in br_nf_local_in() after confirm
      net: atm: fix memory leak in atm_register_sysfs when device_register fail

Yue Haibing (1):
      ipv6: annotate data-races around devconf->rpl_seg_enabled

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty

 Documentation/networking/napi.rst                  |    5 +-
 MAINTAINERS                                        |    9 +-
 arch/mips/configs/mtx1_defconfig                   |    1 +
 arch/powerpc/configs/ppc6xx_defconfig              |    1 +
 drivers/bluetooth/hci_vhci.c                       |   57 +-
 drivers/isdn/mISDN/dsp_hwec.c                      |    6 +-
 drivers/net/dsa/mv88e6xxx/leds.c                   |   17 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   28 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |   20 +-
 drivers/net/ethernet/dlink/Kconfig                 |   20 +
 drivers/net/ethernet/dlink/Makefile                |    1 +
 drivers/net/ethernet/dlink/sundance.c              | 1990 ++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  123 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |    9 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   10 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    4 +-
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |    7 +-
 drivers/net/ethernet/oa_tc6.c                      |    3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   10 +
 drivers/net/ethernet/xircom/xirc2ps_cs.c           |    2 +-
 drivers/net/macsec.c                               |    8 +-
 drivers/net/mctp/mctp-usb.c                        |    1 +
 drivers/net/pcs/pcs-rzn1-miic.c                    |    2 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   18 +-
 drivers/net/phy/phylink.c                          |  103 +-
 drivers/net/phy/sfp.c                              |    3 +
 drivers/net/ppp/ppp_generic.c                      |    6 +-
 drivers/net/vxlan/vxlan_core.c                     |   18 +-
 drivers/net/vxlan/vxlan_private.h                  |    4 +-
 drivers/net/wireless/ath/ath11k/core.h             |    2 +
 drivers/net/wireless/ath/ath11k/mac.c              |  111 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   25 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    8 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    6 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   22 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |    3 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |    9 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    5 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   43 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   60 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    1 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   12 +-
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c |   39 +-
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h |    5 +-
 drivers/net/wireless/ralink/rt2x00/Kconfig         |    4 +-
 drivers/net/wireless/st/cw1200/sta.c               |    2 +-
 drivers/ptp/ptp_ocp.c                              |    3 +-
 include/linux/phy.h                                |    5 +
 include/net/sock.h                                 |   17 +-
 include/uapi/linux/netfilter/nf_tables.h           |    2 +
 net/atm/resources.c                                |    6 +-
 net/ax25/ax25_in.c                                 |    4 +
 net/batman-adv/network-coding.c                    |    7 +-
 net/bluetooth/l2cap_sock.c                         |    3 +
 net/bridge/br_netfilter_hooks.c                    |    3 -
 net/core/gen_estimator.c                           |    2 +
 net/core/sock.c                                    |   22 -
 net/ipv4/devinet.c                                 |    7 +-
 net/ipv4/icmp.c                                    |    6 +-
 net/ipv6/exthdrs.c                                 |    6 +-
 net/ipv6/ip6_icmp.c                                |    6 +-
 net/ipv6/tcp_ipv6.c                                |   32 +-
 net/mac80211/driver-ops.h                          |    2 +-
 net/mac80211/main.c                                |    7 +-
 net/mac80211/mlme.c                                |    8 +
 net/mac80211/tests/chan-mode.c                     |   30 +-
 net/mctp/af_mctp.c                                 |    2 +-
 net/mctp/route.c                                   |   35 +-
 net/mptcp/protocol.c                               |    1 -
 net/netfilter/nf_conntrack_helper.c                |    4 +-
 net/netfilter/nf_tables_api.c                      |   42 +-
 net/netlink/diag.c                                 |    2 +-
 net/smc/smc_clc.c                                  |    2 -
 net/smc/smc_ib.c                                   |    3 +
 net/wireless/scan.c                                |    3 +-
 net/wireless/sme.c                                 |    5 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |    2 +-
 tools/testing/selftests/drivers/net/hw/csum.py     |    4 +-
 tools/testing/selftests/net/Makefile               |    1 +
 tools/testing/selftests/net/bind_bhash.c           |    4 +-
 .../selftests/net/netfilter/conntrack_clash.sh     |    2 +-
 .../selftests/net/netfilter/conntrack_resize.sh    |    5 +-
 .../selftests/net/netfilter/nft_flowtable.sh       |  113 +-
 tools/testing/selftests/net/netfilter/udpclash.c   |    2 +-
 tools/testing/selftests/net/test_vxlan_nh.sh       |  223 +++
 105 files changed, 3117 insertions(+), 492 deletions(-)
 create mode 100644 drivers/net/ethernet/dlink/sundance.c
 create mode 100755 tools/testing/selftests/net/test_vxlan_nh.sh

