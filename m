Return-Path: <netdev+bounces-111791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41B932A4F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CD31F22D71
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BD19DF94;
	Tue, 16 Jul 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1uH4qPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75D198E80;
	Tue, 16 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143233; cv=none; b=pKHuXLy2HQuyrd5iP4X4s96qsk1R7N/5tXPTX8Emi7SaUCHwPqG82xs4XNWgBDTzEDGGjVbI+fTjtigrHUfYbTcQO1r7f0Un71+tdmPncFkhl3tuYP7Q6uGMMn9WNPQERcOnaRvkkMLT0uDJAUuR5PMvvPTF5sVpyJU6+gflFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143233; c=relaxed/simple;
	bh=rFFNmZ5GGBEm2tA3D5vDv4QHwL4qCo0cgR0nnw+Y7fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fm62XphVrpPdrtMcFZwnZboUoDD1n9AoVwExdRlxXDkxUsfrFC9U4dGeDDBuhy6KTf6/h1Hkoe7IXa4EWumfm9eI+Xle5lTuDkqyFtylLbl/1Ke3QRlB3mM+zwIt5pFOqLowNdir5VN4xU6blFZF5JnAOw+/IJhzHDL794aswg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1uH4qPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217BEC116B1;
	Tue, 16 Jul 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721143232;
	bh=rFFNmZ5GGBEm2tA3D5vDv4QHwL4qCo0cgR0nnw+Y7fA=;
	h=From:To:Cc:Subject:Date:From;
	b=o1uH4qPSmYB46vEPiPyN4egxLIpyN8VeJp8g5L3BfXAuqudRZbmDcjUXurtuOPx33
	 MdnaflkuUq5k/7HAnK+Bv+0pnOLxHYZpJyTswHhRAm1v18dnXg3PBtI+0xq+B33R1J
	 SjwRvVctxouy+gpquxS/03RYuLrsOzOLEwLMKll+EAkC//TByMPL0bY6mrxHxNLKMu
	 3Qud/qz4EjJ4raFPWGvAVRmo2WBU6w3X9szZe81Su9jMrey7niDyDvqWFVW03A9o1R
	 kZdqNmsn96Eusb3DX+nwPw1ltK5FntAaryxlqv8F0+/93SNhIs27H0JZg7z6vSP3F8
	 Je4agLAnhO8wQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.11
Date: Tue, 16 Jul 2024 08:20:31 -0700
Message-ID: <20240716152031.1288409-1-kuba@kernel.org>
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

The following changes since commit 528dd46d0fc35c0176257a13a27d41e44fcc6cb3:

  Merge tag 'net-6.10-rc8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-12 18:33:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.11

for you to fetch changes up to 77ae5e5b00720372af2860efdc4bc652ac682696:

  eth: fbnic: Fix spelling mistake "tiggerring" -> "triggering" (2024-07-16 07:55:39 -0700)

----------------------------------------------------------------
Networking changes for 6.11. Not much excitement - a handful of large
patchsets (devmem among them) did not make it in time.

Core & protocols
----------------

 - Use local_lock in addition to local_bh_disable() to protect per-CPU
   resources in networking, a step closer for local_bh_disable() not
   to act as a big lock on PREEMPT_RT.

 - Use flex array for netdevice priv area, ensure its cache alignment.

 - Add a sysctl knob to allow user to specify a default rto_min at socket
   init time. Bit of a big hammer but multiple companies were
   independently carrying such patch downstream so clearly it's useful.

 - Support scheduling transmission of packets based on CLOCK_TAI.

 - Un-pin TCP TIMEWAIT timer to avoid it firing on CPUs later cordoned off
   using cpusets.

 - Support multiple L2TPv3 UDP tunnels using the same 5-tuple address.

 - Allow configuration of multipath hash seed, to both allow synchronizing
   hashing of two routers, and preventing partial accidental sync.

 - Improve TCP compliance with RFC 9293 for simultaneous connect().

 - Support sending NAT keepalives in IPsec ESP in UDP states. Userspace
   IKE daemon had to do this before, but the kernel can better keep
   track of it.

 - Support sending supervision HSR frames with MAC addresses stored in
   ProxyNodeTable when RedBox (i.e. HSR-SAN) is enabled.

 - Introduce IPPROTO_SMC for selecting SMC when socket is created.

 - Allow UDP GSO transmit from devices with no checksum offload.

 - openvswitch: add packet sampling via psample, separating the sampled
   traffic from "upcall" packets sent to user space for forwarding.

 - nf_tables: shrink memory consumption for transaction objects.

Things we sprinkled into general kernel code
--------------------------------------------

 - Power Sequencing subsystem (used by Qualcomm Bluetooth driver
   for QCA6390).

 - Add IRQ information in sysfs for auxiliary bus.

 - Introduce guard definition for local_lock.

 - Add aligned flavor of __cacheline_group_{begin, end}() markings for
   grouping fields in structures.

BPF
---

 - Notify user space (via epoll) when a struct_ops object is getting
   detached/unregistered.

 - Add new kfuncs for a generic, open-coded bits iterator.

 - Enable BPF programs to declare arrays of kptr, bpf_rb_root, and
   bpf_list_head.

 - Support resilient split BTF which cuts down on duplication and makes
   BTF as compact as possible WRT BTF from modules.

 - Add support for dumping kfunc prototypes from BTF which enables both
   detecting as well as dumping compilable prototypes for kfuncs.

 - riscv64 BPF JIT improvements in particular to add 12-argument support
   for BPF trampolines and to utilize bpf_prog_pack for the latter.

 - Add the capability to offload the netfilter flowtable in XDP layer
   through kfuncs.

Driver API
----------

 - Allow users to configure IRQ tresholds between which automatic IRQ
   moderation can choose.

 - Expand Power Sourcing (PoE) status with power, class and failure
   reason. Support setting power limits.

 - Track additional RSS contexts in the core, make sure configuration
   changes don't break them.

 - Support IPsec crypto offload for IPv6 ESP and IPv4 UDP-encapsulated ESP
   data paths.

 - Support updating firmware on SFP modules.

Tests and tooling
-----------------

 - mptcp: use net/lib.sh to manage netns.

 - TCP-AO and TCP-MD5: replace debug prints used by tests with
   tracepoints.

 - openvswitch: make test self-contained (don't depend on OvS CLI tools).

Drivers
-------

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
     - increase the max total outstanding PTP TX packets to 4
     - add timestamping statistics support
     - implement netdev_queue_mgmt_ops
     - support new RSS context API
   - Intel (100G, ice, idpf):
     - implement FEC statistics and dumping signal quality indicators
     - support E825C products (with 56Gbps PHYs)
   - nVidia/Mellanox:
     - support HW-GRO
     - mlx4/mlx5: support per-queue statistics via netlink
     - obey the max number of EQs setting in sub-functions
   - AMD/Solarflare:
     - support new RSS context API
   - AMD/Pensando:
     - ionic: rework fix for doorbell miss to lower overhead
       and skip it on new HW
   - Wangxun:
     - txgbe: support Flow Director perfect filters

 - Ethernet NICs consumer, embedded and virtual:
   - Add driver for Tehuti Networks TN40xx chips
   - Add driver for Meta's internal NIC chips
   - Add driver for Ethernet MAC on Airoha EN7581 SoCs
   - Add driver for Renesas Ethernet-TSN devices
   - Google cloud vNIC:
     - flow steering support
   - Microsoft vNIC:
     - support page sizes other than 4KB on ARM64
   - vmware vNIC:
     - support latency measurement (update to version 9)
   - VirtIO net:
     - support for Byte Queue Limits
     - support configuring thresholds for automatic IRQ moderation
     - support for AF_XDP Rx zero-copy
   - Synopsys (stmmac):
     - support for STM32MP13 SoC
     - let platforms select the right PCS implementation
   - TI:
     - icssg-prueth: add multicast filtering support
     - icssg-prueth: enable PTP timestamping and PPS
   - Renesas:
     - ravb: improve Rx performance 30-400% by using page pool,
       theaded NAPI and timer-based IRQ coalescing
     - ravb: add MII support for R-Car V4M
   - Cadence (macb):
     - macb: add ARP support to Wake-On-LAN
   - Cortina:
     - use phylib for RX and TX pause configuration

 - Ethernet switches:
   - nVidia/Mellanox:
     - support configuration of multipath hash seed
     - report more accurate max MTU
     - use page_pool to improve Rx performance
   - MediaTek:
     - mt7530: add support for bridge port isolation
   - Qualcomm:
     - qca8k: add support for bridge port isolation
   - Microchip:
     - lan9371/2: add 100BaseTX PHY support
   - NXP:
     - vsc73xx: implement VLAN operations

 - Ethernet PHYs:
   - aquantia: enable support for aqr115c
   - aquantia: add support for PHY LEDs
   - realtek: add support for rtl8224 2.5Gbps PHY
   - xpcs: add memory-mapped device support
   - add BroadR-Reach link mode and support in Broadcom's PHY driver

 - CAN:
   - add document for ISO 15765-2 protocol support
   - mcp251xfd: workaround for erratum DS80000789E, use timestamps
     to catch when device returns incorrect FIFO status

 - WiFi:
   - mac80211/cfg80211:
     - parse Transmit Power Envelope (TPE) data in mac80211 instead of
       in drivers
     - improvements for 6 GHz regulatory flexibility
     - multi-link improvements
     - support multiple radios per wiphy
     - remove DEAUTH_NEED_MGD_TX_PREP flag
   - Intel (iwlwifi):
     - bump FW API to 91 for BZ/SC devices
     - report 64-bit radiotap timestamp
     - enable P2P low latency by default
     - handle Transmit Power Envelope (TPE) advertised by AP
     - remove support for older FW for new devices
     - fast resume (keeping the device configured)
     - mvm: re-enable Multi-Link Operation (MLO)
     - aggregation (A-MSDU) optimizations
   - MediaTek (mt76):
     - mt7925 Multi-Link Operation (MLO) support
   - Qualcomm (ath10k):
     - LED support for various chipsets
   - Qualcomm (ath12k):
     - remove unsupported Tx monitor handling
     - support channel 2 in 6 GHz band
     - support Spatial Multiplexing Power Save (SMPS) in 6 GHz band
     - supprt multiple BSSID (MBSSID) and Enhanced Multi-BSSID
       Advertisements (EMA)
     - support dynamic VLAN
     - add panic handler for resetting the firmware state
     - DebugFS support for datapath statistics
     - WCN7850: support for Wake on WLAN
   - Microchip (wilc1000):
     - read MAC address during probe to make it visible to user space
     - suspend/resume improvements
   - TI (wl18xx):
     - support newer firmware versions
   - RealTek (rtw89):
     - preparation for RTL8852BE-VT support
     - Wake on WLAN support for WiFi 6 chips
     - 36-bit PCI DMA support
   - RealTek (rtlwifi):
     - RTL8192DU support
   - Broadcom (brcmfmac):
     - Management Frame Protection support (to enable WPA3)

 - Bluetooth:
   - qualcomm: use the power sequencer for QCA6390
   - btusb: mediatek: add ISO data transmission functions
   - hci_bcm4377: add BCM4388 support
   - btintel: add support for BlazarU core
   - btintel: add support for Whale Peak2
   - btnxpuart: add support for AW693 A1 chipset
   - btnxpuart: add support for IW615 chipset
   - btusb: add Realtek RTL8852BE support ID 0x13d3:0x3591

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (3):
      wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
      wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
      wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()

Aaron Conole (10):
      selftests: openvswitch: Support explicit tunnel port creation.
      selftests: openvswitch: Refactor actions parsing.
      selftests: openvswitch: Add set() and set_masked() support.
      selftests: openvswitch: Add support for tunnel() key.
      selftests: openvswitch: Support implicit ipv6 arguments.
      selftests: net: Use the provided dpctl rather than the vswitchd for tests.
      selftests: net: add config for openvswitch
      selftests: openvswitch: Bump timeout to 15 minutes.
      selftests: openvswitch: Attempt to autoload module.
      selftests: openvswitch: Be more verbose with selftest debugging.

Abhishek Chauhan (4):
      net: Rename mono_delivery_time to tstamp_type for scalabilty
      net: Add additional bit to support clockid_t timestamp type
      selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets
      net: validate SO_TXTIME clockid coming from userspace

Aditya Kumar Singh (3):
      wifi: ath12k: fix per pdev debugfs registration
      wifi: ath12k: unregister per pdev debugfs
      wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry

Adrian Moreno (12):
      net: psample: add user cookie
      net: sched: act_sample: add action cookie to sample
      net: psample: skip packet copy if no listeners
      net: psample: allow using rate as probability
      net: openvswitch: add psample action
      net: openvswitch: store sampling probability in cb.
      selftests: openvswitch: add psample action
      selftests: openvswitch: add userspace parsing
      selftests: openvswitch: parse trunc action
      selftests: openvswitch: add psample test
      net: psample: fix flag being set in wrong skb
      selftests: openvswitch: retry instead of sleep

Ajay Singh (2):
      wifi: wilc1000: read MAC address from fuse at probe
      wifi: wilc1000: disable power sequencer

Ajith C (1):
      wifi: ath12k: fix firmware crash due to invalid peer nss

Alan Maguire (19):
      kbuild, bpf: Use test-ge check for v1.25-only pahole
      selftests/bpf: Add btf_field_iter selftests
      libbpf: Add btf__distill_base() creating split BTF with distilled base BTF
      selftests/bpf: Test distilled base, split BTF generation
      libbpf: Split BTF relocation
      selftests/bpf: Extend distilled BTF tests to cover BTF relocation
      resolve_btfids: Handle presence of .BTF.base section
      libbpf: BTF relocation followup fixing naming, loop logic
      module, bpf: Store BTF base pointer in struct module
      libbpf: Split field iter code into its own file kernel
      libbpf,bpf: Share BTF relocate-related code with kernel
      kbuild,bpf: Add module-specific pahole flags for distilled base BTF
      selftests/bpf: Add kfunc_call test for simple dtor in bpf_testmod
      bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES] is undefined
      libbpf: Fix clang compilation error in btf_relocate.c
      libbpf: Fix error handling in btf__distill_base()
      selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m
      bpf: annotate BTF show functions with __printf
      bpf: Eliminate remaining "make W=1" warnings in kernel/bpf/btf.o

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: remove redundant device name setup

Aleksandr Mishin (1):
      wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()

Alex Bee (1):
      wifi: brcmfmac: of: Support interrupts-extended

Alexander Duyck (15):
      PCI: Add Meta Platforms vendor ID
      eth: fbnic: Add scaffolding for Meta's NIC driver
      eth: fbnic: Allocate core device specific structures and devlink interface
      eth: fbnic: Add register init to set PCIe/Ethernet device config
      eth: fbnic: Add message parsing for FW messages
      eth: fbnic: Add FW communication mechanism
      eth: fbnic: Allocate a netdevice and napi vectors with queues
      eth: fbnic: Implement Tx queue alloc/start/stop/free
      eth: fbnic: Implement Rx queue alloc/start/stop/free
      eth: fbnic: Add initial messaging to notify FW of our presence
      eth: fbnic: Add link detection
      eth: fbnic: Add basic Tx handling
      eth: fbnic: Add basic Rx handling
      eth: fbnic: Add L2 address programming
      eth: fbnic: Write the TCAM tables used for RSS control and Rx to host

Alexander Lobakin (15):
      cache: add __cacheline_group_{begin, end}_aligned() (+ couple more)
      page_pool: use __cacheline_group_{begin, end}_aligned()
      libeth: add cacheline / struct layout assertion helpers
      idpf: stop using macros for accessing queue descriptors
      idpf: split &idpf_queue into 4 strictly-typed queue structures
      idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
      idpf: strictly assert cachelines of queue and queue vector structures
      idpf: merge singleq and splitq &net_device_ops
      idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
      idpf: reuse libeth's definitions of parsed ptype structures
      idpf: remove legacy Page Pool Ethtool stats
      libeth: support different types of buffers for Rx
      idpf: convert header split mode to libeth + napi_build_skb()
      idpf: use libeth Rx buffer management for payload buffer
      netdevice: define and allocate &net_device _properly_

Alexander Sverdlin (3):
      net: dsa: lan9303: imply SMSC_PHY
      net: ethernet: ti: am65-cpsw-nuss: rename phy_node -> port_np
      net: ethernet: ti: am65-cpsw-nuss: populate netdev of_node

Alexei Starovoitov (14):
      Merge branch 'enable-bpf-programs-to-declare-arrays-of-kptr-bpf_rb_root-and-bpf_list_head'
      Merge branch 'bpf-support-dumping-kfunc-prototypes-from-btf'
      Merge branch 'fixes-for-kfunc-prototype-generation'
      Merge branch 'bpf-make-trusted-args-nullable'
      bpf: Relax tuple len requirement for sk helpers.
      bpf: Track delta between "linked" registers.
      bpf: Support can_loop/cond_break on big endian
      selftests/bpf: Add tests for add_const
      Merge branch 'bpf-verifier-correct-tail_call_reachable-for-bpf-prog'
      Merge branch 'fix-compiler-warnings-looking-for-suggestions'
      Merge branch 'use-network-helpers-part-7'
      Merge branch 'small-api-fix-for-bpf_wq'
      Merge branch 'fix-libbpf-bpf-skeleton-forward-backward-compat'
      Merge branch 'use-overflow-h-helpers-to-check-for-overflows'

Alexey Kodanev (1):
      bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

Alexis Lothoré (10):
      wifi: wilc1000: set net device registration as last step during interface creation
      wifi: wilc1000: register net device only after bus being fully initialized
      wifi: wilc1000: set wilc_set_mac_address parameter as const
      wifi: wilc1000: add function to read mac address from eFuse
      wifi: wilc1000: make sdio deinit function really deinit the sdio card
      wifi: wilc1000: let host->chip suspend/resume notifications manage chip wake/sleep
      wifi: wilc1000: do not keep sdio bus claimed during suspend/resume
      wifi: wilc1000: move sdio suspend method next to resume and pm ops definition
      wifi: wilc1000: remove suspend/resume from cfg80211 part
      wifi: wilc1000: disable SDIO func IRQ before suspend

Aloka Dixit (9):
      wifi: ath12k: advertise driver capabilities for MBSSID and EMA
      wifi: ath12k: configure MBSSID params in vdev create/start
      wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
      wifi: ath12k: create a structure for WMI vdev up parameters
      wifi: ath12k: configure MBSSID parameters in AP mode
      wifi: ath12k: refactor arvif security parameter configuration
      wifi: ath12k: add MBSSID beacon support
      wifi: ath12k: add EMA beacon support
      wifi: ath12k: skip sending vdev down for channel switch

Amit Cohen (15):
      mlxsw: port: Edit maximum MTU value
      mlxsw: Adjust MTU value to hardware check
      mlxsw: spectrum: Set more accurate values for netdevice min/max MTU
      mlxsw: Use the same maximum MTU value throughout the driver
      selftests: forwarding: Add test for minimum and maximum MTU
      mlxsw: pci: Split NAPI setup/teardown into two steps
      mlxsw: pci: Store CQ pointer as part of RDQ structure
      mlxsw: pci: Initialize page pool per CQ
      mlxsw: pci: Use page pool for Rx buffers allocation
      mlxsw: pci: Optimize data buffer access
      mlxsw: pci: Do not store SKB for RDQ elements
      mlxsw: pci: Use napi_consume_skb() to free SKB as part of Tx completion
      mlxsw: pci: Store number of scatter/gather entries for maximum packet size
      mlxsw: pci: Use fragmented buffers
      selftests: forwarding: devlink_lib: Wait for udev events after reloading

Andreas Ziegler (1):
      libbpf: Add NULL checks to bpf_object__{prev_map,next_map}

Andrei Otcheretianski (1):
      wifi: iwlwifi: mvm: Don't set NO_HT40+/- flags on 6 GHz band

Andrii Batyiev (1):
      wifi: iwlegacy: do not skip frames with bad FCS

Andrii Nakryiko (14):
      Merge branch 'bpf-add-a-generic-bits-iterator'
      libbpf: keep FD_CLOEXEC flag when dup()'ing FD
      libbpf: Add BTF field iterator
      libbpf: Make use of BTF field iterator in BPF linker code
      libbpf: Make use of BTF field iterator in BTF handling code
      bpftool: Use BTF field iterator in btfgen
      libbpf: Remove callback-based type/string BTF field visitor helpers
      Merge branch 'bpf-support-resilient-split-btf'
      bpftool: Allow compile-time checks of BPF map auto-attach support in skeleton
      Merge branch 'regular-expression-support-for-test-output-matching'
      Merge branch 'bpf-resilient-split-btf-followups'
      bpftool: improve skeleton backwards compat with old buggy libbpfs
      libbpf: fix BPF skeleton forward/backward compat handling
      libbpf: improve old BPF skeleton handling for map auto-attach

Andy Shevchenko (4):
      net: dsa: hellcreek: Replace kernel.h with what is used
      net: intel: Use *-y instead of *-objs in Makefile
      can: mcp251x: Fix up includes
      can: sja1000: plx_pci: Reuse predefined CTI subvendor ID

Anil Samal (3):
      ice: Extend Sideband Queue command to support flags
      ice: Implement driver functionality to dump fec statistics
      ice: Implement driver functionality to dump serdes equalizer values

Anjaneyulu (2):
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v11
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v12

Anshumali Gaur (1):
      octeontx2-af: Add debugfs support to dump NIX TM topology

Antoine Tenart (1):
      libbpf: Skip base btf sanity checks

Antony Antony (2):
      xfrm: Fix input error path memory access
      xfrm: Log input direction mismatch error in one place

Arend van Spriel (1):
      wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

Arnd Bergmann (2):
      ethernet: octeontx2: avoid linking objects into multiple modules
      hns3: avoid linking objects into multiple modules

Artem Savkov (1):
      bpftool: Fix make dependencies for vmlinux.h

Asbjørn Sloth Tønnesen (18):
      flow_offload: add encapsulation control flag helpers
      sfc: use flow_rule_is_supp_enc_control_flags()
      net/mlx5e: flower: validate encapsulation control flags
      nfp: flower: validate encapsulation control flags
      ice: flower: validate encapsulation control flags
      net/sched: flower: refactor control flag definitions
      doc: netlink: specs: tc: describe flower control flags
      net/sched: flower: define new tunnel flags
      net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
      net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
      flow_dissector: prepare for encapsulated control flags
      flow_dissector: set encapsulated control flags from tun_flags
      net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
      net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
      doc: netlink: specs: tc: flower: add enc-flags
      flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
      flow_dissector: set encapsulation control flags for non-IP
      net/sched: cls_flower: propagate tca[TCA_OPTIONS] to NL_REQ_ATTR_CHECK

Avraham Stern (10):
      wifi: iwlwifi: mvm: allow UAPSD when in SCM
      wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time
      wifi: iwlwifi: mvm: add an option to use ptp clock for rx timestamp
      wifi: iwlwifi: mvm: initiator: move setting target flags into a function
      wifi: iwlwifi: mvm: initiator: move setting the sta_id into a function
      wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters
      wifi: iwlwifi: mvm: add support for version 14 of the range request command
      wifi: iwlwifi: mvm: add support for version 10 of the responder config command
      wifi: nl80211: remove the FTMs per burst limit for NDP ranging
      wifi: mac80211_hwsim: add 320 MHz to hwsim channel widths

Avri Altman (1):
      wifi: iwlwifi: mvm: Enable p2p low latency

Baochen Qiang (22):
      wifi: ath12k: fix Smatch warnings on ath12k_core_suspend()
      wifi: ath11k: refactor setting country code logic
      wifi: ath11k: restore country code during resume
      wifi: ath11k: fix wrong definition of CE ring's base address
      wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
      wifi: ath12k: fix wrong definition of CE ring's base address
      wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()
      wifi: ath12k: do not process consecutive RDDM event
      wifi: ath12k: add panic handler
      wifi: ath12k: fix ACPI warning when resume
      wifi: ath11k: fix RCU documentation in ath11k_mac_op_ipv6_changed()
      wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers
      wifi: cfg80211: fix typo in cfg80211_calculate_bitrate_he()
      wifi: cfg80211: handle 2x996 RU allocation in cfg80211_calculate_bitrate_he()
      wifi: ath12k: add ATH12K_DBG_WOW log level
      wifi: ath12k: implement WoW enable and wakeup commands
      wifi: ath12k: add basic WoW functionalities
      wifi: ath12k: add WoW net-detect functionality
      wifi: ath12k: implement hardware data filter
      wifi: ath12k: support ARP and NS offload
      wifi: ath12k: support GTK rekey offload
      wifi: ath12k: handle keepalive during WoWLAN suspend and resume

Bartosz Golaszewski (17):
      dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
      dt-bindings: net: wireless: describe the ath12k PCI module
      net: stmmac: unexport stmmac_pltfr_init/exit()
      net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
      net: stmmac: qcom-ethqos: enable SGMII loopback during DMA reset on sa8775p-ride-r3
      net: phy: aquantia: rename and export aqr107_wait_reset_complete()
      net: phy: aquantia: wait for FW reset before checking the vendor ID
      net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values
      net: phy: aquantia: add support for aqr115c
      dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
      Bluetooth: qca: use the power sequencer for QCA6390
      Bluetooth: qca: don't disable power management for QCA6390
      dt-bindings: bluetooth: qualcomm: describe the inputs from PMU for wcn7850
      Bluetooth: hci_qca: schedule a devm action for disabling the clock
      Bluetooth: hci_qca: unduplicate calls to hci_uart_register_device()
      Bluetooth: hci_qca: make pwrseq calls the default if available
      Bluetooth: hci_qca: use the power sequencer for wcn7850 and wcn6855

Benjamin Berg (10):
      wifi: iwlwifi: mvm: use vif P2P type helper
      wifi: cfg80211: reject non-conformant 6 GHz center frequencies
      wifi: iwlwifi: mvm: don't log error for failed UATS table read
      wifi: iwlwifi: return a new allocation for hdr page space
      wifi: iwlwifi: map entire SKB when sending AMSDUs
      wifi: iwlwifi: keep the TSO and workaround pages mapped
      wifi: iwlwifi: use already mapped data when TXing an AMSDU
      wifi: iwlwifi: keep BHs disabled when TXing from reclaim
      wifi: iwlwifi: release TXQ lock during reclaim
      wifi: iwlwifi: correctly reference TSO page information

Benjamin Tissoires (2):
      bpf: helpers: fix bpf_wq_set_callback_impl signature
      selftests/bpf: amend for wrong bpf_wq_set_callback_impl signature

Bitterblue Smith (15):
      wifi: rtw88: usb: Simplify rtw_usb_write_data
      wifi: rtw88: usb: Fix disconnection after beacon loss
      wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
      wifi: rtlwifi: Add rtl8192du/table.{c,h}
      wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
      wifi: rtlwifi: Add rtl8192du/hw.{c,h}
      wifi: rtlwifi: Add rtl8192du/phy.{c,h}
      wifi: rtlwifi: Add rtl8192du/trx.{c,h}
      wifi: rtlwifi: Add rtl8192du/rf.{c,h}
      wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
      wifi: rtlwifi: Add rtl8192du/dm.{c,h}
      wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
      wifi: rtlwifi: Add rtl8192du/sw.c
      wifi: rtlwifi: Enable the new rtl8192du driver
      wifi: rtw88: usb: Further limit the TX aggregation

Brad Cowie (2):
      net: netfilter: Make ct zone opts configurable for bpf ct helpers
      selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs

Breno Leitao (22):
      wifi: wil6210: Do not use embedded netdev in wil6210_priv
      wifi: rtw89: Un-embed dummy device
      wifi: rtw88: Un-embed dummy device
      wifi: ath12k: allocate dummy net_device dynamically
      netconsole: Do not shutdown dynamic configuration if cmdline is invalid
      openvswitch: Move stats allocation to core
      openvswitch: Remove generic .ndo_get_stats64
      ip_tunnel: Move stats allocation to core
      wifi: mac80211: Move stats allocation to core
      wifi: mac80211: Remove generic .ndo_get_stats64
      wifi: mt76: un-embedd netdev from mt76_dev
      net: thunderx: Unembed netdev structure
      crypto: caam: Avoid unused imx8m_machine_match variable
      crypto: caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST
      crypto: caam: Unembed net_dev structure from qi
      crypto: caam: Unembed net_dev structure in dpaa2
      net: netconsole: Remove unnecessary cast from bool
      net: netconsole: Eliminate redundant setting of enabled field
      net: dpaa: Fix compilation Warning
      net: netconsole: Disable target before netpoll cleanup
      soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
      virtio_net: Fix napi_skb_cache_put warning

Brett Creeley (6):
      ionic: Pass ionic_txq_desc to ionic_tx_tso_post
      ionic: Mark error paths in the data path as unlikely
      ionic: Use netdev_name() function instead of netdev->name
      ionic: Keep interrupt affinity up to date
      ionic: Use an u16 for rx_copybreak
      ionic: Only run the doorbell workaround for certain asic_type

Chaya Rachel Ivgi (1):
      wifi: iwlwifi: remove redundant reading from NVM file

Chen Hanxiao (1):
      net: bridge: fix an inconsistent indentation

Chen Ni (2):
      wifi: ipw2x00: Use kzalloc() instead of kmalloc()/memset()
      net/sched: act_skbmod: convert comma to semicolon

Chengen Du (1):
      af_packet: Handle outgoing VLAN packets without hardware offloading

Chih-Kang Chang (7):
      wifi: rtw89: wow: append security header offset for different cipher
      wifi: rtw89: wow: update WoWLAN reason register for different FW
      wifi: rtw89: wow: update config mac for 802.11ax chip
      wifi: rtw89: wow: fix GTK offload H2C skbuff issue
      wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware
      wifi: rtw89: wow: enable beacon filter after swapping firmware
      wifi: rtw89: add polling for LPS H2C to ensure FW received

Ching-Te Ku (1):
      wifi: rtw89: coex: Add coexistence policy for hardware scan

Chris Lew (1):
      net: qrtr: ns: Ignore ENODEV failures in ns

Chris Lu (8):
      Bluetooth: btusb: mediatek: remove the unnecessary goto tag
      Bluetooth: btusb: mediatek: return error for failed reg access
      Bluetooth: btmtk: rename btmediatek_data
      Bluetooth: btusb: add callback function in btusb suspend/resume
      Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
      Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
      Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
      Bluetooth: btusb: mediatek: add ISO data transmission functions

Chris Mi (1):
      net/mlx5: CT: Separate CT and CT-NAT tuple entries

Chris Packham (3):
      net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
      net: phy: realtek: add support for rtl8224 2.5Gbps PHY
      dt-bindings: net: dsa: mediatek,mt7530: Minor wording fixes

Christian Eggers (1):
      dsa: lan9303: consistent naming for PHY address parameter

Christian Marangi (1):
      net: phy: aquantia: move priv and hw stat to header

Christophe JAILLET (6):
      devlink: Constify the 'table_ops' parameter of devl_dpipe_table_register()
      mlxsw: spectrum_router: Constify struct devlink_dpipe_table_ops
      net: microchip: Constify struct vcap_operations
      can: m_can: Constify struct m_can_ops
      llc: Constify struct llc_conn_state_trans
      llc: Constify struct llc_sap_state_trans

Christophe Roullier (7):
      dt-bindings: net: add STM32MP13 compatible in documentation for stm32
      net: stmmac: dwmac-stm32: Mask support for PMCR configuration
      net: stmmac: dwmac-stm32: add management of stm32mp13 for stm32
      dt-bindings: net: add STM32MP25 compatible in documentation for stm32
      net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32
      net: stmmac: dwmac-stm32: Add test to verify if ETHCK is used before checking clk rate
      net: stmmac: dwmac-stm32: update err status in case different of stm32mp13

Colin Ian King (2):
      net: pse-pd: pd692x0: Fix spelling mistake "availables" -> "available"
      eth: fbnic: Fix spelling mistake "tiggerring" -> "triggering"

Cosmin Ratiu (2):
      net/mlx5: Correct TASR typo into TSAR
      net/mlx5e: CT: Initialize err to 0 to avoid warning

Csókás, Bence (1):
      net: fec: Fix FEC_ECR_EN1588 being cleared on link-down

Cupertino Miranda (2):
      selftests/bpf: Support checks against a regular expression
      selftests/bpf: Match tests against regular expression

D. Wythe (3):
      net/smc: refactoring initialization of smc sock
      net/smc: expose smc proto operations
      net/smc: Introduce IPPROTO_SMC

Dan Carpenter (4):
      dmaengine: ti: k3-udma-glue: clean up return in k3_udma_glue_rx_get_irq()
      atm: clean up a put_user() calls
      bpf: Remove unnecessary loop in task_file_seq_get_next()
      Bluetooth: MGMT: Uninitialized variable in load_conn_param()

Daniel Borkmann (1):
      selftests/bpf: DENYLIST.aarch64: Skip fexit_sleep again

Daniel Gabay (2):
      wifi: iwlwifi: fix iwl_mvm_get_valid_rx_ant()
      wifi: iwlwifi: remove MVM prefix from scan API

Daniel Golle (3):
      net: phy: aquantia: add support for PHY LEDs
      net: ethernet: mediatek: Allow gaps in MAC allocation
      net: ethernet: mtk_eth_soc: implement .{get,set}_pauseparam ethtool ops

Daniel Jurgens (4):
      net/mlx5: IFC updates for SF max IO EQs
      net/mlx5: Set sf_eq_usage for SF max EQs
      net/mlx5: Set default max eqs for SFs
      net/mlx5: Use set number of max EQs

Daniel Xu (14):
      kbuild: bpf: Tell pahole to DECL_TAG kfuncs
      bpf: selftests: Fix bpf_iter_task_vma_new() prototype
      bpf: selftests: Fix fentry test kfunc prototypes
      bpf: selftests: Fix bpf_cpumask_first_zero() kfunc prototype
      bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
      bpf: Make bpf_session_cookie() kfunc return long *
      bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
      bpf: verifier: Relax caller requirements for kfunc projection type args
      bpf: treewide: Align kfunc signatures to prog point-of-view
      bpf: selftests: nf: Opt out of using generated kfunc prototypes
      bpf: selftests: xfrm: Opt out of using generated kfunc prototypes
      bpftool: Support dumping kfunc prototypes from BTF
      bpf: Fix bpf_dynptr documentation comments
      bpf: selftests: Do not use generated kfunc prototypes for arena progs

Danielle Ratson (8):
      ethtool: Add an interface for flashing transceiver modules' firmware
      ethtool: Add flashing transceiver modules' firmware notifications ability
      ethtool: Veto some operations during firmware flashing process
      net: sfp: Add more extended compliance codes
      ethtool: cmis_cdb: Add a layer for supporting CDB commands
      ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
      ethtool: Add ability to flash transceiver modules' firmware
      net: ethtool: Monotonically increase the message sequence number

Dave Thaler (7):
      bpf, docs: Move sentence about returning R0 to abi.rst
      bpf, docs: Use RFC 2119 language for ISA requirements
      bpf, docs: clarify sign extension of 64-bit use of 32-bit imm
      bpf, docs: Add table captions
      bpf, docs: Clarify call local offset
      bpf, docs: Fix instruction.rst indentation
      bpf, docs: Address comments from IETF Area Directors

David Christensen (1):
      ionic: advertise 52-bit addressing limitation for MSI-X

David S. Miller (29):
      Merge branch 'xilinx-clock-support'
      Merge branch 'net-smc-snd_buf-rcv_buf'
      Merge branch 'Felix-DSA-probing-cleanup'
      Merge branch 'devlink-const'
      Merge branch 'tcp-rto-min-us'
      Merge branch 'mlxsw-acl-fixes'
      Merge branch 'tcp-up-pin-tw-timer'
      Merge branch 'rtnetlink-rtnl_lock'
      Merge branch 'fix-changing-dsa-conduit'
      Merge branch 'tcp-ao-md5-racepoits'
      Merge branch 'mlx5-genl-queue-stats'
      Merge branch 'net-smc-IPPROTO_SMC'
      Merge branch 'am65x-ptp'
      Merge branch 'net-drop-rx-socket-tracepoint'
      Merge branch 'net-cleanup-arc-emac'
      Merge branch 'bnxt_en-netdev_queue_mgmt_ops'
      Merge branch 'l2tp-sk_user_data'
      Merge branch 'net-mscc-miim-switch-reset'
      Merge branch 'qca8k-cleanup-and-port-isolation'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-flash-modees-firmware' into main
      Merge branch 'net-selftests-mirroring-cleanup' into main
      Merge branch 'tcp_metrics-netlink-specs' into main
      Merge tag 'nf-next-24-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next into main
      Merge branch 'bnxt_en-ptp' into main
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue into main
      Merge branch 'pcs-xpcs-mmap' into main
      Merge branch 'aquantia-phy-aqr115c' into main
      Merge branch 'main' of ra.kernel.org:/pub/scm/linux/kernel/git/davem/net into main

David Wei (5):
      page_pool: remove WARN_ON() with OR
      bnxt_en: split rx ring helpers out from ring helpers
      bnxt_en: implement netdev_queue_mgmt_ops
      page_pool: export page_pool_disable_direct_recycling()
      bnxt_en: unlink page pool when stopping Rx queue

Davide Caratti (3):
      flow_dissector: add support for tunnel control flags
      net/sched: cls_flower: add support for matching tunnel control flags
      mptcp: refer to 'MPTCP' socket in comments

Deren Wu (5):
      wifi: mt76: mt792x: add struct mt792x_bss_conf
      wifi: mt76: mt792x: add struct mt792x_link_sta
      wifi: mt76: mt792x: add struct mt792x_chanctx
      wifi: mt76: mt7925: support for split bss_info_changed method
      wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS

Dinesh Karthikeyan (6):
      wifi: ath12k: Add support to enable debugfs_htt_stats
      wifi: ath12k: Add htt_stats_dump file ops support
      wifi: ath12k: Add support to parse requested stats_type
      wifi: ath12k: Support Transmit Scheduler stats
      wifi: ath12k: Support pdev error stats
      wifi: ath12k: Support TQM stats

Diogo Ivo (5):
      net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
      net: ti: icss-iep: Remove spinlock-based synchronization
      dt-bindings: net: Add IEP interrupt
      net: ti: icss-iep: Enable compare events
      arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices

Dmitry Antipov (4):
      wifi: rt2x00: remove unused delayed work data from link description
      wifi: cfg80211: use __counted_by where appropriate
      Bluetooth: hci_core, hci_sync: cleanup struct discovery_state
      Bluetooth: hci_core: cleanup struct hci_dev

Dmitry Safonov (6):
      net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs
      net/tcp: Add a helper tcp_ao_hdr_maclen()
      net/tcp: Move tcp_inbound_hash() from headers
      net/tcp: Add tcp-md5 and tcp-ao tracepoints
      net/tcp: Remove tcp_hash_fail()
      Documentation/tcp-ao: Add a few lines on tracepoints

Donald Hunter (4):
      doc: netlink: Fix generated .rst for multi-line docs
      doc: netlink: Don't 'sanitize' op docstrings in generated .rst
      doc: netlink: Fix formatting of op flags in generated .rst
      doc: netlink: Fix op pre and post fields in generated .rst

Donglin Peng (1):
      libbpf: Checking the btf_type kind when fixing variable offsets

Douglas Anderson (2):
      r8152: If inaccessible at resume time, issue a reset
      r8152: Wake up the system if the we need a reset

Dr. David Alan Gilbert (15):
      mISDN: remove unused struct 'bf_ctx'
      net: ethernet: starfire: remove unused structs
      net: ethernet: liquidio: remove unused structs
      net: ethernet: mlx4: remove unused struct 'mlx4_port_config'
      net: ethernet: 8390: ne2k-pci: remove unused struct 'ne2k_pci_card'
      net: usb: remove unused structs 'usb_context'
      wifi: brcm80211: remove unused structs
      selftests/bpf: Remove unused struct 'scale_test_def'
      selftests/bpf: Remove unused 'key_t' structs
      selftests/bpf: Remove unused struct 'libcap'
      net: caif: remove unused structs
      net: ethtool: remove unused struct 'cable_test_tdr_req_info'
      can: mscan: remove unused struct 'mscan_state'
      Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
      Bluetooth: iso: remove unused struct 'iso_list_data'

Dragos Tatulea (10):
      net/mlx5e: SHAMPO, Fix incorrect page release
      net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
      net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
      net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
      net/mlx5e: SHAMPO, Simplify header page release in teardown
      net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
      net/mlx5e: SHAMPO, Make GRO counters more precise
      net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
      net/mlx5e: SHAMPO, Coalesce skb fragments to page size
      net/mlx5e: SHAMPO, Add missing aggregate counter

Easwar Hariharan (1):
      sfc: falcon: Make I2C terminology more inclusive

Eduard Zingerman (1):
      libbpf: Make btf_parse_elf process .BTF.base transparently

Edward Cree (10):
      net: move ethtool-related netdev state into its own struct
      net: ethtool: attach an XArray of custom RSS contexts to a netdevice
      net: ethtool: record custom RSS contexts in the XArray
      net: ethtool: let the core choose RSS context IDs
      net: ethtool: add an extack parameter to new rxfh_context APIs
      net: ethtool: add a mutex protecting RSS contexts
      sfc: use new rxfh_context API
      net: ethtool: use the tracking array for get_rxfh on custom RSS contexts
      sfc: remove get_rxfh_context dead code
      ethtool: move firmware flashing flag to struct ethtool_netdev_state

Elad Yifee (2):
      net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
      net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices

Elliot Ayrey (1):
      net: bridge: mst: Check vlan state for egress decision

Emmanuel Grumbach (13):
      wifi: iwlwifi: mvm: simplify the uAPSD coexistence limitation code
      wifi: iwlwifi: always print the firmware version in hex
      wifi: iwlwifi: mvm: leave a print in the logs when we call fw_nmi()
      wifi: iwlwifi: kill iwl-eeprom-read
      wifi: iwlwifi: move code from iwl-eeprom-parse to dvm
      wifi: cfg80211: honor WIPHY_FLAG_SPLIT_SCAN_6GHZ in cfg80211_conn_scan
      wifi: mac80211: inform the low level if drv_stop() is a suspend
      wifi: iwlwifi: pcie: fix a few legacy register accesses for new devices
      wifi: iwlwifi: support fast resume
      wifi: iwlwifi: don't assume op_mode_nic_config exists
      wifi: iwlwifi: trans: remove unused status bits
      wifi: iwlwifi: update the BA notification API
      wifi: iwlwifi: mvm: don't send an ROC command with max_delay = 0

En-Wei Wu (1):
      wifi: virt_wifi: avoid reporting connection success with wrong SSID

Eric Dumazet (12):
      tcp: add tcp_done_with_error() helper
      tcp: fix race in tcp_write_err()
      tcp: fix races in tcp_abort()
      tcp: fix races in tcp_v[46]_err()
      tcp: annotate data-races around tw->tw_ts_recent and tw->tw_ts_recent_stamp
      net: use unrcu_pointer() helper
      inet: remove (struct uncached_list)->quarantine
      tcp: small changes in reqsk_put() and reqsk_free()
      tcp: move inet_reqsk_alloc() close to inet_reqsk_clone()
      tcp: move reqsk_alloc() to inet_connection_sock.c
      net: reduce rtnetlink_rcv_msg() stack usage
      MAINTAINERS: add 5 missing tcp-related files

Eric Joyner (1):
      ice: Check all ice_vsi_rebuild() errors in function

Erick Archer (8):
      wifi: brcm80211: use sizeof(*pointer) instead of sizeof(type)
      wifi: at76c50x: use sizeof(*pointer) instead of sizeof(type)
      wifi: at76c50x: prefer struct_size over open coded arithmetic
      Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
      Bluetooth: hci_core: Prefer array indexing over pointer arithmetic
      tty: rfcomm: prefer struct_size over open coded arithmetic
      tty: rfcomm: prefer array indexing over pointer arithmetic
      Bluetooth: Use sizeof(*pointer) instead of sizeof(type)

Eyal Birger (1):
      xfrm: support sending NAT keepalives in ESP in UDP states

FUJITA Tomonori (9):
      PCI: Add Edimax Vendor ID to pci_ids.h
      net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
      net: tn40xx: add register defines
      net: tn40xx: add basic Tx handling
      net: tn40xx: add basic Rx handling
      net: tn40xx: add mdio bus support
      net: tn40xx: add phylink support
      net: tn40xx: add initial ethtool_ops support
      net: tn40xx: add per queue netdev-genl stats support

Felix Fietkau (11):
      wifi: nl80211: split helper function from nl80211_put_iface_combinations
      wifi: mac80211: clear vif drv_priv after remove_interface when stopping
      wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
      wifi: cfg80211: extend interface combination check for multi-radio
      wifi: cfg80211: add helper for checking if a chandef is valid on a radio
      wifi: mac80211: add support for DFS with multiple radios
      wifi: mac80211: add radio index to ieee80211_chanctx_conf
      wifi: mac80211: extend ifcomb check functions for multi-radio
      wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
      wifi: mac80211: add wiphy radio assignment and validation
      wifi: mac80211_hwsim: add support for multi-radio wiphy

Florian Lehner (1):
      bpf, devmap: Add .map_alloc_check

Florian Westphal (19):
      net: tcp: un-pin the tw_timer
      tcp: move inet_twsk_schedule helper out of header
      net: add and use skb_get_hash_net
      net: add and use __skb_get_hash_symmetric_net
      netfilter: nf_tables: make struct nft_trans first member of derived subtypes
      netfilter: nf_tables: move bind list_head into relevant subtypes
      netfilter: nf_tables: compact chain+ft transaction objects
      netfilter: nf_tables: reduce trans->ctx.table references
      netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
      netfilter: nf_tables: pass more specific nft_trans_chain where possible
      netfilter: nf_tables: avoid usage of embedded nft_ctx
      netfilter: nf_tables: store chain pointer in rule transaction
      netfilter: nf_tables: reduce trans->ctx.chain references
      netfilter: nf_tables: pass nft_table to destroy function
      netfilter: nf_tables: do not store nft_ctx in transaction objects
      selftests: netfilter: nft_queue.sh: add test for disappearing listener
      netfilter: nf_tables: Add flowtable map for xdp offload
      openvswitch: prepare for stolen verdict coming from conntrack and nat engine
      act_ct: prepare for stolen verdict coming from conntrack and nat engine

Francesco Valla (1):
      Documentation: networking: document ISO 15765-2

Frank Li (5):
      dt-bindings: ptp: Convert ptp-qoirq to yaml format
      dt-bindings: net: Convert fsl-fman to yaml
      dt-bindings: net: fsl,fman: allow dma-coherent property
      dt-bindings: net: fsl,fman: add ptimer-handle property
      dt-bindings: net: convert enetc to yaml

Fredrik Lönnegren (1):
      wifi: rtlwifi: fix default typo

Furong Xu (1):
      net: stmmac: Enable TSO on VLANs

Gal Pressman (2):
      net/mlx5e: Fix outdated comment in features check
      net/mlx5e: Use tcp_v[46]_check checksum helpers

Geert Uytterhoeven (7):
      ravb: RAVB should select PAGE_POOL
      ravb: Improve ravb_hw_info instance order
      ravb: Add MII support for R-Car V4M
      can: rcar_canfd: Simplify clock handling
      can: rcar_canfd: Improve printing of global operational state
      can: rcar_canfd: Remove superfluous parentheses in address calculations
      netxen_nic: Use {low,upp}er_32_bits() helpers

Geliang Tang (38):
      selftests/bpf: Fix prog numbers in test_sockmap
      selftests/bpf: Drop struct post_socket_opts
      selftests/bpf: Add start_server_str helper
      selftests/bpf: Use post_socket_cb in connect_to_fd_opts
      selftests/bpf: Use post_socket_cb in start_server_str
      selftests/bpf: Use start_server_str in do_test in bpf_tcp_ca
      selftests/bpf: Fix tx_prog_fd values in test_sockmap
      selftests/bpf: Drop duplicate definition of i in test_sockmap
      selftests/bpf: Use bpf_link attachments in test_sockmap
      selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
      selftests/bpf: Drop prog_fd array in test_sockmap
      selftests/bpf: Fix size of map_fd in test_sockmap
      selftests/bpf: Check length of recv in test_sockmap
      selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap
      mptcp: use mptcp_win_from_space helper
      mptcp: add mptcp_space_from_win helper
      selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
      selftests/bpf: Add start_test helper in bpf_tcp_ca
      selftests/bpf: Use start_test in test_dctcp_fallback in bpf_tcp_ca
      selftests/bpf: Use start_test in test_dctcp in bpf_tcp_ca
      selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca
      selftests: net: lib: remove 'ns' var in setup_ns
      selftests: mptcp: lib: use setup/cleanup_ns helpers
      selftests: mptcp: lib: use wait_local_port_listen helper
      selftests/bpf: Drop type from network_helper_opts
      selftests/bpf: Use connect_to_addr in connect_to_fd_opt
      selftests/bpf: Add client_socket helper
      selftests/bpf: Drop noconnect from network_helper_opts
      selftests/bpf: Use start_server_str in mptcp
      selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
      selftests/bpf: Add backlog for network_helper_opts
      selftests/bpf: Add ASSERT_OK_FD macro
      selftests/bpf: Close fd in error path in drop_on_reuseport
      selftests/bpf: Use start_server_str in sk_lookup
      selftests/bpf: Use start_server_addr in sk_lookup
      selftests/bpf: Use connect_fd_to_fd in sk_lookup
      selftests/bpf: Null checks for links in bpf_tcp_ca
      selftests/bpf: Close obj in error path in xdp_adjust_tail

Golan Ben Ami (1):
      wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL

Gou Hao (2):
      net/core: remove redundant sk_callback_lock initialization
      net/core: move the lockdep-init of sk_callback_lock to sk_init_common()

Grzegorz Nitka (2):
      ice: Add NAC Topology device capability parser
      ice: Adjust PTP init for 2x50G E825C devices

Guangguan Wang (2):
      net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined
      net/smc: change SMCR_RMBE_SIZES from 5 to 15

Guillaume La Roque (1):
      net: ti: icssg-prueth: add missing deps

Hagar Hemdan (1):
      net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP

Haiyang Zhang (1):
      net: mana: Add support for page sizes other than 4KB on ARM64

Hangbin Liu (1):
      ipv6: sr: restruct ifdefines

Hao Qin (3):
      Bluetooth: btusb: mediatek: refactor the function btusb_mtk_reset
      Bluetooth: btusb: mediatek: reset the controller before downloading the fw
      Bluetooth: btusb: mediatek: add MT7922 subsystem reset

Harini T (2):
      dt-bindings: can: xilinx_can: Modify the title to indicate CAN and CANFD controllers are supported
      can: xilinx_can: Document driver description to list all supported IPs

Harshitha Prem (1):
      wifi: ath12k: Remove unused ath12k_base from ath12k_hw

Hector Martin (2):
      Bluetooth: hci_bcm4377: Increase boot timeout
      Bluetooth: hci_bcm4377: Add BCM4388 support

Heiner Kallweit (2):
      r8169: disable interrupt source RxOverflow
      r8169: remove detection of chip version 11 (early RTL8168b)

Heng Qi (6):
      linux/dim: move useful macros to .h file
      dim: make DIMLIB dependent on NET
      ethtool: provide customized dim profile management
      dim: add new interfaces for initialization and getting results
      virtio-net: support dim profile fine-tuning
      net: ethtool: Fix the panic caused by dev being null when dumping coalesce

Herve Codina (2):
      dt-bindings: net: mscc-miim: Add resets property
      net: mdio: mscc-miim: Handle the switch reset

Hilda Wu (1):
      Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables

Hongfu Li (1):
      rds:Simplify the allocation of slab caches

Ido Schimmel (11):
      lib: objagg: Fix spelling
      lib: test_objagg: Fix spelling
      mlxsw: spectrum_acl_atcam: Fix wrong comment
      lib: objagg: Fix general protection fault
      mlxsw: spectrum_acl_erp: Fix object nesting warning
      mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
      ethtool: Add ethtool operation to write to a transceiver module EEPROM
      mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
      selftests: forwarding: Make vxlan-bridge-1d pass on debug kernels
      mlxsw: core_thermal: Report valid current state during cooling device registration
      mlxsw: pci: Lock configuration space of upstream bridge during reset

Ilan Peer (3):
      wifi: cfg80211: Always call tracing
      wifi: iwlwifi: mvm: Fix associated initiator key setting
      wifi: mac80211: Use the link BSS configuration for beacon processing

Ilya Leoshkevich (15):
      bpf: Fix atomic probe zero-extension
      s390/bpf: Factor out emitting probe nops
      s390/bpf: Get rid of get_probe_mem_regno()
      s390/bpf: Introduce pre- and post- probe functions
      s390/bpf: Land on the next JITed instruction after exception
      s390/bpf: Support BPF_PROBE_MEM32
      s390/bpf: Support address space cast instruction
      s390/bpf: Enable arena
      s390/bpf: Support arena atomics
      selftests/bpf: Introduce __arena_global
      selftests/bpf: Add UAF tests for arena atomics
      selftests/bpf: Remove arena tests from DENYLIST.s390x
      s390/bpf: Change seen_reg to a mask
      s390/bpf: Implement exceptions
      selftests/bpf: Remove exceptions tests from DENYLIST.s390x

Ismael Luceno (1):
      ipvs: Avoid unnecessary calls to skb_is_gso_sctp

Iulia Tanasescu (1):
      Bluetooth: hci_event: Set QoS encryption from BIGInfo report

Ivan Babrou (1):
      bpftool: Un-const bpf_func_info to fix it for llvm 17 and newer

Jackie Jone (1):
      igb: Add MII write support

Jacob Keller (3):
      ice: Introduce helper to get tmr_cmd_reg values
      ice: Introduce ice_get_base_incval() helper
      ice: add and use roundup_u64 instead of open coding equivalent

Jakub Kicinski (139):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-constify-ctl_table-arguments-of-utility-functions'
      Merge branch 'tcp-fix-tcp_poll-races'
      Merge branch 'net-ethernet-ti-am65-cpsw-nuss-support-stacked-switches'
      Merge branch 'doc-netlink-fixes-for-ynl-doc-generator'
      Merge branch 'mlx4-add-support-for-netdev-genl-api'
      Merge branch 'ionic-updates-for-v6-11'
      net: fjes: correct TRACE_INCLUDE_PATH
      Merge branch 'net-stmmac-cleanups'
      Merge branch 'net-phylink-rearrange-ovr_an_inband-support'
      tools: ynl: make the attr and msg helpers more C++ friendly
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      net: qstat: extend kdoc about get_base_stats
      Merge branch 'doc-mptcp-new-general-doc-and-fixes'
      Merge branch 'ice-introduce-eth56g-phy-model-for-e825c-products'
      Merge branch 'net-visibility-of-memory-limits-in-netns'
      Merge branch 'net-ethernet-cortina-use-phylib-for-rx-and-tx-pause'
      Merge branch 'lan78xx-enable-125-mhz-clk-and-auto-speed-configuration-for-lan7801-if-no-eeprom-is-detected'
      net: count drops due to missing qdisc as dev->tx_drops
      tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
      tcp: add a helper for setting EOR on tail skb
      net: skb: add compatibility warnings to skb_shift()
      Revert "ethernet: octeontx2: avoid linking objects into multiple modules"
      Merge branch 'vmxnet3-upgrade-to-version-9'
      Merge branch 'net-mlx5e-shampo-enable-hw-gro-once-more'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl: make user space policies const
      rtnetlink: move rtnl_lock handling out of af_netlink
      net: netlink: remove the cb_mutex "injection" from netlink core
      Merge tag 'wireless-next-2024-06-07' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'intel-wired-lan-driver-updates-2024-06-03'
      Merge branch 'net-core-unify-dstats-with-tstats-and-lstats-implement-generic-dstats-collection'
      Merge branch 'selftests-mptcp-use-net-lib-sh-to-manage-netns'
      Merge branch 'net-flow-dissector-allow-explicit-passing-of-netns'
      Merge branch 'allow-configuration-of-multipath-hash-seed'
      Merge branch 'net-flower-validate-encapsulation-control-flags'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'mana-shared' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
      Merge branch 'net-dsa-lantiq_gswip-code-improvements'
      eth: lan966x: don't clear unsupported stats
      Merge branch 'mlx5-misc-patches-2023-06-13'
      Merge branch 'net-stmmac-provide-platform-select_pcs-method'
      Merge branch 'mlxsw-handle-mtu-values'
      net: make for_each_netdev_dump() a little more bug-proof
      Merge branch 'net-mlx4_en-use-ethtool_puts-sprintf'
      Merge branch 'mlxsw-use-page-pool-for-rx-buffers-allocation'
      Merge branch 'ionic-rework-fix-for-doorbell-miss'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'dt-bindings-net-convert-fsl-fman-related-file-to-yaml-format'
      docs: net: document guidance of implementing the SR-IOV NDOs
      Merge tag 'linux-can-next-for-6.11-20240621' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'locking-introduce-nested-bh-locking'
      Merge branch 'ravb-add-mii-support-for-r-car-v4m'
      Merge branch 'ethtool-provide-the-dim-profile-fine-tuning-channel'
      Merge branch 'gve-add-flow-steering-support'
      Merge branch 'add-ethernet-driver-for-tehuti-networks-tn40xx-chips'
      Merge branch 'mlxsw-reduce-memory-footprint-of-mlxsw-driver'
      selftests: drv-net: try to check if port is in use
      selftests: drv-net: add helper to wait for HW stats to sync
      selftests: drv-net: add ability to wait for at least N packets to load gen
      selftests: drv-net: rss_ctx: add tests for RSS configuration and contexts
      Merge branch 'selftests-drv-net-rss_ctx-add-tests-for-rss-contexts'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2024-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      tools: ynl: use display hints for formatting of scalar attrs
      Merge branch 'selftests-net-switch-pmtu-sh-to-use-the-internal-ovs-script'
      Merge branch 'lift-udp_segment-restriction-for-egress-via-device-w-o-csum-offload'
      selftests: net: ksft: avoid continue when handling results
      selftests: drv-net: add ability to schedule cleanup with defer()
      selftests: drv-net: rss_ctx: convert to defer()
      Merge branch 'selftests-drv-net-add-ability-to-schedule-cleanup-with-defer'
      Merge branch 'ethtool-track-custom-rss-contexts-in-the-core'
      tcp_metrics: add UAPI to the header guard
      tcp_metrics: add netlink protocol spec in YAML
      Merge tag 'linux-can-next-for-6.11-20240629' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      tools: net: package libynl for use in selftests
      Merge branch 'device-memory-tcp'
      selftests: drv-net: rss_ctx: allow more noise on default context
      net: ethtool: fix compat with old RSS context API
      Merge branch 'selftests-openvswitch-address-some-flakes-in-the-ci-environment'
      Merge branch 'crypto-caam-unembed-net_dev'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-constify-struct-regmap_bus-regmap_config'
      Merge branch 'net-openvswitch-add-sample-multicasting'
      Merge branch 'net-pse-pd-add-new-pse-c33-features'
      selftests: net: ksft: interrupt cleanly on KeyboardInterrupt
      Merge branch 'net-stmmac-qcom-ethqos-enable-2-5g-ethernet-on-sa8775p-ride'
      selftests: drv-net: rss_ctx: fix cleanup in the basic test
      selftests: drv-net: rss_ctx: factor out send traffic and check
      selftests: drv-net: rss_ctx: test queue changes vs user RSS config
      selftests: drv-net: rss_ctx: check behavior of indirection table resizing
      selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic
      Merge branch 'selftests-drv-net-rss_ctx-more-tests'
      Merge branch 'mlxsw-improvements'
      Merge branch 'mlx5-misc-patches-2023-07-08'
      Merge branch 'ice-support-to-dump-phy-config-fec'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      ethtool: fail closed if we can't get max channel used in indirection tables
      ethtool: use the rss context XArray in ring deactivation safety-check
      Merge branch 'ethtool-use-the-rss-context-xarray-in-ring-deactivation-safety-check'
      Merge tag 'wireless-next-2024-07-11' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'netconsole-fix-potential-race-condition-and-improve-code-clarity'
      net: ethtool: let drivers remove lost RSS contexts
      net: ethtool: let drivers declare max size of RSS indir table and key
      eth: bnxt: allow deleting RSS contexts when the device is down
      eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
      eth: bnxt: remove rss_ctx_bmap
      eth: bnxt: depend on core cleaning up RSS contexts
      eth: bnxt: use context priv for struct bnxt_rss_ctx
      eth: bnxt: use the RSS context XArray instead of the local list
      eth: bnxt: pad out the correct indirection table
      eth: bnxt: bump the entry size in indir tables to u32
      eth: bnxt: use the indir table from ethtool context
      Merge branch 'eth-bnxt-use-the-new-rss-api'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-make-simultaneous-connect-rfc-compliant'
      Merge branch 'mlx5-misc-2023-07-08-sf-max-eq'
      eth: mlx5: expose NETIF_F_NTUPLE when ARFS is compiled out
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'ipsec-2024-07-11' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'net-pse-pd-fix-possible-issues-with-a-pse-supporting-both-c33-and-podl'
      Merge branch 'vrf-fix-source-address-selection-with-route-leak'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'introduce-en7581-ethernet-support'
      Merge tag 'ipsec-next-2024-07-13' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'eliminate-config_nr_cpus-dependency-in-dpaa-eth-and-enable-compile_test-in-fsl_qbman'
      Merge branch 'virtio-net-support-af_xdp-zero-copy'
      Merge branch 'net-phy-bcm5481x-add-support-for-broadr-reach-mode'
      Merge branch 'net-dsa-vsc73xx-implement-vlan-operations'
      Merge branch 'net-make-timestamping-selectable'
      Merge tag 'for-net-next-2024-07-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Revert "net: mvpp2: Improve data types and use min()"
      Merge branch 'flower-rework-tca_flower_key_enc_flags-usage'
      Merge tag 'aux-sysfs-irqs' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'eth-fbnic-add-network-driver-for-meta-platforms-host-network-interface'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jakub Sitnicki (3):
      selftests/bpf: use section names understood by libbpf in test_sockmap
      udp: Allow GSO transmit from devices with no checksum offload
      selftests/net: Add test coverage for UDP GSO software fallback

James Chapman (11):
      l2tp: remove unused list_head member in l2tp_tunnel
      l2tp: store l2tpv3 sessions in per-net IDR
      l2tp: store l2tpv2 sessions in per-net IDR
      l2tp: refactor udp recv to lookup to not use sk_user_data
      l2tp: don't use sk_user_data in l2tp_udp_encap_err_recv
      l2tp: use IDR for all session lookups
      l2tp: drop the now unused l2tp_tunnel_get_session
      l2tp: replace hlist with simple list for per-tunnel session list
      l2tp: remove incorrect __rcu attribute
      l2tp: fix possible UAF when cleaning up tunnels
      l2tp: fix l2tp_session_register with colliding l2tpv3 IDs

Jason Xing (2):
      net: remove NULL-pointer net parameter in ip_metrics_convert
      net: allow rps/rfs related configs to be switched

Javier Carrasco (4):
      net: dsa: qca8k: constify struct regmap_config
      net: ti: icss-iep: constify struct regmap_config
      net: encx24j600: constify struct regmap_bus/regmap_config
      net: dsa: ar9331: constify struct regmap_bus

Jeff Johnson (16):
      wifi: ath11k: refactor CE remap & unmap
      wifi: ath11k: unmap the CE in ath11k_ahb_probe() error path
      wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
      wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
      wifi: ath11k: fix misspelling of "dma" in num_rxmda_per_pdev
      wifi: ath12k: fix misspelling of "dma" in num_rxmda_per_pdev
      wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()
      wifi: ath12k: Fix devmem address prefix when logging
      test_bpf: Add missing MODULE_DESCRIPTION()
      isdn: add missing MODULE_DESCRIPTION() macros
      net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
      net: arcnet: com20020-isa: add missing MODULE_DESCRIPTION() macro
      net: amd: add missing MODULE_DESCRIPTION() macros
      net: ethernet: mac89x0: add missing MODULE_DESCRIPTION() macro
      net: smc9194: add missing MODULE_DESCRIPTION() macro
      s390/lcs: add missing MODULE_DESCRIPTION() macro

Jeremy Kerr (4):
      net: core,vrf: Change pcpu_dstat fields to u64_stats_t
      net: core: Implement dstats-type stats collections
      net: vrf: move to generic dstat helpers
      net: mctp-i2c: invalidate flows immediately on TX errors

Jeroen de Borst (4):
      gve: Add adminq extended command
      gve: Add flow steering device option
      gve: Add flow steering adminq commands
      gve: Add flow steering ethtool support

Jesse Brandeburg (1):
      MAINTAINERS: update Intel Ethernet maintainers

Jianbo Liu (3):
      net/mlx5: Reimplement write combining test
      xfrm: fix netdev reference count imbalance
      xfrm: call xfrm_dev_policy_delete when kill policy

Jiapeng Chong (2):
      wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()
      wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()

Jiawen Wu (3):
      net: txgbe: add FDIR ATR support
      net: txgbe: support Flow Director perfect filters
      net: txgbe: add FDIR info to ethtool ops

Jiri Olsa (2):
      bpf: Change bpf_session_cookie return value to __u64 *
      selftests/bpf: Move ARRAY_SIZE to bpf_misc.h

Jiri Pirko (1):
      virtio_net: add support for Byte Queue Limits

Joe Damato (5):
      net/mlx4: Track RX allocation failures in a stat
      net/mlx4: link NAPI instances to queues and IRQs
      net/mlx4: support per-queue statistics via netlink
      net/mlx5e: Add txq to sq stats mapping
      net/mlx5e: Add per queue netdev-genl stats

Johan Jonker (3):
      ARM: dts: rockchip: rk3xxx: fix emac node
      net: ethernet: arc: remove emac_arc driver
      dt-bindings: net: remove arc_emac.txt

Johannes Berg (108):
      wifi: regulatory: remove extra documentation
      wifi: ieee80211: add missing doc short descriptions
      wifi: radiotap: document ieee80211_get_radiotap_len() return value
      wifi: ieee80211: remove ieee80211_next_tbtt_present()
      wifi: ieee80211: document function return values
      wifi: ieee80211: document two FTM related functions
      wifi: nl80211: disallow setting special AP channel widths
      wifi: cfg80211: sort trace events again
      wifi: cfg80211: add tracing for wiphy work
      wifi: mac80211: remove outdated comments
      wifi: mac80211: remove extra link STA functions
      wifi: ieee80211/ath11k: remove IEEE80211_MAX_NUM_PWR_LEVEL
      wifi: ath11k: fix TPE power levels
      wifi: mac80211: pass parsed TPE data to drivers
      wifi: mac80211: track changes in AP's TPE
      wifi: iwlwifi: dvm: clean up rs_get_rate() logic
      wifi: iwlwifi: mvm: mark bad no-data RX as having bad PLCP
      wifi: iwlwifi: mei: unify iwl_mei_set_power_limit() prototype
      wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
      wifi: iwlwifi: mvm: don't track used links separately
      wifi: iwlwifi: tracing: fix condition to allocate buf1
      wifi: iwlwifi: simplify TX tracing
      wifi: iwlwifi: mvm: add mvm-specific guard
      wifi: mac80211: move radar detect work to sdata
      wifi: cfg80211: restrict operation during radar detection
      wifi: mac80211: mlme: handle cross-link CSA
      wifi: mac80211: collect some CSA data into sub-structs
      wifi: mac80211: handle wider bandwidth OFDMA during CSA
      wifi: mac80211: handle TPE element during CSA
      wifi: mac80211: refactor chanreq.ap setting
      wifi: mac80211: fix TTLM teardown work
      wifi: mac80211: cancel multi-link reconf work on disconnect
      wifi: mac80211: cancel TTLM teardown work earlier
      wifi: mac80211: don't stop TTLM works again
      wifi: mac80211: reset negotiated TTLM on disconnect
      wifi: mac80211: send DelBA with correct BSSID
      wifi: iwlwifi: mvm: report 64-bit radiotap timestamp
      wifi: iwlwifi: mvm: handle TPE advertised by AP
      wifi: iwlwifi: mvm: use only beacon BSS load for active links
      wifi: iwlwifi: mvm: show full firmware ID in debugfs
      wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
      wifi: mac80211: handle HW restart during ROC
      wifi: nl80211: clean up coalescing rule handling
      wifi: mac80211: correct EHT EIRP TPE parsing
      wifi: cfg80211: make hash table duplicates more survivable
      wifi: nl80211: expose can-monitor channel property
      wifi: cfg80211: use BIT() for flag enums
      wifi: ieee80211: remove unused enum ieee80211_client_reg_power
      wifi: cfg80211: move enum ieee80211_ap_reg_power to cfg80211
      wifi: mac80211: refactor channel checks
      wifi: cfg80211: refactor 6 GHz AP power type parsing
      wifi: cfg80211: refactor regulatory beaconing checking
      wifi: cfg80211: add regulatory flag to allow VLP AP operation
      wifi: mac80211: fix erroneous errors for STA changes
      wifi: mac80211: clean up 'ret' in sta_link_apply_parameters()
      wifi: iwlwifi: mvm: fix DTIM skip powersave config
      wifi: iwlwifi: move TXQ bytecount limit to queue code
      wifi: iwlwifi: api: fix includes in debug.h
      wifi: iwlwifi: pcie: integrate TX queue code
      wifi: iwlwifi: mvm: separate non-BSS/ROC EMLSR blocking
      wifi: mac80211: refactor CSA queue block/unblock
      wifi: mac80211: restrict public action ECSA frame handling
      wifi: mac80211: handle protected dual of public action
      wifi: mac80211: optionally pass chandef to ieee80211_sta_cap_rx_bw()
      wifi: mac80211: optionally pass chandef to ieee80211_sta_cur_vht_bw()
      wifi: mac80211: make ieee80211_chan_bw_change() able to use reserved
      wifi: mac80211: update STA/chandef width during switch
      wifi: mac80211: add ieee80211_tdls_sta_link_id()
      wifi: mac80211: correcty limit wider BW TDLS STAs
      wifi: mac80211: check SSID in beacon
      wifi: iwlwifi: mvm: unify and fix interface combinations
      wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_remove_interface_common()
      wifi: iwlwifi: mvm: rename 'pldr_sync'
      wifi: iwlwifi: mei: clarify iwl_mei_pldr_req() docs
      wifi: iwlwifi: mvm: enable VLP AP on VLP channels
      wifi: iwlwifi: mvm: don't limit VLP/AFC to UATS-enabled
      wifi: iwlwifi: mvm: don't flush BSSes on restart with MLD API
      wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check
      wifi: iwlwifi: mvm: always unblock EMLSR on ROC end
      wifi: iwlwifi: fw: api: fix some kernel-doc
      wifi: iwlwifi: trans: make bad state warnings
      wifi: iwlwifi: dvm: fix kernel-doc warnings
      wifi: iwlwifi: pcie: fix kernel-doc
      wifi: iwlwifi: fix kernel-doc in iwl-trans.h
      wifi: iwlwifi: fix kernel-doc in iwl-fh.h
      wifi: iwlwifi: fix prototype mismatch kernel-doc warnings
      wifi: iwlwifi: fix remaining mistagged kernel-doc comments
      wifi: iwlwifi: fw: api: datapath: fix kernel-doc
      wifi: iwlwifi: mvm: fix rs.h kernel-doc
      wifi: nl80211: don't give key data to userspace
      wifi: mac80211: remove key data from get_key callback
      wifi: mac80211_hwsim: fix kernel-doc
      wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
      wifi: iwlwifi: mvm: fix interface combinations
      wifi: iwlwifi: mvm: clean up reorder buffer data
      wifi: iwlwifi: mvm: align reorder buffer entries to cacheline
      wifi: iwlwifi: mvm: simplify EMLSR blocking
      wifi: iwlwifi: mvm: add missing string for ROC EMLSR block
      wifi: iwlwifi: fw: api: fix memory region kernel-doc
      wifi: iwlwifi: fw: api: mac: fix kernel-doc
      wifi: iwlwifi: fw: api: add puncturing to PHY context docs
      wifi: iwlwifi: document PPAG table command union correctly
      wifi: iwlwifi: fw: api: fix missing RX descriptor kernel-doc
      wifi: iwlwifi: mvm: document remaining mvm data
      wifi: mac80211_hwsim: fix warning
      net: page_pool: fix warning code
      wifi: virt_wifi: don't use strlen() in const context
      wifi: mac80211: fix AP chandef capturing in CSA

Jon Kohler (1):
      enic: add ethtool get_channel support

Jonas Karlman (1):
      dt-bindings: net: rockchip-dwmac: Fix rockchip,rk3308-gmac compatible

Kalle Valo (6):
      wifi: ath11k: ath11k_mac_op_ipv6_changed(): use list_for_each_entry()
      Merge tag 'rtw-next-2024-06-04' of https://github.com/pkshih/rtw
      Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      Merge tag 'ath-next-20240702' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-07-05' of https://github.com/pkshih/rtw
      Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

Kamal Heib (3):
      net/mlx4_en: Use ethtool_puts to fill priv flags strings
      net/mlx4_en: Use ethtool_puts to fill selftest strings
      net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings

Kamil Horák (2N) (4):
      net: phy: bcm54811: New link mode for BroadR-Reach
      net: phy: bcm54811: Add LRE registers definitions
      dt-bindings: ethernet-phy: add optional brr-mode flag
      net: phy: bcm-phy-lib: Implement BroadR-Reach link modes

Kang Yang (5):
      wifi: ath12k: remove unused variable monitor_flags
      wifi: ath12k: avoid duplicated vdev stop
      wifi: ath12k: avoid duplicated vdev down
      wifi: ath12k: remove invalid peer create logic
      wifi: ath12k: remove redundant peer delete for WCN7850

Karol Kolacinski (3):
      ice: Introduce ice_ptp_hw struct
      ice: Add PHY OFFSET_READY register clearing
      ice: Change CGU regs struct to anonymous

Karthik Sundaravel (1):
      ice: Add get/set hw address for VFs using devlink commands

Karthikeyan Kathirvel (1):
      wifi: ath12k: drop failed transmitted frames from metric calculation.

Karthikeyan Periyasamy (16):
      wifi: ath12k: Refactor the hardware recovery procedure
      wifi: ath12k: Refactor the hardware state
      wifi: ath12k: Add lock to protect the hardware state
      wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
      wifi: ath12k: Refactor idle ring descriptor setup
      wifi: ath12k: Introduce device index
      wifi: ath12k: add multi device support for WBM idle ring buffer setup
      wifi: ath12k: avoid double SW2HW_MACID conversion
      wifi: ath12k: remove duplicate definition of MAX_RADIOS
      wifi: ath12k: use correct MAX_RADIOS
      wifi: ath12k: refactor rx descriptor CMEM configuration
      wifi: ath12k: improve the rx descriptor error information
      wifi: ath12k: add hw_link_id in ath12k_pdev
      wifi: ath12k: avoid unnecessary MSDU drop in the Rx error process
      wifi: ath12k: fix mbssid max interface advertisement
      wifi: ath12k: fix peer metadata parsing

Kees Cook (1):
      tcp: Replace strncpy() with strscpy()

Kenta Tada (1):
      bpftool: Query only cgroup-related attach types

Kevin Yang (2):
      tcp: derive delack_max with tcp_rto_min helper
      tcp: add sysctl_tcp_rto_min_us

Kiran K (7):
      Bluetooth: btintel: Refactor btintel_set_ppag()
      Bluetooth: btintel_pcie: Print Firmware Sequencer information
      Bluetooth: btintel_pcie: Fix irq leak
      Bluetooth: btintel: Add firmware ID to firmware name
      Bluetooth: btintel: Fix the sfi name for BlazarU
      Bluetooth: btintel: Add support for BlazarU core
      Bluetooth: btintel: Add support for Whale Peak2

Kory Maincent (7):
      net: Move dev_set_hwtstamp_phylib to net/core/dev.h
      net: pse-pd: Do not return EOPNOSUPP if config is null
      net: ethtool: pse-pd: Fix possible null-deref
      net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
      net: Change the API of PHY default timestamp to MAC
      net: net_tstamp: Add unspec field to hwtstamp_source enumeration
      net: Add struct kernel_ethtool_ts_info

Kory Maincent (Dent Project) (7):
      net: ethtool: pse-pd: Expand C33 PSE status with class, power and extended state
      netlink: specs: Expand the PSE netlink command with C33 new features
      net: pse-pd: pd692x0: Expand ethtool status message
      net: pse-pd: Add new power limit get and set c33 features
      net: ethtool: Add new power limit get and set features
      netlink: specs: Expand the PSE netlink command with C33 pw-limit attributes
      net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks

Krzysztof Kozlowski (4):
      can: hi311x: simplify with spi_get_device_match_data()
      can: mcp251x: simplify with spi_get_device_match_data()
      can: mcp251xfd: simplify with spi_get_device_match_data()
      Bluetooth: hci: fix build when POWER_SEQUENCING=m

Kuan-Chung Chen (1):
      wifi: rtw89: 8852b: fix definition of KIP register number

Kui-Feng Lee (15):
      bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
      bpf: enable detaching links of struct_ops objects.
      bpf: support epoll from bpf struct_ops links.
      bpf: export bpf_link_inc_not_zero.
      selftests/bpf: test struct_ops with epoll
      bpftool: Change pid_iter.bpf.c to comply with the change of bpf_link_fops.
      bpf: Remove unnecessary checks on the offset of btf_field.
      bpf: Remove unnecessary call to btf_field_type_size().
      bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
      bpf: create repeated fields for arrays.
      bpf: look into the types of the fields of a struct type recursively.
      bpf: limit the number of levels of a nested struct type.
      selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
      selftests/bpf: Test global bpf_rb_root arrays and fields in nested struct types.
      selftests/bpf: Test global bpf_list_head arrays.

Kuniyuki Iwashima (15):
      af_unix: Remove dead code in unix_stream_read_generic().
      af_unix: Define locking order for unix_table_double_lock().
      af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
      af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
      af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
      af_unix: Don't acquire unix_state_lock() for sock_i_ino().
      af_unix: Remove U_LOCK_DIAG.
      af_unix: Remove U_LOCK_GC_LISTENER.
      af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
      af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
      af_unix: Remove put_pid()/put_cred() in copy_peercred().
      af_unix: Don't use spin_lock_nested() in copy_peercred().
      tcp: Don't drop SYN+ACK for simultaneous connect().
      selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect tests.
      tcp: Don't access uninit tcp_rsk(req)->ao_keyid in tcp_create_openreq_child().

Leon Hwang (3):
      bpf, verifier: Correct tail_call_reachable for bpf prog
      bpf, x64: Remove tail call detection
      bpf: Fix tailcall cases in test_bpf

Li RongQing (1):
      virtio_net: Remove u64_stats_update_begin()/end() for stats fetch

Lin Ma (1):
      netfilter: cttimeout: remove 'l3num' attr check

Lingbo Kong (4):
      wifi: ath12k: fix ack signal strength calculation
      wifi: ath11k: fix ack signal strength calculation
      wifi: ath11k: modify the calculation of the average signal strength in station mode
      wifi: ath12k: Fix pdev id sent to firmware for single phy devices

Linus Walleij (5):
      net: ethernet: cortina: Restore TSO support
      net: ethernet: cortina: Rename adjust link callback
      net: ethernet: cortina: Use negotiated TX/RX pause
      net: ethernet: cortina: Implement .set_pauseparam()
      dt-bindings: dsa: Rewrite Vitesse VSC73xx in schema

Lorenzo Bianconi (4):
      netfilter: Add bpf_xdp_flow_lookup kfunc
      selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc
      dt-bindings: net: airoha: Add EN7581 ethernet controller
      net: airoha: Introduce ethernet support for EN7581 SoC

Lucas Stach (3):
      net: dsa: microchip: lan9371/2: add 100BaseTX PHY support
      net: dsa: microchip: lan937x: disable in-band status support for RGMII interfaces
      net: dsa: microchip: lan937x: disable VPHY support

Luiz Augusto von Dentz (9):
      Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
      Merge tag 'pwrseq-initial-for-v6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into HEAD
      Bluetooth: Fix usage of __hci_cmd_sync_status
      Bluetooth: hci_core: Remove usage of hci_req_sync
      Bluetooth: hci_core: Don't use hci_prepare_cmd
      Bluetooth: hci_sync: Move handling of interleave_scan
      Bluetooth: hci_sync: Remove remaining dependencies of hci_request
      Bluetooth: Remove hci_request.{c,h}
      Bluetooth: hci_qca: Fix build error

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in FREESCALE QORIQ DPAA FMAN DRIVER

Lukasz Majewski (5):
      selftests: hsr: Extend the hsr_redbox.sh test to use fixed MAC addresses
      selftests: hsr: Extend the hsr_ping.sh test to use fixed MAC addresses
      net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data
      net: hsr: cosmetic: Remove extra white space
      net: dsa: ksz_common: Allow only up to two HSR HW offloaded ports for KSZ9477

Luke Wang (1):
      Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading

MD Danish Anwar (6):
      net: ti: icssg-prueth: Add helper functions to configure FDB
      net: ti: icssg-switch: Add switchdev based driver for ethernet switch support
      net: ti: icssg-prueth: Add support for ICSSG switch firmware
      dt-bindings: net: ti: icssg_prueth: Add documentation for PA_STATS support
      net: ti: icssg-prueth: Add multicast filtering support
      net: ti: icssg-prueth: Split out common object into module

Ma Ke (1):
      selftests/bpf: Don't close(-1) in serial_test_fexit_stress()

Mans Rullgard (1):
      can: Kconfig: remove obsolete help text for slcan

Marc Gonzalez (2):
      dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
      wifi: ath10k: do not always wait for MSA_READY indicator

Marc Kleine-Budde (18):
      Merge patch series "can: xilinx_can: Document driver description to list all supported IPs"
      Merge patch "Documentation: networking: document ISO 15765-2"
      Merge patch series "can: kvaser_usb: Add support for three new devices"
      Merge patch series "can: kvaser_pciefd: Minor improvements and cleanups"
      Merge patch series "can: kvaser_pciefd: Support MSI interrupts"
      Merge patch series "can: hi311x: simplify with spi_get_device_match_data()"
      Merge patch series "can: rcar_canfd: Small improvements and cleanups"
      can: gs_usb: add VID/PID for Xylanta SAINT3 product family
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: update errata references
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
      can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
      can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd
      Merge patch series "can: mcp251xfd: workaround for erratum DS80000789E 6 of mcp2518fd"

Marcin Szycik (4):
      ice: Remove unused struct ice_prot_lkup_ext members
      ice: Optimize switch recipe creation
      ice: Remove unused members from switch API
      ice: Add tracepoint for adding and removing switch rules

Marcin Ślusarz (1):
      wifi: rtw88: usb: schedule rx work after everything is set up

Marek Behún (2):
      net: dsa: deduplicate code adding / deleting the port address to fdb
      net: dsa: update the unicast MAC address when changing conduit

Marek Vasut (8):
      net: stmmac: dwmac-stm32: Separate out external clock rate validation
      net: stmmac: dwmac-stm32: Separate out external clock selector
      net: stmmac: dwmac-stm32: Extract PMCR configuration
      net: stmmac: dwmac-stm32: Clean up the debug prints
      net: stmmac: dwmac-stm32: Fix Mhz to MHz
      dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as compatible strings
      net: phy: realtek: Add support for PHY LEDs on RTL8211F
      dt-bindings: net: realtek,rtl82xx: Document RTL8211F LED support

Martin Blumenstingl (8):
      net: dsa: lantiq_gswip: Only allow phy-mode = "internal" on the CPU port
      net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
      net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
      net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
      net: dsa: lantiq_gswip: Change literal 6 to ETH_ALEN
      net: dsa: lantiq_gswip: Consistently use macros for the mac bridge table
      net: dsa: lantiq_gswip: Update comments in gswip_port_vlan_filtering()
      net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()

Martin Hundebøll (1):
      can: m_can: don't enable transceiver when probing

Martin Jocic (12):
      can: kvaser_usb: Add support for Vining 800
      can: kvaser_usb: Add support for Kvaser USBcan Pro 5xCAN
      can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN
      can: kvaser_pciefd: Group #defines together
      can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
      can: kvaser_pciefd: Remove unnecessary comment
      can: kvaser_pciefd: Add inline
      can: kvaser_pciefd: Add unlikely
      can: kvaser_pciefd: Rename board_irq to pci_irq
      can: kvaser_pciefd: Change name of return code variable
      can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
      can: kvaser_pciefd: Add MSI interrupts

Martin KaFai Lau (5):
      Merge branch 'Replace mono_delivery_time with tstamp_type'
      Merge branch 'use network helpers, part 5'
      Merge branch 'Notify user space when a struct_ops object is detached/unregistered'
      Merge branch 'use network helpers, part 8'
      Merge branch 'BPF selftests misc fixes'

Martin Kaistra (1):
      wifi: rtl8xxxu: 8188f: Limit TX power index

Martin Schiller (4):
      dt-bindings: net: dsa: lantiq,gswip: convert to YAML schema
      net: dsa: lantiq_gswip: add terminating \n where missing
      net: dsa: lantiq_gswip: do also enable or disable cpu port
      net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()

Matt Bobrowski (4):
      bpf: Add security_file_post_open() LSM hook to sleepable_lsm_hooks
      bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
      bpf: add new negative selftests to cover missing check_func_arg_reg_off() and reg->type check
      bpf: relax zero fixed offset constraint on KF_TRUSTED_ARGS/KF_RCU

Matteo Croce (2):
      net: make net.core.{r,w}mem_{default,max} namespaced
      selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a netns

Matthias Schiffer (5):
      net: dsa: mt7530: factor out bridge join/leave logic
      net: dsa: mt7530: add support for bridge port isolation
      net: dsa: qca8k: do not write port mask twice in bridge join/leave
      net: dsa: qca8k: factor out bridge join/leave logic
      net: dsa: qca8k: add support for bridge port isolation

Matthieu Baerts (NGI0) (7):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'
      selftests: net: lib: ignore possible errors
      selftests: net: lib: remove ns from list after clean-up
      selftests: net: lib: do not set ns var as readonly
      selftests: mptcp: lib: fix shellcheck errors

Michael Chan (4):
      bnxt_en: Add new TX timestamp completion definitions
      bnxt_en: Add is_ts_pkt field to struct bnxt_sw_tx_bd
      bnxt_en: Allow some TX packets to be unprocessed in NAPI
      bnxt_en: Add TX timestamp completion logic

Michael Lo (1):
      wifi: mt76: mt792x: fix scheduler interference in drv own process

Michael-CY Lee (2):
      wifi: mac80211: cancel color change finalize work when link is stopped
      wifi: mac80211: do not check BSS color collision in certain cases

Michal Michalik (1):
      ice: Add support for E825-C TS PLL handling

Michal Schmidt (1):
      ice: use irq_update_affinity_hint()

Michal Swiatkowski (8):
      ice: store representor ID in bridge port
      ice: move devlink locking outside the port creation
      ice: move VSI configuration outside repr setup
      ice: update representor when VSI is ready
      ice: Remove reading all recipes before adding a new one
      ice: Simplify bitmap setting in adding recipe
      ice: remove unused recipe bookkeeping data
      ice: remove eswitch rebuild

Mike Yu (4):
      xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO path
      xfrm: Allow UDP encapsulation in crypto offload control path
      xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP packet
      xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP packet

Milan Broz (1):
      r8152: Set NET_ADDR_STOLEN if using passthru MAC

Mina Almasry (1):
      page_pool: convert to use netmem

Miri Korenblit (27):
      wifi: iwlwifi: mvm: define link_sta in the relevant scope
      wifi: iwlwifi: mvm: set A-MSDU size on the correct link
      wifi: iwlwifi: mvm: call ieee80211_sta_recalc_aggregates on A-MSDU size update
      wifi: iwlwifi: mvm: don't always set antenna in beacon template cmd
      wifi: iwlwifi: mvm: Use the SMPS cfg of the correct link
      wifi: iwlwifi: mvm: add a of print of a few commands
      wifi: iwlwifi: bump FW API to 91 for BZ/SC devices
      wifi: iwlwifi: mvm: disable dynamic EMLSR when AUTO_EML is false
      wifi: iwlwifi: mvm: don't skip link selection
      wifi: iwlwifi: mvm: remove IWL_MVM_USE_NSSN_SYNC
      wifi: iwlwifi: mvm: move a constant to constants.h
      wifi: iwlwifi: mvm: Remove debug related code
      wifi: iwlwifi: mvm: add debug data for MPDU counting
      wifi: iwlwifi: mvm: declare band variable in the scope
      wifi: iwlwifi: mvm: fix a wrong comment
      wifi: iwlwifi: remove redundant prints
      wifi: iwlwifi: move amsdu_size parsing to iwlwifi
      wifi: iwlwifi: move Bz and Gl iwl_dev_info entries
      wifi: iwlwifi: mvm: remove unneeded debugfs entries
      wifi: iwlwifi: bump minimum API version in BZ/SC to 90
      wifi: iwlwifi: mvm: fix re-enabling EMLSR
      wifi: iwlwifi: bump min API version for Qu/So devices
      wifi: iwlwifi: mvm: remove IWL_MVM_PARSE_NVM
      wifi: iwlwifi: trans: remove unused function parameter
      wifi: iwlwifi: bump FW API to 92 for BZ/SC devices
      wifi: iwlwifi: mvm: remove init_dbg module parameter
      wifi: iwlwifi: mvm: re-enable MLO

Mohammad Shehar Yaar Tausif (1):
      bpf: Fix order of args in call to bpf_map_kvcalloc

Moshe Shemesh (1):
      net/mlx5: Replace strcpy with strscpy

Mukesh Sisodiya (3):
      wifi: mac80211: update 6 GHz AP power type before association
      wifi: iwlwifi: fw: api: Add new timepoint for scan failure
      wifi: iwlwifi: Remove debug message

Muna Sinada (1):
      wifi: ath12k: dynamic VLAN support

Mykyta Yatsenko (4):
      bpftool: Introduce btf c dump sorting
      libbpf: Configure log verbosity with env variable
      libbpf: Auto-attach struct_ops BPF maps in BPF skeleton
      selftests/bpf: Test struct_ops bpf map auto-attach

Nathan Chancellor (1):
      Bluetooth: btmtk: Mark all stub functions as inline

Neeraj Sanjay Kale (10):
      Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()
      Bluetooth: btnxpuart: Enable status prints for firmware download
      Bluetooth: btnxpuart: Handle FW Download Abort scenario
      dt-bindings: net: bluetooth: nxp: Add firmware-name property
      Bluetooth: btnxpuart: Update firmware names
      Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
      Bluetooth: btnxpuart: Add support for AW693 A1 chipset
      Bluetooth: btnxpuart: Add support for IW615 chipset
      Bluetooth: btnxpuart: Add system suspend and resume handlers
      Bluetooth: btnxpuart: Fix warnings for suspend and resume functions

Nicolas Dichtel (4):
      ipv4: fix source address selection with route leak
      ipv6: fix source address selection with route leak
      ipv6: take care of scope when choosing the src addr
      selftests: vrf_route_leaking: add local test

Niklas Söderlund (1):
      net: ethernet: rtsn: Add support for Renesas Ethernet-TSN

Nithin Dabilpuram (1):
      octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM

Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix tx completion ring (WBM2SW) setup failure

Ole André Vadla Ravnås (1):
      CDC-NCM: add support for Apple's private interface

Oleksij Rempel (4):
      net: dsa: microchip: lan937x: Add error handling in lan937x_setup
      net: dsa: microchip: lan9371/2: update MAC capabilities for port 4
      net: phy: microchip: lan937x: add support for 100BaseTX PHY
      net: phy: dp83td510: add cable testing support

Oliver Hartkopp (1):
      can: isotp: remove ISO 15675-2 specification version where possible

P Praneesh (3):
      wifi: ath12k: change DMA direction while mapping reinjected packets
      wifi: ath12k: fix invalid memory access while processing fragmented packets
      wifi: ath12k: fix firmware crash during reo reinject

Pablo Neira Ayuso (1):
      netfilter: nf_tables: rise cap on SELinux secmark context

Paolo Abeni (19):
      Merge branch 'introduce-switch-mode-support-for-icssg-driver'
      Merge branch 'net-allow-dissecting-matching-tunnel-control-flags'
      Merge branch 'tcp-refactor-skb_cmp_decrypted-checks'
      Merge branch 'improve-gbeth-performance-on-renesas-rz-g2l-and-related-socs'
      Merge branch 'mptcp-misc-cleanups'
      Merge branch 'tcp-small-code-reorg'
      Merge branch 'series-to-deliver-ethernet-for-stm32mp13'
      Merge branch 'introduce-phy-mode-10g-qxgmii'
      Merge branch 'add-flow-director-for-txgbe'
      Merge branch 'af_unix-remove-spin_lock_nested-and-convert-to-lock_cmp_fn'
      Merge branch 'net-macb-wol-enhancements'
      Merge branch 'series-to-deliver-ethernet-for-stm32mp25'
      Merge branch 'zerocopy-tx-cleanups'
      Merge branch 'page_pool-bnxt_en-unlink-old-page-pool-in-queue-api-using-helper'
      Merge branch 'net-bpf_net_context-cleanups'
      Merge branch 'fixes-for-stm32-dwmac-driver-fails-to-probe'
      tools: ynl: use ident name for Family, too.
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      wifi: ath12k: fix build vs old compiler

Patrisious Haddad (1):
      RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded

Paul Barker (7):
      net: ravb: Simplify poll & receive functions
      net: ravb: Align poll function with NAPI docs
      net: ravb: Refactor RX ring refill
      net: ravb: Refactor GbEth RX code path
      net: ravb: Enable SW IRQ Coalescing for GbEth
      net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
      net: ravb: Allocate RX buffers via page pool

Paul Greenwalt (1):
      ice: Allow different FW API versions based on MAC type

Paul Menzel (1):
      Bluetooth: btintel: Fix spelling of *intermediate* in comment

Pavan Chebbi (6):
      bnxt_en: Add BCM5760X specific PHC registers mapping
      bnxt_en: Refactor all PTP TX timestamp fields into a struct
      bnxt_en: Remove an impossible condition check for PTP TX pending SKB
      bnxt_en: Let bnxt_stamp_tx_skb() return error code
      bnxt_en: Increase the max total outstanding PTP TX packets to 4
      bnxt_en: Remove atomic operations on ptp->tx_avail

Pavel Begunkov (5):
      net: always try to set ubuf in skb_zerocopy_iter_stream
      net: split __zerocopy_sg_from_iter()
      net: batch zerocopy_fill_skb_from_iter accounting
      io_uring/net: move charging socket out of zc io_uring
      net: limit scope of a skb_zerocopy_iter_stream var

Pawel Dembicki (8):
      net: dsa: vsc73xx: add port_stp_state_set function
      net: dsa: vsc73xx: Add vlan filtering
      net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
      net: dsa: vsc73xx: Implement the tag_8021q VLAN operations
      net: dsa: Define max num of bridges in tag8021q implementation
      net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
      net: dsa: vsc73xx: Add bridge support
      net: dsa: vsc73xx: start treating the BR_LEARNING flag

Pawel Kaminski (1):
      ice: Add support for devlink local_forwarding param

Peng Fan (1):
      test/vsock: add install target

Petr Machata (18):
      net: ipv4,ipv6: Pass multipath hash computation through a helper
      net: ipv4: Add a sysctl to set multipath hash seed
      mlxsw: spectrum_router: Apply user-defined multipath hash seed
      selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
      selftests: forwarding: router_mpath_hash: Add a new selftest
      selftests: libs: Expand "$@" where possible
      selftests: mirror: Drop direction argument from several functions
      selftests: lib: tc_rule_stats_get(): Move default to argument definition
      selftests: mirror_gre_lag_lacp: Check counters at tunnel
      selftests: mirror: do_test_span_dir_ips(): Install accurate taps
      selftests: mirror: mirror_test(): Allow exact count of packets
      selftests: mirror: Drop dual SW/HW testing
      selftests: mlxsw: mirror_gre: Simplify
      selftests: mirror_gre_lag_lacp: Drop unnecessary code
      selftests: libs: Drop slow_path_trap_install()/_uninstall()
      selftests: libs: Drop unused functions
      selftests: mlxsw: mirror_gre: Obey TESTS
      mlxsw: Warn about invalid accesses to array fields

Phil Sutter (1):
      netfilter: xt_recent: Lift restrictions on max hitcount value

Ping-Ke Shih (21):
      wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume
      wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips
      wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume
      wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
      wifi: rtw89: add LDPC and STBC to rx_status and radiotap known fields for monitor mode
      wifi: rtlwifi: handle return value of usb init TX/RX
      wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
      wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT
      wifi: rtw89: adopt firmware whose version is equal or less but closest
      wifi: rtw89: pci: support 36-bit PCI DMA address
      wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length
      wifi: rtw89: 8852bt: rfk: add TSSI
      wifi: rtw89: 8852bt: rfk: add DPK
      wifi: rtw89: 8852b: set AMSDU limit to 5000
      wifi: rtw89: 8852bt: rfk: add IQK
      wifi: rtw89: 8852bt: rfk: add RX DCK
      wifi: rtw89: 8852bt: rfk: add DACK
      wifi: rtw89: 8852bt: rfk: add RCK
      wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles of BTC for 8852BT in 8852b_common

Piotr Gardocki (1):
      ice: Distinguish driver reset and removal for AQ shutdown

Po-Hao Huang (2):
      wifi: rtw89: fix HW scan not aborting properly
      wifi: rtw89: Fix P2P behavior for WiFi 7 chips

Pradeep Kumar Chitrapu (8):
      wifi: ath12k: add channel 2 into 6 GHz channel list
      wifi: ath12k: Correct 6 GHz frequency value in rx status
      wifi: ath12k: fix survey dump collection in 6 GHz
      wifi: ath12k: add 6 GHz params in peer assoc command
      wifi: ath12k: refactor SMPS configuration
      wifi: ath12k: support SMPS configuration for 6 GHz
      wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
      wifi: ath12k: fix legacy peer association due to missing HT or 6 GHz capabilities

Przemek Kitszel (1):
      ice: do not init struct ice_adapter more times than needed

Pu Lehui (6):
      bpf: Use precise image size for struct_ops trampoline
      riscv, bpf: Fix out-of-bounds issue when preparing trampoline image
      riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
      riscv, bpf: Add 12-argument support for RV64 bpf trampoline
      selftests/bpf: Factor out many args tests from tracing_struct
      selftests/bpf: Add testcase where 7th argment is struct

Puranjay Mohan (4):
      bpf, arm64: Inline bpf_get_current_task/_btf() helpers
      riscv, bpf: Optimize stack usage of trampoline
      selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
      bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG

Rafael Beims (1):
      wifi: mwifiex: Fix interface type change

Rafael Passos (3):
      bpf: remove unused parameter in bpf_jit_binary_pack_finalize
      bpf: remove unused parameter in __bpf_free_used_btfs
      bpf: remove redeclaration of new_n in bpf_verifier_vlog

Rafał Miłecki (1):
      dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema

Rahul Rameshbabu (1):
      net/mlx5e: Support SWP-mode offload L4 csum calculation

Rameshkumar Sundaram (2):
      wifi: ath12k: modify remain on channel for single wiphy
      wifi: ath12k: fix driver initialization for WoW unsupported devices

Ramya Gnanasekar (1):
      wifi: ath12k: Dump additional Tx PDEV HTT stats

Rengarajan S (2):
      lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is detected
      lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801 if NO EEPROM is detected

Rob Herring (Arm) (2):
      dt-bindings: net: wireless: ath11k: Drop "qcom,ipq8074-wcss-pil" from example
      dt-bindings: net: Define properties at top-level

Ronak Doshi (4):
      vmxnet3: prepare for version 9 changes
      vmxnet3: add latency measurement support in vmxnet3
      vmxnet3: add command to allow disabling of offloads
      vmxnet3: update to version 9

Russell King (Oracle) (27):
      net: dsa: remove mac_prepare()/mac_finish() shims
      net: dsa: felix: provide own phylink MAC operations
      net: stmmac: dwxgmac2: remove useless NULL pointer initialisations
      net: stmmac: remove pcs_rane() method
      net: stmmac: remove unnecessary netif_carrier_off()
      net: stmmac: include linux/io.h rather than asm/io.h
      net: stmmac: ethqos: clean up setting serdes speed
      net: phylink: rearrange phylink_parse_mode()
      net: phylink: move test for ovr_an_inband
      net: phylink: rename ovr_an_inband to default_an_inband
      net: fman_memac: remove the now unnecessary checking for fixed-link
      net: stmmac: rename xpcs_an_inband to default_an_inband
      net: stmmac: dwmac-intel: remove checking for fixed link
      net: stmmac: add select_pcs() platform method
      net: stmmac: dwmac-intel: provide a select_pcs() implementation
      net: stmmac: dwmac-rzn1: provide select_pcs() implementation
      net: stmmac: dwmac-socfpga: provide select_pcs() implementation
      net: stmmac: clean up stmmac_mac_select_pcs()
      wifi: wlcore: correctness fix fwlog reading
      wifi: wl18xx: make wl18xx_tx_immediate_complete() more efficient
      wifi: wlcore: improve code in wlcore_fw_status()
      wifi: wlcore: pass "status" to wlcore_hw_convert_fw_status()
      wifi: wlcore: store AP encryption key type
      wifi: wlcore: add pn16 support
      wifi: wl18xx: add support for reading 8.9.1 fw status
      wifi: wl18xx: allow firmwares > 8.9.0.x.58
      net: phy: fix potential use of NULL pointer in phy_suspend()

Sagi Grimberg (2):
      net: micro-optimize skb_datagram_iter
      Revert "net: micro-optimize skb_datagram_iter"

Sai Krishna (1):
      octeontx2-pf: Add ucast filter count configurability via devlink.

Samasth Norway Ananda (1):
      wifi: brcmsmac: LCN PHY code is used for BCM4313 2G-only device

Sascha Hauer (1):
      wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()

Sasha Neftin (1):
      igc: Remove the internal 'eee_advert' field

Sean Anderson (2):
      net: xilinx: axienet: Use NL_SET_ERR_MSG instead of netdev_err
      net: xilinx: axienet: Enable multicast by default

Sean Wang (81):
      wifi: mt76: mt792x: extend mt76_connac_mcu_uni_add_dev for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_set_timing for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_ifs_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
      wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
      wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_set_bss_pm for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_bcnft for per-link BSS
      wifi: mt76: mt7925: extend mt7925_mcu_uni_bss_ps for per-link BSS
      wifi: mt76: mt7925: add mt7925_mcu_bss_rlm_tlv to constitue the RLM TLV
      wifi: mt76: mt7925: mt7925_mcu_set_chctx rely on mt7925_mcu_bss_rlm_tlv
      wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_he_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_vht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
      wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
      wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
      wifi: mt76: mt762x: extend mt76_connac_mcu_sta_basic_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_sta_hdr_trans_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
      wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_assoc to associate per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
      wifi: mt76: mt7925: add mt7925_mac_link_bss_add to create per-link BSS
      wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
      wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
      wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
      wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
      wifi: mt76: mt7925: set Tx queue parameters according to link id
      wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
      wifi: mt76: mt7925: add mt7925_set_link_key
      wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event
      wifi: mt76: mt7925: add mt7925_change_vif_links
      wifi: mt76: mt7925: add mt7925_change_sta_links
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
      wifi: mt76: mt7925: add link handling to txwi
      wifi: mt76: mt7925: add link handling in mt7925_set_key
      wifi: mt76: mt7925: add link handling to mt7925_change_chanctx
      wifi: mt76: mt7925: add link handling in the BSS_CHANGED_PS handler
      wifi: mt76: mt7925: add link handling in mt7925_mcu_set_beacon_filter
      wifi: mt76: mt7925: add link handling in mt7925_txwi_free
      wifi: mt76: mt7925: add link handling in mt7925_mac_sta_assoc
      wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
      wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter
      wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler
      wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
      wifi: mt76: mt7925: update rate index according to link id
      wifi: mt76: mt7925: report link information in rx status
      wifi: mt76: add def_wcid to struct mt76_wcid
      wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
      wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_update for MLO
      wifi: mt76: mt7925: add mt7925_mcu_sta_eht_mld_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
      wifi: mt76: mt7925: update mt7925_mcu_bss_basic_tlv for MLO
      wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
      wifi: mt76: mt7925: remove the unused mt7925_mcu_set_chan_info
      wifi: mt76: mt7925: enabling MLO when the firmware supports it
      Bluetooth: btmtk: add the function to get the fw name
      Bluetooth: btmtk: apply the common btmtk_fw_get_filename

Sebastian Andrzej Siewior (20):
      locking/local_lock: Introduce guard definition for local_lock.
      locking/local_lock: Add local nested BH locking infrastructure.
      net: Use __napi_alloc_frag_align() instead of open coding it.
      net: Use nested-BH locking for napi_alloc_cache.
      net/tcp_sigpool: Use nested-BH locking for sigpool_scratch.
      net/ipv4: Use nested-BH locking for ipv4_tcp_sk.
      netfilter: br_netfilter: Use nested-BH locking for brnf_frag_data_storage.
      net: softnet_data: Make xmit per task.
      dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
      dev: Use nested-BH locking for softnet_data.process_queue.
      lwt: Don't disable migration prio invoking BPF.
      seg6: Use nested-BH locking for seg6_bpf_srh_states.
      net: Use nested-BH locking for bpf_scratchpad.
      net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
      net: Move per-CPU flush-lists to bpf_net_context on PREEMPT_RT.
      net: Remove task_struct::bpf_net_context init on fork.
      net: Optimize xdp_do_flush() with bpf_net_context infos.
      net: Move flush list retrieval to where it is used.
      tun: Assign missing bpf_net_context.
      bpf: Remove tst_run from lwt_seg6local_prog_ops.

Sebastian Gottschall (1):
      wifi: ath10k: add LED and GPIO controlling support for various chipsets

Serge Semin (12):
      net: stmmac: Drop TBI/RTBI PCS flags
      dt-bindings: net: dwmac: Validate PBL for all IP-cores
      net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
      net: pcs: xpcs: Split up xpcs_create() body to sub-functions
      net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
      net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
      net: pcs: xpcs: Introduce DW XPCS info structure
      dt-bindings: net: Add Synopsys DW xPCS bindings
      net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
      net: pcs: xpcs: Add fwnode-based descriptor creation method
      net: stmmac: Create DW XPCS device with particular address
      net: stmmac: Add DW XPCS specified via "pcs-handle" support

Sergey Temerkhanov (3):
      ice: Implement Tx interrupt enablement functions
      ice: Move CGU block
      ice: Introduce ETH56G PHY model for E825C products

Shahar S Matityahu (1):
      wifi: iwlwifi: remove fw_running op

Shannon Nelson (9):
      ionic: fix potential irq name truncation
      ionic: Reset LIF device while restarting LIF
      ionic: only sync frag_len in first buffer of xdp
      ionic: fix up ionic_if.h kernel-doc issues
      ionic: remove missed doorbell per-queue timer
      ionic: add private workqueue per-device
      ionic: add work item for missed-doorbell check
      ionic: add per-queue napi_schedule for doorbell check
      ionic: check for queue deadline in doorbell_napi_work

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: use ROC for P2P device activities

Shay Drory (2):
      driver core: auxiliary bus: show auxiliary device IRQs
      net/mlx5: Expose SFs IRQs

Shengyu Qu (1):
      net: ethernet: mtk_ppe: Change PPE entries number to 16K

Shigeru Yoshida (2):
      tipc: Remove unused struct declaration
      tipc: Consolidate redundant functions

Shradha Gupta (2):
      net: mana: Allow variable size indirection table
      net: mana: Use mana_cleanup_port_context() for rxq cleanup

Shung-Hsi Yu (3):
      bpf: fix overflow check in adjust_jmp_off()
      bpf: use check_add_overflow() to check for addition overflows
      bpf: use check_sub_overflow() to check for subtraction overflows

Simon Horman (2):
      net: tls: Pass union tls_crypto_context pointer to memzero_explicit
      i40e: correct i40e_addr_to_hkey() name in kdoc

Song Liu (1):
      selftests/bpf: Fix bpf_cookie and find_vma in nested VM

Steffen Klassert (3):
      xfrm: Fix unregister netdevice hang on hardware offload.
      xfrm: Export symbol xfrm_dev_state_delete.
      Merge  branch 'Support IPsec crypto offload for IPv6 ESP and IPv4 UDP-encapsulated ESP data paths'

Sven Eckelmann (1):
      wifi: ath12k: Don't drop tx_status in failure case

Sven Peter (1):
      Bluetooth: hci_bcm4377: Use correct unit for timeouts

Swan Beaujard (1):
      bpftool: Fix typo in MAX_NUM_METRICS macro name

Taehee Yoo (2):
      selftests: net: change shebang to bash in amt.sh
      xdp: fix invalid wait context of page_pool_destroy()

Tamizh Chelvam Raja (3):
      wifi: ath12k: fix calling correct function for rx monitor mode
      wifi: ath12k: Remove unsupported tx monitor handling
      wifi: ath12k: Remove unused tcl_*_ring configuration

Tao Chen (1):
      bpftool: Mount bpffs when pinmaps path not under the bpffs

Tariq Toukan (2):
      net/mlx5e: SHAMPO, Use net_prefetch API
      net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split

Tengda Wu (2):
      bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
      selftests/bpf: Test for null-pointer-deref bugfix in resolve_prog_type()

Thomas Weißschuh (6):
      bpf: constify member bpf_sysctl_kern:: Table
      net/neighbour: constify ctl_table arguments of utility function
      net/ipv4/sysctl: constify ctl_table arguments of utility functions
      net/ipv6/addrconf: constify ctl_table arguments of utility functions
      net/ipv6/ndisc: constify ctl_table arguments of utility function
      ipvs: constify ctl_table arguments of utility functions

Thorsten Blum (7):
      net: smc91x: Remove commented out code
      net: smc91x: Fix pointer types
      l2tp: Remove duplicate included header file trace.h
      sctp: Fix typos and improve comments
      udp: Remove duplicate included header file trace/events/udp.h
      net: mvpp2: Improve data types and use min()
      Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls

Tony Nguyen (1):
      net: intel: Remove MODULE_AUTHORs

Tushar Vyavahare (2):
      selftests/xsk: Ensure traffic validation proceeds after ring size adjustment in xskxceiver
      selftests/xsk: Enhance batch size support with dynamic configurations

Uwe Kleine-König (2):
      nfc: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      net: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vadim Fedorenko (9):
      bnxt_en: add timestamping statistics support
      bnxt_en: fix atomic counter for ptp packets
      bpf: Add CHECKSUM_COMPLETE to bpf test progs
      selftests/bpf: Validate CHECKSUM_COMPLETE option
      bpf: verifier: make kfuncs args nullalble
      bpf: crypto: make state and IV dynptr nullable
      selftests: bpf: crypto: use NULL instead of 0-sized dynptr
      selftests: bpf: crypto: adjust bench to use nullable IV
      selftests: bpf: add testmod kfunc for nullable params

Valentin Schneider (1):
      net: tcp/dccp: prepare for tw_timer un-pinning

Venkateswara Naralasetty (1):
      wifi: ath11k: skip status ring entry processing

Vineeth Karumanchi (6):
      dt-bindings: net: xilinx_gmii2rgmii: Add clock support
      net: phy: xilinx-gmii2rgmii: Adopt clock support
      net: macb: queue tie-off or disable during WOL suspend
      net: macb: Enable queue disable
      net: macb: Add ARP support to WOL
      dt-bindings: net: cdns,macb: Deprecate magic-packet property

Vladimir Oltean (18):
      net: dsa: ocelot: use devres in ocelot_ext_probe()
      net: dsa: ocelot: use devres in seville_probe()
      net: dsa: ocelot: delete open coded status = "disabled" parsing
      net: dsa: ocelot: consistently use devres in felix_pci_probe()
      net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
      net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
      net: dsa: ocelot: common probing code
      net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops
      net: phy: introduce core support for phy-mode = "10g-qxgmii"
      dt-bindings: net: ethernet-controller: add 10g-qxgmii mode
      net: dpaa: avoid on-stack arrays of NR_CPUS elements
      net: dpaa: eliminate NR_CPUS dependency in egress_fqs[] and conf_fqs[]
      net: dpaa: stop ignoring TX queues past the number of CPUs
      net: dpaa: no need to make sure all CPUs receive a corresponding Tx queue
      net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
      net: dsa: tag_sja1105: absorb entire sja1105_vlan_rcv() into dsa_8021q_rcv()
      net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
      net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591

Willem de Bruijn (1):
      fou: remove warn in gue_gro_receive on unsupported protocol

Wolfram Sang (6):
      wifi: ath11k: use 'time_left' variable with wait_event_timeout()
      wifi: brcmfmac: use 'time_left' variable with wait_event_timeout()
      wifi: mwl8k: use 'time_left' variable with wait_for_completion_timeout()
      wifi: p54: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      wifi: zd1211rw: use 'time_left' variable with wait_for_completion_timeout()
      wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()

Xiao Wang (4):
      riscv, bpf: Optimize zextw insn with Zba extension
      riscv, bpf: Use STACK_ALIGN macro for size rounding up
      riscv, bpf: Try RVC for reg move within BPF_CMPXCHG JIT
      riscv, bpf: Introduce shift add helper with Zba optimization

Xin Long (1):
      sctp: cancel a blocking accept when shutdown a listen socket

Xuan Zhuo (10):
      virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
      virtio_net: separate virtnet_rx_resize()
      virtio_net: separate virtnet_tx_resize()
      virtio_net: separate receive_buf
      virtio_net: separate receive_mergeable
      virtio_net: xsk: bind/unbind xsk for rx
      virtio_net: xsk: support wakeup
      virtio_net: xsk: rx: support fill with xsk buffer
      virtio_net: xsk: rx: support recv small mode
      virtio_net: xsk: rx: support recv merge mode

Yafang Shao (2):
      bpf: Add bits iterator
      selftests/bpf: Add selftest for bits iter

Yan Zhai (7):
      net: add rx_sk to trace_kfree_skb
      net: introduce sk_skb_reason_drop function
      ping: use sk_skb_reason_drop to free rx packets
      net: raw: use sk_skb_reason_drop to free rx packets
      tcp: use sk_skb_reason_drop to free rx packets
      udp: use sk_skb_reason_drop to free rx packets
      af_packet: use sk_skb_reason_drop to free rx packets

Yedidya Benshimol (1):
      wifi: iwlwifi: remove struct iwl_trans_ops

Yevgeny Kliteynik (1):
      net/mlx5: DR, Remove definer functions from SW Steering API

Ying Hsu (1):
      Bluetooth: Add vendor-specific packet classification for ISO data

Ying Zhang (1):
      bpf: Remove unused variable "prev_state"

Yonghong Song (2):
      selftests/bpf: Ignore .llvm.<hash> suffix in kallsyms_find()
      selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT

Yoray Zack (3):
      net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
      net/mlx5e: SHAMPO, Use KSMs instead of KLMs
      net/mlx5e: SHAMPO, Re-enable HW-GRO

Yujie Liu (1):
      selftests: net: remove unneeded IP_GRE config

Yunjian Wang (1):
      netfilter: nf_conncount: fix wrong variable type

Zhu Jun (1):
      selftests/bpf: Delete extra blank lines in test_sockmap

Zijun Hu (1):
      net: rfkill: Correct return value in invalid parameter case

Ziwei Xiao (1):
      gve: Add adminq mutex lock

Zong-Zhe Yang (9):
      wifi: rtw89: ser: avoid multiple deinit on same CAM
      wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
      wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
      wifi: rtw89: support mac_id number according to chip
      wifi: mac80211: fix NULL dereference at band check in starting tx ba session
      wifi: rtw89: constrain TX power according to Transmit Power Envelope
      wifi: rtw89: mac: parse MRC C2H failure report
      wifi: rtw89: unify the selection logic of RFK table when MCC
      wifi: mac80211: chanctx emulation set CHANGE_CHANNEL when in_reconfig

yunshui (1):
      bpf, net: Use DEV_STAT_INC()

 Documentation/ABI/testing/sysfs-bus-auxiliary      |    9 +
 Documentation/bpf/libbpf/libbpf_overview.rst       |    8 +
 Documentation/bpf/standardization/abi.rst          |    3 +
 .../bpf/standardization/instruction-set.rst        |  333 +-
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  143 +
 Documentation/devicetree/bindings/net/arc_emac.txt |   46 -
 .../net/bluetooth/mediatek,mt7622-bluetooth.yaml   |   51 +
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |    4 +
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   35 +-
 .../devicetree/bindings/net/can/xilinx,can.yaml    |    2 +-
 .../devicetree/bindings/net/cdns,macb.yaml         |    1 +
 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  |  202 +
 .../devicetree/bindings/net/dsa/lantiq-gswip.txt   |  146 -
 .../bindings/net/dsa/mediatek,mt7530.yaml          |    6 +-
 .../bindings/net/dsa/vitesse,vsc73xx.txt           |  129 -
 .../bindings/net/dsa/vitesse,vsc73xx.yaml          |  162 +
 .../bindings/net/ethernet-controller.yaml          |    1 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |    8 +
 .../devicetree/bindings/net/fsl,enetc-ierb.yaml    |   38 +
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml    |   57 +
 .../devicetree/bindings/net/fsl,enetc.yaml         |   66 +
 .../devicetree/bindings/net/fsl,fman-mdio.yaml     |  123 +
 .../devicetree/bindings/net/fsl,fman-muram.yaml    |   40 +
 .../devicetree/bindings/net/fsl,fman-port.yaml     |   75 +
 .../devicetree/bindings/net/fsl,fman.yaml          |  210 +
 .../devicetree/bindings/net/fsl-enetc.txt          |  119 -
 Documentation/devicetree/bindings/net/fsl-fman.txt |  548 ---
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |    2 +-
 .../devicetree/bindings/net/mediatek,net.yaml      |   28 +-
 .../devicetree/bindings/net/mediatek-bluetooth.txt |   36 -
 .../devicetree/bindings/net/mscc,miim.yaml         |   10 +
 .../devicetree/bindings/net/pcs/snps,dw-xpcs.yaml  |  136 +
 .../devicetree/bindings/net/realtek,rtl82xx.yaml   |   40 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |  148 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   49 +-
 .../devicetree/bindings/net/ti,icss-iep.yaml       |    9 +
 .../devicetree/bindings/net/ti,icssg-prueth.yaml   |    9 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |    5 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   46 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    9 -
 .../bindings/net/wireless/qcom,ath12k.yaml         |   99 +
 .../bindings/net/xlnx,gmii-to-rgmii.yaml           |    5 +
 Documentation/devicetree/bindings/ptp/fsl,ptp.yaml |  144 +
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   87 -
 Documentation/netlink/specs/dpll.yaml              |    1 +
 Documentation/netlink/specs/ethtool.yaml           |  144 +
 Documentation/netlink/specs/ovs_flow.yaml          |   17 +
 Documentation/netlink/specs/tc.yaml                |   26 +
 Documentation/netlink/specs/tcp_metrics.yaml       |  169 +
 .../ethernet/mellanox/mlx5/counters.rst            |   24 +-
 Documentation/networking/devlink/ice.rst           |   25 +
 Documentation/networking/devlink/octeontx2.rst     |   16 +
 Documentation/networking/ethtool-netlink.rst       |  165 +-
 Documentation/networking/index.rst                 |    3 +
 Documentation/networking/ip-sysctl.rst             |   27 +
 Documentation/networking/iso15765-2.rst            |  386 ++
 Documentation/networking/mptcp-sysctl.rst          |   74 +-
 Documentation/networking/mptcp.rst                 |  156 +
 Documentation/networking/net_dim.rst               |   42 +
 Documentation/networking/phy.rst                   |    6 +
 Documentation/networking/sriov.rst                 |   25 +
 Documentation/networking/tcp_ao.rst                |    9 +
 MAINTAINERS                                        |   55 +-
 arch/arm/boot/dts/rockchip/rk3066a.dtsi            |    4 -
 arch/arm/boot/dts/rockchip/rk3xxx.dtsi             |    7 +-
 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    |   12 +
 arch/arm64/net/bpf_jit_comp.c                      |   16 +-
 arch/powerpc/net/bpf_jit_comp.c                    |    4 +-
 arch/riscv/Kconfig                                 |   12 +
 arch/riscv/net/bpf_jit.h                           |   51 +
 arch/riscv/net/bpf_jit_comp32.c                    |    3 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  144 +-
 arch/riscv/net/bpf_jit_core.c                      |    5 +-
 arch/s390/net/bpf_jit_comp.c                       |  489 ++-
 arch/x86/net/bpf_jit_comp.c                        |   15 +-
 drivers/base/Makefile                              |    1 +
 drivers/base/auxiliary.c                           |    1 +
 drivers/base/auxiliary_sysfs.c                     |  113 +
 drivers/bluetooth/Kconfig                          |    7 +-
 drivers/bluetooth/btintel.c                        |  244 +-
 drivers/bluetooth/btintel.h                        |   11 +-
 drivers/bluetooth/btintel_pcie.c                   |   10 +-
 drivers/bluetooth/btmtk.c                          | 1085 +++++-
 drivers/bluetooth/btmtk.h                          |  118 +-
 drivers/bluetooth/btmtksdio.c                      |    4 +
 drivers/bluetooth/btmtkuart.c                      |    1 +
 drivers/bluetooth/btnxpuart.c                      |  242 +-
 drivers/bluetooth/btrtl.c                          |    2 +-
 drivers/bluetooth/btusb.c                          |  739 +---
 drivers/bluetooth/hci_bcm4377.c                    |   66 +-
 drivers/bluetooth/hci_ldisc.c                      |    2 +-
 drivers/bluetooth/hci_nokia.c                      |    5 -
 drivers/bluetooth/hci_qca.c                        |  133 +-
 drivers/bluetooth/hci_vhci.c                       |    2 +-
 drivers/crypto/caam/Kconfig                        |    2 +-
 drivers/crypto/caam/caamalg_qi2.c                  |   28 +-
 drivers/crypto/caam/caamalg_qi2.h                  |    2 +-
 drivers/crypto/caam/ctrl.c                         |    2 +
 drivers/crypto/caam/qi.c                           |   43 +-
 drivers/dma/ti/k3-udma-glue.c                      |    3 +
 drivers/infiniband/hw/mana/qp.c                    |   10 +-
 drivers/infiniband/hw/mlx5/counters.c              |    4 +
 drivers/infiniband/hw/mlx5/main.c                  |   19 +-
 drivers/infiniband/hw/mlx5/mem.c                   |  198 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |    3 -
 drivers/infiniband/hw/mlx5/qp.c                    |   16 -
 drivers/isdn/hardware/mISDN/avmfritz.c             |    1 +
 drivers/isdn/hardware/mISDN/hfcmulti.c             |    1 +
 drivers/isdn/hardware/mISDN/hfcpci.c               |    1 +
 drivers/isdn/hardware/mISDN/hfcsusb.c              |    1 +
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        |    1 +
 drivers/isdn/hardware/mISDN/mISDNipac.c            |    1 +
 drivers/isdn/hardware/mISDN/mISDNisar.c            |    1 +
 drivers/isdn/hardware/mISDN/netjet.c               |    1 +
 drivers/isdn/hardware/mISDN/speedfax.c             |    1 +
 drivers/isdn/hardware/mISDN/w6692.c                |    1 +
 drivers/isdn/mISDN/core.c                          |    1 +
 drivers/isdn/mISDN/dsp_blowfish.c                  |    5 -
 drivers/isdn/mISDN/dsp_core.c                      |    1 +
 drivers/isdn/mISDN/l1oip_core.c                    |    1 +
 drivers/net/arcnet/com20020-isa.c                  |    1 +
 drivers/net/bonding/bond_main.c                    |    4 +-
 drivers/net/can/Kconfig                            |    5 +-
 drivers/net/can/dev/dev.c                          |    2 +-
 drivers/net/can/kvaser_pciefd.c                    |  137 +-
 drivers/net/can/m_can/m_can.c                      |  165 +-
 drivers/net/can/m_can/m_can.h                      |    2 +-
 drivers/net/can/m_can/m_can_pci.c                  |    2 +-
 drivers/net/can/m_can/m_can_platform.c             |    2 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   15 +-
 drivers/net/can/mscan/mscan.c                      |    6 -
 drivers/net/can/peak_canfd/peak_canfd.c            |    2 +-
 drivers/net/can/rcar/rcar_canfd.c                  |   41 +-
 drivers/net/can/sja1000/plx_pci.c                  |    3 +-
 drivers/net/can/spi/hi311x.c                       |    7 +-
 drivers/net/can/spi/mcp251x.c                      |   11 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   91 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |    2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |    2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |    5 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c       |  165 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |  129 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |   29 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   56 +-
 drivers/net/can/usb/Kconfig                        |    3 +
 drivers/net/can/usb/gs_usb.c                       |    7 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    9 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |    2 +-
 drivers/net/can/xilinx_can.c                       |    2 +-
 drivers/net/dsa/Kconfig                            |    3 +-
 drivers/net/dsa/hirschmann/hellcreek.h             |    8 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c    |    2 +-
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h    |    2 +-
 drivers/net/dsa/lan9303_i2c.c                      |    2 +-
 drivers/net/dsa/lan9303_mdio.c                     |    8 +-
 drivers/net/dsa/lantiq_gswip.c                     |  123 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c            |    4 +-
 drivers/net/dsa/microchip/ksz_common.c             |   10 +-
 drivers/net/dsa/microchip/ksz_common.h             |    7 +
 drivers/net/dsa/microchip/ksz_ptp.c                |    2 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |    2 +-
 drivers/net/dsa/microchip/lan937x_main.c           |   32 +-
 drivers/net/dsa/microchip/lan937x_reg.h            |    5 +
 drivers/net/dsa/mt7530.c                           |  121 +-
 drivers/net/dsa/mt7530.h                           |    1 +
 drivers/net/dsa/mv88e6xxx/hwtstamp.c               |    2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.h               |    4 +-
 drivers/net/dsa/ocelot/felix.c                     |  114 +-
 drivers/net/dsa/ocelot/felix.h                     |    9 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  112 +-
 drivers/net/dsa/ocelot/ocelot_ext.c                |   54 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |   60 +-
 drivers/net/dsa/qca/ar9331.c                       |    2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |    2 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  118 +-
 drivers/net/dsa/qca/qca8k.h                        |    1 +
 drivers/net/dsa/sja1105/sja1105_main.c             |    8 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |    2 +-
 drivers/net/dsa/sja1105/sja1105_ptp.h              |    2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  735 +++-
 drivers/net/dsa/vitesse-vsc73xx.h                  |   37 +
 drivers/net/dsa/xrs700x/xrs700x_i2c.c              |    4 +-
 drivers/net/ethernet/8390/ne2k-pci.c               |   11 -
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/adaptec/starfire.c            |    8 -
 drivers/net/ethernet/amd/7990.c                    |    1 +
 drivers/net/ethernet/amd/a2065.c                   |    1 +
 drivers/net/ethernet/amd/ariadne.c                 |    1 +
 drivers/net/ethernet/amd/atarilance.c              |    1 +
 drivers/net/ethernet/amd/hplance.c                 |    1 +
 drivers/net/ethernet/amd/lance.c                   |    1 +
 drivers/net/ethernet/amd/mvme147.c                 |    1 +
 drivers/net/ethernet/amd/sun3lance.c               |    1 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |    2 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |    2 +-
 drivers/net/ethernet/arc/Kconfig                   |   10 -
 drivers/net/ethernet/arc/Makefile                  |    1 -
 drivers/net/ethernet/arc/emac_arc.c                |   88 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  810 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   59 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  181 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |  157 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |   44 +-
 drivers/net/ethernet/broadcom/tg3.c                |    2 +-
 drivers/net/ethernet/brocade/bna/bna_types.h       |    2 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   11 +-
 drivers/net/ethernet/cadence/macb.h                |   10 +-
 drivers/net/ethernet/cadence/macb_main.c           |  125 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    6 -
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c |    5 -
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |    2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |   21 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |    2 +-
 drivers/net/ethernet/cirrus/mac89x0.c              |    1 +
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |   25 +-
 drivers/net/ethernet/cortina/gemini.c              |   56 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   76 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |   20 +-
 .../net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c   |    2 -
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   12 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |    2 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |    8 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |   16 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |    2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |    2 +-
 drivers/net/ethernet/google/gve/Makefile           |    2 +-
 drivers/net/ethernet/google/gve/gve.h              |   54 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |  228 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |  103 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   72 +-
 drivers/net/ethernet/google/gve/gve_flow_rule.c    |  298 ++
 drivers/net/ethernet/google/gve/gve_main.c         |   83 +-
 drivers/net/ethernet/hisilicon/hns3/Makefile       |   11 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    2 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |   11 +
 .../hisilicon/hns3/hns3_common/hclge_comm_rss.c    |   14 +
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |    5 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.h |    2 +-
 drivers/net/ethernet/intel/Kconfig                 |   13 +-
 drivers/net/ethernet/intel/e100.c                  |    1 -
 drivers/net/ethernet/intel/e1000/Makefile          |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |    1 -
 drivers/net/ethernet/intel/e1000e/Makefile         |    7 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |    2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    1 -
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |    1 -
 drivers/net/ethernet/intel/i40e/Makefile           |    2 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    1 -
 drivers/net/ethernet/intel/iavf/Makefile           |    5 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    1 -
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  128 +-
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |   61 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |   56 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   63 +-
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h      |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  188 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |   32 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c      |   30 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h      |   15 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |  101 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h       |   20 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |    4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  444 ++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h       |   29 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |    4 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |    4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   26 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   43 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  211 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    1 +
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        | 3268 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |  295 +-
 drivers/net/ethernet/intel/ice/ice_repr.c          |   16 +-
 drivers/net/ethernet/intel/ice/ice_repr.h          |    3 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h       |   10 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   34 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |    8 +
 drivers/net/ethernet/intel/ice/ice_switch.c        |  696 ++--
 drivers/net/ethernet/intel/ice/ice_switch.h        |   20 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |    4 +
 drivers/net/ethernet/intel/ice/ice_trace.h         |   18 +
 drivers/net/ethernet/intel/ice/ice_type.h          |   69 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig            |   26 +
 drivers/net/ethernet/intel/idpf/Makefile           |    3 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   11 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  152 +-
 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h    |    2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   88 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |    1 +
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |  306 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 1424 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |  756 ++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  178 +-
 drivers/net/ethernet/intel/igb/Makefile            |    6 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    5 +-
 drivers/net/ethernet/intel/igbvf/Makefile          |    6 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    1 -
 drivers/net/ethernet/intel/igc/Makefile            |    6 +-
 drivers/net/ethernet/intel/igc/igc.h               |    1 -
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |    8 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    4 -
 drivers/net/ethernet/intel/ixgbe/Makefile          |    8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    1 -
 drivers/net/ethernet/intel/ixgbevf/Makefile        |    6 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    1 -
 drivers/net/ethernet/intel/libeth/Makefile         |    2 +-
 drivers/net/ethernet/intel/libeth/rx.c             |  133 +-
 drivers/net/ethernet/intel/libie/Makefile          |    2 +-
 drivers/net/ethernet/intel/libie/rx.c              |    1 -
 drivers/net/ethernet/lantiq_etop.c                 |    1 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    8 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   66 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    2 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  365 ++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    9 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   64 +
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   20 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   26 +-
 drivers/net/ethernet/mediatek/Kconfig              |   10 +-
 drivers/net/ethernet/mediatek/Makefile             |    1 +
 drivers/net/ethernet/mediatek/airoha_eth.c         | 2730 +++++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  130 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |    8 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h            |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |   17 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c         |   14 +
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   61 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   74 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    4 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    6 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   13 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |  189 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |   56 +
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  224 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  211 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   13 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    3 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   15 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    8 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    2 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   24 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   12 +
 .../mellanox/mlx5/core/steering/dr_types.h         |    5 +
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |  434 +++
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |    1 +
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |   57 +
 drivers/net/ethernet/mellanox/mlxsw/core_env.h     |    6 +
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   51 +-
 drivers/net/ethernet/mellanox/mlxsw/item.h         |    4 +
 drivers/net/ethernet/mellanox/mlxsw/minimal.c      |   19 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  326 +-
 drivers/net/ethernet/mellanox/mlxsw/port.h         |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   31 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |    3 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_atcam.c   |   20 +-
 .../mellanox/mlxsw/spectrum_acl_bloom_filter.c     |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |   13 -
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.h    |    9 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_buffers.c |    8 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_dpipe.c   |    8 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   17 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h |   10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |    6 +-
 drivers/net/ethernet/meta/Kconfig                  |   31 +
 drivers/net/ethernet/meta/Makefile                 |    6 +
 drivers/net/ethernet/meta/fbnic/Makefile           |   19 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |  144 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |  838 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |   88 +
 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h    |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  791 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |  124 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        |  208 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |  666 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |   86 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  488 +++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   63 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  564 +++
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |  161 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |  651 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h        |  189 +
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c        |  529 +++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h        |  175 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       | 1913 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |  127 +
 drivers/net/ethernet/microchip/encx24j600-regmap.c |    6 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    2 +-
 .../ethernet/microchip/lan966x/lan966x_ethtool.c   |   10 +-
 .../ethernet/microchip/lan966x/lan966x_vcap_impl.c |    2 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |    2 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |    2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |    2 +-
 .../microchip/vcap/vcap_api_debugfs_kunit.c        |    2 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |    2 +-
 drivers/net/ethernet/microsoft/Kconfig             |    2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   10 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   14 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   99 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   27 +-
 drivers/net/ethernet/microsoft/mana/shm_channel.c  |   13 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |    2 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             |    2 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |    4 +
 drivers/net/ethernet/pensando/ionic/ionic.h        |    7 +
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |    8 +
 .../net/ethernet/pensando/ionic/ionic_debugfs.c    |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  129 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    8 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   13 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |  237 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  151 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |   12 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   56 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    |    7 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c        |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.h        |    2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   12 +-
 drivers/net/ethernet/renesas/Kconfig               |   11 +
 drivers/net/ethernet/renesas/Makefile              |    2 +
 drivers/net/ethernet/renesas/ravb.h                |   15 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  564 +--
 drivers/net/ethernet/renesas/rswitch.c             |    2 +-
 drivers/net/ethernet/renesas/rtsn.c                | 1391 +++++++
 drivers/net/ethernet/renesas/rtsn.h                |  464 +++
 drivers/net/ethernet/sfc/ef10.c                    |    2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c           |    4 +
 drivers/net/ethernet/sfc/efx.c                     |    2 +-
 drivers/net/ethernet/sfc/efx.h                     |    2 +-
 drivers/net/ethernet/sfc/efx_common.c              |   10 +-
 drivers/net/ethernet/sfc/ethtool.c                 |    6 +-
 drivers/net/ethernet/sfc/ethtool_common.c          |  168 +-
 drivers/net/ethernet/sfc/ethtool_common.h          |   12 +
 drivers/net/ethernet/sfc/falcon/falcon.c           |    2 +-
 drivers/net/ethernet/sfc/falcon/nic.h              |    2 +-
 drivers/net/ethernet/sfc/mcdi_filters.c            |  135 +-
 drivers/net/ethernet/sfc/mcdi_filters.h            |    8 +-
 drivers/net/ethernet/sfc/net_driver.h              |   28 +-
 drivers/net/ethernet/sfc/ptp.c                     |    2 +-
 drivers/net/ethernet/sfc/ptp.h                     |    5 +-
 drivers/net/ethernet/sfc/rx_common.c               |   64 +-
 drivers/net/ethernet/sfc/rx_common.h               |    8 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |    2 +-
 drivers/net/ethernet/sfc/siena/ptp.c               |    2 +-
 drivers/net/ethernet/sfc/siena/ptp.h               |    4 +-
 drivers/net/ethernet/sfc/tc.c                      |    5 +-
 drivers/net/ethernet/smsc/smc9194.c                |    1 +
 drivers/net/ethernet/smsc/smc91x.c                 |    4 -
 drivers/net/ethernet/smsc/smc91x.h                 |    4 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   28 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   58 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |    7 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    7 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  259 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |    8 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    8 -
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |    6 -
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    3 -
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   84 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   32 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |   17 -
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   10 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |    5 -
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c  |    7 +-
 drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c     |    5 -
 drivers/net/ethernet/tehuti/Kconfig                |   15 +
 drivers/net/ethernet/tehuti/Makefile               |    3 +
 drivers/net/ethernet/tehuti/tn40.c                 | 1850 +++++++++
 drivers/net/ethernet/tehuti/tn40.h                 |  233 ++
 drivers/net/ethernet/tehuti/tn40_mdio.c            |  142 +
 drivers/net/ethernet/tehuti/tn40_phy.c             |   76 +
 drivers/net/ethernet/tehuti/tn40_regs.h            |  245 ++
 drivers/net/ethernet/ti/Kconfig                    |    2 +
 drivers/net/ethernet/ti/Makefile                   |   31 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   11 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |    2 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |    4 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    2 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |   92 +-
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |    6 +
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   56 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c       |  341 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h       |   26 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |    3 +-
 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c      |    4 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  316 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   58 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |   65 +-
 drivers/net/ethernet/ti/icssg/icssg_queues.c       |    2 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |    3 +-
 drivers/net/ethernet/ti/icssg/icssg_switchdev.c    |  477 +++
 drivers/net/ethernet/ti/icssg/icssg_switchdev.h    |   13 +
 drivers/net/ethernet/ti/netcp_ethss.c              |    4 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   39 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   32 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   62 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   56 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |    4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |    2 +-
 drivers/net/ethernet/wangxun/txgbe/Makefile        |    1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |  427 +++
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c    |  643 ++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h    |   20 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   18 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |  147 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    7 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |    2 +-
 drivers/net/fjes/fjes_trace.h                      |    2 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/mctp/mctp-i2c.c                        |   45 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |    8 +
 drivers/net/netconsole.c                           |    9 +-
 drivers/net/netdevsim/ethtool.c                    |    2 +-
 drivers/net/pcs/Kconfig                            |    6 +-
 drivers/net/pcs/Makefile                           |    3 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |  460 +++
 drivers/net/pcs/pcs-xpcs.c                         |  365 +-
 drivers/net/pcs/pcs-xpcs.h                         |    7 +-
 drivers/net/phy/aquantia/Makefile                  |    2 +-
 drivers/net/phy/aquantia/aquantia.h                |   79 +
 drivers/net/phy/aquantia/aquantia_firmware.c       |    4 +
 drivers/net/phy/aquantia/aquantia_leds.c           |  150 +
 drivers/net/phy/aquantia/aquantia_main.c           |  140 +-
 drivers/net/phy/bcm-phy-lib.c                      |  115 +
 drivers/net/phy/bcm-phy-lib.h                      |    4 +
 drivers/net/phy/bcm-phy-ptp.c                      |    5 +-
 drivers/net/phy/broadcom.c                         |  417 +-
 drivers/net/phy/dp83640.c                          |    4 +-
 drivers/net/phy/dp83td510.c                        |  264 ++
 drivers/net/phy/micrel.c                           |   10 +-
 drivers/net/phy/microchip.c                        |  126 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |    5 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |    5 +-
 drivers/net/phy/phy-core.c                         |    4 +-
 drivers/net/phy/phy.c                              |    2 +-
 drivers/net/phy/phy_device.c                       |    9 +-
 drivers/net/phy/phylink.c                          |   22 +-
 drivers/net/phy/realtek.c                          |  114 +
 drivers/net/phy/xilinx_gmii2rgmii.c                |    7 +
 drivers/net/pse-pd/pd692x0.c                       |  321 +-
 drivers/net/pse-pd/pse_core.c                      |  176 +-
 drivers/net/pse-pd/tps23881.c                      |    4 +-
 drivers/net/tun.c                                  |    7 +
 drivers/net/usb/cdc_ncm.c                          |   47 +-
 drivers/net/usb/lan78xx.c                          |   12 +-
 drivers/net/usb/r8152.c                            |   21 +
 drivers/net/usb/smsc75xx.c                         |    5 -
 drivers/net/virtio_net.c                           |  914 ++++-
 drivers/net/vmxnet3/Makefile                       |    2 +-
 drivers/net/vmxnet3/vmxnet3_defs.h                 |   61 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  217 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              |    2 +-
 drivers/net/vmxnet3/vmxnet3_int.h                  |   33 +-
 drivers/net/vrf.c                                  |   56 +-
 drivers/net/wireless/admtek/adm8211.c              |    2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |    2 +-
 drivers/net/wireless/ath/ath10k/Kconfig            |    6 +
 drivers/net/wireless/ath/ath10k/Makefile           |    1 +
 drivers/net/wireless/ath/ath10k/core.c             |   32 +
 drivers/net/wireless/ath/ath10k/core.h             |    8 +
 drivers/net/wireless/ath/ath10k/hw.h               |    1 +
 drivers/net/wireless/ath/ath10k/leds.c             |   90 +
 drivers/net/wireless/ath/ath10k/leds.h             |   34 +
 drivers/net/wireless/ath/ath10k/mac.c              |    3 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |   11 +
 drivers/net/wireless/ath/ath10k/qmi.h              |    1 +
 drivers/net/wireless/ath/ath10k/wmi-ops.h          |   32 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |    2 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   54 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   35 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   57 +-
 drivers/net/wireless/ath/ath11k/ce.h               |    6 +-
 drivers/net/wireless/ath/ath11k/core.c             |   49 +-
 drivers/net/wireless/ath/ath11k/core.h             |    9 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    6 +-
 drivers/net/wireless/ath/ath11k/dp.c               |   12 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  107 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h            |    3 +
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   22 +-
 drivers/net/wireless/ath/ath11k/dp_tx.h            |    4 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   16 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    2 +
 drivers/net/wireless/ath/ath11k/hal_tx.h           |    4 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  198 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   22 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   18 +-
 drivers/net/wireless/ath/ath11k/reg.h              |    4 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |    2 +
 drivers/net/wireless/ath/ath12k/ce.h               |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  211 +-
 drivers/net/wireless/ath/ath12k/core.h             |   74 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    3 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   19 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |    6 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1540 ++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  567 +++
 drivers/net/wireless/ath/ath12k/dp.c               |   83 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    5 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   40 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  169 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 +
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  169 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    5 +-
 drivers/net/wireless/ath/ath12k/hal.c              |    5 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   21 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   73 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h           |    4 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    9 +
 drivers/net/wireless/ath/ath12k/htc.c              |    6 +
 drivers/net/wireless/ath/ath12k/hw.c               |   23 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    6 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  852 ++++-
 drivers/net/wireless/ath/ath12k/mac.h              |    5 +
 drivers/net/wireless/ath/ath12k/mhi.c              |   11 +
 drivers/net/wireless/ath/ath12k/pci.c              |   39 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    1 +
 drivers/net/wireless/ath/ath12k/qmi.c              |    8 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   19 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  783 +++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  632 ++-
 drivers/net/wireless/ath/ath12k/wow.c              | 1026 +++++
 drivers/net/wireless/ath/ath12k/wow.h              |   62 +
 drivers/net/wireless/ath/ath5k/base.c              |    2 +-
 drivers/net/wireless/ath/ath5k/base.h              |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |    2 +-
 drivers/net/wireless/ath/carl9170/main.c           |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    2 +-
 drivers/net/wireless/ath/wil6210/netdev.c          |   21 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |    2 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   58 +-
 drivers/net/wireless/atmel/at76c50x-usb.h          |    2 +-
 drivers/net/wireless/broadcom/b43/main.c           |    2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/btcoex.c  |    4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   10 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |    5 -
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    6 +-
 .../wireless/broadcom/brcm80211/brcmsmac/aiutils.c |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/antsel.c  |    2 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    5 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |   29 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |    4 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |   24 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c         |    4 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |    3 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    4 +-
 drivers/net/wireless/intel/iwlegacy/4965.h         |    2 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |    3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/Makefile    |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h       |   21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |    2 +-
 .../iwlwifi/{iwl-eeprom-parse.c => dvm/eeprom.c}   |  480 ++-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c        |   21 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/binding.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |   69 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   27 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   43 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    3 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |  159 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   62 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   19 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   16 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   19 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   19 +-
 .../net/wireless/intel/iwlwifi/iwl-devtrace-data.h |    4 +-
 .../wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   16 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-read.c   |  394 --
 .../net/wireless/intel/iwlwifi/iwl-eeprom-read.h   |   12 -
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   34 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h |   21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   42 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c |  118 +
 .../{iwl-eeprom-parse.h => iwl-nvm-utils.h}        |   17 -
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  448 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  657 +---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   85 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   38 +
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  231 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  303 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   53 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  420 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  147 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  120 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   82 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |  139 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   41 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |   34 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  201 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   62 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   40 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    7 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   86 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  292 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |    9 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  295 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 1185 +++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 1222 +++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      | 1900 ---------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |  191 -
 drivers/net/wireless/intersil/p54/fwio.c           |    6 +-
 drivers/net/wireless/intersil/p54/main.c           |    2 +-
 drivers/net/wireless/intersil/p54/p54pci.c         |    8 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |   10 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +
 drivers/net/wireless/marvell/mwifiex/main.h        |    3 +
 drivers/net/wireless/marvell/mwl8k.c               |   14 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c       |    6 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   31 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |    9 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    5 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   58 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   66 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  147 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   46 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    5 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    6 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  141 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 1139 ++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  981 +++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   65 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   31 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    5 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |  109 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  111 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |    7 +-
 drivers/net/wireless/mediatek/mt76/pci.c           |   23 +
 drivers/net/wireless/mediatek/mt7601u/main.c       |    2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   29 -
 drivers/net/wireless/microchip/wilc1000/fw.h       |   13 +
 drivers/net/wireless/microchip/wilc1000/hif.c      |    4 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |    2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   76 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    3 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |  145 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |   17 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   57 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |    2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.h         |    2 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |   12 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |   15 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    8 +-
 drivers/net/wireless/realtek/rtlwifi/Kconfig       |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    3 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  |   94 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   28 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |   92 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   22 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192du/Makefile    |   13 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.c    |  120 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.h    |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.c    |   63 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.h    |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.c    | 1212 ++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.h    |   22 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.c   |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.h   |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   | 3123 +++++++++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |   32 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.c    |  240 ++
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.h    |   11 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |  395 ++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.c | 1675 ++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.h |   29 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.c   |  372 ++
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.h   |   60 +
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   36 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   12 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    9 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    2 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   17 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    2 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   31 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |    4 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    6 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   80 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   27 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    4 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   29 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  128 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   58 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   45 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  145 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   10 +
 drivers/net/wireless/realtek/rtw89/mac.c           |  124 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   11 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   45 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   20 -
 drivers/net/wireless/realtek/rtw89/pci.c           |  165 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  109 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   17 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   56 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  190 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      | 1873 +--------
 drivers/net/wireless/realtek/rtw89/rtw8852b.h      |  122 -
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   | 2053 ++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |  388 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |   13 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 4019 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   22 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.c   |  490 +++
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.h   |   38 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    8 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    4 +
 drivers/net/wireless/realtek/rtw89/util.c          |  106 +
 drivers/net/wireless/realtek/rtw89/util.h          |    5 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   33 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   30 +
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    3 +-
 drivers/net/wireless/silabs/wfx/sta.c              |    2 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    2 +-
 drivers/net/wireless/st/cw1200/sta.c               |    2 +-
 drivers/net/wireless/st/cw1200/sta.h               |    2 +-
 drivers/net/wireless/ti/wl1251/main.c              |    2 +-
 drivers/net/wireless/ti/wl18xx/main.c              |   71 +-
 drivers/net/wireless/ti/wl18xx/tx.c                |   13 +-
 drivers/net/wireless/ti/wl18xx/wl18xx.h            |   62 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |    9 +
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |  103 +-
 drivers/net/wireless/ti/wlcore/wlcore_i.h          |    4 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   79 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    8 +-
 drivers/net/wireless/virtual/virt_wifi.c           |   20 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.h       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   10 +-
 drivers/nfc/microread/i2c.c                        |    2 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    2 +-
 drivers/nfc/nxp-nci/i2c.c                          |    2 +-
 drivers/nfc/pn533/i2c.c                            |    2 +-
 drivers/nfc/pn544/i2c.c                            |    2 +-
 drivers/nfc/s3fwrn5/i2c.c                          |    2 +-
 drivers/nfc/st-nci/i2c.c                           |    2 +-
 drivers/nfc/st21nfca/i2c.c                         |    2 +-
 drivers/power/Kconfig                              |    1 +
 drivers/power/Makefile                             |    1 +
 drivers/power/sequencing/Kconfig                   |   29 +
 drivers/power/sequencing/Makefile                  |    6 +
 drivers/power/sequencing/core.c                    | 1105 ++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  336 ++
 drivers/ptp/ptp_ines.c                             |    2 +-
 drivers/s390/net/lcs.c                             |    3 +-
 drivers/s390/net/qeth_ethtool.c                    |    2 +-
 drivers/soc/fsl/Kconfig                            |    2 +-
 drivers/soc/fsl/qbman/Kconfig                      |    2 +-
 drivers/staging/vt6655/device_main.c               |    2 +-
 drivers/staging/vt6656/main_usb.c                  |    2 +-
 fs/verity/measure.c                                |    5 +-
 include/linux/auxiliary_bus.h                      |   24 +
 include/linux/bpf.h                                |   34 +-
 include/linux/bpf_verifier.h                       |   14 +-
 include/linux/brcmphy.h                            |   88 +
 include/linux/btf.h                                |   65 +
 include/linux/cache.h                              |   59 +
 include/linux/can/dev.h                            |    2 +-
 include/linux/dim.h                                |  113 +
 include/linux/dsa/8021q.h                          |    8 +-
 include/linux/dsa/lan9303.h                        |    4 +-
 include/linux/ethtool.h                            |  179 +-
 include/linux/filter.h                             |  130 +-
 include/linux/ieee80211.h                          |  290 +-
 include/linux/local_lock.h                         |   21 +
 include/linux/local_lock_internal.h                |   31 +
 include/linux/lockdep.h                            |    3 +
 include/linux/math64.h                             |   28 +
 include/linux/mii_timestamper.h                    |    2 +-
 include/linux/mlx5/device.h                        |    1 +
 include/linux/mlx5/driver.h                        |   11 +
 include/linux/mlx5/mlx5_ifc.h                      |   31 +-
 include/linux/module.h                             |    2 +
 include/linux/net_tstamp.h                         |    9 +
 include/linux/netdevice.h                          |   86 +-
 include/linux/netdevice_xmit.h                     |   13 +
 include/linux/netlink.h                            |    1 -
 include/linux/objagg.h                             |    1 -
 include/linux/pci_ids.h                            |    4 +
 include/linux/pcs/pcs-xpcs.h                       |   49 +-
 include/linux/phy.h                                |   25 +-
 include/linux/phylink.h                            |    6 +-
 include/linux/pse-pd/pse.h                         |   51 +
 include/linux/pwrseq/consumer.h                    |   56 +
 include/linux/pwrseq/provider.h                    |   75 +
 include/linux/sched.h                              |    8 +-
 include/linux/sfp.h                                |    6 +
 include/linux/skbuff.h                             |  101 +-
 include/linux/skbuff_ref.h                         |    4 +-
 include/linux/socket.h                             |    2 +-
 include/linux/stmmac.h                             |    8 +-
 include/net/af_unix.h                              |   14 -
 include/net/bluetooth/bluetooth.h                  |    4 +
 include/net/bluetooth/hci_core.h                   |    7 +-
 include/net/bluetooth/hci_sock.h                   |    2 +-
 include/net/bluetooth/hci_sync.h                   |   26 +
 include/net/bluetooth/rfcomm.h                     |    2 +-
 include/net/caif/caif_layer.h                      |    2 -
 include/net/cfg80211.h                             |  245 +-
 include/net/devlink.h                              |    4 +-
 include/net/dsa.h                                  |   10 +-
 include/net/flow_dissector.h                       |   23 +-
 include/net/flow_offload.h                         |   35 +
 include/net/ieee80211_radiotap.h                   |    1 +
 include/net/inet_frag.h                            |    4 +-
 include/net/inet_timewait_sock.h                   |   11 +-
 include/net/ip.h                                   |    3 +-
 include/net/ip6_route.h                            |   22 +-
 include/net/ip_fib.h                               |   28 +
 include/net/ipv6_stubs.h                           |    3 +
 include/net/libeth/cache.h                         |   66 +
 include/net/libeth/rx.h                            |   19 +
 include/net/llc_c_st.h                             |    4 +-
 include/net/llc_s_st.h                             |    4 +-
 include/net/mac80211.h                             |   73 +-
 include/net/mana/gdma.h                            |   14 +-
 include/net/mana/mana.h                            |   12 +-
 include/net/netdev_queues.h                        |    2 +
 include/net/netfilter/nf_flow_table.h              |   15 +
 include/net/netfilter/nf_tables.h                  |  222 +-
 include/net/netmem.h                               |   15 +
 include/net/netns/ipv4.h                           |    9 +
 include/net/netns/xfrm.h                           |    1 +
 include/net/page_pool/helpers.h                    |   93 +-
 include/net/page_pool/types.h                      |   37 +-
 include/net/psample.h                              |   13 +-
 include/net/regulatory.h                           |    2 -
 include/net/request_sock.h                         |   37 +-
 include/net/sctp/stream_sched.h                    |    8 +-
 include/net/seg6.h                                 |    7 +
 include/net/seg6_hmac.h                            |    7 +
 include/net/seg6_local.h                           |    1 +
 include/net/sock.h                                 |    7 +-
 include/net/tcp.h                                  |  111 +-
 include/net/tcp_ao.h                               |   42 +-
 include/net/xdp_sock.h                             |   14 +-
 include/net/xfrm.h                                 |   46 +-
 include/soc/mscc/ocelot.h                          |    2 +-
 include/trace/events/page_pool.h                   |   30 +-
 include/trace/events/skb.h                         |   11 +-
 include/trace/events/tcp.h                         |  317 ++
 include/uapi/linux/bpf.h                           |   17 +-
 include/uapi/linux/can/isotp.h                     |    2 +-
 include/uapi/linux/ethtool.h                       |  210 +
 include/uapi/linux/ethtool_netlink.h               |   53 +
 include/uapi/linux/in.h                            |    2 +
 include/uapi/linux/netfilter/nf_tables.h           |    2 +-
 include/uapi/linux/nl80211.h                       |   71 +
 include/uapi/linux/openvswitch.h                   |   31 +-
 include/uapi/linux/pkt_cls.h                       |   10 +
 include/uapi/linux/psample.h                       |   11 +-
 include/uapi/linux/tcp_metrics.h                   |   22 +-
 include/uapi/linux/xfrm.h                          |    1 +
 io_uring/net.c                                     |   16 +-
 kernel/bpf/Makefile                                |    8 +-
 kernel/bpf/bpf_lsm.c                               |    1 +
 kernel/bpf/bpf_struct_ops.c                        |   77 +-
 kernel/bpf/btf.c                                   |  511 ++-
 kernel/bpf/core.c                                  |    8 +-
 kernel/bpf/cpumap.c                                |   35 +-
 kernel/bpf/crypto.c                                |   42 +-
 kernel/bpf/devmap.c                                |   57 +-
 kernel/bpf/helpers.c                               |  164 +-
 kernel/bpf/log.c                                   |    6 +-
 kernel/bpf/syscall.c                               |   34 +-
 kernel/bpf/task_iter.c                             |    9 +-
 kernel/bpf/verifier.c                              |  324 +-
 kernel/locking/spinlock.c                          |    8 +
 kernel/module/main.c                               |    5 +-
 kernel/trace/bpf_trace.c                           |   15 +-
 lib/Kconfig                                        |    1 +
 lib/dim/net_dim.c                                  |  144 +-
 lib/objagg.c                                       |   20 +-
 lib/test_bpf.c                                     |   11 +
 lib/test_objagg.c                                  |    2 +-
 net/8021q/vlan_dev.c                               |    2 +-
 net/Kconfig                                        |   13 +-
 net/atm/ioctl.c                                    |    4 +-
 net/bluetooth/Makefile                             |    3 +-
 net/bluetooth/hci_conn.c                           |    1 -
 net/bluetooth/hci_core.c                           |   95 +-
 net/bluetooth/hci_debugfs.c                        |    1 -
 net/bluetooth/hci_event.c                          |    3 +-
 net/bluetooth/hci_request.c                        |  903 -----
 net/bluetooth/hci_request.h                        |   71 -
 net/bluetooth/hci_sync.c                           |  103 +-
 net/bluetooth/iso.c                                |    5 -
 net/bluetooth/mgmt.c                               |   51 +-
 net/bluetooth/msft.c                               |    1 -
 net/bluetooth/rfcomm/tty.c                         |   23 +-
 net/bpf/bpf_dummy_struct_ops.c                     |    4 +-
 net/bpf/test_run.c                                 |   44 +-
 net/bridge/br_forward.c                            |    4 +-
 net/bridge/br_netfilter_hooks.c                    |   20 +-
 net/bridge/br_netlink_tunnel.c                     |    4 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |    6 +-
 net/caif/cfpkt_skbuff.c                            |    7 -
 net/can/Kconfig                                    |   11 +-
 net/can/isotp.c                                    |   11 +-
 net/core/datagram.c                                |   47 +-
 net/core/dev.c                                     |  192 +-
 net/core/dev.h                                     |   22 +
 net/core/dev_ioctl.c                               |    9 +-
 net/core/drop_monitor.c                            |    9 +-
 net/core/filter.c                                  |  210 +-
 net/core/flow_dissector.c                          |   62 +-
 net/core/gen_estimator.c                           |    2 +-
 net/core/lwt_bpf.c                                 |    9 +-
 net/core/neighbour.c                               |    2 +-
 net/core/net-sysfs.c                               |    2 +-
 net/core/page_pool.c                               |  316 +-
 net/core/rtnetlink.c                               |   27 +-
 net/core/skbuff.c                                  |   76 +-
 net/core/sock.c                                    |   35 +-
 net/core/sock_diag.c                               |    8 +-
 net/core/sysctl_net_core.c                         |   75 +-
 net/core/timestamping.c                            |    5 +-
 net/core/xdp.c                                     |    4 +-
 net/dccp/minisocks.c                               |    9 +-
 net/devlink/dpipe.c                                |    2 +-
 net/dsa/Kconfig                                    |    8 +-
 net/dsa/Makefile                                   |    1 +
 net/dsa/dsa.c                                      |    2 -
 net/dsa/port.c                                     |   72 +-
 net/dsa/tag_8021q.c                                |   86 +-
 net/dsa/tag_8021q.h                                |    7 +-
 net/dsa/tag_ocelot_8021q.c                         |    2 +-
 net/dsa/tag_sja1105.c                              |   70 +-
 net/dsa/tag_vsc73xx_8021q.c                        |   68 +
 net/dsa/user.c                                     |  109 +-
 net/dsa/user.h                                     |    2 +
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/cabletest.c                            |    4 -
 net/ethtool/channels.c                             |    6 +-
 net/ethtool/cmis.h                                 |  124 +
 net/ethtool/cmis_cdb.c                             |  602 +++
 net/ethtool/cmis_fw_update.c                       |  399 ++
 net/ethtool/coalesce.c                             |  274 +-
 net/ethtool/common.c                               |   76 +-
 net/ethtool/common.h                               |    4 +-
 net/ethtool/eeprom.c                               |    6 +
 net/ethtool/ioctl.c                                |  192 +-
 net/ethtool/module.c                               |  394 ++
 net/ethtool/module_fw.h                            |   75 +
 net/ethtool/netlink.c                              |   56 +
 net/ethtool/netlink.h                              |   16 +
 net/ethtool/pse-pd.c                               |  125 +-
 net/ethtool/tsinfo.c                               |    6 +-
 net/ethtool/wol.c                                  |    2 +-
 net/hsr/hsr_device.c                               |   63 +-
 net/hsr/hsr_forward.c                              |   41 +-
 net/hsr/hsr_framereg.c                             |   12 +
 net/hsr/hsr_framereg.h                             |    2 +
 net/hsr/hsr_main.h                                 |    4 +-
 net/hsr/hsr_netlink.c                              |    1 +
 net/ieee802154/6lowpan/reassembly.c                |    2 +-
 net/ipv4/bpf_tcp_ca.c                              |    6 +-
 net/ipv4/cipso_ipv4.c                              |    2 +-
 net/ipv4/esp4.c                                    |   11 +-
 net/ipv4/esp4_offload.c                            |   24 +-
 net/ipv4/fib_semantics.c                           |   18 +-
 net/ipv4/fou_core.c                                |    2 +-
 net/ipv4/inet_connection_sock.c                    |   58 +
 net/ipv4/inet_fragment.c                           |    2 +-
 net/ipv4/inet_timewait_sock.c                      |   63 +-
 net/ipv4/ip_fragment.c                             |    2 +-
 net/ipv4/ip_output.c                               |   14 +-
 net/ipv4/ip_tunnel.c                               |   10 +-
 net/ipv4/metrics.c                                 |    8 +-
 net/ipv4/ping.c                                    |    2 +-
 net/ipv4/raw.c                                     |    6 +-
 net/ipv4/route.c                                   |   16 +-
 net/ipv4/syncookies.c                              |    2 +-
 net/ipv4/sysctl_net_ipv4.c                         |   80 +-
 net/ipv4/tcp.c                                     |  112 +-
 net/ipv4/tcp_ao.c                                  |   24 +-
 net/ipv4/tcp_cong.c                                |   20 +-
 net/ipv4/tcp_fastopen.c                            |    7 +-
 net/ipv4/tcp_input.c                               |   87 +-
 net/ipv4/tcp_ipv4.c                                |   60 +-
 net/ipv4/tcp_minisocks.c                           |   46 +-
 net/ipv4/tcp_output.c                              |   27 +-
 net/ipv4/tcp_sigpool.c                             |   17 +-
 net/ipv4/tcp_timer.c                               |    6 +-
 net/ipv4/udp.c                                     |   15 +-
 net/ipv4/udp_offload.c                             |    8 +
 net/ipv6/addrconf.c                                |   11 +-
 net/ipv6/af_inet6.c                                |    3 +-
 net/ipv6/esp6.c                                    |    3 +-
 net/ipv6/esp6_offload.c                            |    7 +
 net/ipv6/ip6_fib.c                                 |    2 +-
 net/ipv6/ip6_output.c                              |   12 +-
 net/ipv6/ipv6_sockglue.c                           |    3 +-
 net/ipv6/ndisc.c                                   |    2 +-
 net/ipv6/netfilter.c                               |    6 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    2 +-
 net/ipv6/raw.c                                     |   10 +-
 net/ipv6/reassembly.c                              |    2 +-
 net/ipv6/route.c                                   |   27 +-
 net/ipv6/seg6.c                                    |   35 +-
 net/ipv6/seg6_local.c                              |   22 +-
 net/ipv6/syncookies.c                              |    2 +-
 net/ipv6/tcp_ipv6.c                                |   34 +-
 net/ipv6/udp.c                                     |   14 +-
 net/ipv6/xfrm6_policy.c                            |    7 +
 net/l2tp/l2tp_core.c                               |  539 +--
 net/l2tp/l2tp_core.h                               |   43 +-
 net/l2tp/l2tp_debugfs.c                            |   13 +-
 net/l2tp/l2tp_ip.c                                 |    2 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/l2tp/l2tp_netlink.c                            |    6 +-
 net/l2tp/l2tp_ppp.c                                |    6 +-
 net/llc/llc_c_st.c                                 |  500 +--
 net/llc/llc_conn.c                                 |   20 +-
 net/llc/llc_s_st.c                                 |   26 +-
 net/llc/llc_sap.c                                  |   12 +-
 net/mac80211/agg-tx.c                              |    4 +-
 net/mac80211/cfg.c                                 |  168 +-
 net/mac80211/chan.c                                |  323 +-
 net/mac80211/debugfs.c                             |    1 -
 net/mac80211/driver-ops.c                          |    6 +-
 net/mac80211/driver-ops.h                          |   14 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ibss.c                                |   11 +-
 net/mac80211/ieee80211_i.h                         |   70 +-
 net/mac80211/iface.c                               |   73 +-
 net/mac80211/link.c                                |   20 +-
 net/mac80211/main.c                                |   58 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mlme.c                                | 1081 ++++--
 net/mac80211/offchannel.c                          |   35 +-
 net/mac80211/parse.c                               |  100 +-
 net/mac80211/pm.c                                  |    4 +-
 net/mac80211/rx.c                                  |    7 +-
 net/mac80211/spectmgmt.c                           |   23 +-
 net/mac80211/sta_info.h                            |    6 +
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/tpe.c                           |  284 ++
 net/mac80211/trace.h                               |   15 +-
 net/mac80211/tx.c                                  |    6 +-
 net/mac80211/util.c                                |  187 +-
 net/mac80211/vht.c                                 |   75 +-
 net/mptcp/protocol.c                               |    8 +-
 net/mptcp/protocol.h                               |    5 +
 net/mptcp/sockopt.c                                |    2 +-
 net/mptcp/subflow.c                                |    2 +-
 net/netfilter/Makefile                             |    7 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    7 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |    4 +-
 net/netfilter/nf_conncount.c                       |    8 +-
 net/netfilter/nf_conntrack_bpf.c                   |   68 +-
 net/netfilter/nf_flow_table_bpf.c                  |  121 +
 net/netfilter/nf_flow_table_inet.c                 |    2 +-
 net/netfilter/nf_flow_table_offload.c              |    2 +-
 net/netfilter/nf_flow_table_xdp.c                  |  147 +
 net/netfilter/nf_tables_api.c                      |  411 +-
 net/netfilter/nf_tables_offload.c                  |   40 +-
 net/netfilter/nf_tables_trace.c                    |    2 +-
 net/netfilter/nfnetlink_cttimeout.c                |    3 +-
 net/netfilter/nft_hash.c                           |    3 +-
 net/netfilter/nft_immediate.c                      |    2 +-
 net/netfilter/xt_recent.c                          |    8 +-
 net/netlink/af_netlink.c                           |   20 +-
 net/openvswitch/Kconfig                            |    1 +
 net/openvswitch/actions.c                          |   66 +-
 net/openvswitch/conntrack.c                        |   47 +-
 net/openvswitch/datapath.h                         |    3 +
 net/openvswitch/flow_netlink.c                     |   32 +-
 net/openvswitch/vport-internal_dev.c               |   10 +-
 net/openvswitch/vport.c                            |    1 +
 net/packet/af_packet.c                             |  103 +-
 net/psample/psample.c                              |   21 +-
 net/qrtr/ns.c                                      |   17 +-
 net/rds/tcp.c                                      |    4 +-
 net/rds/tcp_recv.c                                 |    4 +-
 net/rfkill/core.c                                  |    8 +-
 net/sched/act_api.c                                |    2 +-
 net/sched/act_bpf.c                                |    4 +-
 net/sched/act_ct.c                                 |   31 +-
 net/sched/act_sample.c                             |   12 +
 net/sched/act_skbmod.c                             |    2 +-
 net/sched/cls_bpf.c                                |    4 +-
 net/sched/cls_flower.c                             |  132 +-
 net/sched/sch_generic.c                            |    1 +
 net/sched/sch_taprio.c                             |    2 +-
 net/sctp/socket.c                                  |   14 +-
 net/smc/Makefile                                   |    2 +-
 net/smc/af_smc.c                                   |  162 +-
 net/smc/smc.h                                      |   38 +
 net/smc/smc_core.c                                 |    7 +-
 net/smc/smc_inet.c                                 |  159 +
 net/smc/smc_inet.h                                 |   22 +
 net/tipc/core.h                                    |    1 -
 net/tipc/link.c                                    |   27 +-
 net/tls/tls_device.c                               |   11 +-
 net/tls/tls_main.c                                 |    9 +-
 net/unix/af_unix.c                                 |  172 +-
 net/unix/diag.c                                    |   45 +-
 net/unix/garbage.c                                 |    8 +-
 net/wireless/chan.c                                |  120 +-
 net/wireless/core.c                                |   15 +-
 net/wireless/core.h                                |    7 +-
 net/wireless/ibss.c                                |    5 +-
 net/wireless/mesh.c                                |    5 +-
 net/wireless/nl80211.c                             |  352 +-
 net/wireless/nl80211.h                             |    4 +-
 net/wireless/pmsr.c                                |   10 +-
 net/wireless/rdev-ops.h                            |   68 +-
 net/wireless/reg.c                                 |    2 +
 net/wireless/scan.c                                |  119 +-
 net/wireless/sme.c                                 |    4 +-
 net/wireless/tests/chan.c                          |   22 +-
 net/wireless/trace.h                               |  227 +-
 net/wireless/util.c                                |   76 +-
 net/xdp/xsk.c                                      |   25 +-
 net/xfrm/Makefile                                  |    3 +-
 net/xfrm/xfrm_compat.c                             |    6 +-
 net/xfrm/xfrm_device.c                             |    6 +-
 net/xfrm/xfrm_input.c                              |   11 +-
 net/xfrm/xfrm_nat_keepalive.c                      |  292 ++
 net/xfrm/xfrm_policy.c                             |   18 +-
 net/xfrm/xfrm_state.c                              |   82 +-
 net/xfrm/xfrm_user.c                               |   16 +-
 samples/bpf/cpustat_kern.c                         |    3 +-
 scripts/Makefile.btf                               |   11 +-
 scripts/Makefile.modfinal                          |    2 +-
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |    6 +-
 tools/bpf/bpftool/Makefile                         |    3 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    3 +
 tools/bpf/bpftool/btf.c                            |  195 +-
 tools/bpf/bpftool/cgroup.c                         |   40 +-
 tools/bpf/bpftool/common.c                         |    2 +-
 tools/bpf/bpftool/gen.c                            |   94 +-
 tools/bpf/bpftool/prog.c                           |    4 +
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |    7 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |   14 +-
 tools/bpf/resolve_btfids/main.c                    |    8 +
 tools/include/uapi/linux/bpf.h                     |   17 +-
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/btf.c                                |  724 ++--
 tools/lib/bpf/btf.h                                |   36 +
 tools/lib/bpf/btf_iter.c                           |  177 +
 tools/lib/bpf/btf_relocate.c                       |  519 +++
 tools/lib/bpf/libbpf.c                             |  136 +-
 tools/lib/bpf/libbpf.h                             |   23 +-
 tools/lib/bpf/libbpf.map                           |    4 +
 tools/lib/bpf/libbpf_internal.h                    |   39 +-
 tools/lib/bpf/linker.c                             |   69 +-
 tools/net/ynl/Makefile                             |    6 +-
 tools/net/ynl/Makefile.deps                        |    4 +-
 tools/net/ynl/lib/Makefile                         |    4 +-
 tools/net/ynl/lib/ynl-priv.h                       |   30 +-
 tools/net/ynl/lib/ynl.c                            |   10 +-
 tools/net/ynl/lib/ynl.h                            |    2 +-
 tools/net/ynl/lib/ynl.py                           |    2 +
 tools/net/ynl/ynl-gen-c.py                         |   58 +-
 tools/net/ynl/ynl-gen-rst.py                       |   13 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    1 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |    4 -
 tools/testing/selftests/bpf/bpf_arena_common.h     |    2 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   32 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    2 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c          |    4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   77 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   10 +
 tools/testing/selftests/bpf/config                 |   14 +
 tools/testing/selftests/bpf/network_helpers.c      |  130 +-
 tools/testing/selftests/bpf/network_helpers.h      |   24 +-
 .../selftests/bpf/prog_tests/arena_atomics.c       |   18 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |    7 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  249 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |    6 -
 .../testing/selftests/bpf/prog_tests/btf_distill.c |  552 +++
 .../selftests/bpf/prog_tests/btf_field_iter.c      |  161 +
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |    4 +-
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |    5 +
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   10 +-
 .../selftests/bpf/prog_tests/fexit_stress.c        |    4 +-
 tools/testing/selftests/bpf/prog_tests/find_vma.c  |    4 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |   14 +-
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |    1 +
 .../bpf/prog_tests/kfunc_param_nullable.c          |   11 +
 .../testing/selftests/bpf/prog_tests/linked_list.c |   12 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |    7 +-
 tools/testing/selftests/bpf/prog_tests/rbtree.c    |   47 +
 .../testing/selftests/bpf/prog_tests/send_signal.c |    3 +-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c |   82 +-
 .../selftests/bpf/prog_tests/sockopt_inherit.c     |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |    3 -
 .../selftests/bpf/prog_tests/test_skb_pkt_end.c    |    1 +
 .../bpf/prog_tests/test_struct_ops_module.c        |   57 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |   44 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 +
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |    2 +-
 .../selftests/bpf/prog_tests/xdp_flowtable.c       |  168 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |  143 +-
 tools/testing/selftests/bpf/progs/arena_htab.c     |   21 +-
 tools/testing/selftests/bpf/progs/arena_list.c     |    1 +
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |   36 +-
 .../selftests/bpf/progs/bpf_iter_bpf_array_map.c   |    6 -
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c      |    6 -
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   15 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |  171 +
 tools/testing/selftests/bpf/progs/crypto_bench.c   |   10 +-
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |   16 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   30 +-
 .../testing/selftests/bpf/progs/get_func_ip_test.c |    7 +-
 .../testing/selftests/bpf/progs/ip_check_defrag.c  |   10 +-
 tools/testing/selftests/bpf/progs/iters.c          |    2 -
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |   37 +
 .../selftests/bpf/progs/kprobe_multi_session.c     |    3 +-
 .../bpf/progs/kprobe_multi_session_cookie.c        |    2 +-
 tools/testing/selftests/bpf/progs/linked_list.c    |   47 +-
 .../testing/selftests/bpf/progs/map_percpu_stats.c |    2 +-
 .../selftests/bpf/progs/nested_trust_common.h      |    2 +-
 .../selftests/bpf/progs/nested_trust_failure.c     |    8 -
 .../selftests/bpf/progs/nested_trust_success.c     |    8 +
 .../selftests/bpf/progs/netif_receive_skb.c        |    5 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h   |    5 +-
 tools/testing/selftests/bpf/progs/rbtree.c         |   77 +
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |    2 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |    4 +-
 tools/testing/selftests/bpf/progs/setget_sockopt.c |    5 +-
 tools/testing/selftests/bpf/progs/skb_pkt_end.c    |   11 +-
 .../selftests/bpf/progs/struct_ops_detach.c        |   10 +
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    |    4 -
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |  109 +
 .../testing/selftests/bpf/progs/test_bpf_nf_fail.c |    1 +
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |    2 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |   43 +
 .../selftests/bpf/progs/test_sockmap_kern.h        |   20 +-
 .../selftests/bpf/progs/test_sysctl_loop1.c        |    5 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c        |    5 +-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |    5 +-
 tools/testing/selftests/bpf/progs/test_tc_dtime.c  |   41 +-
 .../bpf/progs/test_tcp_custom_syncookie.c          |    1 +
 .../bpf/progs/test_tcp_custom_syncookie.h          |    2 -
 tools/testing/selftests/bpf/progs/tracing_struct.c |   54 -
 .../selftests/bpf/progs/tracing_struct_many_args.c |   95 +
 .../selftests/bpf/progs/user_ringbuf_fail.c        |   22 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |    1 +
 .../selftests/bpf/progs/verifier_arena_large.c     |    1 +
 .../selftests/bpf/progs/verifier_bits_iter.c       |  153 +
 .../bpf/progs/verifier_iterating_callbacks.c       |  236 ++
 .../selftests/bpf/progs/verifier_netfilter_ctx.c   |    6 +-
 .../bpf/progs/verifier_subprog_precision.c         |    2 -
 tools/testing/selftests/bpf/progs/wq.c             |   19 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |    4 +-
 tools/testing/selftests/bpf/progs/xdp_flowtable.c  |  148 +
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    1 +
 tools/testing/selftests/bpf/progs/xfrm_info.c      |    1 +
 tools/testing/selftests/bpf/test_loader.c          |  121 +-
 tools/testing/selftests/bpf/test_progs.h           |    9 +
 tools/testing/selftests/bpf/test_sockmap.c         |  137 +-
 .../selftests/bpf/test_tcp_check_syncookie_user.c  |   33 +-
 tools/testing/selftests/bpf/test_verifier.c        |    5 -
 tools/testing/selftests/bpf/trace_helpers.c        |   13 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   15 +-
 tools/testing/selftests/bpf/verifier/precise.c     |   22 +-
 tools/testing/selftests/bpf/xskxceiver.c           |   40 +-
 tools/testing/selftests/bpf/xskxceiver.h           |    2 +
 tools/testing/selftests/drivers/net/hw/Makefile    |    1 +
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  522 +++
 tools/testing/selftests/drivers/net/lib/py/env.py  |   19 +-
 tools/testing/selftests/drivers/net/lib/py/load.py |   37 +-
 .../selftests/drivers/net/mlxsw/mirror_gre.sh      |   71 +-
 .../drivers/net/mlxsw/mirror_gre_scale.sh          |   18 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      |   55 +-
 tools/testing/selftests/net/Makefile               |    1 +
 tools/testing/selftests/net/amt.sh                 |    2 +-
 tools/testing/selftests/net/config                 |    6 +-
 tools/testing/selftests/net/forwarding/Makefile    |    2 +
 .../selftests/net/forwarding/devlink_lib.sh        |    2 +
 tools/testing/selftests/net/forwarding/lib.sh      |   92 +-
 .../selftests/net/forwarding/min_max_mtu.sh        |  283 ++
 .../testing/selftests/net/forwarding/mirror_gre.sh |   45 +-
 .../selftests/net/forwarding/mirror_gre_bound.sh   |   23 +-
 .../net/forwarding/mirror_gre_bridge_1d.sh         |   21 +-
 .../net/forwarding/mirror_gre_bridge_1d_vlan.sh    |   21 +-
 .../net/forwarding/mirror_gre_bridge_1q.sh         |   21 +-
 .../net/forwarding/mirror_gre_bridge_1q_lag.sh     |   29 +-
 .../selftests/net/forwarding/mirror_gre_changes.sh |   73 +-
 .../selftests/net/forwarding/mirror_gre_flower.sh  |   43 +-
 .../net/forwarding/mirror_gre_lag_lacp.sh          |   65 +-
 .../selftests/net/forwarding/mirror_gre_lib.sh     |   90 +-
 .../selftests/net/forwarding/mirror_gre_neigh.sh   |   39 +-
 .../selftests/net/forwarding/mirror_gre_nh.sh      |   35 +-
 .../selftests/net/forwarding/mirror_gre_vlan.sh    |   21 +-
 .../net/forwarding/mirror_gre_vlan_bridge_1q.sh    |   69 +-
 .../testing/selftests/net/forwarding/mirror_lib.sh |   79 +-
 .../selftests/net/forwarding/mirror_vlan.sh        |   43 +-
 .../selftests/net/forwarding/router_mpath_seed.sh  |  333 ++
 .../selftests/net/forwarding/vxlan_bridge_1d.sh    |    8 +-
 tools/testing/selftests/net/hsr/hsr_ping.sh        |    9 +
 tools/testing/selftests/net/hsr/hsr_redbox.sh      |   15 +
 tools/testing/selftests/net/lib.sh                 |   59 +-
 tools/testing/selftests/net/lib/py/ksft.py         |   63 +-
 tools/testing/selftests/net/lib/py/utils.py        |   61 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   33 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |   37 +
 tools/testing/selftests/net/netns-sysctl.sh        |   40 +
 .../selftests/net/openvswitch/openvswitch.sh       |  169 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  641 +++-
 tools/testing/selftests/net/openvswitch/settings   |    1 +
 tools/testing/selftests/net/pmtu.sh                |  147 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |   18 -
 tools/testing/selftests/net/udpgso.c               |   15 +-
 tools/testing/selftests/net/udpgso.sh              |   43 +
 tools/testing/selftests/net/vrf_route_leaking.sh   |   93 +-
 tools/testing/selftests/net/ynl.mk                 |   21 +
 tools/testing/vsock/Makefile                       |   13 +
 1583 files changed, 95753 insertions(+), 25791 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/arc_emac.txt
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,fman-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,fman-muram.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,fman-port.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,fman.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
 delete mode 100644 Documentation/devicetree/bindings/net/fsl-fman.txt
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
 create mode 100644 Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
 delete mode 100644 Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 create mode 100644 Documentation/netlink/specs/tcp_metrics.yaml
 create mode 100644 Documentation/networking/iso15765-2.rst
 create mode 100644 Documentation/networking/mptcp.rst
 create mode 100644 Documentation/networking/sriov.rst
 create mode 100644 drivers/base/auxiliary_sysfs.c
 delete mode 100644 drivers/net/ethernet/arc/emac_arc.c
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig
 create mode 100644 drivers/net/ethernet/mediatek/airoha_eth.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/wc.c
 create mode 100644 drivers/net/ethernet/meta/Kconfig
 create mode 100644 drivers/net/ethernet/meta/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_irq.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_pci.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
 create mode 100644 drivers/net/ethernet/renesas/rtsn.c
 create mode 100644 drivers/net/ethernet/renesas/rtsn.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
 create mode 100644 drivers/net/pcs/pcs-xpcs-plat.c
 create mode 100644 drivers/net/phy/aquantia/aquantia_leds.c
 create mode 100644 drivers/net/wireless/ath/ath10k/leds.c
 create mode 100644 drivers/net/wireless/ath/ath10k/leds.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.c => dvm/eeprom.c} (69%)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.c
 rename drivers/net/wireless/intel/iwlwifi/{iwl-eeprom-parse.h => iwl-nvm-utils.h} (73%)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
 create mode 100644 include/linux/netdevice_xmit.h
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h
 create mode 100644 include/net/libeth/cache.h
 delete mode 100644 net/bluetooth/hci_request.c
 delete mode 100644 net/bluetooth/hci_request.h
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h
 create mode 100644 net/mac80211/tests/tpe.c
 create mode 100644 net/netfilter/nf_flow_table_bpf.c
 create mode 100644 net/netfilter/nf_flow_table_xdp.c
 create mode 100644 net/smc/smc_inet.c
 create mode 100644 net/smc/smc_inet.h
 create mode 100644 net/xfrm/xfrm_nat_keepalive.c
 create mode 100644 tools/lib/bpf/btf_iter.c
 create mode 100644 tools/lib/bpf/btf_relocate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py
 create mode 100755 tools/testing/selftests/net/forwarding/min_max_mtu.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh
 create mode 100755 tools/testing/selftests/net/netns-sysctl.sh
 create mode 100644 tools/testing/selftests/net/openvswitch/settings
 create mode 100644 tools/testing/selftests/net/ynl.mk

