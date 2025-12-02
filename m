Return-Path: <netdev+bounces-243342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E47C9D5F5
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 00:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949DA4E03CC
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90F3101D2;
	Tue,  2 Dec 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRlhoNGG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1230FF26;
	Tue,  2 Dec 2025 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719386; cv=none; b=BaRKO7ILQJXKA4lSKqtfQQ2BH1lgw7K/tfIOq6kW2UeAzLfCEw2izfisTOvovlFqZeQlUkmZtW4Jt9wxSSOZJIdX5zjIJic+VSF6iZ+d9+fnB2DLj0lIU2FRyuKbSLAWqn0oOsxxT9pKvRZWCHPHOhz+hRLQ+o5usv8pDu1RNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719386; c=relaxed/simple;
	bh=w1QrMudml7eto9BEWL127nVmLvUZuPJ6mlo2zTboqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M650Xhc1sBeWRAbK0oFNCBh5R9EVH9eSJaDCw6nWK+qub9KWQ6g0tE1+OZeliT6xdwOZ3OOPAXlRAKghK2EOrJhxW7RcLBgJ6XckCHgJLpPLvus/5MZWrYmF1yjZMYO72z3Oq0NL0H2fS/UuMpnBy0xuHlin64oglMWziEPJPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRlhoNGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48229C4CEF1;
	Tue,  2 Dec 2025 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719385;
	bh=w1QrMudml7eto9BEWL127nVmLvUZuPJ6mlo2zTboqjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RRlhoNGGXNVp2w89H6P+QFtSOEK4V9qIGGALA0XKhaGec5Qtx3FUE0vWXVpbzPn3t
	 aGjckPYx8KAktdstQl6O5oIwbz8Ejx7+ZigrRsCICBFAgjj2XkKyuANeXu4VFIqZzk
	 O1vxdNYOl4Fi8dgqERnTuKBnw/Ere4E+tddYEeHTFGW7ktSc9Vbkzv8Fz/f02he5PS
	 CJEvmb3IdjMWhwY1zPboQerqXVVveeyRye8aQZL4Tn5gz6K6nSqmh88Bh13mzZ6T77
	 gj5QI8EQ2kqVBNSKt4BfzeyZEl6RvEBUG19UqwkvWdlVFzi93he5IsQCXPlrMLiT9G
	 nm2QkiHQqPUvg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for Linux 6.19
Date: Tue,  2 Dec 2025 15:49:43 -0800
Message-ID: <20251202234943.2312938-1-kuba@kernel.org>
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

The following changes since commit 1f5e808aa63af61ec0d6a14909056d6668813e86:

  Merge tag 'net-6.18-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-27 09:18:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.19

for you to fetch changes up to 4de44542991ed4cb8c9fb2ccd766d6e6015101b0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-02 15:37:53 -0800)

----------------------------------------------------------------
Networking changes for 6.19.

Core & protocols
----------------

 - Replace busylock at the Tx queuing layer with a lockless list. Resulting
   in a 300% (4x) improvement on heavy TX workloads, sending twice the
   number of packets per second, for half the cpu cycles.

 - Allow constantly busy flows to migrate to a more suitable CPU/NIC
   queue. Normally we perform queue re-selection when flow comes out
   of idle, but under extreme circumstances the flows may be constantly
   busy. Add sysctl to allow periodic rehashing even if it'd risk packet
   reordering.

 - Optimize the NAPI skb cache, make it larger, use it in more paths.

 - Attempt returning Tx skbs to the originating CPU (like we already did
   for Rx skbs).

 - Various data structure layout and prefetch optimizations from Eric.

 - Remove ktime_get() from the recvmsg() fast path, ktime_get() is sadly
   quite expensive on recent AMD machines.

 - Extend threaded NAPI polling to allow the kthread busy poll for packets.

 - Make MPTCP use Rx backlog processing. This lowers the lock pressure,
   improving the Rx performance.

 - Support memcg accounting of MPTCP socket memory.

 - Allow admin to opt sockets out of global protocol memory accounting
   (using a sysctl or BPF-based policy). The global limits are a poor fit
   for modern container workloads, where limits are imposed using cgroups.

 - Improve heuristics for when to kick off AF_UNIX garbage collection.

 - Allow users to control TCP SACK compression, and default to 33% of RTT.

 - Add tcp_rcvbuf_low_rtt sysctl to let datacenter users avoid unnecessarily
   aggressive rcvbuf growth and overshot when the connection RTT is low.

 - Preserve skb metadata space across skb_push / skb_pull operations.

 - Support for IPIP encapsulation in the nftables flowtable offload.

 - Support appending IP interface information to ICMP messages (RFC 5837).

 - Support setting max record size in TLS (RFC 8449).

 - Remove taking rtnl_lock from RTM_GETNEIGHTBL and RTM_SETNEIGHTBL.

 - Use a dedicated lock (and RCU) in MPLS, instead of rtnl_lock.

 - Let users configure the number of write buffers in SMC.

 - Add new struct sockaddr_unsized for sockaddr of unknown length,
   from Kees.

 - Some conversions away from the crypto_ahash API, from Eric Biggers.

 - Some preparations for slimming down struct page.

 - YAML Netlink protocol spec for WireGuard.

 - Add a tool on top of YAML Netlink specs/lib for reporting commonly
   computed derived statistics and summarized system state.

Driver API
----------

 - Add CAN XL support to the CAN Netlink interface.

 - Add uAPI for reporting PHY Mean Square Error (MSE) diagnostics,
   as defined by the OPEN Alliance's "Advanced diagnostic features
   for 100BASE-T1 automotive Ethernet PHYs" specification.

 - Add DPLL phase-adjust-gran pin attribute (and implement it in zl3073x).

 - Refactor xfrm_input lock to reduce contention when NIC offloads IPsec
   and performs RSS.

 - Add info to devlink params whether the current setting is the default
   or a user override. Allow resetting back to default.

 - Add standard device stats for PSP crypto offload.

 - Leverage DSA frame broadcast to implement simple HSR frame duplication
   for a lot of switches without dedicated HSR offload.

 - Add uAPI defines for 1.6Tbps link modes.

Device drivers
--------------

 - Add Motorcomm YT921x gigabit Ethernet switch support.

 - Add MUCSE driver for N500/N210 1GbE NIC series.

 - Convert drivers to support dedicated ops for timestamping control,
   and away from the direct IOCTL handling. While at it support GET
   operations for PHY timestamping.

 - Add (and convert most drivers to) a dedicated ethtool callback
   for reading the Rx ring count.

 - Significant refactoring efforts in the STMMAC driver, which supports
   Synopsys turn-key MAC IP integrated into a ton of SoCs.

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
     - support PPS in/out on all pins
   - Intel (100G, ice, idpf):
     - ice: implement standard ethtool and timestamping stats
     - i40e: support setting the max number of MAC addresses per VF
     - iavf: support RSS of GTP tunnels for 5G and LTE deployments
   - nVidia/Mellanox (mlx5):
     - reduce downtime on interface reconfiguration
     - disable being an XDP redirect target by default (same as other
       drivers) to avoid wasting resources if feature is unused
   - Meta (fbnic):
     - add support for Linux-managed PCS on 25G, 50G, and 100G links
   - Wangxun:
     - support Rx descriptor merge, and Tx head writeback
     - support Rx coalescing offload
     - support 25G SPF and 40G QSFP modules

 - Ethernet virtual:
   - Google (gve):
     - allow ethtool to configure rx_buf_len
     - implement XDP HW RX Timestamping support for DQ descriptor format
   - Microsoft vNIC (mana):
     - support HW link state events
     - handle hardware recovery events when probing the device

 - Ethernet NICs consumer, and embedded:
   - usbnet: add support for Byte Queue Limits (BQL)
   - AMD (amd-xgbe):
     - add device selftests
   - NXP (enetc):
     - add i.MX94 support
   - Broadcom integrated MACs (bcmgenet, bcmasp):
     - bcmasp: add support for PHY-based Wake-on-LAN
   - Broadcom switches (b53):
     - support port isolation
     - support BCM5389/97/98 and BCM63XX ARL formats
   - Lantiq/MaxLinear switches:
     - support bridge FDB entries on the CPU port
     - use regmap for register access
     - allow user to enable/disable learning
     - support Energy Efficient Ethernet
     - support configuring RMII clock delays
     - add tagging driver for MaxLinear GSW1xx switches
   - Synopsys (stmmac):
     - support using the HW clock in free running mode
     - add Eswin EIC7700 support
     - add Rockchip RK3506 support
     - add Altera Agilex5 support
   - Cadence (macb):
     - cleanup and consolidate descriptor and DMA address handling
     - add EyeQ5 support
   - TI:
     - icssg-prueth: support AF_XDP
   - Airoha access points:
     - add missing Ethernet stats and link state callback
     - add AN7583 support
     - support out-of-order Tx completion processing
   - Power over Ethernet:
     - pd692x0: preserve PSE configuration across reboots
     - add support for TPS23881B devices

 - Ethernet PHYs:
   - Open Alliance OATC14 10BASE-T1S PHY cable diagnostic support
   - Support 50G SerDes and 100G interfaces in Linux-managed PHYs
   - micrel:
     - support for non PTP SKUs of lan8814
     - enable in-band auto-negotiation on lan8814
   - realtek:
     - cable testing support on RTL8224
     - interrupt support on RTL8221B
   - motorcomm: support for PHY LEDs on YT853
   - microchip: support for LAN867X Rev.D0 PHYs w/ SQI and cable diag
   - mscc: support for PHY LED control

 - CAN drivers:
   - m_can: add support for optional reset and system wake up
   - remove can_change_mtu() obsoleted by core handling
   - mcp251xfd: support GPIO controller functionality

 - Bluetooth:
   - add initial support for PASTa

 - WiFi:
   - split ieee80211.h file, it's way too big
   - improvements in VHT radiotap reporting, S1G, Channel Switch
     Announcement handling, rate tracking in mesh networks
   - improve multi-radio monitor mode support, and add a cfg80211 debugfs
     interface for it
   - HT action frame handling on 6 GHz
   - initial chanctx work towards NAN
   - MU-MIMO sniffer improvements

 - WiFi drivers:
   - RealTek (rtw89):
     - support USB devices RTL8852AU and RTL8852CU
     - initial work for RTL8922DE
     - improved injection support
   - Intel:
     - iwlwifi: new sniffer API support
   - MediaTek (mt76):
     - WED support for >32-bit DMA
     - airoha NPU support
     - regdomain improvements
     - continued WiFi7/MLO work
   - Qualcomm/Atheros:
     - ath10k: factory test support
     - ath11k: TX power insertion support
     - ath12k: BSS color change support
     - ath12k: statistics improvements
   - brcmfmac: Acer A1 840 tablet quirk
   - rtl8xxxu: 40 MHz connection fixes/support

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (3):
      wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()

Abhishek Rawal (1):
      r8152: Advertise software timestamp information.

Adithya Jayachandran (1):
      {rdma,net}/mlx5: Query vports mac address from device

Aditya Garg (2):
      net: mana: Handle SKB if TX SGEs exceed hardware limit
      net: mana: Drop TX skb on post_work_request failure and unmap resources

Aditya Kumar Singh (6):
      wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon
      wifi: ath11k: relocate some Tx power related functions in mac.c
      wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      wifi: ath11k: add support for Tx Power insertion in RRM action frame
      wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION
      wifi: mac80211_hwsim: advertise puncturing feature support

Adrian Moreno (1):
      rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS

Alan Maguire (1):
      cxgb4: Rename sched_class to avoid type clash

Aleksandr Loktionov (5):
      ice: add flow parsing for GTP and new protocol field support
      ice: add virtchnl definitions and static data for GTP RSS
      ice: implement GTP RSS context tracking and configuration
      ice: improve TCAM priority handling for RSS profiles
      iavf: add RSS support for GTP protocol via ethtool

Alessandro Zanni (1):
      selftest: net: prevent use of uninitialized variable

Alexander Dahl (2):
      net: phy: adin1100: Fix software power-down ready condition
      net: phy: adin1100: Simplify register value passing

Alexander Duyck (9):
      net: phy: Add MDIO_PMA_CTRL1_SPEED for 2.5G and 5G to reflect PMA values
      net: pcs: xpcs: Add support for 25G, 50G, and 100G interfaces
      net: pcs: xpcs: Fix PMA identifier handling in XPCS
      net: pcs: xpcs: Add support for FBNIC 25G, 50G, 100G PMD
      fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
      fbnic: Add logic to track PMD state via MAC/PCS signals
      fbnic: Add handler for reporting link down event statistics
      fbnic: Add SW shim for MDIO interface to PMD and PCS
      fbnic: Replace use of internal PCS w/ Designware XPCS

Alexander Lobakin (2):
      ice: implement configurable header split for regular Rx
      ice: fix broken Rx on VFs

Alexandra Winter (2):
      dibs: Remove reset of static vars in dibs_init()
      dibs: Use subsys_initcall()

Alexey Kodanev (1):
      net: stmmac: fix rx limit check in stmmac_rx_zc()

Alok Tiwari (17):
      net: bridge: correct debug message function name in br_fill_ifinfo
      eth: fbnic: fix various typos in comments and strings
      net: amd-xgbe: use EOPNOTSUPP instead of ENOTSUPP in xgbe_phy_mii_read_c45
      net: phy: micrel: simplify return in ksz9477_phy_errata()
      net: phy: micrel: fix typos in comments
      devlink: region: correct port region lookup to use port_ops
      ixgbe: fix typos in ixgbe driver comments
      igbvf: fix misplaced newline in VLAN add warning message
      hinic3: fix misleading error message in hinic3_open_channel()
      net: dsa: ks8995: Fix incorrect OF match table name
      wifi: mt76: mt7996: fix typos in comments
      ixgbe: avoid redundant call to ixgbe_non_sfp_link_config()
      idpf: use desc_ring when checking completion queue DMA allocation
      idpf: correct queue index in Rx allocation error messages
      ice: fix comment typo and correct module format string
      iavf: clarify VLAN add/delete log messages and lower log level
      l2tp: correct debugfs label for tunnel tx stats

Andre Carvalho (2):
      selftests: netconsole: ensure required log level is set on netcons_basic
      selftests: netconsole: remove log noise due to socat exit

Andy Shevchenko (4):
      ptp: ocp: Refactor signal_show() and fix %ptT misuse
      ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
      ptp: ocp: Apply standard pattern for cleaning up loop
      ptp: ocp: Reuse META's PCI vendor ID

Ankit Garg (5):
      gve: Consolidate and persist ethtool ring changes
      gve: Decouple header split from RX buffer length
      gve: Use extack to log xdp config verification errors
      gve: Allow ethtool to configure rx_buf_len
      gve: Default to max_rx_buffer_size for DQO if device supported

Ankit Khushwaha (2):
      selftest: net: fix socklen_t type mismatch in sctp_collision test
      selftests/net: initialize char variable to null

Anshumali Gaur (1):
      octeontx2-af: Skip TM tree print for disabled SQs

Antoine Tenart (1):
      net: vxlan: prevent NULL deref in vxlan_xmit_one

Ariel D'Alessandro (1):
      dt-bindings: net: Convert Marvell 8897/8997 bindings to DT schema

Asbjørn Sloth Tønnesen (12):
      tools: ynl-gen: add function prefix argument
      tools: ynl-gen: add regeneration comment
      wireguard: netlink: enable strict genetlink validation
      wireguard: netlink: validate nested arrays in policy
      wireguard: netlink: use WG_KEY_LEN in policies
      wireguard: netlink: convert to split ops
      wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
      wireguard: netlink: add YNL specification
      wireguard: uapi: move enum wg_cmd
      wireguard: uapi: move flag enums
      wireguard: uapi: generate header with ynl-gen
      wireguard: netlink: generate netlink code

Aswin Karuvally (4):
      s390/iucv: Convert sprintf/snprintf to scnprintf
      s390/ctcm: Use info level for handshake UC_RCRESET
      s390/qeth: Move all OSA RCs to single enum
      s390/qeth: Handle ambiguous OSA RCs in s390dbf

Ayaan Mirza Baig (1):
      drivers/bluetooth: btbcm: Use kmalloc_array() to prevent overflow

Bagas Sanjaya (14):
      net: nfc: Format userspace interface subsection headings
      net: 6pack: Demote "How to turn on 6pack support" section heading
      net: rmnet: Use section heading markup for packet format subsections
      Documentation: netconsole: Separate literal code blocks for full and short netcat command name versions
      Documentation: ARCnet: Update obsolete contact info
      Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
      Documentation: xfrm_device: Use numbered list for offloading steps
      Documentation: xfrm_device: Separate hardware offload sublists
      Documentation: xfrm_sync: Properly reindent list text
      Documentation: xfrm_sync: Trim excess section heading characters
      Documentation: xfrm_sysctl: Trim trailing colon in section heading
      Documentation: xfrm_sync: Number the fifth section
      net: Move XFRM documentation into its own subdirectory
      MAINTAINERS: Add entry for XFRM documentation

Baochen Qiang (7):
      wifi: ath11k: restore register window after global reset
      wifi: ath12k: fix VHT MCS assignment
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment
      wifi: ath12k: restore register window after global reset
      wifi: ath12k: fix reusing m3 memory
      wifi: ath12k: fix error handling in creating hardware group

Benjamin Berg (3):
      wifi: mac80211: add RX flag to report radiotap VHT information
      wifi: mac80211: track MU-MIMO configuration on disabled interfaces
      wifi: mac80211: make monitor link info check more specific

Biju Das (1):
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk

Bitterblue Smith (25):
      wifi: rtl8xxxu: Report the signal strength only if it's known
      wifi: rtl8xxxu: Dump the efuse right after reading it
      wifi: rtl8xxxu: Use correct power off sequence for RTL8192CU
      wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
      wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
      wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
      wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
      wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
      wifi: rtw89: 8852c: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852cu.c
      wifi: rtw89: Enable the new rtw89_8852cu module
      wifi: rtw89: Use the correct power sequences for USB/SDIO
      wifi: rtw89: Add rtw8852a_dle_mem_usb
      wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
      wifi: rtw89: 8852a: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852au.c
      wifi: rtw89: Enable the new rtw89_8852au module
      wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
      wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
      wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
      wifi: rtl8xxxu: Enable 40 MHz width by default

Bobby Eshleman (13):
      net: netmem: remove NET_IOV_MAX from net_iov_type enum
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

Breno Leitao (25):
      tg3: extract GRXRINGS from .get_rxnfc
      tg3: Fix num of RX queues being reported by ethtool
      net: ixgbe: convert to use .get_rx_ring_count
      net: bnx2x: convert to use get_rx_ring_count
      mlx4: extract GRXRINGS from .get_rxnfc
      mlx5: extract GRXRINGS from .get_rxnfc
      net: vmxnet3: convert to use .get_rx_ring_count
      net: hyperv: convert to use .get_rx_ring_count
      net: mvneta: convert to use .get_rx_ring_count
      net: mvpp2: extract GRXRINGS from .get_rxnfc
      i40e: extract GRXRINGS from .get_rxnfc
      iavf: extract GRXRINGS from .get_rxnfc
      ice: extract GRXRINGS from .get_rxnfc
      idpf: extract GRXRINGS from .get_rxnfc
      igb: extract GRXRINGS from .get_rxnfc
      igc: extract GRXRINGS from .get_rxnfc
      ixgbevf: extract GRXRINGS from .get_rxnfc
      fm10k: extract GRXRINGS from .get_rxnfc
      net: thunder: convert to use .get_rx_ring_count
      net: bnxt: extract GRXRINGS from .get_rxnfc
      net: bcmgenet: extract GRXRINGS from .get_rxnfc
      net: netpoll: initialize work queue before error checks
      net: gianfar: convert to use .get_rx_ring_count
      net: dpaa2: convert to use .get_rx_ring_count
      net: enetc: convert to use .get_rx_ring_count

Buday Csaba (6):
      dt-bindings: net: ethernet-phy: clarify when compatible must specify PHY ID
      net: mdio: move device reset functions to mdio_device.c
      net: mdio: common handling of phy device reset properties
      net: mdio: improve reset handling in mdio_device.c
      net: mdio: eliminate kdoc warnings in mdio_device.c and mdio_bus.c
      net: mdio: remove redundant fwnode cleanup

Byungchul Park (3):
      netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
      eth: fbnic: access @pp through netmem_desc instead of page
      netmem, devmem, tcp: access pp fields through @desc in net_iov

Caleb James DeLisle (1):
      wifi: mt76: mmio_*_copy fix byte order and alignment

Carlos Llamas (1):
      selftests/net: io_uring: fix unknown errnum values

Carolina Jubran (14):
      net/mlx5e: Remove redundant tstamp pointer from channel structures
      net/mlx5e: Remove unnecessary tstamp local variable in mlx5i_complete_rx_cqe
      net/mlx5e: Rename hwstamp functions to hwtstamp
      net/mlx5e: Rename timestamp fields to hwtstamp_config
      IB/IPoIB: Add support for hwtstamp get/set ndos
      net/mlx5e: Convert to new hwtstamp_get/set interface
      net/mlx5e: Recover SQ on excessive PTP TX timestamp delta
      net/mlx5: Remove redundant bw_share minimal value assignment
      selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
      selftests: drv-net: introduce Iperf3Runner for measurement use cases
      selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
      selftests: drv-net: Set shell=True for sysfs writes in devlink_rate_tc_bw.py
      selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
      selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py

Chad Monroe (1):
      net: phy: mxl-gpy: add support for MxL86211C

Chen Ni (1):
      net/sched: act_ife: convert comma to semicolon

Chethan T N (1):
      Bluetooth: btintel_pcie: Introduce HCI Driver protocol

Chien Wong (6):
      wifi: cfg80211: fix doc of struct key_params
      wifi: mac80211: fix CMAC functions not handling errors
      wifi: mac80211: add generic MMIE struct defines
      wifi: mac80211: utilize the newly defined CMAC constants
      wifi: mac80211: refactor CMAC crypt functions
      wifi: mac80211: refactor CMAC packet handlers

Chih-Kang Chang (3):
      wifi: rtw89: flush TX queue before deleting key
      wifi: rtw89: update format of addr cam H2C command
      wifi: rtw89: correct user macid mask of RX info for RTL8922D

Chin-Yen Lee (2):
      wifi: rtw89: restart hardware to recover firmware if power-save becomes abnormal
      wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets

Chingbin Li (1):
      Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Chris Lu (2):
      Bluetooth: btusb: MT7920: Add VID/PID 0489/e135
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e170

Christophe JAILLET (1):
      sctp: Constify struct sctp_sched_ops

Chu Guangqing (6):
      virtio_net: Fix a typo error in virtio_net
      gtp: Fix a typo error for size
      veth: Fix a typo error in veth
      net: sungem_phy: Fix a typo error in sungem_phy
      xen/netfront: Comment Correction: Fix Spelling Error and Description of Queue Quantity Rules
      can: bxcan: Fix a typo error for assign

Clark Wang (1):
      net: enetc: add ptp timer binding support for i.MX94

Colin Ian King (2):
      net: dsa: yt921x: Fix spelling mistake "stucked" -> "stuck"
      ynl: samples: Fix spelling mistake "failedq" -> "failed"

Conor Dooley (1):
      dt-bindings: can: mpfs: document resets

Cosmin Ratiu (6):
      net/mlx5: Initialize events outside devlink lock
      net/mlx5: Move the esw mode notifier chain outside the devlink lock
      net/mlx5: Move the vhca event notifier outside of the devlink lock
      net/mlx5: Move the SF HW table notifier outside the devlink lock
      net/mlx5: Move the SF table notifiers outside the devlink lock
      net/mlx5: Move SF dev table notifier registration outside the PF devlink lock

D. Wythe (3):
      bpf: Export necessary symbols for modules with struct_ops
      net/smc: bpf: Introduce generic hook for handshake flow
      bpf/selftests: Add selftest for bpf_smc_hs_ctrl

Dan Carpenter (3):
      net: airoha: Fix a copy and paste bug in probe()
      net: dsa: microchip: Fix a link check in ksz9477_pcs_read()
      i40e: delete a stray tab

Dan Hamik (1):
      wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dongle

Daniel Borkmann (2):
      xsk: Move NETDEV_XDP_ACT_ZC into generic header
      netkit: Document fast vs slowpath members via macros

Daniel Golle (20):
      net: dsa: lantiq_gswip: clarify GSWIP 2.2 VLAN mode in comment
      net: dsa: lantiq_gswip: convert accessors to use regmap
      net: dsa: lantiq_gswip: convert trivial accessor uses to regmap
      net: dsa: lantiq_gswip: manually convert remaining uses of read accessors
      net: dsa: lantiq_gswip: replace *_mask() functions with regmap API
      net: dsa: lantiq_gswip: optimize regmap_write_bits() statements
      net: dsa: lantiq_gswip: harmonize gswip_mii_mask_*() parameters
      net: dsa: lantiq_gswip: split into common and MMIO parts
      net: dsa: lantiq_gswip: support enable/disable learning
      net: dsa: lantiq_gswip: support Energy Efficient Ethernet
      net: dsa: lantiq_gswip: set link parameters also for CPU port
      net: dsa: lantiq_gswip: define and use GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
      dt-bindings: net: dsa: lantiq,gswip: add MaxLinear RMII refclk output property
      net: dsa: lantiq_gswip: add vendor property to setup MII refclk output
      dt-bindings: net: dsa: lantiq,gswip: add support for MII delay properties
      net: dsa: lantiq_gswip: allow adjusting MII delays
      dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx switches
      net: dsa: add tagging driver for MaxLinear GSW1xx switch family
      net: dsa: add driver for MaxLinear GSW1xx switch family
      net: phy: mxl-gpy: add support for MxL86252 and MxL86282

Daniel Zahka (8):
      selftests: drv-net: psp: add assertions on core-tracked psp dev stats
      netdevsim: implement psp device stats
      devlink: pass extack through to devlink_param::get()
      devlink: refactor devlink_nl_param_value_fill_one()
      devlink: support default values for param-get and param-set
      net/mlx5: implement swp_l4_csum_mode via devlink params
      netdevsim: register a new devlink param with default value interface
      selftest: netdevsim: test devlink default params

David Wu (1):
      ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support

David Yang (9):
      dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
      net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
      net: dsa: yt921x: Add support for Motorcomm YT921x
      MAINTAINERS: add entry for Motorcomm YT921x ethernet switch driver
      net: dsa: yt921x: Fix parsing MIB attributes
      net: dsa: yt921x: Use macros for MIB locations
      net: dsa: yt921x: Set ageing_time_min/ageing_time_max
      net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
      net: dsa: yt921x: Add STP/MST support

Denis Benato (1):
      eth: fealnx: fix typo in comments

Dimitri Daskalakis (5):
      net: fbnic: Fix page chunking logic when PAGE_SIZE > 4K
      net: fbnic: Allow builds for all 64 bit architectures
      selftests: drv-net: Limit the max number of queues in procfs_downup_hammer
      selftests: drv-net: xdp: Fix register spill error with clang 20
      drivers: net: fbnic: Return the true error in fbnic_alloc_napi_vectors.

Dmitry Skorodumov (1):
      ipvlan: fix sparse warning about __be32 -> u32

Donald Hunter (5):
      tools: ynltool: ignore *.d deps files
      tools: ynl: add schema checking
      tools: ynl: add a lint makefile target
      ynl: fix a yamllint warning in ethtool spec
      ynl: fix schema check errors

Dong Yibo (5):
      net: rnpgbe: Add build support for rnpgbe
      net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
      net: rnpgbe: Add basic mbx ops support
      net: rnpgbe: Add basic mbx_fw support
      net: rnpgbe: Add register_netdev

Dr. David Alan Gilbert (1):
      wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params

Dust Li (1):
      smc: rename smc_find_ism_store_rc to reflect broader usage

Emil Tantilov (1):
      idpf: convert vport state to bitmap

Emmanuel Grumbach (6):
      wifi: iwlwifi: mld: support get/set_antenna
      wifi: iwlwifi: be more chatty when we fail to find a wifi7 device
      wifi: iwlwifi: stop checking the firmware's error pointer
      wifi: iwlwifi: disable EHT if the device doesn't allow it
      wifi: iwlwifi: mld: check for NULL pointer after kmalloc
      wifi: cfg80211: use a C99 initializer in wiphy_register

Eric Biggers (2):
      tcp: Convert tcp-md5 to use MD5 library instead of crypto_ahash
      tcp: Remove unnecessary null check in tcp_inbound_md5_hash()

Eric Dumazet (51):
      tcp: better handle TCP_TX_DELAY on established flows
      net: add SK_WMEM_ALLOC_BIAS constant
      net: control skb->ooo_okay from skb_set_owner_w()
      net: add /proc/sys/net/core/txq_reselection_ms control
      net: allow busy connected flows to switch tx queues
      net: remove obsolete WARN_ON(refcount_read(&sk->sk_refcnt) == 1)
      selftests/net: packetdrill: unflake tcp_user_timeout_user-timeout-probe.pkt
      net: add add indirect call wrapper in skb_release_head_state()
      net/sched: act_mirred: add loop detection
      Revert "net/sched: Fix mirred deadlock on device recursion"
      net: sched: claim one cache line in Qdisc
      net: dev_queue_xmit() llist adoption
      net: add a fast path in __netif_schedule()
      net: shrink napi_skb_cache_{put,get}() and napi_skb_cache_get_bulk()
      net: avoid extra access to sk->sk_wmem_alloc in sock_wfree()
      tcp: remove one ktime_get() from recvmsg() fast path
      net: optimize enqueue_to_backlog() for the fast path
      net: rps: softnet_data reorg to make enqueue_to_backlog() fast
      net: mark deliver_skb() as unlikely and not inlined
      tcp: add net.ipv4.tcp_comp_sack_rtt_percent
      net: add prefetch() in skb_defer_free_flush()
      net: allow skb_release_head_state() to be called multiple times
      net: fix napi_consume_skb() with alien skbs
      net: increase skb_defer_max default to 128
      net: clear skb->sk in skb_release_head_state()
      tcp: gro: inline tcp_gro_pull_header()
      tcp: reduce tcp_comp_sack_slack_ns default value to 10 usec
      net: add a new @alloc parameter to napi_skb_cache_get()
      net: __alloc_skb() cleanup
      net: use napi_skb_cache even in process context
      tcp: tcp_moderate_rcvbuf is only used in rx path
      tcp: add net.ipv4.tcp_rcvbuf_low_rtt
      net: optimize eth_type_trans() vs CONFIG_STACKPROTECTOR_STRONG=y
      net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
      net: init shinfo->gso_segs from qdisc_pkt_len_init()
      net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in qdisc_pkt_len_init()
      net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
      net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
      net_sched: cake: use qdisc_pkt_segs()
      net_sched: add Qdisc_read_mostly and Qdisc_write groups
      net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
      net_sched: sch_fq: prefetch one skb ahead in dequeue()
      net: prefech skb->priority in __dev_xmit_skb()
      net: annotate a data-race in __dev_xmit_skb()
      net_sched: add tcf_kfree_skb_list() helper
      net_sched: add qdisc_dequeue_drop() helper
      net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel
      tcp: rename icsk_timeout() to tcp_timeout_expires()
      net: move sk_dst_pending_confirm and sk_pacing_status to sock_read_tx group
      tcp: introduce icsk->icsk_keepalive_timer
      tcp: remove icsk->icsk_retransmit_timer

Erni Sri Satya Vennela (3):
      net: mana: Fix incorrect speed reported by debugfs
      net: mana: Move hardware counter stats from per-port to per-VF context
      net: mana: Add standard counter rx_missed_errors

FUJITA Tomonori (1):
      net: phy: qt2025: Wait until PHY becomes ready

Fedor Pchelkin (11):
      wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
      wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
      wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
      wifi: rtw89: refine rtw89_core_tx_wait_complete()
      wifi: rtw89: implement C2H TX report handler
      wifi: rtw89: usb: anchor TX URBs
      wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
      wifi: rtw89: provide TX reports for management frames
      wifi: rtw89: process TX wait skbs for USB via C2H handler
      Revert "wifi: mt76: mt792x: improve monitor interface handling"
      wifi: mt76: adjust BSS conf pointer handling

Felix Fietkau (3):
      wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()
      wifi: mt76: fix license/copyright of util.h
      wifi: mt76: relicense to BSD-3-Clause-Clear

Felix Maurer (1):
      netlink: specs: rt-link: Add attributes for hsr

Fernando Fernandez Mancera (7):
      netfilter: nf_tables: use C99 struct initializer for nft_set_iter
      ipv6: clear RA flags when adding a static route
      selftests: fib_tests: add fib6 from ra to static test
      netfilter: nf_conncount: rework API to use sk_buff directly
      netfilter: nf_conncount: make nf_conncount_gc_list() to disable BH
      netfilter: nft_connlimit: update the count if add was skipped
      netfilter: nft_connlimit: add support to object update operation

Florian Fainelli (1):
      net: bcmasp: Add support for PHY-based Wake-on-LAN

Florian Fuchs (1):
      net: ps3_gelic_net: Use napi_alloc_skb() and napi_gro_receive()

Florian Westphal (2):
      net: Kconfig: discourage drop_monitor enablement
      netfilter: conntrack: disable 0 value for conntrack_max setting

Frank Li (1):
      dt-bindings: net: dsa: nxp,sja1105: Add optional clock

Gal Pressman (8):
      net/mlx5: Refactor EEPROM query error handling to return status separately
      tools: ynl: cli: Add --list-attrs option to show operation attributes
      tools: ynl: cli: Parse nested attributes in --list-attrs output
      tools: ynl: cli: Display enum values in --list-attrs output
      net/mlx5e: Use u64 instead of __u64 in ieee_setmaxrate
      net/mlx5e: Rename upper_limit_mbps to upper_limit_100mbps
      net/mlx5e: Use U8_MAX instead of hard coded magic number
      net/mlx5e: Use standard unit definitions for bandwidth conversion

Gautam R A (1):
      bnxt_en: Enhance log message in bnxt_get_module_status()

Geert Uytterhoeven (6):
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Invert global vs. channel teardown
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
      can: rcar_canfd: Invert CAN clock and close_candev() order
      can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      can: rcar_canfd: Add suspend/resume support

Gongwei Li (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3533 for RTL8821CE

Gregor Herburger (5):
      can: mcp251xfd: utilize gather_write function for all non-CRC writes
      can: mcp251xfd: add workaround for errata 5
      can: mcp251xfd: only configure PIN1 when rx_int is set
      can: mcp251xfd: add gpio functionality
      dt-bindings: can: mcp251xfd: add gpio-controller property

Grzegorz Nitka (1):
      ice: Allow 100M speed for E825C SGMII device

Gustavo A. R. Silva (3):
      net: spacemit: Avoid -Wflex-array-member-not-at-end warnings
      chtls: Avoid -Wflex-array-member-not-at-end warning
      net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning

Gustavo Luiz Duarte (4):
      netconsole: Simplify send_fragmented_body()
      netconsole: Split userdata and sysdata
      netconsole: Dynamic allocation of userdata buffer
      netconsole: Increase MAX_USERDATA_ITEMS

Haiyang Zhang (1):
      net: mana: Support HW link state events

Halil Pasic (2):
      net/smc: make wr buffer count configurable
      net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully

Hangbin Liu (10):
      netdevsim: add ipsec hw_features
      net: add a common function to compute features for upper devices
      bonding: use common function to compute the features
      team: use common function to compute the features
      net: bridge: use common function to compute the features
      tools: ynl: Add MAC address parsing support
      netlink: specs: support ipv4-or-v6 for dual-stack fields
      netlink: specs: add big-endian byte-order for u32 IPv4 addresses
      tools: ynl: add YNL test framework
      selftests: bonding: add delay before each xvlan_over_bond connectivity check

Hans de Goede (1):
      wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet

Harshit Mogalapalli (1):
      Octeontx2-af: Fix pci_alloc_irq_vectors() return value check

Harshita V Rajput (1):
      cxgb4: flower: add support for fragmentation

Heiko Carstens (2):
      dibs: Remove KMSG_COMPONENT macro
      net: Remove KMSG_COMPONENT macro

Heiko Stuebner (4):
      dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
      dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
      dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506
      MAINTAINERS: add dwmac-rk glue driver to the main Rockchip entry

Heiner Kallweit (25):
      net: mdio: use macro module_driver to avoid boilerplate code
      net: bcmgenet: remove unused platform code
      r8169: reconfigure rx unconditionally before chip reset when resuming
      net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register
      net: stmmac: mdio: fix incorrect phy address check
      net: phy: add iterator mdiobus_for_each_phy
      net: fec: use new iterator mdiobus_for_each_phy
      net: davinci_mdio: use new iterator mdiobus_for_each_phy
      net: phy: use new iterator mdiobus_for_each_phy in mdiobus_prevent_c45_scan
      net: phy: make phy_device members pause and asym_pause bitfield bits
      net: phy: fixed_phy: add helper fixed_phy_register_100fd
      net: fec: register a fixed phy using fixed_phy_register_100fd if needed
      m68k: coldfire: remove creating a fixed phy
      net: b44: register a fixed phy using fixed_phy_register_100fd if needed
      MIPS: BCM47XX: remove creating a fixed phy
      net: phy: fixed_phy: remove fixed_phy_add
      net: phy: fixed_phy: shrink size of struct fixed_phy_status
      net: dsa: loop: use new helper fixed_phy_register_100fd to simplify the code
      net: phy: fixed_phy: initialize the link status as up
      net: dsa: remove definition of struct dsa_switch_driver
      net: phy: fixed_phy: remove setting supported/advertised modes from fixed_phy_register
      r8169: bail out from probe if fiber mode is detected on RTL8127AF
      net: phy: fixed_phy: fix missing initialization of fixed phy link
      net: phy: fixed_phy: remove not needed initialization of phy_device members
      r8169: improve MAC EEE handling

Hiroaki Yamamoto (1):
      wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list

Horatiu Vultur (4):
      net: phy: micrel: Add support for non PTP SKUs for lan8814
      phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X
      phy: mscc: Fix PTP for VSC8574 and VSC8572
      net: phy: micrel: lan8814: Enable in-band auto-negotiation

Howard Hsu (1):
      wifi: mt76: mt7996: fix implicit beamforming support for mt7992

Ido Schimmel (3):
      ipv4: icmp: Add RFC 5837 support
      ipv6: icmp: Add RFC 5837 support
      selftests: traceroute: Add ICMP extensions tests

Inochi Amaoto (3):
      dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
      net: phy: Add helper for fixing RGMII PHY mode based on internal mac delay
      net: stmmac: dwmac-sophgo: Add phy interface filter

Issam Hamdi (1):
      net: phy: realtek: Add RTL8224 cable testing support

Ivan Vecera (8):
      dpll: add phase-adjust-gran pin attribute
      dpll: zl3073x: Specify phase adjustment granularity for pins
      dpll: zl3073x: Store raw register values instead of parsed state
      dpll: zl3073x: Split ref, out, and synth logic from core
      dpll: zl3073x: Cache reference monitor status
      dpll: zl3073x: Cache all reference properties in zl3073x_ref
      dpll: zl3073x: Cache all output properties in zl3073x_out
      dpll: zl3073x: Remove unused dev wrappers

Jack Kao (1):
      wifi: mt76: mt7925: cqm rssi low/high event notify

Jacky Chou (1):
      dt-bindings: net: aspeed: add AST2700 MDIO compatible

Jakub Kicinski (176):
      Merge branch 'net-airoha-add-some-new-ethtool-bits'
      Merge branch 'net-deal-with-sticky-tx-queues'
      Merge branch 'preserve-pse-pd692x0-configuration-across-reboots'
      Merge branch 'net-airoha-npu-introduce-support-for-airoha-7583-npu'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-more-cleanups'
      Merge branch 'add-driver-support-for-eswin-eic7700-soc-ethernet-controller'
      Merge branch 'net-optimize-tx-throughput-and-efficiency'
      Merge branch 'net-macb-various-cleanups'
      Merge branch 'net-avoid-ehash-lookup-races'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-dsa-lantiq_gswip-clean-up-and-improve-vlan-handling'
      Merge branch 'net-stmmac-phylink-pcs-conversion'
      Merge branch 'convert-net-drivers-to-ndo_hwtstamp-api-part-1'
      Merge branch 'intel-wired-lan-driver-updates-2025-10-15-ice-iavf-ixgbe-i40e-e1000e'
      Merge tag 'linux-can-next-for-6.19-20251017' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'net-common-feature-compute-for-upper-interface'
      Merge branch 'net-dsa-yt921x-add-support-for-motorcomm-yt921x'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-dsa-lantiq_gswip-use-regmap-for-register-access'
      Merge branch 'neighbour-convert-rtm_getneightbl-and-rtm_setneightbl-to-rcu'
      Merge branch 'net-add-phylink-managed-wol-and-convert-stmmac'
      Merge branch 'net-stmmac-pcs-support-part-2'
      Merge branch 'net-ravb-soc-specific-configuration'
      Merge branch 'dwmac-support-for-rockchip-rk3506'
      Merge branch 'phy-mscc-fix-ptp-for-vsc8574-and-vsc8572'
      Merge tag 'batadv-next-pullrequest-20251024' of https://git.open-mesh.org/linux-merge
      Merge branch 'convert-net-drivers-to-ndo_hwtstamp-api-part-2'
      Merge branch 'sctp-avoid-redundant-initialisation-in-sctp_accept-and-sctp_do_peeloff'
      tools: ynl: fix indent issues in the main Python lib
      tools: ynl: rework the string representation of NlError
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-stmmac-hwif-c-cleanups'
      Merge branch 'icmp-add-rfc-5837-support'
      Merge branch 'net-enetc-add-i-mx94-enetc-support'
      Merge branch 'net-phy-add-iterator-mdiobus_for_each_phy'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      selftests: drv-net: replace the nsim ring test with a drv-net one
      Merge tag 'wireless-next-2025-10-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'nf-next-25-10-30' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'convert-mlx5e-and-ipoib-to-ndo_hwtstamp_get-set'
      Merge branch 'net-phy-microchip_t1s-add-support-for-lan867x-rev-d0-phy'
      Merge branch 'net-pse-pd-add-tps23881b-support'
      Merge branch 'dpll-add-support-for-phase-adjustment-granularity'
      Merge branch 'mpls-remove-rtnl-dependency'
      Merge branch 'add-support-to-do-threaded-napi-busy-poll'
      Merge branch 'ethtool-introduce-phy-mse-diagnostics-uapi-and-drivers'
      Merge branch 'net-stmmac-multi-interface-stmmac'
      Merge branch 'net-mlx5e-reduce-interface-downtime-on-configuration-change'
      Merge branch 'mptcp-pm-in-kernel-fullmesh-endp-nb-bind-cases'
      Merge branch 'convert-drivers-to-use-ndo_hwtstamp-callbacks-part-3'
      Merge branch 'add-driver-for-1gbe-network-chips-from-mucse'
      Merge branch 'net-altera-tse-cleanup-init-sequence'
      Merge branch 'net-phy-remove-fixed_phy_add-and-first-its-users'
      Merge branch 'net-introduce-struct-sockaddr_unsized'
      Merge tag 'wireless-next-2025-11-05' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-stmmac-socfpga-add-agilex5-platform-support-and-enhancements'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-dsa-lantiq_gswip-add-support-for-maxlinear-gsw1xx-switch-family'
      Merge branch 'net-renesas-cleanup-usage-of-gptp-flags'
      netlink: specs: netdev add missing stats to qstat-get
      Merge branch 'tcp-clean-up-syn-ack-rto-code-and-apply-max-rto'
      Merge branch 'net-phy-add-open-alliance-tc14-10base-t1s-phy-cable-diagnostic-support'
      psp: report basic stats from the core
      psp: add stats from psp spec to driver facing api
      net/mlx5e: Add PSP stats support for Rx/Tx flows
      Merge branch 'psp-track-stats-from-core-and-provide-a-driver-stats-api'
      Merge branch 'net-use-skb_attempt_defer_free-in-napi_consume_skb'
      Merge branch 'net-stmmac-lpc18xx-and-sti-convert-to-set_phy_intf_sel'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-dsa-b53-add-support-for-bcm5389-97-98-and-bcm63xx-arl-formats'
      Merge branch 'net-stmmac-ingenic-convert-to-set_phy_intf_sel'
      Merge branch 'gve-improve-rx-buffer-length-management'
      tools: ynltool: create skeleton for the C command
      tools: ynltool: add page-pool stats
      tools: ynltool: add qstats support
      tools: ynltool: add traffic distribution balance
      Merge branch 'net-stmmac-convert-meson8b-to-use-stmmac_get_phy_intf_sel'
      Merge branch 'selftests-vsock-refactor-and-improve-vmtest-infrastructure'
      Merge tag 'wireless-next-2025-11-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      tools: ynltool: correct install in Makefile
      Merge branch 'net-stmmac-convert-glue-drivers-to-use-stmmac_get_phy_intf_sel'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-phy-mscc-add-support-for-phy-led-control'
      ipv6: clean up routes when manually removing address with a lifetime
      selftests: drv-net: xdp: make the XDP qstats tests less flaky
      Merge branch 'net-stmmac-rk-use-phy_intf_sel_x'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'net-mlx-migrate-to-new-get_rx_ring_count-ethtool-api'
      tools: ynltool: remove -lmnl from link flags
      Merge branch 'selftests-mptcp-counter-cache-stats-before-timeout'
      Merge branch 'convert-drivers-to-use-ndo_hwtstamp-callbacks-part-4'
      Merge branch 'net-stmmac-clean-up-plat_dat-allocation-initialisation'
      Merge branch 'net-mana-refactor-gf-stats-handling-and-add-rx_missed_errors-counter'
      Merge branch 'net-stmmac-dwmac-sophgo-add-phy-interface-filter'
      Merge branch 's390-qeth-improve-handling-of-osa-rcs'
      Merge branch 'dpll-zl3073x-refactor-state-management'
      Merge tag 'ipsec-next-2025-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'net-expand-napi_skb_cache-use'
      Merge branch 'net-mlx5-misc-changes-2025-11-17'
      Merge branch 'af_unix-gc-cleanup-and-optimisation'
      Merge branch 'net-stmmac-sanitise-stmmac_is_jumbo_frm'
      Merge branch 'net-mana-enforce-tx-sge-limit-and-fix-error-cleanup'
      Merge branch 'disable-clkout-on-rtl8211f-d-i-vd-cg'
      Merge branch 'net-adjust-conservative-values-around-napi'
      Merge branch 'net-mlx5-move-notifiers-outside-the-devlink-lock'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-mdio-improve-reset-handling-of-mdio-devices'
      Merge branch 'tcp-tcp_rcvbuf_grow-changes'
      Merge branch 'net-stmmac-pass-struct-device-to-init-exit'
      Merge branch 'net-stmmac-simplify-axi_blen-handling'
      Merge branch 'net-phy-adin1100-fix-powerdown-mode-setting'
      selftests: net: py: coding style improvements
      selftests: net: py: extract the case generation logic
      selftests: net: py: add test variants
      selftests: drv-net: xdp: use variants for qstat tests
      selftests: net: relocate gro and toeplitz tests to drivers/net
      selftests: net: py: support ksft ready without wait
      selftests: net: py: read ip link info about remote dev
      netdevsim: pass packets thru GRO on Rx
      selftests: drv-net: add a Python version of the GRO test
      selftests: drv-net: hw: convert the Toeplitz test to Python
      netdevsim: add loopback support
      selftests: net: remove old setup_* scripts
      Merge branch 'selftests-drv-net-convert-gro-and-toeplitz-tests-to-work-for-drivers-in-nipa'
      Merge branch 'net-add-1600gbps-1-6t-link-mode-support'
      Merge branch 'net-fec-do-some-cleanup-for-the-driver'
      Merge branch 'netconsole-allow-userdata-buffer-to-grow-dynamically'
      Merge branch 'devlink-net-mlx5-implement-swp_l4_csum_mode-via-devlink-params'
      Merge branch 'net-stmmac-qcon-ethqos-rgmii-accessor-cleanups'
      selftests: hw-net: auto-disable building the iouring C code
      selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz configured
      selftests: hw-net: toeplitz: read the RSS key directly from C
      selftests: hw-net: toeplitz: read indirection table from the device
      selftests: hw-net: toeplitz: give the test up to 4 seconds
      Merge branch 'selftests-hw-net-toeplitz-read-config-from-the-nic-directly'
      selftests: af_unix: don't use SKIP for expected failures
      Merge branch 'mptcp-memcg-accounting-for-passive-sockets-backlog-processing'
      Merge branch 'improvements-over-dsa-conduit-ethtool-ops'
      Merge branch 'net-enetc-add-port-mdio-support-for-both-i-mx94-and-i-mx95'
      Merge branch 'ptp-ocp-a-fix-and-refactoring'
      Merge branch 'tools-ynl-gen-regeneration-comment-function-prefix'
      Merge branch 'tcp-provide-better-locality-for-retransmit-timer'
      Merge branch 'selftest-af_unix-misc-updates'
      Merge branch 'add-hwtstamp_get-callback-to-phy-drivers'
      Merge branch 'unify-platform-suspend-resume-routines-for-pci-dwmac-glue'
      Merge branch 'net-intel-migrate-to-get_rx_ring_count-ethtool-callback'
      Merge branch 'net-hibmcge-add-support-for-tracepoint-and-pagepool-on-hibmcge-driver'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      eth: bnxt: make use of napi_consume_skb()
      net: restore napi_consume_skb()'s NULL-handling
      Merge branch 'net-dsa-yt921x-fix-parsing-mib-attributes'
      Merge branch 'intel-wired-lan-driver-updates-2025-11-25-ice-idpf-iavf-ixgbe-ixgbevf-e1000e'
      Merge branch 'bnxt_en-updates-for-net-next'
      Merge tag 'wireless-next-2025-11-27' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'tools-ynl-add-schema-checking'
      Merge branch 'net-broadcom-migrate-to-get_rx_ring_count-ethtool-callback'
      Merge branch 'introduce-the-dsa_xmit_port_mask-tagging-protocol-helper'
      Merge tag 'nf-next-25-11-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'linux-can-next-for-6.19-20251129' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'net-freescale-migrate-to-get_rx_ring_count-ethtool-callback'
      selftests: net: py: handle interrupt during cleanup
      selftests: net: add a hint about MACAddressPolicy=persistent
      Merge branch 'amd-xgbe-schedule-napi-on-rbu-event'
      Merge branch 'net-dsa-b53-fix-arl-accesses-for-bcm5325-65-and-allow-vid-0'
      Revert "r8169: add DASH support for RTL8127AP"
      Merge branch 'net-mlx5e-enhance-dcbnl-get-set-maxrate-code'
      Merge branch 'add-sqi-and-sqi-support-for-oatc14-10base-t1s-phys-and-microchip-t1s-driver'
      Merge branch 'net-dsa-yt921x-add-stp-mst-support'
      Merge branch 'dsa-simple-hsr-offload'
      Merge tag 'for-net-next-2025-12-01' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'selftests-drv-net-fix-issues-in-devlink_rate_tc_bw-py'
      Merge tag 'wireguard-6.19-rc1-for-jakub' of https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jakub Sitnicki (16):
      net: Helper to move packet data and metadata after skb_push/pull
      net: Preserve metadata on pskb_expand_head
      bpf: Unclone skb head on bpf_dynptr_write to skb metadata
      vlan: Make vlan_remove_tag return nothing
      bpf: Make bpf_skb_vlan_pop helper metadata-safe
      bpf: Make bpf_skb_vlan_push helper metadata-safe
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Make bpf_skb_change_proto helper metadata-safe
      bpf: Make bpf_skb_change_head helper metadata-safe
      selftests/bpf: Verify skb metadata in BPF instead of userspace
      selftests/bpf: Dump skb metadata on verification failure
      selftests/bpf: Expect unclone to preserve skb metadata
      selftests/bpf: Cover skb metadata access after vlan push/pop helper
      selftests/bpf: Cover skb metadata access after bpf_skb_adjust_room
      selftests/bpf: Cover skb metadata access after change_head/tail helper
      selftests/bpf: Cover skb metadata access after bpf_skb_change_proto

Jan Vaclav (2):
      net/hsr: add protocol version to fill_info output
      net/hsr: add interlink to fill_info output

Jason Xing (7):
      xsk: do not enable/disable irq when grabbing/releasing xsk_tx_list_lock
      xsk: use a smaller new lock for shared pool case
      xsk: add indirect call for xsk_destruct_skb
      net: increase default NAPI_SKB_CACHE_SIZE to 128
      net: increase default NAPI_SKB_CACHE_BULK to 32
      net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
      net: prefetch the next skb in napi_skb_cache_get()

Javen Xu (2):
      r8169: add support for RTL9151A
      r8169: add DASH support for RTL8127AP

Javier Nieto (2):
      Bluetooth: hci_h5: avoid sending two SYNC messages
      Bluetooth: hci_h5: implement CRC data integrity

Jay Vosburgh (1):
      i40e: avoid redundant VF link state updates

Jeff Johnson (3):
      wifi: ath11k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath12k: Remove struct wmi_bcn_send_from_host_cmd
      wifi: ath11k: Correctly use "ab" macro parameter

Jeremy Kerr (1):
      net: mctp: test: move TX packetqueue from dst to dev

Jesse Brandeburg (5):
      net: docs: add missing features that can have stats
      ice: implement ethtool standard stats
      ice: add tracking of good transmit timestamps
      ice: implement transmit hardware timestamp statistics
      ice: refactor to use helpers

Jianbo Liu (2):
      xfrm: Refactor xfrm_input lock to reduce contention with RSS
      xfrm: Skip redundant replay recheck for the hardware offload path

Jianhui Zhao (1):
      net: phy: realtek: add interrupt support for RTL8221B

Jiapeng Chong (1):
      net: macb: Remove duplicate linux/inetdevice.h header

Jiawen Wu (11):
      net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
      net: txgbe: optimize the flow to setup PHY for AML devices
      net: txgbe: rename txgbe_get_phy_link()
      net: txgbe: support RX desc merge mode
      net: txgbe: support TX head write-back mode
      net: txgbe: support RSC offload
      net: txgbe: support CR modules for AML devices
      net: txgbe: rename the SFP related
      net: txgbe: improve functions of AML 40G devices
      net: txgbe: delay to identify modules in .ndo_open
      net: txgbe: support getting module EEPROM by page

Jijie Shao (3):
      net: hibmcge: support pci_driver.shutdown()
      net: hibmcge: reduce packet drop under stress testing
      net: hibmcge: add support for pagepool on rx

Johannes Berg (38):
      wifi: mac80211: reset CRC valid after CSA
      wifi: iwlwifi: mvm: move rate conversions to utils.c
      wifi: iwlwifi: cfg: add new device names
      wifi: iwlwifi: tests: check listed PCI IDs have configs
      wifi: iwlwifi: fix remaining kernel-doc warnings
      wifi: iwlwifi: mld: update to new sniffer API
      wifi: iwlwifi: mld: include raw PHY notification in radiotap
      wifi: iwlwifi: fix build when mvm/mld not configured
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: mvm/mld: report non-HT frames as 20 MHz
      wifi: iwlwifi: mld: use FW_CHECK on bad ROC notification
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: cfg: fix a few device names
      Merge tag 'iwlwifi-next-2025-10-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-next-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next
      wifi: ieee80211: split mesh definitions out
      wifi: ieee80211: split HT definitions out
      wifi: ieee80211: split VHT definitions out
      wifi: ieee80211: split HE definitions out
      wifi: ieee80211: split EHT definitions out
      wifi: ieee80211: split S1G definitions out
      wifi: ieee80211: split P2P definitions out
      wifi: ieee80211: split NAN definitions out
      wifi: cfg80211: fix EHT typo
      wifi: mac80211: fix EHT typo
      wifi: mac80211: make link iteration safe for 'break'
      wifi: mac80211: remove chanctx to link back-references
      wifi: mac80211: simplify ieee80211_recalc_chanctx_min_def() API
      wifi: mac80211: add and use chanctx usage iteration
      wifi: mac80211: remove "disabling VHT" message
      wifi: mac80211: pass frame type to element parsing
      wifi: mac80211: remove unnecessary vlan NULL check
      Merge tag 'ath-next-20251111' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2025-11-21-v2' of https://github.com/pkshih/rtw
      wifi: mac80211: fix channel switching code
      wifi: cfg80211: use cfg80211_leave() in iftype change
      wifi: cfg80211: stop radar detection in cfg80211_leave()
      Merge tag 'mt76-next-2025-11-24' of https://github.com/nbd168/wireless

Jonas Gorski (16):
      net: dsa: b53: implement port isolation support
      net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
      net: dsa: b53: move reading ARL entries into their own function
      net: dsa: b53: move writing ARL entries into their own functions
      net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
      net: dsa: b53: split reading search entry into their own functions
      net: dsa: b53: move ARL entry functions into ops struct
      net: dsa: b53: add support for 5389/5397/5398 ARL entry format
      net: dsa: b53: add support for bcm63xx ARL entry format
      net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
      net: dsa: b53: fix extracting VID from entry for BCM5325/65
      net: dsa: b53: use same ARL search result offset for BCM5325/65
      net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
      net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
      net: dsa: b53: fix BCM5325/65 ARL entry VIDs
      net: dsa: b53: allow VID 0 for BCM5325/65

Jui-Peng Tsai (1):
      wifi: rtw89: improve scan time on 6 GHz band

Julia Lawall (1):
      strparser: fix typo in comment

Kalesh AP (1):
      bnxt_en: Remove the redundant BNXT_EN_FLAG_MSIX_REQUESTED flag

Kang Yang (1):
      wifi: ath10k: move recovery check logic into a new work

Kees Cook (8):
      net: Add struct sockaddr_unsized for sockaddr of unknown length
      net: Convert proto_ops bind() callbacks to use sockaddr_unsized
      net: Convert proto_ops connect() callbacks to use sockaddr_unsized
      net: Remove struct sockaddr from net.h
      net: Convert proto callbacks from sockaddr to sockaddr_unsized
      bpf: Convert cgroup sockaddr filters to use sockaddr_unsized consistently
      bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unsized
      net: Convert struct sockaddr to fixed-size "sa_data[14]"

Kory Maincent (Dent Project) (3):
      net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      net: pse-pd: pd692x0: Preserve PSE configuration across reboots

Kriish Sharma (2):
      hdlc_ppp: fix potential null pointer in ppp_cp_event logging
      dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c

Krzysztof Kozlowski (1):
      Bluetooth: MAINTAINERS: Add Bartosz Golaszewski as Qualcomm hci_qca maintainer

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX performance
      wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()

Kuniyuki Iwashima (51):
      tcp: Save lock_sock() for memcg in inet_csk_accept().
      net: Allow opt-out from global protocol memory accounting.
      net: Introduce net.core.bypass_prot_mem sysctl.
      bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
      bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
      selftests/bpf: Add test for sk->sk_bypass_prot_mem.
      ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.
      neighbour: Use RCU list helpers for neigh_parms.list writers.
      neighbour: Annotate access to neigh_parms fields.
      neighbour: Convert RTM_GETNEIGHTBL to RCU.
      neighbour: Convert RTM_SETNEIGHTBL to RCU.
      neighbour: Convert rwlock of struct neigh_table to spinlock.
      sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
      sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
      sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
      net: Add sk_clone().
      sctp: Use sk_clone() in sctp_accept().
      sctp: Remove sctp_pf.create_accept_sk().
      sctp: Use sctp_clone_sock() in sctp_do_peeloff().
      sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
      net: sched: Don't use WARN_ON_ONCE() for -ENOMEM in tcf_classify().
      mpls: Return early in mpls_label_ok().
      mpls: Hold dev refcnt for mpls_nh.
      mpls: Unify return paths in mpls_dev_notify().
      ipv6: Add in6_dev_rcu().
      mpls: Use in6_dev_rcu() and dev_net_rcu() in mpls_forward() and mpls_xmit().
      mpls: Add mpls_dev_rcu().
      mpls: Pass net to mpls_dev_get().
      mpls: Add mpls_route_input().
      mpls: Use mpls_route_input() where appropriate.
      mpls: Convert mpls_dump_routes() to RCU.
      mpls: Convert RTM_GETNETCONF to RCU.
      mpls: Protect net->mpls.platform_label with a per-netns mutex.
      mpls: Drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.
      tcp: Call tcp_syn_ack_timeout() directly.
      tcp: Remove timeout arg from reqsk_queue_hash_req().
      tcp: Remove redundant init for req->num_timeout.
      tcp: Remove timeout arg from reqsk_timeout().
      tcp: Apply max RTO to non-TFO SYN+ACK.
      selftest: packetdrill: Add max RTO test for SYN+ACK.
      sctp: Don't inherit do_auto_asconf in sctp_clone_sock().
      tcp: Don't reinitialise tw->tw_transparent in tcp_time_wait().
      af_unix: Count cyclic SCC.
      af_unix: Simplify GC state.
      af_unix: Don't trigger GC from close() if unnecessary.
      af_unix: Don't call wait_for_unix_gc() on every sendmsg().
      af_unix: Refine wait_for_unix_gc().
      af_unix: Remove unix_tot_inflight.
      af_unix: Consolidate unix_schedule_gc() and wait_for_unix_gc().
      selftest: af_unix: Create its own .gitignore.
      selftest: af_unix: Extend recv() timeout in so_peek_off.c.

Lachlan Hodges (5):
      wifi: mac80211: get probe response chan via ieee80211_get_channel_khz
      wifi: cfg80211: default S1G chandef width to 1MHz
      wifi: cfg80211: include s1g_primary_2mhz when sending chandef
      wifi: cfg80211: include s1g_primary_2mhz when comparing chandefs
      wifi: mac80211: allow sharing identical chanctx for S1G interfaces

Lad Prabhakar (7):
      net: ravb: Make DBAT entry count configurable per-SoC
      net: ravb: Allocate correct number of queues based on SoC support
      dt-bindings: net: phy: vsc8531: Convert to DT schema
      net: phy: mscc: Simplify LED mode update using phy_modify()
      net: phy: mscc: Consolidate probe functions into a common helper
      net: phy: mscc: Add support for PHY LED control
      net: phy: mscc: Handle devm_phy_package_join() failure in vsc85xx_probe_common()

Li Qiang (1):
      wifi: iwlwifi: mld: add null check for kzalloc() in iwl_mld_send_proto_offload()

Liming Wu (1):
      virtio_net: enhance wake/stop tx queue statistics accounting

Linu Cherian (4):
      octeontx2-af: Add cn20k NPA block contexts
      octeontx2-af: Extend debugfs support for cn20k NPA
      octeontx2-af: Skip NDC operations for cn20k
      octeontx2-pf: Initialize cn20k specific aura and pool contexts

Loic Poulain (1):
      wifi: ath10k: Support for FTM TLV test commands

Long Li (1):
      net: mana: Handle hardware recovery events when probing the device

Lorenzo Bianconi (38):
      net: airoha: Add missing stats to ethtool_eth_mac_stats
      net: airoha: Add get_link ethtool callback
      dt-bindings: net: airoha: npu: Add AN7583 support
      net: airoha: npu: Add airoha_npu_soc_data struct
      net: airoha: npu: Add 7583 SoC support
      dt-bindings: net: airoha: Add AN7583 support
      net: airoha: ppe: Dynamically allocate foe_check_time array in airoha_ppe struct
      net: airoha: Add airoha_ppe_get_num_stats_entries() and airoha_ppe_get_num_total_stats_entries()
      net: airoha: Add airoha_eth_soc_data struct
      net: airoha: Generalize airoha_ppe2_is_enabled routine
      net: airoha: ppe: Move PPE memory info in airoha_eth_soc_data struct
      net: airoha: ppe: Remove airoha_ppe_is_enabled() where not necessary
      net: airoha: ppe: Configure SRAM PPE entries via the cpu
      net: airoha: ppe: Flush PPE SRAM table during PPE setup
      net: airoha: Select default ppe cpu port in airoha_dev_init()
      net: airoha: Refactor src port configuration in airhoha_set_gdm2_loopback
      net: airoha: ppe: Do not use magic numbers in airoha_ppe_foe_get_entry_locked()
      net: airoha: Add AN7583 SoC support
      net: airoha: Remove code duplication in airoha_regs.h
      net: airoha: Add the capability to consume out-of-order DMA tx descriptors
      wifi: mt76: mt7996: Remove unnecessary link_id checks in mt7996_tx
      wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks
      wifi: mt76: mt7996: Remove useless check in mt7996_msdu_page_get_from_cache()
      wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
      wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
      wifi: mt76: Add the capability to set TX token start ID
      wifi: mt76: Introduce the NPU generic layer
      wifi: mt76: mt7996: Add NPU offload support to MT7996 driver
      wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
      wifi: mt76: mt7996: move mt7996_update_beacons under mt76 mutex
      wifi: mt76: Move mt76_abort_scan out of mt76_reset_device()
      wifi: mt76: mt7996: skip deflink accounting for offchannel links
      wifi: mt76: mt7996: skip ieee80211_iter_keys() on scanning link remove
      wifi: mt76: mt7996: Add missing locking in mt7996_mac_sta_rc_work()
      netfilter: flowtable: Add IPIP rx sw acceleration
      netfilter: flowtable: Add IPIP tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest
      selftests: netfilter: nft_flowtable.sh: Add the capability to send IPv6 TCP traffic

Luiz Augusto von Dentz (8):
      Bluetooth: HCI: Add initial support for PAST
      Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
      Bluetooth: ISO: Add support to bind to trigger PAST
      Bluetooth: HCI: Always use the identity address when initializing a connection
      Bluetooth: ISO: Attempt to resolve broadcast address
      Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
      Bluetooth: ISO: Fix not updating BIS sender source address
      Bluetooth: HCI: Add support for LL Extended Feature Set

Manish Dharanenthiran (2):
      wifi: ath12k: Make firmware stats reset caller-driven
      wifi: ath12k: Fix timeout error during beacon stats retrieval

Marc Kleine-Budde (16):
      can: m_can: add support for optional reset
      Merge patch series "can: m_can: Add am62 wakeup support"
      can: m_can: m_can_init_ram(): make static
      can: m_can: hrtimer_callback(): rename to m_can_polling_timer()
      net: m_can: convert dev_{dbg,info,err} -> netdev_{dbg,info,err}
      can: m_can: m_can_interrupt_enable(): use m_can_write() instead of open coding it
      can: m_can: m_can_class_register(): remove error message in case devm_kzalloc() fails
      can: m_can: m_can_tx_submit(): remove unneeded sanity checks
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
      Merge patch series "can: m_can: various cleanups"
      Merge patch series "convert can drivers to use ndo_hwtstamp callbacks"
      can: mcp251xfd: move chip sleep mode into runtime pm
      Merge patch series "can: mcp251xfd: add gpio functionality"
      Merge patch series "can: netlink: add CAN XL support"
      Merge patch series "Add R-Car CAN-FD suspend/resume support"
      Merge patch series "MAINTAINERS: Add myself as m_can maintainer"

Marco Crivellari (9):
      isdn: kcapi: add WQ_PERCPU to alloc_workqueue users
      wifi: qtnfmac: add WQ_PERCPU to alloc_workqueue users
      wifi: wfx: add WQ_PERCPU to alloc_workqueue users
      wifi: cw1200: add WQ_PERCPU to alloc_workqueue users
      wifi: cfg80211: replace use of system_unbound_wq with system_dfl_wq
      wifi: ipw2x00: replace use of system_wq with system_percpu_wq
      wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
      wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users
      wifi: mt76: replace use of system_wq with system_percpu_wq

Mario Limonciello (AMD) (1):
      wifi: mt76: Strip whitespace from build ddate

Mark Bloch (5):
      net/mlx5: Use common mlx5_same_hw_devs function
      net/mlx5: Add software system image GUID infrastructure
      net/mlx5: Refactor PTP clock devcom pairing
      net/mlx5: Refactor HCA cap 2 setting
      net/mlx5: Add balance ID support for LAG multiplane groups

Markus Elfring (1):
      net: ti: icssg-prueth: Omit a variable reassignment in prueth_netdev_init()

Markus Schneider-Pargmann (2):
      MAINTAINERS: Add myself as m_can maintainer
      MAINTAINERS: Simplify m_can section

Markus Schneider-Pargmann (TI.com) (4):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state

Martin KaFai Lau (3):
      Merge branch 'bpf-allow-opt-out-from-sk-sk_prot-memory_allocated'
      Merge branch 'make-tc-bpf-helpers-preserve-skb-metadata'
      Merge branch 'net-smc-introduce-smc_hs_ctrl'

Matthieu Baerts (NGI0) (12):
      mptcp: pm: in-kernel: record fullmesh endp nb
      mptcp: pm: in kernel: only use fullmesh endp if any
      selftests: mptcp: join: do_transfer: reduce code dup
      selftests: mptcp: join: validate extra bind cases
      selftests: mptcp: lib: introduce 'nstat_{init,get}'
      selftests: mptcp: lib: remove stats files args
      selftests: mptcp: lib: stats: remove nstat rate columns
      selftests: mptcp: join: dump stats from history
      selftests: mptcp: lib: get counters from nstat history
      selftests: mptcp: connect: avoid double packet traces
      selftests: mptcp: wait for port instead of sleep
      selftests: mptcp: get stats just before timing out

Maud Spierings (1):
      can: mcp251x: mcp251x_can_probe(): use dev_err_probe()

Max Chou (4):
      Bluetooth: btrtl: Add the support for RTL8761CUV
      Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
      Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
      Bluetooth: btusb: Add new VID/PID 0x13d3/0x3619 for RTL8852BE-VT

Max Yuan (1):
      gve: Fix race condition on tx->dropped_pkt update

Maxime Chevallier (7):
      net: stmmac: Move subsecond increment configuration in dedicated helper
      net: stmmac: Add a devlink attribute to control timestamping mode
      net: stmmac: rename devlink parameter ts_coarse into phc_coarse_adj
      net: altera-tse: Set platform drvdata before registering netdev
      net: altera-tse: Warn on bad revision at probe time
      net: altera-tse: Don't use netdev name for the PCS mdio bus
      net: altera-tse: Init PCS and phylink before registering netdev

Meghana Malladi (6):
      net: ti: icssg-prueth: Add functions to create and destroy Rx/Tx queues
      net: ti: icssg-prueth: Add XSK pool helpers
      net: ti: icssg-prueth: Add AF_XDP zero copy for TX
      net: ti: icssg-prueth: Make emac_run_xdp function independent of page
      net: ti: icssg-prueth: Add AF_XDP zero copy for RX
      net: ti: icssg-prueth: Enable zero copy in XDP features

Michael Chan (3):
      bnxt_en: Enhance TX pri counters
      bnxt_en: Add CQ ring dump to bnxt_dump_cp_sw_state()
      bnxt_en: Do not set EOP on RX AGG BDs on 5760X chips

Michael Lo (1):
      wifi: mt76: mt7925: ensure the 6GHz A-MPDU density cap from the hardware.

Michal Kubiak (3):
      ice: remove legacy Rx and construct SKB
      ice: drop page splitting and recycling
      ice: switch to Page Pool

Michal Luczaj (1):
      vsock/test: Extend transport change null-ptr-deref test

Michal Schmidt (1):
      iavf: Implement settime64 with -EOPNOTSUPP

Ming Yen Hsieh (6):
      wifi: mt76: mt7925: refactor regulatory domain handling to regd.[ch]
      wifi: mt76: mt7925: refactor CLC support check flow
      wifi: mt76: mt7925: refactor regulatory notifier flow
      wifi: mt76: mt7925: improve EHT capability control in regulatory flow
      wifi: mt76: mt7925: add auto regdomain switch support
      wifi: mt76: mt7925: disable auto regd changes after user set

Miri Korenblit (7):
      wifi: iwlwifi: align the name of iwl_alive_ntf_v6 to the convention
      wifi: iwlwifi: mld: remove support from of alive notif version 6
      wifi: iwlwifi: mld: reschedule check_tpt_wk also not in EMLSR
      wifi: iwlwifi: iwlmld is always used for wifi7 devices
      wifi: iwlwifi: mvm: cleanup unsupported phy command versions
      wifi: iwlwifi: mld: set wiphy::iftype_ext_capab dynamically
      wifi: iwlwifi: mld: check the validity of noa_len

Mohammad Heib (2):
      devlink: Add new "max_mac_per_vf" generic device param
      i40e: support generic devlink param "max_mac_per_vf"

Mohsin Bashir (1):
      eth: fbnic: Configure RDE settings for pause frame

Muna Sinada (6):
      wifi: ath12k: generalize GI and LTF fixed rate functions
      wifi: ath12k: add EHT rate handling to existing set rate functions
      wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
      wifi: ath12k: Add EHT fixed GI/LTF
      wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
      wifi: ath12k: Set EHT fixed rates for associated STAs

Natalia Wochtman (1):
      ixgbevf: ixgbevf_q_vector clean up

Nathan Chancellor (1):
      net: netcp: ethss: Fix type of first parameter in hwtstamp stubs

Nidhish A N (2):
      wifi: iwlwifi: fw: remove support of several iwl_lari_config_change_cmd versions
      wifi: iwlwifi: mld: Move EMLSR prints to IWL_DL_EHT

Niklas Söderlund (8):
      net: rswitch: Move definition of S4 gPTP offset
      net: rcar_gen4_ptp: Move control fields to users
      net: rswitch: Use common defines for time stamping control
      net: rtsn: Use common defines for time stamping control
      net: rcar_gen4_ptp: Remove unused defines
      net: ravb: Break out Rx hardware timestamping
      net: ravb: Use common defines for time stamping control
      net: ravb: Correct bad check of timestamp control flags

Nikola Z. Ivanov (1):
      team: Add matching error label for failed action

Oleksij Rempel (4):
      net: phy: introduce internal API for PHY MSE diagnostics
      ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
      net: phy: micrel: add MSE interface support for KSZ9477 family
      net: phy: dp83td510: add MSE interface support for 10BASE-T1L

Oliver Hartkopp (5):
      can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
      can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
      can: raw: instantly reject unsupported CAN frames
      can: dev: print bitrate error with two decimal digits
      can: Kconfig: select CAN driver infrastructure by default

Oliver Neukum (2):
      net: usb: usbnet: coding style for functions
      net: usb: usbnet: adhere to style

Ovidiu Panait (2):
      net: stmmac: Fix VLAN 0 deletion in vlan_del_hw_rx_fltr()
      net: stmmac: Disable EEE RX clock stop when VLAN is enabled

Pablo Neira Ayuso (7):
      netfilter: flowtable: check for maximum number of encapsulations in bridge vlan
      netfilter: flowtable: move path discovery infrastructure to its own file
      netfilter: flowtable: consolidate xmit path
      netfilter: flowtable: inline vlan encapsulation in xmit path
      netfilter: flowtable: inline pppoe encapsulation in xmit path
      netfilter: flowtable: remove hw_ifidx
      netfilter: flowtable: use tuple address to calculate next hop

Pagadala Yesu Anjaneyulu (3):
      wifi: cfg80211/mac80211: clean up duplicate ap_power handling
      wifi: cfg80211/mac80211: Add fallback mechanism for INDOOR_SP connection
      wifi: cfg80211: Add support for 6GHz AP role not relevant AP type

Paolo Abeni (38):
      Merge branch 'add-aarch64-support-for-fbnic'
      Merge branch 'txgbe-feat-new-aml-firmware'
      Merge branch 'networking-docs-section-headings-cleanup'
      Merge branch 'net-airoha-add-an7583-ethernet-controller-support'
      Merge branch 'implement-more-features-for-txgbe-devices'
      Merge branch 'net-mlx5-add-balance-id-support-for-lag-multiplane-groups'
      Merge branch 'net-macb-eyeq5-support'
      Merge branch 'net-stmmac-add-support-for-coarse-timestamping'
      Merge branch 'add-cn20k-nix-and-npa-contexts'
      Merge branch 'net-smc-make-wr-buffer-count-configurable'
      Merge branch 'xsk-minor-optimizations-around-locks'
      Merge branch 'amd-xgbe-introduce-support-for-ethtool-selftests'
      Merge branch 'tools-ynl-turn-the-page-pool-sample-into-a-real-tool'
      Merge branch 'devlink-eswitch-inactive-mode'
      Merge tag 'linux-can-next-for-6.19-20251112-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'net-stmmac-disable-eee-rx-clock-stop-when-vlan-is-enabled'
      Merge branch 'gve-implement-xdp-hw-rx-timestamping-support-for-dq'
      Merge branch 'txgbe-support-more-modules'
      Merge branch 'add-af_xdp-zero-copy-support'
      Merge branch 'ynl-cli-list-attrs-argument'
      net: factor-out _sk_charge() helper
      mptcp: factor-out cgroup data inherit helper
      mptcp: grafting MPJ subflow earlier
      mptcp: fix memcg accounting for passive sockets
      mptcp: cleanup fallback data fin reception
      mptcp: cleanup fallback dummy mapping generation
      mptcp: ensure the kernel PM does not take action too late
      mptcp: do not miss early first subflow close event notification
      mptcp: make mptcp_destroy_common() static
      mptcp: drop the __mptcp_data_ready() helper
      mptcp: handle first subflow closing consistently
      mptcp: borrow forward memory from subflow
      mptcp: introduce mptcp-level backlog
      mptcp: leverage the backlog for RX packet processing
      Merge branch 'net_sched-speedup-qdisc-dequeue'
      Merge branch 'net-phy-add-support-for-fbnic-phy-w-25g-50g-and-100g-support'
      Merge tag 'linux-can-next-for-6.19-20251126' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'net-mlx5e-disable-egress-xdp-redirect-in-default'

Parthiban Veerasooran (6):
      net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY
      net: phy: microchip_t1s: configure link status control for LAN867x Rev.D0
      net: phy: phy-c45: add OATC14 10BASE-T1S PHY cable diagnostic support
      net: phy: microchip_t1s:: add cable diagnostic support for LAN867x Rev.D0
      net: phy: phy-c45: add SQI and SQI+ support for OATC14 10Base-T1S PHYs
      net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs

Pascal Giard (1):
      Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets

Patrisious Haddad (3):
      net/mlx5: Add OTHER_ESWITCH HW capabilities
      net/mlx5: fs, Add other_eswitch support for steering tables
      net/mlx5: fs, set non default device per namespace

Pavan Kumar Linga (1):
      idpf: add support for IDPF PCI programming interface

Pavel Begunkov (2):
      net: page pool: xa init with destroy on pp init
      net: page_pool: sanitise allocation order

Pei Xiao (1):
      eth: fbnic: fix integer overflow warning in TLV_MAX_DATA definition

Peter Chiu (2):
      wifi: mt76: use GFP_DMA32 for page_pool buffer allocation
      wifi: mt76: mt7996: no need to wait ACK event for SDO command

Peter Enderborg (1):
      if_ether.h: Clarify ethertype validity for gsw1xx dsa

Petr Machata (2):
      net: bridge: Flush multicast groups when snooping is disabled
      selftests: bridge_mdb: Add a test for MDB flush on snooping disable

Pierre-Henry Moussay (1):
      dt-bindings: net: cdns,macb: Add pic64gx compatibility

Ping-Ke Shih (25):
      wifi: rtw89: splice C2H events queue to local to prevent racing
      wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent racing
      wifi: rtw89: 8832cu: turn off TX partial mode
      wifi: rtw89: fill TX descriptor of FWCMD in shortcut
      wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command
      wifi: rtw89: pci: add to read PCI configuration space from common code
      wifi: rtw89: fw: parse firmware element of DIAG_MAC
      wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
      wifi: rtw89: 8852c: add compensation of thermal value from efuse calibration
      wifi: rtw89: consider data rate/bandwidth/GI for injected packets
      wifi: rtw89: do RF calibration once setting channel when running pure monitor mode
      wifi: rtw89: configure RX antenna if chips can support
      wifi: rtw89: fw: part size to download firmware by header info
      wifi: rtw89: mac: separate pre-init code before downloading firmware
      wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
      wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
      wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
      wifi: rtw89: phy: consider type 15 in BB gain table
      wifi: rtw89: phy: ignore DCFO if not defined in chip_info
      wifi: rtw89: fw: print band and port where beacon update on
      wifi: rtw89: align RA H2C format v1 for RTL8922A
      wifi: rtw89: fill addr cam H2C command by struct
      wifi: rtw89: add addr cam H2C command v1
      wifi: rtw89: use separated function to set RX filter
      wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO

Pradeep Kumar Chitrapu (1):
      wifi: ath12k: fix TX and RX MCS rate configurations in HE mode

Przemek Kitszel (10):
      ice: enforce RTNL assumption of queue NAPI manipulation
      ice: move service task start out of ice_init_pf()
      ice: move ice_init_interrupt_scheme() prior ice_init_pf()
      ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
      ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
      ice: move ice_init_pf() out of ice_init_dev()
      ice: extract ice_init_dev() from ice_init()
      ice: move ice_deinit_dev() to the end of deinit paths
      ice: remove duplicate call to ice_deinit_hw() on error paths
      ice: Extend PTYPE bitmap coverage for GTP encapsulated flows

Quan Zhou (1):
      wifi: mt76: mt792x: fix wifi init fail by setting MCU_RUNNING after CLC load

Raju Rangoju (8):
      net: selftests: export packet creation helpers for driver use
      amd-xgbe: introduce support ethtool selftest
      amd-xgbe: add ethtool phy loopback selftest
      amd-xgbe: add ethtool split header selftest
      amd-xgbe: add ethtool jumbo frame selftest
      amd-xgbe: let the MAC manage PHY PM
      amd-xgbe: refactor the dma IRQ handling code path
      amd-xgbe: schedule NAPI on Rx Buffer Unavailable (RBU)

Rakuram Eswaran (1):
      net: tcp_lp: fix kernel-doc warnings and update outdated reference links

Rameshkumar Sundaram (2):
      wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
      wifi: ath12k: unassign arvif on scan vdev create failure

Randy Dunlap (5):
      nl802154: fix some kernel-doc warnings
      NFC: mei_phy: fix kernel-doc warnings
      wifi: nl80211: vendor-cmd: intel: fix a blank kernel-doc line warning
      netfilter: ip6t_srh: fix UAPI kernel-doc comments format
      netfilter: nf_tables: improve UAPI kernel-doc comments

Ravindra (2):
      Bluetooth: btintel_pcie: Support for S4 (Hibernate)
      Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling

Ria Thomas (1):
      wifi: ieee80211: correct FILS status codes

Rob Herring (Arm) (2):
      dt-bindings: net: Convert amd,xgbe-seattle-v1a to DT schema
      wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"

Rob Miller (1):
      bnxt_en: Add Virtual Admin Link State Support for VFs

Robert Marko (2):
      net: sparx5/lan969x: populate netdev of_node
      net: phy: aquantia: check for NVMEM deferral

Rohan G Thomas (5):
      net: stmmac: socfpga: Agilex5 EMAC platform configuration
      net: stmmac: socfpga: Enable TBS support for Agilex5
      net: stmmac: socfpga: Enable TSO for Agilex5 platform
      net: stmmac: socfpga: Add hardware supported cross-timestamp
      net: stmmac: dwmac: Disable flushing frames on Rx Buffer Unavailable

Roopni Devanathan (2):
      wifi: cfg80211: Add debugfs support for multi-radio wiphy
      wifi: cfg80211: Add parameters to radio-specific debugfs directories

Rosen Penev (2):
      wifi: rt2x00: check retval for of_get_mac_address
      wifi: rt2x00: add nvmem eeprom support

Russell King (Oracle) (118):
      net: stmmac: dwc-qos-eth: move MDIO bus locking into stmmac_mdio
      net: stmmac: place .mac_finish() method more appropriately
      net: stmmac: avoid PHY speed change when configuring MTU
      net: stmmac: rearrange tc_init()
      net: stmmac: rename stmmac_phy_setup() to include phylink
      net: stmmac: remove broken PCS code
      net: stmmac: remove xstats.pcs_* members
      net: stmmac: remove SGMII/RGMII/SMII interrupt handling
      net: stmmac: remove PCS "mode" pause handling
      net: stmmac: remove unused PCS loopback support
      net: stmmac: remove hw->ps xxx_core_init() hardware setup
      net: stmmac: remove RGMII "pcs" mode
      net: stmmac: move reverse-"pcs" mode setup to stmmac_check_pcs_mode()
      net: stmmac: simplify stmmac_check_pcs_mode()
      net: stmmac: hw->ps becomes hw->reverse_sgmii_enable
      net: stmmac: do not require snps,ps-speed for SGMII
      net: stmmac: only call stmmac_pcs_ctrl_ane() for integrated SGMII PCS
      net: stmmac: provide PCS initialisation hook
      net: stmmac: convert to phylink PCS support
      net: stmmac: replace has_xxxx with core_type
      net: phy: add phy_can_wakeup()
      net: phy: add phy_may_wakeup()
      net: phylink: add phylink managed MAC Wake-on-Lan support
      net: phylink: add phylink managed wake-on-lan PHY speed control
      net: stmmac: convert to phylink-managed Wake-on-Lan
      net: stmmac: convert to phylink managed WoL PHY speed
      net: stmmac: add stmmac_mac_irq_modify()
      net: stmmac: add support for controlling PCS interrupts
      net: stmmac: move version handling into own function
      net: stmmac: simplify stmmac_get_version()
      net: stmmac: consolidate version reading and validation
      net: stmmac: move stmmac_get_*id() into stmmac_get_version()
      net: stmmac: use FIELD_GET() for version register
      net: stmmac: provide function to lookup hwif
      net: stmmac: use != rather than ^ for comparing dev_id
      net: stmmac: reorganise stmmac_hwif_init()
      net: stmmac: qcom-ethqos: remove MAC_CTRL_REG modification
      net: stmmac: imx: use phylink's interface mode for set_clk_tx_rate()
      net: stmmac: s32: move PHY_INTF_SEL_x definitions out of the way
      net: stmmac: add phy_intf_sel and ACTPHYIF definitions
      net: stmmac: add stmmac_get_phy_intf_sel()
      net: stmmac: add support for configuring the phy_intf_sel inputs
      net: stmmac: imx: convert to PHY_INTF_SEL_xxx
      net: stmmac: imx: use FIELD_PREP()/FIELD_GET() for PHY_INTF_SEL_x
      net: stmmac: imx: use stmmac_get_phy_intf_sel()
      net: stmmac: imx: simplify set_intf_mode() implementations
      net: stmmac: imx: cleanup arguments for set_intf_mode() method
      net: stmmac: imx: use ->set_phy_intf_sel()
      net: stmmac: lpc18xx: convert to PHY_INTF_SEL_x
      net: stmmac: lpc18xx: use PHY_INTF_SEL_x directly
      net: stmmac: lpc18xx: use stmmac_get_phy_intf_sel()
      net: stmmac: lpc18xx: validate phy_intf_sel
      net: stmmac: lpc18xx: use ->set_phy_intf_sel()
      net: stmmac: sti: use PHY_INTF_SEL_x to select PHY interface
      net: stmmac: sti: use PHY_INTF_SEL_x directly
      net: stmmac: sti: use stmmac_get_phy_intf_sel()
      net: stmmac: sti: use ->set_phy_intf_sel()
      net: stmmac: ingenic: move ingenic_mac_init()
      net: stmmac: ingenic: simplify jz4775 mac_set_mode()
      net: stmmac: ingenic: use PHY_INTF_SEL_x to select PHY interface
      net: stmmac: ingenic: use PHY_INTF_SEL_x directly
      net: stmmac: ingenic: prep PHY_INTF_SEL_x field after switch()
      net: stmmac: ingenic: use stmmac_get_phy_intf_sel()
      net: stmmac: ingenic: move "MAC PHY control register" debug
      net: stmmac: ingenic: simplify mac_set_mode() methods
      net: stmmac: ingenic: simplify x2000 mac_set_mode()
      net: stmmac: ingenic: pass ingenic_mac struct rather than plat_dat
      net: stmmac: ingenic: use ->set_phy_intf_sel()
      net: stmmac: meson8b: use PHY_INTF_SEL_x
      net: stmmac: meson8b: use phy_intf_sel directly
      net: stmmac: meson8b: use stmmac_get_phy_intf_sel()
      net: stmmac: improve ndev->max_mtu setup readability
      net: stmmac: loongson1: use PHY_INTF_SEL_x
      net: stmmac: loongson1: use PHY_INTF_SEL_x directly
      net: stmmac: loongson1: use stmmac_get_phy_intf_sel()
      net: stmmac: mediatek: use PHY_INTF_SEL_x
      net: stmmac: mediatek: use stmmac_get_phy_intf_sel()
      net: stmmac: mediatek: simplify set_interface() methods
      net: stmmac: starfive: use PHY_INTF_SEL_x to select PHY interface
      net: stmmac: starfive: use stmmac_get_phy_intf_sel()
      net: stmmac: stm32: use PHY_INTF_SEL_x to select PHY interface
      net: stmmac: stm32: use PHY_INTF_SEL_x directly
      net: stmmac: stm32: use stmmac_get_phy_intf_sel()
      net: stmmac: visconti: use PHY_INTF_SEL_x to select PHY interface
      net: stmmac: visconti: use stmmac_get_phy_intf_sel()
      net: stmmac: clean up stmmac_reset()
      net: stmmac: always allocate mac_device_info
      net: stmmac: rk: replace HIWORD_UPDATE() with GRF_FIELD()
      net: stmmac: rk: convert all bitfields to GRF_FIELD*()
      net: stmmac: rk: use PHY_INTF_SEL_x constants
      net: stmmac: rk: use PHY_INTF_SEL_x in functions
      net: stmmac: add stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of phy_addr to stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of clk_csr to stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of maxmtu to stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of multicast_filter_bins to stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of unicast_filter_entries to stmmac_plat_dat_alloc()
      net: stmmac: move initialisation of queues_to_use to stmmac_plat_dat_alloc()
      net: stmmac: setup default RX channel map in stmmac_plat_dat_alloc()
      net: stmmac: remove unnecessary .use_prio queue initialisation
      net: stmmac: remove unnecessary .prio queue initialisation
      net: stmmac: remove unnecessary .pkt_route queue initialisation
      net: stmmac: convert priv->sph* to boolean and rename
      net: stmmac: stmmac_is_jumbo_frm() len should be unsigned
      net: stmmac: stmmac_is_jumbo_frm() returns boolean
      net: stmmac: pass struct device to init()/exit() methods
      net: stmmac: move probe/remove calling of init/exit
      net: stmmac: rk: convert to init()/exit() methods
      net: stmmac: rk: use phylink's interface mode for set_clk_tx_rate()
      net: stmmac: dwc-qos-eth: simplify switch() in dwc_eth_dwmac_config_dt()
      net: stmmac: move common DMA AXI register bits to common.h
      net: stmmac: provide common stmmac_axi_blen_to_mask()
      net: stmmac: move stmmac_axi_blen_to_mask() to stmmac_main.c
      net: stmmac: move stmmac_axi_blen_to_mask() to axi_blen init sites
      net: stmmac: remove axi_blen array
      net: stmmac: qcom-ethqos: use u32 for rgmii read/write/update
      net: stmmac: qcom-ethqos: add rgmii set/clear functions
      net: stmmac: qcom-ethqos: use read_poll_timeout_atomic()

Ryder Lee (1):
      wifi: cfg80211/mac80211: validate radio frequency range for monitor mode

Saeed Mahameed (4):
      devlink: Introduce switchdev_inactive eswitch mode
      net/mlx5: MPFS, add support for dynamic enable/disable
      net/mlx5: E-Switch, support eswitch inactive mode
      net/mlx5: Abort new commands if all command slots are stalled

Sagar Cheluvegowda (1):
      dt-bindings: net: qcom: ethernet: Add interconnect properties

Sakari Ailus (5):
      net: ethernet: Remove redundant pm_runtime_mark_last_busy() calls
      net: ipa: Remove redundant pm_runtime_mark_last_busy() calls
      net: wwan: Remove redundant pm_runtime_mark_last_busy() calls
      net: wireless: Remove redundant pm_runtime_mark_last_busy() calls
      Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls

Samiullah Khawaja (2):
      net: Extend NAPI threaded polling to allow kthread based busy polling
      selftests: Add napi threaded busy poll test in `busy_poller`

Sarika Sharma (4):
      wifi: ath12k: Fix MSDU buffer types handling in RX error path
      wifi: ath12k: track dropped MSDU buffer type packets in REO exception ring
      wifi: ath12k: Assert base_lock is held before allocating REO update element
      wifi: mac80211: fix missing RX bitrate update for mesh forwarding path

Seungjin Bae (1):
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()

Shangjuan Wei (3):
      dt-bindings: ethernet: eswin: Document for EIC7700 SoC
      net: stmmac: add Eswin EIC7700 glue driver
      dt-bindings: ethernet: eswin: fix yaml schema issues

Shayne Chen (10):
      wifi: mt76: mt7915: add bf backoff limit table support
      wifi: mt76: mt7996: support fixed rate for link station
      wifi: mt76: mt7996: fix several fields in mt7996_mcu_bss_basic_tlv()
      wifi: mt76: mt7996: fix teardown command for an MLD peer
      wifi: mt76: mt7996: set link_valid field when initializing wcid
      wifi: mt76: mt7996: use correct link_id when filling TXD and TXP
      wifi: mt76: mt7996: fix MLD group index assignment
      wifi: mt76: mt7996: fix MLO set key and group key issues
      wifi: mt76: mt7996: fix using wrong phy to start in mt7996_mac_restart()
      wifi: mt76: mt7996: fix EMI rings for RRO

Shi Hao (1):
      eth: 3c515: replace cleanup_module with __exit

Shuai Zhang (1):
      Bluetooth: btusb: add new custom firmwares

Simon Schippers (1):
      usbnet: Add support for Byte Queue Limits (BQL)

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sjoerd Simons (1):
      dt-bindings: net: mediatek,net: Correct bindings for MT7981

Slark Xiao (1):
      net: wwan: t7xx: Make local function static

Sreedevi Joshi (1):
      idpf: remove duplicate defines in IDPF_CAP_RSS

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix max nss value when getting rx chainmask

Steffen Klassert (2):
      Merge branch 'xfrm: IPsec hardware offload performance improvements'
      pfkey: Deprecate pfkey

Subbaraya Sundeep (7):
      octeontx2-af: Simplify context writing and reading to hardware
      octeontx2-af: Add cn20k NIX block contexts
      octeontx2-af: Extend debugfs support for cn20k NIX
      octeontx2-pf: Initialize new NIX SQ context for cn20k
      octeontx2-af: Accommodate more bandwidth profiles for cn20k
      octeontx2-af: Display new bandwidth profiles too in debugfs
      octeontx2-pf: Use new bandwidth profiles in receive queue

Sunday Adelodun (3):
      net: unix: remove outdated BSD behavior comment in unix_release_sock()
      selftests: af_unix: Add tests for ECONNRESET and EOF semantics
      selftests: af_unix: remove unused stdlib.h include

Sven Eckelmann (1):
      batman-adv: use skb_crc32c() instead of skb_seq_read()

Sven Eckelmann (Plasma Cloud) (3):
      wifi: mt76: Fix DTS power-limits on little endian systems
      dt-bindings: net: wireless: mt76: Document power-limits country property
      dt-bindings: net: wireless: mt76: introduce backoff limit properties

Takashi Iwai (1):
      wifi: ath12k: Add MODULE_FIRMWARE() entries

Tao Lan (1):
      net: hibmcge: add support for tracepoint to dump some fields of rx_desc

Tariq Toukan (11):
      net/mlx5e: Enhance function structures for self loopback prevention application
      net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
      net/mlx5e: Allow setting self loopback prevention bits on TIR init
      net/mlx5: IPoIB, set self loopback prevention in TIR init
      net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
      net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
      net/mlx5e: Defer channels closure to reduce interface down time
      net/mlx5: Expose definition for 1600Gbps link mode
      net/mlx5: Use EOPNOTSUPP instead of ENOTSUPP
      net/mlx5e: Update XDP features in switch channels
      net/mlx5e: Support XDP target xmit with dummy program

Thiraviyam Mariyappan (1):
      wifi: ath12k: Fix NSS value update in ext_rx_stats

Thomas Wismer (2):
      net: pse-pd: tps23881: Add support for TPS23881B
      dt-bindings: pse-pd: ti,tps23881: Add TPS23881B

Thomas Wu (1):
      wifi: mac80211: Allow HT Action frame processing on 6 GHz when HE is supported

Thorsten Blum (3):
      kcm: Fix typo and add hyphen in Kconfig help text
      wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy
      net: ipconfig: Replace strncpy with strscpy in ic_proto_name

Théo Lebrun (20):
      dt-bindings: net: cdns,macb: sort compatibles
      net: macb: use BIT() macro for capability definitions
      net: macb: remove gap in MACB_CAPS_* flags
      net: macb: Remove local variables clk_init and init in macb_probe()
      net: macb: drop macb_config NULL checking
      net: macb: simplify macb_dma_desc_get_size()
      net: macb: simplify macb_adj_dma_desc_idx()
      net: macb: move bp->hw_dma_cap flags to bp->caps
      net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
      net: macb: remove bp->queue_mask
      net: macb: replace min() with umin() calls
      net: macb: drop `entry` local variable in macb_tx_map()
      net: macb: drop `count` local variable in macb_tx_map()
      net: macb: apply reverse christmas tree in macb_tx_map()
      net: macb: sort #includes
      dt-bindings: net: cdns,macb: add Mobileye EyeQ5 ethernet interface
      net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
      net: macb: add no LSO capability (MACB_CAPS_NO_LSO)
      net: macb: rename bp->sgmii_phy field to bp->phy
      net: macb: Add "mobileye,eyeq5-gem" compatible

Tianling Shen (1):
      net: phy: motorcomm: Add support for PHY LEDs on YT8531

Tim Hostetler (5):
      ptp: Return -EINVAL on ptp_clock_register if required ops are NULL
      gve: Move ptp_schedule_worker to gve_init_clock
      gve: Wrap struct xdp_buff
      gve: Prepare bpf_xdp_metadata_rx_timestamp support
      gve: Add Rx HWTS metadata to AF_XDP ZC mode

Tonghao Zhang (1):
      net: add net cookie for net device trace events

Tony Nguyen (1):
      e1000e: Remove unneeded checks

Vadim Fedorenko (32):
      net: ti: am65-cpsw: move hw timestamping to ndo callback
      ti: icssg: convert to ndo_hwtstamp API
      amd-xgbe: convert to ndo_hwtstamp callbacks
      net: atlantic: convert to ndo_hwtstamp API
      cxgb4: convert to ndo_hwtstamp API
      tsnep: convert to ndo_hwtstatmp API
      funeth: convert to ndo_hwtstamp API
      bnxt_en: support PPS in/out on all pins
      octeontx2: convert to ndo_hwtstamp API
      mlx4: convert to ndo_hwtstamp API
      ionic: convert to ndo_hwtstamp API
      net: ravb: convert to ndo_hwtstamp API
      net: renesas: rswitch: convert to ndo_hwtstamp API
      net: hns3: add hwtstamp_get/hwtstamp_set ops
      can: convert generic HW timestamp ioctl to ndo_hwtstamp callbacks
      can: peak_canfd: convert to use ndo_hwtstamp callbacks
      can: peak_usb: convert to use ndo_hwtstamp callbacks
      net: liquidio: convert to use ndo_hwtstamp callbacks
      net: liquidio_vf: convert to use ndo_hwtstamp callbacks
      net: octeon: mgmt: convert to use ndo_hwtstamp callbacks
      net: thunderx: convert to use ndo_hwtstamp callbacks
      net: pch_gbe: convert to use ndo_hwtstamp callbacks
      ti: netcp: convert to ndo_hwtstamp callbacks
      bnx2x: convert to use ndo_hwtstamp callbacks
      qede: convert to use ndo_hwtstamp callbacks
      phy: rename hwtstamp callback to hwtstamp_set
      phy: add hwtstamp_get callback to phy drivers
      net: phy: broadcom: add HW timestamp configuration reporting
      net: phy: dp83640: add HW timestamp configuration reporting
      phy: mscc: add HW timestamp configuration reporting
      net: phy: nxp-c45-tja11xx: add HW timestamp configuration reporting
      ptp: ptp_ines: add HW timestamp configuration reporting

Vincent Mailhol (14):
      can: treewide: remove can_change_mtu()
      can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
      can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
      can: netlink: add CAN_CTRLMODE_RESTRICTED
      can: netlink: add initial CAN XL support
      can: netlink: add CAN_CTRLMODE_XL_TMS flag
      can: bittiming: add PWM parameters
      can: bittiming: add PWM validation
      can: calc_bittiming: add PWM calculation
      can: netlink: add PWM netlink interface
      can: calc_bittiming: replace misleading "nominal" by "reference"
      can: calc_bittiming: add can_calc_sample_point_nrz()
      can: calc_bittiming: add can_calc_sample_point_pwm()
      can: add dummy_can driver

Vitaly Lifshits (1):
      e1000e: Introduce private flag to disable K1

Vladimir Oltean (54):
      net: dsa: lantiq_gswip: support bridge FDB entries on the CPU port
      net: dsa: lantiq_gswip: define VLAN ID 0 constant
      net: dsa: lantiq_gswip: remove duplicate assignment to vlan_mapping.val[0]
      net: dsa: lantiq_gswip: merge gswip_vlan_add_unaware() and gswip_vlan_add_aware()
      net: dsa: lantiq_gswip: remove legacy configure_vlan_while_not_filtering option
      net: dsa: lantiq_gswip: permit dynamic changes to VLAN filtering state
      net: dsa: lantiq_gswip: disallow changes to privately set up VID 0
      net: dsa: lantiq_gswip: remove vlan_aware and pvid arguments from gswip_vlan_remove()
      net: dsa: lantiq_gswip: put a more descriptive error print in gswip_vlan_remove()
      net: dsa: lantiq_gswip: drop untagged on VLAN-aware bridge ports with no PVID
      net: dsa: lantiq_gswip: treat VID 0 like the PVID
      net: pcs: xpcs-plat: fix MODULE_AUTHOR
      net: phy: realtek: create rtl8211f_config_rgmii_delay()
      net: phy: realtek: eliminate priv->phycr2 variable
      net: phy: realtek: eliminate has_phycr2 variable
      net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
      net: phy: realtek: eliminate priv->phycr1 variable
      net: phy: realtek: create rtl8211f_config_phy_eee() helper
      net: dsa: cpu_dp->orig_ethtool_ops might be NULL
      net: dsa: use kernel data types for ethtool ops on conduit
      net: dsa: append ethtool counters of all hidden ports to conduit
      net: phy: dp83867: implement configurability for SGMII in-band auto-negotiation
      net: dpaa: fman_memac: complete phylink support with 2500base-x
      net: fman_memac: report structured ethtool counters
      net: dsa: introduce the dsa_xmit_port_mask() tagging protocol helper
      net: dsa: tag_brcm: use the dsa_xmit_port_mask() helper
      net: dsa: tag_gswip: use the dsa_xmit_port_mask() helper
      net: dsa: tag_hellcreek: use the dsa_xmit_port_mask() helper
      net: dsa: tag_ksz: use the dsa_xmit_port_mask() helper
      net: dsa: tag_mtk: use the dsa_xmit_port_mask() helper
      net: dsa: tag_mxl_gsw1xx: use the dsa_xmit_port_mask() helper
      net: dsa: tag_ocelot: use the dsa_xmit_port_mask() helper
      net: dsa: tag_qca: use the dsa_xmit_port_mask() helper
      net: dsa: tag_rtl4_a: use the dsa_xmit_port_mask() helper
      net: dsa: tag_rtl8_4: use the dsa_xmit_port_mask() helper
      net: dsa: tag_rzn1_a5psw: use the dsa_xmit_port_mask() helper
      net: dsa: tag_trailer: use the dsa_xmit_port_mask() helper
      net: dsa: tag_xrs700x: use the dsa_xmit_port_mask() helper
      net: dsa: tag_yt921x: use the dsa_xmit_port_mask() helper
      net: pcs: lynx: accept in-band autoneg for 2500base-x
      net: dsa: mt7530: unexport mt7530_switch_ops
      net: dsa: avoid calling ds->ops->port_hsr_leave() when unoffloaded
      net: dsa: xrs700x: reject unsupported HSR configurations
      net: dsa: add simple HSR offload helpers
      net: dsa: yt921x: use simple HSR offloading helpers
      net: dsa: ocelot: use simple HSR offload helpers
      net: dsa: realtek: use simple HSR offload helpers
      net: dsa: lantiq_gswip: use simple HSR offload helpers
      net: dsa: mv88e6060: use simple HSR offload helpers
      net: dsa: hellcreek: use simple HSR offload helpers
      net: dsa: mt7530: use simple HSR offload helpers
      net: dsa: a5psw: use simple HSR offload helpers
      Documentation: net: dsa: mention availability of RedBox
      Documentation: net: dsa: mention simple HSR offload helpers

Wang Liang (1):
      net: ipv4: Remove extern udp_v4_early_demux()/tcp_v4_early_demux() in .c files

Wei Fang (13):
      dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
      dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
      net: enetc: add preliminary i.MX94 NETC blocks control support
      net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
      net: enetc: add standalone ENETC support for i.MX94
      net: fec: remove useless conditional preprocessor directives
      net: fec: simplify the conditional preprocessor directives
      net: fec: remove struct fec_enet_priv_txrx_info
      net: fec: remove rx_align from fec_enet_private
      net: fec: remove duplicate macros of the BD status
      net: enetc: set the external PHY address in IERB for port MDIO usage
      net: enetc: set external PHY address in IERB for i.MX94 ENETC
      net: enetc: update the base address of port MDIO registers for ENETC v4

Wei Zhang (1):
      wifi: ath12k: add support for BSS color change

Wilfred Mallawa (2):
      net/tls: support setting the maximum payload size
      selftests: tls: add tls record_size_limit test

Willem de Bruijn (1):
      selftests/net: packetdrill: pass send_omit_free to MSG_ZEROCOPY tests

Xiang Mei (2):
      net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
      selftests/tc-testing: Test CAKE scheduler when enqueue drops packets

Xiaoliang Yang (1):
      net: hsr: create an API to get hsr port type

Xuanqiang Luo (3):
      rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
      inet: Avoid ehash lookup race in inet_ehash_insert()
      inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

Yael Chemla (3):
      net: ethtool: Add support for 1600Gbps speed
      net/mlx5e: Add 1600Gbps link modes
      bonding: 3ad: Add support for 1600G speed

Yang Li (1):
      Bluetooth: iso: fix socket matching ambiguity between BIS and CIS

Yao Zi (3):
      net: stmmac: Add generic suspend/resume helper for PCI-based controllers
      net: stmmac: loongson: Use generic PCI suspend/resume routines
      net: stmmac: pci: Use generic PCI suspend/resume routines

Yeounsu Moon (1):
      net: dlink: fix several spelling mistakes in comments

Yishai Hadas (2):
      PCI/TPH: Expose pcie_tph_get_st_table_loc()
      net/mlx5: Add direct ST mode support for RDMA

Yu-Chun Lin (1):
      wifi: rtw89: Replace hardcoded strings with helper functions

Yue Haibing (5):
      net/sched: Remove unused inline helper qdisc_from_priv()
      net/sched: Remove unused typedef psched_tdiff_t
      net: devmem: Remove unused declaration net_devmem_bind_tx_release()
      vxlan: Remove unused declarations eth_vni_hash() and fdb_head_index()
      sctp: Remove unused declaration sctp_auth_init_hmacs()

Zahari Doychev (1):
      ynl: samples: add tc filter example

Zenm Chen (3):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
      wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU

Zhangchao Zhang (1):
      Bluetooth: mediatek: add gpio pin to reset bt

Zhongqiu Han (3):
      wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
      wifi: ath10k: use = {} to initialize bmi_target_info instead of memset
      ptp: ocp: Document sysfs output format for backward compatibility

Zilin Guan (1):
      mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

Zong-Zhe Yang (3):
      wifi: rtw89: mlo: handle needed H2C when link switching is requested by stack
      wifi: rtw89: support EHT rate pattern via bitrate mask
      wifi: rtw89: regd: apply ACPI policy even if country code is programmed

caivive (Weibiao Tu) (1):
      netfilter: fix typo in nf_conntrack_l4proto.h comment

javen (1):
      r8169: add support for RTL8125K

 Documentation/admin-guide/sysctl/net.rst           |   29 +-
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   35 +-
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |    1 +
 .../bindings/net/amd,xgbe-seattle-v1a.yaml         |  147 +
 Documentation/devicetree/bindings/net/amd-xgbe.txt |   76 -
 .../bindings/net/aspeed,ast2600-mdio.yaml          |    7 +-
 .../bindings/net/bluetooth/marvell,sd8897-bt.yaml  |   79 +
 Documentation/devicetree/bindings/net/btusb.txt    |    2 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   25 +
 .../bindings/net/can/microchip,mcp251xfd.yaml      |    5 +
 .../bindings/net/can/microchip,mpfs-can.yaml       |    5 +
 .../devicetree/bindings/net/cdns,macb.yaml         |   27 +-
 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  |  164 +-
 .../bindings/net/dsa/motorcomm,yt921x.yaml         |  167 +
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    3 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |  129 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |   10 +-
 .../devicetree/bindings/net/fsl,enetc.yaml         |    1 +
 .../devicetree/bindings/net/marvell-bt-8xxx.txt    |   83 -
 .../devicetree/bindings/net/mediatek,net.yaml      |   26 +-
 .../devicetree/bindings/net/mscc-phy-vsc8531.txt   |   73 -
 .../devicetree/bindings/net/mscc-phy-vsc8531.yaml  |  131 +
 .../devicetree/bindings/net/nxp,netc-blk-ctrl.yaml |    1 +
 .../bindings/net/pse-pd/ti,tps23881.yaml           |    1 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |    8 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |    3 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |    6 +-
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   19 +
 .../bindings/net/wireless/mediatek,mt76.yaml       |   66 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +-
 Documentation/driver-api/dpll.rst                  |   36 +-
 Documentation/netlink/genetlink-c.yaml             |    2 +-
 Documentation/netlink/genetlink.yaml               |    2 +-
 Documentation/netlink/netlink-raw.yaml             |    2 +-
 Documentation/netlink/specs/conntrack.yaml         |    2 +-
 Documentation/netlink/specs/devlink.yaml           |   11 +
 Documentation/netlink/specs/dpll.yaml              |    7 +
 Documentation/netlink/specs/ethtool.yaml           |   88 +-
 Documentation/netlink/specs/netdev.yaml            |   28 +-
 Documentation/netlink/specs/nftables.yaml          |    2 +-
 Documentation/netlink/specs/psp.yaml               |   95 +
 Documentation/netlink/specs/rt-addr.yaml           |    7 +-
 Documentation/netlink/specs/rt-link.yaml           |   50 +-
 Documentation/netlink/specs/rt-neigh.yaml          |    2 +-
 Documentation/netlink/specs/rt-route.yaml          |    8 +-
 Documentation/netlink/specs/rt-rule.yaml           |    6 +-
 Documentation/netlink/specs/wireguard.yaml         |  298 ++
 Documentation/networking/6pack.rst                 |    2 +-
 Documentation/networking/arcnet-hardware.rst       |   22 +-
 Documentation/networking/arcnet.rst                |   48 +-
 .../device_drivers/cellular/qualcomm/rmnet.rst     |   10 +-
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst       |   17 +
 .../networking/devlink/devlink-eswitch-attr.rst    |   13 +
 .../networking/devlink/devlink-params.rst          |   14 +
 Documentation/networking/devlink/i40e.rst          |   34 +
 Documentation/networking/devlink/index.rst         |    1 +
 Documentation/networking/devlink/mlx5.rst          |   14 +
 Documentation/networking/devlink/stmmac.rst        |   40 +
 Documentation/networking/dsa/dsa.rst               |   17 +-
 Documentation/networking/ethtool-netlink.rst       |   64 +
 Documentation/networking/index.rst                 |    5 +-
 Documentation/networking/ip-sysctl.rst             |   60 +-
 Documentation/networking/napi.rst                  |   50 +-
 .../net_cachelines/inet_connection_sock.rst        |    2 +-
 .../networking/net_cachelines/inet_sock.rst        |   79 +-
 .../net_cachelines/netns_ipv4_sysctl.rst           |    3 +-
 Documentation/networking/netconsole.rst            |    2 +-
 Documentation/networking/nfc.rst                   |    6 +-
 Documentation/networking/smc-sysctl.rst            |   40 +
 Documentation/networking/statistics.rst            |    4 +-
 Documentation/networking/tls.rst                   |   20 +
 Documentation/networking/xfrm/index.rst            |   13 +
 .../networking/{ => xfrm}/xfrm_device.rst          |   20 +-
 Documentation/networking/{ => xfrm}/xfrm_proc.rst  |    0
 Documentation/networking/{ => xfrm}/xfrm_sync.rst  |   97 +-
 .../networking/{ => xfrm}/xfrm_sysctl.rst          |    4 +-
 MAINTAINERS                                        |   32 +-
 arch/m68k/coldfire/m5272.c                         |   15 -
 arch/mips/bcm47xx/setup.c                          |    7 -
 crypto/af_alg.c                                    |    2 +-
 drivers/android/binder_netlink.c                   |    1 +
 drivers/android/binder_netlink.h                   |    1 +
 drivers/block/drbd/drbd_receiver.c                 |    6 +-
 drivers/bluetooth/Kconfig                          |    1 +
 drivers/bluetooth/btbcm.c                          |    4 +-
 drivers/bluetooth/btintel_pcie.c                   |  179 +-
 drivers/bluetooth/btintel_pcie.h                   |    4 +
 drivers/bluetooth/btmtksdio.c                      |    1 -
 drivers/bluetooth/btrtl.c                          |   16 +-
 drivers/bluetooth/btusb.c                          |   47 +
 drivers/bluetooth/hci_bcm.c                        |    6 +-
 drivers/bluetooth/hci_h5.c                         |   53 +-
 drivers/bluetooth/hci_intel.c                      |    3 -
 .../crypto/marvell/octeontx2/otx2_cpt_devlink.c    |    6 +-
 drivers/dibs/dibs_main.c                           |    8 +-
 drivers/dpll/dpll_netlink.c                        |   12 +-
 drivers/dpll/dpll_nl.c                             |    1 +
 drivers/dpll/dpll_nl.h                             |    1 +
 drivers/dpll/zl3073x/Makefile                      |    3 +-
 drivers/dpll/zl3073x/core.c                        |  243 +-
 drivers/dpll/zl3073x/core.h                        |  188 +-
 drivers/dpll/zl3073x/dpll.c                        |  820 ++---
 drivers/dpll/zl3073x/fw.c                          |    6 +-
 drivers/dpll/zl3073x/out.c                         |  157 +
 drivers/dpll/zl3073x/out.h                         |   93 +
 drivers/dpll/zl3073x/prop.c                        |   19 +-
 drivers/dpll/zl3073x/ref.c                         |  204 ++
 drivers/dpll/zl3073x/ref.h                         |  134 +
 drivers/dpll/zl3073x/synth.c                       |   87 +
 drivers/dpll/zl3073x/synth.h                       |   72 +
 drivers/infiniband/hw/erdma/erdma_cm.c             |    6 +-
 drivers/infiniband/hw/mlx5/main.c                  |    2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   29 +
 drivers/isdn/capi/kcapi.c                          |    2 +-
 drivers/isdn/mISDN/l1oip_core.c                    |    2 +-
 drivers/isdn/mISDN/socket.c                        |    4 +-
 drivers/net/bonding/bond_3ad.c                     |    9 +
 drivers/net/bonding/bond_main.c                    |   99 +-
 drivers/net/can/Kconfig                            |   17 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/at91_can.c                         |    1 -
 drivers/net/can/bxcan.c                            |    3 +-
 drivers/net/can/c_can/c_can_main.c                 |    1 -
 drivers/net/can/can327.c                           |    1 -
 drivers/net/can/cc770/cc770.c                      |    1 -
 drivers/net/can/ctucanfd/ctucanfd_base.c           |    1 -
 drivers/net/can/dev/bittiming.c                    |   63 +
 drivers/net/can/dev/calc_bittiming.c               |  114 +-
 drivers/net/can/dev/dev.c                          |  125 +-
 drivers/net/can/dev/netlink.c                      |  319 +-
 drivers/net/can/dummy_can.c                        |  285 ++
 drivers/net/can/esd/esd_402_pci-core.c             |    4 +-
 drivers/net/can/flexcan/flexcan-core.c             |    1 -
 drivers/net/can/grcan.c                            |    1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              |    1 -
 drivers/net/can/janz-ican3.c                       |    1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |    4 +-
 drivers/net/can/m_can/m_can.c                      |  256 +-
 drivers/net/can/m_can/m_can.h                      |    5 +-
 drivers/net/can/m_can/m_can_pci.c                  |    4 +-
 drivers/net/can/m_can/m_can_platform.c             |    4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |    4 +-
 drivers/net/can/mscan/mscan.c                      |    1 -
 drivers/net/can/peak_canfd/peak_canfd.c            |   36 +-
 drivers/net/can/rcar/rcar_can.c                    |    1 -
 drivers/net/can/rcar/rcar_canfd.c                  |  247 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |    1 -
 drivers/net/can/sja1000/sja1000.c                  |    1 -
 drivers/net/can/slcan/slcan-core.c                 |    1 -
 drivers/net/can/softing/softing_main.c             |    1 -
 drivers/net/can/spi/hi311x.c                       |    1 -
 drivers/net/can/spi/mcp251x.c                      |   32 +-
 drivers/net/can/spi/mcp251xfd/Kconfig              |    1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  285 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |  114 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |    8 +
 drivers/net/can/sun4i_can.c                        |    1 -
 drivers/net/can/ti_hecc.c                          |    1 -
 drivers/net/can/usb/ems_usb.c                      |    1 -
 drivers/net/can/usb/esd_usb.c                      |    1 -
 drivers/net/can/usb/etas_es58x/es58x_core.c        |    4 +-
 drivers/net/can/usb/f81604.c                       |    1 -
 drivers/net/can/usb/gs_usb.c                       |   21 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    4 +-
 drivers/net/can/usb/mcba_usb.c                     |    1 -
 drivers/net/can/usb/nct6694_canfd.c                |    1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   36 +-
 drivers/net/can/usb/ucan.c                         |    1 -
 drivers/net/can/usb/usb_8dev.c                     |    1 -
 drivers/net/can/xilinx_can.c                       |    1 -
 drivers/net/dsa/Kconfig                            |    7 +
 drivers/net/dsa/Makefile                           |    1 +
 drivers/net/dsa/b53/b53_common.c                   |  364 ++-
 drivers/net/dsa/b53/b53_priv.h                     |  111 +-
 drivers/net/dsa/b53/b53_regs.h                     |   45 +-
 drivers/net/dsa/dsa_loop.c                         |    7 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |    2 +
 drivers/net/dsa/ks8995.c                           |    6 +-
 drivers/net/dsa/lantiq/Kconfig                     |   17 +
 drivers/net/dsa/lantiq/Makefile                    |    2 +
 drivers/net/dsa/lantiq/lantiq_gswip.c              | 1686 +---------
 drivers/net/dsa/lantiq/lantiq_gswip.h              |   33 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c       | 1739 ++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                |  733 +++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                |  126 +
 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h            |  154 +
 drivers/net/dsa/microchip/ksz9477.c                |    2 +-
 drivers/net/dsa/mt7530.c                           |    5 +-
 drivers/net/dsa/mt7530.h                           |    1 -
 drivers/net/dsa/mv88e6060.c                        |    2 +
 drivers/net/dsa/ocelot/felix.c                     |   70 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |    2 +
 drivers/net/dsa/realtek/rtl8366rb.c                |    2 +
 drivers/net/dsa/rzn1_a5psw.c                       |    2 +
 drivers/net/dsa/xrs700x/xrs700x.c                  |   11 +
 drivers/net/dsa/yt921x.c                           | 3006 ++++++++++++++++++
 drivers/net/dsa/yt921x.h                           |  567 ++++
 drivers/net/ethernet/3com/3c515.c                  |    4 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c           |  438 ++-
 drivers/net/ethernet/airoha/airoha_eth.h           |   72 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |   95 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  259 +-
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |    3 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |  115 +-
 drivers/net/ethernet/altera/altera_tse.h           |    3 -
 drivers/net/ethernet/altera/altera_tse_main.c      |   47 +-
 drivers/net/ethernet/amd/Kconfig                   |    1 +
 drivers/net/ethernet/amd/pds_core/core.h           |    3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |    3 +-
 drivers/net/ethernet/amd/xgbe/Makefile             |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   19 +
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  113 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |    7 +
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c      |   28 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |    3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c      |  346 ++
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   22 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |   68 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |    6 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h    |    8 +-
 drivers/net/ethernet/broadcom/Kconfig              |    1 +
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |   34 +-
 drivers/net/ethernet/broadcom/b44.c                |   37 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   16 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   70 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   34 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   31 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   55 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |    1 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   31 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   75 +-
 drivers/net/ethernet/broadcom/tg3.c                |   24 +-
 drivers/net/ethernet/cadence/macb.h                |   77 +-
 drivers/net/ethernet/cadence/macb_main.c           |  355 +--
 drivers/net/ethernet/cadence/macb_ptp.c            |   16 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   50 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |   48 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |   62 +-
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |   16 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   45 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  156 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c   |   40 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c |    4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.c         |   44 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.h         |   12 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |    4 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |    8 +-
 drivers/net/ethernet/dlink/dl2k.c                  |    8 +-
 drivers/net/ethernet/dlink/dl2k.h                  |    2 +-
 drivers/net/ethernet/engleder/tsnep.h              |    8 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |   14 +-
 drivers/net/ethernet/engleder/tsnep_ptp.c          |   82 +-
 drivers/net/ethernet/fealnx.c                      |    4 +-
 drivers/net/ethernet/freescale/Kconfig             |    1 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   45 +
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   11 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   28 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |    8 +
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |   36 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |   15 +
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   99 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |    1 +
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |   19 +-
 .../net/ethernet/freescale/enetc/netc_blk_ctrl.c   |  400 +++
 drivers/net/ethernet/freescale/fec.h               |   30 +-
 drivers/net/ethernet/freescale/fec_main.c          |  138 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |   91 +
 drivers/net/ethernet/freescale/fman/mac.h          |   14 +
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   11 +-
 drivers/net/ethernet/fungible/funeth/funeth.h      |    4 +-
 drivers/net/ethernet/fungible/funeth/funeth_main.c |   40 +-
 drivers/net/ethernet/google/gve/gve.h              |   22 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |    4 +
 drivers/net/ethernet/google/gve/gve_dqo.h          |    1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |  103 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   97 +-
 drivers/net/ethernet/google/gve/gve_ptp.c          |   12 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   71 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |    2 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |    6 +
 drivers/net/ethernet/hisilicon/Kconfig             |    1 +
 drivers/net/ethernet/hisilicon/hibmcge/Makefile    |    1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |    8 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |   17 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |    4 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h |   84 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |  219 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   31 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   13 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   32 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |    9 +-
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c |    2 +-
 drivers/net/ethernet/intel/Kconfig                 |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h          |    1 +
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   51 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   41 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    3 +
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   17 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    4 +
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     |   55 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   19 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   43 +-
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c     |  119 +-
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h     |   31 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  107 +-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c         |    7 +
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   12 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   35 +-
 drivers/net/ethernet/intel/ice/ice.h               |    8 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  168 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |    4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  200 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c          |    2 +-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   99 +-
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c          |  269 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |   94 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |    3 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |    3 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |    5 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  203 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   20 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   15 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  710 +----
 drivers/net/ethernet/intel/ice/ice_txrx.h          |  132 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |   69 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |    9 -
 drivers/net/ethernet/intel/ice/ice_type.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   48 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  146 +-
 drivers/net/ethernet/intel/ice/ice_xsk.h           |    6 +-
 drivers/net/ethernet/intel/ice/virt/queues.c       |    6 +-
 drivers/net/ethernet/intel/ice/virt/rss.c          | 1313 +++++++-
 drivers/net/ethernet/intel/idpf/idpf.h             |   14 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   35 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   24 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |  105 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |    2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   12 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |    4 +-
 drivers/net/ethernet/intel/idpf/xdp.c              |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   12 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   11 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    4 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c       |   14 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |   18 +-
 drivers/net/ethernet/marvell/mvneta.c              |   14 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   11 +-
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |    3 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |  218 ++
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.h  |   28 +
 .../net/ethernet/marvell/octeontx2/af/cn20k/nix.c  |   20 +
 .../net/ethernet/marvell/octeontx2/af/cn20k/npa.c  |   21 +
 .../ethernet/marvell/octeontx2/af/cn20k/struct.h   |  340 ++
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   73 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   15 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   42 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   15 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   76 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npa.c    |   29 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |   31 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   10 +
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |  220 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   14 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   19 +-
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |    6 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   56 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   11 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   62 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    6 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   55 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |    3 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   18 +-
 .../net/ethernet/mellanox/mlx5/core/en/devlink.c   |    7 +-
 .../net/ethernet/mellanox/mlx5/core/en/mapping.c   |   13 +-
 .../net/ethernet/mellanox/mlx5/core/en/mapping.h   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   24 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |    3 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |    6 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |    1 +
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |    7 +
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    1 +
 .../ethernet/mellanox/mlx5/core/en/tc/int_port.c   |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c   |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.h   |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.h  |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |  235 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.h |   16 +
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c         |    1 +
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |   52 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   23 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   54 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  136 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    2 +-
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c    |   15 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |    7 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   36 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   13 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  221 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/core.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   31 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   82 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    3 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   18 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   41 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h  |    6 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |    4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   19 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |    1 -
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |  116 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h |    9 +
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c |  238 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c   |   29 +-
 .../net/ethernet/mellanox/mlx5/core/lib/vxlan.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   93 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   36 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |   48 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.h   |   11 +
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   90 +-
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |   61 +-
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h    |   20 +-
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.c    |   69 +-
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.h    |    5 +
 .../mellanox/mlx5/core/steering/sws/dr_domain.c    |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   43 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |    3 +-
 drivers/net/ethernet/meta/Kconfig                  |    3 +-
 drivers/net/ethernet/meta/fbnic/Makefile           |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |    9 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |    6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        |   34 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   81 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |   41 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c       |  195 ++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   11 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |    8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |  201 +-
 drivers/net/ethernet/meta/fbnic/fbnic_time.c       |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h        |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   32 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |    1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    2 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  183 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   12 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  204 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |  123 +-
 drivers/net/ethernet/mucse/Kconfig                 |   33 +
 drivers/net/ethernet/mucse/Makefile                |    7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile         |   11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h         |   71 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c    |  143 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h      |   17 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c    |  320 ++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c     |  406 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h     |   20 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c  |  191 ++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h  |   88 +
 drivers/net/ethernet/netronome/nfp/devlink_param.c |    3 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   38 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   17 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |   18 +-
 drivers/net/ethernet/pensando/ionic/ionic_phc.c    |   61 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c      |    3 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   22 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |   80 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.h        |    6 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   92 +-
 drivers/net/ethernet/renesas/ravb.h                |   16 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  141 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h       |   13 -
 drivers/net/ethernet/renesas/rswitch.h             |    3 +
 drivers/net/ethernet/renesas/rswitch_main.c        |   88 +-
 drivers/net/ethernet/renesas/rtsn.c                |   47 +-
 drivers/net/ethernet/spacemit/k1_emac.h            |    8 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   21 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    4 +-
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    9 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   42 +-
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |    4 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   34 +-
 .../net/ethernet/stmicro/stmmac/dwmac-eic7700.c    |  235 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  130 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |  165 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   53 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   73 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c  |   30 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |   44 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   77 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |   30 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  269 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  363 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |   26 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  168 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |   21 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |   54 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |   44 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   21 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |   24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |    7 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   96 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |   35 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    3 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  100 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |   30 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |   14 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |    5 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   16 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   41 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   33 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |  273 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   19 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   27 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |    4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  112 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |    3 +
 .../net/ethernet/stmicro/stmmac/stmmac_libpci.c    |   48 +
 .../net/ethernet/stmicro/stmmac/stmmac_libpci.h    |   12 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  585 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   88 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   85 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |   67 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |   25 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  112 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |    4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |    3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   47 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    6 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |   21 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  514 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  401 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   31 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    7 +-
 drivers/net/ethernet/ti/netcp.h                    |    5 +
 drivers/net/ethernet/ti/netcp_core.c               |   58 +
 drivers/net/ethernet/ti/netcp_ethss.c              |   72 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c       |   15 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   73 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   69 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  143 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c      |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   51 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h         |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |   12 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     |  302 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h     |    5 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |   38 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |   10 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   28 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    2 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   39 +-
 .../net/ethernet/wangxun/txgbevf/txgbevf_main.c    |   12 +
 drivers/net/gtp.c                                  |    2 +-
 drivers/net/hyperv/netvsc_drv.c                    |   15 +-
 drivers/net/ipa/ipa_interrupt.c                    |    1 -
 drivers/net/ipa/ipa_main.c                         |    1 -
 drivers/net/ipa/ipa_modem.c                        |    4 -
 drivers/net/ipa/ipa_smp2p.c                        |    2 -
 drivers/net/ipa/ipa_uc.c                           |    2 -
 drivers/net/ipvlan/ipvlan_core.c                   |    4 +-
 drivers/net/mdio/fwnode_mdio.c                     |    5 -
 drivers/net/mdio/of_mdio.c                         |    5 +-
 drivers/net/netconsole.c                           |  390 +--
 drivers/net/netdevsim/dev.c                        |   56 +
 drivers/net/netdevsim/ipsec.c                      |    1 +
 drivers/net/netdevsim/netdev.c                     |   26 +-
 drivers/net/netdevsim/netdevsim.h                  |    6 +
 drivers/net/netdevsim/psp.c                        |   27 +
 drivers/net/netkit.c                               |    6 +-
 drivers/net/ovpn/netlink-gen.c                     |    1 +
 drivers/net/ovpn/netlink-gen.h                     |    1 +
 drivers/net/pcs/pcs-lynx.c                         |   77 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |    5 +-
 drivers/net/pcs/pcs-xpcs.c                         |  136 +-
 drivers/net/phy/Kconfig                            |    2 +-
 drivers/net/phy/adin1100.c                         |    7 +-
 drivers/net/phy/aquantia/aquantia_firmware.c       |    2 +-
 drivers/net/phy/bcm-phy-ptp.c                      |   21 +-
 drivers/net/phy/dp83640.c                          |   29 +-
 drivers/net/phy/dp83867.c                          |   36 +-
 drivers/net/phy/dp83td510.c                        |   62 +
 drivers/net/phy/fixed_phy.c                        |   51 +-
 drivers/net/phy/mdio-open-alliance.h               |   49 +
 drivers/net/phy/mdio-private.h                     |   11 +
 drivers/net/phy/mdio_bus.c                         |   96 +-
 drivers/net/phy/mdio_bus_provider.c                |   13 +-
 drivers/net/phy/mdio_device.c                      |   60 +
 drivers/net/phy/micrel.c                           |  200 +-
 drivers/net/phy/microchip_rds_ptp.c                |    8 +-
 drivers/net/phy/microchip_t1s.c                    |  100 +-
 drivers/net/phy/motorcomm.c                        |    3 +
 drivers/net/phy/mscc/mscc.h                        |   12 +-
 drivers/net/phy/mscc/mscc_main.c                   |  510 ++-
 drivers/net/phy/mscc/mscc_ptp.c                    |   21 +-
 drivers/net/phy/mxl-gpy.c                          |  115 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |   22 +-
 drivers/net/phy/phy-c45.c                          |  287 +-
 drivers/net/phy/phy-caps.h                         |    1 +
 drivers/net/phy/phy-core.c                         |   47 +-
 drivers/net/phy/phy.c                              |   14 +-
 drivers/net/phy/phy_caps.c                         |    2 +
 drivers/net/phy/phy_device.c                       |   46 +-
 drivers/net/phy/phylink.c                          |   92 +-
 drivers/net/phy/qt2025.rs                          |   10 +-
 drivers/net/phy/realtek/realtek_main.c             |  404 ++-
 drivers/net/ppp/pppoe.c                            |    4 +-
 drivers/net/ppp/pptp.c                             |    8 +-
 drivers/net/pse-pd/pd692x0.c                       |  155 +-
 drivers/net/pse-pd/tps23881.c                      |   69 +-
 drivers/net/sungem_phy.c                           |    2 +-
 drivers/net/team/team_core.c                       |   86 +-
 drivers/net/team/team_nl.c                         |    1 +
 drivers/net/team/team_nl.h                         |    1 +
 drivers/net/usb/r8152.c                            |    1 +
 drivers/net/usb/usbnet.c                           |  293 +-
 drivers/net/veth.c                                 |    2 +-
 drivers/net/virtio_net.c                           |   46 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |   18 +-
 drivers/net/vxlan/vxlan_core.c                     |   18 +-
 drivers/net/vxlan/vxlan_private.h                  |    2 -
 drivers/net/wan/hdlc_ppp.c                         |    4 +-
 drivers/net/wireguard/Makefile                     |    2 +-
 drivers/net/wireguard/generated/netlink.c          |   73 +
 drivers/net/wireguard/generated/netlink.h          |   30 +
 drivers/net/wireguard/netlink.c                    |   68 +-
 drivers/net/wireless/ath/ath10k/core.c             |   28 +-
 drivers/net/wireless/ath/ath10k/core.h             |    6 +-
 drivers/net/wireless/ath/ath10k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |  275 +-
 drivers/net/wireless/ath/ath10k/testmode_i.h       |   15 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   19 +-
 drivers/net/wireless/ath/ath11k/hal.h              |   38 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  455 ++-
 drivers/net/wireless/ath/ath11k/pci.c              |   20 +-
 drivers/net/wireless/ath/ath11k/pci.h              |   18 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   20 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   18 +-
 drivers/net/wireless/ath/ath12k/core.c             |   24 +-
 drivers/net/wireless/ath/ath12k/core.h             |    4 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   14 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   19 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   74 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   10 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  766 ++++-
 drivers/net/wireless/ath/ath12k/mac.h              |   14 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   24 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   13 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    5 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   98 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   55 +-
 drivers/net/wireless/ath/ath12k/wow.c              |    1 +
 drivers/net/wireless/ath/wcn36xx/hal.h             |   74 -
 drivers/net/wireless/ath/wcn36xx/smd.c             |   60 -
 drivers/net/wireless/ath/wcn36xx/smd.h             |    1 -
 drivers/net/wireless/ath/wil6210/pm.c              |    1 -
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |   14 +
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |    6 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |    1 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |   24 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    5 +
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  134 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |  286 ++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   78 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   39 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   74 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   26 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   29 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   17 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    1 +
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    4 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   14 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   13 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  103 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  100 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        | 1709 +++++-----
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   15 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  164 -
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  164 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   10 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |    9 +
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   29 +
 drivers/net/wireless/mediatek/mt76/Kconfig         |    6 +-
 drivers/net/wireless/mediatek/mt76/Makefile        |    3 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |    2 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |    2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c       |    6 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   75 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |   69 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   77 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   10 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |    2 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |   14 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  159 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Makefile |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7603/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615_trace.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_init.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/testmode.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/trace.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   21 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   10 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci_mcu.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_debugfs.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dma.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Makefile |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/mt76x2u.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_init.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_mcu.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_init.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_mcu.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_phy.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |   76 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  184 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |   23 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/testmode.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    4 +-
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  152 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   40 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   99 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    5 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   |  265 ++
 drivers/net/wireless/mediatek/mt76/mt7925/regd.h   |   19 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    4 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    3 +-
 .../net/wireless/mediatek/mt76/mt792x_debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.h  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile |    3 +-
 .../net/wireless/mediatek/mt76/mt7996/coredump.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/coredump.h   |    2 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   74 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   62 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  153 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   78 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   16 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   38 +-
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    |  352 +++
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |    2 +-
 drivers/net/wireless/mediatek/mt76/npu.c           |  501 +++
 drivers/net/wireless/mediatek/mt76/pci.c           |    2 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |    2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |    2 +-
 drivers/net/wireless/mediatek/mt76/sdio.h          |    2 +-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c     |    2 +-
 drivers/net/wireless/mediatek/mt76/testmode.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/testmode.h      |    2 +-
 drivers/net/wireless/mediatek/mt76/trace.c         |    2 +-
 drivers/net/wireless/mediatek/mt76/trace.h         |    2 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    8 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.c     |    2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h     |    2 +-
 drivers/net/wireless/mediatek/mt76/util.c          |    2 +-
 drivers/net/wireless/mediatek/mt76/util.h          |    3 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |   12 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |    3 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   35 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h     |    2 +
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |    3 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |    6 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   10 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    9 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |   27 +-
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |   80 +-
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      |  115 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  188 +-
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/base.c        |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/fw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/bf.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/bf.h            |    7 +
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    2 +
 drivers/net/wireless/realtek/rtw88/usb.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |   22 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    6 +
 drivers/net/wireless/realtek/rtw89/cam.c           |  165 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |  450 +--
 drivers/net/wireless/realtek/rtw89/core.c          |  231 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  104 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  299 ++
 drivers/net/wireless/realtek/rtw89/fw.c            |  169 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   67 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  200 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |  114 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   89 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    9 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   18 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    4 -
 drivers/net/wireless/realtek/rtw89/phy.c           |   65 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    4 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   23 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   85 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |   16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |   79 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    5 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  170 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   69 +-
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |   69 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   17 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    7 +-
 drivers/net/wireless/realtek/rtw89/usb.c           |  115 +-
 drivers/net/wireless/realtek/rtw89/usb.h           |   12 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    8 +-
 drivers/net/wireless/silabs/wfx/main.c             |    2 +-
 drivers/net/wireless/st/cw1200/bh.c                |   11 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c           |    3 -
 drivers/net/wireless/ti/wlcore/cmd.c               |    1 -
 drivers/net/wireless/ti/wlcore/debugfs.c           |   11 -
 drivers/net/wireless/ti/wlcore/main.c              |   36 -
 drivers/net/wireless/ti/wlcore/scan.c              |    1 -
 drivers/net/wireless/ti/wlcore/sysfs.c             |    1 -
 drivers/net/wireless/ti/wlcore/testmode.c          |    2 -
 drivers/net/wireless/ti/wlcore/tx.c                |    1 -
 drivers/net/wireless/ti/wlcore/vendor_cmd.c        |    3 -
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    1 +
 drivers/net/wwan/iosm/iosm_ipc_devlink.c           |    3 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |   17 +-
 drivers/net/wwan/qcom_bam_dmux.c                   |    2 -
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |    5 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h             |    2 -
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |    2 -
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c         |    2 -
 drivers/net/xen-netfront.c                         |    5 +-
 drivers/nfc/mei_phy.h                              |    4 +-
 drivers/nvme/host/tcp.c                            |    4 +-
 drivers/nvme/target/tcp.c                          |    2 +-
 drivers/pci/tph.c                                  |   16 +-
 drivers/ptp/ptp_clock.c                            |    4 +-
 drivers/ptp/ptp_ines.c                             |   31 +-
 drivers/ptp/ptp_ocp.c                              |   52 +-
 drivers/s390/net/ctcm_fsms.c                       |   14 +
 drivers/s390/net/qeth_core_main.c                  |    2 +-
 drivers/s390/net/qeth_core_mpc.c                   |  247 +-
 drivers/s390/net/qeth_core_mpc.h                   |   20 +-
 drivers/s390/net/smsgiucv_app.c                    |    7 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |    2 +-
 drivers/target/iscsi/iscsi_target_login.c          |    2 +-
 drivers/xen/pvcalls-back.c                         |    4 +-
 fs/afs/rxrpc.c                                     |    6 +-
 fs/coredump.c                                      |    2 +-
 fs/dlm/lowcomms.c                                  |    8 +-
 fs/lockd/netlink.c                                 |    1 +
 fs/lockd/netlink.h                                 |    1 +
 fs/nfsd/netlink.c                                  |    1 +
 fs/nfsd/netlink.h                                  |    1 +
 fs/ocfs2/cluster/tcp.c                             |    6 +-
 fs/smb/client/connect.c                            |    4 +-
 fs/smb/server/transport_tcp.c                      |    4 +-
 include/linux/avf/virtchnl.h                       |   50 +
 include/linux/bpf-cgroup.h                         |   17 +-
 include/linux/can/bittiming.h                      |   81 +-
 include/linux/can/dev.h                            |   82 +-
 include/linux/dpll.h                               |    1 +
 include/linux/filter.h                             |   11 +-
 include/linux/icmp.h                               |   32 +
 include/linux/ieee80211-eht.h                      | 1182 +++++++
 include/linux/ieee80211-he.h                       |  825 +++++
 include/linux/ieee80211-ht.h                       |  292 ++
 include/linux/ieee80211-mesh.h                     |  230 ++
 include/linux/ieee80211-nan.h                      |   35 +
 include/linux/ieee80211-p2p.h                      |   71 +
 include/linux/ieee80211-s1g.h                      |  575 ++++
 include/linux/ieee80211-vht.h                      |  236 ++
 include/linux/ieee80211.h                          | 3326 +-------------------
 include/linux/if_hsr.h                             |    9 +
 include/linux/if_vlan.h                            |   13 +-
 include/linux/ipv6.h                               |    1 -
 include/linux/mdio.h                               |   13 +-
 include/linux/mii_timestamper.h                    |   13 +-
 include/linux/mlx5/driver.h                        |   14 +-
 include/linux/mlx5/fs.h                            |   25 +
 include/linux/mlx5/mlx5_ifc.h                      |   47 +-
 include/linux/mlx5/port.h                          |    1 +
 include/linux/mlx5/vport.h                         |    3 +-
 include/linux/net.h                                |    9 +-
 include/linux/netdev_features.h                    |   18 +
 include/linux/netdevice.h                          |   29 +-
 include/linux/netdevice_xmit.h                     |    9 +-
 include/linux/pci-tph.h                            |    1 +
 include/linux/pcs/pcs-xpcs.h                       |    4 +-
 include/linux/phy.h                                |  281 +-
 include/linux/phy_fixed.h                          |   14 +-
 include/linux/phylink.h                            |   28 +
 include/linux/platform_data/bcmgenet.h             |   19 -
 include/linux/rculist_nulls.h                      |   59 +
 include/linux/skbuff.h                             |   79 +-
 include/linux/soc/airoha/airoha_offload.h          |    1 +
 include/linux/soc/mediatek/mtk_wed.h               |    1 +
 include/linux/socket.h                             |   23 +-
 include/linux/stmmac.h                             |   23 +-
 include/linux/usb/usbnet.h                         |    2 +
 include/net/addrconf.h                             |    5 +
 include/net/bluetooth/hci.h                        |   77 +
 include/net/bluetooth/hci_core.h                   |   23 +-
 include/net/bluetooth/hci_sync.h                   |    3 +
 include/net/bluetooth/mgmt.h                       |    2 +
 include/net/cfg80211.h                             |   56 +-
 include/net/devlink.h                              |   49 +-
 include/net/dsa.h                                  |   21 +-
 include/net/gro.h                                  |   27 +
 include/net/ieee80211_radiotap.h                   |   20 +-
 include/net/inet_common.h                          |   13 +-
 include/net/inet_connection_sock.h                 |   31 +-
 include/net/inet_sock.h                            |    9 +-
 include/net/ip.h                                   |    4 +-
 include/net/ipv6.h                                 |   10 +-
 include/net/ipv6_stubs.h                           |    2 +-
 include/net/mac80211.h                             |    4 +-
 include/net/mana/gdma.h                            |   24 +-
 include/net/mana/hw_channel.h                      |    2 +
 include/net/mana/mana.h                            |   24 +-
 include/net/neighbour.h                            |   17 +-
 include/net/netfilter/nf_conntrack_count.h         |   15 +-
 include/net/netfilter/nf_conntrack_l4proto.h       |    2 +-
 include/net/netfilter/nf_flow_table.h              |   26 +-
 include/net/netmem.h                               |   72 +-
 include/net/netns/core.h                           |    2 +
 include/net/netns/ipv4.h                           |    5 +-
 include/net/netns/ipv6.h                           |    1 +
 include/net/netns/mpls.h                           |    1 +
 include/net/netns/smc.h                            |    5 +
 include/net/nl802154.h                             |    5 +-
 include/net/ping.h                                 |    2 +-
 include/net/pkt_sched.h                            |   11 +-
 include/net/proto_memory.h                         |    3 +
 include/net/psp/types.h                            |   32 +
 include/net/request_sock.h                         |    1 -
 include/net/sch_generic.h                          |  120 +-
 include/net/sctp/auth.h                            |    1 -
 include/net/sctp/sctp.h                            |    5 +-
 include/net/sctp/stream_sched.h                    |    4 +-
 include/net/sctp/structs.h                         |    9 +-
 include/net/selftests.h                            |   45 +
 include/net/smc.h                                  |   53 +
 include/net/sock.h                                 |   99 +-
 include/net/tcp.h                                  |   42 +-
 include/net/tls.h                                  |    3 +
 include/net/udp.h                                  |    2 +-
 include/net/vsock_addr.h                           |    2 +-
 include/net/xdp_sock.h                             |    7 +
 include/net/xdp_sock_drv.h                         |    4 +
 include/net/xsk_buff_pool.h                        |   13 +-
 include/trace/events/net.h                         |   37 +-
 include/uapi/linux/android/binder_netlink.h        |    1 +
 include/uapi/linux/bpf.h                           |    2 +
 include/uapi/linux/can/netlink.h                   |   34 +
 include/uapi/linux/devlink.h                       |    4 +
 include/uapi/linux/dpll.h                          |    2 +
 include/uapi/linux/ethtool.h                       |    5 +
 include/uapi/linux/ethtool_netlink_generated.h     |   36 +
 include/uapi/linux/fou.h                           |    1 +
 include/uapi/linux/handshake.h                     |    1 +
 include/uapi/linux/if_ether.h                      |    4 +
 include/uapi/linux/if_team.h                       |    1 +
 include/uapi/linux/lockd_netlink.h                 |    1 +
 include/uapi/linux/mdio.h                          |   23 +-
 include/uapi/linux/mptcp.h                         |    3 +-
 include/uapi/linux/mptcp_pm.h                      |    1 +
 include/uapi/linux/net_shaper.h                    |    1 +
 include/uapi/linux/netdev.h                        |    2 +
 include/uapi/linux/netfilter/nf_tables.h           |   14 +-
 include/uapi/linux/netfilter_ipv6/ip6t_srh.h       |   40 +-
 include/uapi/linux/nfsd_netlink.h                  |    1 +
 include/uapi/linux/nl80211-vnd-intel.h             |    1 -
 include/uapi/linux/ovpn.h                          |    1 +
 include/uapi/linux/psp.h                           |   19 +
 include/uapi/linux/tls.h                           |    2 +
 include/uapi/linux/wireguard.h                     |  193 +-
 kernel/bpf/bpf_struct_ops.c                        |    2 +
 kernel/bpf/cgroup.c                                |    8 +-
 kernel/bpf/helpers.c                               |    6 +-
 kernel/bpf/syscall.c                               |    1 +
 net/9p/trans_fd.c                                  |    8 +-
 net/Kconfig                                        |    8 +-
 net/appletalk/ddp.c                                |    4 +-
 net/atm/clip.c                                     |    4 +-
 net/atm/common.c                                   |    2 +-
 net/atm/pvc.c                                      |    4 +-
 net/atm/svc.c                                      |    4 +-
 net/ax25/af_ax25.c                                 |    4 +-
 net/batman-adv/Kconfig                             |    1 +
 net/batman-adv/bridge_loop_avoidance.c             |   51 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/types.h                             |    2 +-
 net/bluetooth/hci_conn.c                           |   55 +-
 net/bluetooth/hci_event.c                          |  222 +-
 net/bluetooth/hci_sock.c                           |    2 +-
 net/bluetooth/hci_sync.c                           |  254 +-
 net/bluetooth/iso.c                                |  213 +-
 net/bluetooth/l2cap_sock.c                         |    4 +-
 net/bluetooth/mgmt.c                               |  160 +-
 net/bluetooth/rfcomm/core.c                        |    6 +-
 net/bluetooth/rfcomm/sock.c                        |    5 +-
 net/bluetooth/sco.c                                |    4 +-
 net/bridge/br_if.c                                 |   22 +-
 net/bridge/br_multicast.c                          |    9 +
 net/bridge/br_netlink.c                            |    2 +-
 net/caif/caif_socket.c                             |    2 +-
 net/can/Kconfig                                    |    1 +
 net/can/bcm.c                                      |    2 +-
 net/can/isotp.c                                    |    2 +-
 net/can/j1939/socket.c                             |    4 +-
 net/can/raw.c                                      |   56 +-
 net/ceph/messenger.c                               |    2 +-
 net/core/dev.c                                     |  379 ++-
 net/core/dev.h                                     |    3 +
 net/core/dev_ioctl.c                               |   11 +-
 net/core/devmem.c                                  |    6 +-
 net/core/devmem.h                                  |    1 -
 net/core/filter.c                                  |  124 +-
 net/core/hotdata.c                                 |    2 +-
 net/core/neighbour.c                               |  131 +-
 net/core/net_namespace.c                           |   12 +-
 net/core/netdev-genl-gen.c                         |    3 +-
 net/core/netdev-genl-gen.h                         |    1 +
 net/core/netmem_priv.h                             |   16 +-
 net/core/netpoll.c                                 |    2 +-
 net/core/page_pool.c                               |    4 +
 net/core/rtnetlink.c                               |   15 +-
 net/core/selftests.c                               |   48 +-
 net/core/skbuff.c                                  |  119 +-
 net/core/sock.c                                    |  120 +-
 net/core/sysctl_net_core.c                         |   16 +
 net/devlink/netlink_gen.c                          |    8 +-
 net/devlink/netlink_gen.h                          |    1 +
 net/devlink/param.c                                |  189 +-
 net/devlink/region.c                               |    2 +-
 net/dsa/Kconfig                                    |   14 +
 net/dsa/Makefile                                   |    2 +
 net/dsa/conduit.c                                  |  145 +-
 net/dsa/devlink.c                                  |    3 +-
 net/dsa/dsa.c                                      |   65 +
 net/dsa/port.c                                     |    3 +
 net/dsa/tag.h                                      |   18 +
 net/dsa/tag_brcm.c                                 |    8 +-
 net/dsa/tag_gswip.c                                |    6 +-
 net/dsa/tag_hellcreek.c                            |    3 +-
 net/dsa/tag_ksz.c                                  |   20 +-
 net/dsa/tag_mtk.c                                  |    3 +-
 net/dsa/tag_mxl-gsw1xx.c                           |  117 +
 net/dsa/tag_ocelot.c                               |    6 +-
 net/dsa/tag_qca.c                                  |    3 +-
 net/dsa/tag_rtl4_a.c                               |    2 +-
 net/dsa/tag_rtl8_4.c                               |    3 +-
 net/dsa/tag_rzn1_a5psw.c                           |    3 +-
 net/dsa/tag_trailer.c                              |    3 +-
 net/dsa/tag_xrs700x.c                              |    8 +-
 net/dsa/tag_yt921x.c                               |  139 +
 net/ethernet/eth.c                                 |   16 +-
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/common.c                               |    8 +
 net/ethtool/mse.c                                  |  329 ++
 net/ethtool/netlink.c                              |   10 +
 net/ethtool/netlink.h                              |    2 +
 net/handshake/genl.c                               |    1 +
 net/handshake/genl.h                               |    1 +
 net/hsr/hsr_device.c                               |   20 +
 net/hsr/hsr_netlink.c                              |    8 +
 net/hsr/hsr_slave.c                                |    7 +-
 net/ieee802154/socket.c                            |   12 +-
 net/ipv4/Kconfig                                   |    4 +-
 net/ipv4/af_inet.c                                 |   22 +-
 net/ipv4/arp.c                                     |    6 +-
 net/ipv4/datagram.c                                |    4 +-
 net/ipv4/fou_nl.c                                  |    1 +
 net/ipv4/fou_nl.h                                  |    1 +
 net/ipv4/icmp.c                                    |  191 +-
 net/ipv4/inet_connection_sock.c                    |   56 +-
 net/ipv4/inet_diag.c                               |    8 +-
 net/ipv4/inet_hashtables.c                         |    8 +-
 net/ipv4/inet_timewait_sock.c                      |   35 +-
 net/ipv4/ip_input.c                                |    4 +-
 net/ipv4/ipconfig.c                                |    3 +-
 net/ipv4/ipip.c                                    |   25 +
 net/ipv4/ping.c                                    |    8 +-
 net/ipv4/raw.c                                     |    3 +-
 net/ipv4/sysctl_net_ipv4.c                         |   29 +
 net/ipv4/tcp.c                                     |  125 +-
 net/ipv4/tcp_input.c                               |   72 +-
 net/ipv4/tcp_ipv4.c                                |  156 +-
 net/ipv4/tcp_lp.c                                  |    7 +-
 net/ipv4/tcp_minisocks.c                           |    8 +-
 net/ipv4/tcp_offload.c                             |   27 -
 net/ipv4/tcp_output.c                              |   38 +-
 net/ipv4/tcp_timer.c                               |   26 +-
 net/ipv4/udp.c                                     |    6 +-
 net/ipv4/udp_tunnel_core.c                         |    4 +-
 net/ipv6/addrconf.c                                |    2 +-
 net/ipv6/af_inet6.c                                |    7 +-
 net/ipv6/datagram.c                                |    8 +-
 net/ipv6/icmp.c                                    |  214 +-
 net/ipv6/ip6_fib.c                                 |    4 +
 net/ipv6/ip6_flowlabel.c                           |   44 +-
 net/ipv6/ip6_udp_tunnel.c                          |    4 +-
 net/ipv6/ndisc.c                                   |    8 +-
 net/ipv6/ping.c                                    |    2 +-
 net/ipv6/raw.c                                     |    3 +-
 net/ipv6/tcp_ipv6.c                                |  145 +-
 net/ipv6/udp.c                                     |    5 +-
 net/iucv/af_iucv.c                                 |   16 +-
 net/iucv/iucv.c                                    |    5 +-
 net/kcm/Kconfig                                    |    4 +-
 net/key/af_key.c                                   |    2 +
 net/l2tp/l2tp_core.c                               |    8 +-
 net/l2tp/l2tp_debugfs.c                            |    2 +-
 net/l2tp/l2tp_ip.c                                 |    6 +-
 net/l2tp/l2tp_ip6.c                                |    5 +-
 net/l2tp/l2tp_ppp.c                                |    2 +-
 net/llc/af_llc.c                                   |    4 +-
 net/mac80211/aes_cmac.c                            |   60 +-
 net/mac80211/aes_cmac.h                            |    7 +-
 net/mac80211/aes_gmac.c                            |   22 +-
 net/mac80211/aes_gmac.h                            |    1 -
 net/mac80211/agg-rx.c                              |    7 +-
 net/mac80211/cfg.c                                 |   47 +-
 net/mac80211/chan.c                                |  410 ++-
 net/mac80211/driver-ops.c                          |    8 +-
 net/mac80211/he.c                                  |    6 +-
 net/mac80211/ibss.c                                |   14 +-
 net/mac80211/ieee80211_i.h                         |   50 +-
 net/mac80211/iface.c                               |   46 +-
 net/mac80211/link.c                                |    5 -
 net/mac80211/main.c                                |    3 +-
 net/mac80211/mesh.c                                |   26 +-
 net/mac80211/mesh_hwmp.c                           |    7 +-
 net/mac80211/mesh_plink.c                          |    7 +-
 net/mac80211/mlme.c                                |   90 +-
 net/mac80211/parse.c                               |   30 +-
 net/mac80211/rx.c                                  |  178 +-
 net/mac80211/scan.c                                |    6 +-
 net/mac80211/tdls.c                                |   12 +-
 net/mac80211/tests/elems.c                         |    4 +-
 net/mac80211/tx.c                                  |    6 +-
 net/mac80211/util.c                                |   37 +-
 net/mac80211/wpa.c                                 |  150 +-
 net/mac80211/wpa.h                                 |   10 +-
 net/mctp/af_mctp.c                                 |    4 +-
 net/mctp/test/route-test.c                         |  111 +-
 net/mctp/test/utils.c                              |   50 +-
 net/mctp/test/utils.h                              |   13 +-
 net/mpls/af_mpls.c                                 |  321 +-
 net/mpls/internal.h                                |   19 +-
 net/mpls/mpls_iptunnel.c                           |    6 +-
 net/mptcp/fastopen.c                               |    4 +-
 net/mptcp/mib.c                                    |    1 -
 net/mptcp/mib.h                                    |    1 -
 net/mptcp/mptcp_diag.c                             |    3 +-
 net/mptcp/mptcp_pm_gen.c                           |    1 +
 net/mptcp/mptcp_pm_gen.h                           |    1 +
 net/mptcp/pm.c                                     |    4 +-
 net/mptcp/pm_kernel.c                              |   42 +-
 net/mptcp/protocol.c                               |  467 ++-
 net/mptcp/protocol.h                               |   54 +-
 net/mptcp/sockopt.c                                |    2 +
 net/mptcp/subflow.c                                |   46 +-
 net/netfilter/Makefile                             |    1 +
 net/netfilter/ipvs/ip_vs_app.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    3 +-
 net/netfilter/ipvs/ip_vs_core.c                    |    3 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_dh.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_est.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_fo.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_ftp.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |    3 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |    3 +-
 net/netfilter/ipvs/ip_vs_lc.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_mh.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_nfct.c                    |    3 +-
 net/netfilter/ipvs/ip_vs_nq.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_ovf.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_pe.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_pe_sip.c                  |    3 +-
 net/netfilter/ipvs/ip_vs_proto.c                   |    3 +-
 net/netfilter/ipvs/ip_vs_proto_ah_esp.c            |    3 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |    3 +-
 net/netfilter/ipvs/ip_vs_proto_udp.c               |    3 +-
 net/netfilter/ipvs/ip_vs_rr.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_sched.c                   |    3 +-
 net/netfilter/ipvs/ip_vs_sed.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_sh.c                      |    3 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |    9 +-
 net/netfilter/ipvs/ip_vs_twos.c                    |    3 +-
 net/netfilter/ipvs/ip_vs_wlc.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_wrr.c                     |    3 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |    3 +-
 net/netfilter/nf_conncount.c                       |  219 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_standalone.c            |    4 +-
 net/netfilter/nf_flow_table_core.c                 |    5 +-
 net/netfilter/nf_flow_table_ip.c                   |  293 +-
 net/netfilter/nf_flow_table_offload.c              |    2 +-
 net/netfilter/nf_flow_table_path.c                 |  330 ++
 net/netfilter/nf_tables_api.c                      |   34 +-
 net/netfilter/nft_connlimit.c                      |   54 +-
 net/netfilter/nft_flow_offload.c                   |  252 --
 net/netfilter/nft_lookup.c                         |   13 +-
 net/netfilter/xt_connlimit.c                       |   14 +-
 net/netlink/af_netlink.c                           |    8 +-
 net/netrom/af_netrom.c                             |    6 +-
 net/nfc/llcp_sock.c                                |    6 +-
 net/nfc/rawsock.c                                  |    2 +-
 net/openvswitch/conntrack.c                        |   16 +-
 net/packet/af_packet.c                             |   15 +-
 net/phonet/pep.c                                   |    3 +-
 net/phonet/socket.c                                |   10 +-
 net/psp/psp-nl-gen.c                               |   20 +
 net/psp/psp-nl-gen.h                               |    3 +
 net/psp/psp_main.c                                 |    3 +-
 net/psp/psp_nl.c                                   |   93 +
 net/psp/psp_sock.c                                 |    4 +-
 net/qrtr/af_qrtr.c                                 |    4 +-
 net/qrtr/ns.c                                      |    2 +-
 net/rds/af_rds.c                                   |    2 +-
 net/rds/bind.c                                     |    2 +-
 net/rds/rds.h                                      |    2 +-
 net/rds/tcp_connect.c                              |    4 +-
 net/rds/tcp_listen.c                               |    2 +-
 net/rose/af_rose.c                                 |    5 +-
 net/rxrpc/af_rxrpc.c                               |    4 +-
 net/rxrpc/rxperf.c                                 |    2 +-
 net/sched/act_ct.c                                 |    8 +-
 net/sched/act_ife.c                                |    6 +-
 net/sched/act_mirred.c                             |   62 +-
 net/sched/cls_api.c                                |    8 +-
 net/sched/cls_flower.c                             |    2 +-
 net/sched/sch_cake.c                               |   79 +-
 net/sched/sch_codel.c                              |    4 +-
 net/sched/sch_dualpi2.c                            |    1 +
 net/sched/sch_fq.c                                 |    9 +-
 net/sched/sch_fq_codel.c                           |    5 +-
 net/sched/sch_generic.c                            |    7 -
 net/sched/sch_netem.c                              |    1 +
 net/sched/sch_qfq.c                                |    2 +-
 net/sched/sch_taprio.c                             |    1 +
 net/sched/sch_tbf.c                                |    1 +
 net/sctp/ipv6.c                                    |   49 -
 net/sctp/protocol.c                                |   33 -
 net/sctp/socket.c                                  |  223 +-
 net/sctp/stream.c                                  |    8 +-
 net/sctp/stream_sched.c                            |   16 +-
 net/sctp/stream_sched_fc.c                         |    4 +-
 net/sctp/stream_sched_prio.c                       |    2 +-
 net/sctp/stream_sched_rr.c                         |    2 +-
 net/shaper/shaper_nl_gen.c                         |    1 +
 net/shaper/shaper_nl_gen.h                         |    1 +
 net/smc/Kconfig                                    |   10 +
 net/smc/Makefile                                   |    1 +
 net/smc/af_smc.c                                   |   34 +-
 net/smc/smc.h                                      |    4 +-
 net/smc/smc_core.c                                 |   34 +-
 net/smc/smc_core.h                                 |    8 +
 net/smc/smc_hs_bpf.c                               |  140 +
 net/smc/smc_hs_bpf.h                               |   31 +
 net/smc/smc_ib.c                                   |   10 +-
 net/smc/smc_llc.c                                  |    2 +
 net/smc/smc_sysctl.c                               |  113 +
 net/smc/smc_sysctl.h                               |    2 +
 net/smc/smc_wr.c                                   |   31 +-
 net/smc/smc_wr.h                                   |    2 -
 net/socket.c                                       |   14 +-
 net/strparser/strparser.c                          |    2 +-
 net/sunrpc/clnt.c                                  |    6 +-
 net/sunrpc/svcsock.c                               |    2 +-
 net/sunrpc/xprtsock.c                              |    9 +-
 net/tipc/socket.c                                  |   10 +-
 net/tls/tls_device.c                               |    5 +-
 net/tls/tls_main.c                                 |   64 +
 net/tls/tls_sw.c                                   |    2 +-
 net/unix/af_unix.c                                 |   30 +-
 net/unix/af_unix.h                                 |    4 +-
 net/unix/garbage.c                                 |   94 +-
 net/vmw_vsock/af_vsock.c                           |    6 +-
 net/vmw_vsock/vsock_addr.c                         |    2 +-
 net/wireless/core.c                                |   32 +-
 net/wireless/core.h                                |    4 +-
 net/wireless/debugfs.c                             |   33 +
 net/wireless/mlme.c                                |   19 +
 net/wireless/nl80211.c                             |   10 +-
 net/wireless/scan.c                                |   20 +-
 net/wireless/sysfs.c                               |    2 +-
 net/wireless/util.c                                |   29 +-
 net/x25/af_x25.c                                   |    4 +-
 net/xdp/xsk.c                                      |   20 +-
 net/xdp/xsk_buff_pool.c                            |   21 +-
 net/xfrm/Kconfig                                   |   11 +-
 net/xfrm/xfrm_input.c                              |   30 +-
 samples/qmi/qmi_sample_client.c                    |    2 +-
 tools/include/uapi/linux/bpf.h                     |    1 +
 tools/include/uapi/linux/netdev.h                  |    2 +
 tools/net/ynl/Makefile                             |   29 +-
 tools/net/ynl/pyynl/cli.py                         |  100 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |   44 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   26 +-
 tools/net/ynl/samples/.gitignore                   |    1 +
 tools/net/ynl/samples/Makefile                     |    1 +
 tools/net/ynl/samples/page-pool.c                  |  149 -
 tools/net/ynl/samples/tc-filter-add.c              |  335 ++
 tools/net/ynl/tests/Makefile                       |   32 +
 tools/net/ynl/tests/config                         |    6 +
 tools/net/ynl/tests/test_ynl_cli.sh                |  327 ++
 tools/net/ynl/tests/test_ynl_ethtool.sh            |  222 ++
 tools/net/ynl/ynltool/.gitignore                   |    2 +
 tools/net/ynl/ynltool/Makefile                     |   55 +
 tools/net/ynl/ynltool/json_writer.c                |  288 ++
 tools/net/ynl/ynltool/json_writer.h                |   75 +
 tools/net/ynl/ynltool/main.c                       |  242 ++
 tools/net/ynl/ynltool/main.h                       |   66 +
 tools/net/ynl/ynltool/page-pool.c                  |  461 +++
 tools/net/ynl/ynltool/qstats.c                     |  621 ++++
 tools/perf/trace/beauty/include/linux/socket.h     |    5 +-
 tools/testing/selftests/bpf/config                 |    5 +
 .../selftests/bpf/prog_tests/sk_bypass_prot_mem.c  |  292 ++
 .../selftests/bpf/prog_tests/test_bpf_smc.c        |  390 +++
 .../bpf/prog_tests/xdp_context_test_run.c          |  129 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c  |    8 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c  |    8 +-
 tools/testing/selftests/bpf/progs/bpf_smc.c        |  117 +
 .../selftests/bpf/progs/sk_bypass_prot_mem.c       |  104 +
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  386 ++-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |    4 +-
 tools/testing/selftests/drivers/net/.gitignore     |    1 +
 tools/testing/selftests/drivers/net/Makefile       |    3 +
 .../drivers/net/bonding/bond_macvlan_ipvlan.sh     |    1 +
 tools/testing/selftests/{ => drivers}/net/gro.c    |    5 +-
 tools/testing/selftests/drivers/net/gro.py         |  164 +
 tools/testing/selftests/drivers/net/hw/.gitignore  |    1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   26 +-
 .../selftests/drivers/net/hw/devlink_rate_tc_bw.py |  174 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    9 +-
 .../selftests/{net => drivers/net/hw}/toeplitz.c   |   72 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.py |  211 ++
 .../selftests/drivers/net/lib/py/__init__.py       |    9 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |    2 +
 tools/testing/selftests/drivers/net/lib/py/load.py |   84 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |    2 +-
 .../testing/selftests/drivers/net/netcons_basic.sh |    5 +-
 .../selftests/drivers/net/netcons_overflow.sh      |    2 +-
 .../selftests/drivers/net/netdevsim/Makefile       |    1 -
 .../selftests/drivers/net/netdevsim/devlink.sh     |  116 +-
 .../drivers/net/netdevsim/ethtool-ring.sh          |   85 -
 tools/testing/selftests/drivers/net/psp.py         |   13 +
 .../testing/selftests/drivers/net/ring_reconfig.py |  167 +
 tools/testing/selftests/drivers/net/stats.py       |    5 +-
 tools/testing/selftests/drivers/net/xdp.py         |   57 +-
 tools/testing/selftests/net/.gitignore             |    9 -
 tools/testing/selftests/net/Makefile               |    7 -
 tools/testing/selftests/net/af_unix/.gitignore     |    8 +
 tools/testing/selftests/net/af_unix/Makefile       |    1 +
 tools/testing/selftests/net/af_unix/so_peek_off.c  |    4 +-
 .../testing/selftests/net/af_unix/unix_connreset.c |  180 ++
 .../selftests/net/arp_ndisc_evict_nocarrier.sh     |    2 +-
 tools/testing/selftests/net/busy_poll_test.sh      |   24 +-
 tools/testing/selftests/net/busy_poller.c          |   16 +-
 tools/testing/selftests/net/fib_tests.sh           |   66 +-
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  100 +-
 tools/testing/selftests/net/gro.sh                 |  105 -
 tools/testing/selftests/net/io_uring_zerocopy_tx.c |   24 +-
 tools/testing/selftests/net/lib/Makefile           |    1 +
 .../selftests/net/lib/ksft_setup_loopback.sh       |  111 +
 tools/testing/selftests/net/lib/py/__init__.py     |    5 +-
 tools/testing/selftests/net/lib/py/ksft.py         |  107 +-
 tools/testing/selftests/net/lib/py/nsim.py         |    2 +-
 tools/testing/selftests/net/lib/py/utils.py        |   20 +-
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |    5 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   10 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  140 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  244 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   58 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   43 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   44 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |    3 +-
 .../selftests/net/netfilter/nft_flowtable.sh       |  126 +-
 .../selftests/net/netfilter/sctp_collision.c       |    3 +-
 tools/testing/selftests/net/netlink-dumps.c        |    1 +
 .../net/packetdrill/tcp_rto_synack_rto_max.pkt     |   54 +
 .../tcp_syscall_bad_arg_sendmsg-empty-iov.pkt      |    4 +
 .../tcp_user_timeout_user-timeout-probe.pkt        |    6 +-
 .../net/packetdrill/tcp_zerocopy_basic.pkt         |    2 +
 .../net/packetdrill/tcp_zerocopy_batch.pkt         |    2 +
 .../net/packetdrill/tcp_zerocopy_client.pkt        |    2 +
 .../net/packetdrill/tcp_zerocopy_closed.pkt        |    2 +
 .../net/packetdrill/tcp_zerocopy_epoll_edge.pkt    |    3 +
 .../packetdrill/tcp_zerocopy_epoll_exclusive.pkt   |    3 +
 .../net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt |    3 +
 .../packetdrill/tcp_zerocopy_fastopen-client.pkt   |    2 +
 .../packetdrill/tcp_zerocopy_fastopen-server.pkt   |    2 +
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt      |    2 +
 .../net/packetdrill/tcp_zerocopy_small.pkt         |    2 +
 tools/testing/selftests/net/rtnetlink.sh           |   20 +
 tools/testing/selftests/net/setup_loopback.sh      |  120 -
 tools/testing/selftests/net/setup_veth.sh          |   45 -
 tools/testing/selftests/net/so_txtime.c            |    2 +-
 tools/testing/selftests/net/tls.c                  |  141 +
 tools/testing/selftests/net/toeplitz.sh            |  199 --
 tools/testing/selftests/net/toeplitz_client.sh     |   28 -
 tools/testing/selftests/net/traceroute.sh          |  313 ++
 tools/testing/selftests/net/txtimestamp.c          |    2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |   28 +
 tools/testing/selftests/vsock/vmtest.sh            |  350 +-
 tools/testing/vsock/vsock_test.c                   |    7 +-
 1652 files changed, 58109 insertions(+), 24036 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/amd-xgbe.txt
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
 delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
 create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 Documentation/networking/devlink/stmmac.rst
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (68%)
 create mode 100644 drivers/dpll/zl3073x/out.c
 create mode 100644 drivers/dpll/zl3073x/out.h
 create mode 100644 drivers/dpll/zl3073x/ref.c
 create mode 100644 drivers/dpll/zl3073x/ref.h
 create mode 100644 drivers/dpll/zl3073x/synth.c
 create mode 100644 drivers/dpll/zl3073x/synth.h
 create mode 100644 drivers/net/can/dummy_can.c
 create mode 100644 drivers/net/dsa/lantiq/lantiq_gswip_common.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.h
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
 create mode 100644 drivers/net/phy/mdio-private.h
 create mode 100644 drivers/net/wireguard/generated/netlink.c
 create mode 100644 drivers/net/wireguard/generated/netlink.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852au.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c
 create mode 100644 include/linux/ieee80211-eht.h
 create mode 100644 include/linux/ieee80211-he.h
 create mode 100644 include/linux/ieee80211-ht.h
 create mode 100644 include/linux/ieee80211-mesh.h
 create mode 100644 include/linux/ieee80211-nan.h
 create mode 100644 include/linux/ieee80211-p2p.h
 create mode 100644 include/linux/ieee80211-s1g.h
 create mode 100644 include/linux/ieee80211-vht.h
 delete mode 100644 include/linux/platform_data/bcmgenet.h
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c
 create mode 100644 net/dsa/tag_yt921x.c
 create mode 100644 net/ethtool/mse.c
 create mode 100644 net/netfilter/nf_flow_table_path.c
 create mode 100644 net/smc/smc_hs_bpf.c
 create mode 100644 net/smc/smc_hs_bpf.h
 delete mode 100644 tools/net/ynl/samples/page-pool.c
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh
 create mode 100644 tools/net/ynl/ynltool/.gitignore
 create mode 100644 tools/net/ynl/ynltool/Makefile
 create mode 100644 tools/net/ynl/ynltool/json_writer.c
 create mode 100644 tools/net/ynl/ynltool/json_writer.h
 create mode 100644 tools/net/ynl/ynltool/main.c
 create mode 100644 tools/net/ynl/ynltool/main.h
 create mode 100644 tools/net/ynl/ynltool/page-pool.c
 create mode 100644 tools/net/ynl/ynltool/qstats.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
 rename tools/testing/selftests/{ => drivers}/net/gro.c (99%)
 create mode 100755 tools/testing/selftests/drivers/net/gro.py
 rename tools/testing/selftests/{net => drivers/net/hw}/toeplitz.c (88%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/toeplitz.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-ring.sh
 create mode 100755 tools/testing/selftests/drivers/net/ring_reconfig.py
 create mode 100644 tools/testing/selftests/net/af_unix/.gitignore
 create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
 delete mode 100755 tools/testing/selftests/net/gro.sh
 create mode 100755 tools/testing/selftests/net/lib/ksft_setup_loopback.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rto_synack_rto_max.pkt
 delete mode 100644 tools/testing/selftests/net/setup_loopback.sh
 delete mode 100644 tools/testing/selftests/net/setup_veth.sh
 delete mode 100755 tools/testing/selftests/net/toeplitz.sh
 delete mode 100755 tools/testing/selftests/net/toeplitz_client.sh

