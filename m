Return-Path: <netdev+bounces-128426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76E9797EC
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299081F21778
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8B1C9DE5;
	Sun, 15 Sep 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX6Oi53C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A1381AD;
	Sun, 15 Sep 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726421253; cv=none; b=kP4sY7rGWt+VM9TF9pHkYOpHNMZ9W3D/UYtqyWjYhGuCFsYDdoCDcinjXlilVcyzqHyos3uHRJg95ucFQ67kAuHQozLcJGE0nlxiVCoIBqtZsevX6jcxN83AtEdS37ylEMN45rmNVQGOABpn4yLmWniXUv9AWUNdfqyfdxRG+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726421253; c=relaxed/simple;
	bh=0mX63RY/2Mfy94ORtMebewt5bbWIkHVrq9TOk08TMgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIBog5WRH2Kx1waSZ/xBH3rIEglL+eQ6mrnl9t3flyMEfHEGaUMa7OitVguYysWfPb1+1VaodHvwchvLpCog1IpHuUIjzeOefQ5MNBPUoYujIhNTJnHMolDOdnK8cfAZi+WoT8X7+SurVEDmK4VOyQRNYDfZoDdvWXkNjfFPFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX6Oi53C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C49C4CEC3;
	Sun, 15 Sep 2024 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726421251;
	bh=0mX63RY/2Mfy94ORtMebewt5bbWIkHVrq9TOk08TMgw=;
	h=From:To:Cc:Subject:Date:From;
	b=uX6Oi53CH8aik151yY6m8nCLHg42bBiOAjhcQ3lqpfXTrhzZqyOBRlFRO/siqc/bm
	 GvL+XEbHCqLUD8RblVC/+R/1cz5kwWlCeAaMdvq7cEa/HhyuF0so+vjGRoY+duhFdi
	 SbJ+7Sz0PICX7XGLSV4mxuLVKhoSEvbCR6MB0aEL6JGcQql0PlJ1lOeJNV+qjt2kAf
	 qDnNLvQVodmTz6BaYSla7isONnRpCSv1hDjjMD1VDIM5j2i1rwyGLNQ1NOgdxpjsbV
	 pCj2M5HUhKmr6napXkpRugeGhZHVd/UdNueRs6oItxaWmzi1U6LaXKKbnDfrkTmtDH
	 fBIfKXLh1M97w==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.12
Date: Sun, 15 Sep 2024 10:27:30 -0700
Message-ID: <20240915172730.2697972-1-kuba@kernel.org>
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

The following changes since commit 5abfdfd402699ce7c1e81d1a25bc37f60f7741ff:

  Merge tag 'net-6.11-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-09-12 12:45:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.12

for you to fetch changes up to 3561373114c8b3359114e2da27259317dc51145a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-09-15 09:13:19 -0700)

----------------------------------------------------------------
Networking changes for 6.12.

The zero-copy changes are relatively significant, but regression risk
should be contained. The feature needs to be used to cause trouble.
The new code did trigger a PowerPC64 bug with GCC 14:

  https://lore.kernel.org/netdev/20240913125302.0a06b4c7@canb.auug.org.au/

a fix for which Michael will bring via his tree:

  https://lore.kernel.org/all/87jzffq9ge.fsf@mail.lhotse/

Unideal, not sure if you'll be willing to pull without that fix but
since we caught this recently I figured we'll defer to you during
the MW instead of trying to fix it cross-tree.

Also it feels like we got an order of magnitude more semi-automated
"refactoring" chaff than usual, I wonder if it's just us.

Core & protocols
----------------

 - Support Device Memory TCP, ability to zero-copy receive TCP payloads
   to a DMABUF region of memory while packet headers land separately
   in normal kernel buffers, and TCP processes then as usual.

 - The ability to read the PTP PHC (Physical Hardware Clock) alongside
   MONOTONIC_RAW timestamps with PTP_SYS_OFFSET_EXTENDED. Previously
   only CLOCK_REALTIME was supported.

 - Allow matching on all bits of IP DSCP for routing decisions.
   Previously we only supported on matching TOS bits in IPv4 which
   is a narrower interpretation of the same header field.

 - Increase the range of weights used for multi-path routing from
   8 bits to 16 bits.

 - Add support for IPv6 PIO p flag in the Prefix Information Option
   per draft-ietf-6man-pio-pflag.

 - IPv6 IOAM6 support for new tunsrc encap mode for better performance.

 - Detect destinations which blackhole MPTCP traffic and avoid initiating
   MPTCP connections to them for a certain period of time, 1h by default.

 - Improve IPsec control path performance by removing the inexact
   policies list.

 - AF_VSOCK: add support for SIOCOUTQ ioctl.

 - Add enum for reasons TCP reset was sent for easier tracing.

 - Add SMC ringbufs usage statistics.

Drivers
-------

 - Handle netconsole setup failures more gracefully, don't fail loading,
   retain the specified target as disabled.

 - Extend bonding's IPsec offload pass thru capabilities (ESN, stats).

Filtering
---------

 - Add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt() to address the case
   when long-lived sockets miss a chance to set additional callbacks
   if a sockops program was not attached early in their lifetime.

 - Support using BPF skb helpers in tracepoints.

 - Conntrack Netlink: support CTA_FILTER for flush.

 - Improve SCTP support in nfnetlink_queue.

 - Improve performance of large nftables flush transactions.

Things we sprinkled into general kernel code
--------------------------------------------

 - selftests: support setting an "interpreter" for script files;
   make it easy to run as separate cases tests where one "interpreter"
   is fed various test descriptions (in our case packet sequences).

Driver API
----------

 - Extend core and ethtool APIs to support many PHYs connected to a single
   interface (PHY topologies).

 - Extend cable diagnostics to specify whether Time Domain Reflectometry
   (TDR) or Active Link Cable Diagnostic (ALCD) was used.

 - Add library for implementing MAC-PHY Ethernet drivers for SPI devices
   compatible with Open Alliance 10BASE-T1x MAC-PHY Serial Interface (TC6)
   standard.

 - Add helpers to the PHY framework, for PHYs following the Open Alliance
   standards:
   - 1000BaseT1 link settings
   - cable test and diagnostics

 - Support listing / dumping all allocated RSS contexts.

 - Add configuration for frequency Embedded SYNC in DPLL, which magically
   embeds sync pulses into Ethernet signaling.

Device drivers
--------------

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
     - use better FW APIs for queue reset
     - support QOS and TPID settings for the SR-IOV VLAN
     - support dynamic MSI-X allocation
   - Intel (100G, ice, idpf):
     - ice: support PCIe subfunctions
     - iavf: add support for TC U32 filters on VFs
     - ice: support Embedded SYNC in DPLL
   - nVidia/Mellanox (mlx5):
     - support HW managed steering tables
     - support PCIe PTM cross timestamping
   - AMD/Pensando:
     - ionic: use page_pool to increase Rx performance
   - Cisco (enic):
     - report per-queue statistics

 - Ethernet virtual:
   - Microsoft vNIC:
     - mana: support configuring ring length
     - netvsc: enable more channels on systems with many CPUs
   - IBM veth:
     - optimize polling to improve TCP_RR performance
     - optimize performance of Tx handling
   - VirtIO net:
     - synchronize the operstate with the admin state to allow a lower
       virtio-net to propagate the link status to an upper device like
       macvlan

 - Ethernet NICs consumer, and embedded:
   - Add driver for Realtek automotive PCIe devices (RTL9054, RTL9068,
     RTL9072, RTL9075, RTL9068, RTL9071)
   - Add driver for Microchip LAN8650/1 10BASE-T1S MAC-PHY.
   - Microchip:
     - lan743x: use phylink - support WOL, EEE, pause, link settings
     - add Wake-on-LAN support for KSZ87xx family
     - add KSZ8895/KSZ8864 switch support
     - factor out FDMA code and use it in sparx5 and lan966x
       (including DCB support in both)
   - Synopsys (stmmac):
     - support frame preemption (configured using TC and ethtool)
     - support Loongson DWMAC (GMAC v3.73)
     - support RockChips RK3576 DWMAC
   - TI:
     - am65-cpsw: add multi queue RX support
     - icssg-prueth: HSR offload support
   - Cadence (macb):
     - enable software (hrtimer based) IRQ coalescing by default
   - Xilinx (axinet):
     - expose HW statistics
     - improve multicast filtering
     - relax Rx checksum offload constraints
   - MediaTek:
     - mt7530: add EN7581 support
   - Aspeed (ftgmac100):
     - report link speed and duplex
   - Intel:
     - igc: add mqprio offload
     - igc: report EEE configuration
   - RealTek (r8169):
     - add support for RTL8126A rev.b
   - Vitesse (vsc73xx):
     - implement FDB add/del/dump operations
   - Freescale (fs_enet):
     - use phylink

 - Ethernet PHYs:
   - vitesse: implement downshift and MDI-X in vsc73xx PHYs
   - microchip: support LAN887x, supporting IEEE 802.3bw (100BASE-T1)
     and IEEE 802.3bp (1000BASE-T1) specifications
   - add Applied Micro QT2025 PHY driver (in Rust)
   - add Motorcomm yt8821 2.5G Ethernet PHY driver

 - CAN:
   - add driver for Rockchip RK3568 CAN-FD controller
   - flexcan: add wakeup support for imx95
   - kvaser_usb: set hardware timestamp on transmitted packets

 - WiFi:
   - mac80211/cfg80211:
     - EHT rate support in AQL airtime fairness
     - handle DFS (radar detection) per link in Multi-Link Operation
   - RealTek (rtw89):
     - support RTL8852BT and 8852BE-VT (WiFi 6)
     - support hardware rfkill
     - support HW encryption in unicast management frames
     - support Wake-on-WLAN with supported network detection
   - RealTek (rtw89):
     - improve Rx performance by using USB frame aggregation
     - support USB 3 with RTL8822CU/RTL8822BU
   - Intel (iwlwifi/mvm):
     - offload RLC/SMPS functionality to firmware
   - Marvell (mwifiex):
     - add host based MLME to enable WPA3

 - Bluetooth:
   - add support for Amlogic HCI UART protocol
   - add support for ISO data/packets to Intel and NXP drivers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
A K M Fazla Mehrab (1):
      net/handshake: use sockfd_put() helper

Abhash Jha (1):
      selftests/net/pmtu.sh: Fix typo in error message

Abhinav Jain (3):
      selftests: net: Create veth pair for testing in networkless kernel
      selftests: net: Add on/off checks for non-fixed features of interface
      selftests: net: Use XFAIL for operations not supported by the driver

Aditya Kumar Singh (9):
      wifi: ath12k: restore ASPM for supported hardwares only
      Revert "wifi: mac80211: move radar detect work to sdata"
      wifi: mac80211: remove label usage in ieee80211_start_radar_detection()
      wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt class
      wifi: cfg80211: move DFS related members to links[] in wireless_dev
      wifi: cfg80211: handle DFS per link
      wifi: mac80211: handle DFS per link
      wifi: cfg80211/mac80211: use proper link ID for DFS
      wifi: mac80211: handle ieee80211_radar_detected() for MLO

Ahmed Zaki (2):
      iavf: refactor add/del FDIR filters
      iavf: add support for offloading tc U32 cls filters

Alan Maguire (2):
      bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
      selftests/bpf: add sockopt tests for TCP_BPF_SOCK_OPS_CB_FLAGS

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: remove unused variable

Aleksandr Loktionov (1):
      i40e: Add Energy Efficient Ethernet ability for X710 Base-T/KR/KX cards

Aleksandr Mishin (1):
      ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Alexander Dahl (1):
      net: mdiobus: Debug print fwnode handle instead of raw pointer

Alexander Hall (1):
      Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604

Alexander Lobakin (8):
      netdevice: convert private flags > BIT(31) to bitfields
      netdev_features: convert NETIF_F_LLTX to dev->lltx
      netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local
      netdev_features: convert NETIF_F_FCOE_MTU to dev->fcoe_mtu
      netdev_features: remove NETIF_F_ALL_FCOE
      libeth: add Tx buffer completion helpers
      idpf: convert to libeth Tx buffer completion
      netdevice: add netdev_tx_reset_subqueue() shorthand

Allen Pais (4):
      net: alteon: Convert tasklet API to new bottom half workqueue mechanism
      net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
      net: cnic: Convert tasklet API to new bottom half workqueue mechanism
      net: macb: Convert tasklet API to new bottom half workqueue mechanism

Anand Khoje (1):
      net/mlx5: Reclaim max 50K pages at once

Andrew Halaney (1):
      net: stmmac: drop the ethtool begin() callback

Andy Shevchenko (3):
      net: ethernet: ti: am65-cpsw-nuss: Replace of_node_to_fwnode() with more suitable API
      net: dsa: mv88e6xxx: Remove stale comment
      net: macb: Use predefined PCI vendor ID constant

Anjaneyulu (1):
      wifi: iwlwifi: allow only CN mcc from WRDD

Antonio Ojea (2):
      netfilter: nfnetlink_queue: unbreak SCTP traffic
      selftests: netfilter: nft_queue.sh: sctp coverage

Appana Durga Kedareswara Rao (1):
      net: axienet: Replace the occurrences of (1<<x) by BIT(x)

Arend van Spriel (1):
      wifi: brcmfmac: introducing fwil query functions

Arkadiusz Kubalewski (2):
      dpll: add Embedded SYNC feature for a pin
      ice: add callbacks for Embedded SYNC enablement on dpll pins

Arnd Bergmann (1):
      can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation

Asbjørn Sloth Tønnesen (1):
      selftests/bpf: Avoid subtraction after htons() in ipip tests

Avraham Stern (3):
      wifi: iwlwifi: mei: add support for SAP version 4
      wifi: iwlwifi: mvm: set the cipher for secured NDP ranging
      wifi: iwlwifi: mvm: increase the time between ranging measurements

Baochen Qiang (1):
      wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

Bartosz Golaszewski (1):
      dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855

Benjamin Lin (3):
      wifi: mt76: connac: add IEEE 802.11 fragmentation support for mt7996
      wifi: mt76: connac: add support for IEEE 802.11 fragmentation
      wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation

Bitterblue Smith (9):
      wifi: rtw88: Set efuse->ext_lna_5g - fix typo
      wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
      wifi: rtw88: 8822c: Fix reported RX band width
      wifi: rtw88: 8703b: Fix reported RX band width
      wifi: rtw88: usb: Init RX burst length according to USB speed
      wifi: rtw88: usb: Update the RX stats after every frame
      wifi: rtw88: usb: Support RX aggregation
      wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c
      wifi: rtw88: Fix USB/SDIO devices not transmitting beacons

Bjørn Mork (1):
      wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Boris Sukholitko (3):
      tc: adjust network header after 2nd vlan push
      selftests: tc_actions: test ingress 2nd vlan push
      selftests: tc_actions: test egress 2nd vlan push

Breno Leitao (12):
      net: skbuff: Skip early return in skb_unref when debugging
      net: netconsole: Fix MODULE_AUTHOR format
      net: veth: Disable netpoll support
      net: netpoll: extract core of netpoll_cleanup
      net: netconsole: Correct mismatched return types
      net: netconsole: Standardize variable naming
      net: netconsole: Unify Function Return Paths
      net: netconsole: Defer netpoll cleanup to avoid lock release during list traversal
      netpoll: Ensure clean state on setup failures
      net: netconsole: Populate dynamic entry even if netpoll fails
      net: netconsole: selftests: Create a new netconsole selftest
      netkit: Assign missing bpf_net_context

Brett Creeley (3):
      ionic: Fully reconfigure queues when going to/from a NULL XDP program
      ionic: Allow XDP program to be hot swapped
      fbnic: Set napi irq value after calling netif_napi_add

Bruce Allan (1):
      ice: do not clutter debug logs with unused data

Carolina Jubran (1):
      net/mlx5: Add support for enabling PTM PCI capability

Changliang Wu (1):
      netfilter: ctnetlink: support CTA_FILTER for flush

Chen Ni (8):
      selftests: net: convert comma to semicolon
      ptp: ptp_idt82p33: Convert comma to semicolon
      wifi: mt76: mt7925: convert comma to semicolon
      net: atlantic: convert comma to semicolon
      ionic: Convert comma to semicolon
      sfc/siena: Convert comma to semicolon
      sfc: convert comma to semicolon
      wifi: brcmfmac: cfg80211: Convert comma to semicolon

Chen Yufan (1):
      wifi: mwifiex: Convert to use jiffies macro

Chia-Yuan Li (1):
      wifi: rtw89: limit the PPDU length for VHT rate to 0x40000

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Chin-Yen Lee (8):
      wifi: rtw89: wow: implement PS mode for net-detect
      wifi: rtw89: wow: add WoWLAN net-detect support
      wifi: rtw89: wow: add delay option for net-detect
      wifi: rtw89: wow: add net-detect support for 8852c
      wifi: rtw89: 8852a: adjust ANA clock to 12M
      wifi: rtw89: wow: add wait for H2C of FW-IPS mode
      wifi: rtw89: wow: add net-detect support for 8922ae
      wifi: rtw89: wow: add scan interval option for net-detect

Ching-Te Ku (4):
      wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0 for RTL8852BT
      wifi: rtw89: coex: Update Wi-Fi role info version 7
      wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
      wifi: rtw89: coex: Add new Wi-Fi role format condition for function using

Chris Mi (1):
      net/mlx5: E-Switch, Increase max int port number for offload

Christian Hopps (1):
      net: add copy from skb_seq_state to buffer function

Christoph Paasch (1):
      mpls: Reduce skb re-allocations due to skb_cow()

Christophe JAILLET (10):
      wifi: brcmfmac: fwsignal: Use struct_size() to simplify brcmf_fws_rxreorder()
      tcp: Use clamp() in htcp_alpha_update()
      wifi: b43: Constify struct lpphy_tx_gain_table_entry
      net: sungem_phy: Constify struct mii_phy_def
      net: netconsole: Constify struct config_item_type
      net: netlink: Remove the dump_cb_mutex field from struct netlink_sock
      wifi: lib80211: Handle const struct lib80211_crypto_ops in lib80211
      wifi: lib80211: Constify struct lib80211_crypto_ops
      staging: rtl8192e: Constify struct lib80211_crypto_ops
      wifi: rsi: Remove an unused field in struct rsi_debugfs

Christophe Leroy (1):
      net: fs_enet: Fix warning due to wrong type

ChunHao Lin (1):
      r8169: add support for RTL8126A rev.b

Colin Ian King (5):
      wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"
      tools: ynl: remove extraneous ; after statements
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"
      rtase: Fix spelling mistake: "tx_underun" -> "tx_underrun"
      qlcnic: make read-only const array key static

Cong Wang (1):
      l2tp: avoid overriding sk->sk_user_data

Cosmin Ratiu (2):
      net/mlx5e: CT: 'update' rules instead of 'replace'
      net/mlx5e: CT: Update connection tracking steering entries

Csókás, Bence (2):
      net: fec: Move `fec_ptp_read()` to the top of the file
      net: fec: Remove duplicated code

D. Wythe (1):
      net/smc: add sysctl for smc_limit_hs

Dan Carpenter (7):
      ice: Fix a 32bit bug
      wifi: mwifiex: Fix uninitialized variable in mwifiex_cfg80211_authenticate()
      rtase: Fix error code in rtase_init_board()
      ice: Fix a couple NULL vs IS_ERR() bugs
      ice: Fix a NULL vs IS_ERR() check in probe()
      netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()
      net/mlx5: HWS, check the correct variable in hws_send_ring_alloc_sq()

Daniel Borkmann (1):
      netkit: Disable netpoll support

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Offload RLC/SMPS functionality to firmware
      wifi: iwlwifi: mvm: Remove unused last_sub_index from reorder buffer

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: drop clocks unused by Ethernet driver

Daniel Machon (24):
      net: microchip: add FDMA library
      net: sparx5: use FDMA library symbols
      net: sparx5: replace a few variables with new equivalent ones
      net: sparx5: use the FDMA library for allocation of rx buffers
      net: sparx5: use FDMA library for adding DCB's in the rx path
      net: sparx5: use library helper for freeing rx buffers
      net: sparx5: use a few FDMA helpers in the rx path
      net: sparx5: use the FDMA library for allocation of tx buffers
      net: sparx5: use FDMA library for adding DCB's in the tx path
      net: sparx5: use library helper for freeing tx buffers
      net: sparx5: use contiguous memory for tx buffers
      net: sparx5: ditch sparx5_fdma_rx/tx_reload() functions
      net: lan966x: select FDMA library
      net: lan966x: use FDMA library symbols
      net: lan966x: replace a few variables with new equivalent ones
      net: lan966x: use the FDMA library for allocation of rx buffers
      net: lan966x: use FDMA library for adding DCB's in the rx path
      net: lan966x: use library helper for freeing rx buffers
      net: lan966x: use the FDMA library for allocation of tx buffers
      net: lan966x: use FDMA library for adding DCB's in the tx path
      net: lan966x: use library helper for freeing tx buffers
      net: lan966x: ditch tx->last_in_use variable
      net: lan966x: use a few FDMA helpers throughout
      net: lan966x: refactor buffer reload function

Daniel Xu (1):
      bpf, cpumap: Move xdp:xdp_cpumap_kthread tracepoint before rcv

Danielle Ratson (1):
      net: ethtool: Enhance error messages sent to user space

Dave Taht (1):
      sch_cake: constify inverse square root cache

David Arinzon (2):
      net: ena: Add ENA Express metrics support
      net: ena: Extend customer metrics reporting support

David Lin (2):
      wifi: mwifiex: add host mlme for client mode
      wifi: mwifiex: add host mlme for AP mode

David S. Miller (26):
      Merge branch 'l2tp-session-cleanup' into main
      Merge branch 'smc-cleanups' into main
      Merge branch 'vsock-virtio' into main
      Merge branch 'axienet-coding-style' into main
      Merge branch 'netns-init-cleanups' into main
      Merge branch 'dsa-en7581' into main
      Merge branch 'tcp-active-reset'
      Merge branch 'selftest-rds'
      Merge branch 'l2tp-misc-improvements'
      Merge branch 'bnxt_en-fix-queue-reset-when-queue-active'
      Merge branch 'mvpp2-child-port-removal'
      Merge branch 'phylib-fixed-speed-1G'
      Merge branch 'ethtool-rss-driver-tweaks'
      Merge branch 'phy-listing-and-topology-tracking'
      Merge branch 'net-redundant-judgments'
      Merge branch 'am-qt2025-phy-rust'
      Merge branch 'unmask-dscp-bits'
      Merge branch 'octeontx2-af-cpt-update'
      Merge branch 'sparx5-fdma-part-one'
      Merge branch 'fbnic-ethtool'
      Merge branch 'microchip=ksz8-cleanup'
      Merge branch 'rx-sw-tstamp-for-all'
      Merge branch 'fs_enet-cleanup'
      Merge branch 'unmask-dscp-part-four'
      Merge branch 'lan743x-phylink'
      Merge branch 'am65-cpsw-rx-mq'

David Wei (3):
      bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
      bnxt_en: stop packet flow during bnxt_queue_stop/start
      bnxt_en: only set dev->queue_mgmt_ops if supported by FW

David Wu (1):
      ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576

Detlev Casanova (2):
      ethernet: stmmac: dwmac-rk: Fix typo for RK3588 code
      dt-bindings: net: Add support for rk3576 dwmac

Dian-Syuan Yang (1):
      wifi: rtw89: correct VHT TX rate on 20MHz connection

Dinesh Karthikeyan (1):
      wifi: ath12k: Support Transmit DE stats

Diogo Jahchan Koike (2):
      net: fix unreleased lock in cable test
      ethtool: pse-pd: move pse validation into set

Divya Koppera (3):
      net: phy: Add phy library support to check supported list when autoneg is enabled
      net: phy: microchip_t1: Adds support for lan887x phy
      net: phy: microchip_t1: Cable Diagnostics for lan887x

Dmitry Antipov (7):
      wifi: rtw88: always wait for both firmware loading attempts
      net: core: annotate socks of struct sock_reuseport with __counted_by
      wifi: mac80211: refactor block ack management code
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      net: sched: consistently use rcu_replace_pointer() in taprio_change()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Kandybka (3):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()
      wifi: brcmsmac: clean up unnecessary current_ampdu_cnt and related checks
      wifi: rtw88: remove CPT execution branch never used

Dmitry Safonov (7):
      selftests/net: Clean-up double assignment
      selftests/net: Provide test_snprintf() helper
      selftests/net: Be consistent in kconfig checks
      selftests/net: Open /proc/thread-self in open_netns()
      selftests/net: Don't forget to close nsfd after switch_save_ns()
      selftests/net: Synchronize client/server before counters checks
      selftests/net: Add trace events matching to tcp_ao

Donald Hunter (2):
      netfilter: nfnetlink: convert kfree_skb to consume_skb
      netlink: specs: nftables: allow decode of tailscale ruleset

Dr. David Alan Gilbert (1):
      net/tcp: Expand goo.gl link

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split

Duy Nguyen (1):
      dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support

Edward Cree (2):
      net: ethtool: check rxfh_max_num_contexts != 1 at register time
      sfc: siena: rip out rss-context dead code

Edwin Peer (1):
      bnxt_en: resize bnxt_irq name field to fit format string

Emmanuel Grumbach (17):
      wifi: iwlwifi: mvm: prepare the introduction of V9 of REDUCED_TX_POWER
      wifi: iwlwifi: mvm: add support for new REDUCE_TXPOWER_CMD versions
      wifi: iwlwifi: mvm: set ul_mu_data_disable when needed
      wifi: iwlwifi: mvm: s/iwl_bt_coex_profile_notif/iwl_bt_coex_prof_old_notif
      wifi: iwlwifi: mvm: start to support the new BT profile notification
      wifi: iwlwiif: mvm: handle the new BT notif
      wifi: iwlwifi: mvm: add firmware debug points for EMLSR entry / exit
      wifi: mac80211: fix the comeback long retry times
      wifi: iwlwifi: mvm: rename iwl_missed_beacons_notif
      wifi: iwlwifi: mvm: add the new API for the missed beacons notification
      wifi: iwlwifi: mvm: handle the new missed beacons notification
      wifi: iwlwifi: mvm: exit EMLSR if both links are missing beacons
      wifi: iwlwifi: mvm: add API for EML OMN frame failure
      wifi: iwlwifi: mvm: handle the new EML OMN failure notification
      wifi: iwlwifi: mvm: allow ESR when we the ROC expires
      wifi: iwlwifi: mvm: tell the firmware about CSA with mode=1
      wifi: iwlwifi: mvm: replace CONFIG_PM by CONFIG_PM_SLEEP

Enguerrand de Ribaucourt (2):
      net: dsa: microchip: ksz9477: split half-duplex monitoring function
      net: dsa: microchip: ksz9477: unwrap URL in comment

Eric Dumazet (15):
      inet: constify inet_sk_bound_dev_eq() net parameter
      inet: constify 'struct net' parameter of various lookup helpers
      udp: constify 'struct net' parameter of socket lookups
      inet6: constify 'struct net' parameter of various lookup helpers
      ipv6: udp: constify 'struct net' parameter of socket lookups
      ipv6: avoid indirect calls for SOL_IP socket options
      tcp: remove volatile qualifier on tw_substate
      tcp: annotate data-races around tcptw->tw_rcv_nxt
      icmp: change the order of rate limits
      icmp: move icmp_global.credit and icmp_global.stamp to per netns storage
      icmp: icmp_msgs_per_sec and icmp_msgs_burst sysctls become per netns
      netpoll: remove netpoll_srcu
      sock_map: Add a cond_resched() in sock_hash_free()
      net: hsr: Remove interlink_sequence_nr.
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

Eric Huang (2):
      wifi: rtw89: adjust DIG threshold to reduce false alarm
      wifi: rtw89: use frequency domain RSSI

Erni Sri Satya Vennela (1):
      net: netvsc: Update default VMBus channels

Erwan Velu (1):
      net/mlx5: Use cpumask_local_spread() instead of custom code

FUJITA Tomonori (6):
      rust: sizes: add commonly used constants
      rust: net::phy support probe callback
      rust: net::phy implement AsRef<kernel::device::Device> trait
      rust: net::phy unified read/write API for C22 and C45 registers
      rust: net::phy unified genphy_read_status function for C22 and C45 registers
      net: phy: add Applied Micro QT2025 PHY driver

Fabio Estevam (1):
      net: fec: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Felix Fietkau (21):
      wifi: mt76: mt7603: fix mixed declarations and code
      wifi: mt76: mt7603: fix reading target power from eeprom
      wifi: mt76: mt7603: initialize chainmask
      wifi: mt76: fix mt76_get_rate
      wifi: mt76: partially move channel change code to core
      wifi: mt76: add separate tx scheduling queue for off-channel tx
      wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
      wifi: mt76: mt7915: allocate vif wcid in the same range as stations
      wifi: mt76: connac: add support for passing connection state directly
      wifi: mt76: change .sta_assoc callback to .sta_event
      wifi: mt76: mt7915: use mac80211 .sta_state op
      wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
      wifi: mt76: mt7915: retry mcu messages
      wifi: mt76: mt7915: reset the device after MCU timeout
      wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
      wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
      wifi: mt76: mt7915: improve hardware restart reliability
      wifi: mt76: shrink mt76_queue_buf
      wifi: mt76: mt7915: always query station rx rate from firmware
      wifi: mt76: mt7996: fix uninitialized TLV data
      wifi: mt76: mt7915: avoid long MCU command timeouts during SER

Florian Fainelli (1):
      net: dsa: b53: Use dev_err_probe()

Florian Westphal (15):
      netfilter: nf_tables: store new sets in dedicated list
      netfilter: nf_tables: pass context structure to nft_parse_register_load
      netfilter: nf_tables: allow loads only when register is initialized
      netfilter: nf_tables: don't initialize registers in nft_do_chain()
      selftests: add xfrm policy insertion speed test script
      xfrm: policy: don't iterate inexact policies twice at insert time
      xfrm: switch migrate to xfrm_policy_lookup_bytype
      xfrm: policy: remove remaining use of inexact list
      xfrm: policy: use recently added helper in more places
      xfrm: minor update to sdb and xfrm_policy comments
      selftests: netfilter: nft_queue.sh: reduce test file size for debug build
      netfilter: nf_tables: drop unused 3rd argument from validate callback ops
      selftests: netfilter: nft_queue.sh: fix spurious timeout on debug kernel
      netlink: specs: nftables: allow decode of default firewalld ruleset
      xfrm: policy: fix null dereference

Frank Li (6):
      dt-bindings: can: fsl,flexcan: add common 'can-transceiver' for fsl,flexcan
      dt-bindings: net: fsl,qoriq-mc-dpmac: using unevaluatedProperties
      dt-bindings: net: mdio: change nodename match pattern
      dt-binding: ptp: fsl,ptp: add pci1957,ee02 compatible string for fsl,enetc-ptp
      dt-bindings: can: convert microchip,mcp251x.txt to yaml
      dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format

Frank Sae (2):
      net: phy: Optimize phy speed mask to be compatible to yt8821
      net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy

Frédéric Danis (1):
      Bluetooth: hci_ldisc: Use speed set by btattach as oper_speed

Furong Xu (7):
      net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
      net: stmmac: drop stmmac_fpe_handshake
      net: stmmac: refactor FPE verification process
      net: stmmac: configure FPE via ethtool-mm
      net: stmmac: support fp parameter of tc-mqprio
      net: stmmac: support fp parameter of tc-taprio
      net: stmmac: silence FPE kernel logs

Gal Pressman (52):
      net/mlx5e: Be consistent with bitmap handling of link modes
      net/mlx5e: Use extack in set ringparams callback
      net/mlx5e: Use extack in get coalesce callback
      net/mlx5e: Use extack in set coalesce callback
      net/mlx5e: Use extack in get module eeprom by page callback
      net: Silence false field-spanning write warning in metadata_dst memcpy
      ethtool: RX software timestamp for all
      can: dev: Remove setting of RX software timestamp
      can: peak_canfd: Remove setting of RX software timestamp
      can: peak_usb: Remove setting of RX software timestamp
      tsnep: Remove setting of RX software timestamp
      ionic: Remove setting of RX software timestamp
      ravb: Remove setting of RX software timestamp
      net: renesas: rswitch: Remove setting of RX software timestamp
      net: ethernet: rtsn: Remove setting of RX software timestamp
      net: hns3: Remove setting of RX software timestamp
      net: fec: Remove setting of RX software timestamp
      net: enetc: Remove setting of RX software timestamp
      gianfar: Remove setting of RX software timestamp
      octeontx2-pf: Remove setting of RX software timestamp
      net: mvpp2: Remove setting of RX software timestamp
      lan743x: Remove setting of RX software timestamp
      net: lan966x: Remove setting of RX software timestamp
      net: sparx5: Remove setting of RX software timestamp
      mlxsw: spectrum: Remove setting of RX software timestamp
      net: ethernet: ti: am65-cpsw-ethtool: Remove setting of RX software timestamp
      net: ethernet: ti: cpsw_ethtool: Remove setting of RX software timestamp
      net: ti: icssg-prueth: Remove setting of RX software timestamp
      net: netcp: Remove setting of RX software timestamp
      i40e: Remove setting of RX software timestamp
      ice: Remove setting of RX software timestamp
      igb: Remove setting of RX software timestamp
      igc: Remove setting of RX software timestamp
      ixgbe: Remove setting of RX software timestamp
      cxgb4: Remove setting of RX software timestamp
      bnx2x: Remove setting of RX software timestamp
      bnxt_en: Remove setting of RX software timestamp
      tg3: Remove setting of RX software timestamp
      bonding: Remove setting of RX software timestamp
      amd-xgbe: Remove setting of RX software timestamp
      net: macb: Remove setting of RX software timestamp
      liquidio: Remove setting of RX software timestamp
      net: thunderx: Remove setting of RX software timestamp
      enic: Remove setting of RX software timestamp
      net/funeth: Remove setting of RX software timestamp
      net: mscc: ocelot: Remove setting of RX software timestamp
      qede: Remove setting of RX software timestamp
      sfc: Remove setting of RX software timestamp
      sfc/siena: Remove setting of RX software timestamp
      net: stmmac: Remove setting of RX software timestamp
      ixp4xx_eth: Remove setting of RX software timestamp
      ptp: ptp_ines: Remove setting of RX software timestamp

Gaosheng Cui (1):
      MIPS: Remove the obsoleted code for include/linux/mv643xx.h

Geliang Tang (1):
      selftests: mptcp: join: simplify checksum_tests

Guillaume Nault (2):
      bareudp: Pull inner IP header in bareudp_udp_encap_recv().
      bareudp: Pull inner IP header on xmit.

Gustavo A. R. Silva (14):
      net/fungible: Avoid -Wflex-array-member-not-at-end warning
      wifi: ipw2x00: libipw: Avoid -Wflex-array-member-not-at-end warnings
      sched: act_ct: avoid -Wflex-array-member-not-at-end warning
      nfp: Use static_assert() to check struct sizes
      net/smc: Use static_assert() to check struct sizes
      wifi: mwl8k: Use static_assert() to check struct sizes
      UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel
      cxgb4: Avoid -Wflex-array-member-not-at-end warning
      nfc: pn533: Avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlegacy: Avoid multiple -Wflex-array-member-not-at-end warnings
      wifi: ath11k: Avoid -Wflex-array-member-not-at-end warnings
      wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings
      wifi: mt76: Avoid multiple -Wflex-array-member-not-at-end warnings
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Haibo Chen (2):
      dt-bindings: can: fsl,flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

Hangbin Liu (3):
      bonding: add common function to check ipsec device
      bonding: Add ESN support to IPSec HW offload
      bonding: support xfrm state update

Hans de Goede (2):
      net: rfkill: gpio: Do not load on Lenovo Yoga Tab 3 Pro YT3-X90
      Bluetooth: Use led_set_brightness() in LED trigger activate() callback

Heiner Kallweit (2):
      wifi: ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader
      r8169: disable ALDPS per default for RTL8125

Hilda Wu (2):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
      Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B

Hongbo Li (15):
      net/ipv4: fix macro definition sk_for_each_bound_bhash
      net: ipa: make use of dev_err_cast_probe()
      net: dsa: realtek: make use of dev_err_cast_probe()
      net: hns: Use IS_ERR_OR_NULL() helper function
      net: prefer strscpy over strcpy
      net/ipv6: replace deprecated strcpy with strscpy
      net/netrom: prefer strscpy over strcpy
      net/tipc: replace deprecated strcpy with strscpy
      net/ipv4: net: prefer strscpy over strcpy
      net: dsa: felix: Annotate struct action_gate_entry with __counted_by
      net/ipv4: make use of the helper macro LIST_HEAD()
      net/tipc: make use of the helper macro LIST_HEAD()
      net/netfilter: make use of the helper macro LIST_HEAD()
      net/ipv6: make use of the helper macro LIST_HEAD()
      net/core: make use of the helper macro LIST_HEAD()

Howard Hsu (5):
      wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
      wifi: mt76: mt7996: set correct beamformee SS capability
      wifi: mt76: mt7996: fix EHT beamforming capability check
      wifi: mt76: mt7996: set correct value in beamforming mcu command for mt7992
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Ido Schimmel (65):
      mlxsw: core_thermal: Call thermal_zone_device_unregister() unconditionally
      mlxsw: core_thermal: Remove unnecessary check
      mlxsw: core_thermal: Remove another unnecessary check
      mlxsw: core_thermal: Fold two loops into one
      mlxsw: core_thermal: Remove unused arguments
      mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
      mlxsw: core_thermal: Simplify rollback
      mlxsw: core_thermal: Remove unnecessary checks
      mlxsw: core_thermal: Remove unnecessary assignments
      mlxsw: core_thermal: Fix -Wformat-truncation warning
      selftests: fib_rule_tests: Remove unused functions
      selftests: fib_rule_tests: Clarify test results
      selftests: fib_rule_tests: Add negative match tests
      selftests: fib_rule_tests: Add negative connect tests
      selftests: fib_rule_tests: Test TOS matching with input routes
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family
      netfilter: nft_fib: Mask upper DSCP bits before FIB lookup
      ipv4: Centralize TOS matching
      bpf: Unmask upper DSCP bits in bpf_fib_lookup() helper
      ipv4: Unmask upper DSCP bits in NETLINK_FIB_LOOKUP family
      ipv4: Unmask upper DSCP bits when constructing the Record Route option
      netfilter: rpfilter: Unmask upper DSCP bits
      netfilter: nft_fib: Unmask upper DSCP bits
      ipv4: ipmr: Unmask upper DSCP bits in ipmr_rt_fib_lookup()
      ipv4: Unmask upper DSCP bits in fib_compute_spec_dst()
      ipv4: Unmask upper DSCP bits in input route lookup
      ipv4: Unmask upper DSCP bits in RTM_GETROUTE input route lookup
      ipv4: icmp: Pass full DS field to ip_route_input()
      ipv4: udp: Unmask upper DSCP bits during early demux
      ipv4: Unmask upper DSCP bits when using hints
      ipv4: Unmask upper DSCP bits in RTM_GETROUTE output route lookup
      ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
      ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
      ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
      ipv4: Unmask upper DSCP bits in get_rttos()
      ipv4: Unmask upper DSCP bits when building flow key
      xfrm: Unmask upper DSCP bits in xfrm_get_tos()
      ipv4: Unmask upper DSCP bits in ip_send_unicast_reply()
      ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
      ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
      vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
      bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()
      ipv4: Fix user space build failure due to header change
      ipv4: Unmask upper DSCP bits in __ip_queue_xmit()
      ipv4: ipmr: Unmask upper DSCP bits in ipmr_queue_xmit()
      ip6_tunnel: Unmask upper DSCP bits in ip4ip6_err()
      ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_bind_dev()
      netfilter: br_netfilter: Unmask upper DSCP bits in br_nf_pre_routing_finish()
      ipv4: ip_gre: Unmask upper DSCP bits in ipgre_open()
      bpf: lwtunnel: Unmask upper DSCP bits in bpf_lwt_xmit_reroute()
      ipv4: icmp: Unmask upper DSCP bits in icmp_reply()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()
      ipv4: netfilter: Unmask upper DSCP bits in ip_route_me_harder()
      netfilter: nft_flow_offload: Unmask upper DSCP bits in nft_flow_route()
      netfilter: nf_dup4: Unmask upper DSCP bits in nf_dup_ipv4_route()
      ipv4: udp_tunnel: Unmask upper DSCP bits in udp_tunnel_dst_lookup()
      sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
      net: fib_rules: Add DSCP selector attribute
      ipv4: fib_rules: Add DSCP selector support
      ipv6: fib_rules: Add DSCP selector support
      net: fib_rules: Enable DSCP selector usage
      selftests: fib_rule_tests: Add DSCP selector match tests
      selftests: fib_rule_tests: Add DSCP selector connect tests

Ilan Peer (3):
      wifi: iwlwifi: mvm: Fix a race in scan abort flow
      wifi: iwlwifi: mvm: Stop processing MCC update if there was no change
      wifi: mac80211: Check for missing VHT elements only for 5 GHz

Issam Hamdi (1):
      wifi: cfg80211: Set correct chandef when starting CAC

Jacky Chou (1):
      net: ftgmac100: Get link speed and duplex for NC-SI

Jacob Keller (4):
      ice: implement and use rd32_poll_timeout for ice_sq_done timeout
      ice: improve debug print for control queue messages
      ice: reword comments referring to control queues
      ice: remove unnecessary control queue cmd_buf arrays

Jake Hamby (2):
      can: m_can: m_can_chip_config(): mask timestamp wraparound IRQ
      can: m_can: enable NAPI before enabling interrupts

Jakub Kicinski (124):
      Merge branch 'mlxsw-core_thermal-small-cleanups'
      Merge branch 'ethernet-convert-from-tasklet-to-bh-workqueue'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      net: remove IFF_* re-definition
      selftests: net: ksft: print more of the stack for checks
      Merge branch 'add-second-qdma-support-for-en7581-eth-controller'
      Merge branch 'ibmveth-rr-performance'
      net: skbuff: sprinkle more __GFP_NOWARN on ingress allocs
      Merge branch 'net-constify-struct-net-parameter-of-socket-lookups'
      Merge branch 'mlx5-ptm-cross-timestamping-support'
      Merge tag 'linux-can-next-for-6.12-20240806' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'ibmvnic-ibmvnic-rr-patchset'
      Merge branch 'mlx5-misc-patches-2024-08-08'
      selftests: drv-net: rss_ctx: add identifier to traffic comments
      eth: mvpp2: implement new RSS context API
      eth: mlx5: allow disabling queues when RSS contexts exist
      ethtool: make ethtool_ops::cap_rss_ctx_supported optional
      eth: remove .cap_rss_ctx_supported from updated drivers
      ethtool: rss: don't report key if device doesn't support it
      ethtool: rss: move the device op invocation out of rss_prepare_data()
      ethtool: rss: report info about additional contexts from XArray
      ethtool: rss: support dumping RSS contexts
      ethtool: rss: support skipping contexts during dump
      netlink: specs: decode indirection table as u32 array
      selftests: drv-net: rss_ctx: test dumping RSS contexts
      eth: fbnic: add basic rtnl stats
      Merge branch 'eth-fbnic-add-basic-stats'
      Merge branch 'net-nexthop-increase-weight-to-u16'
      Merge branch 'gve-add-rss-config-support'
      Merge branch 'bnxt_en-address-string-truncation'
      Merge branch 'uapi-net-sched-cxgb4-fix-wflex-array-member-not-at-end-warning'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'ip-random-cleanup-for-devinet-c'
      Merge branch 'virtio-net-synchronize-op-admin-state'
      Merge branch 'net-dsa-microchip-ksz8795-add-wake-on-lan-support'
      Merge branch 'ipv6-add-ipv6_addr_-cpu_to_be32-be32_to_cpu-helpers'
      Merge branch 'selftests-fib_rule_tests-cleanups-and-new-tests'
      Merge branch 'use-more-devm-for-ag71xx'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      tcp_metrics: use netlink policy for IPv6 addr len validation
      selftests: net/forwarding: spawn sh inside vrf to speed up ping loop
      net: repack struct netdev_queue
      Merge branch 'net-xilinx-axienet-add-statistics-support'
      selftests: net: add helper for checking if nettest is available
      Merge branch 'enhance-network-interface-feature-testing'
      Merge branch 'unmask-upper-dscp-bits-part-1'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'nf-next-24-08-23' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'adds-support-for-lan887x-phy'
      Merge branch 'netconsole-populate-dynamic-entry-even-if-netpoll-fails'
      Merge branch 'add-alcd-support-to-cable-testing-interface'
      Merge branch 'add-support-for-icssg-pa_stats'
      Merge branch 'net-header-and-core-spelling-corrections'
      Merge branch 'some-modifications-to-optimize-code-readability'
      Merge branch 'net-xilinx-axienet-multicast-fixes-and-improvements'
      Merge branch 'net-pse-pd-tps23881-reset-gpio-support'
      Merge branch 'add-embedded-sync-feature-for-a-dpll-s-pin'
      Merge branch 'add-gmac-support-for-rk3576'
      Merge branch 'net-selftests-tcp-ao-selftests-updates'
      Merge branch 'net-fix-module-autoloading'
      Merge branch 'net-dsa-microchip-add-ksz8895-ksz8864-switch-support'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-take-better-care-of-tw_substate-and-tw_rcv_nxt'
      Merge branch 'net-hisilicon-minor-fixes'
      Merge branch 'net-vertexcom-mse102x-minor-clean-ups'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'replace-deprecated-strcpy-with-strscpy'
      tools: ynl: error check scanf() in a sample
      Merge branch 'adding-so_peek_off-for-tcpv6'
      Merge branch 'bnxt_en-update-for-net-next'
      Merge branch 'icmp-avoid-possible-side-channels-attacks'
      Merge tag 'linux-can-next-for-6.12-20240830' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'ieee802154-for-net-2024-09-01' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'rx-software-timestamp-for-all'
      Merge branch 'mptcp-mib-counters-for-mpj-tx-misc-improvements'
      Merge branch 'unmask-upper-dscp-bits-part-3'
      Merge tag 'wireless-next-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-realtek-automotive-pcie-driver'
      Merge branch 'make-use-of-the-helper-macro-list_head'
      Merge branch 'use-functionality-of-irq_get_trigger_type'
      Merge branch 'octeontx2-address-some-warnings'
      Merge tag 'nf-next-24-09-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'selftests-mptcp-add-time-per-subtests-in-tap-output'
      net: remove dev_pick_tx_cpu_id()
      Merge tag 'linux-can-next-for-6.12-20240909' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'af_unix-correct-manage_oob-when-oob-follows-a-consumed-oob'
      Merge branch 'various-cleanups'
      Merge branch 'selftests-net-add-packetdrill'
      Merge branch 'rx-software-timestamp-for-all-round-3'
      Merge branch 'ionic-convert-rx-queue-buffers-to-use-page_pool'
      Merge branch 'net-stmmac-fpe-via-ethtool-tc'
      Merge branch 'net-timestamp-introduce-a-flag-to-filter-out-rx-software-and-hardware-report'
      Merge branch 'net-xilinx-axienet-partial-checksum-offload-improvements'
      Merge branch 'bnxt_en-msix-improvements'
      Merge tag 'ipsec-next-2024-09-10' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge tag 'mlx5-updates-2024-09-02' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'wireless-next-2024-09-11' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-hsr-use-the-seqnr-lock-for-frames-received-via-interlink-port'
      Merge branch 'mptcp-fallback-to-tcp-after-3-mpc-drop-cache'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'device-memory-tcp'
      Merge branch 'add-support-for-open-alliance-10base-t1x-macphy-serial-interface'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'ena-driver-metrics-changes'
      Merge branch 'selftests-net-packetdrill-netns-and-two-imports'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      uapi: libc-compat: remove ipx leftovers
      net: caif: remove unused name
      Merge branch 'bareudp-pull-inner-ip-header-on-xmit-recv'
      Merge branch 'net-use-irqf_no_autoen-flag-in-request_irq'
      Merge branch 'mlx5-updates-2024-09-11'
      Merge tag 'for-net-next-2024-09-12' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'net-fib_rules-add-dscp-selector-support'
      Merge branch 'enic-report-per-queue-stats'
      Merge tag 'linux-can-fixes-for-6.11-20240912' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'linux-can-next-for-6.12-20240911' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'net-ibm-emac-modernize-a-bit'
      Merge branch 'introduce-hsr-offload-support-for-icssg'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

James Chapman (27):
      l2tp: lookup tunnel from socket without using sk_user_data
      ipv4: export ip_flush_pending_frames
      l2tp: have l2tp_ip_destroy_sock use ip_flush_pending_frames
      l2tp: don't use tunnel socket sk_user_data in ppp procfs output
      l2tp: don't set sk_user_data in tunnel socket
      l2tp: remove unused tunnel magic field
      l2tp: simplify tunnel and socket cleanup
      l2tp: delete sessions using work queue
      l2tp: free sessions using rcu
      l2tp: refactor ppp socket/session relationship
      l2tp: prevent possible tunnel refcount underflow
      l2tp: use rcu list add/del when updating lists
      l2tp: add idr consistency check in session_register
      l2tp: cleanup eth/ppp pseudowire setup code
      l2tp: use pre_exit pernet hook to avoid rcu_barrier
      documentation/networking: update l2tp docs
      l2tp: remove inline from functions in c sources
      l2tp: move l2tp_ip and l2tp_ip6 data to pernet
      l2tp: handle hash key collisions in l2tp_v3_session_get
      l2tp: add tunnel/session get_next helpers
      l2tp: use get_next APIs for management requests and procfs/debugfs
      l2tp: improve tunnel/session refcount helpers
      l2tp: l2tp_eth: use per-cpu counters from dev->tstats
      l2tp: flush workqueue before draining it
      l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
      l2tp: avoid using drain_workqueue in l2tp_pre_exit_net
      l2tp: remove unneeded null check in l2tp_v2_session_get_next

Jason Wang (4):
      virtio: rename virtio_config_enabled to virtio_config_core_enabled
      virtio: allow driver to disable the configure change notification
      virtio-net: synchronize operstate with admin state on up/down
      virtio-net: synchronize probe with ndo_set_features

Jason Xing (13):
      tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
      tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
      tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
      tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
      tcp: rstreason: introduce SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
      tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for active reset
      tcp: rstreason: let it work finally in tcp_send_active_reset()
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
      selftests: add selftest for UDP SO_PEEK_OFF support
      selftests: return failure when timestamps can't be reported
      net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
      net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
      net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER

Javier Carrasco (2):
      net: mvpp2: use port_count to remove ports
      net: mvpp2: use device_for_each_child_node() to access device child nodes

Jeongjun Park (1):
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Jeroen de Borst (1):
      gve: Add RSS adminq commands and ethtool support

Jianbo Liu (3):
      net/mlx5e: Enable remove flow for hard packet limit
      net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal port
      net/mlx5e: TC, Offload rewrite and mirror to both internal and external dests

Jiawei Ye (1):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param

Jimmy Assarsson (15):
      can: kvaser_usb: Add helper functions to convert device timestamp into ktime
      can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
      can: kvaser_usb: hydra: Add struct for Tx ACK commands
      can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
      can: kvaser_usb: leaf: Add struct for Tx ACK commands
      can: kvaser_usb: leaf: Assign correct timestamp_freq for kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
      can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
      can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local variable
      can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
      can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
      can: kvaser_usb: leaf: Store MSB of timestamp
      can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
      can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
      can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
      can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops

Jing-Ping Jan (1):
      Documentation: networking: correct spelling

Jinjian Song (1):
      net: wwan: t7xx: PCIe reset rescan

Jinjie Ruan (14):
      net: dsa: ocelot: Simplify with scoped for each OF child loop
      net: dsa: sja1105: Simplify with scoped for each OF child loop
      net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
      net: dsa: realtek: Use for_each_child_of_node_scoped()
      net: phy: Use for_each_available_child_of_node_scoped()
      net: mdio: mux-mmioreg: Simplified with scoped function
      net: mdio: mux-mmioreg: Simplified with dev_err_probe()
      net: mv643xx_eth: Simplify with scoped for each OF child loop
      net: dsa: microchip: Use scoped function to simplfy code
      net: bcmasp: Simplify with scoped for each OF child loop
      wifi: brcmsmac: Use kvmemdup to simplify the code
      net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
      net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()

Joe Damato (4):
      net: wangxun: use net_prefetch to simplify logic
      Documentation: Add missing fields to net_cachelines
      netdev-genl: Set extack and fix error on napi-get
      net: napi: Prevent overflow of napi_defer_hard_irqs

Johannes Berg (7):
      wifi: iwlwifi: mvm: use correct key iteration
      wifi: iwlwifi: pcie: print function scratch before writing
      wifi: iwlwifi: config: label 'gl' devices as discrete
      wifi: iwlwifi: mvm: drop wrong STA selection in TX
      wifi: mac80211: fix RCU list iterations
      wifi: iwlwifi: mvm: refactor scan channel description a bit
      wifi: cfg80211: fix kernel-doc for per-link data

John Wang (1):
      net: mctp: Consistent peer address handling in ioctl tag allocation

Jon Maloy (2):
      tcp: add SO_PEEK_OFF socket option tor TCPv6
      selftests: add selftest for tcp SO_PEEK_OFF support

Jonathan Cooper (1):
      sfc: Add X4 PF support

Joshua Hay (2):
      idpf: refactor Tx completion routines
      idpf: enable WB_ON_ITR

Junfeng Guo (11):
      ice: add parser create and destroy skeleton
      ice: parse and init various DDP parser sections
      ice: add debugging functions for the parser sections
      ice: add parser internal helper functions
      ice: add parser execution main loop
      ice: support turning on/off the parser's double vlan mode
      ice: add UDP tunnels support to the parser
      ice: add API for parser profile initialization
      virtchnl: support raw packet in protocol header
      ice: add method to disable FDIR SWAP option
      ice: enable FDIR filters from raw binary patterns for VFs

Justin Iurman (4):
      net: ipv6: ioam6: code alignment
      net: ipv6: ioam6: new feature tunsrc
      ioam6: improve checks on user data
      net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Justin Lai (13):
      rtase: Add support for a pci table in this module
      rtase: Implement the .ndo_open function
      rtase: Implement the rtase_down function
      rtase: Implement the interrupt routine and rtase_poll
      rtase: Implement hardware configuration function
      rtase: Implement .ndo_start_xmit function
      rtase: Implement a function to receive packets
      rtase: Implement net_device_ops
      rtase: Implement pci_driver suspend and resume function
      rtase: Implement ethtool function
      rtase: Add a Makefile in the rtase folder
      realtek: Update the Makefile and Kconfig in the realtek folder
      MAINTAINERS: Add the rtase ethernet driver entry

Justin Stitt (1):
      Bluetooth: replace deprecated strncpy with strscpy_pad

Kalle Valo (5):
      Merge tag 'rtw-next-2024-08-09' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20240812' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-09-05' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20240909' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Kang Yang (1):
      wifi: ath11k: use work queue to process beacon tx event

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix array out-of-bound access in SoC stats
      wifi: ath11k: fix array out-of-bound access in SoC stats

Kiran (1):
      Bluetooth: btintel_pcie: Add support for ISO data

Kiran K (2):
      Bluetooth: Add a helper function to extract iso header
      Bluetooth: btintel_pcie: Allocate memory for driver private data

Kory Maincent (1):
      Documentation: networking: Fix missing PSE documentation and grammar issues

Krzysztof Kozlowski (8):
      dt-bindings: net: mediatek,net: narrow interrupts per variants
      dt-bindings: net: mediatek,net: add top-level constraints
      dt-bindings: net: renesas,etheravb: add top-level constraints
      dt-bindings: net: socionext,uniphier-ave4: add top-level constraints
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"

Krzysztof Olędzki (1):
      net/mlx4: Add support for EEPROM high pages query for QSFP/QSFP+/QSFP28

Kuan-Chung Chen (6):
      wifi: rtw89: add EVM statistics for 1SS rate
      wifi: rtw89: add support for hardware rfkill
      wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
      wifi: rtw89: add support for HW encryption in unicast management frames
      wifi: rtw89: 8852c: support firmware with fw_element
      wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade

Kuan-Wei Chiu (1):
      Bluetooth: hci_conn: Remove redundant memset after kzalloc

Kuniyuki Iwashima (18):
      l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
      net: Don't register pernet_operations if only one of id or size is specified.
      net: Initialise net->passive once in preinit_net().
      net: Call preinit_net() without pernet_ops_rwsem.
      net: Slim down setup_net().
      net: Initialise net.core sysctl defaults in preinit_net().
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
      ipv4: Set ifa->ifa_dev in inet_alloc_ifa().
      ipv4: Remove redundant !ifa->ifa_dev check.
      ipv4: Initialise ifa->hash in inet_alloc_ifa().
      ip: Move INFINITY_LIFE_TIME to addrconf.h.
      af_unix: Don't call skb_get() for OOB skb.
      selftest: bpf: Remove mssind boundary check in test_tcp_custom_syncookie.c.
      af_unix: Remove single nest in manage_oob().
      af_unix: Rename unlinked_skb in manage_oob().
      af_unix: Move spin_lock() in manage_oob().
      af_unix: Don't return OOB skb in manage_oob().
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Kurt Kanzenbach (2):
      igc: Add MQPRIO offload support
      igc: Get rid of spurious interrupts

Kyle Swenson (3):
      net: pse-pd: tps23881: Fix the device ID check
      dt-bindings: pse: tps23881: add reset-gpios
      net: pse-pd: tps23881: Support reset-gpios

Lee Trager (1):
      eth: fbnic: Add devlink firmware version info

Li Zetao (18):
      net: vxlan: delete redundant judgment statements
      fib: rules: delete redundant judgment statements
      neighbour: delete redundant judgment statements
      rtnetlink: delete redundant judgment statements
      ipv4: delete redundant judgment statements
      ipmr: delete redundant judgment statements
      net: nexthop: delete redundant judgment statements
      ip6mr: delete redundant judgment statements
      net/ipv6: delete redundant judgment statements
      net: mpls: delete redundant judgment statements
      net: caif: use max() to simplify the code
      ipv6: mcast: use min() to simplify the code
      tipc: use min() to simplify the code
      ionic: Remove redundant null pointer checks in ionic_debugfs_add_qcq()
      pds_core: Remove redundant null pointer checks
      wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_sdio_probe()
      wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_bus_probe()
      Bluetooth: btrtl: Use kvmemdup to simplify the code

Liao Chen (3):
      net: dm9051: fix module autoloading
      net: ag71xx: fix module autoloading
      net: airoha: fix module autoloading

Linu Cherian (1):
      octeontx2-af: debugfs: Add Channel info to RPM map

Lorenzo Bianconi (12):
      net: airoha: Introduce airoha_qdma struct
      net: airoha: Move airoha_queues in airoha_qdma
      net: airoha: Move irq_mask in airoha_qdma structure
      net: airoha: Add airoha_qdma pointer in airoha_tx_irq_queue/airoha_queue structures
      net: airoha: Use qdma pointer as private structure in airoha_irq_handler routine
      net: airoha: Allow mapping IO region for multiple qdma controllers
      net: airoha: Start all qdma NAPIs in airoha_probe()
      net: airoha: Link the gdm port to the selected qdma controller
      dt-bindings: net: dsa: mediatek,mt7530: Add airoha,en7581-switch
      net: dsa: mt7530: Add EN7581 support
      net: airoha: honor reset return value in airoha_hw_init()
      net: airoha: configure hw mac address according to the port id

Luigi Leonardi (3):
      vsock: add support for SIOCOUTQ ioctl
      vsock/virtio: add SIOCOUTQ support for all virtio based transports
      test/vsock: add ioctl unsent bytes test

Luiz Augusto von Dentz (5):
      Bluetooth: btusb: Invert LE State flag to set invalid rather then valid
      Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
      Bluetooth: CMTP: Mark BT_CMTP as DEPRECATED
      Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
      Bluetooth: btusb: Fix not handling ZPL/short-transfer

MD Danish Anwar (7):
      dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
      net: ti: icssg-prueth: Add support for PA Stats
      net: ti: icssg-prueth: Make pa_stats optional
      net: ti: icss-iep: Move icss_iep structure
      net: ti: icssg-prueth: Stop hardcoding def_inc
      net: ti: icssg-prueth: Add support for HSR frame forward offload
      net: ti: icssg-prueth: Add multicast filtering support in HSR mode

Ma Ke (4):
      wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
      wifi: mt76: mt7915: check devm_kasprintf() returned value
      wifi: mt76: mt7921: Check devm_kasprintf() returned value
      wifi: mt76: mt7615: check devm_kasprintf() returned value

Maciej Fijalkowski (3):
      xsk: Bump xsk_queue::queue_empty_descs in xp_can_alloc()
      selftests/xsk: Read current MAX_SKB_FRAGS from sysctl knob
      xsk: fix batch alloc API on non-coherent systems

Maciej Żenczykowski (1):
      ipv6: eliminate ndisc_ops_is_useropt()

Mahesh Bandewar (1):
      ptp/ioctl: support MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED

Marc Kleine-Budde (27):
      Merge patch series "can: fsl,flexcan: add imx95 wakeup"
      Merge patch series "can: esd_402_pci: Do cleanup; Add one-shot mode"
      Merge patch series "can: kvaser_usb: Add hardware timestamp support to all devices"
      dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
      can: rockchip_canfd: add driver for Rockchip CAN-FD controller
      can: rockchip_canfd: add quirks for errata workarounds
      can: rockchip_canfd: add quirk for broken CAN-FD support
      can: rockchip_canfd: add support for rk3568v3
      can: rockchip_canfd: add notes about known issues
      can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
      can: rockchip_canfd: rkcanfd_register_done(): add warning for erratum 5
      can: rockchip_canfd: add TX PATH
      can: rockchip_canfd: implement workaround for erratum 6
      can: rockchip_canfd: implement workaround for erratum 12
      can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT register
      can: rockchip_canfd: add stats support for errata workarounds
      can: rockchip_canfd: prepare to use full TX-FIFO depth
      can: rockchip_canfd: enable full TX-FIFO depth of 2
      can: rockchip_canfd: add hardware timestamping support
      can: rockchip_canfd: add support for CAN_CTRLMODE_LOOPBACK
      can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING
      Merge patch series "can: rockchip_canfd: add support for CAN-FD IP core found on Rockchip RK3568"
      can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit division on 32 bit platforms
      can: rockchip_canfd: rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register
      Merge patch series "can: rockchip_canfd: rework delay calculation and decoding of error code register"
      can: m_can: m_can_close(): stop clocks after device has been shut down
      Merge patch series "can: m_can: fix struct net_device_ops::{open,stop} callbacks under high bus load"

Marek Vasut (2):
      wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume
      wifi: wilc1000: Re-enable RTC clock on resume

Mark Bloch (4):
      net/mlx5: fs, move hardware fte deletion function reset
      net/mlx5: fs, remove unused member
      net/mlx5: fs, separate action and destination into distinct struct
      net/mlx5: fs, add support for no append at software level

Martin Jocic (2):
      can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef
      can: kvaser_pciefd: Enable 64-bit DMA addressing

Martin KaFai Lau (3):
      Merge branch 'add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt()'
      Merge branch 'selftests/bpf: Various sockmap-related fixes'
      Merge branch 'bpf: Allow skb dynptr for tp_btf'

Martyn Welch (1):
      net: enetc: Replace ifdef with IS_ENABLED

Matthias Schiffer (1):
      net: ti: icssg_prueth: populate netdev of_node

Matthieu Baerts (NGI0) (18):
      mptcp: pm: rename helpers linked to 'flush'
      mptcp: pm: reduce entries iterations on connect
      mptcp: MIB counters for sent MP_JOIN
      selftests: mptcp: join: reduce join_nr params
      selftests: mptcp: join: one line for join check
      selftests: mptcp: join: validate MPJ SYN TX MIB counters
      selftests: mptcp: join: more explicit check name
      selftests: mptcp: join: specify host being checked
      selftests: mptcp: join: mute errors when ran in the background
      selftests: mptcp: pm_nl_ctl: remove re-definition
      selftests: mptcp: lib: add time per subtests in TAP output
      selftests: mptcp: connect: remote time in TAP output
      selftests: mptcp: reset the last TS before the first test
      selftests: mptcp: diag: remove trailing whitespace
      selftests: mptcp: connect: remove duplicated spaces in TAP output
      mptcp: export mptcp_subflow_early_fallback()
      mptcp: fallback to TCP after SYN+MPC drops
      mptcp: disable active MPTCP in case of blackhole

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8922A

Maxime Chevallier (25):
      net: phy: Introduce ethernet link topology representation
      net: sfp: pass the phy_device when disconnecting an sfp module's PHY
      net: phy: add helpers to handle sfp phy connect/disconnect
      net: sfp: Add helper to return the SFP bus name
      net: ethtool: Allow passing a phy index for some commands
      netlink: specs: add phy-index as a header parameter
      net: ethtool: Introduce a command to list PHYs on an interface
      netlink: specs: add ethnl PHY_GET command set
      net: ethtool: plca: Target the command to the requested PHY
      net: ethtool: pse-pd: Target the command to the requested PHY
      net: ethtool: cable-test: Target the command to the requested PHY
      net: ethtool: strset: Allow querying phy stats by index
      Documentation: networking: document phy_link_topology
      net: ethtool: cable-test: Release RTNL when the PHY isn't found
      net: ethernet: fs_enet: convert to SPDX
      net: ethernet: fs_enet: cosmetic cleanups
      net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
      net: ethernet: fs_enet: only protect the .restart() call in .adjust_link
      net: ethernet: fs_enet: drop unused phy_info and mii_if_info
      net: ethernet: fs_enet: use macros for speed and duplex values
      net: ethernet: fs_enet: simplify clock handling with devm accessors
      net: ethernet: fs_enet: phylink conversion
      net: ethtool: phy: Check the req_info.pdn field for GET commands
      net: ethtool: phy: Don't set the context dev pointer for unfiltered DUMP
      net: ethernet: fs_enet: Make the per clock optional

Menglong Dong (1):
      net: vxlan: remove duplicated initialization in vxlan_xmit

Miaoqing Pan (1):
      wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan

Michael Burch (1):
      Bluetooth: btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)

Michael Chan (11):
      bnxt_en: Update firmware interface to 1.10.3.68
      bnxt_en: Add support to call FW to update a VNIC
      bnxt_en: Check the FW's VNIC flush capability
      bnxt_en: Deprecate support for legacy INTX mode
      bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
      bnxt_en: Remove register mapping to support INTX
      bnxt_en: Replace deprecated PCI MSIX APIs
      bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
      bnxt_en: Support dynamic MSIX
      bnxt_en: Increase the number of MSIX vectors for RoCE device
      bnxt_en: Add MSIX check in bnxt_check_rings()

Michael Lo (1):
      wifi: mt76: mt7925: fix a potential association failure upon resuming

Michael-CY Lee (1):
      wifi: mt76: mt7996: set IEEE80211_KEY_FLAG_GENERATE_MMIE for other ciphers

Michal Kubiak (1):
      idpf: fix netdev Tx queue stop/wake

Michal Luczaj (6):
      selftests/bpf: Support more socket types in create_pair()
      selftests/bpf: Socket pair creation, cleanups
      selftests/bpf: Simplify inet_socketpair() and vsock_socketpair_connectible()
      selftests/bpf: Honour the sotype of af_unix redir tests
      selftests/bpf: Exercise SOCK_STREAM unix_inet_redir_to_connected()
      selftests/bpf: Introduce __attribute__((cleanup)) in create_pair()

Michal Swiatkowski (8):
      ice: treat subfunction VSI the same as PF VSI
      ice: make representor code generic
      ice: create port representor for SF
      ice: don't set target VSI for subfunction
      ice: check if SF is ready in ethtool ops
      ice: implement netdevice ops for SF representor
      ice: support subfunction devlink Tx topology
      ice: basic support for VLAN in subfunctions

Mina Almasry (17):
      ethtool: refactor checking max channels
      net: refactor ->ndo_bpf calls into dev_xdp_propagate
      netdev: add netdev_rx_queue_restart()
      net: netdev netlink api to bind dma-buf to a net device
      netdev: support binding dma-buf to netdevice
      netdev: netdevice devmem allocator
      page_pool: devmem support
      memory-provider: dmabuf devmem memory provider
      net: support non paged skb frags
      net: add support for skbs with unreadable frags
      tcp: RX path for devmem TCP
      net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
      net: add devmem TCP documentation
      selftests: add ncdevmem, netcat for devmem TCP
      netdev: add dmabuf introspection
      memory-provider: fix compilation issue without SYSFS
      memory-provider: disable building dmabuf mp on !CONFIG_PAGE_POOL

Ming Yen Hsieh (4):
      wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
      wifi: mac80211: introduce EHT rate support in AQL airtime
      wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc
      wifi: mt76: mt7925: replace chan config with extend txpower config for clc

Miri Korenblit (11):
      wifi: iwlwifi: remove MVM prefix from FW macros
      wifi: iwlwifi: mvm: add and improve EMLSR debug info
      wifi: iwlwifi: use default command queue watchdog timeout
      wifi: iwlwifi: mvm: cleanup iwl_mvm_get_wd_timeout
      wifi: iwlwifi: bump FW API to 93 for BZ/SC devices
      wifi: iwlwifi: mvm: avoid NULL pointer dereference
      wifi: iwlwifi: s/IWL_MVM_STATION_COUNT_MAX/IWL_STATION_COUNT_MAX
      wifi: iwlwifi: STA command structure shouldn't be mvm specific
      wifi: iwlwifi: s/iwl_mvm_remove_sta_cmd/iwl_remove_sta_cmd
      wifi: iwlwifi: mvm: remove mvm prefix from iwl_mvm_tx_resp*
      wifi: iwlwifi: mvm: properly set the rates in link cmd

Mohammad Nassiri (1):
      selftests/tcp_ao: Fix printing format for uint64_t

Mohsin Bashir (2):
      eth: fbnic: Add ethtool support for fbnic
      eth: fbnic: Add support to fetch group stats

Moon Yeounsu (1):
      net: ethernet: dlink: replace deprecated macro

Moshe Shemesh (5):
      net/mlx5: fs, move steering common function to fs_cmd.h
      net/mlx5: fs, make get_root_namespace API function
      net/mlx5: Add device cap for supporting hot reset in sync reset flow
      net/mlx5: Add support for sync reset using hot reset
      net/mlx5: Skip HotPlug check on sync reset using hot reset

Nathan Chancellor (2):
      can: rockchip_canfd: fix return type of rkcanfd_start_xmit()
      xfrm: policy: Restore dir assignments in xfrm_hash_rebuild()

Neeraj Sanjay Kale (2):
      Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h
      Bluetooth: btnxpuart: Add support for ISO packets

Nelson Escobar (4):
      enic: Use macro instead of static const variables for array sizes
      enic: Collect per queue statistics
      enic: Report per queue statistics in netdev qstats
      enic: Report some per queue statistics in ethtool

Nick Child (9):
      ibmveth: Optimize poll rescheduling process
      ibmveth: Recycle buffers during replenish phase
      ibmvnic: Only replenish rx pool when resources are getting low
      ibmvnic: Use header len helper functions on tx
      ibmvnic: Reduce memcpys in tx descriptor generation
      ibmvnic: Remove duplicate memory barriers in tx
      ibmvnic: Introduce send sub-crq direct
      ibmvnic: Only record tx completed bytes once per handler
      ibmvnic: Perform tx CSO during send scrq direct

Nick Morrow (1):
      wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

Niklas Söderlund (1):
      net: phy: Check for read errors in SIOCGMIIREG

Nikolay Aleksandrov (1):
      doc/netlink/specs: add netkit support to rt_link.yaml

Oleksij Rempel (6):
      ethtool: Add new result codes for TDR diagnostics
      phy: Add Open Alliance helpers for the PHY framework
      net: phy: dp83tg720: Add cable testing support
      ethtool: Extend cable testing interface with result source information
      ethtool: Add support for specifying information source in cable test results
      phy: dp83td510: Utilize ALCD for cable length measurement when link is active

P Praneesh (2):
      wifi: ath12k: fix BSS chan info request WMI command
      wifi: ath12k: match WMI BSS chan info structure with firmware definition

Pablo Neira Ayuso (10):
      netfilter: nf_tables: do not remove elements if set backend implements .abort
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout
      netfilter: nf_tables: remove annotation to access set timeout while holding lock
      netfilter: nft_dynset: annotate data-races around set timeout
      netfilter: nf_tables: annotate data-races around element expiration
      netfilter: nf_tables: consolidate timeout extension for elements
      netfilter: nf_tables: zero timeout means element never times out
      netfilter: nf_tables: set element timeout update support

Paolo Abeni (14):
      Merge branch 'stmmac-add-loongson-platform-support'
      Merge branch 'net-netconsole-fix-netconsole-unsafe-locking'
      Merge branch 'net-smc-introduce-ringbufs-usage-statistics'
      Merge branch 'preparations-for-fib-rule-dscp-selector'
      tools: ynl: lift an assumption about spec file name
      Merge branch 'net-ipv6-ioam6-introduce-tunsrc'
      Merge branch 'tc-adjust-network-header-after-2nd-vlan-push'
      Merge branch 'netdev_features-start-cleaning-netdev_features_t-up'
      Merge branch 'net-simplified-with-scoped-function'
      Merge branch 'cleanup-chelsio-driver-declarations'
      Merge branch 'bonding-support-new-xfrm-state-offload-functions'
      Merge tag 'linux-can-next-for-6.12-20240904-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'add-driver-for-motorcomm-yt8821-2-5g-ethernet-phy'
      Merge branch 'net-lan966x-use-the-newly-introduced-fdma-library'

Parthiban Veerasooran (14):
      Documentation: networking: add OPEN Alliance 10BASE-T1x MAC-PHY serial interface
      net: ethernet: oa_tc6: implement register write operation
      net: ethernet: oa_tc6: implement register read operation
      net: ethernet: oa_tc6: implement software reset
      net: ethernet: oa_tc6: implement error interrupts unmasking
      net: ethernet: oa_tc6: implement internal PHY initialization
      net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
      net: ethernet: oa_tc6: enable open alliance tc6 data communication
      net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames
      net: ethernet: oa_tc6: implement receive path to receive rx ethernet frames
      net: ethernet: oa_tc6: implement mac-phy interrupt
      net: ethernet: oa_tc6: add helper function to enable zero align rx frame
      microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
      dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY

Patrick Rohr (1):
      Add support for PIO p flag

Patrisious Haddad (1):
      xfrm: Remove documentation WARN_ON to limit return values for offloaded SA

Pavan Kumar Linga (1):
      idpf: remove redundant 'req_vec_chunks' NULL check

Pavel Nikulin (1):
      Bluetooth: btusb: Add Mediatek MT7925 support ID 0x13d3:0x3608

Pawel Dembicki (7):
      net: dsa: vsc73xx: make RGMII delays configurable
      dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
      net: dsa: vsc73xx: speed up MDIO bus to max allowed value
      net: phy: vitesse: implement downshift in vsc73xx phys
      net: dsa: vsc73xx: use defined values in phy operations
      net: phy: vitesse: implement MDI-X configuration in vsc73xx
      net: dsa: vsc73xx: implement FDB operations

Peter Chiu (5):
      wifi: mt76: mt7996: use hweight16 to get correct tx antenna
      wifi: mt76: mt7996: fix traffic delay when switching back to working channel
      wifi: mt76: mt7996: fix wmm set of station interface to 3
      wifi: mt76: mt7996: advertize beacon_int_min_gcd
      wifi: mt76: connac: fix checksum offload fields of connac3 RXD

Peter Robinson (2):
      wifi: rtl8xxxu: drop reference to staging drivers
      wifi: rtl8xxxu: add missing rtl8192cu USB IDs

Petr Machata (6):
      net: nexthop: Add flag to assert that NHGRP reserved fields are zero
      net: nexthop: Increase weight to u16
      selftests: router_mpath: Sleep after MZ
      selftests: router_mpath_nh: Test 16-bit next hop weights
      selftests: router_mpath_nh_res: Test 16-bit next hop weights
      selftests: fib_nexthops: Test 16-bit next hop weights

Philo Lu (5):
      bpf: Support __nullable argument suffix for tp_btf
      selftests/bpf: Add test for __nullable suffix in tp_btf
      tcp: Use skb__nullable in trace_tcp_send_reset
      bpf: Allow bpf_dynptr_from_skb() for tp_btf
      selftests/bpf: Expand skb dynptr selftests for tp_btf

Pieter Van Trappen (11):
      net: macb: increase max_mtu for oversized frames
      dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
      net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
      net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
      net: dsa: microchip: add WoL support for KSZ87xx family
      net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
      net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family
      net: dsa: microchip: rename ksz8 series files
      net: dsa: microchip: clean up ksz8_reg definition macros
      net: dsa: microchip: replace unclear KSZ8830 strings
      net: dsa: microchip: update tag_ksz masks for KSZ9477 family

Ping-Ke Shih (16):
      wifi: rtw88: debugfs: support multiple adapters debugging
      wifi: rtw89: 8852bt: add set_channel_rf
      wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK enable/disable
      wifi: rtw89: 8852bt: add chip_info of RTL8852BT
      wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
      wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
      wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
      wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
      wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
      wifi: rtw89: 8852c: support firmware format up to v1
      wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
      wifi: rtw89: correct base HT rate mask for firmware
      wifi: rtw89: debugfs: support multiple adapters debugging
      wifi: mac80211: don't use rate mask for offchannel TX either
      wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
      wifi: rtw88: assign mac_id for vif/sta and update to TX desc

Piotr Raczynski (7):
      ice: add new VSI type for subfunctions
      ice: export ice ndo_ops functions
      ice: add basic devlink subfunctions support
      ice: allocate devlink for subfunction
      ice: base subfunction aux driver
      ice: implement netdev for subfunction
      ice: subfunction activation and base devlink ops

Po-Hao Huang (2):
      wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports
      wifi: rtw89: 8922a: Add new fields for scan offload H2C command

Przemek Kitszel (1):
      ice: stop intermixing AQ commands/responses debug dumps

Qianqiang Liu (1):
      net: ag71xx: remove dead code path

Radhey Shyam Pandey (3):
      net: axienet: add missing blank line after declaration
      net: axienet: remove unnecessary ftrace-like logging
      net: axienet: remove unnecessary parentheses

Rahul Rameshbabu (4):
      net/mlx5: Add support for MTPTM and MTCTR registers
      net/mlx5: Implement PTM cross timestamping support
      MAINTAINERS: Update Mellanox website links
      net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq

Raju Lakkaraju (4):
      net: lan743x: Create separate PCS power reset function
      net: lan743x: Create separate Link Speed Duplex state function
      net: lan743x: Migrate phylib to phylink
      net: lan743x: Add support to ethtool phylink get and set settings

Ravi Gunasekaran (1):
      net: ti: icssg-prueth: Enable HSR Tx duplication, Tx Tag and Rx Tag offload

Rex Lu (1):
      wifi: mt76: mt7996: fix handling mbss enable/disable

Rob Herring (Arm) (5):
      net: phy: qca807x: Drop unnecessary and broken DT validation
      net: mdio: Use of_property_count_u32_elems() to get property length
      net: Use of_property_read_bool()
      net: can: cc770: Simplify parsing DT properties
      net: amlogic,meson-dwmac: Fix "amlogic,tx-delay-ns" schema

Roger Quadros (6):
      net: ethernet: ti: am65-cpsw: Introduce multi queue Rx
      net: ethernet: ti: cpsw_ale: use regfields for ALE registers
      net: ethernet: ti: cpsw_ale: use regfields for number of Entries and Policers
      net: ethernet: ti: cpsw_ale: add Policer and Thread control register fields
      net: ethernet: ti: cpsw_ale: add policer/classifier helpers and setup defaults
      net: ethernet: ti: am65-cpsw: setup priority to flow mapping

Rory Little (1):
      wifi: mac80211: Add non-atomic station iterator

Rosen Penev (28):
      wifi: ath9k: use devm for request_irq()
      wifi: ath9k: use devm for gpio_request_one()
      net: atlantic: use ethtool_sprintf
      net: ag71xx: use phylink_mii_ioctl
      net: sunvnet: use ethtool_sprintf/puts
      net: hinic: use ethtool_sprintf/puts
      net: ag71xx: devm_clk_get_enabled
      net: ag71xx: use devm for of_mdiobus_register
      net: ag71xx: use devm for register_netdev
      net: ag71xx: move clk_eth out of struct
      net: ag71xx: support probe defferal for getting MAC address
      net: phy: qca83xx: use PHY_ID_MATCH_EXACT
      net: ag71xx: add COMPILE_TEST to test compilation
      net: ag71xx: add MODULE_DESCRIPTION
      net: ag71xx: update FIFO bits and descriptions
      net: ag71xx: use ethtool_puts
      net: ag71xx: get reset control using devm api
      net: ag71xx: remove always true branch
      net: gianfar: fix NVMEM mac address
      net: ibm: emac: use devm for alloc_etherdev
      net: ibm: emac: manage emac_irq with devm
      net: ibm: emac: use devm for of_iomap
      net: ibm: emac: remove mii_bus with devm
      net: ibm: emac: use devm for register_netdev
      net: ibm: emac: use netdev's phydev directly
      net: ibm: emac: replace of_get_property
      net: ibm: emac: remove all waiting code
      net: ibm: emac: get rid of wol_irq

Russell King (1):
      net: phylink: Add phylink_set_fixed_link() to configure fixed link state in phylink

Russell King (Oracle) (2):
      net: mii: constify advertising mask
      net: phylib: do not disable autoneg for fixed speeds >= 1G

Sascha Hauer (7):
      wifi: mwifiex: increase max_num_akm_suites
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: fix key_mgmt setting
      wifi: mwifiex: add support for WPA-PSK-SHA256
      wifi: mwifiex: keep mwifiex_cfg80211_ops constant
      wifi: mwifiex: remove unnecessary checks for valid priv
      net: tls: wait for async completion on last message

Sasha Neftin (2):
      igc: Add Energy Efficient Ethernet ability
      igc: Move the MULTI GBT AN Control Register to _regs file

Scott Ehlert (1):
      Bluetooth: btsdio: Do not bind to non-removable CYW4373

Sean Anderson (10):
      net: xilinx: axienet: Report RxRject as rx_dropped
      net: xilinx: axienet: Add statistics support
      net: xilinx: axienet: Don't print if we go into promiscuous mode
      net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
      net: xilinx: axienet: Support IFF_ALLMULTI
      net: cadence: macb: Enable software IRQ coalescing by default
      net: xilinx: axienet: Remove unused checksum variables
      net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx checksumming
      net: xilinx: axienet: Set RXCSUM in features
      net: xilinx: axienet: Relax partial rx checksum checks

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Use u64_stats_t for statistic.
      net: hsr: Use the seqnr lock for frames received via interlink port.

Sergey Temerkhanov (1):
      ice: Report NVM version numbers on mismatch during load

Shannon Nelson (5):
      ionic: debug line for Tx completion errors
      ionic: rename ionic_xdp_rx_put_bufs
      ionic: use per-queue xdp_prog
      ionic: always use rxq_info
      ionic: convert Rx queue buffers to use page_pool

Shay Drory (2):
      net/mlx5: Allow users to configure affinity for SFs
      net/mlx5: Add NOT_READY command return status

Shen Lichuan (4):
      wifi: mac80211: use kmemdup_array instead of kmemdup for multiple allocation
      sfc: Convert to use ERR_CAST()
      nfp: Convert to use ERR_CAST()
      netfilter: conntrack: Convert to use ERR_CAST()

Shradha Gupta (2):
      net: mana: Implement get_ringparam/set_ringparam for mana
      net: mana: Improve mana_set_channels() in low mem conditions

Simon Horman (40):
      ethtool: Don't check for NULL info in prepare_data callbacks
      eth: fbnic: select DEVLINK and PAGE_POOL
      linkmode: Change return type of linkmode_andnot to bool
      tipc: guard against string buffer overrun
      bonding: Pass string literal as format argument of alloc_ordered_workqueue()
      net: mvpp2: Increase size of queue_name buffer
      bnx2x: Provide declaration of dmae_reg_go_c in header
      net: stmmac: xgmac: use const char arrays for string constants
      net: mvneta: Use __be16 for l3_proto parameter of mvneta_txq_desc_csum()
      bnxt_en: Extend maximum length of version string by 1 byte
      bnxt_en: avoid truncation of per rx run debugfs filename
      ipv6: Add ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
      net: ethernet: mtk_eth_soc: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
      net: hns3: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
      net: txgbe: Remove unnecessary NULL check before free
      bnx2x: Set ivi->vlan field as an integer
      net: atlantic: Avoid warning about potential string truncation
      xfrm: Correct spelling in xfrm.h
      packet: Correct spelling in if_packet.h
      s390/iucv: Correct spelling in iucv.h
      ip_tunnel: Correct spelling in ip_tunnels.h
      ipv6: Correct spelling in ipv6.h
      bonding: Correct spelling in headers
      net: qualcomm: rmnet: Correct spelling in if_rmnet.h
      netlabel: Correct spelling in netlabel.h
      NFC: Correct spelling in headers
      net: sched: Correct spelling in headers
      sctp: Correct spelling in headers
      x25: Correct spelling in x25.h
      net: Correct spelling in headers
      net: Correct spelling in net/core
      mac802154: Correct spelling in mac802154.h
      ieee802154: Correct spelling in nl802154.h
      bpf, sockmap: Correct spelling skmsg.c
      netfilter: nf_tables: Correct spelling in nf_tables.h
      netfilter: nf_tables: Add missing Kernel doc
      wifi: cfg80211: wext: Update spelling and grammar
      octeontx2-af: Pass string literal as format argument of alloc_workqueue()
      octeontx2-pf: Make iplen __be16 in otx2_sqe_add_ext()
      net: ibm: emac: Use __iomem annotation for emac_[xg]aht_base

Somashekhar(Som) (1):
      wifi: iwlwifi: Enable channel puncturing for US/CAN from bios

Sreekanth Reddy (1):
      bnxt_en: Support QOS and TPID settings for the SRIOV VLAN

Srujana Challa (3):
      octeontx2-af: use dynamic interrupt vectors for CN10K
      octeontx2-af: avoid RXC register access for CN10KB
      octeontx2-af: configure default CPT credits for CN10KA B0

Stanislav Fomichev (4):
      selftests: net-drv: exercise queue stats when the device is down
      selftests: net: ksft: support marking tests as disruptive
      selftests: net: ksft: replace 95 with errno.EOPNOTSUPP
      eth: fbnic: add support for basic qstats

Stefan Mätje (5):
      can: esd_402_pci: Rename esdACC CTRL register macros
      can: esd_402_pci: Add support for one-shot mode
      can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode
      can: usb: Kconfig: Fix list of devices for esd_usb driver
      can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

Stefan Wahren (5):
      net: vertexcom: mse102x: Use DEFINE_SIMPLE_DEV_PM_OPS
      net: vertexcom: mse102x: Silence TX timeout
      net: vertexcom: mse102x: Fix random MAC address log
      net: vertexcom: mse102x: Drop log message on remove
      net: vertexcom: mse102x: Use ETH_ZLEN

Steffen Klassert (2):
      Merge branch 'xfrm: speed up policy insertions'
      Revert "xfrm: add SA information to the offloaded packet"

Su Hui (1):
      net: tipc: avoid possible garbage value

Sven Eckelmann (1):
      net: ag71xx: disable napi interrupts during probe

Tan En De (1):
      net: stmmac: Batch set RX OWN flag and other flags

Tariq Toukan (1):
      docs: networking: Align documentation with behavior change

Thorsten Blum (1):
      wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()

Toke Høiland-Jørgensen (3):
      wifi: ath9k: Remove error checks when creating debugfs entries
      Revert "wifi: ath9k: use devm for request_irq()"
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tristram Ha (2):
      dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
      net: dsa: microchip: Add KSZ8895/KSZ8864 switch support

Uros Bizjak (2):
      net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
      netdev: Add missing __percpu qualifier to a cast

Uwe Kleine-König (1):
      can: Switch back to struct platform_driver::remove()

Vadim Fedorenko (1):
      ptp: ocp: Improve PCIe delay estimation

Vasileios Amoiridis (3):
      net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
      net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
      net: smc91x: Make use of irq_get_trigger_type()

Veerendranath Jakkam (4):
      wifi: cfg80211: Avoid RCU debug splat in __cfg80211_bss_update error paths
      wifi: cfg80211: make BSS source types public
      wifi: cfg80211: skip indicating signal for per-STA profile BSSs
      wifi: cfg80211: avoid overriding direct/MBSSID BSS with per-STA profile BSS

Vegard Nossum (3):
      .gitignore: add .gcda files
      net: rds: add option for GCOV profiling
      selftests: rds: add testing infrastructure

Vikas Gupta (2):
      bnxt_en: add support for storing crash dump into host memory
      bnxt_en: add support for retrieving crash dump using ethtool

Vitaly Lifshits (1):
      e1000e: avoid failing the system during pm_suspend

Wen Gu (2):
      net/smc: introduce statistics for allocated ringbufs of link group
      net/smc: introduce statistics for ringbufs usage of net namespace

Willem de Bruijn (5):
      selftests: support interpreted scripts with ksft_runner.sh
      selftests/net: integrate packetdrill with ksft
      selftests/net: packetdrill: run in netns and expand config
      selftests/net: packetdrill: import tcp/zerocopy
      selftests/net: packetdrill: import tcp/slow_start

Xi Huang (2):
      ipv6: remove redundant check
      net: dpaa: reduce number of synchronize_net() calls

Xin Long (2):
      openvswitch: switch to per-action label counting in conntrack
      netfilter: move nf_ct_netns_get out of nf_conncount_init

Yan Zhen (4):
      wifi: mac80211: scan: Use max macro
      net: openvswitch: Use ERR_CAST() to return
      can: kvaser_usb: Simplify with dev_err_probe()
      netfilter: Use kmemdup_array instead of kmemdup for multiple allocation

Yang Li (3):
      dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
      Bluetooth: hci_uart: Add support for Amlogic HCI UART
      MAINTAINERS: Add an entry for Amlogic HCI UART (M: Yang Li)

Yang Ruibin (1):
      net: alacritech: Switch to use dev_err_probe()

Yanteng Si (14):
      net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
      net: stmmac: Add multi-channel support
      net: stmmac: Export dwmac1000_dma_ops
      net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init
      net: stmmac: dwmac-loongson: Drop pci_enable/disable_msi calls
      net: stmmac: dwmac-loongson: Use PCI_DEVICE_DATA() macro for device identification
      net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
      net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
      net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
      net: stmmac: dwmac-loongson: Introduce PCI device info data
      net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
      net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support
      net: stmmac: dwmac-loongson: Add Loongson GNET support
      net: stmmac: dwmac-loongson: Add loongson module author

Yaxin Chen (1):
      tcp_bpf: Remove an unused parameter for bpf_tcp_ingress()

Yevgeny Kliteynik (17):
      net/mlx5: Added missing mlx5_ifc definition for HW Steering
      net/mlx5: Added missing definitions in preparation for HW Steering
      net/mlx5: HWS, added actions handling
      net/mlx5: HWS, added tables handling
      net/mlx5: HWS, added rules handling
      net/mlx5: HWS, added definers handling
      net/mlx5: HWS, added matchers functionality
      net/mlx5: HWS, added FW commands handling
      net/mlx5: HWS, added modify header pattern and args handling
      net/mlx5: HWS, added vport handling
      net/mlx5: HWS, added memory management handling
      net/mlx5: HWS, added backward-compatible API handling
      net/mlx5: HWS, added debug dump and internal headers
      net/mlx5: HWS, added send engine and context handling
      net/mlx5: HWS, added API and enabled HWS support
      net/mlx5: HWS, updated API functions comments to kernel doc
      net/mlx5: HWS, fixed error flow return values of some functions

Youwan Wang (1):
      net: phy: phy_device: fix PHY WOL enabled, PM failed to suspend

Yu Jiaoliang (2):
      nfp: bpf: Use kmemdup_array instead of kmemdup for multiple allocation
      wifi: cfg80211: Use kmemdup_array instead of kmemdup for multiple allocation

Yu Liao (1):
      net: txgbe: use pci_dev_id() helper

Yue Haibing (16):
      RDS: IB: Remove unused declarations
      rxrpc: Remove unused function declarations
      ethtool: cmis_cdb: Remove unused declaration ethtool_cmis_page_fini()
      gve: Remove unused declaration gve_rx_alloc_rings()
      igbvf: Remove two unused declarations
      net/mlx5: E-Switch, Remove unused declarations
      mptcp: Remove unused declaration mptcp_sockopt_sync()
      net: thunderx: Remove unused declarations
      net: liquidio: Remove unused declarations
      cxgb3: Remove unused declarations
      cxgb4: Remove unused declarations
      cxgb: Remove unused declarations
      qlcnic: Remove unused declarations
      be2net: Remove unused declarations
      wifi: libertas: Cleanup unused declarations
      Bluetooth: L2CAP: Remove unused declarations

Zhang Changzhong (3):
      net: remove redundant check in skb_shift()
      wifi: mac80211: remove redundant unlikely() around IS_ERR()
      can: j1939: use correct function name in comment

Zhang Zekun (2):
      net: ethernet: ibm: Simpify code with for_each_child_of_node()
      net: hns3: Use ARRAY_SIZE() to improve readability

Zhengchao Shao (4):
      net/smc: remove unreferenced header in smc_loopback.h file
      net/smc: remove the fallback in __smc_connect
      net/smc: remove redundant code in smc_connect_check_aclc
      net/smc: remove unused input parameters in smcr_new_buf_create

Zijun Hu (2):
      wifi: rfkill: Correct parameter type for rfkill_set_hw_state_reason()
      net: sysfs: Fix weird usage of class's namespace relevant fields

Ziwei Xiao (1):
      gve: Add RSS device option

Zong-Zhe Yang (21):
      wifi: rtw88: select WANT_DEV_COREDUMP
      wifi: rtw89: select WANT_DEV_COREDUMP
      wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX
      wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
      wifi: rtw89: mcc: stop at a role holding chanctx
      wifi: rtw89: rename sub_entity to chanctx
      wifi: rtw89: pass rtwvif to RFK channel
      wifi: rtw89: pass rtwvif to RFK scan
      wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and update_beacon_be
      wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()
      wifi: rtw89: pass chan to rfk_band_changed()
      wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
      wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
      wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
      wifi: rtw89: introduce chip support link number and driver MLO capability
      wifi: mac80211_hwsim: correct MODULE_PARM_DESC of multi_radio
      wifi: rtw89: wow: fix wait condition for AOAC report request
      wifi: rtw89: avoid reading out of bounds when loading TX power FW elements

hhorace (1):
      wifi: cfg80211: fix bug of mapping AF3x to incorrect User Priority

wangfe (1):
      xfrm: add SA information to the offloaded packet

zhangxiangqian (1):
      net: usb: cdc_ether: don't spew notifications

 .gitignore                                         |    1 +
 Documentation/dev-tools/gcov.rst                   |   11 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |   22 +-
 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  |   63 +
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   10 +-
 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |    8 +-
 .../bindings/net/can/microchip,mcp2510.yaml        |   70 +
 .../bindings/net/can/microchip,mcp251x.txt         |   30 -
 .../bindings/net/can/renesas,rcar-canfd.yaml       |   22 +-
 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |   74 +
 .../bindings/net/dsa/mediatek,mt7530.yaml          |    8 +-
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |    7 +
 .../bindings/net/dsa/vitesse,vsc73xx.yaml          |   32 +
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml           |   10 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |    2 +-
 .../devicetree/bindings/net/mediatek,net.yaml      |   12 +-
 .../devicetree/bindings/net/microchip,lan8650.yaml |   74 +
 .../bindings/net/pse-pd/ti,tps23881.yaml           |    3 +
 .../devicetree/bindings/net/renesas,etheravb.yaml  |   29 +-
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |    2 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |    1 +
 .../bindings/net/socionext,uniphier-ave4.yaml      |    8 +-
 .../bindings/net/wireless/marvell,sd8787.yaml      |   93 +
 .../bindings/net/wireless/marvell-8xxx.txt         |   70 -
 Documentation/devicetree/bindings/ptp/fsl,ptp.yaml |   22 +-
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       |   20 +
 Documentation/driver-api/dpll.rst                  |   21 +
 Documentation/netlink/specs/dpll.yaml              |   24 +
 Documentation/netlink/specs/ethtool.yaml           |   78 +-
 Documentation/netlink/specs/netdev.yaml            |   61 +
 Documentation/netlink/specs/nftables.yaml          |  270 +-
 Documentation/netlink/specs/rt_link.yaml           |   41 +
 .../device_drivers/ethernet/amazon/ena.rst         |    5 +
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../ethernet/mellanox/mlx5/counters.rst            |   16 +
 .../ethernet/mellanox/mlx5/kconfig.rst             |    3 +
 .../device_drivers/ethernet/meta/fbnic.rst         |   29 +
 Documentation/networking/devmem.rst                |  269 ++
 Documentation/networking/ethtool-netlink.rst       |  103 +-
 Documentation/networking/index.rst                 |    3 +
 Documentation/networking/ip-sysctl.rst             |   14 +
 Documentation/networking/l2tp.rst                  |   54 +-
 Documentation/networking/mptcp-sysctl.rst          |   11 +
 Documentation/networking/multi-pf-netdev.rst       |   10 +-
 .../networking/net_cachelines/net_device.rst       |   11 +-
 Documentation/networking/netdev-features.rst       |   15 -
 Documentation/networking/netdevices.rst            |    4 +-
 Documentation/networking/oa-tc6-framework.rst      |  497 ++++
 Documentation/networking/phy-link-topology.rst     |  121 +
 Documentation/networking/switchdev.rst             |    4 +-
 Documentation/networking/timestamping.rst          |   20 +-
 MAINTAINERS                                        |   69 +-
 arch/alpha/include/uapi/asm/socket.h               |    6 +
 arch/mips/include/uapi/asm/socket.h                |    6 +
 arch/parisc/include/uapi/asm/socket.h              |    6 +
 arch/powerpc/platforms/chrp/pegasos_eth.c          |    7 +-
 arch/sparc/include/uapi/asm/socket.h               |    6 +
 drivers/bluetooth/Kconfig                          |   12 +
 drivers/bluetooth/Makefile                         |    1 +
 drivers/bluetooth/btintel_pcie.c                   |   18 +-
 drivers/bluetooth/btnxpuart.c                      |    1 +
 drivers/bluetooth/btrtl.c                          |   23 +-
 drivers/bluetooth/btsdio.c                         |    1 +
 drivers/bluetooth/btusb.c                          |  249 +-
 drivers/bluetooth/h4_recv.h                        |    7 +
 drivers/bluetooth/hci_aml.c                        |  755 ++++++
 drivers/bluetooth/hci_ldisc.c                      |   11 +-
 drivers/bluetooth/hci_uart.h                       |    8 +-
 drivers/dpll/dpll_netlink.c                        |  130 +
 drivers/dpll/dpll_nl.c                             |    5 +-
 drivers/net/amt.c                                  |    4 +-
 drivers/net/bareudp.c                              |   28 +-
 drivers/net/bonding/bond_main.c                    |  122 +-
 drivers/net/can/Kconfig                            |    1 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/at91_can.c                         |    2 +-
 drivers/net/can/bxcan.c                            |    2 +-
 drivers/net/can/c_can/c_can_platform.c             |    2 +-
 drivers/net/can/cc770/cc770_isa.c                  |    2 +-
 drivers/net/can/cc770/cc770_platform.c             |   32 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c       |    2 +-
 drivers/net/can/dev/dev.c                          |    3 -
 drivers/net/can/dev/netlink.c                      |  102 +-
 drivers/net/can/esd/esd_402_pci-core.c             |    5 +-
 drivers/net/can/esd/esdacc.c                       |   55 +-
 drivers/net/can/esd/esdacc.h                       |   36 +-
 drivers/net/can/flexcan/flexcan-core.c             |   52 +-
 drivers/net/can/flexcan/flexcan.h                  |    2 +
 drivers/net/can/grcan.c                            |    2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |    2 +-
 drivers/net/can/janz-ican3.c                       |    2 +-
 drivers/net/can/kvaser_pciefd.c                    |   29 +-
 drivers/net/can/m_can/m_can.c                      |   17 +-
 drivers/net/can/m_can/m_can_platform.c             |    2 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |    2 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |    3 -
 drivers/net/can/rcar/rcar_can.c                    |    2 +-
 drivers/net/can/rcar/rcar_canfd.c                  |    2 +-
 drivers/net/can/rockchip/Kconfig                   |    9 +
 drivers/net/can/rockchip/Makefile                  |   10 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  967 ++++++++
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |   73 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  299 +++
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  105 +
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  167 ++
 drivers/net/can/rockchip/rockchip_canfd.h          |  553 +++++
 drivers/net/can/sja1000/sja1000_isa.c              |    2 +-
 drivers/net/can/sja1000/sja1000_platform.c         |    2 +-
 drivers/net/can/softing/softing_main.c             |    2 +-
 drivers/net/can/sun4i_can.c                        |    2 +-
 drivers/net/can/ti_hecc.c                          |    2 +-
 drivers/net/can/usb/Kconfig                        |    3 +-
 drivers/net/can/usb/esd_usb.c                      |    6 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   26 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   63 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   41 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  114 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    3 -
 drivers/net/can/xilinx_can.c                       |    2 +-
 drivers/net/dsa/b53/b53_mdio.c                     |    7 +-
 drivers/net/dsa/microchip/Kconfig                  |    9 +-
 drivers/net/dsa/microchip/Makefile                 |    2 +-
 drivers/net/dsa/microchip/{ksz8795.c => ksz8.c}    |  123 +-
 drivers/net/dsa/microchip/ksz8.h                   |    3 +
 drivers/net/dsa/microchip/ksz8863_smi.c            |    4 +-
 .../dsa/microchip/{ksz8795_reg.h => ksz8_reg.h}    |   15 +-
 drivers/net/dsa/microchip/ksz9477.c                |  287 +--
 drivers/net/dsa/microchip/ksz9477.h                |    5 -
 drivers/net/dsa/microchip/ksz9477_reg.h            |   12 -
 drivers/net/dsa/microchip/ksz_common.c             |  450 +++-
 drivers/net/dsa/microchip/ksz_common.h             |   60 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |    2 +-
 drivers/net/dsa/microchip/ksz_spi.c                |   21 +-
 drivers/net/dsa/mt7530-mmio.c                      |    1 +
 drivers/net/dsa/mt7530.c                           |   49 +-
 drivers/net/dsa/mt7530.h                           |   20 +-
 drivers/net/dsa/mv88e6xxx/global2_scratch.c        |    2 +-
 drivers/net/dsa/ocelot/felix.c                     |    5 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |    2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |   10 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |    8 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   10 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  482 +++-
 drivers/net/dsa/vitesse-vsc73xx.h                  |    2 +
 drivers/net/dummy.c                                |    3 +-
 drivers/net/ethernet/Kconfig                       |   11 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/adi/adin1110.c                |    2 +-
 drivers/net/ethernet/alacritech/slicoss.c          |   21 +-
 drivers/net/ethernet/alteon/acenic.c               |   26 +-
 drivers/net/ethernet/alteon/acenic.h               |    8 +-
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h   |   72 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |  175 +-
 drivers/net/ethernet/amazon/ena/ena_com.h          |   68 +
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  163 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   27 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |    2 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |    8 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   30 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |    4 -
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c           |   16 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   16 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |    4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   10 +-
 drivers/net/ethernet/apple/bmac.c                  |    3 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   25 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |    4 +-
 drivers/net/ethernet/atheros/Kconfig               |    4 +-
 drivers/net/ethernet/atheros/ag71xx.c              |  179 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |    5 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |    4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h    |    2 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c  |    2 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  381 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   20 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |   98 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h |    8 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c  |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   33 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  389 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   29 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |    6 +-
 drivers/net/ethernet/broadcom/cnic.c               |   19 +-
 drivers/net/ethernet/broadcom/cnic.h               |    2 +-
 drivers/net/ethernet/broadcom/tg3.c                |    6 +-
 drivers/net/ethernet/cadence/macb.h                |    3 +-
 drivers/net/ethernet/cadence/macb_main.c           |   21 +-
 drivers/net/ethernet/cadence/macb_pci.c            |    5 +-
 .../ethernet/cavium/liquidio/cn23xx_vf_device.h    |    2 -
 .../net/ethernet/cavium/liquidio/cn66xx_device.h   |    1 -
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   16 +-
 .../net/ethernet/cavium/liquidio/octeon_device.h   |    7 -
 drivers/net/ethernet/cavium/liquidio/octeon_droq.h |    2 -
 drivers/net/ethernet/cavium/liquidio/octeon_iq.h   |    3 -
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |    2 -
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    2 -
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |    2 -
 drivers/net/ethernet/chelsio/cxgb/common.h         |    2 -
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c          |    3 +-
 drivers/net/ethernet/chelsio/cxgb/tp.h             |    2 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h    |    2 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |    5 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.h     |    1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |   11 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c    |    6 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h    |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h     |    1 -
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |    8 +-
 drivers/net/ethernet/cisco/enic/enic.h             |   38 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  106 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  157 +-
 drivers/net/ethernet/davicom/dm9051.c              |    1 +
 drivers/net/ethernet/dlink/dl2k.c                  |    2 +-
 drivers/net/ethernet/emulex/benet/be.h             |    2 -
 drivers/net/ethernet/emulex/benet/be_cmds.h        |    3 -
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |    4 -
 drivers/net/ethernet/faraday/ftgmac100.c           |   28 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    6 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   25 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |    9 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   20 +-
 drivers/net/ethernet/freescale/fec_main.c          |   18 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   58 +-
 drivers/net/ethernet/freescale/fman/fman_port.c    |    6 +-
 drivers/net/ethernet/freescale/fs_enet/Kconfig     |    2 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |  452 ++--
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |   27 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c   |   17 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c   |   15 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c   |   29 +-
 .../net/ethernet/freescale/fs_enet/mii-bitbang.c   |    5 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |    5 +-
 drivers/net/ethernet/freescale/gianfar.c           |    2 +
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   10 +-
 drivers/net/ethernet/fungible/funcore/fun_dev.c    |   17 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |    5 +-
 drivers/net/ethernet/google/gve/gve.h              |    6 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |  182 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   59 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   44 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |    3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   79 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    8 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |    4 -
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |    8 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    1 +
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |   33 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |   10 +-
 drivers/net/ethernet/ibm/emac/core.c               |  221 +-
 drivers/net/ethernet/ibm/emac/core.h               |   10 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  176 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  183 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   19 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   40 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   24 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   30 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   59 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c        |   89 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h        |   13 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  160 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   25 +-
 drivers/net/ethernet/intel/ice/Makefile            |    4 +
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   46 +
 drivers/net/ethernet/intel/ice/devlink/devlink.h   |    1 +
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  506 ++++
 .../net/ethernet/intel/ice/devlink/devlink_port.h  |   46 +
 drivers/net/ethernet/intel/ice/ice.h               |   19 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |    4 +
 drivers/net/ethernet/intel/ice/ice_base.c          |    5 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    1 +
 drivers/net/ethernet/intel/ice/ice_controlq.c      |  176 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h      |    5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |    1 +
 drivers/net/ethernet/intel/ice/ice_ddp.c           |   10 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |   13 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  223 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |  111 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |   22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   10 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   99 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c          |  109 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |    5 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   50 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |   64 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h         |   28 +-
 drivers/net/ethernet/intel/ice/ice_parser.c        | 2430 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h        |  540 ++++
 drivers/net/ethernet/intel/ice/ice_parser_rt.c     |  861 +++++++
 drivers/net/ethernet/intel/ice/ice_repr.c          |  211 +-
 drivers/net/ethernet/intel/ice/ice_repr.h          |   22 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |    6 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c        |  329 +++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h        |   33 +
 .../net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c   |   21 +
 .../net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h   |   13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    2 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |    2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |    4 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |  403 ++-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c  |    4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |    2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   23 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |  110 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  397 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   92 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |    2 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    8 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |    1 -
 drivers/net/ethernet/intel/igbvf/mbx.h             |    1 -
 drivers/net/ethernet/intel/igc/igc.h               |   11 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       |   22 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   81 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   99 +-
 drivers/net/ethernet/intel/igc/igc_phy.c           |    4 +-
 drivers/net/ethernet/intel/igc/igc_regs.h          |   12 +
 drivers/net/ethernet/intel/igc/igc_tsn.c           |   67 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    4 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   11 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |    4 +-
 drivers/net/ethernet/lantiq_etop.c                 |    1 -
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    5 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |   18 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  136 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    5 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   30 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |  124 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   11 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |    6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    2 -
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    2 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |    3 +-
 drivers/net/ethernet/mediatek/airoha_eth.c         |  547 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   14 -
 drivers/net/ethernet/mediatek/mtk_ppe.c            |   10 +-
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c    |    9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   10 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   21 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    7 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.h        |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h  |    2 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c |   21 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c |   26 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   46 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_priv.h   |    1 +
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |    1 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   99 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  120 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    3 -
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   62 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  315 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |   95 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |    4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   91 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    9 +
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |   16 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   12 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   92 +-
 .../mellanox/mlx5/core/steering/hws/Makefile       |    2 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |  926 +++++++
 .../mlx5/core/steering/hws/mlx5hws_action.c        | 2604 ++++++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_action.h        |  307 +++
 .../mlx5/core/steering/hws/mlx5hws_buddy.c         |  149 ++
 .../mlx5/core/steering/hws/mlx5hws_buddy.h         |   21 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c  |  997 ++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h  |   73 +
 .../mlx5/core/steering/hws/mlx5hws_bwc_complex.c   |   86 +
 .../mlx5/core/steering/hws/mlx5hws_bwc_complex.h   |   29 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c  | 1300 ++++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h  |  361 +++
 .../mlx5/core/steering/hws/mlx5hws_context.c       |  260 ++
 .../mlx5/core/steering/hws/mlx5hws_context.h       |   64 +
 .../mlx5/core/steering/hws/mlx5hws_debug.c         |  480 ++++
 .../mlx5/core/steering/hws/mlx5hws_debug.h         |   40 +
 .../mlx5/core/steering/hws/mlx5hws_definer.c       | 2146 ++++++++++++++++
 .../mlx5/core/steering/hws/mlx5hws_definer.h       |  834 +++++++
 .../mlx5/core/steering/hws/mlx5hws_internal.h      |   59 +
 .../mlx5/core/steering/hws/mlx5hws_matcher.c       | 1216 +++++++++
 .../mlx5/core/steering/hws/mlx5hws_matcher.h       |  107 +
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.c       |  579 +++++
 .../mlx5/core/steering/hws/mlx5hws_pat_arg.h       |  101 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_pool.c |  640 +++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_pool.h |  151 ++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_prm.h  |  514 ++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.c |  780 ++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.h |   84 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 1209 +++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.h |  270 ++
 .../mlx5/core/steering/hws/mlx5hws_table.c         |  493 ++++
 .../mlx5/core/steering/hws/mlx5hws_table.h         |   68 +
 .../mlx5/core/steering/hws/mlx5hws_vport.c         |   86 +
 .../mlx5/core/steering/hws/mlx5hws_vport.h         |   13 +
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   43 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   12 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |   20 -
 drivers/net/ethernet/meta/Kconfig                  |    2 +
 drivers/net/ethernet/meta/fbnic/Makefile           |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |    7 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   37 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |   75 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   75 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   13 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |    6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c   |   27 +
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |   40 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   50 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |    3 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  138 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   59 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   10 +
 drivers/net/ethernet/microchip/Kconfig             |    7 +-
 drivers/net/ethernet/microchip/Makefile            |    2 +
 drivers/net/ethernet/microchip/fdma/Kconfig        |   18 +
 drivers/net/ethernet/microchip/fdma/Makefile       |    7 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  146 ++
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |  243 ++
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |  127 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  646 +++--
 drivers/net/ethernet/microchip/lan743x_main.h      |    4 +
 drivers/net/ethernet/microchip/lan865x/Kconfig     |   19 +
 drivers/net/ethernet/microchip/lan865x/Makefile    |    6 +
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |  429 ++++
 drivers/net/ethernet/microchip/lan966x/Kconfig     |    1 +
 drivers/net/ethernet/microchip/lan966x/Makefile    |    1 +
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |   11 +-
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  417 ++--
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   58 +-
 drivers/net/ethernet/microchip/sparx5/Kconfig      |    1 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |    1 +
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   11 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |  372 +--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   31 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   29 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   96 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |   12 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |    4 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    5 +-
 .../net/ethernet/netronome/nfp/nfp_net_debugdump.c |    2 +
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |    3 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   |    2 +-
 drivers/net/ethernet/oa_tc6.c                      | 1361 ++++++++++
 drivers/net/ethernet/pasemi/pasemi_mac.c           |    5 +-
 drivers/net/ethernet/pensando/Kconfig              |    1 +
 .../net/ethernet/pensando/ionic/ionic_debugfs.c    |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   23 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    2 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  163 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |    2 +
 .../net/ethernet/pensando/ionic/ionic_rx_filter.c  |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  420 ++--
 drivers/net/ethernet/pensando/ionic/ionic_txrx.h   |    4 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |    5 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |    9 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |    1 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   12 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   10 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 +-
 drivers/net/ethernet/realtek/Kconfig               |   19 +
 drivers/net/ethernet/realtek/Makefile              |    1 +
 drivers/net/ethernet/realtek/r8169.h               |    1 +
 drivers/net/ethernet/realtek/r8169_main.c          |   46 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |    3 +
 drivers/net/ethernet/realtek/rtase/Makefile        |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h         |  340 +++
 drivers/net/ethernet/realtek/rtase/rtase_main.c    | 2288 +++++++++++++++++
 drivers/net/ethernet/renesas/ravb_main.c           |    4 +-
 drivers/net/ethernet/renesas/rswitch.c             |    2 -
 drivers/net/ethernet/renesas/rtsn.c                |    2 -
 drivers/net/ethernet/rocker/rocker_main.c          |    3 +-
 drivers/net/ethernet/sfc/ef10.c                    |  127 +
 drivers/net/ethernet/sfc/ef100_ethtool.c           |    2 +-
 drivers/net/ethernet/sfc/ef100_rep.c               |    4 +-
 drivers/net/ethernet/sfc/efx.c                     |    4 +
 drivers/net/ethernet/sfc/ethtool.c                 |    7 +-
 drivers/net/ethernet/sfc/nic.h                     |    2 +
 drivers/net/ethernet/sfc/nic_common.h              |    1 +
 drivers/net/ethernet/sfc/ptp.c                     |    2 +-
 drivers/net/ethernet/sfc/siena/efx_common.c        |    7 -
 drivers/net/ethernet/sfc/siena/ethtool.c           |    6 -
 drivers/net/ethernet/sfc/siena/ethtool_common.c    |  125 +-
 drivers/net/ethernet/sfc/siena/net_driver.h        |   26 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |    2 +-
 drivers/net/ethernet/sfc/siena/rx_common.c         |   56 -
 drivers/net/ethernet/sfc/siena/rx_common.h         |    4 -
 drivers/net/ethernet/sfc/tc_counters.c             |    2 +-
 drivers/net/ethernet/smsc/smc91x.c                 |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  597 ++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  164 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   10 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |   35 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |   96 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |   12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |   27 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |   30 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   78 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |    6 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   27 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   35 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  108 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  292 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  153 +-
 drivers/net/ethernet/sun/sunvnet.c                 |   34 +-
 drivers/net/ethernet/tehuti/tehuti.c               |    4 +-
 drivers/net/ethernet/tehuti/tehuti.h               |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |  105 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  394 +--
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |   39 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  287 ++-
 drivers/net/ethernet/ti/cpsw_ale.h                 |   62 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |    7 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    3 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |   72 -
 drivers/net/ethernet/ti/icssg/icss_iep.h           |   73 +-
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |    1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   18 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c       |   22 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h       |    2 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |   30 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  200 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   18 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    9 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |   36 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h        |  158 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |    7 +-
 drivers/net/ethernet/toshiba/spider_net.c          |    3 +-
 drivers/net/ethernet/vertexcom/mse102x.c           |   20 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |    5 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |    3 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |  120 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  401 ++-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |    4 +-
 drivers/net/geneve.c                               |    2 +-
 drivers/net/gtp.c                                  |    2 +-
 drivers/net/hamradio/bpqether.c                    |    2 +-
 drivers/net/hyperv/hyperv_net.h                    |    2 +-
 drivers/net/hyperv/netvsc_bpf.c                    |    2 +-
 drivers/net/hyperv/netvsc_drv.c                    |    3 +-
 drivers/net/ipa/ipa_power.c                        |    7 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    4 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    3 +-
 drivers/net/loopback.c                             |    4 +-
 drivers/net/macsec.c                               |    4 +-
 drivers/net/macvlan.c                              |    6 +-
 drivers/net/mdio/fwnode_mdio.c                     |    3 +-
 drivers/net/mdio/mdio-mux-mmioreg.c                |   54 +-
 drivers/net/mdio/of_mdio.c                         |    5 +-
 drivers/net/net_failover.c                         |    4 +-
 drivers/net/netconsole.c                           |  192 +-
 drivers/net/netkit.c                               |    7 +-
 drivers/net/nlmon.c                                |    4 +-
 drivers/net/phy/Kconfig                            |   11 +
 drivers/net/phy/Makefile                           |    4 +-
 drivers/net/phy/ax88796b_rust.rs                   |    7 +-
 drivers/net/phy/dp83td510.c                        |  119 +-
 drivers/net/phy/dp83tg720.c                        |  154 ++
 drivers/net/phy/marvell-88x2222.c                  |    2 +
 drivers/net/phy/marvell.c                          |    2 +
 drivers/net/phy/marvell10g.c                       |    2 +
 drivers/net/phy/microchip_t1.c                     |  990 +++++++-
 drivers/net/phy/microchip_t1s.c                    |   30 +
 drivers/net/phy/motorcomm.c                        |  684 ++++-
 drivers/net/phy/open_alliance_helpers.c            |   77 +
 drivers/net/phy/open_alliance_helpers.h            |   47 +
 drivers/net/phy/phy.c                              |   22 +-
 drivers/net/phy/phy_device.c                       |  106 +-
 drivers/net/phy/phy_link_topology.c                |  105 +
 drivers/net/phy/phylink.c                          |   45 +-
 drivers/net/phy/qcom/at803x.c                      |    2 +
 drivers/net/phy/qcom/qca807x.c                     |   12 +-
 drivers/net/phy/qcom/qca83xx.c                     |   10 +-
 drivers/net/phy/qt2025.rs                          |  103 +
 drivers/net/phy/sfp-bus.c                          |   26 +-
 drivers/net/phy/vitesse.c                          |  183 ++
 drivers/net/ppp/ppp_generic.c                      |    2 +-
 drivers/net/pse-pd/tps23881.c                      |   21 +
 drivers/net/rionet.c                               |    2 +-
 drivers/net/sungem_phy.c                           |   35 +-
 drivers/net/team/team_core.c                       |    8 +-
 drivers/net/tun.c                                  |    5 +-
 drivers/net/usb/cdc_ether.c                        |    3 +-
 drivers/net/veth.c                                 |    3 +-
 drivers/net/virtio_net.c                           |   78 +-
 drivers/net/vrf.c                                  |    7 +-
 drivers/net/vsockmon.c                             |    4 +-
 drivers/net/vxlan/vxlan_core.c                     |   10 +-
 drivers/net/wireguard/device.c                     |    2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |    4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/core.h             |    9 +-
 drivers/net/wireless/ath/ath11k/dp.h               |   23 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   12 +
 drivers/net/wireless/ath/ath11k/wmi.c              |    6 +-
 drivers/net/wireless/ath/ath12k/core.h             |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  354 +++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  126 +
 drivers/net/wireless/ath/ath12k/dp.h               |   12 -
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    2 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    6 +
 drivers/net/wireless/ath/ath12k/hw.h               |    1 +
 drivers/net/wireless/ath/ath12k/mac.c              |   59 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    3 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |    3 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    3 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |    8 +-
 drivers/net/wireless/ath/ath9k/calib.c             |    7 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    6 +-
 drivers/net/wireless/ath/ath9k/dfs.c               |    2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c         |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    6 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 -
 drivers/net/wireless/ath/ath9k/hw.c                |    6 +-
 drivers/net/wireless/broadcom/b43/tables_lpphy.c   |   20 +-
 drivers/net/wireless/broadcom/b43/tables_lpphy.h   |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |    2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   32 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |   40 +-
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         |    8 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |   22 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    6 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |   46 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945.h         |    6 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/commands.h     |  273 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |   29 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   13 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    4 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   87 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   79 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   46 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   16 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   31 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   30 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    2 -
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |   10 +
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |   58 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |   83 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    5 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   93 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   73 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   12 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   48 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   90 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   64 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |    4 +-
 drivers/net/wireless/marvell/libertas/cmd.h        |    5 -
 .../net/wireless/marvell/libertas_tf/libertas_tf.h |    3 -
 drivers/net/wireless/marvell/mwifiex/11h.c         |   11 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |    2 -
 drivers/net/wireless/marvell/mwifiex/11n.h         |    4 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   23 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  426 +++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   29 +-
 drivers/net/wireless/marvell/mwifiex/decl.h        |   23 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |   57 +-
 drivers/net/wireless/marvell/mwifiex/init.c        |   73 +-
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    5 +
 drivers/net/wireless/marvell/mwifiex/join.c        |   69 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |   76 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |   49 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   11 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h        |    2 +
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c |    2 +
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |   36 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    5 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c      |    9 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |  202 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |    7 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |  104 +
 drivers/net/wireless/marvell/mwifiex/wmm.c         |    7 -
 drivers/net/wireless/marvell/mwl8k.c               |    3 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   66 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |   20 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |    1 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   41 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   27 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    1 +
 .../net/wireless/mediatek/mt76/mt7615/testmode.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    1 +
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |    7 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   11 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   10 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   30 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   28 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |   21 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h |    2 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |    1 +
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    3 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   37 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |  154 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   56 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    6 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   36 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   89 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   37 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   62 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |    4 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   20 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |   12 +-
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig      |    5 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    6 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |    1 +
 drivers/net/wireless/realtek/rtw88/coex.c          |   38 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |  303 ++-
 drivers/net/wireless/realtek/rtw88/debug.h         |    3 +
 drivers/net/wireless/realtek/rtw88/fw.c            |   13 +-
 drivers/net/wireless/realtek/rtw88/hci.h           |    7 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   13 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   53 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   20 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |   17 +
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |    2 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |   24 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |   41 +
 drivers/net/wireless/realtek/rtw88/rx.h            |   15 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +
 drivers/net/wireless/realtek/rtw88/tx.c            |   11 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |    1 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  209 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |   16 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    8 +
 drivers/net/wireless/realtek/rtw89/cam.c           |   12 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  196 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    6 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  510 +++-
 drivers/net/wireless/realtek/rtw89/coex.h          |   12 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  314 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  191 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  187 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |    2 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  511 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  159 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   51 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   12 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   35 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   74 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    8 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    7 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   89 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  138 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h  |   18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   55 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h      |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |  292 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h  |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   42 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   29 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |   24 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |  211 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |   20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  848 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |  418 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   23 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   93 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   52 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  264 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h  |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  151 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |    8 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |    2 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   67 +-
 drivers/net/wireless/realtek/rtw89/util.h          |   18 +
 drivers/net/wireless/realtek/rtw89/wow.c           |  350 ++-
 drivers/net/wireless/realtek/rtw89/wow.h           |   23 +
 drivers/net/wireless/rsi/rsi_debugfs.h             |    1 -
 drivers/net/wireless/ti/wl18xx/event.c             |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    4 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |   47 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h             |    9 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |   53 +-
 drivers/net/wwan/t7xx/t7xx_pci.h                   |    3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c            |    1 -
 drivers/net/wwan/t7xx/t7xx_port_trace.c            |    1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c         |   34 +-
 drivers/net/xen-netback/hash.c                     |    5 +-
 drivers/nfc/pn533/usb.c                            |    1 -
 drivers/ptp/ptp_chardev.c                          |    8 +-
 drivers/ptp/ptp_idt82p33.c                         |    8 +-
 drivers/ptp/ptp_ines.c                             |    4 -
 drivers/ptp/ptp_ocp.c                              |   20 +-
 drivers/scsi/fcoe/fcoe.c                           |    4 +-
 drivers/staging/octeon/ethernet.c                  |    2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |    2 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |    2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |    2 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    2 +-
 drivers/vhost/vsock.c                              |    4 +-
 drivers/virtio/virtio.c                            |   59 +-
 include/linux/avf/virtchnl.h                       |   13 +-
 include/linux/dpll.h                               |   15 +
 include/linux/etherdevice.h                        |    2 +-
 include/linux/ethtool.h                            |    7 +-
 include/linux/ethtool_netlink.h                    |   29 +-
 include/linux/filter.h                             |    4 +-
 include/linux/if_rmnet.h                           |    2 +-
 include/linux/ipv6.h                               |    1 +
 include/linux/linkmode.h                           |    5 +-
 include/linux/mii.h                                |    7 +-
 include/linux/mlx5/device.h                        |    8 +-
 include/linux/mlx5/driver.h                        |    2 +
 include/linux/mlx5/fs.h                            |    3 +
 include/linux/mlx5/mlx5_ifc.h                      |  243 +-
 include/linux/mlx5/qp.h                            |    1 +
 include/linux/mv643xx.h                            |  921 -------
 include/linux/netdev_features.h                    |   16 +-
 include/linux/netdevice.h                          |  131 +-
 include/linux/netpoll.h                            |    1 +
 include/linux/oa_tc6.h                             |   24 +
 include/linux/phy.h                                |    6 +
 include/linux/phy_link_topology.h                  |   82 +
 include/linux/phylink.h                            |    2 +
 include/linux/platform_data/microchip-ksz.h        |    4 +-
 include/linux/ptp_clock_kernel.h                   |   36 +-
 include/linux/rfkill.h                             |    5 +-
 include/linux/sfp.h                                |    8 +-
 include/linux/skbuff.h                             |   64 +-
 include/linux/skbuff_ref.h                         |    9 +-
 include/linux/socket.h                             |    1 +
 include/linux/stmmac.h                             |   29 +-
 include/linux/sungem_phy.h                         |    2 +-
 include/linux/virtio.h                             |   11 +-
 include/linux/virtio_vsock.h                       |    6 +
 include/net/addrconf.h                             |   16 +-
 include/net/af_vsock.h                             |    3 +
 include/net/bluetooth/hci.h                        |    5 +
 include/net/bluetooth/hci_core.h                   |    4 +-
 include/net/bluetooth/l2cap.h                      |    4 -
 include/net/bond_3ad.h                             |    5 +-
 include/net/bond_alb.h                             |    2 +-
 include/net/busy_poll.h                            |    2 +-
 include/net/caif/caif_layer.h                      |    4 +-
 include/net/caif/cfpkt.h                           |    2 +-
 include/net/cfg80211.h                             |   25 +-
 include/net/dropreason-core.h                      |    6 +-
 include/net/dst.h                                  |    2 +-
 include/net/dst_cache.h                            |    2 +-
 include/net/dst_metadata.h                         |    7 +-
 include/net/erspan.h                               |    4 +-
 include/net/hwbm.h                                 |    4 +-
 include/net/inet6_hashtables.h                     |   14 +-
 include/net/inet_hashtables.h                      |   10 +-
 include/net/inet_sock.h                            |    3 +-
 include/net/inet_timewait_sock.h                   |    2 +-
 include/net/ip.h                                   |   10 +-
 include/net/ip_fib.h                               |    7 +
 include/net/ip_tunnels.h                           |    2 +-
 include/net/ipv6.h                                 |   16 +-
 include/net/ipv6_stubs.h                           |    2 +-
 include/net/iucv/iucv.h                            |    2 +-
 include/net/iw_handler.h                           |   12 +-
 include/net/lib80211.h                             |    8 +-
 include/net/libeth/tx.h                            |  129 +
 include/net/libeth/types.h                         |   25 +
 include/net/llc_pdu.h                              |    2 +-
 include/net/mac80211.h                             |   45 +-
 include/net/mac802154.h                            |    4 +-
 include/net/mana/mana.h                            |   23 +-
 include/net/mptcp.h                                |    4 +
 include/net/ndisc.h                                |   15 -
 include/net/net_namespace.h                        |    4 +-
 include/net/netdev_rx_queue.h                      |    7 +-
 include/net/netfilter/nf_conntrack_count.h         |    6 +-
 include/net/netfilter/nf_tables.h                  |   48 +-
 include/net/netfilter/nf_tproxy.h                  |    1 +
 include/net/netfilter/nft_fib.h                    |    4 +-
 include/net/netfilter/nft_meta.h                   |    3 +-
 include/net/netfilter/nft_reject.h                 |    3 +-
 include/net/netlabel.h                             |    2 +-
 include/net/netlink.h                              |   16 +-
 include/net/netmem.h                               |  132 +-
 include/net/netns/ipv4.h                           |    5 +-
 include/net/netns/sctp.h                           |    4 +-
 include/net/nexthop.h                              |    4 +-
 include/net/nfc/nci.h                              |    2 +-
 include/net/nfc/nfc.h                              |    8 +-
 include/net/nl802154.h                             |    2 +-
 include/net/page_pool/helpers.h                    |   39 +-
 include/net/page_pool/types.h                      |   23 +-
 include/net/pkt_cls.h                              |    2 +-
 include/net/red.h                                  |    8 +-
 include/net/regulatory.h                           |    2 +-
 include/net/route.h                                |    5 +-
 include/net/rstreason.h                            |   39 +
 include/net/sctp/sctp.h                            |    2 +-
 include/net/sctp/structs.h                         |   20 +-
 include/net/sock.h                                 |    6 +-
 include/net/sock_reuseport.h                       |    2 +-
 include/net/tcp.h                                  |    3 +-
 include/net/udp.h                                  |   16 +-
 include/net/x25.h                                  |    2 +-
 include/net/xfrm.h                                 |   45 +-
 include/trace/events/page_pool.h                   |   12 +-
 include/trace/events/tcp.h                         |   12 +-
 include/uapi/asm-generic/socket.h                  |    6 +
 include/uapi/linux/bpf.h                           |    3 +-
 include/uapi/linux/dpll.h                          |    3 +
 include/uapi/linux/ethtool.h                       |   16 +
 include/uapi/linux/ethtool_netlink.h               |   36 +
 include/uapi/linux/fib_rules.h                     |    1 +
 include/uapi/linux/if_packet.h                     |    7 +-
 include/uapi/linux/in.h                            |    2 +-
 include/uapi/linux/inet_diag.h                     |    2 +-
 include/uapi/linux/ioam6_iptunnel.h                |    6 +
 include/uapi/linux/libc-compat.h                   |   36 -
 include/uapi/linux/mdio.h                          |    1 +
 include/uapi/linux/net_tstamp.h                    |    3 +-
 include/uapi/linux/netdev.h                        |   13 +
 include/uapi/linux/netfilter/nf_tables.h           |    2 +-
 include/uapi/linux/nexthop.h                       |   10 +-
 include/uapi/linux/pkt_cls.h                       |   19 +-
 include/uapi/linux/ptp_clock.h                     |   24 +-
 include/uapi/linux/smc.h                           |    6 +
 include/uapi/linux/uio.h                           |   18 +
 kernel/bpf/btf.c                                   |    3 +
 kernel/bpf/cpumap.c                                |    6 +-
 kernel/bpf/verifier.c                              |   36 +-
 lib/test_bpf.c                                     |    3 +-
 net/6lowpan/ndisc.c                                |    6 -
 net/8021q/vlan_dev.c                               |   10 +-
 net/8021q/vlanproc.c                               |    4 +-
 net/Kconfig                                        |    6 +
 net/batman-adv/soft-interface.c                    |    5 +-
 net/bluetooth/cmtp/Kconfig                         |    4 +-
 net/bluetooth/cmtp/capi.c                          |   32 +-
 net/bluetooth/hci_conn.c                           |    7 +-
 net/bluetooth/hci_sync.c                           |    5 +-
 net/bluetooth/leds.c                               |    2 +-
 net/bluetooth/mgmt.c                               |   13 +-
 net/bridge/br_device.c                             |    6 +-
 net/bridge/br_netfilter_hooks.c                    |    3 +-
 net/bridge/netfilter/ebtables.c                    |    2 +-
 net/bridge/netfilter/nft_meta_bridge.c             |    7 +-
 net/bridge/netfilter/nft_reject_bridge.c           |    3 +-
 net/caif/cfpkt_skbuff.c                            |    6 +-
 net/caif/chnl_net.c                                |    2 -
 net/can/bcm.c                                      |    4 +-
 net/can/j1939/transport.c                          |    8 +-
 net/core/Makefile                                  |    2 +
 net/core/datagram.c                                |    6 +
 net/core/dev.c                                     |   89 +-
 net/core/dev_addr_lists.c                          |    6 +-
 net/core/dev_ioctl.c                               |    9 +-
 net/core/devmem.c                                  |  389 +++
 net/core/devmem.h                                  |  180 ++
 net/core/fib_rules.c                               |    9 +-
 net/core/filter.c                                  |   25 +-
 net/core/gro.c                                     |    5 +-
 net/core/lwt_bpf.c                                 |    3 +-
 net/core/mp_dmabuf_devmem.h                        |   44 +
 net/core/neighbour.c                               |    3 +-
 net/core/net-sysfs.c                               |   13 +-
 net/core/net_namespace.c                           |   86 +-
 net/core/netdev-genl-gen.c                         |   23 +
 net/core/netdev-genl-gen.h                         |    6 +
 net/core/netdev-genl.c                             |  147 +-
 net/core/netdev_rx_queue.c                         |   81 +
 net/core/netmem_priv.h                             |   31 +
 net/core/netpoll.c                                 |   44 +-
 net/core/page_pool.c                               |  119 +-
 net/core/page_pool_priv.h                          |   46 +
 net/core/page_pool_user.c                          |   32 +-
 net/core/pktgen.c                                  |   10 +-
 net/core/rtnetlink.c                               |    5 +-
 net/core/skbuff.c                                  |  136 +-
 net/core/skmsg.c                                   |    2 +-
 net/core/sock.c                                    |   74 +-
 net/core/sock_map.c                                |    1 +
 net/core/sock_reuseport.c                          |    5 +-
 net/core/utils.c                                   |    2 +-
 net/dsa/tag_ksz.c                                  |   11 +-
 net/dsa/user.c                                     |    3 +-
 net/ethtool/Makefile                               |    3 +-
 net/ethtool/cabletest.c                            |   59 +-
 net/ethtool/channels.c                             |   20 +-
 net/ethtool/cmis.h                                 |    1 -
 net/ethtool/cmis_cdb.c                             |   14 +-
 net/ethtool/common.c                               |   65 +-
 net/ethtool/common.h                               |    7 +-
 net/ethtool/ioctl.c                                |   44 +-
 net/ethtool/linkinfo.c                             |    2 +-
 net/ethtool/linkmodes.c                            |    2 +-
 net/ethtool/netlink.c                              |   68 +-
 net/ethtool/netlink.h                              |   37 +-
 net/ethtool/phy.c                                  |  306 +++
 net/ethtool/plca.c                                 |   30 +-
 net/ethtool/pse-pd.c                               |   38 +-
 net/ethtool/rss.c                                  |  233 +-
 net/ethtool/strset.c                               |   27 +-
 net/handshake/netlink.c                            |    4 +-
 net/hsr/hsr_device.c                               |   46 +-
 net/hsr/hsr_forward.c                              |    4 +-
 net/hsr/hsr_main.h                                 |    5 +-
 net/hsr/hsr_netlink.c                              |    2 +-
 net/hsr/hsr_slave.c                                |   11 +-
 net/ieee802154/6lowpan/core.c                      |    2 +-
 net/ieee802154/core.c                              |   10 +-
 net/ipv4/Kconfig                                   |    3 +-
 net/ipv4/devinet.c                                 |   53 +-
 net/ipv4/esp4.c                                    |    3 +-
 net/ipv4/fib_frontend.c                            |    4 +-
 net/ipv4/fib_rules.c                               |   54 +-
 net/ipv4/fib_semantics.c                           |    6 +-
 net/ipv4/fib_trie.c                                |    3 +-
 net/ipv4/icmp.c                                    |  119 +-
 net/ipv4/inet_connection_sock.c                    |    2 +-
 net/ipv4/inet_diag.c                               |    4 +-
 net/ipv4/inet_hashtables.c                         |   12 +-
 net/ipv4/ip_gre.c                                  |    7 +-
 net/ipv4/ip_input.c                                |    6 +-
 net/ipv4/ip_output.c                               |    5 +-
 net/ipv4/ip_tunnel.c                               |   15 +-
 net/ipv4/ip_vti.c                                  |    2 +-
 net/ipv4/ipip.c                                    |    2 +-
 net/ipv4/ipmr.c                                    |   12 +-
 net/ipv4/netfilter.c                               |    3 +-
 net/ipv4/netfilter/arp_tables.c                    |    4 +-
 net/ipv4/netfilter/ip_tables.c                     |    4 +-
 net/ipv4/netfilter/ipt_rpfilter.c                  |    3 +-
 net/ipv4/netfilter/nf_dup_ipv4.c                   |    3 +-
 net/ipv4/netfilter/nft_dup_ipv4.c                  |    4 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    5 +-
 net/ipv4/nexthop.c                                 |   55 +-
 net/ipv4/route.c                                   |   16 +-
 net/ipv4/sysctl_net_ipv4.c                         |   32 +-
 net/ipv4/tcp.c                                     |  291 ++-
 net/ipv4/tcp_bpf.c                                 |    4 +-
 net/ipv4/tcp_htcp.c                                |    2 +-
 net/ipv4/tcp_input.c                               |   13 +-
 net/ipv4/tcp_ipv4.c                                |   23 +-
 net/ipv4/tcp_metrics.c                             |   10 +-
 net/ipv4/tcp_minisocks.c                           |   33 +-
 net/ipv4/tcp_output.c                              |    7 +-
 net/ipv4/tcp_timer.c                               |    7 +-
 net/ipv4/udp.c                                     |   11 +-
 net/ipv4/udp_tunnel_core.c                         |    3 +-
 net/ipv6/addrconf.c                                |   26 +-
 net/ipv6/af_inet6.c                                |    1 +
 net/ipv6/esp6.c                                    |    3 +-
 net/ipv6/fib6_rules.c                              |   43 +-
 net/ipv6/icmp.c                                    |   28 +-
 net/ipv6/inet6_hashtables.c                        |   15 +-
 net/ipv6/ioam6_iptunnel.c                          |   86 +-
 net/ipv6/ip6_gre.c                                 |    7 +-
 net/ipv6/ip6_input.c                               |    6 +-
 net/ipv6/ip6_tunnel.c                              |   11 +-
 net/ipv6/ip6mr.c                                   |    5 +-
 net/ipv6/ipv6_sockglue.c                           |    4 +-
 net/ipv6/mcast.c                                   |    5 +-
 net/ipv6/ndisc.c                                   |    6 +-
 net/ipv6/netfilter/ip6_tables.c                    |    2 +-
 net/ipv6/netfilter/nft_dup_ipv6.c                  |    4 +-
 net/ipv6/route.c                                   |    8 +-
 net/ipv6/rpl_iptunnel.c                            |   12 +-
 net/ipv6/sit.c                                     |   11 +-
 net/ipv6/tcp_ipv6.c                                |    5 +-
 net/ipv6/udp.c                                     |    8 +-
 net/l2tp/l2tp_core.c                               |  382 ++-
 net/l2tp/l2tp_core.h                               |   25 +-
 net/l2tp/l2tp_debugfs.c                            |   24 +-
 net/l2tp/l2tp_eth.c                                |   44 +-
 net/l2tp/l2tp_ip.c                                 |  125 +-
 net/l2tp/l2tp_ip6.c                                |  123 +-
 net/l2tp/l2tp_netlink.c                            |   76 +-
 net/l2tp/l2tp_ppp.c                                |  154 +-
 net/mac80211/agg-rx.c                              |   15 +-
 net/mac80211/agg-tx.c                              |   15 +-
 net/mac80211/airtime.c                             |  140 +-
 net/mac80211/cfg.c                                 |   51 +-
 net/mac80211/chan.c                                |    5 +-
 net/mac80211/ht.c                                  |   15 +-
 net/mac80211/ieee80211_i.h                         |   33 +-
 net/mac80211/iface.c                               |   25 +-
 net/mac80211/link.c                                |   12 +
 net/mac80211/main.c                                |    6 +-
 net/mac80211/mesh_pathtbl.c                        |    2 +-
 net/mac80211/mlme.c                                |   45 +-
 net/mac80211/offchannel.c                          |    1 +
 net/mac80211/pm.c                                  |    2 +-
 net/mac80211/rate.c                                |    2 +-
 net/mac80211/scan.c                                |   16 +-
 net/mac80211/status.c                              |    1 +
 net/mac80211/tx.c                                  |    2 +-
 net/mac80211/util.c                                |  100 +-
 net/mctp/af_mctp.c                                 |    3 +
 net/mpls/af_mpls.c                                 |    6 +-
 net/mpls/mpls_iptunnel.c                           |    2 +-
 net/mptcp/ctrl.c                                   |  133 +
 net/mptcp/mib.c                                    |    7 +
 net/mptcp/mib.h                                    |    7 +
 net/mptcp/pm.c                                     |   11 -
 net/mptcp/pm_netlink.c                             |   78 +-
 net/mptcp/pm_userspace.c                           |   40 +-
 net/mptcp/protocol.c                               |   18 +-
 net/mptcp/protocol.h                               |   33 +-
 net/mptcp/subflow.c                                |   54 +-
 net/netfilter/core.c                               |    4 +-
 net/netfilter/nf_conncount.c                       |   15 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_netlink.c               |    9 +-
 net/netfilter/nf_nat_core.c                        |    2 +-
 net/netfilter/nf_tables_api.c                      |  201 +-
 net/netfilter/nf_tables_core.c                     |    2 +-
 net/netfilter/nfnetlink.c                          |   14 +-
 net/netfilter/nfnetlink_queue.c                    |   12 +-
 net/netfilter/nft_bitwise.c                        |    4 +-
 net/netfilter/nft_byteorder.c                      |    2 +-
 net/netfilter/nft_cmp.c                            |    6 +-
 net/netfilter/nft_compat.c                         |    6 +-
 net/netfilter/nft_counter.c                        |   90 +-
 net/netfilter/nft_ct.c                             |    2 +-
 net/netfilter/nft_dup_netdev.c                     |    2 +-
 net/netfilter/nft_dynset.c                         |   22 +-
 net/netfilter/nft_exthdr.c                         |    2 +-
 net/netfilter/nft_fib.c                            |    3 +-
 net/netfilter/nft_flow_offload.c                   |    6 +-
 net/netfilter/nft_fwd_netdev.c                     |    9 +-
 net/netfilter/nft_hash.c                           |    2 +-
 net/netfilter/nft_immediate.c                      |    3 +-
 net/netfilter/nft_lookup.c                         |    5 +-
 net/netfilter/nft_masq.c                           |    7 +-
 net/netfilter/nft_meta.c                           |    8 +-
 net/netfilter/nft_nat.c                            |   11 +-
 net/netfilter/nft_objref.c                         |    2 +-
 net/netfilter/nft_osf.c                            |    3 +-
 net/netfilter/nft_payload.c                        |    2 +-
 net/netfilter/nft_queue.c                          |    5 +-
 net/netfilter/nft_range.c                          |    2 +-
 net/netfilter/nft_redir.c                          |    7 +-
 net/netfilter/nft_reject.c                         |    3 +-
 net/netfilter/nft_reject_inet.c                    |    3 +-
 net/netfilter/nft_reject_netdev.c                  |    3 +-
 net/netfilter/nft_rt.c                             |    3 +-
 net/netfilter/nft_socket.c                         |    7 +-
 net/netfilter/nft_synproxy.c                       |    3 +-
 net/netfilter/nft_tproxy.c                         |    7 +-
 net/netfilter/nft_xfrm.c                           |    3 +-
 net/netfilter/xt_connlimit.c                       |   15 +-
 net/netlink/af_netlink.h                           |    1 -
 net/netrom/nr_route.c                              |    4 +-
 net/openvswitch/actions.c                          |    8 +-
 net/openvswitch/conntrack.c                        |   35 +-
 net/openvswitch/datapath.h                         |    3 -
 net/openvswitch/flow_netlink.c                     |    2 +-
 net/openvswitch/vport-internal_dev.c               |   11 +-
 net/packet/af_packet.c                             |    4 +-
 net/rds/Kconfig                                    |    9 +
 net/rds/Makefile                                   |    5 +
 net/rds/ib.h                                       |    4 -
 net/rfkill/core.c                                  |    8 +-
 net/rfkill/rfkill-gpio.c                           |   18 +
 net/rxrpc/ar-internal.h                            |    2 -
 net/sched/act_ct.c                                 |    4 +-
 net/sched/act_vlan.c                               |    1 +
 net/sched/sch_cake.c                               |   53 +-
 net/sched/sch_taprio.c                             |    4 +-
 net/sctp/protocol.c                                |    3 +-
 net/smc/af_smc.c                                   |    8 -
 net/smc/smc_clc.h                                  |    4 +
 net/smc/smc_core.c                                 |   72 +-
 net/smc/smc_core.h                                 |    2 +
 net/smc/smc_loopback.h                             |    1 -
 net/smc/smc_pnet.c                                 |    3 -
 net/smc/smc_stats.c                                |    6 +
 net/smc/smc_stats.h                                |   28 +-
 net/smc/smc_sysctl.c                               |   11 +
 net/socket.c                                       |   10 +-
 net/tipc/bcast.c                                   |    2 +-
 net/tipc/bearer.c                                  |   10 +-
 net/tipc/monitor.c                                 |    2 +-
 net/tipc/socket.c                                  |    6 +-
 net/tls/tls_sw.c                                   |    2 +-
 net/unix/af_unix.c                                 |   92 +-
 net/unix/garbage.c                                 |   16 +-
 net/vmw_vsock/af_vsock.c                           |   58 +-
 net/vmw_vsock/virtio_transport.c                   |    4 +-
 net/vmw_vsock/virtio_transport_common.c            |   35 +
 net/vmw_vsock/vsock_loopback.c                     |    6 +
 net/wireless/core.c                                |   10 +-
 net/wireless/core.h                                |    8 +
 net/wireless/ibss.c                                |    2 +-
 net/wireless/lib80211.c                            |   10 +-
 net/wireless/lib80211_crypt_ccmp.c                 |    2 +-
 net/wireless/lib80211_crypt_tkip.c                 |    2 +-
 net/wireless/lib80211_crypt_wep.c                  |    2 +-
 net/wireless/mesh.c                                |    2 +-
 net/wireless/mlme.c                                |   20 +-
 net/wireless/nl80211.c                             |   77 +-
 net/wireless/rdev-ops.h                            |   13 +-
 net/wireless/reg.c                                 |   19 +-
 net/wireless/scan.c                                |   45 +-
 net/wireless/sme.c                                 |    3 +-
 net/wireless/trace.h                               |   40 +-
 net/wireless/util.c                                |   14 +-
 net/xdp/xsk_buff_pool.c                            |   44 +-
 net/xdp/xsk_queue.h                                |    5 -
 net/xfrm/xfrm_device.c                             |    6 +-
 net/xfrm/xfrm_interface_core.c                     |    2 +-
 net/xfrm/xfrm_policy.c                             |  225 +-
 rust/kernel/lib.rs                                 |    1 +
 rust/kernel/net/phy.rs                             |   90 +-
 rust/kernel/net/phy/reg.rs                         |  224 ++
 rust/kernel/sizes.rs                               |   26 +
 rust/uapi/uapi_helper.h                            |    1 +
 tools/include/uapi/linux/bpf.h                     |    3 +-
 tools/include/uapi/linux/netdev.h                  |   13 +
 tools/net/ynl/lib/.gitignore                       |    1 +
 tools/net/ynl/lib/ynl.c                            |    4 +-
 tools/net/ynl/samples/netdev.c                     |    6 +-
 tools/net/ynl/ynl-gen-c.py                         |    6 +-
 tools/testing/selftests/Makefile                   |    6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod-events.h |    6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |    2 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   37 +-
 .../selftests/bpf/prog_tests/flow_dissector.c      |   12 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c      |   47 +
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   28 +-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  149 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |  117 +-
 .../selftests/bpf/prog_tests/tp_btf_nullable.c     |   14 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   25 +
 tools/testing/selftests/bpf/progs/dynptr_success.c |   23 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c |   26 +-
 .../bpf/progs/test_tcp_custom_syncookie.c          |   11 +-
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |   24 +
 tools/testing/selftests/bpf/xskxceiver.c           |   43 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    1 -
 tools/testing/selftests/drivers/net/Makefile       |    5 +-
 tools/testing/selftests/drivers/net/config         |    4 +
 .../selftests/drivers/net/hw/pp_alloc_fail.py      |    3 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   80 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |    5 +-
 .../testing/selftests/drivers/net/netcons_basic.sh |  234 ++
 tools/testing/selftests/drivers/net/stats.py       |   33 +-
 tools/testing/selftests/kselftest/runner.sh        |    7 +-
 tools/testing/selftests/net/.gitignore             |    2 +
 tools/testing/selftests/net/Makefile               |   12 +-
 tools/testing/selftests/net/af_unix/msg_oob.c      |   23 +
 tools/testing/selftests/net/fcnal-test.sh          |    9 +-
 tools/testing/selftests/net/fib_nexthops.sh        |   55 +-
 tools/testing/selftests/net/fib_rule_tests.sh      |  306 ++-
 tools/testing/selftests/net/forwarding/README      |    2 +-
 .../net/forwarding/custom_multipath_hash.sh        |    8 +-
 .../net/forwarding/gre_custom_multipath_hash.sh    |    8 +-
 .../net/forwarding/ip6gre_custom_multipath_hash.sh |    8 +-
 tools/testing/selftests/net/forwarding/lib.sh      |    7 +
 .../selftests/net/forwarding/router_mpath_nh.sh    |   40 +-
 .../net/forwarding/router_mpath_nh_lib.sh          |   13 +
 .../net/forwarding/router_mpath_nh_res.sh          |   58 +-
 .../selftests/net/forwarding/router_multipath.sh   |    2 +
 .../testing/selftests/net/forwarding/tc_actions.sh |   46 +-
 tools/testing/selftests/net/lib.sh                 |   15 +
 tools/testing/selftests/net/lib/py/ksft.py         |   60 +-
 tools/testing/selftests/net/mptcp/diag.sh          |    2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   17 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  353 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   17 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |    2 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |   10 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |    1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |    1 +
 tools/testing/selftests/net/ncdevmem.c             |  570 +++++
 tools/testing/selftests/net/netdevice.sh           |   60 +-
 tools/testing/selftests/net/netfilter/config       |    2 +
 tools/testing/selftests/net/netfilter/nft_queue.sh |  129 +-
 tools/testing/selftests/net/packetdrill/Makefile   |   10 +
 tools/testing/selftests/net/packetdrill/config     |   11 +
 .../testing/selftests/net/packetdrill/defaults.sh  |   63 +
 .../selftests/net/packetdrill/ksft_runner.sh       |   41 +
 .../selftests/net/packetdrill/set_sysctls.py       |   38 +
 .../selftests/net/packetdrill/tcp_inq_client.pkt   |   51 +
 .../selftests/net/packetdrill/tcp_inq_server.pkt   |   51 +
 .../packetdrill/tcp_md5_md5-only-on-client-ack.pkt |   28 +
 .../tcp_slow_start_slow-start-ack-per-1pkt.pkt     |   56 +
 ...low_start_slow-start-ack-per-2pkt-send-5pkt.pkt |   33 +
 ...low_start_slow-start-ack-per-2pkt-send-6pkt.pkt |   34 +
 .../tcp_slow_start_slow-start-ack-per-2pkt.pkt     |   42 +
 .../tcp_slow_start_slow-start-ack-per-4pkt.pkt     |   35 +
 .../tcp_slow_start_slow-start-after-idle.pkt       |   39 +
 .../tcp_slow_start_slow-start-after-win-update.pkt |   50 +
 ..._start_slow-start-app-limited-9-packets-out.pkt |   38 +
 .../tcp_slow_start_slow-start-app-limited.pkt      |   36 +
 .../tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt  |   63 +
 .../net/packetdrill/tcp_zerocopy_basic.pkt         |   55 +
 .../net/packetdrill/tcp_zerocopy_batch.pkt         |   41 +
 .../net/packetdrill/tcp_zerocopy_client.pkt        |   30 +
 .../net/packetdrill/tcp_zerocopy_closed.pkt        |   44 +
 .../net/packetdrill/tcp_zerocopy_epoll_edge.pkt    |   61 +
 .../packetdrill/tcp_zerocopy_epoll_exclusive.pkt   |   63 +
 .../net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt |   66 +
 .../packetdrill/tcp_zerocopy_fastopen-client.pkt   |   56 +
 .../packetdrill/tcp_zerocopy_fastopen-server.pkt   |   44 +
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt      |  118 +
 .../net/packetdrill/tcp_zerocopy_small.pkt         |   57 +
 tools/testing/selftests/net/pmtu.sh                |   10 +-
 tools/testing/selftests/net/psock_fanout.c         |    6 +-
 tools/testing/selftests/net/rds/Makefile           |   12 +
 tools/testing/selftests/net/rds/README.txt         |   41 +
 tools/testing/selftests/net/rds/config.sh          |   53 +
 tools/testing/selftests/net/rds/run.sh             |  224 ++
 tools/testing/selftests/net/rds/test.py            |  262 ++
 tools/testing/selftests/net/rxtimestamp.c          |   18 +
 tools/testing/selftests/net/sk_so_peek_off.c       |  202 ++
 tools/testing/selftests/net/tcp_ao/Makefile        |    3 +-
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |    2 +-
 tools/testing/selftests/net/tcp_ao/config          |    1 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |   25 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |    6 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |    2 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |   18 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |  178 +-
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  |  559 +++++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    |  543 ++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |   31 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |   17 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |    1 -
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |   26 +
 tools/testing/selftests/net/tcp_ao/restore.c       |   30 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |    2 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |   19 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |   28 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c       |    6 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |   35 +-
 tools/testing/selftests/net/txtimestamp.c          |    6 +-
 tools/testing/selftests/net/unicast_extensions.sh  |    9 +-
 tools/testing/selftests/net/vrf_route_leaking.sh   |    3 +-
 .../testing/selftests/net/xfrm_policy_add_speed.sh |   83 +
 tools/testing/vsock/util.c                         |    6 +-
 tools/testing/vsock/util.h                         |    3 +
 tools/testing/vsock/vsock_test.c                   |   85 +
 1458 files changed, 69979 insertions(+), 13803 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
 create mode 100644 Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
 create mode 100644 Documentation/networking/devmem.rst
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/bluetooth/hci_aml.c
 create mode 100644 drivers/net/can/rockchip/Kconfig
 create mode 100644 drivers/net/can/rockchip/Makefile
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-core.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-ethtool.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-rx.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-timestamp.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-tx.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd.h
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (93%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/Makefile
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_prm.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
 create mode 100644 drivers/net/ethernet/microchip/fdma/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/fdma/Makefile
 create mode 100644 drivers/net/ethernet/microchip/fdma/fdma_api.c
 create mode 100644 drivers/net/ethernet/microchip/fdma/fdma_api.h
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c
 create mode 100644 drivers/net/phy/open_alliance_helpers.c
 create mode 100644 drivers/net/phy/open_alliance_helpers.h
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 drivers/net/phy/qt2025.rs
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c
 delete mode 100644 include/linux/mv643xx.h
 create mode 100644 include/linux/oa_tc6.h
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 include/net/libeth/tx.h
 create mode 100644 include/net/libeth/types.h
 create mode 100644 net/core/devmem.c
 create mode 100644 net/core/devmem.h
 create mode 100644 net/core/mp_dmabuf_devmem.h
 create mode 100644 net/core/netdev_rx_queue.c
 create mode 100644 net/core/netmem_priv.h
 create mode 100644 net/ethtool/phy.c
 create mode 100644 rust/kernel/net/phy/reg.rs
 create mode 100644 rust/kernel/sizes.rs
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
 create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh
 create mode 100644 tools/testing/selftests/net/ncdevmem.c
 create mode 100644 tools/testing/selftests/net/packetdrill/Makefile
 create mode 100644 tools/testing/selftests/net/packetdrill/config
 create mode 100755 tools/testing/selftests/net/packetdrill/defaults.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/ksft_runner.sh
 create mode 100755 tools/testing/selftests/net/packetdrill/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
 create mode 100644 tools/testing/selftests/net/rds/Makefile
 create mode 100644 tools/testing/selftests/net/rds/README.txt
 create mode 100755 tools/testing/selftests/net/rds/config.sh
 create mode 100755 tools/testing/selftests/net/rds/run.sh
 create mode 100644 tools/testing/selftests/net/rds/test.py
 create mode 100644 tools/testing/selftests/net/sk_so_peek_off.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
 create mode 100644 tools/testing/selftests/net/tcp_ao/lib/ftrace.c
 create mode 100755 tools/testing/selftests/net/xfrm_policy_add_speed.sh

