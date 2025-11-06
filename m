Return-Path: <netdev+bounces-236458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D066FC3C84E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA9A3BF96F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B913633F8B7;
	Thu,  6 Nov 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqtbmkhu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058E302CD0;
	Thu,  6 Nov 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446774; cv=none; b=diaIq5W7IR68IMmiPaPh+ylUcGojl5xLQjhMi3Oa3Em1J+4gEV2wjjqMZMzGvvjp7dwzF2glQxAsFZFfFQOpUrb9Pa3cOfySXr37cfw7edsmGxyPDd5d3CtLaumMAMEEfUjlmTpCQtDQmsDv52Inp+DLOEGow6NOaC9/OyyCG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446774; c=relaxed/simple;
	bh=HNaA+5yFakpB23Eg1Xm2vv3Qp1YA4+QBRNSIjQ0wOIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VLYJe/p64oMIFRoNjNeJARzggVP84Sk1R/ZqxrbNkNH6o50AZpWf08SmzBsOaJPdVwkb2BSPfmUKkxLWVz3zJhz7TKRY+XZ57gNeR9Uh3bhB9d6mMUtWKHeht2ZPkL95jo3yy12a5L69iLcEpq8dUPNLmQMlJKoizeTsiqiDWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqtbmkhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F3C116B1;
	Thu,  6 Nov 2025 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446773;
	bh=HNaA+5yFakpB23Eg1Xm2vv3Qp1YA4+QBRNSIjQ0wOIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EqtbmkhuKH4+mZ0sACZCMnksM9xb5I+QXbiGE11FQoqmvlYV9l6f3ZfxhR5uDdBJn
	 djSDj2tJNWF714xCgK8ETl2pcaysTWcT3KMWqOAsdSGkOSMHCkaBkHF2qufMVSZDV8
	 JPoiWHBZj93gXBxPPWepiSX6fIoINz/yW9eZHA95oY2zeYCOSWVbt7Nc7hh7jAoSGd
	 TpcECjkdI6/piwyFlqV5RKkp9OsBzEvWdLS9VNNDEN2qopfdq+hb70SW7W5LYSJpH4
	 viKaNQj7lwhNZStiNiBx+Hyt650Di1tWZBtU9XLDaea8xabYiEDNrcVfhNxfIFnQ63
	 2swTL05QUm5OA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.17
Date: Thu,  6 Nov 2025 08:32:52 -0800
Message-ID: <20251106163252.4143775-1-kuba@kernel.org>
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

The following changes since commit 407c114c983f6eb87161853f0fdbe4a08e394b92:

  Merge tag 'net-6.16-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-24 08:44:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.17

for you to fetch changes up to fa582ca7e187a15e772e6a72fe035f649b387a60:

  dpll: zl3073x: Fix build failure (2025-07-26 12:05:33 -0700)

----------------------------------------------------------------
Networking changes for 6.17.

Core & protocols
----------------

 - Wrap datapath globals into net_aligned_data, to avoid false sharing.

 - Preserve MSG_ZEROCOPY in forwarding (e.g. out of a container).

 - Add SO_INQ and SCM_INQ support to AF_UNIX.

 - Add SIOCINQ support to AF_VSOCK.

 - Add TCP_MAXSEG sockopt to MPTCP.

 - Add IPv6 force_forwarding sysctl to enable forwarding per interface.

 - Make TCP validation of whether packet fully fits in the receive
   window and the rcv_buf more strict. With increased use of HW
   aggregation a single "packet" can be multiple 100s of kB.

 - Add MSG_MORE flag to optimize large TCP transmissions via sockmap,
   improves latency up to 33% for sockmap users.

 - Convert TCP send queue handling from tasklet to BH workque.

 - Improve BPF iteration over TCP sockets to see each socket exactly once.

 - Remove obsolete and unused TCP RFC3517/RFC6675 loss recovery code.

 - Support enabling kernel threads for NAPI processing on per-NAPI
   instance basis rather than a whole device. Fully stop the kernel NAPI
   thread when threaded NAPI gets disabled. Previously thread would stick
   around until ifdown due to tricky synchronization.

 - Allow multicast routing to take effect on locally-generated packets.

 - Add output interface argument for End.X in segment routing.

 - MCTP: add support for gateway routing, improve bind() handling.

 - Don't require rtnl_lock when fetching an IPv6 neighbor over Netlink.

 - Add a new neighbor flag ("extern_valid"), which cedes refresh
   responsibilities to userspace. This is needed for EVPN multi-homing
   where a neighbor entry for a multi-homed host needs to be synced
   across all the VTEPs among which the host is multi-homed.

 - Support NUD_PERMANENT for proxy neighbor entries.

 - Add a new queuing discipline for IETF RFC9332 DualQ Coupled AQM.

 - Add sequence numbers to netconsole messages. Unregister netconsole's
   console when all net targets are removed. Code refactoring.
   Add a number of selftests.

 - Align IPSec inbound SA lookup to RFC 4301. Only SPI and protocol
   should be used for an inbound SA lookup.

 - Support inspecting ref_tracker state via DebugFS.

 - Don't force bonding advertisement frames tx to ~333 ms boundaries.
   Add broadcast_neighbor option to send ARP/ND on all bonded links.

 - Allow providing upcall pid for the 'execute' command in openvswitch.

 - Remove DCCP support from Netfilter's conntrack.

 - Disallow multiple packet duplications in the queuing layer.

 - Prevent use of deprecated iptables code on PREEMPT_RT.

Driver API
----------

 - Support RSS and hashing configuration over ethtool Netlink.

 - Add dedicated ethtool callbacks for getting and setting hashing fields.

 - Add support for power budget evaluation strategy in PSE /
   Power-over-Ethernet. Generate Netlink events for overcurrent etc.

 - Support DPLL phase offset monitoring across all device inputs.
   Support providing clock reference and SYNC over separate DPLL
   inputs.

 - Support traffic classes in devlink rate API for bandwidth management.

 - Remove rtnl_lock dependency from UDP tunnel port configuration.

Device drivers
--------------

 - Add a new Broadcom driver for 800G Ethernet (bnge).

 - Add a standalone driver for Microchip ZL3073x DPLL.

 - Remove IBM's NETIUCV device driver.

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
    - support zero-copy Tx of DMABUF memory
    - take page size into account for page pool recycling rings
   - Intel (100G, ice, idpf):
     - idpf: XDP and AF_XDP support preparations
     - idpf: add flow steering
     - add link_down_events statistic
     - clean up the TSPLL code
     - preparations for live VM migration
   - nVidia/Mellanox:
    - support zero-copy Rx/Tx interfaces (DMABUF and io_uring)
    - optimize context memory usage for matchers
    - expose serial numbers in devlink info
    - support PCIe congestion metrics
   - Meta (fbnic):
     - add 25G, 50G, and 100G link modes to phylink
     - support dumping FW logs
   - Marvell/Cavium:
     - support for CN20K generation of the Octeon chips
   - Amazon:
     - add HW clock (without timestamping, just hypervisor time access)

 - Ethernet virtual:
   - VirtIO net:
     - support segmentation of UDP-tunnel-encapsulated packets
   - Google (gve):
     - support packet timestamping and clock synchronization
   - Microsoft vNIC:
     - add handler for device-originated servicing events
     - allow dynamic MSI-X vector allocation
     - support Tx bandwidth clamping

 - Ethernet NICs consumer, and embedded:
   - AMD:
     - amd-xgbe: hardware timestamping and PTP clock support
   - Broadcom integrated MACs (bcmgenet, bcmasp):
     - use napi_complete_done() return value to support NAPI polling
     - add support for re-starting auto-negotiation
   - Broadcom switches (b53):
     - support BCM5325 switches
     - add bcm63xx EPHY power control
   - Synopsys (stmmac):
     - lots of code refactoring and cleanups
   - TI:
     - icssg-prueth: read firmware-names from device tree
     - icssg: PRP offload support
   - Microchip:
     - lan78xx: convert to PHYLINK for improved PHY and MAC management
     - ksz: add KSZ8463 switch support
   - Intel:
     - support similar queue priority scheme in multi-queue and
       time-sensitive networking (taprio)
     - support packet pre-emption in both
   - RealTek (r8169):
     - enable EEE at 5Gbps on RTL8126
   - Airoha:
     - add PPPoE offload support
     - MDIO bus controller for Airoha AN7583

 - Ethernet PHYs:
   - support for the IPQ5018 internal GE PHY
   - micrel KSZ9477 switch-integrated PHYs:
     - add MDI/MDI-X control support
     - add RX error counters
     - add cable test support
     - add Signal Quality Indicator (SQI) reporting
   - dp83tg720: improve reset handling and reduce link recovery time
   - support bcm54811 (and its MII-Lite interface type)
   - air_en8811h: support resume/suspend
   - support PHY counters for QCA807x and QCA808x
   - support WoL for QCA807x

 - CAN drivers:
   - rcar_canfd: support for Transceiver Delay Compensation
   - kvaser: report FW versions via devlink dev info

 - WiFi:
   - extended regulatory info support (6 GHz)
   - add statistics and beacon monitor for Multi-Link Operation (MLO)
   - support S1G aggregation, improve S1G support
   - add Radio Measurement action fields
   - support per-radio RTS threshold
   - some work around how FIPS affects wifi, which was wrong (RC4 is used
     by TKIP, not only WEP)
   - improvements for unsolicited probe response handling

 - WiFi drivers:
   - RealTek (rtw88):
     - IBSS mode for SDIO devices
   - RealTek (rtw89):
     - BT coexistence for MLO/WiFi7
     - concurrent station + P2P support
     - support for USB devices RTL8851BU/RTL8852BU
   - Intel (iwlwifi):
     - use embedded PNVM in (to be released) FW images to fix
       compatibility issues
     - many cleanups (unused FW APIs, PCIe code, WoWLAN)
     - some FIPS interoperability
   - MediaTek (mt76):
     - firmware recovery improvements
     - more MLO work
   - Qualcomm/Atheros (ath12k):
     - fix scan on multi-radio devices
     - more EHT/Wi-Fi 7 features
     - encapsulation/decapsulation offload
   - Broadcom (brcm80211):
     - support SDIO 43751 device

 - Bluetooth:
   - hci_event: add support for handling LE BIG Sync Lost event
   - ISO: add socket option to report packet seqnum via CMSG
   - ISO: support SCM_TIMESTAMPING for ISO TS

 - Bluetooth drivers:
   - intel_pcie: support Function Level Reset
   - nxpuart: add support for 4M baudrate
   - nxpuart: implement powerup sequence, reset, FW dump, and FW loading

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aakash Kumar S (1):
      xfrm: Duplicate SPI Handling

Aaradhana Sahu (6):
      wifi: ath12k: Block radio bring-up in FTM mode
      wifi: ath12k: Add a table of parameters entries impacting memory consumption
      wifi: ath12k: Remove redundant TID calculation for QCN9274
      wifi: ath12k: Refactor macros to use memory profile-based values
      wifi: ath12k: Enable memory profile selection for QCN9274
      wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode

Abdelrahman Fekry (1):
      docs: net: sysctl documentation cleanup

Abin Joseph (1):
      net: macb: Add shutdown operation support

Aditya Kumar Singh (9):
      wifi: ieee80211: add Radio Measurement action fields
      wifi: mac80211: Allow DFS/CSA on a radio if scan is ongoing on another radio
      wifi: ath12k: handle regulatory hints during mac registration
      wifi: ath12k: fix timeout while waiting for regulatory update during interface creation
      wifi: ath12k: add support for Tx Power insertion in RRM action frame
      wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
      wifi: ath12k: Add num_stations counter for each interface
      wifi: cfg80211: fix off channel operation allowed check for MLO
      wifi: mac80211: fix macro scoping in for_each_link_data

Ahelenia Ziemiańska (2):
      atm: lanai: fix "take a while" typo
      gve: global: fix "for a while" typo

Ahmed Zaki (4):
      iavf: convert to NAPI IRQ affinity API
      virtchnl2: rename enum virtchnl2_cap_rss
      idpf: add flow steering support
      idpf: preserve coalescing settings across resets

Al Viro (1):
      don't open-code kernel_accept() in rds_tcp_accept_one()

Aleksandr Loktionov (1):
      ice: add 40G speed to Admin Command GET PORT OPTION

Alex Gavin (1):
      wifi: mac80211_hwsim: Update comments in header

Alexander Duyck (8):
      net: phy: Add interface types for 50G and 100G
      fbnic: Do not consider mailbox "initialized" until we have verified fw version
      fbnic: Retire "AUTO" flags and cleanup handling of FW link settings
      fbnic: Replace link_mode with AUI
      fbnic: Update FW link mode values to represent actual link modes
      fbnic: Set correct supported modes and speeds based on FW setting
      fbnic: Add support for reporting link config
      fbnic: Add support for setting/getting pause configuration

Alexander Lobakin (17):
      libeth, libie: clean symbol exports up a little
      libeth: convert to netmem
      libeth: support native XDP and register memory model
      libeth: xdp: add XDP_TX buffers sending
      libeth: xdp: add .ndo_xdp_xmit() helpers
      libeth: xdp: add XDPSQE completion helpers
      libeth: xdp: add XDPSQ locking helpers
      libeth: xdp: add XDPSQ cleanup timers
      libeth: xdp: add helpers for preparing/processing &libeth_xdp_buff
      libeth: xdp: add XDP prog run and verdict result handling
      libeth: xdp: add templates for building driver-side callbacks
      libeth: xdp: add RSS hash hint and XDP features setup helpers
      libeth: xsk: add XSk XDP_TX sending helpers
      libeth: xsk: add XSk xmit functions
      libeth: xsk: add XSk Rx processing support
      libeth: xsk: add XSkFQ refill and XSk wakeup helpers
      libeth: xdp, xsk: access adjacent u32s as u64 where applicable

Alexander Stein (2):
      net: fman_memac: Don't use of_property_read_bool on non-boolean property managed
      net: fsl_pq_mdio: use dev_err_probe

Alexander Wetzel (3):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
      wifi: mac80211: Do not schedule stopped TXQs
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Alexandre Cassen (1):
      net/mlx5e: Support routed networks during IPsec MACs initialization

Alexei Lazar (1):
      net/mlx5e: Clear Read-Only port buffer size in PBMC before update

Alok Tiwari (8):
      ixgbe: Fix typos and clarify comments in X550 driver code
      bnxt_en: Improve comment wording and error return code
      selftests: nettest: Fix typo in log and error messages for clarity
      gve: Fix various typos and improve code comments
      gve: Return error for unknown admin queue command
      net: ll_temac: Fix incorrect PHY node reference in debug message
      net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
      be2net: Use correct byte order and format string for TCP seq and ack_seq

Andrea Mayer (2):
      seg6: fix lenghts typo in a comment
      selftests: seg6: fix instaces typo in comments

Andrey Skvortsov (1):
      wifi: rtw88: enable TX reports for the management queue

Andrey Vatoropin (1):
      net/mlx4_en: Remove the redundant NULL check for the 'my_ets' object

Andy Gospodarek (1):
      bnxt: move bnxt_hsi.h to include/linux/bnxt/hsi.h

Ankit Chauhan (1):
      selftests: tcp_ao: fix spelling in seq-ext.c comment

Antonio Quartulli (2):
      wifi: iwlwifi: fix cmd length when sending WOWLAN_TSC_RSC_PARAM
      wifi: mac80211: fix unassigned variable access

Arkadiusz Kubalewski (7):
      ice: redesign dpll sma/u.fl pins control
      dpll: add phase-offset-monitor feature to netlink spec
      dpll: add phase_offset_monitor_get/set callback ops
      ice: add phase offset monitor for all PPS dpll inputs
      dpll: add reference-sync netlink attribute
      dpll: add reference sync get/set
      ice: add ref-sync dpll pins

Arnd Bergmann (5):
      wifi: rtlwifi: avoid stack size warning for _read_eeprom_info
      lib: test_objagg: split test_hints_case() into two functions
      caif: reduce stack size, again
      net: pse-pd: pd692x0: reduce stack usage in pd692x0_setup_pi_matrix
      net: wangxun: fix LIBWX dependencies again

Arseniy Krasnov (1):
      Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'

Aswin Karuvally (1):
      s390/qeth: Make hw_trap sysfs attribute idempotent

Avraham Stern (6):
      wifi: iwlwifi: mvm: fix scan request validation
      wifi: iwlwifi: mld: fix scan request validation
      wifi: iwlwifi: mld: update the P2P device mac before starting the GO
      wifi: iwlwifi: mld: update expected range response notification version
      wifi: iwlwifi: mvm: avoid outdated reorder buffer head_sn
      wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn

Bagas Sanjaya (5):
      net: ip-sysctl: Format Private VLAN proxy arp aliases as bullet list
      net: ip-sysctl: Format possible value range of ioam6_id{,_wide} as bullet list
      net: ip-sysctl: Format pf_{enable,expose} boolean lists as bullet lists
      net: ip-sysctl: Format SCTP-related memory parameters description as bullet list
      net: ip-sysctl: Add link to SCTP IPv4 scoping draft

Bailey Forrest (1):
      gve: make IRQ handlers and page allocation NUMA aware

Baochen Qiang (5):
      wifi: ath12k: avoid bit operation on key flags
      wifi: ath12k: install pairwise key first
      wifi: ath12k: remove unneeded semicolon in ath12k_mac_parse_tx_pwr_env()
      wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      wifi: ath12k: bring DFS support back for WCN7850

Bartosz Golaszewski (7):
      net: dsa: vsc73xx: use new GPIO line value setter callbacks
      net: dsa: mt7530: use new GPIO line value setter callbacks
      net: can: mcp251x: propagate the return value of mcp251x_spi_write()
      net: can: mcp251x: use new GPIO line value setter callbacks
      net: phy: qca807x: use new GPIO line value setter callbacks
      ssb: use new GPIO line value setter callbacks
      ssb: use new GPIO line value setter callbacks for the second GPIO chip

Bastien Nocera (7):
      Bluetooth: btintel: Fix typo in comment
      Bluetooth: btmtk: Fix typo in log string
      Bluetooth: btrtl: Fix typo in comment
      Bluetooth: hci_bcm4377: Fix typo in comment
      Bluetooth: aosp: Fix typo in comment
      Bluetooth: RFCOMM: Fix typos in comments
      Bluetooth: Fix typos in comments

Benjamin Berg (8):
      wifi: iwlwifi: move dBm averaging function into utils
      wifi: iwlwifi: mld: use the correct struct size for tracing
      wifi: iwlwifi: mld: advertise support for TTLM changes
      wifi: cfg80211: only verify part of Extended MLD Capabilities
      wifi: cfg80211: add a flag for the first part of a scan
      wifi: mac80211: copy first_part into HW scan
      wifi: iwlwifi: mld: support channel survey collection for ACS scans
      wifi: iwlwifi: mld: decode EOF bit for AMPDUs

Biju Das (3):
      can: rcar_canfd: Drop unused macros
      net: phy: micrel: Add ksz9131_resume()
      net: stmmac: dwmac-renesas-gbeth: Add PM suspend/resume callbacks

Bitterblue Smith (25):
      wifi: rtw88: Rename the RTW_WCPU_11{AC,N} enums
      wifi: rtw88: Enable AP and adhoc modes for SDIO again
      wifi: rtw89: 8851b: Accept USB devices and load their MAC address
      wifi: rtw89: Make dle_mem in rtw89_chip_info an array
      wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
      wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
      wifi: rtw89: Disable deep power saving for USB/SDIO
      wifi: rtw89: Add extra TX headroom for USB
      wifi: rtw89: Hide some errors when the device is unplugged
      wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
      wifi: rtw89: Fix rtw89_mac_power_switch() for USB
      wifi: rtw89: Add some definitions for USB
      wifi: rtw89: Add usb.{c,h}
      wifi: rtw89: Add rtw8851bu.c
      wifi: rtw89: Enable the new USB modules
      wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
      wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
      wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
      wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
      wifi: rtw89: Add rtw8852bu.c
      wifi: rtw89: Enable the new rtw89_8852bu module
      wifi: rtw88: Fix macid assigned to TDLS station
      wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
      wifi: rtw89: Lower the timeout in rtw89_fwdl_check_path_ready_ax() for USB

Bjorn Helgaas (2):
      wifi: Fix typos
      net: Fix typos

Bobby Eshleman (1):
      selftests/vsock: add initial vmtest.sh for vsock

Breno Leitao (32):
      netconsole: Only register console drivers when targets are configured
      netconsole: Add automatic console unregistration on target removal
      selftests: netconsole: Do not exit from inside the validation function
      selftests: netconsole: Add support for basic netconsole target format
      ptp: Use ratelimite for freerun error message
      netpoll: remove __netpoll_cleanup from exported API
      netpoll: expose netpoll logging macros in public header
      netpoll: relocate netconsole-specific functions to netconsole module
      netpoll: move netpoll_print_options to netconsole
      netconsole: rename functions to better reflect their purpose
      netconsole: improve code style in parser function
      selftests: net: Refactor cleanup logic in lib_netcons.sh
      selftests: net: add netconsole test for cmdline configuration
      netdevsim: migrate to dstats stats collection
      netdevsim: collect statistics at RX side
      net: add dev_dstats_rx_dropped_add() helper
      netdevsim: account dropped packet length in stats on queue free
      netpoll: Extract carrier wait function
      netpoll: extract IPv4 address retrieval into helper function
      netpoll: Extract IPv6 address retrieval function
      netpoll: Improve code clarity with explicit struct size calculations
      netpoll: factor out UDP checksum calculation into helper
      netpoll: factor out IPv6 header setup into push_ipv6() helper
      netpoll: factor out IPv4 header setup into push_ipv4() helper
      netpoll: factor out UDP header setup into push_udp() helper
      netpoll: move Ethernet setup to push_eth() helper
      selftests: net: Add IPv6 support to netconsole basic tests
      netdevsim: implement peer queue flow control
      selftests: drv-net: Strip '@' prefix from bpftrace map keys
      selftests: net: add netpoll basic functionality test
      selftests: net: Skip test if IPv6 is not configured
      netpoll: Remove unused fields from inet_addr union

Bui Quang Minh (1):
      virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

Byungchul Park (17):
      page_pool: rename page_pool_return_page() to page_pool_return_netmem()
      page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
      page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
      netmem: use _Generic to cover const casting for page_to_netmem()
      page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
      netmem: introduce struct netmem_desc mirroring struct page
      netmem: use netmem_desc instead of page to access ->pp in __netmem_get_pp()
      netmem, mlx4: access ->pp_ref_count through netmem_desc instead of page
      netdevsim: access ->pp through netmem_desc instead of page
      mt76: access ->pp through netmem_desc instead of page
      net: fec: access ->pp through netmem_desc instead of page
      octeontx2-pf: access ->pp through netmem_desc instead of page
      iavf: access ->pp through netmem_desc instead of page
      idpf: access ->pp through netmem_desc instead of page
      mlx5: access ->pp through netmem_desc instead of page
      net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
      libeth: xdp: access ->pp through netmem_desc instead of page

Carolina Jubran (11):
      netlink: introduce type-checking attribute iteration for nlmsg
      devlink: Extend devlink rate API with traffic classes bandwidth management
      selftest: netdevsim: Add devlink rate tc-bw test
      net/mlx5: Add no-op implementation for setting tc-bw on rate objects
      net/mlx5: Add support for setting tc-bw on nodes
      net/mlx5: Add traffic class scheduling support for vport QoS
      net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
      selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution
      net/mlx5e: Remove unused VLAN insertion logic in TX path
      net/mlx5: Expose disciplined_fr_counter through HCA capabilities in mlx5_ifc
      devlink: Fix excessive stack usage in rate TC bandwidth parsing

Catalin Popescu (2):
      dt-bindings: net: bluetooth: nxp: add support for supply and reset
      Bluetooth: btnxpuart: implement powerup sequence

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Support Function level reset

Charalampos Mitrodimas (1):
      net, bpf: Fix RCU usage in task_cls_state() for BPF programs

Chenguang Zhao (1):
      net: ipv6: Fix spelling mistake

Chia-Yu Chang (5):
      sched: Struct definition and parsing of dualpi2 qdisc
      sched: Dump configuration and statistics of dualpi2 qdisc
      selftests/tc-testing: Fix warning and style check on tdc.sh
      selftests/tc-testing: Add selftests for qdisc DualPI2
      Documentation: netlink: specs: tc: Add DualPI2 specification

Chia-Yuan Li (2):
      wifi: rtw89: trigger TX stuck if FIFO full
      wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips

Chih-Kang Chang (20):
      wifi: rtw89: mcc: update format of RF notify MCC H2C command
      wifi: rtw89: mcc: correct frequency when MCC
      wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
      wifi: rtw89: mcc: stop TX during MCC prepare
      wifi: rtw89: TX nulldata 0 after scan complete
      wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
      wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
      wifi: rtw89: mcc: clear normal flow NoA when MCC start
      wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of tob
      wifi: rtw89: mcc: enlarge TX retry count when GC auth
      wifi: rtw89: scan abort when assign/unassign_vif
      wifi: rtw89: mcc: add H2C command to support different PD level in MCC
      wifi: rtw89: add DIG suspend/resume flow when scan and connection
      wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching time
      wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
      wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when concurrency
      wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA issue
      wifi: rtw89: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: update SER L2 type default value
      wifi: rtw89: tweak tx wake notify matching condition

Chin-Yen Lee (4):
      wifi: rtw88: pci: add PCI Express error handling
      wifi: rtw89: pci: add PCI Express error handling
      wifi: rtw89: enter power save mode aggressively
      wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode

Ching-Te Ku (20):
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
      wifi: rtw89: coex: Implement Wi-Fi MLO related logic
      wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
      wifi: rtw89: coex: refine debug log with format version and readable string
      wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
      wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
      wifi: rtw89: coex: Update BTG control for WiFi 7
      wifi: rtw89: coex: Update hardware PTA resource binding logic
      wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature
      wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
      wifi: rtw89: coex: Enable outsource info H2C command
      wifi: rtw89: coex: Query Bluetooth TX power when firmware support
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
      wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware version
      wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
      wifi: rtw89: coex: Assign priority table before entering power save
      wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue
      wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
      wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for v0.29.122.0
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.0.0

Chris Down (1):
      Bluetooth: hci_event: Mask data status from LE ext adv reports

Chris Morgan (1):
      net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick

Christian Marangi (2):
      dt-bindings: net: Document support for Airoha AN7583 MDIO Controller
      net: mdio: Add MDIO bus controller for Airoha AN7583

Christophe JAILLET (5):
      wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg
      net: dsa: mv88e6xxx: Constify struct devlink_region_ops and struct mv88e6xxx_region
      net: dsa: mv88e6xxx: Use kcalloc()
      net: dsa: hellcreek: Constify struct devlink_region_ops and struct hellcreek_fdb_entry
      net: dsa: mt7530: Constify struct regmap_config

Colin Ian King (5):
      wifi: rtlwifi: rtl8821ae: make the read-only array params static const
      igc: Make the const read-only array supported_sizes static
      wifi: brcmfmac: Make read-only array cfg_offset static const
      wifi: ath11k: Make read-only const array svc_id static const
      net/mlx5: Fix spelling mistake "disabliing" -> "disabling"

Cosmin Ratiu (1):
      net/mlx5e: CT: extract a memcmp from a spinlock section

Dan Carpenter (7):
      wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
      octeontx2-af: Fix error code in rvu_mbox_init()
      wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()
      wifi: mt76: mt7925: fix off by one in mt7925_mcu_hw_scan()
      net: airoha: Fix a NULL vs IS_ERR() bug in airoha_npu_run_firmware()
      net: ethernet: mtk_wed: Fix NULL vs IS_ERR() bug in mtk_wed_get_memory_region()
      net/mlx5: Fix an IS_ERR() vs NULL bug in esw_qos_move_node()

Daniel Braunwarth (1):
      net: phy: realtek: add error handling to rtl8211f_get_wol

Daniel Gabay (1):
      wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_retry_emlsr()

Daniel Golle (3):
      net: ethernet: mtk_eth_soc: improve support for named interrupts
      net: ethernet: mtk_eth_soc: fix kernel-doc comment
      net: ethernet: mtk_eth_soc: use generic allocator for SRAM

Daniel Jurgens (1):
      net/mlx5: IFC updates for disabled host PF

Daniel Zahka (3):
      selftests: drv-net: tso: enable test cases based on hw_features
      selftests: drv-net: tso: fix vxlan tunnel flags to get correct gso_type
      selftests: drv-net: tso: fix non-tunneled tso6 test case name

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dave Ertman (1):
      ice: breakout common LAG code into helpers

Dave Marquardt (1):
      docs: netdevsim: fixe typo in netdevsim documentation

David Arinzon (9):
      net: ena: Add PHC support in the ENA driver
      net: ena: PHC silent reset
      net: ena: Add device reload capability through devlink
      net: ena: Add devlink port support
      devlink: Add new "enable_phc" generic device param
      net: ena: Control PHC enable through devlink
      net: ena: Add debugfs support to the ENA driver
      net: ena: View PHC stats using debugfs
      net: ena: Add PHC documentation

David Bauer (3):
      wifi: mt76: mt7915: mcu: increase eeprom command timeout
      wifi: mt76: mt7915: mcu: lower default timeout
      wifi: mt76: mt7915: mcu: re-init MCU before loading FW patch

David Jander (3):
      net: phy: dp83tg720: implement soft reset with asymmetric delay
      net: phy: dp83tg720: remove redundant 600ms post-reset delay
      net: phy: dp83tg720: switch to adaptive polling and remove random delays

David Lechner (1):
      net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep

David S. Miller (4):
      Merge branch 'ionic-cleanups' into main
      Merge branch 'netconsole-msgid' into main
      Merge branch 'gve-xdp-tx-redirect' into main
      Merge branch 'hv-msi-parent-domain' into main

David Thompson (1):
      mlxbf_gige: emit messages during open and probe failures

Davide Caratti (2):
      can: add drop reasons in the receive path of AF_CAN
      can: add drop reasons in CAN protocols receive path

Dawid Osuchowski (2):
      i40e: add link_down_events statistic
      ice: add E835 device IDs

Dennis Chen (1):
      netdevsim: remove redundant branch

Dexuan Cui (1):
      hv_sock: Return the readable bytes in hvs_stream_has_data()

Dipayaan Roy (1):
      net: mana: Expose additional hardware counters for drop and TC via ethtool.

Don Skidmore (1):
      ixgbe: check for MDD events

Donald Hunter (8):
      netlink: specs: add doc start markers to yaml
      netlink: specs: clean up spaces in brackets
      netlink: specs: fix up spaces before comments
      netlink: specs: fix up truthy values
      netlink: specs: fix up indentation errors
      netlink: specs: wrap long doc lines (>80 chars)
      netlink: specs: fix a couple of yamllint warnings
      tools: ynl: process unknown for enum values

Double Lo (1):
      wifi: brcmfmac: support CYW54591 PCIE device

Doug Berger (1):
      net: bcmgenet: update PHY power down

Dr. David Alan Gilbert (9):
      cxgb3/l2t: Remove unused t3_l2t_send_event
      net: liquidio: Remove unused validate_cn23xx_pf_config_info()
      wl1251: Remove unused wl1251_acx_rate_policies
      wl1251: Remove unused wl1251_cmd_*
      wifi: wlcore: Remove unused wl12xx_cmd_start_fwlog
      net/x25: Remove unused x25_terminate_link()
      wifi: brcm80211: Remove unused functions
      wifi: brcm80211: Remove more unused functions
      wifi: brcm80211: Remove yet more unused functions

Dragos Tatulea (9):
      net: Allow const args for of page_to_netmem()
      net: Add skb_can_coalesce for netmem
      page_pool: Add page_pool_dev_alloc_netmems helper
      net/mlx5e: Add TX support for netmems
      net/mlx5: Small refactor for general object capabilities
      net/mlx5: Add IFC bits for PCIe Congestion Event object
      net/mlx5e: Create/destroy PCIe Congestion Event object
      net/mlx5e: Add device PCIe congestion ethtool stats
      net/mlx5e: TX, Fix dma unmapping for devmem tx

Easwar Hariharan (2):
      net/smc: convert timeouts to secs_to_jiffies()
      net: ipconfig: convert timeouts to secs_to_jiffies()

Edward Cree (1):
      sfc: falcon: refactor and document ef4_ethtool_get_rxfh_fields

Edward Srouji (1):
      RDMA/mlx5: Fix UMR modifying of mkey page size

Emmanuel Grumbach (1):
      wifi: iwlwifi: mld: support iwl_omi_send_status_notif version 2

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 0489/e14e for MT7925

Eric Dumazet (54):
      selftests/tc-testing: sfq: check perturb timer values
      tcp: tcp_time_to_recover() cleanup
      net: annotate races around sk->sk_uid
      net: remove sock_i_uid()
      net: make sk->sk_sndtimeo lockless
      net: make sk->sk_rcvtimeo lockless
      tcp: remove rtx_syn_ack field
      tcp: remove inet_rtx_syn_ack()
      selftests/net: packetdrill: add tcp_dsack_mult.pkt
      net: ipv4: guard ip_mr_output() with rcu
      ipv6: guard ip6_mr_output() with rcu
      net: net->nsid_lock does not need BH safety
      net: add struct net_aligned_data
      net: move net_cookie into net_aligned_data
      tcp: move tcp_memory_allocated into net_aligned_data
      udp: move udp_memory_allocated into net_aligned_data
      net: dst: annotate data-races around dst->obsolete
      net: dst: annotate data-races around dst->expires
      net: dst: annotate data-races around dst->lastuse
      net: dst: annotate data-races around dst->input
      net: dst: annotate data-races around dst->output
      net: dst: add four helpers to annotate data-races around dst->dev
      ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
      ipv6: adopt dst_dev() helper
      ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
      ipv6: ip6_mc_input() and ip6_mr_input() cleanups
      net: ifb: support BIG TCP packets
      net: remove RTNL use for /proc/sys/net/core/rps_default_mask
      net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
      udp: remove udp_tunnel_gro_init()
      net_sched: act: annotate data-races in tcf_lastuse_update() and tcf_tm_dump()
      net_sched: act_connmark: use RCU in tcf_connmark_dump()
      net_sched: act_csum: use RCU in tcf_csum_dump()
      net_sched: act_ct: use RCU in tcf_ct_dump()
      net_sched: act_ctinfo: use atomic64_t for three counters
      net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
      net_sched: act_mpls: use RCU in tcf_mpls_dump()
      net_sched: act_nat: use RCU in tcf_nat_dump()
      net_sched: act_pedit: use RCU in tcf_pedit_dump()
      net_sched: act_police: use RCU in tcf_police_dump()
      net_sched: act_skbedit: use RCU in tcf_skbedit_dump()
      selftests/net: packetdrill: add --mss option to three tests
      tcp: do not accept packets beyond window
      tcp: add LINUX_MIB_BEYOND_WINDOW
      selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt
      tcp: call tcp_measure_rcv_mss() for ooo packets
      selftests/net: packetdrill: add tcp_ooo_rcv_mss.pkt
      tcp: add const to tcp_try_rmem_schedule() and sk_rmem_schedule() skb
      tcp: stronger sk_rcvbuf checks
      selftests/net: packetdrill: add tcp_rcv_toobig.pkt
      ipv6: add a retry logic in net6_rt_notify()
      ipv6: prevent infinite loop in rt6_nlmsg_size()
      ipv6: fix possible infinite loop in fib6_info_uses_dev()
      ipv6: annotate data-races around rt->fib6_nsiblings

Eric Huang (3):
      wifi: rtw89: add EHT physts and adjust init flow accordingly
      wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
      wifi: rtw89: correct length for IE18/19 PHY report and IE parser

Eric Work (1):
      net: atlantic: add set_power to fw_ops for atl2 to fix wol

Erni Sri Satya Vennela (5):
      net: mana: Fix potential deadlocks in mana napi ops
      net: mana: Add support for net_shaper_ops
      net: mana: Add speed support in mana_get_link_ksettings
      net: mana: Handle unsupported HWC commands
      net: mana: Fix build errors when CONFIG_NET_SHAPER is disabled

Fabio Estevam (1):
      wifi: brcmfmac: Add support for the SDIO 43751 device

Faisal Bukhari (1):
      netlink: spelling: fix appened -> appended in a comment

Faizal Rahim (7):
      igc: move TXDCTL and RXDCTL related macros
      igc: add DCTL prefix to related macros
      igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
      igc: assign highest TX queue number as highest priority in mqprio
      igc: add private flag to reverse TX queue priority in TSN mode
      igc: add preemptible queue support in taprio
      igc: add preemptible queue support in mqprio

Fan Yu (2):
      tcp: trace retransmit failures in tcp_retransmit_skb
      net/sched: Add precise drop reason for pfifo_fast queue overflows

Fedor Pchelkin (4):
      wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK
      wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
      wifi: rtw89: sar: do not assert wiphy lock held until probing is done
      netfilter: nf_tables: adjust lockdep assertions handling

Felix Fietkau (1):
      wifi: mt76: fix vif link allocation

Feng Liu (1):
      net/mlx5e: Expose TIS via devlink tx reporter diagnose

Feng Yang (1):
      skbuff: Add MSG_MORE flag to optimize tcp large packet transmission

Fengyuan Gong (1):
      net: account for encap headers in qdisc pkt len

Florian Fainelli (4):
      net: bcmasp: Utilize napi_complete_done() return value
      net: bcmasp: enable GRO software interrupt coalescing by default
      net: dsa: b53: add support for FDB operations on 5325/5365
      net: bcmasp: Add support for re-starting auto-negotiation

Florian Larysch (1):
      net: phy: micrel: fix KSZ8081/KSZ8091 cable test

Florian Westphal (7):
      selftests: net: Enable legacy netfilter legacy options.
      netfilter: nft_set_pipapo: remove unused arguments
      netfilter: nft_set: remove one argument from lookup and update functions
      netfilter: nft_set: remove indirection from update API call
      netfilter: nft_set_pipapo: merge pipapo_get/lookup
      netfilter: nft_set_pipapo: prefer kvmalloc for scratch maps
      netfilter: xt_nfacct: don't assume acct name is null-terminated

Frank Li (4):
      dt-bindings: net: convert qca,qca7000.txt yaml format
      dt-bindings: net: convert lpc-eth.txt yaml format
      dt-bindings: net: convert nxp,lpc1850-dwmac.txt to yaml format
      dt-bindings: ieee802154: Convert at86rf230.txt yaml format

Frank Wunderlich (10):
      net: ethernet: mtk_eth_soc: support named IRQs
      net: ethernet: mtk_eth_soc: add consts for irq index
      net: ethernet: mtk_eth_soc: skip first IRQ if not used
      net: ethernet: mtk_eth_soc: only use legacy mode on missing IRQ name
      dt-bindings: net: mediatek,net: update mac subnode pattern for mt7988
      dt-bindings: net: mediatek,net: allow up to 8 IRQs
      dt-bindings: net: mediatek,net: allow irq names
      dt-bindings: net: mediatek,net: add sram property
      dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for mt7988
      dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus

Fushuai Wang (3):
      net/mlx5e: Fix error handling in RQ memory model registration
      sfc: eliminate xdp_rxq_info_valid using XDP base API
      sfc: siena: eliminate xdp_rxq_info_valid using XDP base API

Gabriel Goller (1):
      ipv6: add `force_forwarding` sysctl to enable per-interface forwarding

Gal Pressman (7):
      net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
      net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
      net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard
      net/mlx5e: Replace recursive VLAN push handling with an iterative loop
      ethtool: Don't check for RXFH fields conflict when no input_xfrm is requested
      selftests: drv-net: Fix remote command checking in require_cmd()
      selftests: drv-net: Make command requirements explicit

Gaosheng Cui (1):
      iwlwifi: remove unused no_sleep_autoadjust declaration

Geert Uytterhoeven (15):
      documentation: networking: can: Document alloc_candev_mqs()
      net: hns3: Demote load and progress messages to debug level
      can: rcar_canfd: Consistently use ndev for net_device pointers
      can: rcar_canfd: Remove bittiming debug prints
      can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
      can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
      can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
      can: rcar_canfd: Repurpose f_dcfg base for other registers
      can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
      can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
      can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
      can: rcar_canfd: Add support for Transceiver Delay Compensation
      can: rcar_canfd: Describe channel-specific FD registers using C struct
      dt-bindings: net: Rename renesas,r9a09g057-gbeth.yaml
      can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Geliang Tang (3):
      mptcp: sockopt: drop redundant tcp_getsockopt
      tcp: add tcp_sock_set_maxseg
      mptcp: add TCP_MAXSEG sockopt support

George Moussalem (2):
      dt-bindings: net: qca,ar803x: Add IPQ5018 Internal GE PHY support
      net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (1):
      wifi: cfg80211: move away from using a fake platform device

Guillaume Nault (1):
      ipv6: Simplify link-local address generation for IPv6 GRE.

Gur Stavi (3):
      queue_api: add subqueue variant netif_subqueue_sent
      hinic3: use netif_subqueue_sent api
      hinic3: remove tx_q name collision hack

Gustavo A. R. Silva (2):
      wifi: iwlwifi: mvm: d3: Avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: mvm/fw: Avoid -Wflex-array-member-not-at-end warnings

Gustavo Luiz Duarte (5):
      netconsole: introduce 'msgid' as a new sysdata field
      netconsole: implement configfs for msgid_enabled
      netconsole: append msgid to sysdata
      selftests: netconsole: Add tests for 'msgid' feature in sysdata
      docs: netconsole: document msgid feature

Haiyang Zhang (2):
      net: mana: Add handler for hardware servicing events
      net: mana: Handle Reset Request from MANA NIC

Hangbin Liu (3):
      selftests: net: use slowwait to stabilize vrf_route_leaking test
      selftests: net: use slowwait to make sure IPv6 setup finished
      selftests: rtnetlink: fix addrlft test flakiness on power-saving systems

Hannes Reinecke (1):
      net/handshake: Add new parameter 'HANDSHAKE_A_ACCEPT_KEYRING'

Hao Li (1):
      Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618

Haochen Tong (1):
      Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925

Hari Chandrakanthan (2):
      wifi: ath12k: Fix station association with MBSSID Non-TX BSS
      wifi: mac80211: fix rx link assignment for non-MLO stations

Hari Kalavakunta (1):
      net: ncsi: Fix buffer overflow in fetching version id

Hariharan Basuthkar (1):
      wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD for AP vdev

Hariprasad Kelam (6):
      Octeontx-pf: Update SGMII mode mapping
      Octeontx2-af: Introduce mode group index
      Octeontx2-pf: ethtool: support multi advertise mode
      Octeontx2-af: Add programmed macaddr to RVU pfvf
      Octeontx2-af: RPM: Update DMA mask
      Octeontx2-af: Debugfs support for firmware data

Harshitha Prem (1):
      wifi: ath12k: update unsupported bandwidth flags in reg rules

Harshitha Ramamurthy (1):
      gve: Add initial PTP device support

Heiner Kallweit (19):
      r8169: enable EEE at 5Gbps on RTL8126
      r8169: remove redundant pci_tbl entry
      net: usb: lan78xx: make struct fphy_status static const
      net: phy: assign default match function for non-PHY MDIO devices
      net: phy: move definition of genphy_c45_driver to phy_device.c
      net: phy: simplify mdiobus_setup_mdiodev_from_board_info
      net: phy: move definition of struct mdio_board_entry to mdio-boardinfo.c
      net: phy: improve mdio-boardinfo.h
      net: phy: directly copy struct mdio_board_info in mdiobus_register_board_info
      net: phy: move __phy_package_[read|write]_mmd to phy_package.c
      net: phy: make phy_package a separate module
      net: phy: add Kconfig symbol PHY_PACKAGE
      net: phy: add flag is_genphy_driven to struct phy_device
      net: phy: improve phy_driver_is_genphy
      net: phy: remove phy_driver_is_genphy_10g
      dpaa_eth: don't use fixed_phy_change_carrier
      iwlwifi: use DECLARE_BITMAP macro
      net: usb: lan78xx: stop including phy_fixed.h
      net: phy: declare package-related struct members only if CONFIG_PHY_PACKAGE is enabled

Himanshu Mittal (1):
      net: ti: icssg-prueth: Add prp offload support to ICSSG driver

Ido Schimmel (7):
      seg6: Extend seg6_lookup_any_nexthop() with an oif argument
      seg6: Call seg6_lookup_any_nexthop() from End.X behavior
      seg6: Allow End.X behavior to accept an oif
      selftests: seg6: Add test cases for End.X with link-local nexthop
      neighbor: Add NTF_EXT_VALIDATED flag for externally validated entries
      selftests: net: Add a selftest for externally validated neighbor entries
      selftests: rtnetlink: Add operational state test

Ilan Peer (4):
      wifi: iwlwifi: mld: Block EMLSR when scanning on P2P Device
      wifi: cfg80211: Fix interface type validation
      wifi: mac80211_hwsim: Declare support for AP scanning
      wifi: iwlwifi: mvm: Remove NAN support

Ilya Maximets (1):
      net: openvswitch: allow providing upcall pid for the 'execute' command

Inochi Amaoto (4):
      dt-bindings: net: Add support for Sophgo CV1800 dwmac
      dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac
      net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
      net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string

Itamar Shalev (5):
      wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_int_mlo_scan()
      wifi: iwlwifi: mvm: enable antenna selection for AX210 family
      wifi: iwlwifi: simplify iwl_poll_bits_mask return value
      wifi: iwlwifi: pcie: inform me when op mode leaving
      wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset

Ivan Pravdin (1):
      Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv

Ivan Vecera (18):
      dt-bindings: dpll: Add DPLL device and pin
      dt-bindings: dpll: Add support for Microchip Azurite chip family
      devlink: Add support for u64 parameters
      devlink: Add new "clock_id" generic device param
      dpll: Add basic Microchip ZL3073x support
      dpll: zl3073x: Fetch invariants during probe
      dpll: zl3073x: Read DPLL types and pin properties from system firmware
      dpll: zl3073x: Register DPLL devices and pins
      dpll: zl3073x: Implement input pin selection in manual mode
      dpll: zl3073x: Add support to get/set priority on input pins
      dpll: zl3073x: Implement input pin state setting in automatic mode
      dpll: zl3073x: Add support to get/set frequency on pins
      dpll: zl3073x: Add support to get/set esync on pins
      dpll: zl3073x: Add support to get phase offset on connected input pin
      dpll: zl3073x: Implement phase offset monitor feature
      dpll: zl3073x: Add support to adjust phase
      dpll: zl3073x: Add support to get fractional frequency offset
      dpll: zl3073x: Fix build failure

Jack Ping CHNG (2):
      net: pcs: xpcs: Use devm_clk_get_optional
      net: pcs: xpcs: mask readl() return value to 16 bits

Jacky Chou (3):
      dt-bindings: net: ftgmac100: Add resets property
      dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
      net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs

Jacob Keller (14):
      net: intel: rename 'hena' to 'hashcfg' for clarity
      net: intel: move RSS packet classifier types to libie
      ice: fix E825-C TSPLL register definitions
      ice: clear time_sync_en field for E825-C during reprogramming
      ice: read TSPLL registers again before reporting status
      ice: default to TIME_REF instead of TXCO on E825-C
      ice: add support for reading and unpacking Rx queue context
      ice: add functions to get and set Tx queue context
      ice: save RSS hash configuration for migration
      ice: move ice_vsi_update_l2tsel to ice_lib.c
      ice: expose VF functions used by live migration
      ice: use pci_iov_vf_id() to get VF ID
      ice: avoid rebuilding if MSI-X vector count is unchanged
      ice: introduce ice_get_vf_by_dev() wrapper

Jakub Kicinski (270):
      Merge branch 'netconsole-optimize-console-registration-and-improve-testing'
      uapi: in6: restore visibility of most IPv6 socket options
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'hinic3-queue_api-related-fixes'
      Merge tag 'linux-can-next-for-6.17-20250610' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      selftests/net: packetdrill: more xfail changes
      Merge branch 'netlink-specs-fix-all-the-yamllint-errors'
      Merge branch 'fbnic-expand-mac-stats-coverage'
      Merge branch 'net-phy-micrel-add-extended-phy-support-for-ksz9477-class-devices'
      Merge branch 'net-bcmgenet-add-support-for-gro-software-interrupt-coalescing'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      net: ethtool: copy the rxfh flow handling
      net: ethtool: remove the duplicated handling from rxfh and rxnfc
      net: ethtool: require drivers to opt into the per-RSS ctx RXFH
      net: ethtool: add dedicated callbacks for getting and setting rxfh fields
      eth: remove empty RXFH handling from drivers
      eth: fbnic: migrate to new RXFH callbacks
      net: drv: vmxnet3: migrate to new RXFH callbacks
      net: drv: virtio: migrate to new RXFH callbacks
      net: drv: hyperv: migrate to new RXFH callbacks
      Merge branch 'net-ethtool-add-dedicated-rxfh-driver-callbacks'
      Merge branch 'net-bcmasp-add-support-for-gro'
      Merge branch 'net-phy-improve-mdio-boardinfo-handling'
      Merge branch 'dp83tg720-reduce-link-recovery'
      Merge branch 'dpll-add-all-inputs-phase-offset-monitor'
      Merge branch 'net-stmmac-rk-much-needed-cleanups'
      Merge branch 'net-phy-make-phy_package-a-separate-module'
      Merge branch 'netpoll-untangle-netconsole-and-netpoll'
      Merge branch 'gve-add-rx-hw-timestamping-support'
      Merge branch 'seg6-allow-end-x-behavior-to-accept-an-oif'
      Merge branch 'cn20k-silicon-with-mbox-support'
      eth: cisco: migrate to new RXFH callbacks
      eth: cxgb4: migrate to new RXFH callbacks
      eth: lan743x: migrate to new RXFH callbacks
      eth: e1000e: migrate to new RXFH callbacks
      eth: enetc: migrate to new RXFH callbacks
      Merge branch 'eth-migrate-to-new-rxfh-callbacks-get-only-drivers'
      eth: igb: migrate to new RXFH callbacks
      eth: igc: migrate to new RXFH callbacks
      eth: ixgbe: migrate to new RXFH callbacks
      eth: fm10k: migrate to new RXFH callbacks
      eth: i40e: migrate to new RXFH callbacks
      eth: ice: migrate to new RXFH callbacks
      eth: iavf: migrate to new RXFH callbacks
      Merge branch 'eth-intel-migrate-to-new-rxfh-callbacks'
      Merge branch 'net-phy-remove-phy_driver_is_genphy-and-phy_driver_is_genphy_10g'
      eth: gianfar: migrate to new RXFH callbacks
      Merge branch 'shradha_v6.16-rc1' of https://github.com/shradhagupta6/linux
      Merge branch 'vsock-test-improve-transport_uaf-test'
      Merge branch 'io_uring-cmd-for-tx-timestamps'
      Merge branch 'net-stmmac-rk-more-cleanups'
      Merge branch 'tcp-remove-obsolete-rfc3517-rfc6675-code'
      Merge branch 'link-napi-instances-to-queues-and-irqs'
      Merge branch 'nte-stmmac-visconti-cleanups'
      Merge branch 'net-dsa-b53-fix-bcm5325-support'
      Merge branch 'net-use-new-gpio-line-value-setter-callbacks'
      Merge branch 'misc-vlan-cleanups'
      Merge branch 'ipmr-ip6mr-allow-mc-routing-locally-generated-mc-packets'
      Merge branch 'net-mlx5e-add-support-for-devmem-and-io_uring-tcp-zero-copy'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      eth: bnx2x: migrate to new RXFH callbacks
      eth: bnxt: migrate to new RXFH callbacks
      eth: ena: migrate to new RXFH callbacks
      eth: thunder: migrate to new RXFH callbacks
      eth: otx2: migrate to new RXFH callbacks
      Merge branch 'eth-migrate-some-drivers-to-new-rxfh-callbacks'
      eth: niu: migrate to new RXFH callbacks
      eth: mvpp2: migrate to new RXFH callbacks
      eth: dpaa: migrate to new RXFH callbacks
      eth: dpaa2: migrate to new RXFH callbacks
      eth: sxgbe: migrate to new RXFH callbacks
      Merge branch 'eth-migrate-more-drivers-to-new-rxfh-callbacks'
      Merge branch 'udp_tunnel-remove-rtnl_lock-dependency'
      Merge branch 'phc-support-in-ena-driver'
      Merge branch 'add-support-for-pse-budget-evaluation-strategy'
      Merge tag 'linux-can-next-for-6.17-20250618' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-loongson1-cleanups'
      Merge branch 'net-fec-general-vlan-cleanups'
      Merge branch 'convert-lan78xx-driver-to-the-phylink'
      Merge branch 'netdevsim-implement-rx-statistics-using-netdev_pcpu_stat_dstats'
      Merge branch 'netpoll-code-organization-improvements'
      Merge branch 'ref_tracker-add-ability-to-register-a-debugfs-file-for-a-ref_tracker_dir'
      Merge branch 'rds-minor-updates-for-spelling-and-endian'
      eth: sfc: falcon: migrate to new RXFH callbacks
      eth: sfc: siena: migrate to new RXFH callbacks
      eth: sfc: migrate to new RXFH callbacks
      eth: benet: migrate to new RXFH callbacks
      eth: qede: migrate to new RXFH callbacks
      eth: mlx5: migrate to new RXFH callbacks
      eth: nfp: migrate to new RXFH callbacks
      eth: hinic: migrate to new RXFH callbacks
      eth: hns3: migrate to new RXFH callbacks
      net: ethtool: don't mux RXFH via rxnfc callbacks
      Merge branch 'eth-finish-migration-to-the-new-rxfh-callbacks'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      netdevsim: fix UaF when counting Tx stats
      Merge branch 'add-support-for-the-ipq5018-internal-ge-phy'
      selftests: drv-net: import things in lib one by one
      Merge branch 'net-replace-sock_i_uid-with-sk_uid'
      Merge branch 'net-lockless-sk_sndtimeo-and-sk_rcvtimeo'
      selftests: drv-net: stats: fix pylint issues
      selftests: drv-net: stats: use skip instead of xfail for unsupported features
      Merge branch 'selftests-drv-net-stats-use-skip-instead-of-xfail'
      Merge branch 'rework-irq-handling-in-mtk_eth_soc'
      Merge branch 'there-are-some-cleanup-for-hns3-driver'
      Merge tag 'wireless-next-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      netlink: specs: add the multicast group name to spec
      net: ethtool: dynamically allocate full req size req
      net: ethtool: call .parse_request for SET handlers
      net: ethtool: remove the data argument from ethtool_notify()
      net: ethtool: copy req_info from SET to NTF
      net: ethtool: rss: add notifications
      doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
      selftests: drv-net: test RSS Netlink notifications
      Merge branch 'net-ethtool-rss-add-notifications'
      eth: fbnic: remove duplicate FBNIC_MAX_.XQS macros
      eth: fbnic: fix stampinn typo in a comment
      eth: fbnic: realign whitespace
      eth: fbnic: sort includes
      eth: fbnic: rename fbnic_fw_clear_cmpl to fbnic_mbx_clear_cmpl
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'ptp-belated-spring-cleaning-of-the-chardev-driver'
      Merge branch 'ref_tracker-fix'
      Merge branch 'nfc-trf7970a-add-option-to-reduce-antenna-gain'
      Merge branch 'net-dsa-ks8995-fix-up-bindings'
      Merge branch 'tcp-remove-rtx_syn_ack-and-inet_rtx_syn_ack'
      Merge branch 'tcp-fix-dsack-bug-with-non-contiguous-ranges'
      eth: bnxt: take page size into account for page pool recycling rings
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'dpll-add-reference-sync-feature'
      Merge branch 'octeontx2-pf-extend-link-modes-support'
      net: ethtool: avoid OOB accesses in PAUSE_SET
      net: ethtool: take rss_lock for all rxfh changes
      net: ethtool: move rxfh_fields callbacks under the rss_lock
      net: ethtool: move get_rxfh callback under the rss_lock
      Merge branch 'net-ethtool-consistently-take-rss_lock-for-all-rxfh-ops'
      Merge branch 'add-support-for-externally-validated-neighbor-entries'
      Merge branch 'net-enetc-change-some-statistics-to-64-bit'
      docs: fbnic: explain the ring config
      net: ethtool: fix leaking netdev ref if ethnl_default_parse() failed
      Merge branch 'seg6-fix-typos-in-comments-within-the-srv6-subsystem'
      Merge branch 'net-introduce-net_aligned_data'
      Merge branch 'net-add-data-race-annotations-around-dst-fields'
      Merge branch 'vsock-test-check-for-null-ptr-deref-when-transport-changes'
      Merge branch 'preserve-msg_zerocopy-with-forwarding'
      Merge branch 'support-rate-management-on-traffic-classes-in-devlink-and-mlx5'
      Merge branch 'net-ethernet-mtk_eth_soc-improve-device-tree-handling'
      Merge branch 'netpoll-factor-out-functions-from-netpoll_send_udp-and-add-ipv6-selftest'
      Merge branch 'introducing-broadcom-bnge-ethernet-driver'
      Merge branch 'net-phylink-support-autoneg-configuration-for-sfps'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-mlx5-hws-optimize-matchers-icm-usage'
      Merge branch 'net-remove-unused-function-parameters-in-skbuff-c'
      Merge branch 'support-some-features-for-the-hibmcge-driver'
      eth: otx2: migrate to the *_rxfh_context ops
      eth: ice: drop the dead code related to rss_contexts
      eth: mlx5: migrate to the *_rxfh_context ops
      net: ethtool: remove the compat code for _rxfh_context ops
      net: ethtool: reduce indent for _rxfh_context ops
      Merge branch 'net-migrate-remaining-drivers-to-dedicated-_rxfh_context-ops'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'eth-fbnic-add-firmware-logging-support'
      Merge branch 'af_unix-introduce-so_inq-scm_inq'
      Merge branch 'net-xsk-update-tx-queue-consumer'
      Merge branch 'ipv6-drop-rtnl-from-mcast-c-and-anycast-c'
      Merge branch 'add-vf-drivers-for-wangxun-virtual-functions'
      Merge branch 'add-microchip-zl3073x-support-part-1'
      Merge branch 'converge-on-using-secs_to_jiffies-part-two'
      Merge branch 'vsock-introduce-siocinq-ioctl-support'
      Merge branch 'net-phy-bcm54811-phy-initialization'
      Merge branch 'net-mlx5-misc-changes-2025-07-09'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'virtio_udp_tunnel_08_07_2025' of https://github.com/pabeni/linux-devel
      Merge branch 'further-mt7988-devicetree-work'
      Merge branch 'riscv-sophgo-add-ethernet-support-for-sg2042'
      Merge tag 'wireless-next-2025-07-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      ethtool: rss: make sure dump takes the rss lock
      tools: ynl: decode enums in auto-ints
      ethtool: mark ETHER_FLOW as usable for Rx hash
      ethtool: rss: report which fields are configured for hashing
      selftests: drv-net: test RSS header field configuration
      Merge branch 'ethtool-rss-report-which-fields-are-configured-for-hashing'
      Merge branch 'net-ftgmac100-add-soc-reset-support-for-rmii-mode'
      Merge tag 'nf-next-25-07-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      eth: fbnic: fix ubsan complaints about OOB accesses
      Merge branch 'net_sched-act-extend-rcu-use-in-dump-methods'
      Merge branch 'netdevsim-support-setting-a-permanent-address'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'batadv-next-pullrequest-20250710' of git://git.open-mesh.org/linux-merge
      tools: ynl: default to --process-unknown in installed mode
      Merge branch 'net-fec-add-some-optimizations'
      selftests: drv-net: add rss_api to the Makefile
      Merge tag 'linux-can-next-for-6.17-20250711' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'tcp-receiver-changes'
      Merge branch 'net-hns3-use-seq_file-for-debugfs'
      selftests: packetdrill: correct the expected timing in tcp_rcv_big_endseq
      selftests: drv-net: add helper/wrapper for bpftrace
      Merge branch 'selftest-net-add-selftest-for-netpoll'
      Merge branch 'expose-refclk-for-rmii-and-enable-rmii'
      Merge branch 'net-mlx5e-add-support-for-pcie-congestion-events'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      ethtool: rss: initial RSS_SET (indirection table handling)
      selftests: drv-net: rss_api: factor out checking min queue count
      tools: ynl: support packing binary arrays of scalars
      selftests: drv-net: rss_api: test setting indirection table via Netlink
      ethtool: rss: support setting hfunc via Netlink
      ethtool: rss: support setting hkey via Netlink
      selftests: drv-net: rss_api: test setting hashing key via Netlink
      netlink: specs: define input-xfrm enum in the spec
      ethtool: rss: support setting input-xfrm via Netlink
      ethtool: rss: support setting flow hashing fields
      selftests: drv-net: rss_api: test input-xfrm and hash fields
      Merge branch 'ethtool-rss-support-rss_set-via-netlink'
      Merge branch 'neighbour-convert-rtm_getneigh-to-rcu-and-make-pneigh-rtnl-free'
      selftests: net: prevent Python from buffering the output
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'add-shared-phy-counter-support-for-qca807x-and-qca808x'
      Merge branch 'net-mlx5-misc-changes-2025-07-16'
      Merge branch 'net-maintain-netif-vs-dev-prefix-semantics'
      Merge branch 'amd-xgbe-add-hardware-ptp-timestamping'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'mptcp-add-tcp_maxseg-sockopt-support'
      ethtool: assert that drivers with sym hash are consistent for RSS contexts
      ethtool: rejig the RSS notification machinery for more types
      ethtool: rss: factor out allocating memory for response
      ethtool: rss: factor out populating response from context
      ethtool: move ethtool_rxfh_ctx_alloc() to common code
      ethtool: rss: support creating contexts via Netlink
      ethtool: rss: support removing contexts via Netlink
      selftests: drv-net: rss_api: context create and delete tests
      Merge branch 'ethtool-rss-support-creating-and-removing-contexts-via-netlink'
      net: netdevsim: hook in XDP handling
      Merge branch 'selftests-drv-net-test-xdp-native-support'
      Merge branch 'net-mlx5-misc-changes-2025-07-21'
      Merge branch 'tcp-a-couple-of-fixes'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'split-netmem-from-struct-page'
      Merge branch 'dualpi2-patch'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2025-07-24' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      tools: ynl-gen: don't add suffix for pure types
      tools: ynl-gen: move free printing to the print_type_full() helper
      tools: ynl-gen: print alloc helper for multi-val attrs
      tools: ynl-gen: print setters for multi-val attrs
      selftests: drv-net: devmem: use new mattr ynl helpers
      Merge branch 'tools-ynl-gen-print-setters-for-multi-val-attrs'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'for-net-next-2025-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'use-enum-to-represent-the-napi-threaded-state'
      Merge branch 'selftests-drv-net-fix-and-improve-command-requirement-checking'
      Merge branch 'selftests-drv-net-tso-fix-issues-with-tso-selftest'
      Merge branch 'mlx5e-misc-fixes-2025-07-23'
      Merge branch 'mptcp-track-more-fallback-cases'
      Merge branch 'net-dsa-b53-mmap-add-bcm63xx-ephy-power-control'
      Merge branch 'net-mlx5e-misc-changes-2025-07-22'
      Merge branch 'net-add-sockaddr_inet-unified-address-structure'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'linux-can-next-for-6.17-20250725' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge tag 'nf-next-25-07-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'linux-can-fixes-for-6.16-20250725' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'arm64-dts-socfpga-enable-ethernet-support-for-agilex5'
      Merge branch 'net-dsa-microchip-add-ksz8463-switch-support'
      Merge branch 'xsk-fix-negative-overflow-issues-in-zerocopy-xmit'
      Merge branch 'ipv6-f6i-fib6_siblings-and-rt-fib6_nsiblings-fixes'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: bpf: fix legacy netfilter options

Jason Wang (3):
      iwlwifi: Fix comment typo
      tun: remove unnecessary tun_xdp_hdr structure
      vhost-net: reduce one userspace copy when building XDP buff

Jason Xing (7):
      net: xsk: dpaa2: avoid repeatedly updating the global consumer
      net: xsk: update tx queue consumer immediately after transmission
      selftests/bpf: add a new test to check the consumer update case
      Documentation: xsk: correct the obsolete references and examples
      net: xsk: introduce XDP_MAX_TX_SKB_BUDGET setsockopt
      stmmac: xsk: fix negative overflow of budget in zerocopy mode
      igb: xsk: solve negative overflow of nb_pkts in zerocopy mode

Jeff Johnson (9):
      wifi: ath: Add missing include of export.h
      wifi: ath9k: Add missing include of export.h
      wifi: ath10k: Add missing include of export.h
      wifi: ath11k: Add missing include of export.h
      wifi: ath12k: Add missing include of export.h
      wifi: ath12k: pack HTT pdev rate stats structs
      wifi: ath10k: Prefer {} to {0} in initializers
      wifi: ath11k: Prefer {} to {0} in initializers
      wifi: ath12k: Prefer {} to {0} in initializers

Jeff Layton (10):
      ref_tracker: don't use %pK in pr_ostream() output
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: have callers pass output function to pr_ostream()
      ref_tracker: add a static classname string to each ref_tracker_dir
      ref_tracker: allow pr_ostream() to print directly to a seq_file
      ref_tracker: automatically register a file in debugfs for a ref_tracker_dir
      ref_tracker: add a way to create a symlink to the ref_tracker_dir debugfs file
      net: add symlinks to ref_tracker_dir for netns
      ref_tracker: eliminate the ref_tracker_dir name field
      ref_tracker: do xarray and workqueue job initializations earlier

Jeremy Kerr (14):
      net: mctp: don't use source cb data when forwarding, ensure pkt_type is set
      net: mctp: test: make cloned_frag buffers more appropriately-sized
      net: mctp: separate routing database from routing operations
      net: mctp: separate cb from direct-addressing routing
      net: mctp: test: Add an addressed device constructor
      net: mctp: test: Add extaddr routing output test
      net: mctp: test: move functions into utils.[ch]
      net: mctp: test: add sock test infrastructure
      net: mctp: test: Add initial socket tests
      net: mctp: pass net into route creation
      net: mctp: remove routes by netid, not by device
      net: mctp: allow NL parsing directly into a struct mctp_route
      net: mctp: add gateway routing support
      net: mctp: test: Add tests for gateway routes

Jesper Dangaard Brouer (2):
      page_pool: import Jesper's page_pool benchmark
      net: track pfmemalloc drops via SKB_DROP_REASON_PFMEMALLOC

Jesse Brandeburg (1):
      ice: convert ice_add_prof() to bitmap

Jian Shen (4):
      net: hns3: clean up the build warning in debugfs by use seq file
      net: hns3: use seq_file for files in queue/ in debugfs
      net: hns3: use seq_file for files in tm/ in debugfs
      net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in debugfs

Jianbo Liu (4):
      xfrm: hold device only for the asynchronous decryption
      xfrm: Skip redundant statistics update for crypto offload
      net/mlx5: Add IFC bits to support RSS for IPSec offload
      net/mlx5e: Remove skb secpath if xfrm state is not found

Jiasheng Jiang (1):
      iwlwifi: Add missing check for alloc_ordered_workqueue

Jiayuan Chen (3):
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls
      selftests/bpf: Add test to cover ktls with bpf_msg_pop_data

Jijie Shao (12):
      net: hns3: fix spelling mistake "reg_um" -> "reg_num"
      net: hns3: use hns3_get_ae_dev() helper to reduce the unnecessary middle layer conversion
      net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle layer conversion
      net: hns3: add complete parentheses for some macros
      net: hibmcge: support scenario without PHY
      net: hibmcge: adjust the burst len configuration of the MAC controller to improve TX performance.
      net: hibmcge: configure FIFO thresholds according to the MAC controller documentation
      net: hns3: remove tx spare info from debugfs.
      net: hns3: use seq_file for files in common/ of hns3 layer
      net: hns3: use seq_file for files in reg/ in debugfs
      net: hns3: use seq_file for files in fd/ in debugfs
      net: hibmcge: support for statistics of reset failures

Jimmy Assarsson (21):
      can: kvaser_pciefd: Add support to control CAN LEDs on device
      can: kvaser_pciefd: Add support for ethtool set_phys_id()
      can: kvaser_pciefd: Add intermediate variable for device struct in probe()
      can: kvaser_pciefd: Store the different firmware version components in a struct
      can: kvaser_pciefd: Store device channel index
      can: kvaser_pciefd: Split driver into C-file and header-file.
      can: kvaser_pciefd: Add devlink support
      can: kvaser_pciefd: Expose device firmware version via devlink info_get()
      can: kvaser_pciefd: Add devlink port support
      Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
      can: kvaser_usb: Add support to control CAN LEDs on device
      can: kvaser_usb: Add support for ethtool set_phys_id()
      can: kvaser_usb: Assign netdev.dev_port based on device channel index
      can: kvaser_usb: Add intermediate variables
      can: kvaser_usb: Move comment regarding max_tx_urbs
      can: kvaser_usb: Store the different firmware version components in a struct
      can: kvaser_usb: Store additional device information
      can: kvaser_usb: Add devlink support
      can: kvaser_usb: Expose device information via devlink info_get()
      can: kvaser_usb: Add devlink port support
      Documentation: devlink: add devlink documentation for the kvaser_usb driver

Jiri Pirko (2):
      net/mlx5: Expose serial numbers in devlink info
      netdevsim: add fw_update_flash_chunk_time_ms debugfs knobs

Jiri Slaby (SUSE) (1):
      net: Use dev_fwnode()

Johan Hovold (10):
      wifi: ath11k: fix suspend use-after-free after probe failure
      wifi: ath11k: fix dest ring-buffer corruption
      wifi: ath11k: use plain access for descriptor length
      wifi: ath11k: use plain accesses for monitor descriptor
      wifi: ath11k: fix source ring-buffer corruption
      wifi: ath11k: fix dest ring-buffer corruption when ring is full
      wifi: ath12k: fix dest ring-buffer corruption
      wifi: ath12k: use plain access for descriptor length
      wifi: ath12k: fix source ring-buffer corruption
      wifi: ath12k: fix dest ring-buffer corruption when ring is full

Johannes Berg (58):
      wifi: iwlwifi: pcie: add missing TOP reset code
      Merge tag 'ath-next-20250624' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2025-06-25' of https://github.com/pkshih/rtw
      wifi: iwlwifi: pcie: initiate TOP reset if requested
      wifi: iwlwifi: mld: fix misspelling of 'established'
      wifi: iwlwifi: pcie: reinit device properly during TOP reset
      wifi: iwlwifi: pcie: abort D3 handshake on error
      wifi: iwlwifi: mld: add timer host wakeup debugfs
      wifi: iwlwifi: mld: remove special FW error resume handling
      wifi: iwlwifi: mld: fix last_mlo_scan_time type
      wifi: iwlwifi: defer MLO scan after link activation
      wifi: iwlwifi: dvm: fix some kernel-doc issues
      wifi: iwlwifi: pcie: fix kernel-doc warnings
      wifi: iwlwifi: mei: fix kernel-doc warnings
      wifi: iwlwifi: mvm: fix kernel-doc warnings
      wifi: iwlwifi: mld: make PHY config a debug message
      wifi: iwlwifi: fw: make PNVM version a debug message
      wifi: iwlwifi: make FSEQ version a debug message
      wifi: iwlwifi: add HE 1024QAM for <242-tone RU for PE
      wifi: iwlwifi: pcie: fix non-MSIX handshake register
      wifi: iwlwifi: mld: ftm: fix switch end indentation
      Merge tag 'iwlwifi-next-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'mt76-next-2025-07-07' of https://github.com/nbd168/wireless
      wifi: iwlwifi: use PNVM data embedded in .ucode files
      wifi: iwlwifi: mvm/mld: make PHC messages debug messages
      wifi: iwlwifi: remove Intel driver load message
      wifi: iwlwifi: match discrete/integrated to fix some names
      wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument
      Merge tag 'iwlwifi-next-2025-07-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: mac80211: remove spurious blank line
      wifi: mac80211: fix deactivated link CSA
      wifi: cfg80211: hide scan internals
      wifi: nl80211: make nl80211_check_scan_flags() type safe
      wifi: mac80211: remove DISALLOW_PUNCTURING_5GHZ code
      wifi: mac80211: send extended MLD capa/ops if AP has it
      wifi: mac80211: don't complete management TX on SAE commit
      wifi: iwlwifi: pcie: accept new devices for MVM-only configs
      wifi: iwlwifi: mvm: remove regulatory puncturing setup
      wifi: iwlwifi: mld: restrict puncturing disable to FM
      wifi: iwlwifi: fix HE/EHT capabilities
      wifi: iwlwifi: pcie: don't WARN on bad firmware input
      wifi: iwlwifi: mvm: remove extra link ID
      wifi: iwlwifi: mvm/mld: use average RSSI for beacons
      wifi: mac80211: make VHT opmode NSS ignore a debug message
      wifi: mac80211: don't unreserve never reserved chanctx
      wifi: mac80211: remove ieee80211_link_unreserve_chanctx() return value
      wifi: mac80211: don't send keys to driver when fips_enabled
      wifi: mac80211: clean up cipher suite handling
      wifi: mac80211: simplify __ieee80211_rx_h_amsdu() loop
      wifi: mac80211: don't use TPE data from assoc response
      Merge tag 'iwlwifi-next-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'rtw-next-2025-07-18' of https://github.com/pkshih/rtw
      wifi: cfg80211/mac80211: remove wrong scan request n_channels
      wifi: cfg80211: reject HTC bit for management frames
      Merge tag 'ath-next-20250721' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
      wifi: mac80211: fix WARN_ON for monitor mode on some devices
      wifi: iwlwifi: disable certain features for fips_enabled
      Merge tag 'iwlwifi-next-2025-07-23' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

John Fraker (5):
      gve: Add device option for nic clock synchronization
      gve: Add adminq command to report nic timestamp
      gve: Add rx hardware timestamp expansion
      gve: Implement ndo_hwtstamp_get/set for RX timestamping
      gve: Advertise support for rx hardware timestamping

John Madieu (1):
      dt-bindings: net: renesas-gbeth: Add support for RZ/G3E (R9A09G047) SoC

Jonas Rebmann (1):
      net: fec: allow disable coalescing

Jordan Rife (12):
      bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
      bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
      bpf: tcp: Get rid of st_bucket_done
      bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
      bpf: tcp: Avoid socket skips and repeats during iteration
      selftests/bpf: Add tests for bucket resume logic in listening sockets
      selftests/bpf: Allow for iteration over multiple ports
      selftests/bpf: Allow for iteration over multiple states
      selftests/bpf: Make ehash buckets configurable in socket iterator tests
      selftests/bpf: Create established sockets in socket iterator tests
      selftests/bpf: Create iter_tcp_destroy test program
      selftests/bpf: Add tests for bucket resume logic in established sockets

Joshua Hay (6):
      idpf: use reserved RDMA vectors from control plane
      idpf: implement core RDMA auxiliary dev create, init, and destroy
      idpf: implement RDMA vport auxiliary dev create, init, and destroy
      idpf: implement remaining IDC RDMA core callbacks and handlers
      idpf: implement IDC vport aux driver MTU change handler
      idpf: implement get LAN MMIO memory regions

Joshua Washington (8):
      gve: rename gve_xdp_xmit to gve_xdp_xmit_gqi
      gve: refactor DQO TX methods to be more generic for XDP
      gve: add XDP_TX and XDP_REDIRECT support for DQ RDA
      gve: deduplicate xdp info and xsk pool registration logic
      gve: merge xdp and xsk registration
      gve: keep registry of zc xsk pools in netdev_priv
      gve: implement DQO TX datapath for AF_XDP zero-copy
      gve: implement DQO RX datapath and control path for AF_XDP zero-copy

Jun Miao (1):
      net: usb: Convert tasklet API to new bottom half workqueue mechanism

Justin Lai (2):
      rtase: Link IRQs to NAPI instances
      rtase: Link queues to NAPI instances

Kamil Horák - 2N (4):
      net: phy: MII-Lite PHY interface mode
      dt-bindings: ethernet-phy: add MII-Lite phy interface type
      net: phy: bcm5481x: MII-Lite activation
      net: phy: bcm54811: PHY initialization

Kang Yang (2):
      wifi: ath12k: update channel list in worker when wait flag is set
      wifi: ath10k: shutdown driver when hardware is unreliable

Karol Kolacinski (12):
      ice: change SMA pins to SDP in PTP API
      ice: add ice driver PTP pin documentation
      ice: move TSPLL functions to a separate file
      ice: rename TSPLL and CGU functions and definitions
      ice: remove ice_tspll_params_e825 definitions
      ice: use designated initializers for TSPLL consts
      ice: add TSPLL log config helper
      ice: use bitfields instead of unions for CGU regs
      ice: add multiple TSPLL helpers
      ice: wait before enabling TSPLL
      ice: fall back to TCXO on TSPLL lock fail
      ice: move TSPLL init calls to ice_ptp.c

Karthik M (1):
      wifi: ath12k: disable pdev for non supported country

Karthikeyan Kathirvel (2):
      wifi: ath12k: Decrement TID on RX peer frag setup error handling
      wifi: ath12k: allow beacon protection keys to be installed in hardware

Kavita Kavita (2):
      wifi: cfg80211: Improve the documentation for NL80211_CMD_ASSOC_MLO_RECONF
      wifi: cfg80211: Add support for link reconfiguration negotiation offload to driver

Kees Cook (6):
      wifi: mac80211: Write cnt before copying in ieee80211_copy_rnr_beacon()
      wifi: nl80211: Set num_sub_specs before looping through sub_specs
      wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
      ipv6: Add sockaddr_inet unified address structure
      wireguard: peer: Replace sockaddr with sockaddr_inet
      sctp: Replace sockaddr with sockaddr_inet in sctp_addr union

Kevin Yang (1):
      gve: Add support to query the nic clock

Khaled Elnaggar (1):
      can: janz-ican3: use sysfs_emit() in fwinfo_show()

Kiran K (4):
      Bluetooth: btintel_pcie: Add support for device 0x4d76
      Bluetooth: btintel: Define a macro for Intel Reset vendor command
      Bluetooth: btintel_pcie: Make driver wait for alive interrupt
      Bluetooth: btintel_pcie: Fix Alive Context State Handling

Koen De Schepper (1):
      sched: Add enqueue/dequeue of dualpi2 qdisc

Kohei Enju (2):
      igbvf: remove unused interrupt counter fields from struct igbvf_adapter
      igbvf: add tx_timeout_count to ethtool statistics

Kory Maincent (4):
      net: pse-pd: Fix ethnl_pse_send_ntf() stub parameter type
      ethtool: pse-pd: Add missing linux/export.h include
      dt-bindings: pse: tps23881: Clarify channels property description
      net: pse-pd: tps23881: Clarify setup_pi_matrix callback documentation

Kory Maincent (Dent Project) (13):
      net: pse-pd: Introduce attached_phydev to pse control
      net: pse-pd: Add support for reporting events
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add helper to report hardware enable status of the PI
      net: pse-pd: Add support for budget evaluation strategies
      net: ethtool: Add PSE port priority support feature
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      net: pse-pd: pd692x0: Add support for controller and manager power supplies
      dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
      net: pse-pd: tps23881: Add support for static port priority feature
      dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description

Kuan-Chung Chen (6):
      wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA
      wifi: rtw89: 8852c: increase beacon loss to 6 seconds
      wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register value
      wifi: rtw89: 8922a: pass channel information when enter LPS
      wifi: rtw89: mac: differentiate mem_page_size by chip generation
      wifi: rtw89: dynamically update EHT preamble puncturing

Kuniyuki Iwashima (40):
      af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
      af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
      af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
      af_unix: Use cached value for SOCK_STREAM in unix_inq_len().
      af_unix: Cache state->msg in unix_stream_read_generic().
      af_unix: Introduce SO_INQ.
      selftest: af_unix: Add test for SO_INQ.
      ipv6: ndisc: Remove __in6_dev_get() in pndisc_{constructor,destructor}().
      ipv6: mcast: Replace locking comments with lockdep annotations.
      ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in __ipv6_dev_mc_inc().
      ipv6: mcast: Remove mca_get().
      ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
      ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
      ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
      ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
      ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
      ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
      ipv6: anycast: Don't use rtnl_dereference().
      ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
      ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
      ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
      ipv6: Remove setsockopt_needs_rtnl().
      dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
      neighbour: Make neigh_valid_get_req() return ndmsg.
      neighbour: Move two validations from neigh_get() to neigh_valid_get_req().
      neighbour: Allocate skb in neigh_get().
      neighbour: Move neigh_find_table() to neigh_get().
      neighbour: Split pneigh_lookup().
      neighbour: Annotate neigh_table.phash_buckets and pneigh_entry.next with __rcu.
      neighbour: Free pneigh_entry after RCU grace period.
      neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
      neighbour: Convert RTM_GETNEIGH to RCU.
      neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
      neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
      neighbour: Remove __pneigh_lookup().
      neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_lookup().
      neighbour: Protect tbl->phash_buckets[] with a dedicated mutex.
      neighbour: Update pneigh_entry in pneigh_create().
      bpf: Disable migration in nf_hook_run_bpf().
      neighbour: Fix null-ptr-deref in neigh_flush_dev().

Kyle Hendry (7):
      net: dsa: b53: Add phy_enable(), phy_disable() methods
      dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
      net: dsa: b53: Define chip IDs for more bcm63xx SoCs
      net: dsa: b53: mmap: Add syscon reference and register layout for bcm63268
      net: dsa: b53: mmap: Add register layout for bcm6318
      net: dsa: b53: mmap: Add register layout for bcm6368
      net: dsa: b53: mmap: Implement bcm63xx ephy power control

Lachlan Hodges (8):
      wifi: cfg80211: support configuration of S1G station capabilities
      wifi: mac80211: handle station association response with S1G
      wifi: mac80211: add support for storing station S1G capabilities
      wifi: mac80211: add support for S1G aggregation
      wifi: cfg80211: support configuring an S1G short beaconing BSS
      wifi: mac80211: support initialising an S1G short beaconing BSS
      wifi: mac80211: support initialising current S1G short beacon index
      wifi: mac80211: support returning the S1G short beacon skb

Lama Kayal (4):
      net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
      net/mlx5e: SHAMPO, Cleanup reservation size formula
      net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
      net/mlx5e: Remove duplicate mkey from SHAMPO header

Lance Yang (1):
      netfilter: load nf_log_syslog on enabling nf_conntrack_log_invalid

Lee Trager (6):
      eth: fbnic: Fix incorrect minimum firmware version
      eth: fbnic: Use FIELD_PREP to generate minimum firmware version
      eth: fbnic: Create ring buffer for firmware logs
      eth: fbnic: Add mailbox support for firmware logs
      eth: fbnic: Enable firmware logging
      eth: fbnic: Create fw_log file in DebugFS

Leon Romanovsky (1):
      net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Leon Yen (1):
      wifi: mt76: mt7921s: Introduce SDIO WiFi/BT combo module card reset

Li Shuang (1):
      selftests: tc: Add generic erspan_opts matching support for tc-flower

Liming Wu (1):
      virtio_net: simplify tx queue wake condition check

Linus Walleij (3):
      dt-bindings: dsa: Rewrite Micrel KS8995 in schema
      ARM: dts: Fix up wrv54g device tree
      net: dt-bindings: ixp4xx-ethernet: Support fixed links

Liu Song (1):
      wifi: brcmsmac: Use str_true_false() helper

Lorenzo Bianconi (11):
      net: airoha: Add PPPoE offload support
      net: airoha: Get rid of dma_sync_single_for_device() in airoha_qdma_fill_rx_queue()
      wifi: mt76: mt7996: Fix secondary link lookup in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Rely on for_each_sta_active_link() in mt7996_mcu_sta_mld_setup_tlv()
      wifi: mt76: mt7996: Do not set wcid.sta to 1 in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Fix mlink lookup in mt7996_tx_prepare_skb
      wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()
      wifi: mt76: mt7996: Fix valid_links bitmask in mt7996_mac_sta_{add,remove}
      wifi: mt76: mt7996: Add MLO support to mt7996_tx_check_aggr()
      wifi: mt76: mt7996: Move num_sta accounting in mt7996_mac_sta_{add,remove}_links
      wifi: mt76: Get rid of dma_sync_single_for_device() for MMIO devices

Lucien.Jheng (1):
      net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.

Luigi Leonardi (2):
      vsock/test: Add macros to identify transports
      vsock/test: Add test for null ptr deref when transport changes

Luis Felipe Hernandez (1):
      docs: Fix kernel-doc error in CAN driver

Luiz Augusto von Dentz (1):
      Bluetooth: btintel_pcie: Reword restart to recovery

Luo Jie (4):
      net: phy: qcom: Add PHY counter support
      net: phy: qcom: qca808x: Support PHY counter
      net: phy: qcom: qca807x: Support PHY counter
      net: phy: qcom: qca807x: Enable WoL support using shared library

MD Danish Anwar (1):
      net: ti: icssg-prueth: Read firmware-names from device tree

Maharaja Kennadyrajan (6):
      wifi: ath12k: Add support to TDMA and MLO stats
      wifi: ath12k: Add support to RTT stats
      wifi: mac80211: use RCU-safe iteration in ieee80211_csa_finish
      wifi: mac80211: Add link iteration macro for link data with rcu_dereference
      wifi: mac80211: extend beacon monitoring for MLO
      wifi: mac80211: extend connection monitoring for MLO

Maor Gottlieb (1):
      net/mlx5: Warn when write combining is not supported

Marc Kleine-Budde (17):
      Merge patch series "can: netlink: preparation before introduction of CAN XL"
      Merge patch series "can: add drop reasons in the receive path"
      Merge patch series "can: rcar_canfd: Add support for Transceiver Delay Compensation"
      net: fec: fix typos found by codespell
      net: fec: struct fec_enet_private: remove obsolete comment
      net: fec: switch from asm/cacheflush.h to linux/cacheflush.h
      net: fec: sort the includes by alphabetic order
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info
      net: fec: fec_restart(): introduce a define for FEC_ECR_SPEED
      net: fec: fec_enet_rx_queue(): use same signature as fec_enet_tx_queue()
      net: fec: fec_enet_rx_queue(): replace manual VLAN header calculation with skb_vlan_eth_hdr()
      net: fec: fec_enet_rx_queue(): reduce scope of data
      net: fec: fec_enet_rx_queue(): move_call to _vlan_hwaccel_put_tag()
      net: fec: fec_enet_rx_queue(): factor out VLAN handling into separate function fec_enet_rx_vlan()
      Merge patch series "can: Kconfig: add missing COMPILE_TEST"
      Merge patch series "can: kvaser_pciefd: Simplify identification of physical CAN interfaces"
      Merge patch series "can: kvaser_usb: Simplify identification of physical CAN interfaces"

Mark Zhang (1):
      net/mlx4e: Don't redefine IB_MTU_XXX enum

Martin KaFai Lau (1):
      Merge branch 'bpf-tcp-exactly-once-socket-iteration'

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Martyna Szapar-Mudlaw (2):
      ice: add link_down_events statistic
      ixgbe: add link_down_events statistic

Matt Johnston (8):
      net: mctp: mctp_test_route_extaddr_input cleanup
      net: mctp: Prevent duplicate binds
      net: mctp: Treat MCTP_NET_ANY specially in bind()
      net: mctp: Add test for conflicting bind()s
      net: mctp: Use hashtable for binds
      net: mctp: Allow limiting binds to a peer address
      net: mctp: Test conflicts of connect() with bind()
      net: mctp: Add bind lookup test

Matthew Gerlach (3):
      dt-bindings: net: Convert socfpga-dwmac bindings to yaml
      dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems to iommus
      dt-bindings: net: altr,socfpga-stmmac: Add compatible string for Agilex5

Matthias Schiffer (4):
      batman-adv: store hard_iface as iflink private data
      dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
      net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
      checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes

Matti Vaittinen (1):
      net: gianfar: Use device_get_named_child_node_count()

Mengyuan Lou (12):
      net: libwx: add mailbox api for wangxun vf drivers
      net: libwx: add base vf api for vf drivers
      net: libwx: add wangxun vf common api
      net: wangxun: add txgbevf build
      net: txgbevf: add sw init pci info and reset hardware
      net: txgbevf: init interrupts and request irqs
      net: txgbevf: Support Rx and Tx process path
      net: txgbevf: add link update flow
      net: wangxun: add ngbevf build
      net: ngbevf: add sw init pci info and reset hardware
      net: ngbevf: init interrupts and request irqs
      net: ngbevf: add link update flow

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath11k-pci: describe firmware-name property
      wifi: ath11k: support usercase-specific firmware overrides

Michael Guralnik (1):
      net/mlx5: Expose HCA capability bits for mkey max page size

Michael-CY Lee (2):
      wifi: mac80211: determine missing link_id in ieee80211_rx_for_interface() based on frequency
      wifi: cfg80211/mac80211: report link ID for unexpected frames

Michal Kubiak (1):
      ice: add a separate Rx handler for flow director commands

Michal Luczaj (7):
      vsock/test: Introduce vsock_bind_try() helper
      vsock/test: Introduce get_transports()
      vsock/test: Cover more CIDs in transport_uaf test
      net: splice: Drop unused @pipe
      net: splice: Drop unused @gfp
      net: skbuff: Drop unused @skb
      net: skbuff: Drop unused @skb

Michal Swiatkowski (8):
      ice, libie: move generic adminq descriptors to lib
      ixgbe: use libie adminq descriptors
      i40e: use libie adminq descriptors
      iavf: use libie adminq descriptors
      libie: add adminq helper for converting err to str
      ice: use libie_aq_str
      iavf: use libie_aq_str
      i40e: use libie_aq_str

Milena Olech (1):
      idpf: add cross timestamping

Mina Almasry (6):
      netmem: fix netmem comments
      selftests: devmem: remove unused variable
      selftests: devmem: add ipv4 support to chunks test
      netmem: fix skb_frag_address_safe with unreadable skbs
      selftests: pp-bench: remove unneeded linux/version.h
      selftests: pp-bench: remove page_pool_put_page wrapper

Ming Yen Hsieh (1):
      wifi: mt76: mt792x: improve monitor interface handling

Mingming Cao (2):
      ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
      ibmveth: Add multi buffers rx replenishment hcall support

Miri Korenblit (54):
      wifi: iwlwifi: mld: remove unneeded compilations
      wifi: iwlwifi: move iwl-context-info header files
      wifi: iwlwifi: bump minimum API version in BZ/SC/DR
      wifi: iwlwifi: pcie: move generation specific files to a folder
      wifi: iwlwifi: support RZL platform device ID
      wifi: iwlwifi: mld: make iwl_mld_add_all_rekeys void
      wifi: iwlwifi: mld: don't exit EMLSR when we shouldn't
      MAINTAINERS: update iwlwifi git link
      wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
      wifi: iwlwifi: pcie move common probe logic
      wifi: iwlwifi: trans: remove iwl_trans_init
      wifi: iwlwifi: mvm: remove MLO GTK rekey code
      wifi: iwlwifi: mvm: remove unneeded argument
      wifi: iwlwifi: bump minimum API version in BZ
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4
      wifi: mac80211: avoid weird state in error path
      wifi: mac80211: verify state before connection
      wifi: iwlwifi: handle non-overlapping API ranges
      wifi: iwlwifi: assign a FW API range for JF
      wifi: iwlwifi: bump minimum API version for SO/MA/TY
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
      wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v9
      wifi: iwlwifi: assign a FW API range for HR
      wifi: iwlwifi: assign a FW API range for GF
      wifi: iwlwifi: pcie: add a missing include
      wifi: iwlwifi: mvm: set gtk id also in older FWs
      wifi: iwlwifi: mvm: always set the key idx in gtk_seq
      wifi: iwlwifi: mvm: don't remove all keys in mcast rekey
      wifi: iwlwifi: mld: don't remove all keys in mcast rekey
      wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD ver 6 and 7
      wifi: iwlwifi: mld: remove support for REDUCE_TX_POWER_CMD ver 9
      wifi: iwlwifi: remove an unused struct
      wifi: iwlwifi: mld: remove support for iwl_geo_tx_power_profiles_cmd version 4
      wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: add kunit test for emlsr with bt on"
      wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON"
      wifi: iwlwifi: mld: remove support for iwl_mcc_update_resp versions
      wifi: iwlwifi: remove support of versions 4 and 5 of iwl_alive_ntf
      wifi: iwlwifi: remove support of version 4 of iwl_wowlan_rsc_tsc_params_cmd
      wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions
      wifi: mac80211: only assign chanctx in reconfig
      wifi: mac80211: don't mark keys for inactive links as uploaded
      wifi: mac80211: handle WLAN_HT_ACTION_NOTIFY_CHANWIDTH async
      wifi: mac80211: remove ieee80211_remove_key
      wifi: mac80211: don't require cipher and keylen in gtk rekey
      wifi: iwlwifi: mld: disable RX aggregation if requested
      wifi: iwlwifi: remove SC2F firmware support
      wifi: iwlwifi: stop supporting iwl_omi_send_status_notif ver 1
      wifi: iwlwifi: Remove support for rx OMI bandwidth reduction
      wifi: iwlwifi: mld: use spec link id and not FW link id
      wifi: iwlwifi: don't export symbols that we shouldn't
      wifi: iwlwifi: check validity of the FW API range
      wifi: iwlwifi: Revert "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"

Miroslav Lichvar (1):
      testptp: add option to enable external timestamping edges

Mohsin Bashir (8):
      eth: Update rmon hist range
      eth: fbnic: Expand coverage of mac stats
      selftests: drv-net: Add bpftool util
      selftests: drv-net: Test XDP_PASS/DROP support
      selftests: drv-net: Test XDP_TX support
      selftests: drv-net: Test tail-adjustment support
      selftests: drv-net: Test head-adjustment support
      selftests: drv-net: Wait for bkg socat to start

Moon Hee Lee (1):
      wifi: mac80211: reject TDLS operations when station is not associated

Moon Yeounsu (1):
      net: dlink: enable RMON MMIO access on supported devices

Moshe Shemesh (2):
      net/mlx5: Add HWS as secondary steering mode
      net/mlx5e: fix kdoc warning on eswitch.h

Mun Yew Tham (1):
      net: stmmac: dwmac-socfpga: Add xgmac support for Agilex5

Murad Masimov (1):
      wifi: plfxlc: Fix error handling in usb driver probe

Nagamani PV (1):
      s390/net: Remove NETIUCV device driver

Nam Cao (2):
      irqdomain: Export irq_domain_free_irqs_top()
      PCI: hv: Switch to msi_create_parent_irq_domain()

Nathan Chancellor (1):
      wifi: brcmsmac: Remove const from tbl_ptr parameter in wlc_lcnphy_common_read_table()

Nathan Lynch (1):
      lib: packing: Include necessary headers

Neal Cardwell (3):
      tcp: remove obsolete and unused RFC3517/RFC6675 loss recovery code
      tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
      tcp: remove RFC3517/RFC6675 tcp_clear_retrans_hints_partial()

Neeraj Sanjay Kale (4):
      dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
      Bluetooth: btnxpuart: Add support for 4M baudrate
      Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
      Bluetooth: btnxpuart: Add uevents for FW dump and FW download complete

Nicolas Dichtel (1):
      ip6_tunnel: enable to change proto of fb tunnels

Nicolas Escande (1):
      neighbour: add support for NUD_PERMANENT proxy entries

Nikunj Kela (1):
      net: stmmac: extend use of snps,multicast-filter-bins property to xgmac

Nithyanantham Paramasivam (3):
      wifi: ath12k: Fix the handling of TX packets in Ethernet mode
      wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
      wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211

Oleksij Rempel (13):
      net: phy: micrel: add MDI/MDI-X control support for KSZ9477 switch-integrated PHYs
      net: phy: micrel: Add RX error counter support for KSZ9477 switch-integrated PHYs
      net: phy: micrel: add cable test support for KSZ9477-class PHYs
      net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management
      net: usb: lan78xx: Rename EVENT_LINK_RESET to EVENT_PHY_INT_ACK
      net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
      net: usb: lan78xx: port link settings to phylink API
      net: usb: lan78xx: Integrate EEE support with phylink LPI API
      net: usb: lan78xx: remove unused struct members
      net: usb: lan78xx: fix possible NULL pointer dereference in lan78xx_phy_init()
      phy: micrel: add Signal Quality Indicator (SQI) support for KSZ9477 switch PHYs
      net: selftests: add PHY-loopback test for bad TCP checksums
      net: usb: smsc95xx: add support for ethtool pause parameters

Oliver Neukum (1):
      net: usb: cdc-ncm: check for filtering capability

Or Ron (1):
      wifi: iwlwifi: phy periph read - flow modification

Oren Sidi (2):
      net/mlx5: Add IFC bits and enums for buf_ownership
      net/mlx5: Expose cable_length field in PFCC register

Oscar Maes (2):
      net: ipv4: fix incorrect MTU in broadcast routes
      selftests: net: add test for variable PMTU in broadcast routes

P Praneesh (3):
      wifi: ath12k: remove monitor handling from ath12k_dp_rx_deliver_msdu()
      wifi: ath12k: Fix double budget decrement while reaping monitor ring
      wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM error path

Pablo Neira Ayuso (2):
      netfilter: conntrack: remove DCCP protocol support
      netfilter: Exclude LEGACY TABLES on PREEMPT_RT.

Pagadala Yesu Anjaneyulu (8):
      wifi: iwlwifi: parse VLP AP not allowed nvm channel flag
      wifi: iwlwifi: Remove unused cfg parameter from iwl_nvm_get_regdom_bw_flags
      wifi: iwlwifi: add support for the devcoredump
      wifi: iwlwifi: mld: Add dump handler to iwl_mld
      wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect
      wifi: iwlwifi: add support for accepting raw DSM tables by firmware
      wifi: iwlwifi: mvm: remove IWL_MVM_ESR_EXIT_FAIL_ENTRY
      wifi: iwlwifi: mvm: Add dump handler to iwl_mvm

Paolo Abeni (38):
      Merge branch 'intel-next-queue-1GbE'
      Merge branch 'support-bandwidth-clamping-in-mana-using-net-shapers'
      Merge branch 'selftests-net-use-slowwait-to-make-sure-setup-finished'
      Merge branch 'add-support-for-25g-50g-and-100g-to-fbnic'
      Merge branch 'pse-improve-documentation-clarity'
      udp_tunnel: fix deadlock in udp_tunnel_nic_set_port_priv()
      Merge branch 'follow-up-to-rgmii-mode-clarification-am65-cpsw-fix-checkpatch'
      Merge branch 'eth-fbnic-trivial-code-tweaks'
      Merge branch 'clean-up-usage-of-ffi-types'
      Merge tag 'ktime-get-clock-ts64-for-ptp' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
      Merge branch 'ptp-provide-support-for-auxiliary-clocks-for-ptp_sys_offset_extended'
      Merge branch 'another-ip-sysctl-docs-cleanup'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-broadcast_neighbor-for-no-stacking-networking-arch'
      Merge branch 'net-mctp-add-support-for-gateway-routing'
      scripts/kernel_doc.py: properly handle VIRTIO_DECLARE_FEATURES
      virtio: introduce extended features
      virtio_pci_modern: allow configuring extended features
      vhost-net: allow configuring extended features
      virtio_net: add supports for extended offloads
      net: implement virtio helpers to handle UDP GSO tunneling.
      virtio_net: enable gso over UDP tunnel support.
      tun: enable gso over UDP tunnel support.
      vhost/net: enable gso over UDP tunnel support.
      Merge branch 'net-dsa-rzn1_a5psw-add-compile_test'
      Merge branch 'net-mctp-improved-bind-handling'
      tcp: fix UaF in tcp_prune_ofo_queue()
      Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux
      Merge tag 'wireless-next-2025-07-17' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'dpll-zl3073x-add-misc-features'
      Merge branch 'ppp-replace-per-cpu-recursion-counter-with-lock-owner-field'
      Merge branch 'gve-af_xdp-zero-copy-for-dqo-rda'
      Merge branch 'octeontx2-af-rpm-misc-feaures'
      tcp: do not set a zero size receive buffer
      tcp: do not increment BeyondWindow MIB for old seq
      Merge tag 'ipsec-next-2025-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      mptcp: track fallbacks accurately via mibs
      mptcp: remove pr_fallback()

Patrisious Haddad (2):
      net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
      net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow

Paul Chaignon (2):
      bpf: Reject narrower access to pointer ctx fields
      selftests/bpf: Test invalid narrower ctx load

Paul Geurts (2):
      dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction-db option
      NFC: trf7970a: Create device-tree parameter for RX gain reduction

Paul Greenwalt (1):
      ixgbe: add MDD support

Paul Kocialkowski (1):
      dt-bindings: net: sun8i-emac: Add A100 EMAC compatible

Pauli Virtanen (1):
      Bluetooth: ISO: add socket option to report packet seqnum via CMSG

Pavel Begunkov (1):
      net: timestamp: add helper returning skb's tx tstamp

Pei Xiao (1):
      wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags

Peiyang Wang (2):
      net: hns3: add \n at the end when print msg
      net: hns3: clear hns alarm: comparison of integer expressions of different signedness

Petr Machata (16):
      net: ipv4: Add a flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()
      net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
      net: ipv4: ipmr: Split ipmr_queue_xmit() in two
      net: ipv4: Add ip_mr_output()
      net: ipv6: Make udp_tunnel6_xmit_skb() void
      net: ipv6: Add a flags argument to ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
      net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
      net: ipv6: ip6mr: Make ip6mr_forward2() void
      net: ipv6: ip6mr: Split ip6mr_forward2() in two
      net: ipv6: Add ip6_mr_output()
      vxlan: Support MC routing in the underlay
      selftests: forwarding: lib: Move smcrouted helpers here
      selftests: net: lib: Add ip_link_has_flag()
      selftests: forwarding: adf_mcd_start(): Allow configuring custom interfaces
      selftests: forwarding: Add a test for verifying VXLAN MC underlay
      selftests: forwarding: lib: Split setup_wait()

Phil Sutter (5):
      netfilter: nf_tables: Drop dead code from fill_*_info routines
      netfilter: nf_tables: Reintroduce shortened deletion notifications
      netfilter: nfnetlink: New NFNLA_HOOK_INFO_DESC helper
      netfilter: nfnetlink_hook: Dump flowtable info
      selftests: netfilter: Ignore tainted kernels in interface stress test

Ping-Ke Shih (10):
      wifi: rtw89: rfk: support IQK firmware command v1
      wifi: rtw89: mac: add dummy handler of MAC C2H event class 27
      wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
      wifi: rtw89: 8851b: set ADC bandwidth select according to calibration value
      wifi: rtw89: 8851b: adjust ADC setting for RF calibration
      wifi: rtw89: 8851b: update NCTL 0xB
      wifi: rtw89: 8851b: rfk: update DPK to 0x11
      wifi: rtw89: 8851b: rfk: update IQK to 0x14
      wifi: rtw89: purge obsoleted scan events with software sequence number
      wifi: rtw89: check path range before using in rtw89_fw_h2c_rf_ps_info()

Pradeep Kumar Chitrapu (8):
      wifi: ath12k: push HE MU-MIMO params to hardware
      wifi: ath12k: push EHT MU-MIMO params to hardware
      wifi: ath12k: move HE MCS mapper to a separate function
      wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
      wifi: ath12k: add support for setting fixed HE rate/GI/LTF
      wifi: ath12k: clean up 80P80 support
      wifi: ath12k: add support for 160 MHz bandwidth
      wifi: ath12k: add extended NSS bandwidth support for 160 MHz

Pranav Tyagi (2):
      net/smc: replace strncpy with strscpy
      net/sched: replace strncpy with strscpy

Qianfeng Rong (5):
      wifi: ath5k: Use max() to improve code
      wifi: rtlwifi: Use min()/max() to improve code
      wifi: brcm80211: Use min() to improve code
      wifi: mwifiex: Use max_t() to improve code
      wifi: wilc1000: Use min() to improve code

Qingfang Deng (2):
      ppp: convert to percpu netstats
      pppoe: drop PACKET_OTHERHOST before skb_share_check()

Qiu Yutan (1):
      net: arp: use kfree_skb_reason() in arp_rcv()

Radoslaw Tyl (1):
      ixgbe: turn off MDD while modifying SRRCTL

Rafael Beims (1):
      wifi: mwifiex: enable host mlme on sdio W8997 chipsets

Raj Kumar Bhagat (4):
      wifi: mac80211: Allow scan on a radio while operating on DFS on another radio
      wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0
      wifi: ath12k: handle WMI event for real noise floor calculation
      wifi: ath12k: use real noise floor instead of default value

Raju Rangoju (3):
      amd-xgbe: add support for giant packet size
      and-xgbe: remove the abstraction for hwptp
      amd-xgbe: add hardware PTP timestamping support

Rameshkumar Sundaram (6):
      wifi: mac80211: Fix bssid_indicator for MBSSID in AP mode
      wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss
      wifi: ath12k: Prepare ahvif scan link for parallel scan
      wifi: ath12k: Split scan request for split band device
      wifi: ath12k: combine channel list for split-phy devices in single-wiphy
      wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP

Ramya Gnanasekar (1):
      wifi: mac80211: update radar_required in channel context after channel switch

Rand Deeb (1):
      wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()

Randy Dunlap (2):
      net: Kconfig: add endif/endmenu comments
      can: tscan1: CAN_TSCAN1 can depend on PC104

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Rob Herring (Arm) (1):
      net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"

Roopni Devanathan (4):
      wifi: cfg80211/mac80211: Add support to get radio index
      wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
      wifi: cfg80211: Report per-radio RTS threshold to userspace
      wifi: mac80211: Set RTS threshold on per-radio basis

Rosen Penev (13):
      wifi: ath9k: ahb: reorder declarations
      wifi: ath9k: ahb: reorder includes
      dt-bindings: net: wireless: ath9k: add WIFI bindings
      wifi: ath9k: ahb: replace id_table with of
      net: dsa: rzn1_a5psw: add COMPILE_TEST
      net: dsa: rzn1_a5psw: use devm to enable clocks
      wifi: rt2x00: add COMPILE_TEST
      wifi: rt2x00: remove mod_name from platform_driver
      wifi: rt2800soc: allow loading from OF
      wifi: rt2800: move 2x00soc to 2800soc
      wifi: rt2x00: soc: modernize probe
      MIPS: dts: ralink: mt7620a: add wifi
      dt-bindings: net: wireless: rt2800: add SOC Wifi

Rotem Kerem (7):
      wifi: iwlwifi: pcie: move iwl_trans_pcie_dump_regs() to utils.c
      wifi: iwlwifi: move iwl_trans_pcie_write_mem to iwl-trans.c
      wifi: iwlwifi: move _iwl_trans_set_bits_mask utilities
      wifi: iwlwifi: Add an helper function for polling bits
      wifi: iwlwifi: add suppress_cmd_error_once() API
      wifi: iwlwifi: add iwl_trans_device_enabled() API
      wifi: iwlwifi: add iwl_trans_is_dead() API

RubenKelevra (3):
      net: pfcp: fix typo in message_priority field name
      uapi: net_dropmon: drop unused is_drop_point_hw macro
      net: ieee8021q: fix insufficient table-size assertion

Ruffalo Lavoisier (1):
      iwlwifi: api: delete repeated words

Russell King (Oracle) (28):
      net: phy: simplify phy_get_internal_delay()
      net: phy: improve rgmii_clock() documentation
      net: stmmac: improve .set_clk_tx_rate() method error message
      net: stmmac: rk: add get_interfaces() implementation
      net: stmmac: rk: simplify set_*_speed()
      net: stmmac: rk: add struct for programming register based speeds
      net: stmmac: rk: combine rv1126 set_*_speed() methods
      net: stmmac: rk: combine clk_mac_speed rate setting functions
      net: stmmac: rk: combine .set_*_speed() methods
      net: stmmac: rk: simplify px30_set_rmii_speed()
      net: stmmac: rk: convert px30_set_rmii_speed() to .set_speed()
      net: stmmac: rk: remove obsolete .set_*_speed() methods
      net: stmmac: qcom-ethqos: add ethqos_pcs_set_inband()
      net: stmmac: remove pcs_get_adv_lp() support
      net: stmmac: rk: fix code formmating issue
      net: stmmac: rk: use device rather than platform device in rk_priv_data
      net: stmmac: rk: remove unnecessary clk_mac
      net: stmmac: visconti: re-arrange speed decode
      net: stmmac: visconti: reorganise visconti_eth_set_clk_tx_rate()
      net: stmmac: visconti: clean up code formatting
      net: stmmac: visconti: make phy_intf_sel local
      net: stmmac: replace ioaddr with stmmac_priv for pcs_set_ane() method
      net: stmmac: loongson1: provide match data struct
      net: stmmac: loongson1: get ls1b resource only once
      net: stmmac: lpc18xx: use plat_dat->phy_interface
      net: phylink: restrict SFP interfaces to those that are supported
      net: phylink: clear SFP interfaces when not in use
      net: phylink: add phylink_sfp_select_interface_speed()

Ryan Wanner (5):
      dt-bindings: net: cdns,macb: add sama7d65 ethernet interface
      dt-bindings: net: cdns,macb: Add external REFCLK property
      net: cadence: macb: Expose REFCLK as a device tree property
      net: cadence: macb: Enable RMII for SAMA7 gem
      net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag

Saeed Mahameed (8):
      net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
      net/mlx5e: SHAMPO: Remove redundant params
      net/mlx5e: SHAMPO: Improve hw gro capability checking
      net/mlx5e: SHAMPO: Separate pool for headers
      net/mlx5e: Convert over to netmem
      net/mlx5e: Add support for UNREADABLE netmem page pools
      net/mlx5e: Implement queue mgmt ops and single channel swap
      net/mlx5e: Support ethtool tcp-data-split settings

Sai Krishna (5):
      octeontx2-af: CN20k basic mbox operations and structures
      octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
      octeontx2-pf: CN20K mbox REQ/ACK implementation for NIC PF
      octeontx2-af: CN20K mbox implementation for AF's VF
      octeontx2-pf: CN20K mbox implementation between PF-VF

Saleemuddin Shaik (1):
      wifi: ath12k: Add support for transmit histogram stats

Samiullah Khawaja (5):
      net: stop napi kthreads when THREADED napi is disabled
      Add support to set NAPI threaded for individual NAPI
      net: Create separate gro_flush_normal function
      net: Use netif_threaded_enable instead of netif_set_threaded in drivers
      net: define an enum for the napi threaded state

Sarika Sharma (19):
      wifi: mac80211: add support towards MLO handling of station statistics
      wifi: cfg80211: add link_station_info structure to support MLO statistics
      wifi: cfg80211: extend to embed link level statistics in NL message
      wifi: cfg80211: add statistics for providing overview for MLO station
      wifi: cfg80211: allocate memory for link_station info structure
      wifi: mac80211: add support to accumulate removed link statistics
      wifi: cfg80211: clear sinfo->filled for MLO station statistics
      wifi: mac80211: extend support to fill link level sinfo structure
      wifi: mac80211: correct RX stats packet increment for multi-link
      wifi: mac80211: add link_sta_statistics ops to fill link station statistics
      wifi: ath12k: Add memset and update default rate value in wmi tx completion
      wifi: ath12k: fill link station statistics for MLO
      wifi: ath12k: add link support for multi-link in arsta
      wifi: ath12k: add EHT support for TX rate
      wifi: ath12k: correctly update bw for ofdma packets
      wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
      wifi: ath12k: properly set bit for pdev mask for firmware PPDU_STATS request
      wifi: cfg80211: fix double free for link_sinfo in nl80211_station_dump()
      wifi: ath12k: Correct tid cleanup when tid setup fails

Sean Anderson (1):
      net: phy: Don't register LEDs for genphy

Sebastian Andrzej Siewior (3):
      selftests/tc-testing: Enable CONFIG_IP_SET
      ppp: Replace per-CPU recursion counter with lock-owner field
      selftests: netfilter: Enable CONFIG_INET_SCTP_DIAG

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Seth Forshee (DigitalOcean) (1):
      bonding: don't force LACPDU tx to ~333 ms boundaries

Shahar Shitrit (1):
      net/mlx5e: Fix potential deadlock by deferring RX timeout recovery

Shannon Nelson (3):
      ionic: print firmware heartbeat as unsigned
      ionic: clean dbpage in de-init
      ionic: cancel delayed work earlier in remove

Shradha Gupta (6):
      PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
      PCI: hv: Allow dynamic MSI-X vector allocation
      net: mana: Allow irq_setup() to skip cpus for affinity
      net: mana: Allocate MSI-X vectors dynamically
      net: mana: Set tx_packets to post gso processing packet count
      net: mana: fix spelling for mana_gd_deregiser_irq()

Simon Horman (8):
      dpll: remove documentation of rclk_dev_name
      nfc: Remove checks for nla_data returning NULL
      rds: Correct endian annotation of port and addr assignments
      rds: Correct spelling
      tg3: spelling corrections
      ixgbe: spelling corrections
      octeontx2-af: use unsigned int as iterator for unsigned values
      net/sched: taprio: align entry index attr validation with mqprio

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sivashankari Madhavan (1):
      wifi: ath12k: support average ack rssi in station dump

Slawomir Mrozowicz (1):
      ixgbe: add Tx hang detection unhandled MDD

Somashekhar Puttagangaiah (2):
      wifi: mac80211: add mandatory bitrate support for 6 GHz
      wifi: cfg80211/mac80211: implement dot11ExtendedRegInfoSupport

Song Yoong Siang (3):
      doc: xdp: Clarify driver implementation for XDP Rx metadata
      igc: Relocate RSS field definitions to igc_defines.h
      igc: Add wildcard rule support to ethtool NFC using Default Queue

Sriram R (2):
      wifi: ath12k: Add support to enqueue management frame at MLD level
      wifi: ath12k: Validate peer_id before searching for peer

Stanislav Fomichev (17):
      geneve: rely on rtnl lock in geneve_offload_rx_ports
      vxlan: drop sock_lock
      udp_tunnel: remove rtnl_lock dependency
      net: remove redundant ASSERT_RTNL() in queue setup functions
      netdevsim: remove udp_ports_sleep
      Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
      team: replace team lock with rtnl lock
      net: s/dev_get_port_parent_id/netif_get_port_parent_id/
      net: s/dev_get_mac_address/netif_get_mac_address/
      net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
      net: s/__dev_set_mtu/__netif_set_mtu/
      net: s/dev_get_flags/netif_get_flags/
      net: s/dev_set_threaded/netif_set_threaded/
      net: s/dev_close_many/netif_close_many/
      macsec: set IFF_UNICAST_FLT priv flag
      selftests: rtnetlink: add macsec and vlan nesting test
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stanislaw Gruszka (1):
      wifi: iwlegacy: Check rate_idx range after addition

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

Stefano Garzarella (2):
      vsock/test: fix test for null ptr deref when transport changes
      vsock/test: fix vsock_ioctl_int() check for unsupported ioctl

Stephane Grosjean (1):
      can: peak_usb: fix USB FD devices potential malfunction

Steven Rostedt (3):
      xdp: Remove unused events xdp_redirect_map and xdp_redirect_map_err
      xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL
      net/tcp_ao: tracing: Hide tcp_ao events under CONFIG_TCP_AO

Subbaraya Sundeep (5):
      octeontx2: Annotate mmio regions as __iomem
      octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
      octeontx2: Set appropriate PF, VF masks and shifts based on silicon
      octeontx2-af: Fix rvu_mbox_init return path
      Octeontx2-af: Disable stale DMAC filters

Suchit Karunakaran (1):
      net: stream: add description for sk_stream_write_space()

Sudheer Mogilappagari (1):
      virtchnl2: add flow steering support

Sumanth Gavini (3):
      wifi: wil6210: wmi: Fix spellings reported by codespell
      wifi: ath10k: Fix Spelling
      wifi: ath6kl: Fix spellings

Taehee Yoo (1):
      eth: bnxt: add netmem TX support

Tamir Duberstein (2):
      Use unqualified references to ffi types
      Cast to the proper type

Tamizh Chelvam Raja (3):
      wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()
      wifi: ath12k: fix endianness handling while accessing wmi service bit
      wifi: ath12k: Add support to parse max ext2 wmi service bit

Tariq Toukan (1):
      net/mlx5e: RX, Remove unnecessary RQT redirects

Tejun Heo (1):
      net: tcp: tsq: Convert from tasklet to BH workqueue

Thiraviyam Mariyappan (1):
      wifi: ath12k: Clear auth flag only for actual association in security mode

Thomas Fourier (5):
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
      mwl8k: Add missing check after DMA map
      net: ag71xx: Add missing check after DMA map
      et131x: Add missing check after DMA map

Thomas Gleixner (16):
      ptp: Split out PTP_CLOCK_GETCAPS ioctl code
      ptp: Split out PTP_EXTTS_REQUEST ioctl code
      ptp: Split out PTP_PEROUT_REQUEST ioctl code
      ptp: Split out PTP_ENABLE_PPS ioctl code
      ptp: Split out PTP_SYS_OFFSET_PRECISE ioctl code
      ptp: Split out PTP_SYS_OFFSET_EXTENDED ioctl code
      ptp: Split out PTP_SYS_OFFSET ioctl code
      ptp: Split out PTP_PIN_GETFUNC ioctl code
      ptp: Split out PTP_PIN_SETFUNC ioctl code
      ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
      ptp: Split out PTP_MASK_EN_SINGLE ioctl code
      ptp: Convert chardev code to lock guards
      ptp: Simplify ptp_read()
      timekeeping: Provide ktime_get_clock_ts64()
      ptp: Use ktime_get_clock_ts64() for timestamping
      ptp: Enable auxiliary clocks for PTP_SYS_OFFSET_EXTENDED

Tianyi Cui (1):
      selftests/drivers/net: Support ipv6 for napi_id test

Ting-Ying Li (2):
      wifi: brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
      wifi: brcmfmac: fix EXTSAE WPA3 connection failure due to AUTH TX failure

Toke Høiland-Jørgensen (2):
      net: netdevsim: Support setting dev->perm_addr on port creation
      selftests: net: add netdev-l2addr.sh for testing L2 address functionality

Tonghao Zhang (3):
      net: bonding: add broadcast_neighbor option for 802.3ad
      net: bonding: add broadcast_neighbor netlink option
      net: bonding: send peer notify when failure recovery

Tristram Ha (7):
      net: dsa: microchip: Fix wrong rx drop MIB counter for KSZ8863
      dt-bindings: net: dsa: microchip: Add KSZ8463 switch support
      net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
      net: dsa: microchip: Use different registers for KSZ8463
      net: dsa: microchip: Write switch MAC address differently for KSZ8463
      net: dsa: microchip: Setup fiber ports for KSZ8463
      net: dsa: microchip: Disable PTP function of KSZ8463

Uwe Kleine-König (3):
      net: atlantic: Rename PCI driver struct to end in _driver
      net: tulip: Rename PCI driver struct to end in _driver
      Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)

Vasanthakumar Thiagarajan (1):
      wifi: cfg80211: Add utility API to get radio index from channel

Vikas Gupta (10):
      bng_en: Add PCI interface
      bng_en: Add devlink interface
      bng_en: Add firmware communication mechanism
      bng_en: Add initial interaction with firmware
      bng_en: Add ring memory allocation support
      bng_en: Add backing store support
      bng_en: Add resource management support
      bng_en: Add irq allocation support
      bng_en: Initialize default configuration
      bng_en: Add a network device

Vincent Mailhol (7):
      can: netlink: replace tabulation by space in assignment
      can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
      can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
      can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
      can: ti_hecc: fix -Woverflow compiler warning
      can: ti_hecc: Kconfig: add COMPILE_TEST
      can: tscan1: Kconfig: add COMPILE_TEST

Vishwanath Seshagiri (1):
      selftests: flip local/remote endpoints in iou-zcrx.py

Vlad Dogaru (6):
      net/mlx5: HWS, remove unused create_dest_array parameter
      net/mlx5: HWS, Export rule skip logic
      net/mlx5: HWS, Refactor rule skip logic
      net/mlx5: HWS, Create STEs directly from matcher
      net/mlx5: HWS, Decouple matcher RX and TX sizes
      net/mlx5: HWS, Track matcher sizes individually

Vladimir Oltean (5):
      ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      igc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      igb: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      ixgbe: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
      i40e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()

Wang Liang (6):
      net/smc: remove unused input parameters in smc_buf_get_slot
      net/smc: remove unused function smc_lo_supports_v2
      net: replace ADDRLABEL with dynamic debug
      net: replace ND_PRINTK with dynamic debug
      vxlan: remove redundant conversion of vni in vxlan_nl2conf
      vsock: remove unnecessary null check in vsock_getname()

WangYuli (3):
      wifi: brcmfmac: Fix typo "notifer"
      wifi: iwlwifi: Fix typo "ransport"
      ipvs: Rename del_timer in comment in ip_vs_conn_expire_now()

Wei Fang (7):
      net: enetc: replace PCVLANR1/2 with SICVLANR1/2 and remove dead branch
      net: enetc: change the statistics of ring to unsigned long type
      net: enetc: separate 64-bit counters from enetc_port_counters
      net: enetc: read 64-bit statistics from port MAC counters
      net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
      net: fec: add more macros for bits of FEC_ECR
      net: fec: add fec_set_hw_mac_addr() helper function

Willem de Bruijn (3):
      net: remove unused sock_enable_timestamps
      net: preserve MSG_ZEROCOPY with forwarding
      selftest: net: extend msg_zerocopy test with forwarding

William Liu (2):
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree
      selftests/tc-testing: Add tests for restrictions on netem duplication

Xin Guo (1):
      tcp: update the outdated ref draft-ietf-tcpm-rack

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Xuewei Niu (3):
      vsock: Add support for SIOCINQ ioctl
      test/vsock: Add retry mechanism to ioctl wrapper
      test/vsock: Add ioctl SIOCINQ tests

Yajun Deng (2):
      net: sysfs: Implement is_visible for phys_(port_id, port_name, switch_id)
      net: phy: Add c45_phy_ids sysfs directory entry

Yang Li (4):
      Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
      Bluetooth: Fix spelling mistakes
      Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
      Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections

Yedidya Benshimol (2):
      wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c
      wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers

Yevgeny Kliteynik (3):
      net/mlx5: HWS, remove incorrect comment
      net/mlx5: HWS, Rearrange to prevent forward declaration
      net/mlx5: HWS, Shrink empty matchers

Yi Chen (1):
      selftests: netfilter: ipvs.sh: Explicity disable rp_filter on interface tunl0

Yi Cong (1):
      usbnet: Set duplex status to unknown in the absence of MII

Yonglong Liu (3):
      net: hns3: delete redundant address before the array
      net: hns3: use seq_file for files in mac_list/ in debugfs
      net: hns3: use seq_file for files in common/ of hclge layer

Yue Haibing (16):
      tcp: Remove inet_hashinfo2_free_mod()
      neighbour: Remove redundant assignment to err
      net/sched: Remove unused functions
      net: Remove unnecessary NULL check for lwtunnel_fill_encap()
      net: Reoder rxq_idx check in __net_mp_open_rxq()
      ipv4: fib: Remove unnecessary encap_type check
      net: Remove unused function first_net_device_rcu()
      ipv6: Cleanup fib6_drop_pcpu_from()
      ipv6: mcast: Avoid a duplicate pointer check in mld_del_delrec()
      ipv6: mcast: Remove unnecessary null check in ip6_mc_find_dev()
      ipv6: mcast: Simplify mld_clear_{report|query}()
      ip6_gre: Factor out common ip6gre tunnel match into helper
      Bluetooth: Remove hci_conn_hash_lookup_state()
      netfilter: x_tables: Remove unused functions xt_{in|out}name()
      netfilter: nf_tables: Remove unused nft_reduce_is_readonly()
      netfilter: conntrack: Remove unused net in nf_conntrack_double_lock()

Yuesong Li (4):
      net: amt: convert to use secs_to_jiffies
      wifi: iwlegacy: convert to use secs_to_jiffies()
      wifi: ipw2x00: convert to use secs_to_jiffies
      wifi: iwlwifi: convert to use secs_to_jiffies()

Yury Norov (1):
      net: mana: explain irq_setup() algorithm

Yuto Ohnuki (2):
      igbvf: remove unused fields from struct igbvf_adapter
      ixgbevf: remove unused fields from struct ixgbevf_adapter

Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

Yuyang Huang (2):
      selftest: Add selftest for multicast address notifications
      selftest: add selftest for anycast notifications

Zak Kemble (2):
      net: bcmgenet: use napi_complete_done return value
      net: bcmgenet: enable GRO software interrupt coalescing by default

Zenm Chen (1):
      Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano

Zheng Yongjun (1):
      iwlwifi: fw: simplify the iwl_fw_dbg_collect_trig()

Zhongqiu Han (1):
      Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure

Zhu Yanjun (1):
      net/mlx5: Fix build -Wframe-larger-than warnings

Zijun Hu (8):
      Bluetooth: hci_qca: Enable ISO data packet RX
      Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()
      Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
      Bluetooth: hci_core: Eliminate an unnecessary goto label in hci_find_irk_by_addr()
      Bluetooth: hci_event: Correct comment about HCI_EV_EXTENDED_INQUIRY_RESULT
      Bluetooth: btusb: QCA: Support downloading custom-made firmwares
      Bluetooth: btusb: Sort WCN6855 device IDs by VID and PID
      Bluetooth: btusb: Add one more ID 0x28de:0x1401 for Qualcomm WCN6855

Ziwei Xiao (1):
      gve: Add adminq lock for queues creation and destruction

Zong-Zhe Yang (17):
      wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
      wifi: rtw89: chan: re-config default chandef only when none is registered
      wifi: rtw89: implement channel switch support
      wifi: rtw89: fw: add RFE type to RF TSSI H2C command
      wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
      wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
      wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band
      wifi: rtw89: report boottime of receiving beacon and probe response
      wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
      wifi: rtw89: regd/acpi: update field definition to specific country in UNII-4 conf
      wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and parse rule of regd_UK
      wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM
      wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
      wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852bt: implement RFK multi-channel handling and support chanctx up to 2
      wifi: rtw89: 8852b: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852b: implement RFK multi-channel handling and support chanctx up to 2

Zqiang (2):
      net: usb: enable the work after stop usbnet by ip down/up
      net: usb: Remove duplicate assignments for net->pcpu_stat_type

lvxiafei (1):
      netfilter: conntrack: table full detailed log

moyuanhao (1):
      mptcp: fix typo in a comment

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range

zhangjianrong (2):
      net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
      net: thunderbolt: Enable end-to-end flow control also in transmit

Álvaro Fernández Rojas (13):
      net: dsa: tag_brcm: legacy: reorganize functions
      net: dsa: tag_brcm: add support for legacy FCS tags
      net: dsa: b53: support legacy FCS tags
      net: dsa: b53: detect BCM5325 variants
      net: dsa: b53: prevent FAST_AGE access on BCM5325
      net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
      net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
      net: dsa: b53: prevent DIS_LEARNING access on BCM5325
      net: dsa: b53: prevent BRCM_HDR access on older devices
      net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
      net: dsa: b53: fix unicast/multicast flooding on BCM5325
      net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
      net: dsa: b53: ensure BCM5325 PHYs are enabled

 Documentation/ABI/testing/sysfs-class-net-phydev   |   10 +
 Documentation/arch/s390/driver-model.rst           |   21 -
 Documentation/dev-tools/checkpatch.rst             |    9 +
 .../devicetree/bindings/dpll/dpll-device.yaml      |   76 +
 .../devicetree/bindings/dpll/dpll-pin.yaml         |   45 +
 .../bindings/dpll/microchip,zl30731.yaml           |  115 +
 .../bindings/net/airoha,an7583-mdio.yaml           |   59 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |    1 +
 .../bindings/net/altr,gmii-to-sgmii-2.0.yaml       |   49 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |  171 ++
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |   18 +
 .../devicetree/bindings/net/cdns,macb.yaml         |    8 +
 .../devicetree/bindings/net/dsa/brcm,b53.yaml      |    6 +
 .../bindings/net/dsa/mediatek,mt7530.yaml          |   24 +-
 .../devicetree/bindings/net/dsa/micrel,ks8995.yaml |  135 ++
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |    1 +
 .../bindings/net/ethernet-controller.yaml          |    1 +
 .../devicetree/bindings/net/faraday,ftgmac100.yaml |   21 +-
 .../bindings/net/ieee802154/at86rf230.txt          |   27 -
 .../bindings/net/ieee802154/atmel,at86rf233.yaml   |   66 +
 .../bindings/net/intel,ixp4xx-ethernet.yaml        |    2 +
 Documentation/devicetree/bindings/net/lpc-eth.txt  |   28 -
 .../devicetree/bindings/net/mediatek,net.yaml      |   64 +-
 .../devicetree/bindings/net/micrel-ks8995.txt      |   20 -
 .../devicetree/bindings/net/nfc/ti,trf7970a.yaml   |    7 +
 .../devicetree/bindings/net/nxp,lpc-eth.yaml       |   48 +
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.txt  |   20 -
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.yaml |   85 +
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   22 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   18 +-
 .../devicetree/bindings/net/qca,ar803x.yaml        |   43 +
 .../devicetree/bindings/net/qca,qca7000.txt        |   87 -
 .../devicetree/bindings/net/qca,qca7000.yaml       |  109 +
 ...a09g057-gbeth.yaml => renesas,rzv2h-gbeth.yaml} |    4 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    4 +
 .../devicetree/bindings/net/socfpga-dwmac.txt      |   57 -
 .../bindings/net/sophgo,cv1800b-dwmac.yaml         |  114 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   11 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |    2 +-
 .../bindings/net/wireless/qca,ath9k.yaml           |   18 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |    6 +
 .../bindings/net/wireless/ralink,rt2880.yaml       |   49 +
 Documentation/driver-api/dpll.rst                  |   43 +
 Documentation/netlink/specs/conntrack.yaml         |   38 +-
 Documentation/netlink/specs/devlink.yaml           |  236 +-
 Documentation/netlink/specs/dpll.yaml              |   57 +-
 Documentation/netlink/specs/ethtool.yaml           |  384 +++-
 Documentation/netlink/specs/fou.yaml               |   14 +-
 Documentation/netlink/specs/handshake.yaml         |   14 +-
 Documentation/netlink/specs/lockd.yaml             |    4 +-
 Documentation/netlink/specs/mptcp_pm.yaml          |  192 +-
 Documentation/netlink/specs/net_shaper.yaml        |    7 +-
 Documentation/netlink/specs/netdev.yaml            |   56 +-
 Documentation/netlink/specs/nfsd.yaml              |   10 +-
 Documentation/netlink/specs/nftables.yaml          |   16 +-
 Documentation/netlink/specs/nl80211.yaml           |  109 +-
 Documentation/netlink/specs/nlctrl.yaml            |    6 +-
 Documentation/netlink/specs/ovpn.yaml              |   26 +-
 Documentation/netlink/specs/ovs_datapath.yaml      |    2 +-
 Documentation/netlink/specs/ovs_flow.yaml          |   16 +-
 Documentation/netlink/specs/ovs_vport.yaml         |    4 +-
 Documentation/netlink/specs/rt-addr.yaml           |    2 +-
 Documentation/netlink/specs/rt-link.yaml           |    2 +-
 Documentation/netlink/specs/rt-neigh.yaml          |    3 +-
 Documentation/netlink/specs/rt-route.yaml          |   10 +-
 Documentation/netlink/specs/rt-rule.yaml           |    2 +-
 Documentation/netlink/specs/tc.yaml                |  178 +-
 Documentation/netlink/specs/tcp_metrics.yaml       |    8 +-
 Documentation/netlink/specs/team.yaml              |   16 +-
 Documentation/networking/af_xdp.rst                |   48 +-
 Documentation/networking/bonding.rst               |   11 +-
 Documentation/networking/can.rst                   |   11 +-
 .../device_drivers/ethernet/amazon/ena.rst         |  108 +
 .../networking/device_drivers/ethernet/index.rst   |    2 +
 .../device_drivers/ethernet/intel/ice.rst          |   13 +
 .../ethernet/mellanox/mlx5/counters.rst            |   32 +
 .../device_drivers/ethernet/meta/fbnic.rst         |   30 +
 .../device_drivers/ethernet/wangxun/ngbevf.rst     |   16 +
 .../device_drivers/ethernet/wangxun/txgbevf.rst    |   16 +
 .../networking/devlink/devlink-params.rst          |    6 +
 Documentation/networking/devlink/devlink-port.rst  |    8 +
 Documentation/networking/devlink/index.rst         |    3 +
 Documentation/networking/devlink/kvaser_pciefd.rst |   24 +
 Documentation/networking/devlink/kvaser_usb.rst    |   33 +
 Documentation/networking/devlink/netdevsim.rst     |    2 +-
 Documentation/networking/devlink/zl3073x.rst       |   51 +
 Documentation/networking/ethtool-netlink.rst       |  131 +-
 Documentation/networking/ip-sysctl.rst             |  768 +++++--
 Documentation/networking/napi.rst                  |    9 +-
 .../networking/net_cachelines/net_device.rst       |    2 +-
 Documentation/networking/net_cachelines/snmp.rst   |    1 +
 .../networking/net_cachelines/tcp_sock.rst         |    2 -
 Documentation/networking/netconsole.rst            |   32 +
 Documentation/networking/nf_conntrack-sysctl.rst   |    1 -
 Documentation/networking/phy.rst                   |    7 +
 Documentation/networking/xdp-rx-metadata.rst       |   33 +
 MAINTAINERS                                        |   28 +-
 arch/alpha/include/uapi/asm/socket.h               |    3 +
 .../dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts  |   92 +-
 arch/arm/configs/omap2plus_defconfig               |    1 -
 arch/loongarch/configs/loongson3_defconfig         |    1 -
 arch/m68k/configs/amiga_defconfig                  |    1 -
 arch/m68k/configs/apollo_defconfig                 |    1 -
 arch/m68k/configs/atari_defconfig                  |    1 -
 arch/m68k/configs/bvme6000_defconfig               |    1 -
 arch/m68k/configs/hp300_defconfig                  |    1 -
 arch/m68k/configs/mac_defconfig                    |    1 -
 arch/m68k/configs/multi_defconfig                  |    1 -
 arch/m68k/configs/mvme147_defconfig                |    1 -
 arch/m68k/configs/mvme16x_defconfig                |    1 -
 arch/m68k/configs/q40_defconfig                    |    1 -
 arch/m68k/configs/sun3_defconfig                   |    1 -
 arch/m68k/configs/sun3x_defconfig                  |    1 -
 arch/mips/boot/dts/ralink/mt7620a.dtsi             |   10 +
 arch/mips/configs/fuloong2e_defconfig              |    1 -
 arch/mips/configs/ip22_defconfig                   |    1 -
 arch/mips/configs/loongson2k_defconfig             |    1 -
 arch/mips/configs/loongson3_defconfig              |    1 -
 arch/mips/configs/malta_defconfig                  |    1 -
 arch/mips/configs/malta_kvm_defconfig              |    1 -
 arch/mips/configs/maltaup_xpa_defconfig            |    1 -
 arch/mips/configs/rb532_defconfig                  |    1 -
 arch/mips/configs/rm200_defconfig                  |    1 -
 arch/mips/include/uapi/asm/socket.h                |    3 +
 arch/parisc/include/uapi/asm/socket.h              |    3 +
 arch/powerpc/configs/cell_defconfig                |    1 -
 arch/powerpc/include/asm/hvcall.h                  |    1 +
 arch/s390/configs/debug_defconfig                  |    1 -
 arch/s390/configs/defconfig                        |    1 -
 arch/sh/configs/titan_defconfig                    |    1 -
 arch/sparc/include/uapi/asm/socket.h               |    3 +
 drivers/Kconfig                                    |    4 +-
 drivers/atm/lanai.c                                |    2 +-
 drivers/bluetooth/btintel.c                        |    6 +-
 drivers/bluetooth/btintel.h                        |    2 +
 drivers/bluetooth/btintel_pcie.c                   |  347 ++-
 drivers/bluetooth/btintel_pcie.h                   |    4 +-
 drivers/bluetooth/btmtkuart.c                      |    2 +-
 drivers/bluetooth/btnxpuart.c                      |  131 +-
 drivers/bluetooth/btrtl.c                          |    2 +-
 drivers/bluetooth/btusb.c                          |  153 +-
 drivers/bluetooth/hci_bcm4377.c                    |    2 +-
 drivers/bluetooth/hci_intel.c                      |   10 +-
 drivers/bluetooth/hci_qca.c                        |    1 +
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |    5 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c |   13 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |    4 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c |    6 +-
 drivers/dpll/Kconfig                               |    6 +
 drivers/dpll/Makefile                              |    2 +
 drivers/dpll/dpll_core.c                           |   45 +
 drivers/dpll/dpll_core.h                           |    3 +-
 drivers/dpll/dpll_netlink.c                        |  259 ++-
 drivers/dpll/dpll_netlink.h                        |    2 +
 drivers/dpll/dpll_nl.c                             |   15 +-
 drivers/dpll/dpll_nl.h                             |    1 +
 drivers/dpll/zl3073x/Kconfig                       |   39 +
 drivers/dpll/zl3073x/Makefile                      |   10 +
 drivers/dpll/zl3073x/core.c                        | 1030 +++++++++
 drivers/dpll/zl3073x/core.h                        |  383 ++++
 drivers/dpll/zl3073x/devlink.c                     |  259 +++
 drivers/dpll/zl3073x/devlink.h                     |   12 +
 drivers/dpll/zl3073x/dpll.c                        | 2318 ++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.h                        |   46 +
 drivers/dpll/zl3073x/i2c.c                         |   76 +
 drivers/dpll/zl3073x/prop.c                        |  358 +++
 drivers/dpll/zl3073x/prop.h                        |   34 +
 drivers/dpll/zl3073x/regs.h                        |  263 +++
 drivers/dpll/zl3073x/spi.c                         |   76 +
 drivers/gpu/drm/display/drm_dp_tunnel.c            |    2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |    4 +-
 drivers/gpu/drm/i915/intel_wakeref.c               |    3 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |    4 +-
 drivers/infiniband/hw/mlx5/dm.c                    |    2 +-
 drivers/infiniband/hw/mlx5/umr.c                   |    6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |    2 +-
 drivers/net/amt.c                                  |   11 +-
 drivers/net/bareudp.c                              |    7 +-
 drivers/net/bonding/bond_3ad.c                     |   24 +-
 drivers/net/bonding/bond_main.c                    |   96 +-
 drivers/net/bonding/bond_netlink.c                 |   16 +
 drivers/net/bonding/bond_options.c                 |   42 +
 drivers/net/can/Kconfig                            |    3 +-
 drivers/net/can/Makefile                           |    2 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |   11 +-
 drivers/net/can/dev/calc_bittiming.c               |    2 +-
 drivers/net/can/dev/netlink.c                      |   26 +-
 drivers/net/can/janz-ican3.c                       |    2 +-
 drivers/net/can/kvaser_pciefd/Makefile             |    3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h      |   96 +
 .../kvaser_pciefd_core.c}                          |  144 +-
 .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c  |   60 +
 drivers/net/can/rcar/rcar_can.c                    |    9 +-
 drivers/net/can/rcar/rcar_canfd.c                  |  313 ++-
 drivers/net/can/sja1000/Kconfig                    |    2 +-
 drivers/net/can/spi/mcp251x.c                      |   37 +-
 drivers/net/can/ti_hecc.c                          |    2 +-
 drivers/net/can/usb/Kconfig                        |    1 +
 drivers/net/can/usb/etas_es58x/es58x_fd.c          |    2 +-
 drivers/net/can/usb/kvaser_usb/Makefile            |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   33 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  139 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_devlink.c    |   87 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   65 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |   75 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |   17 +-
 drivers/net/can/xilinx_can.c                       |    2 +-
 drivers/net/dsa/Kconfig                            |    2 +-
 drivers/net/dsa/b53/Kconfig                        |    1 +
 drivers/net/dsa/b53/b53_common.c                   |  309 ++-
 drivers/net/dsa/b53/b53_mmap.c                     |  107 +-
 drivers/net/dsa/b53/b53_priv.h                     |   63 +-
 drivers/net/dsa/b53/b53_regs.h                     |   27 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |   20 +-
 drivers/net/dsa/microchip/ksz8.c                   |  191 +-
 drivers/net/dsa/microchip/ksz8.h                   |    4 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   53 +-
 drivers/net/dsa/microchip/ksz_common.c             |  163 +-
 drivers/net/dsa/microchip/ksz_common.h             |   37 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |   10 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |    4 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  104 +
 drivers/net/dsa/mt7530-mdio.c                      |   21 +-
 drivers/net/dsa/mt7530-mmio.c                      |   21 +-
 drivers/net/dsa/mt7530.c                           |    6 +-
 drivers/net/dsa/mv88e6xxx/devlink.c                |   31 +-
 drivers/net/dsa/mv88e6xxx/global2.c                |    6 +-
 drivers/net/dsa/qca/ar9331.c                       |    4 +-
 drivers/net/dsa/rzn1_a5psw.c                       |   22 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   10 +-
 drivers/net/ethernet/agere/et131x.c                |   36 +
 drivers/net/ethernet/airoha/airoha_eth.c           |    5 -
 drivers/net/ethernet/airoha/airoha_npu.c           |   29 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   31 +-
 drivers/net/ethernet/amazon/Kconfig                |    2 +
 drivers/net/ethernet/amazon/ena/Makefile           |    2 +-
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h   |   76 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |  267 +++
 drivers/net/ethernet/amazon/ena/ena_com.h          |   84 +
 drivers/net/ethernet/amazon/ena/ena_debugfs.c      |   62 +
 drivers/net/ethernet/amazon/ena/ena_debugfs.h      |   27 +
 drivers/net/ethernet/amazon/ena/ena_devlink.c      |  210 ++
 drivers/net/ethernet/amazon/ena/ena_devlink.h      |   21 +
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   55 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   62 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |   14 +
 drivers/net/ethernet/amazon/ena/ena_phc.c          |  233 ++
 drivers/net/ethernet/amazon/ena/ena_phc.h          |   37 +
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h    |    8 +
 drivers/net/ethernet/amd/xgbe/Makefile             |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   18 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  142 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  204 +-
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c      |  401 ++++
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |    2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c           |   75 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   49 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |    2 +
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |    6 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   |   39 +
 drivers/net/ethernet/atheros/ag71xx.c              |    9 +
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |    2 +-
 drivers/net/ethernet/broadcom/Kconfig              |    9 +
 drivers/net/ethernet/broadcom/Makefile             |    1 +
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |    1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |    6 +-
 drivers/net/ethernet/broadcom/b44.c                |    2 +-
 drivers/net/ethernet/broadcom/bnge/Makefile        |   12 +
 drivers/net/ethernet/broadcom/bnge/bnge.h          |  218 ++
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |  388 ++++
 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c  |  306 +++
 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h  |   18 +
 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c  |   33 +
 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h  |    9 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c     |  508 +++++
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h     |  110 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |  703 ++++++
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h |   27 +
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |  268 +++
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |  206 ++
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |  605 +++++
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h     |   94 +
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c     |  438 ++++
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h     |  188 ++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c    |    2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   37 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h    |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   98 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c  |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h  |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   26 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c    |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c      |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |    2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    6 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    9 +-
 drivers/net/ethernet/broadcom/tg3.c                |    6 +-
 drivers/net/ethernet/broadcom/tg3.h                |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   26 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |   39 -
 .../ethernet/cavium/liquidio/cn23xx_pf_device.h    |    3 -
 drivers/net/ethernet/cavium/liquidio/octeon_main.h |    2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_nic.h  |    4 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   37 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |    4 +-
 drivers/net/ethernet/chelsio/cxgb/pm3393.c         |    8 +-
 drivers/net/ethernet/chelsio/cxgb3/l2t.c           |   37 -
 drivers/net/ethernet/chelsio/cxgb3/l2t.h           |    1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  105 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c  |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c     |    2 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |    3 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |    8 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c        |    2 +-
 drivers/net/ethernet/dec/tulip/xircom_cb.c         |    4 +-
 drivers/net/ethernet/dlink/dl2k.c                  |   57 +-
 drivers/net/ethernet/dlink/dl2k.h                  |    2 +
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   56 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   11 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   28 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    2 -
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   44 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   36 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-xsk.c   |    2 -
 drivers/net/ethernet/freescale/enetc/enetc.c       |   12 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   22 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  106 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |    4 +
 drivers/net/ethernet/freescale/fec.h               |   15 +-
 drivers/net/ethernet/freescale/fec_main.c          |  224 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    2 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   42 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    4 +-
 drivers/net/ethernet/freescale/gianfar.c           |   17 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   24 +-
 drivers/net/ethernet/google/Kconfig                |    1 +
 drivers/net/ethernet/google/gve/Makefile           |    4 +-
 drivers/net/ethernet/google/gve/gve.h              |   83 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |  101 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   30 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |   25 +-
 drivers/net/ethernet/google/gve/gve_desc_dqo.h     |    3 +-
 drivers/net/ethernet/google/gve/gve_dqo.h          |    3 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   34 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  362 ++-
 drivers/net/ethernet/google/gve/gve_ptp.c          |  139 ++
 drivers/net/ethernet/google/gve/gve_rx.c           |   14 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  201 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |    4 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  386 +++-
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |    1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_diagnose.c  |    1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |    2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c   |    1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |   57 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |   38 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |    8 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   20 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |    2 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.c    |    6 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.h    |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 1046 +++------
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h |   16 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   48 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  107 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 1367 +++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |    1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   44 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |    7 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |    2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    8 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |    2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |   27 +-
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |   47 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c   |    2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c  |    2 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |   23 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  236 +-
 drivers/net/ethernet/ibm/ibmveth.h                 |   21 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |   27 +-
 drivers/net/ethernet/intel/Kconfig                 |    3 +
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   77 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   34 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   68 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  155 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    7 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  730 +++---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |    8 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   46 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  165 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  293 +--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   18 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   15 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   45 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   25 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   43 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   38 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   73 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   12 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.c      |   62 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h      |   12 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq_cmd.h  |   83 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c      |  110 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   52 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   80 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   17 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |   40 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h        |   34 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   35 +-
 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   10 +-
 drivers/net/ethernet/intel/ice/devlink/health.c    |    6 +-
 drivers/net/ethernet/intel/ice/devlink/port.c      |    2 +
 drivers/net/ethernet/intel/ice/devlink/port.h      |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |    3 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |    1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h       |    5 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  297 +--
 drivers/net/ethernet/intel/ice/ice_base.c          |    7 +-
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h      |  181 --
 drivers/net/ethernet/intel/ice/ice_common.c        |  717 ++++--
 drivers/net/ethernet/intel/ice/ice_common.h        |   58 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c      |   53 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h      |    8 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c           |   36 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |    2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |   47 +-
 drivers/net/ethernet/intel/ice/ice_devids.h        |   18 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 1424 +++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |   33 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  112 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   78 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h     |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c          |   49 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |   68 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |   38 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c         |   16 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   12 +
 drivers/net/ethernet/intel/ice/ice_lag.c           |   46 +-
 drivers/net/ethernet/intel/ice/ice_lag.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |    8 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  100 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c           |   38 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  315 +--
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   20 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |  177 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  582 +----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   55 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |   18 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   23 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |    7 +
 drivers/net/ethernet/intel/ice/ice_switch.c        |   55 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c         |  626 ++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h         |   31 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   87 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |    3 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   20 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   22 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   26 +-
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c        |    6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  132 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |   23 +-
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |    2 +-
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c     |    6 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |   24 +-
 drivers/net/ethernet/intel/idpf/Makefile           |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h             |  168 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.c    |   14 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.h    |   18 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |   49 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  334 ++-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |  503 +++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  127 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   33 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h         |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |  136 ++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h         |   17 +
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |   45 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  315 ++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |    9 +
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |   55 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |  278 ++-
 drivers/net/ethernet/intel/igb/igb.h               |    9 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   20 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    6 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   37 +-
 drivers/net/ethernet/intel/igb/igb_xsk.c           |    3 +-
 drivers/net/ethernet/intel/igbvf/ethtool.c         |    1 +
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   27 -
 drivers/net/ethernet/intel/igbvf/netdev.c          |   11 -
 drivers/net/ethernet/intel/igc/igc.h               |   57 +-
 drivers/net/ethernet/intel/igc/igc_base.h          |    8 -
 drivers/net/ethernet/intel/igc/igc_defines.h       |    5 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   48 +-
 drivers/net/ethernet/intel/igc/igc_mac.c           |    2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  100 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   36 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |  118 +-
 drivers/net/ethernet/intel/igc/igc_tsn.h           |    5 +
 drivers/net/ethernet/intel/ixgbe/devlink/region.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |  276 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   32 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  237 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   53 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h     |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   46 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |  226 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |  150 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h      |    5 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |    3 -
 drivers/net/ethernet/intel/ixgbevf/vf.c            |    2 +-
 drivers/net/ethernet/intel/libeth/Kconfig          |   10 +-
 drivers/net/ethernet/intel/libeth/Makefile         |    8 +-
 drivers/net/ethernet/intel/libeth/priv.h           |   37 +
 drivers/net/ethernet/intel/libeth/rx.c             |   42 +-
 drivers/net/ethernet/intel/libeth/tx.c             |   41 +
 drivers/net/ethernet/intel/libeth/xdp.c            |  451 ++++
 drivers/net/ethernet/intel/libeth/xsk.c            |  271 +++
 drivers/net/ethernet/intel/libie/Kconfig           |    6 +
 drivers/net/ethernet/intel/libie/Makefile          |    4 +
 drivers/net/ethernet/intel/libie/adminq.c          |   52 +
 drivers/net/ethernet/intel/libie/rx.c              |    7 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 -
 drivers/net/ethernet/marvell/mvneta_bm.h           |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |    6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h     |    6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   31 +-
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   78 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    1 +
 .../net/ethernet/marvell/octeontx2/af/cgx_fw_if.h  |   33 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/api.h  |   32 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c         |  424 ++++
 .../net/ethernet/marvell/octeontx2/af/cn20k/reg.h  |   81 +
 .../ethernet/marvell/octeontx2/af/cn20k/struct.h   |   40 +
 drivers/net/ethernet/marvell/octeontx2/af/common.h |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  106 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   24 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |    6 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  243 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   81 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   98 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |    6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |    4 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  184 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   56 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    8 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |   16 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |    4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |   13 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_sdp.c    |   10 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |    6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |    8 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   18 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |    1 +
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.h   |    2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |  252 +++
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h |   17 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   44 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   54 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  230 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  177 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |   49 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   44 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |    4 +-
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |    5 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |    7 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |    6 +-
 drivers/net/ethernet/mediatek/Kconfig              |    1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  229 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   18 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   24 +-
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c        |   36 +-
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c     |    3 -
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |    3 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    4 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   55 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   27 +-
 .../ethernet/mellanox/mlx5/core/en/fs_ethtool.h    |   14 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   75 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |    6 -
 .../mellanox/mlx5/core/en/pcie_cong_event.c        |  315 +++
 .../mellanox/mlx5/core/en/pcie_cong_event.h        |   10 +
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    2 -
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |    2 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    7 +
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |   34 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    7 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/vlan.c   |   41 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   82 +-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |    3 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |    4 +
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  198 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  362 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  140 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   15 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   25 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  | 1038 ++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h  |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   46 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   19 +
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c   |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    3 -
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   13 +
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   40 +-
 .../mellanox/mlx5/core/steering/hws/action.c       |    7 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |  531 +++--
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.h |   15 +-
 .../mellanox/mlx5/core/steering/hws/debug.c        |   20 +-
 .../mellanox/mlx5/core/steering/hws/definer.c      |   13 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   15 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c      |  164 +-
 .../mellanox/mlx5/core/steering/hws/matcher.h      |    3 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |   36 +-
 .../mellanox/mlx5/core/steering/hws/rule.c         |   36 +-
 .../mellanox/mlx5/core/steering/hws/rule.h         |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |    3 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |   26 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |    2 +-
 drivers/net/ethernet/meta/fbnic/Makefile           |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |    3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |  161 +-
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   29 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |    4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  239 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  230 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   52 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c     |  123 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h     |   45 +
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |   19 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |  169 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |   27 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   16 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   21 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |  126 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |    3 -
 drivers/net/ethernet/micrel/ks8842.c               |    2 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |   31 +-
 drivers/net/ethernet/microsoft/Kconfig             |    1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  548 ++++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   14 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  327 ++-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   82 +-
 drivers/net/ethernet/neterion/s2io.c               |    4 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |    3 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   17 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |    1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |    7 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_ptp.c          |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   22 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |    3 -
 drivers/net/ethernet/qlogic/qla3xxx.c              |    2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |    2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    1 -
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c    |    2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    3 -
 drivers/net/ethernet/realtek/rtase/rtase.h         |    1 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   39 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c |   45 +-
 drivers/net/ethernet/sfc/ef10.c                    |    1 -
 drivers/net/ethernet/sfc/ethtool.c                 |    2 +
 drivers/net/ethernet/sfc/ethtool_common.c          |   99 +-
 drivers/net/ethernet/sfc/ethtool_common.h          |    2 +
 drivers/net/ethernet/sfc/falcon/ethtool.c          |   55 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h               |    6 +-
 drivers/net/ethernet/sfc/net_driver.h              |    2 -
 drivers/net/ethernet/sfc/rx_common.c               |    6 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |    1 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c    |   77 +-
 drivers/net/ethernet/sfc/siena/ethtool_common.h    |    2 +
 drivers/net/ethernet/sfc/siena/farch.c             |    2 +-
 drivers/net/ethernet/sfc/siena/mcdi_pcol.h         |   12 +-
 drivers/net/ethernet/sfc/siena/net_driver.h        |    2 -
 drivers/net/ethernet/sfc/siena/rx_common.c         |    6 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |    2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   11 -
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c  |   79 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |    5 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   13 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  728 +++---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |  125 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   12 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   49 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |   32 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +-
 drivers/net/ethernet/sun/niu.c                     |   19 +-
 drivers/net/ethernet/sun/niu.h                     |    4 +-
 drivers/net/ethernet/sun/sunhme.c                  |    2 +-
 drivers/net/ethernet/sun/sunqe.h                   |    2 +-
 drivers/net/ethernet/tehuti/tehuti.c               |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   27 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  147 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   17 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    4 +-
 drivers/net/ethernet/wangxun/Kconfig               |   35 +
 drivers/net/ethernet/wangxun/Makefile              |    2 +
 drivers/net/ethernet/wangxun/libwx/Makefile        |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   14 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |    9 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.c        |  243 ++
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h        |   22 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   11 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.c         |  599 +++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h         |  127 ++
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |  414 ++++
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h  |   22 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |  280 +++
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h     |   14 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile       |    9 +
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c  |  261 +++
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h  |   29 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile      |    9 +
 .../net/ethernet/wangxun/txgbevf/txgbevf_main.c    |  314 +++
 .../net/ethernet/wangxun/txgbevf/txgbevf_type.h    |   26 +
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 +-
 drivers/net/geneve.c                               |   14 +-
 drivers/net/gtp.c                                  |   12 +-
 drivers/net/hyperv/netvsc_drv.c                    |   30 +-
 drivers/net/ifb.c                                  |    1 +
 drivers/net/ipa/ipa_main.c                         |   12 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    7 +-
 drivers/net/macsec.c                               |    2 +-
 drivers/net/mdio/Kconfig                           |    7 +
 drivers/net/mdio/Makefile                          |    1 +
 drivers/net/mdio/fwnode_mdio.c                     |   26 +-
 drivers/net/mdio/mdio-airoha.c                     |  276 +++
 drivers/net/mdio/mdio-mux-gpio.c                   |    3 +-
 drivers/net/netconsole.c                           |  270 ++-
 drivers/net/netdevsim/bus.c                        |   29 +-
 drivers/net/netdevsim/dev.c                        |   66 +-
 drivers/net/netdevsim/ethtool.c                    |   21 +
 drivers/net/netdevsim/hwstats.c                    |    5 +-
 drivers/net/netdevsim/netdev.c                     |  160 +-
 drivers/net/netdevsim/netdevsim.h                  |   18 +-
 drivers/net/netdevsim/udp_tunnels.c                |   12 -
 drivers/net/ovpn/udp.c                             |    4 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |    6 +-
 drivers/net/phy/Kconfig                            |    6 +
 drivers/net/phy/Makefile                           |    3 +-
 drivers/net/phy/air_en8811h.c                      |   45 +-
 drivers/net/phy/broadcom.c                         |   39 +-
 drivers/net/phy/dp83822.c                          |    7 +-
 drivers/net/phy/dp83869.c                          |    7 +-
 drivers/net/phy/dp83tg720.c                        |  181 +-
 drivers/net/phy/intel-xway.c                       |    7 +-
 drivers/net/phy/mdio-boardinfo.c                   |   29 +-
 drivers/net/phy/mdio-boardinfo.h                   |    9 +-
 drivers/net/phy/mdio_bus_provider.c                |    1 -
 drivers/net/phy/mdio_device.c                      |    5 +-
 drivers/net/phy/mediatek/Kconfig                   |    1 +
 drivers/net/phy/micrel.c                           |  255 ++-
 drivers/net/phy/mscc/mscc_main.c                   |    5 +-
 drivers/net/phy/phy-c45.c                          |    7 -
 drivers/net/phy/phy-core.c                         |   79 +-
 drivers/net/phy/phy_caps.c                         |   13 +
 drivers/net/phy/phy_device.c                       |  174 +-
 drivers/net/phy/phy_package.c                      |   71 +-
 drivers/net/phy/phylib-internal.h                  |    6 +-
 drivers/net/phy/phylink.c                          |   74 +-
 drivers/net/phy/qcom/Kconfig                       |    3 +-
 drivers/net/phy/qcom/at803x.c                      |  167 ++
 drivers/net/phy/qcom/qca807x.c                     |   42 +-
 drivers/net/phy/qcom/qca808x.c                     |   23 +
 drivers/net/phy/qcom/qcom-phy-lib.c                |   75 +
 drivers/net/phy/qcom/qcom.h                        |   23 +
 drivers/net/phy/realtek/realtek_main.c             |   10 +-
 drivers/net/phy/sfp.c                              |   21 +-
 drivers/net/ppp/ppp_generic.c                      |   86 +-
 drivers/net/ppp/pppoe.c                            |    6 +-
 drivers/net/pse-pd/pd692x0.c                       |  233 +-
 drivers/net/pse-pd/pse_core.c                      | 1066 ++++++++-
 drivers/net/pse-pd/tps23881.c                      |  401 +++-
 drivers/net/tap.c                                  |   10 +-
 drivers/net/team/team_core.c                       |   96 +-
 drivers/net/team/team_mode_activebackup.c          |    3 +-
 drivers/net/team/team_mode_loadbalance.c           |   13 +-
 drivers/net/thunderbolt/main.c                     |   21 +-
 drivers/net/tun.c                                  |   72 +-
 drivers/net/tun_vnet.h                             |  113 +-
 drivers/net/usb/Kconfig                            |    3 +-
 drivers/net/usb/cdc_ncm.c                          |   20 +-
 drivers/net/usb/lan78xx.c                          |  744 +++----
 drivers/net/usb/smsc95xx.c                         |   72 +-
 drivers/net/usb/usbnet.c                           |   55 +-
 drivers/net/virtio_net.c                           |  190 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |   74 +-
 drivers/net/vrf.c                                  |    2 +
 drivers/net/vxlan/vxlan_core.c                     |   60 +-
 drivers/net/vxlan/vxlan_private.h                  |    2 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |   31 +-
 drivers/net/wireguard/device.c                     |    2 +-
 drivers/net/wireguard/peer.h                       |    2 +-
 drivers/net/wireguard/socket.c                     |    4 +-
 drivers/net/wireless/admtek/adm8211.c              |    2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |    5 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    2 +
 drivers/net/wireless/ath/ath10k/ce.c               |    2 +
 drivers/net/wireless/ath/ath10k/core.c             |   54 +-
 drivers/net/wireless/ath/ath10k/core.h             |   13 +-
 drivers/net/wireless/ath/ath10k/coredump.c         |    2 +
 drivers/net/wireless/ath/ath10k/debug.c            |    8 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    7 +-
 drivers/net/wireless/ath/ath10k/htc.c              |    3 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           |   11 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    6 +-
 drivers/net/wireless/ath/ath10k/hw.c               |    1 +
 drivers/net/wireless/ath/ath10k/hw.h               |   10 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   35 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    3 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    2 +-
 drivers/net/wireless/ath/ath10k/trace.c            |    2 +
 drivers/net/wireless/ath/ath10k/wmi.c              |    6 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    7 +-
 drivers/net/wireless/ath/ath11k/core.c             |   11 +-
 drivers/net/wireless/ath/ath11k/core.h             |   13 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |    2 +
 drivers/net/wireless/ath/ath11k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath11k/debug.c            |    2 +
 drivers/net/wireless/ath/ath11k/debugfs.c          |   40 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   15 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   11 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   45 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   15 +-
 drivers/net/wireless/ath/ath11k/fw.c               |    2 +
 drivers/net/wireless/ath/ath11k/hal.c              |   41 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   42 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |    2 +
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +
 drivers/net/wireless/ath/ath11k/spectral.c         |    3 +-
 drivers/net/wireless/ath/ath11k/trace.c            |    2 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   12 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |    1 +
 drivers/net/wireless/ath/ath12k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath12k/core.c             |   85 +-
 drivers/net/wireless/ath/ath12k/core.h             |   57 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  564 ++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  207 +-
 drivers/net/wireless/ath/ath12k/dp.c               |  137 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   45 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   30 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   90 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  160 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   40 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   57 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   32 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 2090 +++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   24 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |    3 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    6 +-
 drivers/net/wireless/ath/ath12k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   28 +
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    6 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  148 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    3 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  383 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  167 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   12 +-
 drivers/net/wireless/ath/ath5k/phy.c               |   12 +-
 drivers/net/wireless/ath/ath5k/reg.h               |    2 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    7 +-
 drivers/net/wireless/ath/ath6kl/core.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/hif.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/htc.h              |    6 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/init.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/usb.c              |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |   10 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   62 +-
 drivers/net/wireless/ath/ath9k/common-beacon.c     |    1 +
 drivers/net/wireless/ath/ath9k/common-debug.c      |    1 +
 drivers/net/wireless/ath/ath9k/common-init.c       |    1 +
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    1 +
 drivers/net/wireless/ath/ath9k/common.c            |    1 +
 drivers/net/wireless/ath/ath9k/dynack.c            |    1 +
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |   10 +-
 drivers/net/wireless/ath/ath9k/hw.c                |    1 +
 drivers/net/wireless/ath/ath9k/main.c              |    9 +-
 drivers/net/wireless/ath/carl9170/main.c           |    2 +-
 drivers/net/wireless/ath/main.c                    |    1 +
 drivers/net/wireless/ath/wcn36xx/main.c            |    5 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    2 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |    2 +-
 drivers/net/wireless/broadcom/b43/main.c           |    6 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   71 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |    2 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    5 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |    2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   26 +-
 .../broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   45 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    5 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    5 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   22 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |  443 ----
 .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h      |   27 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      |   11 -
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |   25 +-
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    2 +
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    7 +-
 drivers/net/wireless/intel/iwlegacy/commands.h     |    2 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |    2 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    1 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    9 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   24 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   34 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   31 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   49 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c     |   29 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   16 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |   33 +-
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   12 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.h     |    2 -
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |   15 -
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |  133 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   20 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   61 -
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   24 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h   |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   35 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    6 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   36 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    4 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   33 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  150 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |   10 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   80 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   24 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.c     |  113 +-
 drivers/net/wireless/intel/iwlwifi/iwl-utils.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h       |   30 +-
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |    4 -
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    5 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   24 +-
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    9 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  202 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |    7 +-
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   15 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   15 +
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |   12 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  383 +---
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   36 +-
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |    3 -
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  136 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   66 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   27 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  110 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   24 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |   12 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |  100 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   82 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  178 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   39 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |    2 -
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c        |  140 --
 .../intel/iwlwifi/mld/tests/link-selection.c       |    6 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  501 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   62 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   52 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   59 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |    9 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   60 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   68 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   96 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  121 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    3 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   25 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   93 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |    6 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  368 +---
 .../intel/iwlwifi/pcie/{ => gen1_2}/internal.h     |   58 +-
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c  |   34 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c   |   29 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/trans.c        |  607 +++--
 .../intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c      |    0
 .../wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c  |   53 +-
 .../intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h |    6 +-
 .../intel/iwlwifi/{ => pcie}/iwl-context-info.h    |    0
 drivers/net/wireless/intel/iwlwifi/pcie/utils.c    |  104 +
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h    |   40 +
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |    2 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   73 +-
 .../iwlwifi/{mvm/tests/scan.c => tests/utils.c}    |   43 +-
 drivers/net/wireless/intersil/p54/main.c           |    3 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |    4 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |    4 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   18 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    4 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    2 +-
 drivers/net/wireless/marvell/mwl8k.c               |   16 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |    4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   11 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    3 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |    4 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   13 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    4 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    6 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   13 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    2 +
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |   58 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    3 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   48 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   91 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |    6 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |    6 +-
 drivers/net/wireless/mediatek/mt7601u/main.c       |    5 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    7 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    5 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |   16 +-
 drivers/net/wireless/purelifi/plfxlc/mac.h         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |   29 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    8 +-
 drivers/net/wireless/ralink/rt2x00/Kconfig         |    7 +-
 drivers/net/wireless/ralink/rt2x00/Makefile        |    1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h     |    3 +-
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |  110 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c     |  151 --
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h     |   29 -
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    5 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   12 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   23 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |   25 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   23 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/rf.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |   21 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   38 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/coex.c          |   22 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   32 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   25 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   15 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   49 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |    6 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |    8 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |   26 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw89/acpi.c          |   95 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |   33 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  557 ++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   73 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1309 ++++++++---
 drivers/net/wireless/realtek/rtw89/coex.h          |    7 +
 drivers/net/wireless/realtek/rtw89/core.c          |  275 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  220 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   15 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  622 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  110 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  180 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   39 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   96 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   42 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  337 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |    3 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   54 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   36 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  149 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  171 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  156 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.c    |   81 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.h    |    2 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |  501 +++--
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  100 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   77 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   19 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   69 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   55 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   51 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   52 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   14 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c           | 1042 +++++++++
 drivers/net/wireless/realtek/rtw89/usb.h           |   65 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   18 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   14 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    9 +-
 drivers/net/wireless/silabs/wfx/sta.c              |    4 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    4 +-
 drivers/net/wireless/st/cw1200/sta.c               |    5 +-
 drivers/net/wireless/st/cw1200/sta.h               |    5 +-
 drivers/net/wireless/ti/wl1251/acx.c               |   35 -
 drivers/net/wireless/ti/wl1251/acx.h               |    1 -
 drivers/net/wireless/ti/wl1251/cmd.c               |   79 -
 drivers/net/wireless/ti/wl1251/cmd.h               |    3 -
 drivers/net/wireless/ti/wl1251/main.c              |    5 +-
 drivers/net/wireless/ti/wl1251/reg.h               |    6 +-
 drivers/net/wireless/ti/wl12xx/reg.h               |    6 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |   26 -
 drivers/net/wireless/ti/wlcore/cmd.h               |    1 -
 drivers/net/wireless/ti/wlcore/main.c              |    8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    9 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |   14 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |    2 +-
 drivers/nfc/trf7970a.c                             |   91 +-
 drivers/pci/Kconfig                                |    1 +
 drivers/pci/controller/pci-hyperv.c                |  110 +-
 drivers/pci/msi/irqdomain.c                        |    5 +-
 drivers/ptp/ptp_chardev.c                          |  758 +++----
 drivers/ptp/ptp_clock.c                            |    2 +-
 drivers/s390/net/Kconfig                           |   12 -
 drivers/s390/net/Makefile                          |    1 -
 drivers/s390/net/netiucv.c                         | 2083 ------------------
 drivers/s390/net/qeth_core_sys.c                   |   22 +-
 drivers/ssb/driver_gpio.c                          |   16 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    6 +-
 drivers/vhost/net.c                                |  115 +-
 drivers/vhost/vhost.c                              |    2 +-
 drivers/vhost/vhost.h                              |    4 +-
 drivers/virtio/virtio.c                            |   43 +-
 drivers/virtio/virtio_debug.c                      |   27 +-
 drivers/virtio/virtio_pci_modern.c                 |   10 +-
 drivers/virtio/virtio_pci_modern_dev.c             |   69 +-
 fs/nfsd/nfsctl.c                                   |   36 +-
 fs/smb/server/smb2pdu.c                            |    2 +-
 fs/smb/server/transport_tcp.c                      |    6 +-
 include/dt-bindings/clock/ast2600-clock.h          |    2 +
 include/linux/avf/virtchnl.h                       |   23 +-
 .../bnxt/bnxt_hsi.h => include/linux/bnxt/hsi.h    |    0
 include/linux/brcmphy.h                            |    6 +
 include/linux/can/bittiming.h                      |    2 +-
 include/linux/can/dev.h                            |    4 +-
 include/linux/dpll.h                               |   21 +
 include/linux/ethtool.h                            |   29 +-
 include/linux/ethtool_netlink.h                    |    7 +
 include/linux/filter.h                             |   14 +-
 include/linux/ieee80211.h                          |   53 +-
 include/linux/if_team.h                            |    3 -
 include/linux/if_tun.h                             |    5 -
 include/linux/if_vlan.h                            |   23 +-
 include/linux/in6.h                                |    7 +
 include/linux/ipv6.h                               |    2 +
 include/linux/mdio.h                               |    1 -
 include/linux/mlx5/device.h                        |    1 +
 include/linux/mlx5/fs.h                            |    2 +-
 include/linux/mlx5/mlx5_ifc.h                      |  136 +-
 include/linux/mm.h                                 |    4 +-
 include/linux/mmc/sdio_ids.h                       |    1 +
 include/linux/mroute6.h                            |    7 +
 include/linux/msi.h                                |    2 +
 include/linux/net/intel/iidc_rdma_idpf.h           |   55 +
 include/linux/net/intel/libie/adminq.h             |  308 +++
 include/linux/net/intel/libie/pctype.h             |   41 +
 include/linux/netdevice.h                          |   54 +-
 include/linux/netfilter.h                          |    1 +
 include/linux/netfilter/nf_conntrack_dccp.h        |   38 -
 include/linux/netfilter/x_tables.h                 |   10 -
 include/linux/netpoll.h                            |   13 +-
 include/linux/packing.h                            |    6 +-
 include/linux/phy.h                                |   49 +-
 include/linux/platform_data/microchip-ksz.h        |    1 +
 include/linux/pse-pd/pse.h                         |  114 +-
 include/linux/ptp_clock_kernel.h                   |   34 +-
 include/linux/ref_tracker.h                        |   50 +-
 include/linux/skbuff.h                             |   22 +-
 include/linux/soc/marvell/silicons.h               |   25 +
 include/linux/tcp.h                                |    4 +-
 include/linux/timekeeping.h                        |   10 +
 include/linux/usb/cdc_ncm.h                        |    1 +
 include/linux/usb/usbnet.h                         |    3 +-
 include/linux/virtio.h                             |    9 +-
 include/linux/virtio_config.h                      |   43 +-
 include/linux/virtio_features.h                    |   88 +
 include/linux/virtio_net.h                         |  197 +-
 include/linux/virtio_pci_modern.h                  |   43 +-
 include/net/act_api.h                              |   25 +-
 include/net/af_unix.h                              |    2 +
 include/net/aligned_data.h                         |   22 +
 include/net/bluetooth/bluetooth.h                  |   11 +-
 include/net/bluetooth/hci.h                        |   10 +-
 include/net/bluetooth/hci_core.h                   |   41 +-
 include/net/bond_options.h                         |    1 +
 include/net/bonding.h                              |    3 +
 include/net/cfg80211.h                             |  221 +-
 include/net/devlink.h                              |   18 +
 include/net/dropreason-core.h                      |   39 +-
 include/net/dsa.h                                  |    2 +
 include/net/dst.h                                  |   38 +-
 include/net/gro.h                                  |    6 +
 include/net/inet6_hashtables.h                     |    2 +-
 include/net/inet_hashtables.h                      |    8 +-
 include/net/ip.h                                   |   15 +-
 include/net/ip6_route.h                            |    4 +-
 include/net/ip6_tunnel.h                           |    5 +-
 include/net/ip_tunnels.h                           |    2 +-
 include/net/libeth/rx.h                            |   28 +-
 include/net/libeth/tx.h                            |   36 +-
 include/net/libeth/types.h                         |  106 +-
 include/net/libeth/xdp.h                           | 1879 ++++++++++++++++
 include/net/libeth/xsk.h                           |  685 ++++++
 include/net/lwtunnel.h                             |    8 +-
 include/net/mac80211.h                             |   69 +-
 include/net/mana/gdma.h                            |   27 +-
 include/net/mana/mana.h                            |  173 ++
 include/net/mctp.h                                 |   57 +-
 include/net/ndisc.h                                |    9 -
 include/net/neighbour.h                            |   22 +-
 include/net/netdev_queues.h                        |    9 +
 include/net/netfilter/ipv4/nf_conntrack_ipv4.h     |    3 -
 include/net/netfilter/nf_conntrack.h               |    2 -
 include/net/netfilter/nf_conntrack_l4proto.h       |   13 -
 include/net/netfilter/nf_log.h                     |    3 +
 include/net/netfilter/nf_reject.h                  |    1 -
 include/net/netfilter/nf_tables.h                  |   19 +-
 include/net/netfilter/nf_tables_core.h             |   52 +-
 include/net/netlink.h                              |   14 +
 include/net/netmem.h                               |  181 +-
 include/net/netns/conntrack.h                      |   13 -
 include/net/netns/mctp.h                           |   20 +-
 include/net/page_pool/helpers.h                    |   14 +-
 include/net/pfcp.h                                 |    2 +-
 include/net/request_sock.h                         |    4 -
 include/net/route.h                                |    6 +-
 include/net/sctp/structs.h                         |    2 +-
 include/net/sock.h                                 |   23 +-
 include/net/tc_act/tc_connmark.h                   |    1 +
 include/net/tc_act/tc_csum.h                       |   10 +-
 include/net/tc_act/tc_ct.h                         |   11 +-
 include/net/tc_act/tc_ctinfo.h                     |    7 +-
 include/net/tc_act/tc_gate.h                       |    9 -
 include/net/tc_act/tc_mpls.h                       |   10 +-
 include/net/tc_act/tc_nat.h                        |    1 +
 include/net/tc_act/tc_pedit.h                      |    1 +
 include/net/tc_act/tc_police.h                     |   12 +-
 include/net/tc_act/tc_sample.h                     |    9 -
 include/net/tc_act/tc_skbedit.h                    |    1 +
 include/net/tc_act/tc_vlan.h                       |    9 -
 include/net/tcp.h                                  |   11 +-
 include/net/udp.h                                  |    1 -
 include/net/udp_tunnel.h                           |  103 +-
 include/net/vxlan.h                                |    5 +-
 include/net/x25.h                                  |    1 -
 include/net/xdp_sock.h                             |    1 +
 include/trace/events/tcp.h                         |   29 +-
 include/trace/events/xdp.h                         |   21 +-
 include/uapi/asm-generic/socket.h                  |    3 +
 include/uapi/linux/devlink.h                       |   16 +
 include/uapi/linux/dpll.h                          |   13 +
 include/uapi/linux/ethtool.h                       |    4 +-
 include/uapi/linux/ethtool_netlink.h               |    2 -
 include/uapi/linux/ethtool_netlink_generated.h     |   83 +
 include/uapi/linux/handshake.h                     |    1 +
 include/uapi/linux/if_link.h                       |    2 +
 include/uapi/linux/if_tun.h                        |    9 +
 include/uapi/linux/if_xdp.h                        |    1 +
 include/uapi/linux/in6.h                           |    4 +-
 include/uapi/linux/ipv6.h                          |    1 +
 include/uapi/linux/mctp.h                          |    8 +
 include/uapi/linux/neighbour.h                     |    5 +
 include/uapi/linux/net_dropmon.h                   |    7 -
 include/uapi/linux/netconf.h                       |    1 +
 include/uapi/linux/netdev.h                        |    6 +
 include/uapi/linux/netfilter/nfnetlink_hook.h      |    2 +
 include/uapi/linux/nl80211.h                       |   61 +-
 include/uapi/linux/openvswitch.h                   |    6 +
 include/uapi/linux/pkt_sched.h                     |   68 +
 include/uapi/linux/snmp.h                          |    1 +
 include/uapi/linux/sysctl.h                        |    1 +
 include/uapi/linux/vhost.h                         |    7 +
 include/uapi/linux/vhost_types.h                   |    5 +
 include/uapi/linux/virtio_net.h                    |   33 +
 kernel/bpf/cgroup.c                                |    8 +-
 kernel/bpf/cpumap.c                                |    3 +-
 kernel/irq/irqdomain.c                             |    1 +
 kernel/time/timekeeping.c                          |   33 +
 lib/ref_tracker.c                                  |  289 ++-
 lib/test_objagg.c                                  |   77 +-
 net/6lowpan/ndisc.c                                |   16 +-
 net/8021q/vlan.c                                   |    5 +-
 net/Kconfig                                        |    6 +-
 net/appletalk/atalk_proc.c                         |    2 +-
 net/batman-adv/bat_algo.c                          |    1 +
 net/batman-adv/bat_algo.h                          |    2 -
 net/batman-adv/bat_iv_ogm.c                        |   25 +-
 net/batman-adv/bat_v.c                             |    6 +-
 net/batman-adv/bat_v_elp.c                         |    8 +-
 net/batman-adv/bat_v_ogm.c                         |   14 +-
 net/batman-adv/hard-interface.c                    |   39 +-
 net/batman-adv/main.c                              |    7 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/mesh-interface.c                    |    6 +-
 net/batman-adv/multicast.c                         |    6 +-
 net/batman-adv/netlink.c                           |    7 +-
 net/batman-adv/originator.c                        |    7 +-
 net/batman-adv/send.c                              |    7 +-
 net/bluetooth/af_bluetooth.c                       |    9 +-
 net/bluetooth/aosp.c                               |    2 +-
 net/bluetooth/coredump.c                           |    6 +-
 net/bluetooth/hci_conn.c                           |   19 +-
 net/bluetooth/hci_core.c                           |   31 +-
 net/bluetooth/hci_event.c                          |   76 +-
 net/bluetooth/hci_sock.c                           |    2 +-
 net/bluetooth/hci_sync.c                           |   14 +-
 net/bluetooth/iso.c                                |   52 +-
 net/bluetooth/l2cap_sock.c                         |    4 +-
 net/bluetooth/lib.c                                |    2 +-
 net/bluetooth/mgmt.c                               |    1 +
 net/bluetooth/rfcomm/core.c                        |    3 +-
 net/bluetooth/rfcomm/tty.c                         |    2 +-
 net/bluetooth/sco.c                                |    4 +-
 net/bluetooth/smp.c                                |    2 +-
 net/bridge/br.c                                    |    7 +-
 net/bridge/br_if.c                                 |    3 +-
 net/bridge/br_netlink.c                            |    2 +-
 net/bridge/br_switchdev.c                          |    2 +-
 net/bridge/netfilter/Kconfig                       |   10 +-
 net/caif/cfctrl.c                                  |  294 ++-
 net/can/af_can.c                                   |    6 +-
 net/can/bcm.c                                      |    5 +-
 net/can/isotp.c                                    |    5 +-
 net/can/j1939/socket.c                             |    5 +-
 net/can/raw.c                                      |    5 +-
 net/core/dev.c                                     |  276 ++-
 net/core/dev.h                                     |   14 +
 net/core/dev_addr_lists.c                          |    2 +-
 net/core/dev_api.c                                 |   13 +
 net/core/dev_ioctl.c                               |    5 +-
 net/core/dst.c                                     |   10 +-
 net/core/dst_cache.c                               |    2 +-
 net/core/filter.c                                  |   35 +-
 net/core/hotdata.c                                 |    5 +
 net/core/ieee8021q_helpers.c                       |   44 +-
 net/core/neighbour.c                               |  564 +++--
 net/core/net-sysfs.c                               |   80 +-
 net/core/net-sysfs.h                               |    2 +
 net/core/net_namespace.c                           |   64 +-
 net/core/netclassid_cgroup.c                       |    4 +-
 net/core/netdev-genl-gen.c                         |    5 +-
 net/core/netdev-genl.c                             |   14 +
 net/core/netdev_rx_queue.c                         |    6 +-
 net/core/netpoll.c                                 |  480 ++--
 net/core/page_pool.c                               |   36 +-
 net/core/rtnetlink.c                               |   10 +-
 net/core/selftests.c                               |   67 +-
 net/core/skbuff.c                                  |   38 +-
 net/core/skmsg.c                                   |    7 +
 net/core/sock.c                                    |   73 +-
 net/core/stream.c                                  |    8 +-
 net/core/sysctl_net_core.c                         |   37 +-
 net/devlink/netlink_gen.c                          |   15 +-
 net/devlink/netlink_gen.h                          |    1 +
 net/devlink/param.c                                |   20 +
 net/devlink/rate.c                                 |  127 ++
 net/dsa/Kconfig                                    |   16 +-
 net/dsa/dsa.c                                      |    3 +-
 net/dsa/tag_brcm.c                                 |  135 +-
 net/dsa/user.c                                     |    2 +-
 net/ethtool/common.c                               |   58 +
 net/ethtool/common.h                               |   13 +
 net/ethtool/ioctl.c                                |  327 +--
 net/ethtool/netlink.c                              |   95 +-
 net/ethtool/netlink.h                              |   12 +-
 net/ethtool/pause.c                                |    1 +
 net/ethtool/pse-pd.c                               |   65 +
 net/ethtool/rss.c                                  |  948 +++++++-
 net/handshake/tlshd.c                              |    6 +
 net/ipv4/arp.c                                     |   16 +-
 net/ipv4/datagram.c                                |    2 +-
 net/ipv4/fib_frontend.c                            |    2 +-
 net/ipv4/fib_semantics.c                           |   10 +-
 net/ipv4/icmp.c                                    |   24 +-
 net/ipv4/igmp.c                                    |    2 +-
 net/ipv4/inet_connection_sock.c                    |   42 +-
 net/ipv4/inet_diag.c                               |    2 +-
 net/ipv4/inet_hashtables.c                         |    4 +-
 net/ipv4/ip_fragment.c                             |    2 +-
 net/ipv4/ip_input.c                                |    6 +
 net/ipv4/ip_output.c                               |    9 +-
 net/ipv4/ip_tunnel.c                               |    4 +-
 net/ipv4/ip_tunnel_core.c                          |    4 +-
 net/ipv4/ip_vti.c                                  |    4 +-
 net/ipv4/ipconfig.c                                |    6 +-
 net/ipv4/ipmr.c                                    |  171 +-
 net/ipv4/netfilter.c                               |    4 +-
 net/ipv4/netfilter/Kconfig                         |   24 +-
 net/ipv4/nexthop.c                                 |    5 +-
 net/ipv4/ping.c                                    |    4 +-
 net/ipv4/proc.c                                    |    1 +
 net/ipv4/raw.c                                     |    4 +-
 net/ipv4/route.c                                   |   43 +-
 net/ipv4/syncookies.c                              |    3 +-
 net/ipv4/tcp.c                                     |   33 +-
 net/ipv4/tcp_fastopen.c                            |    4 +-
 net/ipv4/tcp_input.c                               |  227 +-
 net/ipv4/tcp_ipv4.c                                |  313 ++-
 net/ipv4/tcp_metrics.c                             |    8 +-
 net/ipv4/tcp_minisocks.c                           |    2 +-
 net/ipv4/tcp_output.c                              |   89 +-
 net/ipv4/tcp_recovery.c                            |    2 +-
 net/ipv4/tcp_timer.c                               |    2 +-
 net/ipv4/udp.c                                     |   29 +-
 net/ipv4/udp_impl.h                                |    1 +
 net/ipv4/udp_offload.c                             |   10 +-
 net/ipv4/udp_tunnel_core.c                         |   21 +-
 net/ipv4/udp_tunnel_nic.c                          |   78 +-
 net/ipv4/udplite.c                                 |    2 +-
 net/ipv4/xfrm4_output.c                            |    2 +-
 net/ipv6/addrconf.c                                |  106 +-
 net/ipv6/addrlabel.c                               |   32 +-
 net/ipv6/af_inet6.c                                |    2 +-
 net/ipv6/anycast.c                                 |  101 +-
 net/ipv6/calipso.c                                 |    6 +-
 net/ipv6/datagram.c                                |    6 +-
 net/ipv6/exthdrs.c                                 |   10 +-
 net/ipv6/icmp.c                                    |    4 +-
 net/ipv6/ila/ila_lwt.c                             |    2 +-
 net/ipv6/inet6_connection_sock.c                   |    4 +-
 net/ipv6/ioam6.c                                   |   17 +-
 net/ipv6/ioam6_iptunnel.c                          |    4 +-
 net/ipv6/ip6_fib.c                                 |   50 +-
 net/ipv6/ip6_gre.c                                 |  108 +-
 net/ipv6/ip6_input.c                               |   40 +-
 net/ipv6/ip6_output.c                              |   32 +-
 net/ipv6/ip6_tunnel.c                              |   49 +-
 net/ipv6/ip6_udp_tunnel.c                          |   20 +-
 net/ipv6/ip6_vti.c                                 |    4 +-
 net/ipv6/ip6mr.c                                   |  157 +-
 net/ipv6/ipv6_sockglue.c                           |   28 +-
 net/ipv6/mcast.c                                   |  393 ++--
 net/ipv6/ndisc.c                                   |  184 +-
 net/ipv6/netfilter.c                               |    4 +-
 net/ipv6/netfilter/Kconfig                         |   19 +-
 net/ipv6/netfilter/nf_dup_ipv6.c                   |    2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |    2 +-
 net/ipv6/output_core.c                             |    4 +-
 net/ipv6/ping.c                                    |    2 +-
 net/ipv6/raw.c                                     |    2 +-
 net/ipv6/reassembly.c                              |   10 +-
 net/ipv6/route.c                                   |  132 +-
 net/ipv6/rpl_iptunnel.c                            |    4 +-
 net/ipv6/seg6_iptunnel.c                           |   26 +-
 net/ipv6/seg6_local.c                              |   26 +-
 net/ipv6/sit.c                                     |    2 +-
 net/ipv6/syncookies.c                              |    2 +-
 net/ipv6/tcp_ipv6.c                                |   23 +-
 net/ipv6/udp.c                                     |   11 +-
 net/ipv6/udp_impl.h                                |    1 +
 net/ipv6/udplite.c                                 |    2 +-
 net/ipv6/xfrm6_output.c                            |    2 +-
 net/kcm/kcmsock.c                                  |    3 +-
 net/key/af_key.c                                   |    2 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/llc/af_llc.c                                   |    6 +-
 net/llc/llc_proc.c                                 |    2 +-
 net/mac80211/agg-rx.c                              |    6 +-
 net/mac80211/agg-tx.c                              |    3 +-
 net/mac80211/cfg.c                                 |  207 +-
 net/mac80211/chan.c                                |   51 +-
 net/mac80211/debugfs.c                             |    3 +-
 net/mac80211/debugfs_netdev.c                      |    2 +-
 net/mac80211/driver-ops.c                          |    5 +-
 net/mac80211/driver-ops.h                          |   59 +-
 net/mac80211/ht.c                                  |   40 +-
 net/mac80211/ibss.c                                |    4 +-
 net/mac80211/ieee80211_i.h                         |   73 +-
 net/mac80211/iface.c                               |   35 +-
 net/mac80211/key.c                                 |   66 +-
 net/mac80211/link.c                                |    9 +-
 net/mac80211/main.c                                |   88 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mlme.c                                |  318 ++-
 net/mac80211/offchannel.c                          |    7 +-
 net/mac80211/pm.c                                  |    2 +-
 net/mac80211/rx.c                                  |  113 +-
 net/mac80211/s1g.c                                 |   26 +
 net/mac80211/scan.c                                |   23 +-
 net/mac80211/sta_info.c                            |  420 +++-
 net/mac80211/sta_info.h                            |   59 +-
 net/mac80211/tdls.c                                |    2 +-
 net/mac80211/trace.h                               |  115 +-
 net/mac80211/tx.c                                  |  116 +-
 net/mac80211/util.c                                |  113 +-
 net/mac80211/vht.c                                 |    5 +-
 net/mctp/af_mctp.c                                 |  212 +-
 net/mctp/route.c                                   |  675 ++++--
 net/mctp/test/route-test.c                         |  798 +++++--
 net/mctp/test/sock-test.c                          |  396 ++++
 net/mctp/test/utils.c                              |  232 +-
 net/mctp/test/utils.h                              |   61 +
 net/mpls/af_mpls.c                                 |    6 +-
 net/mptcp/ctrl.c                                   |    4 +-
 net/mptcp/mib.c                                    |    5 +
 net/mptcp/mib.h                                    |    7 +
 net/mptcp/options.c                                |    5 +-
 net/mptcp/protocol.c                               |   52 +-
 net/mptcp/protocol.h                               |   35 +-
 net/mptcp/sockopt.c                                |   33 +-
 net/mptcp/subflow.c                                |   16 +-
 net/ncsi/internal.h                                |    2 +-
 net/ncsi/ncsi-rsp.c                                |    1 +
 net/netfilter/Kconfig                              |   30 +-
 net/netfilter/Makefile                             |    1 -
 net/netfilter/ipvs/ip_vs_conn.c                    |    2 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |    2 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 net/netfilter/nf_conntrack_core.c                  |   24 +-
 net/netfilter/nf_conntrack_netlink.c               |    1 -
 net/netfilter/nf_conntrack_proto.c                 |    6 -
 net/netfilter/nf_conntrack_proto_dccp.c            |  826 -------
 net/netfilter/nf_conntrack_standalone.c            |  118 +-
 net/netfilter/nf_log.c                             |   26 +
 net/netfilter/nf_nat_core.c                        |    6 -
 net/netfilter/nf_nat_proto.c                       |   43 -
 net/netfilter/nf_tables_api.c                      |   80 +-
 net/netfilter/nfnetlink_cttimeout.c                |    5 -
 net/netfilter/nfnetlink_hook.c                     |   80 +-
 net/netfilter/nft_dynset.c                         |   10 +-
 net/netfilter/nft_exthdr.c                         |    8 +
 net/netfilter/nft_lookup.c                         |   27 +-
 net/netfilter/nft_objref.c                         |    5 +-
 net/netfilter/nft_set_bitmap.c                     |   11 +-
 net/netfilter/nft_set_hash.c                       |   54 +-
 net/netfilter/nft_set_pipapo.c                     |  204 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   26 +-
 net/netfilter/nft_set_rbtree.c                     |   40 +-
 net/netfilter/x_tables.c                           |   16 +-
 net/netfilter/xt_nfacct.c                          |    4 +-
 net/netlink/af_netlink.c                           |    2 +-
 net/nfc/netlink.c                                  |    6 +-
 net/openvswitch/actions.c                          |    6 +-
 net/openvswitch/datapath.c                         |    8 +-
 net/openvswitch/datapath.h                         |    3 +
 net/openvswitch/vport.c                            |    1 +
 net/packet/af_packet.c                             |    2 +-
 net/packet/diag.c                                  |    2 +-
 net/phonet/socket.c                                |    4 +-
 net/rds/af_rds.c                                   |    2 +-
 net/rds/send.c                                     |    2 +-
 net/rds/tcp_listen.c                               |   30 +-
 net/rose/rose_in.c                                 |    3 +-
 net/sched/Kconfig                                  |   12 +
 net/sched/Makefile                                 |    1 +
 net/sched/act_api.c                                |    9 +-
 net/sched/act_connmark.c                           |   18 +-
 net/sched/act_csum.c                               |   18 +-
 net/sched/act_ct.c                                 |   30 +-
 net/sched/act_ctinfo.c                             |   42 +-
 net/sched/act_mpls.c                               |   21 +-
 net/sched/act_nat.c                                |   25 +-
 net/sched/act_pedit.c                              |   20 +-
 net/sched/act_police.c                             |   18 +-
 net/sched/act_skbedit.c                            |   20 +-
 net/sched/em_text.c                                |    2 +-
 net/sched/sch_cake.c                               |    5 +-
 net/sched/sch_dualpi2.c                            | 1175 ++++++++++
 net/sched/sch_generic.c                            |    2 +
 net/sched/sch_netem.c                              |   40 +
 net/sched/sch_taprio.c                             |   12 +-
 net/sctp/input.c                                   |    2 +-
 net/sctp/ipv6.c                                    |    7 +-
 net/sctp/proc.c                                    |    4 +-
 net/sctp/protocol.c                                |    3 +-
 net/sctp/socket.c                                  |    8 +-
 net/sctp/transport.c                               |    2 +-
 net/smc/af_smc.c                                   |    9 +-
 net/smc/smc_clc.c                                  |    6 +-
 net/smc/smc_core.c                                 |    5 +-
 net/smc/smc_diag.c                                 |    2 +-
 net/smc/smc_loopback.c                             |    6 -
 net/smc/smc_pnet.c                                 |    2 +-
 net/socket.c                                       |   54 +-
 net/strparser/strparser.c                          |    2 +-
 net/tipc/socket.c                                  |    2 +-
 net/tipc/udp_media.c                               |   12 +-
 net/tls/tls_sw.c                                   |   13 +
 net/unix/af_unix.c                                 |  189 +-
 net/unix/diag.c                                    |    2 +-
 net/vmw_vsock/af_vsock.c                           |   27 +-
 net/vmw_vsock/hyperv_transport.c                   |   17 +-
 net/wireless/core.c                                |   23 +-
 net/wireless/core.h                                |   11 +-
 net/wireless/mlme.c                                |   34 +-
 net/wireless/nl80211.c                             |  826 ++++++-
 net/wireless/rdev-ops.h                            |   45 +-
 net/wireless/reg.c                                 |   30 +-
 net/wireless/scan.c                                |  204 +-
 net/wireless/sme.c                                 |   39 +-
 net/wireless/trace.h                               |  129 +-
 net/wireless/util.c                                |   36 +
 net/wireless/wext-compat.c                         |   10 +-
 net/wireless/wext-core.c                           |    2 +-
 net/x25/af_x25.c                                   |    2 +-
 net/x25/x25_dev.c                                  |   22 -
 net/xdp/xsk.c                                      |   38 +-
 net/xdp/xsk_diag.c                                 |    2 +-
 net/xfrm/xfrm_input.c                              |   17 +-
 net/xfrm/xfrm_policy.c                             |    4 +-
 net/xfrm/xfrm_state.c                              |   81 +-
 rust/kernel/net/phy.rs                             |   34 +-
 scripts/checkpatch.pl                              |   12 +
 scripts/lib/kdoc/kdoc_parser.py                    |    1 +
 tools/include/uapi/linux/if_xdp.h                  |    1 +
 tools/include/uapi/linux/netdev.h                  |    6 +
 tools/net/ynl/pyynl/cli.py                         |    2 +
 tools/net/ynl/pyynl/lib/ynl.py                     |   23 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   49 +-
 tools/testing/selftests/bpf/config                 |    3 +
 .../selftests/bpf/prog_tests/sock_iter_batch.c     |  458 +++-
 .../selftests/bpf/prog_tests/sockmap_ktls.c        |   91 +
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |   36 +-
 .../selftests/bpf/progs/test_sockmap_ktls.c        |    4 +
 tools/testing/selftests/bpf/progs/verifier_ctx.c   |   25 +
 tools/testing/selftests/bpf/xskxceiver.c           |   56 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    1 +
 tools/testing/selftests/drivers/net/Makefile       |    3 +
 tools/testing/selftests/drivers/net/hw/Makefile    |    1 +
 .../selftests/drivers/net/hw/devlink_rate_tc_bw.py |  465 ++++
 tools/testing/selftests/drivers/net/hw/devmem.py   |    5 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   98 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |   17 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |    9 +-
 tools/testing/selftests/drivers/net/hw/rss_api.py  |  476 ++++
 .../selftests/drivers/net/hw/rss_input_xfrm.py     |    8 +-
 tools/testing/selftests/drivers/net/hw/tso.py      |  101 +-
 .../selftests/drivers/net/lib/py/__init__.py       |   14 +
 tools/testing/selftests/drivers/net/lib/py/env.py  |    2 +-
 tools/testing/selftests/drivers/net/lib/py/load.py |    2 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  165 +-
 .../drivers/net/mlxsw/spectrum-2/resource_scale.sh |    2 +-
 .../drivers/net/mlxsw/spectrum/resource_scale.sh   |    2 +-
 tools/testing/selftests/drivers/net/napi_id.py     |    4 +-
 .../testing/selftests/drivers/net/napi_id_helper.c |   35 +-
 .../testing/selftests/drivers/net/netcons_basic.sh |   55 +-
 .../selftests/drivers/net/netcons_cmdline.sh       |   52 +
 .../selftests/drivers/net/netcons_sysdata.sh       |   30 +
 .../selftests/drivers/net/netdevsim/devlink.sh     |   55 +
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   23 +-
 .../testing/selftests/drivers/net/netpoll_basic.py |  396 ++++
 tools/testing/selftests/drivers/net/ping.py        |    2 +-
 tools/testing/selftests/drivers/net/stats.py       |   45 +-
 tools/testing/selftests/drivers/net/xdp.py         |  658 ++++++
 tools/testing/selftests/hid/config.common          |    1 +
 tools/testing/selftests/net/.gitignore             |    1 +
 tools/testing/selftests/net/Makefile               |    5 +
 tools/testing/selftests/net/af_unix/Makefile       |    2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c      |  125 ++
 tools/testing/selftests/net/bench/Makefile         |    7 +
 .../testing/selftests/net/bench/page_pool/Makefile |   17 +
 .../net/bench/page_pool/bench_page_pool_simple.c   |  267 +++
 .../selftests/net/bench/page_pool/time_bench.c     |  394 ++++
 .../selftests/net/bench/page_pool/time_bench.h     |  238 ++
 .../selftests/net/bench/test_bench_page_pool.sh    |   32 +
 tools/testing/selftests/net/broadcast_pmtu.sh      |   47 +
 tools/testing/selftests/net/config                 |   11 +
 tools/testing/selftests/net/forwarding/Makefile    |    1 +
 tools/testing/selftests/net/forwarding/lib.sh      |   69 +-
 .../selftests/net/forwarding/router_multicast.sh   |   35 +-
 .../testing/selftests/net/forwarding/tc_flower.sh  |   52 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh        |  771 +++++++
 .../testing/selftests/net/ipv6_force_forwarding.sh |  105 +
 tools/testing/selftests/net/lib.sh                 |   35 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    2 +-
 tools/testing/selftests/net/lib/py/ksft.py         |    7 +-
 tools/testing/selftests/net/lib/py/utils.py        |   39 +
 tools/testing/selftests/net/lib/py/ynl.py          |    5 +
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |  621 ++++++
 tools/testing/selftests/net/mptcp/config           |    2 +
 tools/testing/selftests/net/msg_zerocopy.c         |   24 +-
 tools/testing/selftests/net/msg_zerocopy.sh        |   84 +-
 tools/testing/selftests/net/netdev-l2addr.sh       |   59 +
 tools/testing/selftests/net/netfilter/config       |    7 +-
 tools/testing/selftests/net/netfilter/ipvs.sh      |    4 +-
 .../net/netfilter/nft_interface_stress.sh          |    5 +-
 tools/testing/selftests/net/nettest.c              |   12 +-
 tools/testing/selftests/net/nl_netdev.py           |  127 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |    4 +
 .../net/packetdrill/tcp_blocking_blocking-read.pkt |    2 +
 .../selftests/net/packetdrill/tcp_dsack_mult.pkt   |   45 +
 .../selftests/net/packetdrill/tcp_inq_client.pkt   |    3 +
 .../selftests/net/packetdrill/tcp_inq_server.pkt   |    3 +
 .../selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt  |   27 +
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   44 +
 .../selftests/net/packetdrill/tcp_rcv_toobig.pkt   |   33 +
 tools/testing/selftests/net/rtnetlink.sh           |   92 +-
 .../selftests/net/rtnetlink_notification.sh        |  112 +
 .../selftests/net/srv6_end_next_csid_l3vpn_test.sh |    2 +-
 .../net/srv6_end_x_next_csid_l3vpn_test.sh         |   50 +-
 .../selftests/net/srv6_hencap_red_l3vpn_test.sh    |    2 +-
 .../selftests/net/srv6_hl2encap_red_l2vpn_test.sh  |    2 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |    2 +-
 tools/testing/selftests/net/test_neigh.sh          |  366 ++++
 .../selftests/net/test_vxlan_vnifiltering.sh       |    9 +-
 tools/testing/selftests/net/vrf_route_leaking.sh   |    4 +-
 tools/testing/selftests/ptp/testptp.c              |   11 +-
 tools/testing/selftests/tc-testing/config          |    2 +
 .../tc-testing/tc-tests/infra/qdiscs.json          |    5 +-
 .../tc-testing/tc-tests/qdiscs/dualpi2.json        |  254 +++
 .../tc-testing/tc-tests/qdiscs/netem.json          |   81 +
 .../selftests/tc-testing/tc-tests/qdiscs/sfq.json  |   36 +
 tools/testing/selftests/tc-testing/tdc.sh          |    6 +-
 tools/testing/selftests/vsock/.gitignore           |    2 +
 tools/testing/selftests/vsock/Makefile             |   17 +
 tools/testing/selftests/vsock/config               |  111 +
 tools/testing/selftests/vsock/settings             |    1 +
 tools/testing/selftests/vsock/vmtest.sh            |  487 ++++
 .../testing/selftests/wireguard/qemu/kernel.config |    4 +
 tools/testing/vsock/Makefile                       |    1 +
 tools/testing/vsock/util.c                         |  126 +-
 tools/testing/vsock/util.h                         |   35 +
 tools/testing/vsock/vsock_test.c                   |  353 ++-
 1906 files changed, 83410 insertions(+), 29341 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/lpc-eth.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ks8995.txt
 create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc-eth.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.txt
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.yaml
 rename Documentation/devicetree/bindings/net/{renesas,r9a09g057-gbeth.yaml => renesas,rzv2h-gbeth.yaml} (97%)
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst
 create mode 100644 Documentation/networking/devlink/zl3073x.rst
 create mode 100644 drivers/dpll/zl3073x/Kconfig
 create mode 100644 drivers/dpll/zl3073x/Makefile
 create mode 100644 drivers/dpll/zl3073x/core.c
 create mode 100644 drivers/dpll/zl3073x/core.h
 create mode 100644 drivers/dpll/zl3073x/devlink.c
 create mode 100644 drivers/dpll/zl3073x/devlink.h
 create mode 100644 drivers/dpll/zl3073x/dpll.c
 create mode 100644 drivers/dpll/zl3073x/dpll.h
 create mode 100644 drivers/dpll/zl3073x/i2c.c
 create mode 100644 drivers/dpll/zl3073x/prop.c
 create mode 100644 drivers/dpll/zl3073x/prop.h
 create mode 100644 drivers/dpll/zl3073x/regs.h
 create mode 100644 drivers/dpll/zl3073x/spi.c
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (96%)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_debugfs.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_devlink.h
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/Makefile
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_core.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_resc.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
 create mode 100644 drivers/net/ethernet/google/gve/gve_ptp.c
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_cgu_regs.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_idc.c
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c
 create mode 100644 drivers/net/ethernet/intel/libie/adminq.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
 create mode 100644 drivers/net/mdio/mdio-airoha.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/internal.h (96%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c (98%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c (96%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans.c (89%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c (100%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c (98%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h (98%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info.h (100%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.h
 rename drivers/net/wireless/intel/iwlwifi/{mvm/tests/scan.c => tests/utils.c} (63%)
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
 delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h
 delete mode 100644 drivers/s390/net/netiucv.c
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h => include/linux/bnxt/hsi.h (100%)
 create mode 100644 include/linux/net/intel/iidc_rdma_idpf.h
 create mode 100644 include/linux/net/intel/libie/adminq.h
 create mode 100644 include/linux/net/intel/libie/pctype.h
 delete mode 100644 include/linux/netfilter/nf_conntrack_dccp.h
 create mode 100644 include/linux/soc/marvell/silicons.h
 create mode 100644 include/linux/virtio_features.h
 create mode 100644 include/net/aligned_data.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 net/mctp/test/sock-test.c
 delete mode 100644 net/netfilter/nf_conntrack_proto_dccp.c
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_api.py
 create mode 100755 tools/testing/selftests/drivers/net/netcons_cmdline.sh
 create mode 100755 tools/testing/selftests/drivers/net/netpoll_basic.py
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/af_unix/scm_inq.c
 create mode 100644 tools/testing/selftests/net/bench/Makefile
 create mode 100644 tools/testing/selftests/net/bench/page_pool/Makefile
 create mode 100644 tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
 create mode 100644 tools/testing/selftests/net/bench/page_pool/time_bench.c
 create mode 100644 tools/testing/selftests/net/bench/page_pool/time_bench.h
 create mode 100755 tools/testing/selftests/net/bench/test_bench_page_pool.sh
 create mode 100755 tools/testing/selftests/net/broadcast_pmtu.sh
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
 create mode 100755 tools/testing/selftests/net/ipv6_force_forwarding.sh
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c
 create mode 100755 tools/testing/selftests/net/netdev-l2addr.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_dsack_mult.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
 create mode 100755 tools/testing/selftests/net/rtnetlink_notification.sh
 create mode 100755 tools/testing/selftests/net/test_neigh.sh
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
 create mode 100644 tools/testing/selftests/vsock/.gitignore
 create mode 100644 tools/testing/selftests/vsock/Makefile
 create mode 100644 tools/testing/selftests/vsock/config
 create mode 100644 tools/testing/selftests/vsock/settings
 create mode 100755 tools/testing/selftests/vsock/vmtest.sh

