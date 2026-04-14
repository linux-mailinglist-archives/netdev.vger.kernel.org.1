Return-Path: <netdev+bounces-278570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI1lKJ2W3mm0GAAAu9opvQ
	(envelope-from <netdev+bounces-278570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892C3FE08A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C45300E384
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240902609EE;
	Tue, 14 Apr 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhG/JgxM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949414E2F2;
	Tue, 14 Apr 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776195205; cv=none; b=CwYZKtktXyz4VkJ35Snvo4qtpqcRKl4y3iqq7q3c1fuwQRKer49/dKDVzNWKNvPM0b72ZcfC9nyyP4xhTRotJGccruiZFMpftf5P/kWmuvkEXUDwhpWwFb+MvyRRHkG8DaKDAsACVwjw9dELVoqUMPoFmsff+UMg/hi5r9WeM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776195205; c=relaxed/simple;
	bh=O1ikd5i9BYcK/iql8g/VI9Sh0ZfiguefGXGDHIVUUDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aL2KcbA2SGR5/p5A0QdDPQCLeG3oWGhKk8Gn/cWHhrGKUpNTtYUqGf8kytFMyC1Iugd5LZ+tW8vtncURmRDIokFwXszzbld33qfGhUbr3e8wTqco+9FjO7VQz8Rbk8LD4oDvjQSRQU9KwY/+gTB4DP9b7Yyi5BLJ3GDSWULA8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhG/JgxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C432DC19425;
	Tue, 14 Apr 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776195205;
	bh=O1ikd5i9BYcK/iql8g/VI9Sh0ZfiguefGXGDHIVUUDA=;
	h=From:To:Cc:Subject:Date:From;
	b=HhG/JgxMoyt2/B+AdCbsqVddK8ZFyIQk2CCMy6ReuUVmNE4OR1LQLa0lhPgtfWXbP
	 gT5WIyjqFAJXr4VQ4hbBaqPJWjetLRwrzusi4ZO+uL4uiQt6FWrxZiQceaAEvXLR9r
	 6iVUSGhbpCihkdQZkxQffhiVhD6IRrvOicCXnmmEMAAd6tP2HpRwNOWM8b8H3XCkYv
	 aV8z1TGT/BlgQFfqo5+QHdQ3mEaYEJw/A/98zZpFzwH+loBDRyve0DASZcOCgfjMa4
	 U1l226R/Nhh3vCLksLVaRjQEpdnJhtDWxGXN52xyBomaCqGRuBqCRM15lZGyuz2am4
	 FJfmILLtYuS7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for 7.1
Date: Tue, 14 Apr 2026 12:33:24 -0700
Message-ID: <20260414193324.1390838-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.py:url,ovs-dpctl.py:url,vmtest.sh:url,ethtool.py:url]
X-Rspamd-Queue-Id: 1892C3FE08A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

You'll see a conflict with iouring. The resolutions are self-evident.
Redo what
  222b5566a02d ("net: Proxy netdev_queue_get_dma_dev for leased queues")
  1e91c98bc9a8 ("net: Slightly simplify net_mp_{open,close}_rxq")
did in iouring, vs changes from:
  06fc3b6d388d ("io_uring/zcrx: extract netdev+area init into a helper")

The following changes since commit a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c:

  Merge tag 'net-7.0-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-09 08:39:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.1

for you to fetch changes up to 35c2c39832e569449b9192fa1afbbc4c66227af7:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-14 12:04:00 -0700)

----------------------------------------------------------------
Networking changes for 7.1.

Core & protocols
----------------

 - Support HW queue leasing, allowing containers to be granted access
   to HW queues for zero-copy operations and AF_XDP.

 - Number of code moves to help the compiler with inlining.
   Avoid output arguments for returning drop reason where possible.

 - Rework drop handling within qdiscs to include more metadata
   about the reason and dropping qdisc in the tracepoints.

 - Remove the rtnl_lock use from IP Multicast Routing.

 - Pack size information into the Rx Flow Steering table pointer
   itself. This allows making the table itself a flat array of u32s,
   thus making the table allocation size a power of two.

 - Report TCP delayed ack timer information via socket diag.

 - Add ip_local_port_step_width sysctl to allow distributing the randomly
   selected ports more evenly throughout the allowed space.

 - Add support for per-route tunsrc in IPv6 segment routing.

 - Start work of switching sockopt handling to iov_iter.

 - Improve dynamic recvbuf sizing in MPTCP, limit burstiness and avoid
   buffer size drifting up.

 - Support MSG_EOR in MPTCP.

 - Add stp_mode attribute to the bridge driver for STP mode selection.
   This addresses concerns about call_usermodehelper() usage.

 - Remove UDP-Lite support (as announced in 2023).

 - Remove support for building IPv6 as a module.
   Remove the now unnecessary function calling indirection.

Cross-tree stuff
----------------

 - Move Michael MIC code from generic crypto into wireless,
   it's considered insecure but some WiFi networks still need it.

Netfilter
---------

 - Switch nft_fib_ipv6 module to no longer need temporary dst_entry
   object allocations by using fib6_lookup() + RCU.
   Florian W reports this gets us ~13% higher packet rate.

 - Convert IPVS's global __ip_vs_mutex to per-net service_mutex and
   switch the service tables to be per-net. Convert some code that
   walks the service lists to use RCU instead of the service_mutex.

 - Add more opinionated input validation to lower security exposure.

 - Make IPVS hash tables to be per-netns and resizable.

Wireless
--------

 - Finished assoc frame encryption/EPPKE/802.1X-over-auth.

 - Radar detection improvements.

 - Add 6 GHz incumbent signal detection APIs.

 - Multi-link support for FILS, probe response templates and
   client probing.

 - New APIs and mac80211 support for NAN (Neighbor Aware Networking,
   aka Wi-Fi Aware) so less work must be in firmware.

Driver API
----------

 - Add numerical ID for devlink instances (to avoid having to create
   fake bus/device pairs just to have an ID). Support shared devlink
   instances which span multiple PFs.

 - Add standard counters for reporting pause storm events
   (implement in mlx5 and fbnic).

 - Add configuration API for completion writeback buffering
   (implement in mana).

 - Support driver-initiated change of RSS context sizes.

 - Support DPLL monitoring input frequency (implement in zl3073x).

 - Support per-port resources in devlink (implement in mlx5).

Misc
----

 - Expand the YAML spec for Netfilter.

Drivers
-------

 - Software:
   - macvlan: support multicast rx for bridge ports with shared source
     MAC address
   - team: decouple receive and transmit enablement for IEEE 802.3ad
     LACP "independent control"

 - Ethernet high-speed NICs:
   - nVidia/Mellanox:
     - support high order pages in zero-copy mode (for payload
       coalescing)
     - support multiple packets in a page (for systems with 64kB pages)
   - Broadcom 25-400GE (bnxt):
     - implement XDP RSS hash metadata extraction
     - add software fallback for UDP GSO, lowering the IOMMU cost
   - Broadcom 800GE (bnge):
     - add link status and configuration handling
     - add various HW and SW statistics
   - Marvell/Cavium:
     - NPC HW block support for cn20k
   - Huawei (hinic3):
     - add mailbox / control queue
     - add rx VLAN offload
     - add driver info and link management

 - Ethernet NICs:
   - Marvell/Aquantia:
     - support reading SFP module info on some AQC100 cards
   - Realtek PCI (r8169):
     - add support for RTL8125cp
   - Realtek USB (r8152):
     - support for the RTL8157 5Gbit chip
     - add 2500baseT EEE status/configuration support

 - Ethernet NICs embedded and off-the-shelf IP:
   - Synopsys (stmmac):
     - cleanup and reorganize SerDes handling and PCS support
     - cleanup descriptor handling and per-platform data
     - cleanup and consolidate MDIO defines and handling
     - shrink driver memory use for internal structures
     - improve Tx IRQ coalescing
     - improve TCP segmentation handling
     - add support for Spacemit K3
   - Cadence (macb):
     - support PHYs that have inband autoneg disabled with GEM
     - support IEEE 802.3az EEE
     - rework usrio capabilities and handling
   - AMD (xgbe):
     - improve power management for S0i3
     - improve TX resilience for link-down handling

 - Virtual:
   - Google cloud vNIC:
     - support larger ring sizes in DQO-QPL mode
     - improve HW-GRO handling
     - support UDP GSO for DQO format
   - PCIe NTB:
     - support queue count configuration

 - Ethernet PHYs:
   - automatically disable PHY autonomous EEE if MAC is in charge
   - Broadcom:
     - add BCM84891/BCM84892 support
   - Micrel:
     - support for LAN9645X internal PHY
   - Realtek:
     - add RTL8224 pair order support
     - support PHY LEDs on RTL8211F-VD
     - support spread spectrum clocking (SSC)
   - Maxlinear:
     - add PHY-level statistics via ethtool

 - Ethernet switches:
   - Maxlinear (mxl862xx):
     - support for bridge offloading
     - support for VLANs
     - support driver statistics

 - Bluetooth:
   - large number of fixes and new device IDs
   - Mediatek:
     - support MT6639 (MT7927)
     - support MT7902 SDIO

 - WiFi:
   - Intel (iwlwifi):
     - UNII-9 and continuing UHR work
   - MediaTek (mt76):
     - mt7996/mt7925 MLO fixes/improvements
     - mt7996 NPU support (HW eth/wifi traffic offload)
   - Qualcomm (ath12k):
     - monitor mode support on IPQ5332
     - basic hwmon temperature reporting
     - support IPQ5424
   - Realtek:
     - add USB RX aggregation to improve performance
     - add USB TX flow control by tracking in-flight URBs

 - Cellular:
   - IPA v5.2 support

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (2):
      wifi: ath12k: Enable monitor mode support on IPQ5332
      wifi: ath12k: Use .mbn firmware for AHB devices

Aaron Tomlin (1):
      vmxnet3: Suppress page allocation warning for massive Rx Data ring

Abhilekh Deka (1):
      net/ibmveth: fix comment typos in ibmveth.c

Aditya Kumar Singh (1):
      wifi: mac80211_hwsim: add incumbent signal interference detection support

Alejandro Colomar (1):
      wifi: ath9k: Fix typo

Aleksander Jan Bajkowski (2):
      net: phy: realtek: get rid of magic numbers in rtl8201_config_intr()
      net: phy: realtek: use LEDCR page number define on RTL8211F

Aleksandr Loktionov (2):
      ixgbe: refactor: use DECLARE_BITMAP for ring state field
      iavf: fix kernel-doc comment style in iavf_ethtool.c

Aleksei Oladko (4):
      selftests: net: forwarding: fix IPv6 address leak in cleanup
      selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
      selftests: net: run reuseport in an isolated netns
      selftests: net: io_uring_zerocopy: enable io_uring for the test

Alexander Duyck (1):
      fbnic: Set Relaxed Ordering PCIe TLP attributes for DMA engines

Alexander Graf (1):
      vsock: add G2H fallback for CIDs not owned by H2G transport

Alexander Stein (1):
      wifi: brcmfmac: silence warning for non-existent, optional firmware

Alexander Wilhelm (1):
      net: qrtr: fix endian handling of confirm_rx field

Alexei Lazar (1):
      net/mlx5: Add IFC bits for shared headroom pool PBMC support

Alexey Velichayshiy (1):
      wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()

Allen Ye (1):
      wifi: mt76: fix backoff fields and max_power calculation

Allison Henderson (5):
      selftests: rds: Fix pylint warnings
      selftests: rds: Add ksft timeout
      selftests: rds: Fix tcpdump segfault in rds selftests
      selftests: rds: add tools/testing/selftests/net/rds/config
      selftests: rds: Add -c config option to rds/config.sh

Alok Tiwari (6):
      octeontx2-af: make PF_FUNC comparison consistent in NIX XOFF handling
      net: mdio: xgene: Fix misleading err message in xgene mdio read
      selftests: fib_tests: fix link-local retrieval in fib6_nexthop()
      net: netdevsim: correct typo in new_device_store error message
      wifi: mt76: mt7996: fix FCS error flag check in RX descriptor
      mlx4: correct error reporting in mlx4_master_process_vhcr()

Alvin Šipraga (1):
      net: dsa: tag_rtl8_4: update format description

Amit Pundir (2):
      dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      wifi: ath10k: Add device-tree quirk to skip host cap QMI requests

Andy Roulin (3):
      net: bridge: add stp_mode attribute for STP mode selection
      docs: net: bridge: document stp_mode attribute
      selftests: net: add bridge STP mode selection test

Andy Shevchenko (2):
      i40e: Add missing wordpart.h header
      nfc: microread: Drop unused include

Ankit Garg (5):
      gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
      gve: fix SW coalescing when hw-GRO is used
      gve: pull network headers into skb linear part
      gve: Enable hw-gro by default if device supported
      gve: add support for UDP GSO for DQO format

Antonio Quartulli (2):
      tools: ynl: add uns-admin-perm to genetlink
      selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3

Antony Antony (2):
      icmp: fix ICMP error source address when xfrm policy matches
      selftests: net: add ICMP error source address test over xfrm tunnel

Arnd Bergmann (4):
      net: ethernet: ti-cpsw:: rename soft_reset() function
      net: ethernet: ti-cpsw: fix linking built-in code to modules
      dpaa2: avoid linking objects into multiple modules
      Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array

Asbjørn Sloth Tønnesen (1):
      tools: ynl: add sample for wireguard

Avinash Bhatt (3):
      wifi: iwlwifi: add CQM event support for per-link RSSI changes
      wifi: iwlwifi: handle NULL/ERR returns from ptp_clock_register()
      wifi: iwlwifi: mld: block EMLSR during TDLS connections

Avraham Stern (3):
      wifi: cfg80211: support key installation on non-netdev wdevs
      wifi: cfg80211: allow protected action frame TX for NAN
      wifi: mac80211: allow add_key on NAN interfaces

Avula Sri Charan (1):
      wifi: ath12k: Skip adding inactive partner vdev info

Baochen Qiang (2):
      wifi: ath12k: fix indentation in ath12k_qmi_aux_uc_load()
      wifi: ath10k: fix station lookup failure during disconnect

Bartosz Golaszewski (2):
      net: mdio-gpio: remove linux/mdio-gpio.h
      net: mdio-gpio: remove linux/platform_data/mdio-gpio.h

Benjamin Berg (4):
      wifi: mac80211: ignore reserved bits in reconfiguration status
      wifi: mac80211: add a TXQ for management frames on NAN devices
      wifi: ieee80211: add more NAN definitions
      wifi: mac80211: export ieee80211_calculate_rx_timestamp

Bhargava Marreddy (10):
      bng_en: add per-PF workqueue, timer, and slow-path task
      bng_en: query PHY capabilities and report link status
      bng_en: add ethtool link settings, get_link, and nway_reset
      bng_en: implement ethtool pauseparam operations
      bng_en: add support for link async events
      bng_en: add HW stats infra and structured ethtool ops
      bng_en: periodically fetch and accumulate hardware statistics
      bng_en: implement ndo_get_stats64
      bng_en: implement netdev_stat_ops
      bng_en: add support for ethtool -S stats display

Birger Koblitz (3):
      r8152: Add 2500baseT EEE status/configuration support
      r8152: Add support for 5Gbit Link Speeds and EEE
      r8152: Add support for the RTL8157 hardware

Bitterblue Smith (5):
      wifi: rtw89: Turbo mode for RTL8851BU/RTL8852BU
      wifi: rtw88: TX QOS Null data the same way as Null data
      wifi: rtw88: coex: Ignore BT info byte 5 from RTL8821A
      wifi: rtw88: Fill fw_version member of struct wiphy
      wifi: rtw89: Fill fw_version member of struct wiphy

Bjorn Andersson (1):
      wifi: ath11k: Silence remoteproc probe deferral prints

Björn Töpel (4):
      ethtool: Track user-provided RSS indirection table size
      ethtool: Add RSS indirection table resize helpers
      bnxt_en: Resize RSS contexts on channel count change
      selftests: rss_drv: Add RSS indirection table resize tests

Bo Sun (1):
      octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()

Bobby Eshleman (4):
      selftests/vsock: auto-detect kernel for guest VMs
      selftests/vsock: fix vmtest.sh for read-only nested VM runners
      selftests/vsock: fix vsock_test path shadowing in nested VMs
      selftests: drv-net: add missing tc config options for netkit tests

Brendan Jackman (2):
      wifi: iwlegacy: Fixup allocation failure log
      wifi: iwlegacy: Fix GFP flags in allocation loop

Breno Leitao (6):
      selftests: netconsole: print diagnostic on busywait timeout in netcons_basic
      bonding: remove bonding_priv.h
      net: add getsockopt_iter callback to proto_ops
      net: call getsockopt_iter if available
      af_packet: convert to getsockopt_iter
      can: raw: convert to getsockopt_iter

Bui Quang Minh (1):
      virtio-net: xsk: Support wakeup on RX side

Byungchul Park (1):
      netmem: remove the pp fields from net_iov

Cai Xinchen (2):
      dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
      dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

Carolina Jubran (2):
      net/mlx5: Move crosststamp setup into helper function
      net/mlx5: Support cross-timestamping on ARM architectures

Cedric Jehasse (2):
      net/sched: cls_flower: remove unions from fl_flow_key
      net: dsa: mv88e6xxx: Add partial support for TCAM entries

Chad Monroe (5):
      wifi: mt76: fix deadlock in remain-on-channel
      wifi: mt76: mt7996: reset device after MCU message timeout
      wifi: mt76: mt7996: increase txq memory limit to 32 MiB
      wifi: mt76: fix multi-radio on-channel scanning
      wifi: mt76: support upgrading passive scans to active

Charles Perry (11):
      net: macb: fix SGMII with inband aneg disabled
      net: macb: add support for reporting SGMII inband link status
      net: macb: add the .pcs_inband_caps() callback for SGMII
      net: macb: set default_an_inband to true for SGMII
      dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
      net: macb: add safeguards for jumbo frame larger than 10240
      net: macb: add support for Microchip pic64hpsc ethernet endpoint
      net: phy: fix a return path in get_phy_c45_ids()
      dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
      net: mdio: add a driver for PIC64-HPSC/HX MDIO controller
      net: phy: add a PHY write barrier when disabling interrupts

Chih Kai Hsu (4):
      r8152: fix incorrect register write to USB_UPHY_XTAL
      r8152: add helper functions for PLA/USB OCP registers
      r8152: add helper functions for PHY OCP registers
      r8152: Add helper functions for SRAM2

Chin-Yen Lee (3):
      wifi: rtw89: wow: add retry for ensuring packet are processed
      wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C command
      wifi: rtw89: wow: enable MLD address for Magic packet wakeup

Ching-Te Ku (1):
      wifi: rtw88: coex: Solve LE-HID lag & update coex version to 26020420

Chris J Arges (7):
      bnxt_en: use bnxt_xdp_buff for xdp context
      bnxt_en: Implement XDP RSS hash metadata extraction
      bnxt_en: Move bnxt_rss_ext_op into header
      bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
      selftests: net: move common xdp.py functions into lib
      selftests: drv-net: xdp: Add rss_hash metadata tests
      net: Add net_cookie to Dead loop messages

Chris Lu (4):
      Bluetooth: btusb: MT7922: Add VID/PID 0489/e174
      Bluetooth: btmtk: improve mt79xx firmware setup retry flow
      Bluetooth: btmtk: add status check in mt79xx firmware setup
      Bluetooth: btmtk: Add reset mechanism if downloading firmware failed

Christian Eggers (1):
      Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS

Christian Hewitt (2):
      wifi: mt7601u: check multiple firmware paths
      wifi: rtw89: retry efuse physical map dump on transient failure

Christophe Leroy (CS GROUP) (1):
      net: Convert move_addr_to_user() to scoped user access

Christos Longros (1):
      wifi: rtw89: fix typo "frome" -> "from" in rx_freq_frome_ie

Colin Ian King (2):
      hinic3: Fix spelling mistake "capbility" -> "capability"
      wifi: mt76: mt7996: Fix spelling mistake "retriving" -> "retrieving"

Conor Dooley (12):
      Revert "net: macb: Clean up the .usrio settings in macb_config instances"
      net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
      net: macb: split USRIO_HAS_CLKEN capability in two
      dt-bindings: net: cdns,macb: replace cdns,refclk-ext with cdns,refclk-source
      net: macb: rework usrio refclk selection code
      net: macb: np4 doesn't need a usrio pointer
      net: macb: add mpfs specific usrio configuration
      net: macb: warn on pclk use as a tsu_clk fallback
      net: macb: clean up tsu clk rate acquisition
      dt-bindings: net: macb: add property indicating timer adjust mode
      net: macb: timer adjust mode is not supported
      net: macb: fix use of at91_default_usrio without CONFIG_OF

Cosmin Ratiu (4):
      selftests: Migrate nsim-only MACsec tests to Python
      nsim: Add support for VLAN filters
      selftests: Add MACsec VLAN propagation traffic test
      macsec: Support VLAN-filtering lower devices

Damien Dejean (4):
      dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
      net: phy: realtek: add RTL8224 pair order support
      dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
      net: phy: realtek: add RTL8224 polarity support

Daniel Borkmann (16):
      net: Add queue-create operation
      net: Implement netdev_nl_queue_create_doit
      net: Add lease info to queue-get response
      net, ethtool: Disallow leased real rxqs to be resized
      net: Slightly simplify net_mp_{open,close}_rxq
      xsk: Extend xsk_rcv_check validation
      xsk: Proxy pool management for leased queues
      netkit: Add single device mode for netkit
      netkit: Add netkit notifier to check for unregistering devices
      netkit: Add xsk support for af_xdp applications
      net: Rename ifq_idx to rxq_idx in netif_mp_* helpers
      netkit: Don't emit scrub attribute for single device mode
      tools/ynl: Make YnlFamily closeable as a context manager
      selftests/net: Split netdevsim tests from HW tests in nk_qlease
      selftests/net: Add additional test coverage in nk_qlease
      MAINTAINERS: Add netkit selftest files

Daniel Gabay (1):
      wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces

Daniel Golle (19):
      dt-bindings: net: dsa: maxlinear,mxl862xx: remove port label
      net: dsa: mxl862xx: rename MDIO op arguments
      selftests: net: local_termination: test link-local protocols
      net: phy: mxl-gpy: add PHY-level statistics via ethtool
      net: dsa: mxl862xx: don't read out-of-bounds
      selftests: forwarding: local_termination: fix PTP UDP cksums
      net: dsa: mxl862xx: add CRC for MDIO communication
      net: dsa: mxl862xx: use RST_DATA to skip writing zero words
      net: dsa: mxl862xx: cancel pending work on probe error
      net: dsa: move dsa_bridge_ports() helper to dsa.h
      net: dsa: add bridge member iteration macro
      dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
      net: dsa: mxl862xx: implement bridge offloading
      net: dsa: mxl862xx: reject DSA_PORT_TYPE_DSA
      net: dsa: mxl862xx: don't skip early bridge port configuration
      net: dsa: mxl862xx: implement VLAN functionality
      net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers
      net: dsa: mxl862xx: add ethtool statistics support
      net: dsa: mxl862xx: implement .get_stats64

Daniel Hodges (1):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

Daniel Machon (9):
      net: sparx5: move netdev and notifier block registration to probe
      net: sparx5: move VCAP initialization to probe
      net: sparx5: move MAC table initialization and add deinit function
      net: sparx5: move stats initialization and add deinit function
      net: sparx5: move calendar initialization to probe
      net: sparx5: move remaining init functions from start() to probe()
      net: sparx5: move PTP IRQ handling out of sparx5_start()
      net: sparx5: move FDMA/XTR initialization out of sparx5_start()
      net: sparx5: replace sparx5_start() with sparx5_forwarding_init()

Daniel Wagner (2):
      net: phy: bcm84881: add BCM84891/BCM84892 support
      net: phy: bcm84881: add LED framework support for BCM84891/BCM84892

Daniel Zahka (1):
      psp: add missing device stats to get-stats reply attributes

David Bauer (2):
      wifi: mt76: mt76x02: wake queues after reconfig
      wifi: mt76: don't return TXQ when exceeding max non-AQL packets

David Carlier (3):
      net: use get_random_u{16,32,64}() where appropriate
      octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
      octeon_ep_vf: add NULL check for napi_build_skb()

David Heidelberg (1):
      dt-bindings: nfc: nxp,nci: Document PN557 compatible

David Laight (1):
      netfilter: nf_conntrack_h323: Correct indentation when H323_TRACE defined

David Wei (8):
      selftests/net: Add bpf skb forwarding program
      selftests/net: Export Netlink class via lib.py
      selftests/net: Add env for container based tests
      selftests/net: Add netkit container ping test
      net: Proxy netif_mp_{open,close}_rxq for leased queues
      net: Proxy netdev_queue_get_dma_dev for leased queues
      netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
      selftests/net: Add queue leasing tests with netkit

Davide Caratti (4):
      netdevsim: move TC offload code to a dedicated file
      netdevsim: support tc-ets offload
      tc-testing: add a test case for ETS offload
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Di Zhu (1):
      virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported

Dimitri Daskalakis (6):
      selftests: net: py: Add rand_ports helper method
      selftests: drv-net: rss: Generate unique ports for RSS context tests
      selftests: drv-net: rss: Fix error calculation in test_hitless_key_update
      selftests: drv-net: rss: Add retries to test_rss_key_indir to reduce flakes
      selftests: drv-net: Add ntuple (NFC) flow steering test
      selftests: drv-net: ntuple: Add dst-ip, src-port, dst-port fields

Dipayaan Roy (1):
      net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout

Dmitry Baryshkov (1):
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

Dongyang Jin (1):
      Bluetooth: btbcm: remove done label in btbcm_patchram

Dragos Tatulea (21):
      net/mlx5e: Make mlx5e_rq_param naming consistent
      net/mlx5e: Extract striding rq param calculation in function
      net/mlx5e: Extract max_xsk_wqebbs into its own function
      net/mlx5e: Expose and rename xsk channel parameter function
      net/mlx5e: Alloc xsk channel param out of mlx5e_open_xsk()
      net/mlx5e: Move xsk param into new option container struct
      net/mlx5e: Drop unused channel parameters
      net/mlx5e: SHAMPO, Always calculate page size
      net/mlx5e: Set page_pool order based on calculated page_shift
      net/mlx5e: Alloc rq drop page based on calculated page_shift
      net/mlx5e: RX, Make page frag bias more robust
      net/mlx5e: Add queue config ops for page size
      net/mlx5e: Pass netdev queue config to param calculations
      net/mlx5e: Add param helper to calculate max page size
      net/mlx5e: SHAMPO, Allow high order pages in zerocopy mode
      selftests: drv-net: iou-zcrx: wait for memory cleanup of probe run
      net/mlx5e: XSK, Increase size for chunk_size param
      net/mlx5e: XDP, Improve dma address calculation of linear part for XDP_TX
      net/mlx5e: XDP, Remove stride size limitation
      net/mlx5e: XDP, Use a single linear page per rq
      net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode

Dudu Lu (1):
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp

Duoming Zhou (3):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
      wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
      wifi: mt76: mt7996: fix use-after-free bugs in mt7996_mac_dump_work()

Dylan Eray (1):
      Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921

Emmanuel Grumbach (28):
      wifi: cfg80211: support UNII-9 channels in ieee80211_channel_to_freq_khz
      wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2
      wifi: iwlwifi: ensure we don't read SAR values past the limit
      wifi: iwlwifi: uefi: decouple UEFI and firmware APIs
      wifi: iwlwifi: acpi: better use ARRAY_SIZE than a define
      wifi: iwlwifi: uefi: open code the PPAG table store operation
      wifi: iwlwifi: bring iwl_fill_ppag_table to the iwlmvm
      wifi: iwlwifi: regulatory: support a new command for PPAG
      wifi: iwlwifi: acpi: check the size of the ACPI PPAG tables
      wifi: iwlwifi: acpi: add support for PPAG rev5
      wifi: iwlwifi: uefi: add support for PPAG table rev5
      wifi: iwlwifi: mvm: zero iwl_geo_tx_power_profiles_cmd before sending
      wifi: iwlwifi: uefi: support the new WRDS and EWRD tables
      wifi: iwlwifi: acpi: add support for WRDS rev 3 table
      wifi: iwlwifi: acpi: add support for EWRD rev 3 table
      wifi: iwlwifi: mld: support version 11 of REDUCE_TX_POWER_CMD
      wifi: iwlwifi: uefi: open code the parsing of the WGDS table
      wifi: iwlwifi: uefi: add support for WGDS rev4
      wifi: iwlwifi: acpi: validate the WGDS table
      wifi: iwlwifi: acpi: add support for WGDS revision 4
      wifi: iwlwifi: support PER_CHAIN_LIMIT_OFFSET_CMD v6
      wifi: iwlwifi: uefi: mode the comments valid kerneldoc comments
      wifi: iwlwifi: remove IWL_MAX_WD_TIMEOUT
      wifi: iwlwifi: mld: remove SCAN_TIMEOUT_MSEC
      wifi: iwlwifi: mld: update the TLC when we deactivate a link
      wifi: iwlwifi: TLC_MNG_CONFIG_CMD can use several structures
      wifi: iwlwifi: fix the description of SESSION_PROTECTION_CMD
      wifi: iwlwifi: reduce the number of prints upon firmware crash

Eric Biggers (10):
      qed: Reimplement qed_mcast_bin_from_mac() using library functions
      octeontx2-pf: macsec: Use AES library instead of ecb(aes) skcipher
      xfrm: Drop support for HMAC-RIPEMD-160
      wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
      wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
      wifi: ath11k: Use michael_mic() from cfg80211
      wifi: ath12k: Use michael_mic() from cfg80211
      wifi: ipw2x00: Use michael_mic() from cfg80211
      crypto: Remove michael_mic from crypto_shash API
      wifi: cfg80211: Explicitly include <linux/export.h> in michael-mic.c

Eric Dumazet (66):
      net: __lock_sock() can be static
      udp: move udp6_csum_init() back to net/ipv6/udp.c
      tcp: inline __tcp_v4_send_check()
      tcp: move tcp_v6_send_check() to tcp_output.c
      tcp: make tcp_v{4,6}_send_check() static
      tcp: reduce calls to tcp_schedule_loss_probe()
      tcp: move inet6_csk_update_pmtu() to tcp_ipv6.c
      icmp: increase net.ipv4.icmp_msgs_{per_sec,burst}
      inet: remove three EXPORT_SYMBOL()
      net: use try_cmpxchg() in lock_sock_nested()
      net: inline skb_add_rx_frag_netmem()
      net: remove addr_len argument of recvmsg() handlers
      mpls: remove test against ipv6_stub
      netfilter: nf_log_syslog: no longer acquire sk_callback_lock in nf_log_dump_sk_uid_gid()
      netfilter: xt_owner: no longer acquire sk_callback_lock in mt_owner()
      netfilter: nft_meta: no longer acquire sk_callback_lock in nft_meta_get_eval_skugid()
      netfilter: nfnetlink_log: no longer acquire sk_callback_lock
      netfilter: nfnetlink_queue: no longer acquire sk_callback_lock
      net: fix off-by-one in udp_flow_src_port() / psp_write_headers()
      net: add rps_tag_ptr type and helpers
      net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
      net-sysfs: add rps_sock_flow_table_mask() helper
      net-sysfs: use rps_tag_ptr and remove metadata from rps_sock_flow_table
      net-sysfs: get rid of rps_dev_flow_lock
      net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
      net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table
      tcp: move tcp_do_parse_auth_options() to net/ipv4/tcp.c
      net: use ktime_t in struct scm_timestamping_internal
      tcp: move tcp_v6_early_demux() to net/ipv6/ip6_input.c
      inet_diag: report delayed ack timer information
      tcp: move tcp_v4_early_demux() to net/ipv4/ip_input.c
      tcp: avoid dst->ops->check() call in tcp_v{4,6}_do_rcv()
      net/sched: do not reset queues in graft operations
      net/sched: use rtnl_kfree_skbs() in pfifo_fast_reset()
      tcp: move sysctl_tcp_shrink_window to netns_ipv4_read_txrx group
      net/sched: refine indirect call mitigation in tc_wrapper.h
      tcp: move tp->chrono_type next tp->chrono_stat[]
      tcp: inline tcp_chrono_start()
      tcp: add sysctl_tcp_shrink_window to netns_ipv4_sysctl.rst
      tcp: add tcp_release_cb_cond() helper
      net: add skb_defer_disable_key static key
      net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
      net: plumb drop reasons to __dev_queue_xmit()
      selftests/net: packetdrill: add tcp_disorder_fin_in_FIN_WAIT.pkt
      tcp: improve inet6_ehashfn() entropy
      tcp: add cwnd_event_tx_start to tcp_congestion_ops
      tcp: tcp_vegas: use tcp_vegas_cwnd_event_tx_start()
      tcp: use __jhash_final() in inet6_ehashfn()
      ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
      macvlan: annotate data-races around port->bc_queue_len_used
      macvlan: avoid spinlock contention in macvlan_broadcast_enqueue()
      net: always inline some skb helpers
      inet: remove leftover EXPORT_SYMBOL()
      net: qdisc_pkt_len_segs_init() cleanup
      net: pull headers in qdisc_pkt_len_segs_init()
      codel: annotate data-races in codel_dump_stats()
      net: dropreason: add MACVLAN_BROADCAST_BACKLOG and IPVLAN_MULTICAST_BACKLOG
      ipvlan: ipvlan_handle_mode_l2() refactoring
      ipvlan: avoid spinlock contention in ipvlan_multicast_enqueue()
      tcp: return a drop_reason from tcp_add_backlog()
      tcp: add indirect call wrapper in tcp_conn_request()
      net: change sock_queue_rcv_skb_reason() to return a drop_reason
      net: always set reason in sk_filter_trim_cap()
      net: change sk_filter_reason() to return the reason by value
      tcp: change tcp_filter() to return the reason by value
      net: change sk_filter_trim_cap() to return a drop_reason by value

Eric Huang (1):
      wifi: rtw89: phy: expand PHY page for RTL8922D

Eric Joyner (1):
      ionic: Report additional media types from firmware

Eric Woudstra (2):
      net: pppoe: avoid zero-length arrays in struct pppoe_hdr
      bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign

Erni Sri Satya Vennela (6):
      net: mana: Add MAC address to vPort logs and clarify error messages
      net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response
      net: mana: Use at least SZ_4K in doorbell ID range check
      net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG
      net: mana: Use pci_name() for debugfs directory naming
      net: mana: Move current_speed debugfs file to mana_init_port()

Ethan Nelson-Moore (1):
      net: can: ctucanfd: remove useless copy of PCI_DEVICE_DATA macro

Ethan Tidmore (1):
      wifi: brcmfmac: Fix error pointer dereference

Fan Gong (9):
      hinic3: Add command queue detailed-response interfaces
      hinic3: Add Command Queue/Async Event Queue/Complete Event Queue/Mailbox dump interfaces
      hinic3: Add chip_present_flag checks to prevent errors when card is absent
      hinic3: Add RX VLAN offload support
      hinic3: Add msg_send_lock for message sending concurrecy
      hinic3: Add PF device support and function type validation
      hinic3: Add PF FLR wait and timeout handling
      hinic3: Add PF/VF capability parsing and parameter validation
      hinic3: Add ethtool basic ops

Fedor Pchelkin (1):
      wifi: rtw88: check for PCI upstream bridge existence

Felix Fietkau (9):
      wifi: mt76: add offchannel check to mt76_roc_complete
      wifi: mt76: check chanctx before restoring channel after ROC
      wifi: mt76: abort ROC on chanctx changes
      wifi: mt76: optimize ROC for same-channel case
      wifi: mt76: send nullfunc PS frames on offchannel transitions
      wifi: mt76: flush pending TX before channel switch
      wifi: mt76: route nullfunc frames to PSD/ALTX queue
      wifi: mt76: wait for firmware TX completion of mgmt frames before channel switch
      wifi: mt76: add per-link beacon monitoring for MLO

Fernando Fernandez Mancera (19):
      ipv6: discard fragment queue earlier if there is malformed datagram
      inet: add ip_local_port_step_width sysctl to improve port usage distribution
      ipv4: validate IPV4_DEVCONF attributes properly
      selftests: net: add ipv6 RA route to ECMP merge test
      ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
      net: remove EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() macros
      ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
      ipv6: remove dynamic ICMPv6 sender registration infrastructure
      ipv6: prepare headers for ipv6_stub removal
      drivers: net: drop ipv6_stub usage and use direct function calls
      ipv4: drop ipv6_stub usage and use direct function calls
      net: convert remaining ipv6_stub users to direct function calls
      bpf: remove ipv6_bpf_stub completely and use direct function calls
      ipv6: remove ipv6_stub infrastructure completely
      netfilter: remove nf_ipv6_ops and use direct function calls
      net: vxlan: check ipv6_mod_enabled() on neigh_reduce()
      net: hsr: emit notification for PRP slave2 changed hw addr on port deletion
      netfilter: conntrack: remove UDP-Lite conntrack support
      net_sched: fix skb memory leak in deferred qdisc drops

Florian Fainelli (1):
      net: bcmasp: Switch to page pool for RX path

Florian Westphal (19):
      netfilter: nft_set_rbtree: don't disable bh when acquiring tree lock
      netfilter: nf_tables: drop obsolete EXPORT_SYMBOLs
      netfilter: nf_tables: remove register tracking infrastructure
      ipv6: export fib6_lookup for nft_fib_ipv6
      ipv6: make ipv6_anycast_destination logic usable without dst_entry
      netfilter: nft_fib_ipv6: switch to fib6_lookup
      netfilter: nfnetlink_queue: remove locking in nfqnl_get_sk_secctx
      netfilter: nf_conntrack_sip: remove net variable shadowing
      netfilter: add deprecation warning for dccp support
      netfilter: nf_conntrack_h323: remove unreliable debug code in decode_octstr
      netfilter: add more netlink-based policy range checks
      netfilter: nf_tables: add netlink policy based cap on registers
      netfilter: nft_set_pipapo: increment data in one step
      netfilter: nft_set_pipapo_avx2: remove redundant loop in lookup_slow
      netfilter: x_physdev: reject empty or not-nul terminated device names
      netfilter: nfnetlink: prefer skb_mac_header helpers
      netfilter: xt_socket: enable defrag after all other checks
      netfilter: nft_fwd_netdev: check ttl/hl before forwarding
      selftests: netfilter: nft_tproxy.sh: adjust to socat changes

Fushuai Wang (1):
      wireguard: allowedips: Use kfree_rcu() instead of call_rcu()

Gabriel Goller (2):
      docs: net: document neigh gc_stale_time sysctl
      docs: net: document neigh gc_interval sysctl

Gabriel Krisman Bertazi (1):
      udp: Force compute_score to always inline

Gal Pressman (5):
      selftests: net: pass bpftrace timeout to cmd()
      selftests: net: fix timeout passed as positional argument to communicate()
      gre: Count GRE packet drops
      net/mlx5e: Fix features not applied during netdev registration
      net/mlx5e: IPsec, fix ASO poll timeout with read_poll_timeout_atomic()

Gang Yan (2):
      mptcp: reduce 'overhead' from u16 to u8
      mptcp: preserve MSG_EOR semantics in sendmsg path

Geert Uytterhoeven (3):
      dt-bindings: net: micrel: Sort lists
      dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
      can: rcar_can: Convert to FIELD_MODIFY()

Geliang Tang (1):
      tcp: add recv_should_stop helper

Greg Jumper (1):
      net/rds: Restrict use of RDS/IB to the initial network namespace

Greg Kroah-Hartman (3):
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      bnge: return after auxiliary_device_uninit() in error path
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()

Gustavo A. R. Silva (4):
      wifi: iwlegacy: Avoid multiple -Wflex-array-member-not-at-end warnings
      wifi: ath6kl: wmi: Avoid -Wflex-array-member-not-at-end warning
      netfilter: x_tables: Avoid a couple -Wflex-array-member-not-at-end warnings
      Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings

Haiyang Zhang (3):
      net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
      net: mana: Add support for RX CQE Coalescing
      net: mana: Add ethtool counters for RX CQEs in coalesced type

Hangbin Liu (8):
      bonding: print churn state via netlink
      ynl: ethtool: remove duplicated unspec entry
      tools: ynl: tests: fix leading space on Makefile target
      tools: ynl: move ethtool.py to selftest
      tools: ynl: ethtool: use doit instead of dumpit for per-device GET
      tools: ynl: ethtool: add --dbg-small-recv option
      netlink: add a nla_nest_end_safe() helper
      ethtool: strset: check nla_len overflow

Hans de Goede (2):
      Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
      Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod

Hari Chandrakanthan (1):
      wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver

Harish Rachakonda (1):
      wifi: ath12k: Support channel change stats

Heiner Kallweit (19):
      net: ti: davinci_emac: stop using bus type mdio_bus_type
      net: mdio: extend struct mdio_bus_stat_attr instead of using dev_ext_attribute
      net: mdio: use macro __ATTR to simplify the code
      net: phy: consider that mdio_bus_device_stat_field_show doesn't use member address
      net: phy: avoid extra casting in mdio_bus_get_stat
      net: mdio: constify attributes and attribute arrays
      net: mdio: use macro __ATTRIBUTE_GROUPS
      net: phy: inline helper mdio_bus_get_global_stat
      net: phy: improve mdiobus_stats_acct
      Revert "net: phy: improve mdiobus_stats_acct"
      net: phy: remove phy_attach
      net: mdio: remove selecting FIXED_PHY for FWNODE_MDIO
      net: phy: move mdio_device reset handling functions in the code
      net: phy: make mdio_device.c part of libphy
      net: phy: move (of_)mdio_find_bus to mdio_bus_provider.c
      net: phy: move registering mdio_bus_class and mdio_bus_type to libphy
      net: phy: move remaining provider code to mdio_bus_provider.c
      regmap: mdio: make it depend on PHYLIB
      net: phy: remove Kconfig symbol MDIO_BUS

Heitor Alves de Siqueira (2):
      wifi: libertas: use USB anchors for tracking in-flight URBs
      wifi: libertas: don't kill URBs in interrupt context

Howard Hsu (1):
      wifi: mt76: mt7996: support critical packet mode for MT7990 chipsets

Håkon Bugge (1):
      net/rds: Optimize rds_ib_laddr_check

Ido Schimmel (3):
      vrf: Remove unnecessary NULL check
      vrf: Use dst_dev_put() instead of using loopback device
      vrf: Remove unnecessary RCU protection around dst entries

Ilan Peer (4):
      wifi: cfg80211: Add support for additional 7 GHz channels
      wifi: iwlwifi: mld: Refactor scan command handling
      wifi: iwlwifi: mld: Introduce scan command version 18
      wifi: ieee80211: Add some missing NAN definitions

Inochi Amaoto (6):
      net: ethernet: litex: use devm_register_netdev() to register netdev
      net: ethernet: litex: use device pointer to simplify code.
      dt-bindings: net: Add support for Spacemit K3 dwmac
      net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
      net: stmmac: Add glue layer for Spacemit K3 SoC
      MAINTAINERS: add entry for SpacemiT DWMAC glue layer

Ioana Ciornei (13):
      net: dpaa2-mac: extend APIs related to statistics
      net: dpaa2-mac: retrieve MAC statistics in one firmware command
      net: dpaa2-mac: export standard statistics
      selftests: forwarding: extend ethtool_std_stats_get with pause statistics
      selftests: net: extend lib.sh to parse drivers/net/net.config
      selftests: net: update some helpers to use run_on
      selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
      selftests: drivers: hw: test rmon counters only on first interface
      selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
      selftests: drivers: hw: move to KTAP output
      selftests: drivers: hw: update ethtool_rmon to work with a single local interface
      selftests: drivers: hw: add test for the ethtool standard counters
      selftests: forwarding: lib: rewrite processing of command line arguments

Ivan Vecera (16):
      dpll: zl3073x: detect DPLL channel count from chip ID at runtime
      dpll: zl3073x: add die temperature reporting for supported chips
      dpll: zl3073x: use struct_group to partition states
      dpll: zl3073x: add zl3073x_ref_state_update helper
      dpll: zl3073x: introduce zl3073x_chan for DPLL channel state
      dpll: zl3073x: add DPLL channel status fields to zl3073x_chan
      dpll: zl3073x: add reference priority to zl3073x_chan
      dpll: zl3073x: drop selected and simplify connected ref getter
      dpll: add frequency monitoring to netlink spec
      dpll: add frequency monitoring callback ops
      dpll: zl3073x: implement frequency monitoring
      dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
      dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
      dpll: zl3073x: add ref sync and output clock type helpers
      dt-bindings: dpll: add ref-sync-sources property
      dpll: zl3073x: add ref-sync pair support

Izabela Bakollari (1):
      sfc: add transmit timestamping support

J. Neuschäfer (1):
      wifi: rtl8xxxu: Mark RTL8188ETV (0bda:0179) as tested

Jaime Saguillo Revilla (1):
      wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter names

Jakub Kicinski (207):
      Merge branch 'tcp-rework-tcp_v-4-6-_send_check'
      Merge branch 'net-ethernet-enic-add-vic-ids-and-link-modes'
      Merge branch 'net-stmmac-qcom-ethqos-cleanups-and-re-organise-serdes-handling'
      eth: bnxt: rename ring_err_stats -> ring_drv_stats
      selftests: net: py: avoid masking exceptions in bkg() failures
      selftests: net: py: use repr(cmd) for failure exceptions
      selftests: net: py: add cmd info for ksft_wait failure
      Merge branch 'selftests-net-py-improve-bkg-error-reporting'
      selftests: hw-net: tso: set a TCP window clamp to avoid spurious drops
      Merge branch 'net-stmmac-fix-interrupt-coalescing'
      Merge branch 'netfilter-updates-for-net-next'
      Merge branch 'add-selftests-helper-to-get-n-unique-ports'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'support-phys-that-have-inband-autoneg-disabled-with-gem'
      Merge branch 'net-ethernet-litex-minor-improvment-for-the-codebase'
      Merge branch 'gve-support-larger-ring-sizes-in-dqo-qpl-mode'
      Merge branch 'npc-hw-block-support-for-cn20k'
      Merge branch 'icmp-fix-icmp-error-source-address-over-xfrm-tunnel'
      Merge branch 'net-sched-refactor-qdisc-drop-reasons-into-dedicated-tracepoint'
      Merge tag 'phy-qcom-sgmii-eth-add-set_mode-and-validate-methods'
      selftests: drv-net: iou-zcrx: wait for memory provider cleanup
      selftests: drv-net: iou-zcrx: rework large chunks test to use common setup
      selftests: drv-net: iou-zcrx: allocate hugepages for large chunks test
      Merge branch 'selftests-drv-net-iou-zcrx-improve-stability-and-make-the-large-chunk-test-work'
      Merge branch 'net-stmmac-further-cleanups'
      Merge branch 'net-sparx5-clean-up-probe-remove-init-and-deinit-paths'
      Merge branch 'ipmr-no-rtnl-for-rtnl_family_ipmr-rtnetlink'
      Merge branch 'grab-ipa-imem-slice-through-dt'
      Merge tag 'wireless-next-2026-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      tools: ynl: rename TESTS variable to TEST_PROGS
      tools: ynl: don't install tests in /usr/bin/
      tools: ynl: support INSTALL_PATH in the tests Makefile
      tools: ynl: produce kselftest-list.txt from tests
      Merge branch 'tools-ynl-tests-adjust-makefile-to-mimic-ksft'
      Merge branch 'rfs-use-high-order-allocations-for-hash-tables'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      selftests: drv-net: update the README
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-qcom-ethqos-further-serdes-reorganisation'
      Merge branch 'doc-netlink-expand-nftables-specification'
      Merge branch 'net-cadence-macb-add-ieee-802-3az-eee-support'
      Merge branch 'selftests-net-add-netkit-container-env-and-test'
      docs: netdev: refine netdevsim testing guidance
      Merge branch 'net-stmmac-mdio-related-cleanups'
      Merge branch 'nfc-drop-redundant-usb-device-references'
      Merge branch 'net-ntb_netdev-add-multi-queue-support'
      tools: ynl: move samples to tests
      tools: ynl: convert netdev sample to selftest
      tools: ynl: convert ovs sample to selftest
      tools: ynl: convert rt-link sample to selftest
      tools: ynl: convert tc and tc-filter-add samples to selftest
      tools: ynl: add netdevsim wrapper library for YNL tests
      tools: ynl: convert devlink sample to selftest
      tools: ynl: convert ethtool sample to selftest
      tools: ynl: convert rt-addr sample to selftest
      tools: ynl: convert rt-route sample to selftest
      Merge branch 'tools-ynl-convert-samples-into-selftests'
      Merge tag 'ib-gpio-remove-of-gpio-h-for-v7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into mbox
      Merge branch 'net-stmmac-further-ptp-cleanups'
      Merge branch 'smc-sysctl-formatting-and-missing-entries'
      tools: ynl: cli: order set->list conversion in JSON output
      Merge branch 'selftests-rds-ksft-cleanups'
      tools: ynl: handle pad type during decode
      tools: ynl: move policy decoding out of NlMsg
      tools: ynl: add short doc to class YnlFamily
      tools: ynl: add Python API for easier access to policies
      tools: ynl: cli: add --policy support
      Merge branch 'tools-ynl-policy-query-support'
      Merge branch 'amd-xgbe-improve-power-management-for-s0i3'
      Merge branch 'net-stmmac-start-to-shrink-memory-usage'
      Merge branch 'net-macb-clean-up-several-member-settings-of-macb_config-instances'
      Merge branch 'selftests-net-fix-cmd-process-timeout-handling'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      genetlink: use maxattr of 0 for the reject policy
      genetlink: apply reject policy for split ops on the dispatch path
      selftests: net: make sure that Netlink rejects unknown attrs in dump
      selftests: net: add test for Netlink policy dumps
      Merge branch 'genetlink-apply-reject-policy-for-split-ops-on-the-dispatch-path'
      Merge branch 'udp-retire-udp-lite'
      Merge branch 'tcp-rfc-7323-compliant-window-retraction-handling'
      Merge branch 'net-add-skb_drop_reason_recursion_limit'
      Merge branch 'net-phy-further-decouple-provider-from-consumer-part'
      Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'
      Merge branch 'dpaa2-fix-config-relation-with-fsl_dpaa2_switch'
      selftests: net: py: give bpftrace more time to start
      Merge branch 'support-multi-channel-irqs-in-stmmac-platform-drivers'
      Merge branch 'dpll-zl3073x-refactor-state-management'
      Merge branch 'riscv-spacemit-add-ethernet-support-for-k3'
      Merge branch 'net-stmmac-clean-up-descriptor-handling-part-1'
      tools: ynl: rework policy access to support recursion
      Merge branch 'dt-bindings-net-micrel-fix-ksz8041rnli-dtbs_check-warnings'
      Merge branch 'remove-kconfig-sysmbol-mdio_bus'
      Merge branch 'net-mdio-gpio-remove-unneeded-headers'
      Merge branch 'net-mlx5-support-ptm-on-arm-architecture'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'add-ethtool-coalesce_rx_cqe_frames-nsecs-and-use-it-in-mana-driver'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: net: move gro to lib for HW vs SW reuse
      selftests: drv-net: give HW stats sync time extra 25% of margin
      selftests: drv-net: gro: use SO_TXTIME to schedule packets together
      selftests: drv-net: gro: test GRO stats
      selftests: drv-net: gro: add test for packet ordering
      selftests: drv-net: gro: add a test for GRO depth
      Merge branch 'selftests-drv-net-driver-tests-for-hw-gro'
      Merge branch 'net-stmmac-descriptor-cleanups-part-2'
      Merge branch 'selftests-vsock-support-nested-vm-runner-for-vmtest-sh'
      Merge branch 'net-phy-realtek-pair-order-and-polarity'
      Merge branch 'netdevsim-support-ets-offload'
      Merge branch 'net-stmmac-improve-pcs-support'
      Merge branch 'ethtool-dynamic-rss-context-indirection-table-resizing'
      Merge branch 'selftests-rds-add-config-file-and-config-sh-c-option'
      Merge branch 'net-dsa-mxl862xx-mdio-bus-integrity-and-optimization'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-support-for-nuvoton-ma35d1-gmac'
      Merge tag 'wireless-next-2026-03-26' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-stmmac-dwmac-socfpga-cleanup-fix_mac_speed'
      Merge branch 'add-support-for-per-route-seg6-tunsrc'
      Merge branch 'net-dsa-microchip-small-cleanups-for-ksz9477-sgmii'
      Merge branch 'net-stmmac-remove-unused-and-unimplemented-axi-properties'
      Merge branch 'net-stmmac-disable-eee-on-i-mx'
      Merge branch 'vrf-a-few-cleanups'
      Merge branch 'convert-config_ipv6-to-built-in-and-remove-stubs'
      Merge branch 'bnxt_en-add-xdp-rss-hash-metadata-support'
      Merge branch 'macb-usrio-tsu-patches'
      Merge branch 'net-hsr-subsystem-cleanups-and-modernization'
      net: Clear the dst when performing encap / decap
      selftests/bpf: Test that dst is cleared on same-protocol encap
      Merge branch 'net-stmmac-qcom-ethqos-more-cleanups'
      selftests: drv-net: update the README with variants
      Merge branch 'net-refactor-usb-endpoint-lookups'
      Merge branch 'nfc-refactor-usb-endpoint-lookups'
      Merge branch 'declance-improve-dma-error-reporting'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'linux-can-next-for-7.1-20260401' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-tso-fixes-cleanups'
      Merge branch 'macvlan-broadcast-delivery-changes'
      Merge branch 'net-phy-microchip-add-downshift-support-for-lan88xx'
      Merge branch 'enic-sr-iov-v2-preparatory-infrastructure'
      selftests: drv-net: gro: add data burst test case
      selftests: drv-net: gro: add 1 byte payload test
      selftests: drv-net: gro: always wait for FIN in the capacity test
      selftests: drv-net: gro: prepare for ip6ip6 support
      selftests: drv-net: gro: remove TOTAL_HDR_LEN
      selftests: drv-net: gro: make large packet math more precise
      selftests: drv-net: gro: test ip6ip6
      selftests: drv-net: gro: add a test for bad IPv4 csum
      Merge branch 'selftests-drv-net-gro-more-test-cases'
      Merge branch 'net-macb-remove-dedicated-irq-handler-for-wol'
      Merge branch 'dpll-add-frequency-monitoring-feature'
      selftests: net: py: color the basics in the output
      Merge branch 'net-dsa-mxl862xx-add-support-for-bridge-offloading'
      Merge branch 'nfc-support-for-five-qualcomm-sdm845-phones'
      eth: remove the driver for acenic / tigon1&2
      Merge branch 'mptcp-support-msg_eor-and-small-cleanups'
      selftests: drv-net: adjust to socat changes
      Merge branch 'net-pull-gso-packet-headers-in-core-stack'
      Merge tag 'ipsec-next-2026-04-08' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge tag 'nf-next-26-04-08' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      docs: netdev: improve wording of reviewer guidance
      Merge branch 'mptcp-autotune-related-improvement'
      Merge branch 'dsa_loop-and-platform_data-cleanups'
      Merge branch 'devlink-add-per-port-resource-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'netkit-support-for-io_uring-zero-copy-and-af_xdp'
      net: remove the netif_get_rx_queue_lease_locked() helpers
      Merge branch 'macsec-add-support-for-vlan-filtering-in-offload-mode'
      Merge branch 'net-bcmgenet-fix-queue-lock-up'
      selftests: net: py: explicitly forbid multiple ksft_run() calls
      Merge branch 'add-selftests-for-ntuple-nfc-rules'
      Merge branch 'net-bridge-add-stp_mode-attribute-for-stp-mode-selection'
      Merge branch 'net-dsa-mxl862xx-vlan-support-and-minor-improvements'
      Merge branch 'dpll-zl3073x-add-ref-sync-pair-support'
      Merge branch 'wangxun-improvement'
      Merge branch 'net-dsa-tag_rtl8_4-fixes-doc-and-set-keep'
      Merge branch 'ipvlan-multicast-delivery-changes'
      net: fix reference tracker mismanagement in netdev_put_lock()
      selftests: net: py: add test case filtering and listing
      Merge tag 'wireless-next-2026-04-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'linux-can-fixes-for-7.0-20260409' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'nf-next-26-04-10' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'add-tso-map-once-dma-helpers-and-bnxt-sw-uso-support'
      Merge branch 'bng_en-add-link-management-and-statistics-support'
      Merge branch 'net-mana-fix-debugfs-directory-naming-and-file-lifecycle'
      Merge branch 'ynl-ethtool-netlink-fix-nla_len-overflow-for-large-string-sets'
      Merge branch 'net-phy-add-support-for-disabling-autonomous-eee'
      Merge branch 'bpf-fix-sock_ops_get_sk-same-register-oob-read-in-sock_ops-and-add-selftest'
      Merge branch 'net-enetc-improve-statistics-for-v1-and-add-statistics-for-v4'
      Merge branch 'net-hamradio-fix-missing-input-validation-in-bpqether-and-scc'
      Merge branch 'net-rds-fix-use-after-free-in-rds-ib-for-non-init-namespaces'
      Merge branch 'more-fixes-for-the-ipa-driver'
      Merge branch 'add-support-for-pic64-hpsc-hx-mdio-controller'
      Merge branch 'net-reduce-sk_filter-and-friends-bloat'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'mlx5-misc-fixes-2026-04-09'
      Merge branch 'ipa-v5-2-support'
      Merge branch 'net-fix-skb_ext-build_bug_on-failures-with-gcov'
      tcp: update window_clamp when SO_RCVBUF is set
      Merge tag 'for-net-next-2026-04-13' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'net-move-getsockopt-away-from-__user-buffers'
      Merge branch 'net-qrtr-ns-a-bunch-of-fixs'
      Merge branch 'octeon_ep_vf-fix-napi_build_skb-null-dereference'
      Merge branch 'net-dsa-mxl862xx-add-statistics-support'
      Merge branch 'net-airoha-preliminary-series-to-support-multiple-net_devices-connected-to-the-same-gdm-port'
      Merge branch 'follow-ups-to-nk_qlease-net-selftests'
      Merge branch 'wireguard-fixes-for-7-1-rc1'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jamal Hadi Salim (1):
      net/sched: act_ct: Only release RCU read lock after ct_ft

Jan Hoffmann (1):
      net: sfp: add quirk for ZOERAX SFP-2.5G-T

Jan Petrous (OSS) (3):
      net: stmmac: platform: read channels irq
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      stmmac: s32: enable support for Multi-IRQ mode

Janusz Dziedzic (4):
      wifi: cfg80211: fix background CAC
      wifi: cfg80211: set and report chandef CAC ongoing
      wifi: cfg80211: events, report background radar
      wifi: mac80211_hwsim: background CAC support

Jason A. Donenfeld (1):
      wireguard: allowedips: remove redundant space

Jason Xing (1):
      net: advance skb_defer_disable_key check in napi_consume_skb

Javen Xu (1):
      r8169: add support for RTL8125cp

Javier Tia (8):
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
      Bluetooth: btmtk: fix ISO interface setup for single alt setting
      Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
      Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
      Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
      Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
      Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
      Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Jeff Johnson (2):
      wifi: ath12k: Clean up the WMI Unit Test command interface
      wifi: ath12k: Remove unused DFS Unit Test definitions

Jelle van der Waa (1):
      netfilter: nf_tables: Fix typo in enum description

Jens Emil Schulz Østergaard (1):
      net: phy: micrel: Add support for lan9645x internal phy

Jeremy Kerr (6):
      net: mctp: avoid copy in fragmentation loop for near-MTU messages
      net: mctp: perform source address lookups when we populate our dst
      net: mctp: allow local TX with no address assigned
      net: mctp: don't require a route for null-EID ingress
      net: mctp: tests: use actual address when creating dev with addr
      net: mctp: defer creation of dst after source-address check

Jesper Dangaard Brouer (5):
      net: sched: introduce qdisc-specific drop reason tracing
      net: sched: sfq: convert to qdisc drop reasons
      net: sched: rename QDISC_DROP_FQ_* to generic names
      net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
      net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops

Jiajia Liu (1):
      wifi: mac80211: remove unused variables in minstrel_ht_alloc_sta

Jiawen Wu (10):
      net: txgbe: fix RTNL assertion warning when remove module
      net: ngbe: remove netdev->ethtool->wol_enabled setting
      net: ngbe: move the WOL functions to libwx
      net: ngbe: remove redundant macros
      net: wangxun: replace busy-wait reset flag with kernel mutex
      net: wangxun: move ethtool_ops.set_channels into libwx
      net: wangxun: reorder timer and work sync cancellations
      net: wangxun: schedule hardware stats update in watchdog
      net: libwx: wrap-around and reset qmprc counter
      net: libwx: improve flow control setting

Jiayuan Chen (11):
      net: fix sock compilation error under CONFIG_PREEMPT_RT
      net: annotate data races around sk->sk_prot
      net: sched: cls_u32: Avoid memcpy() false-positive warning in u32_init_knode()
      selftests: bonding: add test for stacked bond header_parse recursion
      tcp: Fix inconsistent indenting warning
      net: initialize sk_rx_queue_mapping in sk_clone()
      net: skb: clean up dead code after skb_kfree_head() simplification
      bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
      selftests/bpf: Add tests for sock_ops ctx access with same src/dst register
      net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
      selftests/bpf: add test for xdp_master_redirect with bond not up

Jiejian Wu (1):
      ipvs: make ip_vs_svc_table and ip_vs_svc_fwm_table per netns

Jiri Pirko (14):
      devlink: expose devlink instance index over netlink
      devlink: add helpers to get bus_name/dev_name
      devlink: avoid extra iterations when found devlink is not registered
      devlink: allow to use devlink index as a command handle
      devlink: support index-based lookup via bus_name/dev_name handle
      devlink: support index-based notification filtering
      devlink: introduce __devlink_alloc() with dev driver pointer
      devlink: add devlink_dev_driver_name() helper and use it in trace events
      devlink: add devl_warn() helper and use it in port warnings
      devlink: allow devlink instance allocation without a backing device
      devlink: introduce shared devlink instance for PFs on same chip
      documentation: networking: add shared devlink documentation
      net/mlx5: Add a shared devlink instance for PFs on same chip
      mlx5: shd: Gracefully avoid shared devlink creation when no usable SN is found

Joe Damato (10):
      net: tso: Introduce tso_dma_map and helpers
      net: bnxt: Export bnxt_xmit_get_cfa_action
      net: bnxt: Add a helper for tx_bd_ext
      net: bnxt: Use dma_unmap_len for TX completion unmapping
      net: bnxt: Add TX inline buffer infrastructure
      net: bnxt: Add boilerplate GSO code
      net: bnxt: Implement software USO
      net: bnxt: Add SW GSO completion and teardown support
      net: bnxt: Dispatch to SW USO
      selftests: drv-net: Add USO test

Joey Lu (2):
      dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
      net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family

Johan Hovold (33):
      wifi: at76c50x: drop redundant device reference
      wifi: libertas: drop redundant device reference
      wifi: libertas_tf: drop redundant device reference
      wifi: rt2x00: drop redundant device reference
      wifi: mwifiex: drop redundant device reference
      nfc: pn533: drop redundant device reference
      nfc: port100: drop redundant device reference
      net: usb: lan78xx: drop redundant device reference
      wifi: ath6kl: drop redundant device reference
      wifi: ath6kl: rename disconnect callback
      wifi: ath9k: drop redundant device reference
      wifi: ath10k: drop redundant device reference
      wifi: ath10k: rename disconnect callback
      net: mdio: mvusb: drop redundant device reference
      wifi: rtl818x: drop redundant device reference
      wifi: rtl8xxxu: drop redundant device reference
      wifi: rtw88: fix device leak on probe failure
      wifi: rtw89: drop redundant device reference
      wifi: rtlwifi: usb: drop redundant device reference
      ieee802154: atusb: drop redundant device reference
      net: hso: refactor endpoint lookup
      net: ipeth: refactor endpoint lookup
      nfc: nfcmrvl: refactor endpoint lookup
      nfc: pn533: refactor endpoint lookup
      nfc: port100: refactor endpoint lookup
      can: kvaser_usb: leaf: refactor endpoint lookup
      can: ucan: refactor endpoint lookup
      wifi: at76c50x: refactor endpoint lookup
      wifi: libertas: refactor endpoint lookup
      wifi: libertas_tf: refactor endpoint lookup
      can: ucan: fix devres lifetime
      Bluetooth: btusb: refactor endpoint lookup
      Bluetooth: btmtk: refactor endpoint lookup

Johannes Berg (35):
      wifi: mac80211: give the AP more time for EPPKE as well
      Merge tag 'ath-next-20260303' of https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: move action code from per-type frame structs
      wifi: mac80211: remove stale TODO item
      wifi: mac80211: remove AID bit stripping for print
      wifi: nl80211: fix UHR capability validation
      wifi: ieee80211: fix UHR operation DBE vs. P-EDCA order
      wifi: nl80211: split out UHR operation information
      wifi: mac80211: validate HE 6 GHz operation when EHT is used
      wifi: mac80211: refactor chandef tracing macros
      wifi: mac80211: always use full chanctx compatible check
      wifi: cfg80211: split control freq check from chandef check
      wifi: nl80211: reject S1G/60G with HT chantype
      wifi: mac80211: fix STA link removal during link removal
      wifi: nl80211: use int for band coming from netlink
      Merge tag 'ath-next-20260324' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211_hwsim: advertise basic UHR support
      Merge tag 'mt76-next-2026-03-23' of https://github.com/nbd168/wireless
      wifi: iwlwifi: restrict TOP reset to some devices
      wifi: iwlwifi: mld: enable UHR in TLC
      wifi: iwlwifi: mld: set UHR MCS in RX status
      wifi: iwlwifi: mld: support changing iftype at runtime
      wifi: iwlwifi: use IWL_FW_CHECK for sync timeout
      wifi: iwlwifi: pcie: don't dump on reset handshake in dump
      wifi: iwlwifi: mld: make iwl_mld_mac80211_iftype_to_fw() static
      wifi: iwlwifi: mld: remove type argument from iwl_mld_add_sta()
      wifi: iwlwifi: mld: rename iwl_mld_phy_from_mac80211() argument
      wifi: iwlwifi: mld: make alloc functions not forced static
      wifi: iwlwifi: mld: add double-include guards to nan.h
      wifi: iwlwifi: add MAC context command version 4
      wifi: iwlwifi: mld: set RX_FLAG_RADIOTAP_TLV_AT_END generically
      Merge tag 'iwlwifi-next-2026-03-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into wireless-next
      Merge tag 'rtw-next-2026-04-02' of https://github.com/pkshih/rtw into wireless-next
      Merge tag 'ath-next-20260407' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'ath-next-20260408' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Jori Koolstra (2):
      wifi: mac80211_hwsim: change hwsim_class to a const struct
      dibs: change dibs_class to a const struct

Joris Vaisvila (1):
      net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628

Joshua Peisach (1):
      wifi: b43: use register definitions in nphy_op_software_rfkill

Josua Mayer (1):
      dt-bindings: net: dsa: nxp,sja1105: make spi-cpol optional for sja1110

Julian Anastasov (13):
      ipvs: some service readers can use RCU
      ipvs: use single svc table
      ipvs: do not keep dest_dst after dest is removed
      ipvs: use more counters to avoid service lookups
      ipvs: no_cport and dropentry counters can be per-net
      rculist_bl: add hlist_bl_for_each_entry_continue_rcu
      ipvs: add resizable hash tables
      ipvs: use resizable hash table for services
      ipvs: switch to per-net connection table
      ipvs: use more keys for connection hashing
      ipvs: show the current conn_tab size to users
      ipvs: add ip_vs_status info
      ipvs: add conn_lfactor and svc_lfactor sysctl vars

Julian Braha (3):
      ppp: dead code cleanup in Kconfig
      net: microchip: dead code cleanup in kconfig for FDMA
      stmmac: cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in Kconfig

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Justin Chen (3):
      net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
      net: bcmgenet: fix leaking free_bds
      net: bcmgenet: fix racing timeout handler

Justin Iurman (2):
      seg6: add per-route tunnel source address
      selftests: add check for seg6 tunsrc

Kamiyama Chiaki (1):
      Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d

Karthikeyan Kathirvel (1):
      wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing

Karthikeyan Periyasamy (1):
      wifi: ath12k: Remove the unused argument from the Rx data path

Kavita Kavita (5):
      wifi: mac80211_hwsim: Advertise support for (Re)Association frame encryption
      wifi: mac80211: Advertise EPPKE support based on driver capabilities
      wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
      wifi: mac80211: Add support for IEEE 802.1X authentication protocol in non-AP STA mode
      wifi: mac80211: Advertise IEEE 802.1X authentication support

Kees Cook (1):
      wifi: mac80211: Replace strncpy() with strscpy_pad() in drv_switch_vif_chanctx tracepoint

Keita Morisaki (2):
      tcp: shrink per-packet memset in __tcp_transmit_skb()
      tcp: remove unused hash_size from struct tcp_out_options

Kevin Hao (9):
      net: macb: Clean up the .clk_init setting in the macb_config instances
      net: macb: Clean up the .init settings in macb_config instances
      net: macb: Clean up the .usrio settings in macb_config instances
      net: macb: Replace open-coded implementation with napi_schedule()
      net: macb: Introduce macb_queue_isr_clear() helper function
      net: macb: Factor out the handling of non-hot IRQ events into a separate function
      net: macb: Remove dedicated IRQ handler for WoL
      net: macb: Use netif_napi_add_tx() instead of netif_napi_add() for TX NAPI
      net: macb: Use napi_schedule_irqoff() in IRQ handler

Kexin Sun (6):
      net/hsr: update outdated comments
      wifi: mac80211: update outdated comment
      qlcnic: update outdated comment
      netlink: update outdated comment
      hv_sock: update outdated comment for renamed vsock_stream_recvmsg()
      net: phy: update outdated comment for removed phy_package_read/write()

Kibaek Yoo (2):
      net: macvlan: support multicast rx for bridge ports with shared source MAC
      selftests: net: add macvlan multicast test for shared source MAC

Kiran K (10):
      Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
      Bluetooth: btintel: Replace CNVi id with hardware variant
      Bluetooth: btintel: Add support for Scorpious Peak2 support
      Bluetooth: btintel: Add DSBR support for ScP2 onwards
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2
      Bluetooth: btintel: Add support for Scorpious Peak2F support
      Bluetooth: btintel_pcie: Add support for exception dump for ScP2F
      Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
      Bluetooth: btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
      Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes

Kohei Enju (1):
      net: core: allow netdev_upper_get_next_dev_rcu from bh context

Koichiro Den (4):
      net: ntb_netdev: Introduce per-queue context
      net: ntb_netdev: Gate subqueue stop/wake by transport link
      net: ntb_netdev: Factor out multi-queue helpers
      net: ntb_netdev: Support ethtool channels for multi-queue

Konrad Dybcio (3):
      dt-bindings: sram: qcom,imem: Allow modem-tables subnode
      dt-bindings: net: qcom,ipa: Add sram property for describing IMEM slice
      net: ipa: Grab IMEM slice base/size from DTS

Konstantin Khorenko (2):
      net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
      net: add noinline __init __no_profile to skb_extensions_init() for GCOV compatibility

Kory Maincent (1):
      net: pse-pd: fix kernel-doc function name for pse_control_find_by_id()

Kryštof Černý (1):
      net: phy: realtek: Add support for PHY LEDs on RTL8211F-VD

Kuan-Chung Chen (1):
      wifi: rtw89: add H2C command to protect TX/RX for unused PHY

Kuniyuki Iwashima (35):
      bonding: Optimise is_netpoll_tx_blocked().
      selftest: net: Add basic functionality tests for ipmr.
      ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
      ipmr: Convert ipmr_rtm_dumplink() to RCU.
      ipmr: Use MAXVIFS in mroute_msgsize().
      ipmr: Convert ipmr_rtm_getroute() to RCU.
      ipmr: Convert ipmr_rtm_dumproute() to RCU.
      ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
      ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
      ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
      ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
      ipmr: Call fib_rules_unregister() without RTNL.
      ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under CONFIG_IP_MROUTE.
      ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
      ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
      ipmr: Don't hold RTNL for ipmr_rtm_route().
      dccp Remove inet_hashinfo2_init_mod().
      tcp: Initialise ehash secrets during connect() and listen().
      udp: Make udp[46]_seq_show() static.
      ipv6: Retire UDP-Lite.
      ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
      ipv4: Retire UDP-Lite.
      udp: Remove UDP-Lite SNMP stats.
      smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
      udp: Remove partial csum code in RX.
      udp: Remove partial csum code in TX.
      udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
      udp: Remove struct proto.h.udp_table.
      udp: Remove udp_table in struct udp_seq_afinfo.
      udp: Remove dead check in __udp[46]_lib_lookup() for BPF.
      udp: Don't pass udptable to IPv6 socket lookup functions.
      udp: Don't pass udptable to IPv4 socket lookup functions.
      udp: Don't pass proto to __udp4_lib_rcv() and __udp6_lib_rcv().
      fou: Remove IPPROTO_UDPLITE check in gue_err() and gue6_err().
      tcp: Don't set treq->req_usec_ts in cookie_tcp_reqsk_init().

Kyoji Ogasawara (2):
      net/smc: fix indentation in smcr_buf_type section
      net/smc: Add documentation for limit_smc_hs and hs_ctrl

Lachlan Hodges (3):
      wifi: mac80211: don't use cfg80211_chandef_create() for default chandef
      wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands
      wifi: cfg80211: check non-S1G width with S1G chandef

Laurence Rowe (1):
      vsock: avoid timeout for non-blocking accept() with empty backlog

Laurent Pinchart (1):
      net: stmmac: imx: Disable EEE

Leon Hwang (1):
      selftests/drivers/net: Add an xdp test to xdp.py

Leon Kral (1):
      net/handshake: Fixed grammar mistake

Leon Yen (5):
      wifi: mt76: mt7925: introduce CSA support in non-MLO mode
      wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control
      wifi: mt76: mt792x: Fix a potential deadlock in high-load situations
      wifi: mt76: mt7921: fix a potential clc buffer length underflow
      wifi: mt76: mt7925: fix tx power setting failure after chip reset

Li RongQing (1):
      net/mlx5: Move command entry freeing outside of spinlock

Linus Heckemann (1):
      selftests/net: add test for IP-in-IPv6 tunneling

Linus Walleij (1):
      net: dsa: qca8k: Use the right GPIO header

Long Li (1):
      net: mana: Set default number of queues to 16

Lorenzo Bianconi (48):
      net: airoha: Rely __field_prep for non-constant masks
      net: airoha: Make flow control source port mapping dependent on nbq parameter
      net: airoha: Move GDM forward port configuration in ndo_open/ndo_stop callbacks
      wifi: mac80211: Remove deleted sta links in ieee80211_ml_reconf_work()
      net: airoha: select QDMA block according LAN/WAN configuration
      net: airoha: Reset PPE cpu port configuration in airoha_ppe_hw_init()
      wifi: mt76: mt7996: Set mtxq->wcid just for primary link
      wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
      wifi: mt76: mt7996: Clear wcid pointer in mt7996_mac_sta_deinit_link()
      wifi: mt76: mt7996: Reset ampdu_state state in case of failure in mt7996_tx_check_aggr()
      wifi: mt76: Fix memory leak destroying device
      wifi: mt76: mt7996: Fix NPU stop procedure
      wifi: mt76: npu: Add missing rx_token_size initialization
      wifi: mt76: always enable RRO queues for non-MT7992 chipset
      wifi: mt76: mt7996: Fix BAND2 tx queues initialization when NPU is enabled
      wifi: mt76: mt7996: Fix wdma_idx for MT7996 device if NPU is enabled
      wifi: mt76: mt7996: Add mt7992_npu_txrx_offload_init routine
      wifi: mt76: mt7996: Rename mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
      wifi: mt76: mt7996: Add NPU support for MT7990 chipset
      wifi: mt76: mt7996: Integrate NPU in RRO session management
      wifi: mt76: mt7996: Integrate MT7990 init configuration for NPU
      wifi: mt76: mt7996: Integrate MT7990 dma configuration for NPU
      wifi: mt76: mt7996: Add __mt7996_npu_hw_init routine
      wifi: mt76: mt7996: Move RRO dma start in a dedicated routine
      wifi: mt76: Do not reset idx for NPU tx queues during reset
      wifi: mt76: mt7996: Do not schedule RRO and TxFree queues during reset for NPU
      wifi: mt76: mt7996: Store DMA mapped buffer addresses in mt7996_npu_hw_init()
      wifi: mt76: Enable NPU support for MT7996 devices
      net: airoha: Rework the code flow in airoha_remove() and in airoha_probe() error path
      wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA property
      wifi: mt76: mt7996: Remove link pointer dependency in mt7996_mac_sta_remove_links()
      wifi: mt76: mt7996: Remove unnecessary phy filed in mt7996_vif_link struct
      wifi: mt76: mt7996: Decrement sta counter removing the link in mt7996_mac_reset_sta_iter()
      wifi: mt76: mt7996: Rely on msta_link link_id in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Destroy vif active links in mt7996_remove_interface()
      wifi: mt76: mt7996: Destroy active sta links in mt7996_mac_sta_remove()
      net: airoha: Fix typo in airoha_set_gdm2_loopback routine name
      net: airoha: Set REG_RX_CPU_IDX() once in airoha_qdma_fill_rx_queue()
      net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()
      net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2 is available
      net: airoha: Add missing RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue()
      net: airoha: Rely on net_device pointer in airoha_dev_setup_tc_block signature
      net: airoha: Rely on net_device pointer in HTB callbacks
      net: airoha: Rely on net_device pointer in ETS callbacks
      net: airoha: Remove PCE_MC_EN_MASK bit in REG_FE_PCE_CFG configuration
      net: airoha: Fix VIP configuration for AN7583 SoC
      net: airoha: Add missing PPE configurations in airoha_ppe_hw_init()

Luca Weiss (4):
      net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
      net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
      dt-bindings: net: qcom,ipa: add Milos compatible
      net: ipa: add IPA v5.2 configuration data

Lucid Duck (1):
      wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs

Luigi Leonardi (1):
      vsock/virtio: remove unnecessary call to `virtio_transport_get_ops`

Luiz Angelo Daros de Luca (1):
      net: dsa: tag_rtl8_4: set KEEP flag

Luiz Augusto von Dentz (2):
      Bluetooth: btintel_pci: Fix btintel_pcie_read_hwexp code style
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Luka Gejak (2):
      net: hsr: constify hsr_ops and prp_ops protocol operation structures
      net: hsr: use __func__ instead of hardcoded function name

Lukas Kraft (1):
      bluetooth: btusb: Fix whitespace in btusb.c

Luxiao Xu (1):
      net: strparser: fix skb_head leak in strp_abort_strp()

MD Danish Anwar (3):
      net: ti: icssg: Add HSR/PRP protocol frame filtering
      net: ti: icssg: Fix wrong macro used in RX classifier configuration
      net: ti: icssg-prueth: Add HSR multicast FDB port membership management

Maciej Fijalkowski (1):
      xsk: remove repeated defines

Maciej W. Rozycki (4):
      FDDI: defza: Rate-limit memory allocation errors
      FDDI: defxx: Rate-limit memory allocation errors
      declance: Rate-limit DMA errors
      declance: Include the offending address with DMA errors

Madhur Kumar (1):
      wifi: mt76: mt7921: Replace deprecated PCI function

Maharaja Kennadyrajan (1):
      wifi: ath12k: add basic hwmon temperature reporting

Maher Sanalla (2):
      net/mlx5: Add TLP emulation device capabilities
      net/mlx5: Expose TLP emulation capabilities

Manish Dharanenthiran (1):
      wifi: ath12k: Fix the assignment of logical link index

Manivannan Sadhasivam (5):
      net: qrtr: ns: Limit the maximum server registration per node
      net: qrtr: ns: Limit the maximum number of lookups
      net: qrtr: ns: Free the node during ctrl_cmd_bye()
      net: qrtr: ns: Limit the total number of nodes
      net: qrtr: ns: Fix use-after-free in driver remove()

Marc Harvey (10):
      net: team: Annotate reads and writes for mixed lock accessed values
      net: team: Remove unused team_mode_op, port_enabled
      net: team: Rename port_disabled team mode op to port_tx_disabled
      selftests: net: Add tests for failover of team-aggregated ports
      selftests: net: Add test for enablement of ports with teamd
      net: team: Rename enablement functions and struct members to tx
      net: team: Track rx enablement separately from tx enablement
      net: team: Add new rx_enabled team port option
      net: team: Add new tx_enabled team port option
      selftests: net: Add tests for team driver decoupled tx and rx control

Marc Kleine-Budde (2):
      Merge patch series "can: mcp251xfd: add XSTBYEN transceiver standby control"
      Merge patch series "can: refactor USB endpoint lookups"

Marco Crivellari (4):
      wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
      wifi: iwlwifi: fw: replace use of system_unbound_wq with system_dfl_wq
      wifi: iwlwifi: mvm: replace use of system_wq with system_percpu_wq
      Octeontx2-af: add WQ_PERCPU to alloc_workqueue users

Marek Vasut (4):
      dt-bindings: net: realtek,rtl82xx: Keep property list sorted
      dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
      net: phy: realtek: Add property to enable SSC
      Bluetooth: btbcm: Add entry for BCM4343A2 UART Bluetooth

Marino Dzalto (1):
      netfilter: xt_HL: add pr_fmt and checkentry validation

Mashiro Chen (4):
      net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
      net: rose: reject truncated CLEAR_REQUEST frames in state machines
      net: hamradio: bpqether: validate frame length in bpq_rcv()
      net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl

Matt Olson (2):
      gve: Update QPL page registration logic
      gve: Enable reading max ring size from the device in DQO-QPL mode

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: recreate signal endp with same ID

Maxime Chevallier (11):
      net: ethtool: re-order local includes
      net: dsa: microchip: Don't embed struct phy_device to maintain the port state
      net: ethtool: pass genl_info to the ethnl parse_request operation
      net: stmmac: dwmac-socfpga: Move internal helpers
      net: stmmac: dwmac-socfpga: Use the socfpga_sgmii_config() helper
      net: stmmac: dwmac-socfpga: Use the correct type for interface modes
      net: stmmac: dwmac-socfpga: get the phy_mode with the dedicated helper
      net: stmmac: dwmac-sofcpga: Drop the struct device reference
      net: dsa: microchip: Drop unnecessary check in ksz9477 PCS setup
      net: dsa: microchip: drop an outdated comment about SGMII support
      net: phy: qcom: at803x: Use the correct bit to disable extended next page

MeiChia Chiu (1):
      wifi: mt76: mt7996: Add eMLSR support

Michael Lo (2):
      wifi: mt76: mt7925: Skip scan process during suspend.
      wifi: mt76: mt7921: fix 6GHz regulatory update on connection

Michael S. Tsirkin (2):
      virtio_net: sync RX buffer before reading the header
      ptr_ring: disable KCSAN warnings

Mike Marciniszyn (Meta) (5):
      net: export netif_open for self_test usage
      eth fbnic: Add register self test
      eth fbnic: Add msix self test
      eth fbnic: TLV support for use by MBX self test
      eth fbnic: Add mailbox self test

Ming Yen Hsieh (3):
      wifi: mt76: mt7925: fix incorrect length field in txpower command
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
      wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi

Miri Korenblit (39):
      wifi: nl80211: refactor nl80211_parse_chandef
      wifi: cfg80211: remove unneeded call to cfg80211_leave
      wifi: nl80211/cfg80211: support stations of non-netdev interfaces
      wifi: cfg80211: refactor wiphy_suspend
      wifi: nl80211: don't allow DFS channels for NAN
      wifi: cfg80211: make cluster id an array
      wifi: mac80211: use for_each_chanctx_user_* in one more place
      wifi: mac80211: make ieee80211_find_chanctx link-unaware
      wifi: mac80211: properly handle error in ieee80211_add_virtual_monitor
      wifi: mac80211: don't consider the sband when processing capabilities
      wifi: iwlwifi: mld: add support for sta command version 3
      wifi: iwlwifi: bump core version for BZ/SC/DR
      wifi: iwlwifi: validate the channels received in iwl_mcc_update_resp_v*
      wifi: iwlwifi: mld: use the dedicated helper to extract a link
      wifi: iwlwifi: mld: always assign a fw id to a vif
      wifi: iwlwifi: add a macro for max FW links
      wifi: iwlwifi: mld: introduce iwl_mld_vif_fw_id_valid
      wifi: mac80211: extract channel logic from link logic
      wifi: mac80211: cleanup error path of ieee80211_do_open
      wifi: cfg80211: Add an API to configure local NAN schedule
      wifi: cfg80211: make sure NAN chandefs are valid
      wifi: cfg80211: add support for NAN data interface
      wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
      wifi: nl80211: add support for NAN stations
      wifi: nl80211: define an API for configuring the NAN peer's schedule
      wifi: nl80211: allow reporting spurious NAN Data frames
      wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
      wifi: nl80211: Add a notification to notify NAN channel evacuation
      wifi: mac80211: run NAN DE code only when appropriate
      wifi: mac80211: add NAN local schedule support
      wifi: mac80211: support open and close for NAN_DATA interfaces
      wifi: mac80211: handle reconfig for NAN DATA interfaces
      wifi: mac80211: support NAN stations
      wifi: mac80211: add NAN peer schedule support
      wifi: mac80211: update NAN data path state on schedule changes
      wifi: mac80211: add support for TX over NAN_DATA interfaces
      wifi: mac80211: Accept frames on NAN DATA interfaces
      wifi: mac80211: allow block ack agreements in NAN Data
      wifi: mac80211: report and drop spurious NAN Data frames

Mohsin Bashir (6):
      net: ethtool: Track pause storm events
      net: ethtool: Update doc for tunable
      eth: fbnic: Add protection against pause storm
      eth: fbnic: Fetch TX pause storm stats
      eth: mlx5: Move pause storm errors to pause stats
      eth: fbnic: Use wake instead of start

Moshe Shemesh (2):
      net/mlx5: Rename MLX5_PF page counter type to MLX5_SELF
      net/mlx5: Add icm_mng_function_id_mode cap bit

Nagamani PV (1):
      net/iucv: Add missing kernel-doc return value descriptions

Naveen Anandhan (1):
      selftests: tc-testing: preserve list order when removing duplicates

Nicolai Buchwitz (12):
      net: microchip: lan743x: add ethtool nway_reset support
      net: cadence: macb: add ethtool nway_reset support
      net: cadence: macb: add EEE LPI statistics counters
      net: cadence: macb: implement EEE TX LPI support
      net: cadence: macb: add ethtool EEE support
      net: cadence: macb: enable EEE for Raspberry Pi RP1
      net: cadence: macb: enable EEE for Mobileye EyeQ5
      net: phy: microchip: add downshift tunable support for LAN88xx
      net: phy: microchip: enable downshift by default on LAN88xx
      net: phy: add support for disabling PHY-autonomous EEE
      net: phy: broadcom: implement .disable_autonomous_eee for BCM54xx
      net: phy: realtek: convert RTL8211F to .disable_autonomous_eee

Nicolas Escande (1):
      wifi: mac80211: handle VHT EXT NSS in ieee80211_determine_our_sta_mode()

Nidhish A N (1):
      wifi: iwlwifi: mvm: cleanup some more MLO code

Nimrod Oren (2):
      net: page_pool: scale alloc cache with PAGE_SIZE
      net/mlx5e: Add hds-thresh query support via ethtool

Nobuhiro Iwamatsu (1):
      octeon_ep: Remove unnecessary semicolons in octep_oq_drop_rx()

Nora Schiffer (2):
      dt-bindings: net: ti: k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
      net: ethernet: ti: am65-cpsw: add support for J722S SoC family

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Oliver Neukum (1):
      net: usb: cdc-ether: unify error handling in probe

Or Har-Toov (12):
      devlink: Refactor resource functions to be generic
      devlink: Add port-level resource registration infrastructure
      net/mlx5: Register SF resource on PF port representor
      netdevsim: Add devlink port resource registration
      devlink: Add dump support for device-level resources
      devlink: Include port resources in resource dump dumpit
      devlink: Add port-specific option to resource dump doit
      selftest: netdevsim: Add devlink port resource doit test
      devlink: Document port-level resources and full dump
      devlink: Add resource scope filtering to resource dump
      selftest: netdevsim: Add resource dump and scope filter test
      devlink: Document resource scope filtering

Oskar Ray-Frayssinet (1):
      net: ntb_netdev: add SPDX tag and remove boilerplate license text

P Praneesh (1):
      wifi: ath12k: Fix legacy rate mapping for monitor mode capture

Pablo Neira Ayuso (2):
      netfilter: nft_meta: add double-tagged vlan and pppoe support
      netfilter: nf_tables_offload: add nft_flow_action_entry_next() and use it

Pagadala Yesu Anjaneyulu (4):
      wifi: iwlwifi: mld: remove unused scan expire time constants
      wifi: iwlwifi: fw: Add TLV support for BIOS revision of command
      wifi: iwlwifi: mld: eliminate duplicate WIDE_ID in PPAG command handling
      wifi: iwlwifi: mld: add BIOS revision compatibility check for PPAG command

Paolo Abeni (27):
      Merge branch 'net-mlx5e-shampo-allow-high-order-pages-in-zerocopy-mode'
      Merge branch 'dpll-zl3073x-consolidate-chip-info-and-add-temperature-reporting'
      Merge branch 'net-phy-improve-stats-handling-in-mdio_bus-c'
      Merge branch 'amd-xgbe-add-support-for-p100a-platform'
      Merge tag 'nf-next-26-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'gve-optimize-and-enable-hw-gro-for-dqo'
      Merge branch 'net-ethtool-track-tx-pause-storm'
      Merge branch 'eth-fbnic-add-fbnic-self-tests'
      Merge branch 'net-hinic3-pf-initialization'
      Merge branch 'net-dsa-mv88e6xxx-add-partial-support-for-tcam-entries'
      Merge branch 'initial-support-for-pic64-hpsc-hx-ethernet-endpoint'
      Merge tag 'ovpn-net-next-20260317' of https://github.com/OpenVPN/ovpn-net-next
      Merge tag 'wireless-next-2026-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'amd-xgbe-tx-resilience-improvements-for-link-down-handling'
      Merge branch 'net-cleanup-bitmaps-printing'
      Merge branch 'net-stmmac-cleanup-stmmac_xmit'
      Merge branch 'net-dpaa2-mac-export-standard-statistics'
      Merge branch 'r8152-add-helper-functions-for-pla-usb-phy-ocp-registers'
      Merge branch 'selftests-drivers-bash-support-for-remote-traffic-generators'
      Merge branch 'net-mctp-improvements-for-null-eid-addressing'
      Merge branch 'net-mlx5e-xdp-add-support-for-multi-packet-per-page'
      mptcp: better mptcp-level RTT estimator
      mptcp: add receive queue awareness in tcp_rcv_space_adjust()
      Merge branch 'r8152-add-support-for-the-rtl8157-5gbit-usb-ethernet-chip'
      ipv6: move IFA_F_PERMANENT percpu allocation in process scope
      Merge branch 'decouple-receive-and-transmit-enablement-in-team-driver'
      Merge branch 'net-bpf-fix-null-ptr-deref-in-xdp_master_redirect-for-bonding-and-add-selftest'

Parav Pandit (1):
      mlx5: Remove redundant iseg base

Patrisious Haddad (1):
      net/mlx5: Add vhca_id_type bit to alias context

Pauli Virtanen (3):
      Bluetooth: hci_core: Rate limit the logging of invalid ISO handle
      Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER

Peter Chiu (3):
      wifi: mt76: mt7996: fix RRO EMU configuration
      wifi: mt76: mt7996: update WFSYS reset flow for MT7990 chipsets
      wifi: mt76: mt7996: fix frequency separation for station STR mode

Ping-Ke Shih (29):
      wifi: rtw89: fw: add fw_def struct to put firmware name and format version
      wifi: rtw89: fw: recognize firmware type B by AID
      wifi: rtw89: 8852b: update supported firmware format to 2
      wifi: rtw89: rfk: add hardware version to rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
      wifi: rtw89: pci: update SER parameters for suspend/resume
      wifi: rtw89: mac: remove A-die off setting for RTL8852C and RTL8922A
      wifi: rtw89: phy: limit AMPDU number for RA try rate
      wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB
      wifi: rtw88: validate RX rate to prevent out-of-bound
      wifi: rtw89: 8922d: add definition of quota, registers and efuse block
      wifi: rtw89: 8922d: add power on/off functions
      wifi: rtw89: 8922d: define efuse map and read necessary fields
      wifi: rtw89: 8922d: read and configure RF by calibration data from efuse physical map
      wifi: rtw89: 8922d: add set channel of MAC part
      wifi: rtw89: 8922d: add set channel of BB part
      wifi: rtw89: 8922d: add set channel of RF part
      wifi: rtw89: pci: clear SER ISR when initial and leaving WoWLAN for WiFi 7 chips
      wifi: rtw89: mac: add specific case to dump mac memory for RTL8922D
      wifi: rtw89: mac: disable pre-load function for RTL8922DE
      wifi: rtw89: phy: load RF parameters relying on ACV for RTL8922D
      wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power settings
      wifi: rtw89: 8922d: add set channel with pre-/post- helpers
      wifi: rtw89: 8922d: add RF calibration ops
      wifi: rtw89: 8922d: add set TX power callback
      wifi: rtw89: 8922d: configure TX/RX path assisting in BT coexistence
      wifi: rtw89: 8922d: add RF ops of init hardware and get thermal
      wifi: rtw89: 8922d: add ops related to BT coexistence mechanism
      wifi: rtw89: 8922d: add chip_info and chip_ops struct
      wifi: rtw89: 8922d: add PCI ID of RTL8922DE and RTL8922DE-VS

Po-Hao Huang (2):
      wifi: rtw89: Drop malformed AMPDU frames with abnormal PN
      wifi: rtw89: Recalculate station aggregates when AMSDU length changes for MLO links

Qingfang Deng (15):
      pppoe: remove kernel-mode relay support
      ppp: don't store tx skb in the fastpath
      ppp: simplify input error handling
      ppp: disconnect channel before nullifying pch->chan
      ppp: remove pch->chan NULL checks from tx path
      ovpn: pktid: use bitops.h API
      ppp: require callers of ppp_dev_name() to hold RCU
      l2tp: ppp: use max L2TP header size for PPP channel hdrlen
      net: add netdev_from_priv() helper
      team: use netdev_from_priv()
      ppp: update Kconfig help message
      selftests: net: add tests for PPP
      ppp: consolidate refcount decrements
      pppox: remove sk_pppox() helper
      pppox: convert pppox_sk() to use container_of()

Quan Zhou (3):
      wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
      wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work
      wifi: mt76: mt7925: fix incorrect TLV length in CLC command

Rafael J. Wysocki (2):
      ptp: vmw: Convert to a platform driver
      net: fjes: Drop fjes_acpi_driver and rework initialization

Raj Kumar Bhagat (2):
      dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424

Raju Rangoju (7):
      amd-xgbe: define macros for MAC versions and speed select values
      amd-xgbe: add support for P100a platform
      amd-xgbe: Simplify powerdown/powerup paths
      amd-xgbe: add PCI power management for S0i3 support
      amd-xgbe: add adaptive link status polling
      amd-xgbe: optimize TX shutdown on link-down
      amd-xgbe: add TX descriptor cleanup for link-down

Ralf Lici (6):
      ovpn: notify userspace on client float event
      selftests: ovpn: add notification parsing and matching
      ovpn: add support for asymmetric peer IDs
      selftests: ovpn: check asymmetric peer-id
      selftests: ovpn: add test for the FW mark feature
      ovpn: consolidate crypto allocations in one chunk

Ramya Gnanasekar (1):
      wifi: ath12k: Set up MLO after SSR

Randy Dunlap (3):
      NFC: fix header file kernel-doc warnings
      atm: atmdev: add function parameter names and description
      net: openvswitch: clean up some kernel-doc warnings

Ratheesh Kannoth (7):
      octeontx2-af: npc: cn20k: Index management
      octeontx2-af: npc: cn20k: Allocate default MCAM indexes
      octeontx2-af: npc: cn20k: Prepare for new SoC
      octeontx2-af: npc: cn20k: virtual index support
      octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
      octeontx2-af: npc: cn20k: add debugfs support
      octeontx2-af: npc: Use common structures

Remy D. Farley (5):
      doc/netlink: netlink-raw: Add max check
      doc/netlink: nftables: Add definitions
      doc/netlink: nftables: Update attribute sets
      doc/netlink: nftables: Add sub-messages
      doc/netlink: nftables: Fill out operation attributes

Rex Lu (1):
      wifi: mt76: mt7996: adjust timeout value for boot-up calibration commands

Ria Thomas (1):
      wifi: mac80211: add support for NDP ADDBA/DELBA for S1G

Roi L (1):
      qtnfmac: use alloc_netdev macro for single queue devices

Ronald Claveau (1):
      dt-bindings: net: wireless: brcm: Add compatible for bcm43752

Roopni Devanathan (2):
      wifi: ath12k: Rename hw_link_id to radio_idx in ath12k_ah_to_ar()
      wifi: ath12k: Create symlink for each radio in a wiphy

Rory Little (1):
      wifi: mt76: mt7921: Place upper limit on station AID

Rosen Penev (9):
      net: freescale: ucc_geth: call of_node_put once
      net: fs_enet: allow nvmem to override MAC address
      wifi: rt2x00: use generic nvmem_cell_get
      net: rocker: kzalloc + kcalloc to kzalloc_flex
      net: mvneta: support EPROBE_DEFER when reading MAC address
      net: xgbe: use device_get_mac_addr
      wifi: b43: kzalloc + kcalloc to kzalloc_flex
      wifi: brcmfmac: of: defer probe for MAC address
      wifi: wilc1000: use kzalloc_flex

Russell King (Oracle) (124):
      net: stmmac: qcom-ethqos: rename "por" members to "rgmii_por"
      net: stmmac: qcom-ethqos: remove register field value obfuscations
      net: stmmac: qcom-ethqos: change ethqos_configure*() to return void
      net: stmmac: qcom-ethqos: move qcom_ethqos_set_sgmii_loopback() up
      net: stmmac: qcom-ethqos: move loopback disable to .mac_finish()
      net: stmmac: pass interface mode into fix_mac_speed() method
      net: stmmac: qcom-ethqos: pass phy interface mode to configs
      net: stmmac: qcom-ethqos: use phy interface mode for inband
      net: stmmac: qcom-ethqos: move SerDes speed configuration
      net: stmmac: qcom-ethqos: convert to set_clk_tx_rate() method
      net: stmmac: fix EEE supportable interfaces
      net: stmmac: use circ_buf helpers for descriptors
      net: stmmac: fix transmit interrupt coalescing
      net: stmmac: ptp: limit n_per_out
      phy: qcom-sgmii-eth: add .set_mode() and .validate() methods
      net: stmmac: clean up formatting in stmmac_mac_finish()
      net: stmmac: remove plat_dat->port_node
      net: stmmac: remove .get_tx_owner()
      net: stmmac: remove .get_tx_ls()
      net: stmmac: remove .get_tx_len()
      net: stmmac: remove dwmac4 DMA_CHAN_INTR_DEFAULT_[TR]X*
      net: stmmac: remove dwmac410_(enable|disable)_dma_irq
      net: stmmac: remove mac->xlgmac
      net: stmmac: make extend_desc boolean
      net: stmmac: make chain_mode a boolean
      net: stmmac: make dma_cfg mixed/fixed burst boolean
      net: stmmac: move initialisation of dma_cfg->atds
      net: stmmac: simplify atds initialisation
      net: stmmac: move DMA configuration validation to driver probe
      net: stmmac: qcom-ethqos: move ethqos_set_serdes_speed()
      net: stmmac: qcom-ethqos: convert to use phy_set_mode_ext()
      phy: qcom-sgmii-eth: remove .set_speed() implementation
      phy: qcom-sgmii-eth: use PHY interface mode for SerDes settings
      phy: qcom-sgmii-eth: remove qcom_dwmac_sgmii_phy_interface()
      phy: qcom-sgmii-eth: relax order of .power_on() vs .set_mode*()
      net: stmmac: qcom-ethqos: remove phy_set_mode_ext() after phy_power_on()
      net: stmmac: mdio: convert MDC clock divisor selection to tables
      net: stmmac: mdio: use same test for MDC clock divisor lookups
      net: stmmac: mdio: simplify MDC clock divisor lookup
      net: stmmac: mdio: convert field prep to use field_prep()
      net: stmmac: use u32 for MDIO register field masks
      net: stmmac: use GENMASK_U32() for mdio bitfields
      net: stmmac: mdio_bus_data->default_an_inband is boolean
      net: stmmac: make pcs_mask and phy_mask u32
      net: stmmac: remove stmmac_dwmac4_get_mac_addr()
      net: stmmac: ptp: rearrange n_ext_ts initialisation
      net: stmmac: ptp: remove redundant priv->pps[].available
      net: stmmac: provide plat_dat->dma_cfg in stmmac_plat_dat_alloc()
      net: stmmac: convert plat_stmmacenet_data booleans to type bool
      net: stmmac: reorder structs to reduce memory consumption
      net: stmmac: use u8 for ?x_queues_to_use and number_?x_queues
      net: stmmac: use u8 for host_dma_width and similar struct members
      net: stmmac: add documentation for stmmac_dma_cfg members
      net: stmmac: add documentation for clocks
      net: phy: vitesse: add inband caps and configuration
      net: stmmac: avoid passing pci_dev
      net: stmmac: move MSI data out of struct stmmac_priv
      net: stmmac: rearrange stmmac_tx_info members to pack better
      net: stmmac: helpers for filling tx_q->tx_skbuff_dma
      net: stmmac: clean up stmmac_clear_rx_descriptors()
      net: stmmac: add helper to get hardware receive descriptor
      net: stmmac: add helper to get size of a receive descriptor
      net: stmmac: add helper to set receive tail pointer
      net: stmmac: remove rx_tail_addr
      net: stmmac: use consistent tests for receive buffer size
      net: stmmac: add helper to set receive buffer size
      net: stmmac: simplify stmmac_set_queue_rx_buf_size()
      net: stmmac: add helper to get hardware transmit descriptor
      net: stmmac: add helper to get size of a transmit descriptor
      net: stmmac: add helper to set transmit tail pointer
      net: stmmac: remove tx_tail_addr
      net: stmmac: use queue rather than ->queue_index
      net: stmmac: rename "mode" to "descriptor_mode"
      net: stmmac: more mode -> descriptor_mode renames
      net: stmmac: simplify DMA descriptor allocation/init/freeing
      net: stmmac: use more descriptive names in stmmac_xmit()
      net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()
      net: phylink: add debug for phy_config_inband()
      net: stmmac: move default_an_inband to plat_stmmacenet_data
      net: stmmac: add struct stmmac_pcs_info
      net: stmmac: add support for reading inband SGMII status
      net: stmmac: add BASE-X support to integrated PCS
      net: stmmac: use integrated PCS for BASE-X modes
      net: stmmac: move stmmac_xmit() skb head handling
      net: stmmac: move first xmit descriptor SARC and TBS config
      net: stmmac: move stmmac_xmit() first entry index code
      net: stmmac: move stmmac_xmit() initial variable init
      net: stmmac: use first_desc for TBS
      net: stmmac: elminate tbs_desc in stmmac_xmit()
      net: phylink: use phylink_expects_phy() in phylink_fwnode_phy_connect()
      net: stmmac: remove axi_kbbe, axi_mb and axi_rb members
      dt-bindings: remove unimplemented AXI snps,kbbe snps,mb and snps,rb
      net: stmmac: provide flag to disable EEE
      net: stmmac: qcom-ethqos: remove ethqos_configure()
      net: stmmac: qcom-ethqos: pass ethqos to ethqos_pcs_set_inband()
      net: stmmac: qcom-ethqos: eliminate configure_func
      net: stmmac: qcom-ethqos: move detection of invalid RGMII speed
      net: stmmac: qcom-ethqos: move RGMII_CONFIG_DDR_MODE
      net: stmmac: qcom-ethqos: move 1G vs 100M/10M RGMII settings
      net: stmmac: qcom-ethqos: move two more RGMII_IO_MACRO_CONFIG2 out
      net: stmmac: qcom-ethqos: move 100M/10M speed programming
      net: stmmac: qcom-ethqos: move RGMII_CONFIG2_RSVD_CONFIG15 out
      net: stmmac: qcom-ethqos: move RGMII_CONFIG2_RX_PROG_SWAP
      net: stmmac: qcom-ethqos: finally eliminate the switch
      net: stmmac: qcom-ethqos: simplify prg_rclk_dly programming
      net: stmmac: qcom-ethqos: move loopback decision next to reg update
      net: stmmac: qcom-ethqos: correct prg_rclk_dly comment
      net: stmmac: qcom-ethqos: move phase_shift to register update site
      net: stmmac: fix channel TSO enable on resume
      net: stmmac: fix .ndo_fix_features()
      net: stmmac: fix TSO support when some channels have TBS available
      net: stmmac: add stmmac_tso_header_size()
      net: stmmac: add TSO check for header length
      net: stmmac: add GSO MSS checks
      net: stmmac: move TSO VLAN tag insertion to core code
      net: stmmac: move check for hardware checksum supported
      net: stmmac: simplify GSO/TSO test in stmmac_xmit()
      net: stmmac: split out gso features setup
      net: stmmac: make stmmac_set_gso_features() more readable
      net: stmmac: add warning when TSO is requested but unsupported
      net: stmmac: check txpbl for TSO
      net: stmmac: move "TSO supported" message to stmmac_set_gso_features()
      net: stmmac: qcom-ethqos: set clk_csr
      net: stmmac: enable RPS and RBU interrupts

Ryder Lee (4):
      wifi: mt76: mt7615: fix use_cts_prot support
      wifi: mt76: mt7915: fix use_cts_prot support
      wifi: mt76: mt7996: add support for ERP CTS & HT protection
      wifi: mt76: mt7996: Disable Rx hdr_trans in monitor mode

Ryohei Kinugawa (1):
      docs/mlx5: Fix typo subfuction

Sabrina Dubroca (2):
      tls: don't select STREAM_PARSER
      ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit

Saeed Mahameed (2):
      net/mlx5e: Remove unused field in mlx5e_flow_steering struct
      net/mlx5e: Allow set_rx_mode on uplink representor

Sagi Maimon (1):
      ptp: ocp: Add support for Xilinx-based Adva TimeCard variant

Sai Pratyusha Magam (1):
      wifi: mac80211: Fix AAD/Nonce computation for management frames with MLO

Salil Mehta (1):
      MAINTAINERS: Remove Salil Mehta as HiSilicon HNS3/HNS Ethernet maintainer

Samuel Page (1):
      can: raw: fix ro->uniq use-after-free in raw_rcv()

Saravanakumar Duraisamy (3):
      wifi: ath12k: Add ath12k_hw_params for IPQ5424
      wifi: ath12k: add ath12k_hw_regs for IPQ5424
      wifi: ath12k: Add CE remap hardware parameters for IPQ5424

Sarika Sharma (1):
      wifi: ath12k: account TX stats only when ACK/BA status is present

Satish Kharat (8):
      net:ethernet:enic: add VIC subsystem ids
      net:ethernet:enic: map ethtool link modes by VIC type
      enic: extend resource discovery for SR-IOV admin channel
      enic: add V2 SR-IOV VF device ID
      enic: detect SR-IOV VF type from PCI capability
      enic: make enic_dev_enable/disable ref-counted
      enic: add type-aware alloc for WQ, RQ, CQ and INTR resources
      enic: detect admin channel resources for SR-IOV

Sean Chang (1):
      net: macb: use ethtool_sprintf to fill ethtool stats strings

Sean Wang (44):
      wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
      wifi: mt76: mt7925: drop puncturing handling from BSS change path
      wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
      wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync
      wifi: mt76: connac: use is_connac2() to replace is_mt7921() checks
      wifi: mt76: mt7921: use mt76_for_each_q_rx() in reset path
      wifi: mt76: mt7921: handle MT7902 irq_map quirk with mutable copy
      wifi: mt76: mt7921: add MT7902e DMA layout support
      wifi: mt76: connac: mark MT7902 as hw txp devices
      wifi: mt76: mt792x: add PSE handling barrier for the large MCU cmd
      wifi: mt76: mt792x: ensure MCU ready before ROM patch download
      wifi: mt76: mt7921: add MT7902 MCU support
      wifi: mt76: mt792x: add MT7902 WFDMA prefetch configuration
      wifi: mt76: mt7921: add MT7902 PCIe device support
      wifi: mt76: mt7921: add MT7902 SDIO device support
      wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
      wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
      wifi: mt76: mt7925: pass mlink to sta_amsdu_tlv()
      wifi: mt76: mt7925: pass WCID indices to bss_basic_tlv()
      wifi: mt76: mt7925: pass mlink and mconf to sta_mld_tlv()
      wifi: mt76: mt7925: pass mlink to mcu_sta_update()
      wifi: mt76: mt7925: resolve primary mlink via def_wcid
      wifi: mt76: mt7925: pass mlink to mac_link_sta_remove()
      wifi: mt76: mt7925: pass mlink to sta_hdr_trans_tlv()
      wifi: mt76: mt7925: validate mlink in sta_hdr_trans_tlv()
      wifi: mt76: mt7925: pass mlink to wtbl_update_hdr_trans()
      wifi: mt76: mt7925: pass mlink to set_link_key()
      wifi: mt76: mt7925: resolve link after acquiring mt76 mutex
      wifi: mt76: mt7925: pass mconf and mlink to wtbl_update_hdr_trans()
      wifi: mt76: mt7925: make WCID cleanup unconditional in sta_remove_links()
      wifi: mt76: mt7925: unwind WCID setup on link STA add failure
      wifi: mt76: mt7925: drop WCID reinit after publish
      wifi: mt76: mt7925: move WCID teardown into link_sta_remove()
      wifi: mt76: mt7925: switch link STA allocation to RCU lifetime
      wifi: mt76: mt7925: publish msta->link after successful link add
      wifi: mt76: mt7925: host-only unwind published links on add failure
      mmc: sdio: add MediaTek MT7902 SDIO device ID
      Bluetooth: btmtk: add MT7902 MCU support
      Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3594 for MT7902
      Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
      Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
      Bluetooth: btmtk: add MT7902 SDIO support

Sebastian Andrzej Siewior (1):
      net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps

Shardul Bankar (1):
      wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit

Shay Drory (7):
      net/mlx5: Add silent mode set/query and VHCA RX IFC bits
      net/mlx5: LAG, replace pf array with xarray
      net/mlx5: LAG, use xa_alloc to manage LAG device indices
      net/mlx5: E-switch, modify peer miss rule index to vhca_id
      net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
      net/mlx5: Add VHCA RX flow destination support for FW steering
      {net/RDMA}/mlx5: Add LAG demux table API and vport demux rules

Shayne Chen (9):
      wifi: ieee80211: fix definition of EHT-MCS 15 in MRU
      wifi: mt76: mt7996: extend CSA and CCA support for MLO
      wifi: mt76: mt7996: add duplicated WTBL command
      wifi: mt76: mt7996: fix iface combination for different chipsets
      wifi: mt76: mt7996: add variant for MT7992 chipsets
      wifi: mt76: mt7996: fix wrong DMAD length when using MAC TXP
      wifi: mt76: mt7996: Account active links in valid_links fields
      wifi: mt76: mt7996: Move mlink deallocation in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Add mcu APIs to enable/disable vif links.

Shin-Yi Lin (1):
      wifi: rtw89: usb: Rx aggregation for RTL8832CU/RTL8851BU

ShravyaPanchagiri (1):
      docs: octeontx2: fix typo in documentation

Shuai Zhang (2):
      Bluetooth: hci_qca: disable power control for WCN7850 when bt_en is not defined
      Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Simon Baatz (7):
      tcp: implement RFC 7323 window retraction receiver requirements
      mptcp: keep rcv_mwnd_seq in sync with subflow rcv_wnd
      tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
      selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
      selftests/net: packetdrill: improve tcp_rcv_neg_window.pkt

Simon Horman (1):
      ice: Make name member of struct ice_cgu_pin_desc const

Soichiro Ueda (1):
      selftests: af_unix: validate SO_PEEK_OFF advancement and reset

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Enable IPQ5424 WiFi device support

Sriram R (2):
      wifi: mac80211: fetch FILS discovery template by link ID
      wifi: mac80211: fetch unsolicited probe response template by link ID

StanleyYP Wang (10):
      wifi: mt76: mt7996: fix the behavior of radar detection
      wifi: mt76: mt7996: set specific BSSINFO and STAREC commands after channel switch
      wifi: mt76: mt7996: abort CCA when CSA is starting
      wifi: mt76: mt7996: offload radar threshold initialization
      wifi: mt76: add external EEPROM support for mt799x chipsets
      wifi: mt76: mt7996: apply calibration-free data from OTP
      wifi: mt76: mt7996: fix struct mt7996_mcu_uni_event
      wifi: mt76: avoid to set ACK for MCU command if wait_resp is not set
      wifi: mt76: mt7996: fix queue pause after scan due to wrong channel switch reason
      wifi: mt76: mt7996: fix issues with manually triggered radar detection

Stefan Metzmacher (1):
      Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

Stefano Radaelli (1):
      Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

Subbaraya Sundeep (1):
      octeontx2-pf: cn20k: Add TC rules support

Suman Ghosh (5):
      octeontx2-af: npc: cn20k: KPM profile changes
      octeontx2-af: npc: cn20k: Add default profile
      octeontx2-af: npc: cn20k: MKEX profile support
      octeontx2-af: npc: cn20k: Use common APIs
      octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon

Sun Jian (1):
      netfilter: use function typedefs for __rcu NAT helper hook pointers

Suraj P Kizhakkethil (2):
      wifi: mac80211: set band information only for non-MLD when probing stations using NULL frame
      wifi: mac80211: Set link ID for NULL packets sent to probe stations

Taegu Ha (1):
      ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Tamizh Chelvam Raja (3):
      wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces
      wifi: mac80211: use ap_addr for 4-address NULL frame destination
      wifi: mac80211: enable MLO support for 4-address mode interfaces

Tariq Toukan (1):
      net/mlx5: Expose MLX5_UMR_ALIGN definition

Thangaraj Samynathan (2):
      net: lan743x: fix SGMII detection on PCI1xxxx B0+ during warm reset
      net: lan743x: rename chip_rev to fpga_rev

Thorsten Blum (6):
      net: l2tp_eth: Replace deprecated strcpy with strscpy in l2tp_eth_create
      keys, dns: Use kmalloc_flex to improve dns_resolver_preparse
      ipv6: sit: Replace deprecated strcpy with strscpy
      Bluetooth: btintel_pcie: Replace snprintf("%s") with strscpy
      Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
      Bluetooth: btintel_pcie: use strscpy to copy plain strings

Théo Lebrun (3):
      net: macb: runtime detect MACB_CAPS_USRIO_DISABLED
      net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
      net: macb: drop usrio pointer on EyeQ5 config

Tiernan Hubble (1):
      net: atlantic: fix reading SFP module info on some AQC100 cards

Tim Bird (2):
      wifi: Add SPDX ids to some files in the wireless subsystem
      net: Add SPDX ids to some source files

Tomas Alvarez Vanoli (1):
      net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll

Tomasz Unger (4):
      NFC: pn544: i2c: Replace strcpy() with strscpy()
      NFC: nxp-nci: Replace strcpy() with strscpy()
      NFC: nfcmrvl: Replace strcpy() with strscpy()
      NFC: s3fwrn5: Replace strcpy() with strscpy()

Victor Nogueira (1):
      selftests/tc-testing: Adapt test's output to HFSC's iproute2 printing changes

Viken Dadhaniya (2):
      dt-bindings: can: mcp251xfd: add microchip,xstbyen property
      can: mcp251xfd: add support for XSTBYEN transceiver standby control

Ville Nummela (1):
      wifi: rsi_91x_usb: do not pause rfkill polling when stopping mac80211

Vishwanath Seshagiri (1):
      virtio_net: add page_pool support for buffer allocation

Vivek Sahu (1):
      Bluetooth: qca: Refactor code on the basis of chipset names

Vivian Wang (1):
      net: spacemit: Remove unused buff_addr fields

Vladimir Oltean (4):
      net: dsa: remove struct platform_data
      net: dsa: clean up struct dsa_chip_data
      net: dsa: remove unused platform_data definitions
      net: dsa: eliminate <linux/dsa/loop.h>

Wei Fang (6):
      net: enetc: remove stray semicolon
      net: enetc: add support for the standardized counters
      net: enetc: show RX drop counters only for assigned RX rings
      net: enetc: remove standardized counters from enetc_pm_counters
      net: enetc: add unstructured pMAC counters for ENETC v1
      net: enetc: add unstructured counters for ENETC v4

Wesley Atwell (1):
      tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()

Wojciech Slenska (1):
      dt-bindings: net: qcom,ipa: document qcm2290 compatible

Xiang Mei (1):
      bonding: remove unused bond_is_first_slave and bond_is_last_slave macros

Xin Long (2):
      sctp: fix missing encap_port propagation for GSO fragments
      sctp: disable BH before calling udp_tunnel_xmit_skb()

Yi Cong (1):
      wifi: rtl8xxxu: fix potential use of uninitialized value

Yohei Kojima (2):
      docs: ethtool: clarify the bit-by-bit bitset format description
      selftests: net: Remove unnecessary backslashes in fq_band_pktlimit.sh

Yoshihiro Shimoda (2):
      net: ethernet: ravb: Disable interrupts when closing device
      net: ethernet: ravb: Suspend and resume the transmission flow

Yue Haibing (2):
      ip6_tunnel: use generic for_each_ip_tunnel_rcu macro
      ipv6: sit: remove redundant ret = 0 assignment

Yury Norov (2):
      octeontx2-af: simplify rvu_debugfs
      net-sysfs: switch xps_queue_show() to sysfs_emit()

Yury Norov (NVIDIA) (1):
      i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()

Zac Bowling (1):
      wifi: mt76: fix list corruption in mt76_wcid_cleanup

Zeeshan Ahmad (1):
      net: core: failover: enforce mandatory ops and clean up redundant checks

Zenm Chen (3):
      wifi: rtw89: Add support for TP-Link Archer TX50U
      wifi: rtw89: Add support for Buffalo WI-U3-2400XE2
      wifi: rtw89: Add support for Elecom WDC-XE2402TU3-B

Zhengchuan Liang (2):
      netfilter: require Ethernet MAC header before using eth_hdr()
      net: caif: clear client service pointer on teardown

Zhengping Zhang (1):
      net: airoha: fix typo in function name

Zilin Guan (3):
      wifi: ath11k: fix memory leaks in beacon template setup
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()
      wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()

Ziyi Guo (1):
      wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback

Zong-Zhe Yang (14):
      wifi: rtw89: add general way to generate module firmware string
      wifi: rtw89: 8852a: move DIG tables to rtw8852a.c
      wifi: rtw89: 8852a: update supported firmware format to 1
      wifi: rtw89: 8851b: update supported firmware format to 1
      wifi: rtw89: debug: add SER SW counters to count simulation
      wifi: rtw89: ser: Wi-Fi 7 reset HALT C2H after reading it
      wifi: rtw89: ser: post-recover DMAC state to prevent LPS
      wifi: rtw89: move disabling dynamic mechanism functions to core
      wifi: rtw89: tweak settings of TX power and channel for Wi-Fi 7
      wifi: rtw89: chan: simplify link handling related to ROC
      wifi: rtw89: chan: recalc MLO DBCC mode based on current entity mode
      wifi: rtw89: replace RF mutex with wiphy lock assertion
      wifi: rtw89: debug: simulate Wi-Fi 7 SER L0/L1 without PS mode
      wifi: rtw89: fw: load TX power elements according to AID

kexinsun (2):
      rds: update outdated comment
      xfrm: update outdated comment

谢致邦 (XIE Zhibang) (1):
      net: stmmac: dwmac-rk: Fix typo in comment

 CREDITS                                            |   10 +
 Documentation/admin-guide/sysctl/net.rst           |   28 +
 .../devicetree/bindings/dpll/dpll-pin.yaml         |   13 +
 .../bindings/dpll/microchip,zl30731.yaml           |   30 +-
 .../bindings/net/can/microchip,mcp251xfd.yaml      |    8 +
 .../devicetree/bindings/net/cdns,macb.yaml         |   90 +-
 .../bindings/net/dsa/maxlinear,mxl862xx.yaml       |    1 -
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    2 -
 .../devicetree/bindings/net/ethernet-phy.yaml      |   14 +
 Documentation/devicetree/bindings/net/micrel.yaml  |    6 +-
 .../bindings/net/microchip,pic64hpsc-mdio.yaml     |   68 +
 .../devicetree/bindings/net/nfc/nxp,nci.yaml       |    1 +
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml         |  140 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |   47 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          |   12 +
 .../devicetree/bindings/net/realtek,rtl82xx.yaml   |   19 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   21 +-
 .../devicetree/bindings/net/spacemit,k3-dwmac.yaml |  102 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   19 +-
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |   11 +
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |    1 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |   14 +
 Documentation/driver-api/dpll.rst                  |   20 +
 Documentation/netlink/genetlink.yaml               |    2 +-
 Documentation/netlink/netlink-raw.yaml             |   11 +-
 Documentation/netlink/specs/devlink.yaml           |   90 +-
 Documentation/netlink/specs/dpll.yaml              |   35 +
 Documentation/netlink/specs/ethtool.yaml           |   25 +-
 Documentation/netlink/specs/netdev.yaml            |   46 +
 Documentation/netlink/specs/nftables.yaml          |  691 ++-
 Documentation/netlink/specs/ovpn.yaml              |   23 +-
 Documentation/netlink/specs/psp.yaml               |    8 +
 Documentation/netlink/specs/rt-link.yaml           |   23 +
 Documentation/networking/bridge.rst                |   22 +
 .../device_drivers/ethernet/marvell/octeontx2.rst  |    2 +-
 .../ethernet/mellanox/mlx5/kconfig.rst             |    4 +-
 .../networking/devlink/devlink-resource.rst        |   70 +
 .../networking/devlink/devlink-shared.rst          |   97 +
 Documentation/networking/devlink/index.rst         |    1 +
 Documentation/networking/dsa/dsa.rst               |    5 -
 Documentation/networking/ethtool-netlink.rst       |   23 +-
 Documentation/networking/ip-sysctl.rst             |   40 +-
 Documentation/networking/ipvs-sysctl.rst           |   37 +
 .../net_cachelines/netns_ipv4_sysctl.rst           |    2 +
 .../networking/net_cachelines/tcp_sock.rst         |    1 +
 Documentation/networking/netdevices.rst            |    6 +
 Documentation/networking/scaling.rst               |   13 +-
 Documentation/networking/smc-sysctl.rst            |   43 +-
 Documentation/networking/tls-handshake.rst         |    2 +-
 Documentation/process/maintainer-netdev.rst        |   18 +-
 MAINTAINERS                                        |   26 +-
 arch/arm/configs/omap2plus_defconfig               |    1 -
 arch/arm/configs/spitz_defconfig                   |    1 -
 arch/arm64/configs/defconfig                       |    3 +-
 arch/loongarch/configs/loongson32_defconfig        |    1 -
 arch/loongarch/configs/loongson64_defconfig        |    1 -
 arch/m68k/configs/amiga_defconfig                  |   45 +-
 arch/m68k/configs/apollo_defconfig                 |   45 +-
 arch/m68k/configs/atari_defconfig                  |   45 +-
 arch/m68k/configs/bvme6000_defconfig               |   45 +-
 arch/m68k/configs/hp300_defconfig                  |   45 +-
 arch/m68k/configs/mac_defconfig                    |   45 +-
 arch/m68k/configs/multi_defconfig                  |   45 +-
 arch/m68k/configs/mvme147_defconfig                |   45 +-
 arch/m68k/configs/mvme16x_defconfig                |   45 +-
 arch/m68k/configs/q40_defconfig                    |   45 +-
 arch/m68k/configs/sun3_defconfig                   |   45 +-
 arch/m68k/configs/sun3x_defconfig                  |   45 +-
 arch/mips/configs/bigsur_defconfig                 |    1 -
 arch/mips/configs/cavium_octeon_defconfig          |    1 -
 arch/mips/configs/decstation_64_defconfig          |    1 -
 arch/mips/configs/decstation_defconfig             |    1 -
 arch/mips/configs/decstation_r4k_defconfig         |    1 -
 arch/mips/configs/gpr_defconfig                    |    1 -
 arch/mips/configs/ip32_defconfig                   |    1 -
 arch/mips/configs/lemote2f_defconfig               |    1 -
 arch/mips/configs/loongson2k_defconfig             |    1 -
 arch/mips/configs/loongson3_defconfig              |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig        |    2 -
 arch/mips/configs/maltaaprp_defconfig              |    2 -
 arch/mips/configs/maltasmvp_defconfig              |    2 -
 arch/mips/configs/maltasmvp_eva_defconfig          |    2 -
 arch/mips/configs/maltaup_defconfig                |    2 -
 arch/mips/configs/mtx1_defconfig                   |    2 -
 arch/mips/configs/rm200_defconfig                  |    1 -
 arch/mips/configs/sb1250_swarm_defconfig           |    1 -
 arch/parisc/configs/generic-32bit_defconfig        |    2 -
 arch/parisc/configs/generic-64bit_defconfig        |    2 -
 arch/powerpc/configs/44x/akebono_defconfig         |    1 -
 arch/powerpc/configs/g5_defconfig                  |    3 -
 arch/powerpc/configs/linkstation_defconfig         |    1 -
 arch/powerpc/configs/mvme5100_defconfig            |    1 -
 arch/powerpc/configs/powernv_defconfig             |    3 -
 arch/powerpc/configs/ppc64_defconfig               |    3 -
 arch/powerpc/configs/ppc64e_defconfig              |    3 -
 arch/powerpc/configs/ppc6xx_defconfig              |    2 -
 arch/powerpc/configs/ps3_defconfig                 |    1 -
 arch/powerpc/configs/skiroot_defconfig             |    2 -
 arch/s390/configs/debug_defconfig                  |    2 -
 arch/s390/configs/defconfig                        |    2 -
 arch/sh/configs/sh2007_defconfig                   |    1 -
 arch/sh/configs/titan_defconfig                    |    1 -
 arch/sh/configs/ul2_defconfig                      |    1 -
 arch/sparc/configs/sparc32_defconfig               |    1 -
 arch/sparc/configs/sparc64_defconfig               |    1 -
 crypto/Kconfig                                     |   12 -
 crypto/Makefile                                    |    1 -
 crypto/michael_mic.c                               |  176 -
 crypto/tcrypt.c                                    |    4 -
 crypto/testmgr.c                                   |    6 -
 crypto/testmgr.h                                   |   50 -
 drivers/base/regmap/Kconfig                        |    2 +-
 drivers/bluetooth/btbcm.c                          |   11 +-
 drivers/bluetooth/btintel.c                        |  109 +-
 drivers/bluetooth/btintel.h                        |   20 +-
 drivers/bluetooth/btintel_pcie.c                   |  122 +-
 drivers/bluetooth/btintel_pcie.h                   |    3 -
 drivers/bluetooth/btmtk.c                          |  115 +-
 drivers/bluetooth/btmtk.h                          |    9 +-
 drivers/bluetooth/btmtksdio.c                      |   44 +-
 drivers/bluetooth/btqca.c                          |   37 +-
 drivers/bluetooth/btusb.c                          |   84 +-
 drivers/bluetooth/hci_ldisc.c                      |    3 +
 drivers/bluetooth/hci_ll.c                         |   10 +
 drivers/bluetooth/hci_qca.c                        |   84 +-
 drivers/clk/qcom/Kconfig                           |    2 +-
 drivers/dibs/dibs_main.c                           |   14 +-
 drivers/dpll/dpll_core.c                           |    5 +-
 drivers/dpll/dpll_netlink.c                        |   90 +
 drivers/dpll/dpll_nl.c                             |    5 +-
 drivers/dpll/zl3073x/Makefile                      |    4 +-
 drivers/dpll/zl3073x/chan.c                        |  165 +
 drivers/dpll/zl3073x/chan.h                        |  174 +
 drivers/dpll/zl3073x/core.c                        |  243 +-
 drivers/dpll/zl3073x/core.h                        |   71 +-
 drivers/dpll/zl3073x/dpll.c                        |  911 ++--
 drivers/dpll/zl3073x/dpll.h                        |    8 +-
 drivers/dpll/zl3073x/flash.c                       |    3 +-
 drivers/dpll/zl3073x/i2c.c                         |   37 +-
 drivers/dpll/zl3073x/out.c                         |   27 +-
 drivers/dpll/zl3073x/out.h                         |   43 +-
 drivers/dpll/zl3073x/ref.c                         |   58 +-
 drivers/dpll/zl3073x/ref.h                         |   93 +-
 drivers/dpll/zl3073x/regs.h                        |   16 +
 drivers/dpll/zl3073x/spi.c                         |   37 +-
 drivers/dpll/zl3073x/synth.h                       |   16 +-
 drivers/gpio/TODO                                  |   28 -
 drivers/gpio/gpiolib-of.c                          |   31 +-
 drivers/infiniband/Kconfig                         |    1 -
 drivers/infiniband/core/addr.c                     |    3 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |   24 +-
 drivers/infiniband/hw/mlx5/main.c                  |   23 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |    1 -
 drivers/infiniband/hw/mlx5/mr.c                    |    1 -
 drivers/infiniband/hw/ocrdma/Kconfig               |    2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    6 +-
 drivers/infiniband/ulp/ipoib/Kconfig               |    2 +-
 drivers/net/Kconfig                                |   10 +-
 drivers/net/bonding/bond_main.c                    |   10 +-
 drivers/net/bonding/bond_netlink.c                 |    9 +
 drivers/net/bonding/bond_procfs.c                  |   11 +-
 drivers/net/bonding/bonding_priv.h                 |   22 -
 drivers/net/can/ctucanfd/ctucanfd_pci.c            |    8 -
 drivers/net/can/rcar/rcar_can.c                    |    3 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   37 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |    1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |   25 +-
 drivers/net/can/usb/ucan.c                         |   42 +-
 drivers/net/dsa/dsa_loop.c                         |   35 +-
 drivers/net/dsa/microchip/ksz9477.c                |   68 +-
 drivers/net/dsa/microchip/ksz_common.c             |    2 +-
 drivers/net/dsa/microchip/ksz_common.h             |    4 +-
 drivers/net/dsa/mv88e6xxx/Makefile                 |    2 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   35 +
 drivers/net/dsa/mv88e6xxx/chip.h                   |   52 +
 drivers/net/dsa/mv88e6xxx/port.c                   |   28 +-
 drivers/net/dsa/mv88e6xxx/port.h                   |    7 +-
 drivers/net/dsa/mv88e6xxx/tcam.c                   |  338 ++
 drivers/net/dsa/mv88e6xxx/tcam.h                   |   41 +
 drivers/net/dsa/mv88e6xxx/tcflower.c               |  167 +
 drivers/net/dsa/mv88e6xxx/tcflower.h               |   14 +
 drivers/net/dsa/mxl862xx/Kconfig                   |    1 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h            |  696 ++-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h            |   35 +-
 drivers/net/dsa/mxl862xx/mxl862xx-host.c           |  371 +-
 drivers/net/dsa/mxl862xx/mxl862xx-host.h           |    2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c                | 1909 ++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx.h                |  272 +-
 drivers/net/dsa/qca/qca8k.h                        |    2 +-
 drivers/net/dsa/yt921x.c                           |   13 -
 drivers/net/ethernet/Kconfig                       |    1 -
 drivers/net/ethernet/Makefile                      |    1 -
 drivers/net/ethernet/airoha/airoha_eth.c           |  342 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |    7 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   41 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   12 +-
 drivers/net/ethernet/alteon/Kconfig                |   47 -
 drivers/net/ethernet/alteon/Makefile               |    6 -
 drivers/net/ethernet/alteon/acenic.c               | 3178 --------------
 drivers/net/ethernet/alteon/acenic.h               |  791 ----
 drivers/net/ethernet/amd/declance.c                |    4 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |    8 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  127 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  114 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   18 +
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   91 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |   22 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |   14 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   34 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   55 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |    3 +
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h        |    7 +
 .../aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c   |   80 +
 drivers/net/ethernet/broadcom/Kconfig              |    3 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |    8 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  125 +-
 .../net/ethernet/broadcom/asp2/bcmasp_intf_defs.h  |    4 +
 drivers/net/ethernet/broadcom/bnge/Makefile        |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h          |   10 +
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c     |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c  |  732 ++++
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |  384 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h |    8 +
 drivers/net/ethernet/broadcom/bnge/bnge_link.c     | 1132 +++++
 drivers/net/ethernet/broadcom/bnge/bnge_link.h     |  173 +
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |  676 ++-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |   94 +-
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c     |   35 +-
 drivers/net/ethernet/broadcom/bnxt/Makefile        |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  255 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   59 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   74 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c      |  240 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h      |   46 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   57 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |   10 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   30 +-
 drivers/net/ethernet/cadence/macb.h                |   35 +
 drivers/net/ethernet/cadence/macb_main.c           |  740 ++--
 drivers/net/ethernet/chelsio/Kconfig               |    2 +-
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    2 +-
 .../chelsio/inline_crypto/chtls/chtls_io.c         |    8 +-
 drivers/net/ethernet/cisco/enic/enic.h             |   57 +
 drivers/net/ethernet/cisco/enic/enic_dev.c         |   17 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |  155 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   59 +-
 drivers/net/ethernet/cisco/enic/enic_res.c         |   12 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.c          |   14 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h          |    3 +
 drivers/net/ethernet/cisco/enic/vnic_dev.c         |   10 +
 drivers/net/ethernet/cisco/enic/vnic_intr.c        |   12 +-
 drivers/net/ethernet/cisco/enic/vnic_intr.h        |    2 +
 drivers/net/ethernet/cisco/enic/vnic_resource.h    |    4 +
 drivers/net/ethernet/cisco/enic/vnic_rq.c          |   14 +-
 drivers/net/ethernet/cisco/enic/vnic_rq.h          |    3 +
 drivers/net/ethernet/cisco/enic/vnic_wq.c          |   14 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.h          |    3 +
 drivers/net/ethernet/freescale/Makefile            |    3 +-
 drivers/net/ethernet/freescale/dpaa2/Kconfig       |    4 +
 drivers/net/ethernet/freescale/dpaa2/Makefile      |    9 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |   61 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c   |  425 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h   |   27 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c         |   48 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac-cmd.h   |   11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c       |   31 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h       |   94 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |    2 +
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  192 +
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  427 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c        |    2 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    4 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    3 +-
 drivers/net/ethernet/google/gve/gve.h              |   18 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   30 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |    2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   56 +-
 drivers/net/ethernet/google/gve/gve_rx.c           |    5 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   43 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |    5 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |   37 +-
 drivers/net/ethernet/huawei/hinic3/Makefile        |    1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c   |  195 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h   |   15 +
 drivers/net/ethernet/huawei/hinic3/hinic3_common.c |    6 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_common.h |    1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h    |    2 +
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c    |   65 +
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h    |    5 +
 .../net/ethernet/huawei/hinic3/hinic3_ethtool.c    |  425 ++
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c |   47 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h |    8 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c    |   69 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.h    |    2 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_intf.h    |   12 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c  |    9 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h  |    1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c   |   23 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c    |    1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c   |    3 +
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c   |   39 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h   |    4 +
 .../ethernet/huawei/hinic3/hinic3_mgmt_interface.h |   16 +-
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c |   16 +-
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.c    |   77 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.h    |  110 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_dev.h    |    3 +
 .../net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h |    1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c    |    2 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c     |   15 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h     |    3 +
 drivers/net/ethernet/ibm/ibmveth.c                 |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   21 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |    2 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  103 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   27 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    2 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |   21 +-
 drivers/net/ethernet/marvell/mvneta.c              |    3 +
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |    2 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c    |   47 +-
 drivers/net/ethernet/marvell/octeontx2/Kconfig     |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |  273 ++
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.h  |    3 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c         |   17 +
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  | 4522 ++++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.h  |  340 ++
 .../net/ethernet/marvell/octeontx2/af/cn20k/reg.h  |   65 +
 drivers/net/ethernet/marvell/octeontx2/af/common.h |    4 -
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  172 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    2 +
 .../ethernet/marvell/octeontx2/af/npc_profile.h    |   84 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  116 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   18 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  104 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   95 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  600 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.h    |   21 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |  708 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.h |   14 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  120 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   53 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |  266 ++
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h |   14 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   35 +
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  267 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   79 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   56 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |   30 +
 drivers/net/ethernet/mediatek/mtk_ppe.h            |    1 +
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |    4 +
 .../mellanox/mlx5/core/diag/fs_tracepoint.c        |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   21 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  424 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   47 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/neigh.c |    9 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |    3 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/pool.c  |   23 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |   59 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.h |    6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |    1 -
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |   12 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  270 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  101 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   30 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   10 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   37 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   14 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  103 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    6 +
 .../net/ethernet/mellanox/mlx5/core/lag/debugfs.c  |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  704 ++-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   49 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |   20 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   15 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   28 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   40 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   21 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |    3 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |    3 +-
 .../net/ethernet/mellanox/mlx5/core/sh_devlink.c   |   61 +
 .../net/ethernet/mellanox/mlx5/core/sh_devlink.h   |   12 +
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |    1 -
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   36 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c        |  128 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   42 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  139 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  115 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   27 +
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h   |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        |  156 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |  111 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |   27 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |    7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c        |  276 ++
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h        |   27 +
 drivers/net/ethernet/microchip/fdma/Kconfig        |    4 -
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    8 +
 drivers/net/ethernet/microchip/lan743x_main.c      |   23 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    1 +
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |    9 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |   34 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  253 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   12 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   18 +
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |    2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  157 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   12 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  122 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   75 +-
 drivers/net/ethernet/netronome/Kconfig             |    1 -
 drivers/net/ethernet/netronome/nfp/flower/action.c |    2 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |    7 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    9 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |    6 +
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |   53 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |    2 +-
 drivers/net/ethernet/realtek/r8169.h               |    1 +
 drivers/net/ethernet/realtek/r8169_main.c          |    7 +
 drivers/net/ethernet/realtek/r8169_phy_config.c    |   26 +
 drivers/net/ethernet/renesas/ravb_main.c           |   10 +
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |   31 +-
 drivers/net/ethernet/sfc/ethtool.c                 |    2 +
 drivers/net/ethernet/sfc/tc_counters.c             |    2 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |    5 +-
 drivers/net/ethernet/sfc/tx.c                      |    2 +
 drivers/net/ethernet/spacemit/k1_emac.c            |    3 -
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   33 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    2 +
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   21 +-
 drivers/net/ethernet/stmicro/stmmac/descs.h        |    2 +
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   22 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   19 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   20 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    8 +-
 .../net/ethernet/stmicro/stmmac/dwmac-motorcomm.c  |    5 -
 .../net/ethernet/stmicro/stmmac/dwmac-nuvoton.c    |  136 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  380 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |   38 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   63 +-
 .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c   |  227 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   13 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |   12 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   22 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   11 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   27 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   33 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |   14 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   54 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |    2 -
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   24 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |   30 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |   38 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   13 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   25 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |   39 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   59 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 1314 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  113 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   11 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |  156 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |   14 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  107 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   21 +-
 drivers/net/ethernet/ti/Makefile                   |   30 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   12 +-
 drivers/net/ethernet/ti/am65-cpts.c                |   23 +-
 drivers/net/ethernet/ti/am65-cpts.h                |    8 +-
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |   25 +
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   24 +
 drivers/net/ethernet/ti/cpsw_new.c                 |    2 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |   39 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    2 +-
 drivers/net/ethernet/ti/cpsw_sl.c                  |   11 +
 drivers/net/ethernet/ti/davinci_cpdma.c            |   27 +
 drivers/net/ethernet/ti/davinci_emac.c             |   39 +-
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |   69 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  255 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   37 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h    |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   66 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   53 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |    9 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |   57 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   52 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |   17 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |   21 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   16 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    2 +
 drivers/net/fddi/defxx.c                           |    2 +-
 drivers/net/fddi/defza.c                           |    5 +-
 drivers/net/fjes/fjes_main.c                       |  120 +-
 drivers/net/geneve.c                               |    1 -
 drivers/net/gtp.c                                  |    2 +-
 drivers/net/hamradio/6pack.c                       |    9 +-
 drivers/net/hamradio/bpqether.c                    |    3 +
 drivers/net/hamradio/scc.c                         |    2 +
 drivers/net/ieee802154/atusb.c                     |    5 +-
 drivers/net/ipa/Makefile                           |    2 +-
 drivers/net/ipa/data/ipa_data-v5.2.c               |  452 ++
 drivers/net/ipa/gsi.c                              |    1 +
 drivers/net/ipa/gsi_reg.c                          |    1 +
 drivers/net/ipa/ipa_data.h                         |   10 +-
 drivers/net/ipa/ipa_main.c                         |   10 +-
 drivers/net/ipa/ipa_mem.c                          |   24 +-
 drivers/net/ipa/ipa_reg.c                          |    1 +
 drivers/net/ipa/ipa_sysfs.c                        |    2 +
 drivers/net/ipa/ipa_version.h                      |    2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   46 +-
 drivers/net/macsec.c                               |   71 +-
 drivers/net/macvlan.c                              |   25 +-
 drivers/net/mdio/Kconfig                           |    8 +-
 drivers/net/mdio/Makefile                          |    1 +
 drivers/net/mdio/mdio-gpio.c                       |   12 +-
 drivers/net/mdio/mdio-mvusb.c                      |   14 +-
 drivers/net/mdio/mdio-pic64hpsc.c                  |  190 +
 drivers/net/mdio/mdio-xgene.c                      |    2 +-
 drivers/net/netdevsim/Makefile                     |    2 +-
 drivers/net/netdevsim/bus.c                        |    2 +-
 drivers/net/netdevsim/dev.c                        |   23 +-
 drivers/net/netdevsim/netdev.c                     |  116 +-
 drivers/net/netdevsim/netdevsim.h                  |   15 +
 drivers/net/netdevsim/psample.c                    |    4 +-
 drivers/net/netdevsim/tc.c                         |   79 +
 drivers/net/netkit.c                               |  415 +-
 drivers/net/ntb_netdev.c                           |  542 ++-
 drivers/net/ovpn/crypto_aead.c                     |  162 +-
 drivers/net/ovpn/io.c                              |    8 +-
 drivers/net/ovpn/netlink-gen.c                     |   13 +-
 drivers/net/ovpn/netlink-gen.h                     |    6 +-
 drivers/net/ovpn/netlink.c                         |   98 +-
 drivers/net/ovpn/netlink.h                         |    2 +
 drivers/net/ovpn/peer.c                            |    9 +-
 drivers/net/ovpn/peer.h                            |    4 +-
 drivers/net/ovpn/pktid.c                           |   11 +-
 drivers/net/ovpn/pktid.h                           |    2 +-
 drivers/net/ovpn/skb.h                             |   13 +-
 drivers/net/ovpn/tcp.c                             |    2 +-
 drivers/net/ovpn/udp.c                             |    3 +-
 drivers/net/phy/Kconfig                            |    6 -
 drivers/net/phy/Makefile                           |    6 +-
 drivers/net/phy/bcm84881.c                         |  204 +-
 drivers/net/phy/broadcom.c                         |    7 +
 drivers/net/phy/mdio-private.h                     |   11 -
 drivers/net/phy/mdio_bus.c                         |  412 --
 drivers/net/phy/mdio_bus_provider.c                |  319 ++
 drivers/net/phy/mdio_device.c                      |  171 +-
 drivers/net/phy/micrel.c                           |  152 +
 drivers/net/phy/microchip.c                        |   79 +-
 drivers/net/phy/mxl-gpy.c                          |   66 +-
 drivers/net/phy/phy.c                              |   25 +-
 drivers/net/phy/phy_device.c                       |   77 +-
 drivers/net/phy/phy_package.c                      |    4 +-
 drivers/net/phy/phylib-internal.h                  |    7 +
 drivers/net/phy/phylink.c                          |   13 +-
 drivers/net/phy/qcom/at803x.c                      |    2 +-
 drivers/net/phy/realtek/Kconfig                    |    1 +
 drivers/net/phy/realtek/realtek_main.c             |  253 +-
 drivers/net/phy/sfp.c                              |    2 +
 drivers/net/phy/vitesse.c                          |   41 +
 drivers/net/ppp/Kconfig                            |   30 +-
 drivers/net/ppp/ppp_async.c                        |    2 +-
 drivers/net/ppp/ppp_generic.c                      |  279 +-
 drivers/net/ppp/ppp_synctty.c                      |    2 +-
 drivers/net/ppp/pppoe.c                            |   91 +-
 drivers/net/ppp/pppox.c                            |    3 -
 drivers/net/ppp/pptp.c                             |    6 +-
 drivers/net/pse-pd/pse_core.c                      |    2 +-
 drivers/net/team/team_core.c                       |  318 +-
 drivers/net/team/team_mode_loadbalance.c           |    8 +-
 drivers/net/team/team_mode_random.c                |    4 +-
 drivers/net/team/team_mode_roundrobin.c            |    2 +-
 drivers/net/tun.c                                  |    8 +-
 drivers/net/usb/cdc-phonet.c                       |    7 +-
 drivers/net/usb/cdc_ether.c                        |   54 +-
 drivers/net/usb/cdc_mbim.c                         |   17 +-
 drivers/net/usb/hso.c                              |   65 +-
 drivers/net/usb/ipheth.c                           |   18 +-
 drivers/net/usb/lan78xx.c                          |    9 +-
 drivers/net/usb/r8152.c                            | 2927 +++++++------
 drivers/net/virtio_net.c                           |  560 +--
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    4 +-
 drivers/net/vrf.c                                  |   82 +-
 drivers/net/vxlan/vxlan_core.c                     |   15 +-
 drivers/net/vxlan/vxlan_multicast.c                |    6 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |    3 +-
 drivers/net/wireguard/allowedips.c                 |    9 +-
 drivers/net/wireguard/device.c                     |    8 +-
 drivers/net/wireguard/selftest/allowedips.c        |    2 +-
 drivers/net/wireguard/socket.c                     |    3 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |   13 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    3 +
 drivers/net/wireless/ath/ath10k/snoc.h             |    1 +
 drivers/net/wireless/ath/ath10k/usb.c              |    8 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   26 +-
 drivers/net/wireless/ath/ath11k/Kconfig            |    1 -
 drivers/net/wireless/ath/ath11k/ahb.c              |   10 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   60 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   36 +-
 drivers/net/wireless/ath/ath11k/peer.h             |    1 -
 drivers/net/wireless/ath/ath12k/Kconfig            |    1 -
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c              |   36 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |    5 +-
 drivers/net/wireless/ath/ath12k/ce.h               |   13 +-
 drivers/net/wireless/ath/ath12k/core.c             |   27 +-
 drivers/net/wireless/ath/ath12k/core.h             |   18 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   29 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |   72 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |   26 +
 drivers/net/wireless/ath/ath12k/dp.c               |    2 -
 drivers/net/wireless/ath/ath12k/dp_htt.c           |   24 +-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |    1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   57 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    6 -
 drivers/net/wireless/ath/ath12k/hal.h              |   31 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   85 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/thermal.c          |  124 +
 drivers/net/wireless/ath/ath12k/thermal.h          |   40 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |    8 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |   76 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |   32 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |    7 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |    3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   88 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  103 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  115 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   14 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   25 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/usb.c              |   16 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |   11 -
 drivers/net/wireless/ath/ath9k/ath9k.h             |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    4 -
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   33 +-
 drivers/net/wireless/ath/wil6210/main.c            |    3 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    5 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   34 +-
 drivers/net/wireless/broadcom/b43/dma.c            |   18 +-
 drivers/net/wireless/broadcom/b43/dma.h            |    4 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |   24 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   41 +-
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |   15 +
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   17 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |    4 +-
 drivers/net/wireless/intel/ipw2x00/Kconfig         |    1 -
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |    2 +-
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  120 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    7 +-
 drivers/net/wireless/intel/iwlegacy/3945.h         |    4 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/commands.h     |    9 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  132 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   28 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    3 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  167 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   18 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   37 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   45 +
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   69 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   15 +
 drivers/net/wireless/intel/iwlwifi/fw/img.c        |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    8 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  151 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   10 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  238 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  141 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   23 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   20 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    1 -
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   22 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   15 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |    2 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |   13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   52 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |    5 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    4 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |  178 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   25 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  224 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |   50 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   31 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |   78 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h       |    3 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  157 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   46 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   18 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  132 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  291 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    5 -
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    4 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c |    6 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |   13 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |    2 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |    8 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |   72 +-
 drivers/net/wireless/marvell/libertas/if_usb.h     |    3 +
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   50 +-
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c    |    1 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   36 +-
 drivers/net/wireless/marvell/mwifiex/init.c        |    2 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   12 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |    7 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |    4 -
 drivers/net/wireless/marvell/mwl8k.c               |    4 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |   39 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   33 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |    4 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |  154 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |  230 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   47 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   15 -
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   47 +
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h   |    2 -
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   11 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   34 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   46 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   15 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   13 -
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   70 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   11 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |    3 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   16 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   70 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   22 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  394 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  194 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    7 +
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   13 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    7 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   14 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |    6 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   51 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |   36 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |  208 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |   64 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  110 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  165 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    |    5 -
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  439 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  829 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  112 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   70 +-
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    |  469 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   11 +
 drivers/net/wireless/mediatek/mt76/npu.c           |   37 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |   70 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |   34 +-
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |   15 +-
 drivers/net/wireless/mediatek/mt7601u/usb.h        |    1 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   44 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |    8 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |   38 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |    4 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |    6 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   12 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    4 -
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   54 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |   28 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    3 +-
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c  |   12 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    4 -
 drivers/net/wireless/realtek/rtw88/coex.c          |   47 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    6 +
 drivers/net/wireless/realtek/rtw88/main.h          |    6 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   34 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    5 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    5 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |    8 +
 drivers/net/wireless/realtek/rtw88/tx.c            |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   72 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  155 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  105 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   53 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |   23 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  161 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |  134 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   69 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   34 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   11 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    7 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  104 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   71 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    5 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    2 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  285 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   49 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   68 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.c    |   51 -
 .../net/wireless/realtek/rtw89/rtw8852a_table.h    |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   41 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   15 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |    7 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   18 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      | 3093 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h      |   83 +
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c  |  372 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h  |   22 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |  119 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    4 +-
 drivers/net/wireless/realtek/rtw89/usb.c           |  107 +-
 drivers/net/wireless/realtek/rtw89/usb.h           |   15 +
 drivers/net/wireless/realtek/rtw89/util.h          |   17 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    2 +
 drivers/net/wireless/realtek/rtw89/wow.h           |    7 -
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   17 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |    2 +
 drivers/net/wireless/rsi/rsi_common.h              |    1 +
 drivers/net/wireless/silabs/wfx/data_rx.c          |    8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  240 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    2 +
 drivers/net/wireless/virtual/virt_wifi.c           |   12 +-
 drivers/nfc/microread/i2c.c                        |    1 -
 drivers/nfc/nfcmrvl/fw_dnld.c                      |    2 +-
 drivers/nfc/nfcmrvl/main.c                         |   47 +-
 drivers/nfc/nfcmrvl/nfcmrvl.h                      |    4 +-
 drivers/nfc/nfcmrvl/uart.c                         |   23 +-
 drivers/nfc/nfcmrvl/usb.c                          |   22 +-
 drivers/nfc/nxp-nci/firmware.c                     |    2 +-
 drivers/nfc/pn533/usb.c                            |   38 +-
 drivers/nfc/pn544/i2c.c                            |    2 +-
 drivers/nfc/port100.c                              |   31 +-
 drivers/nfc/s3fwrn5/firmware.c                     |    2 +-
 drivers/nfc/s3fwrn5/i2c.c                          |   54 +-
 drivers/nfc/s3fwrn5/phy_common.c                   |   11 +-
 drivers/nfc/s3fwrn5/phy_common.h                   |    5 +-
 drivers/nfc/s3fwrn5/uart.c                         |   43 +-
 drivers/phy/broadcom/Kconfig                       |    4 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c          |   62 +-
 drivers/ptp/ptp_ocp.c                              |  365 +-
 drivers/ptp/ptp_vmw.c                              |   23 +-
 drivers/scsi/bnx2fc/Kconfig                        |    1 -
 drivers/scsi/bnx2i/Kconfig                         |    1 -
 drivers/scsi/cxgbi/cxgb3i/Kconfig                  |    2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig                  |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   33 +-
 drivers/vhost/vsock.c                              |   13 +
 fs/dlm/Kconfig                                     |    2 +-
 fs/gfs2/Kconfig                                    |    2 +-
 include/linux/atmdev.h                             |    6 +-
 include/linux/brcmphy.h                            |    3 +
 include/linux/dpll.h                               |   10 +
 include/linux/dsa/loop.h                           |   42 -
 include/linux/ethtool.h                            |   21 +-
 include/linux/filter.h                             |   15 +-
 include/linux/icmpv6.h                             |   29 +-
 include/linux/ieee80211-eht.h                      |    4 +-
 include/linux/ieee80211-ht.h                       |    3 +
 include/linux/ieee80211-nan.h                      |   44 +-
 include/linux/ieee80211-uhr.h                      |  275 +-
 include/linux/ieee80211.h                          |  100 +-
 include/linux/if_pppox.h                           |   13 +-
 include/linux/if_team.h                            |   66 +-
 include/linux/indirect_call_wrapper.h              |    2 +-
 include/linux/mdio-gpio.h                          |    9 -
 include/linux/mdio.h                               |    2 -
 include/linux/micrel_phy.h                         |    1 +
 include/linux/microchipphy.h                       |    5 +
 include/linux/mlx5/device.h                        |   10 +
 include/linux/mlx5/driver.h                        |    4 +-
 include/linux/mlx5/fs.h                            |   10 +-
 include/linux/mlx5/lag.h                           |   21 +
 include/linux/mlx5/mlx5_ifc.h                      |   64 +-
 include/linux/mmc/sdio_ids.h                       |    1 +
 include/linux/mroute_base.h                        |    9 +-
 include/linux/net.h                                |   26 +
 include/linux/netdevice.h                          |   29 +-
 include/linux/netfilter/nf_conntrack_amanda.h      |   15 +-
 include/linux/netfilter/nf_conntrack_ftp.h         |   17 +-
 include/linux/netfilter/nf_conntrack_irc.h         |   15 +-
 include/linux/netfilter/nf_conntrack_snmp.h        |   11 +-
 include/linux/netfilter/nf_conntrack_tftp.h        |    9 +-
 include/linux/netfilter_ipv6.h                     |  102 +-
 include/linux/of_gpio.h                            |   38 -
 include/linux/phy.h                                |   19 +-
 include/linux/platform_data/dsa.h                  |   40 -
 include/linux/platform_data/mdio-gpio.h            |   14 -
 include/linux/ppp_channel.h                        |    6 +-
 include/linux/ptr_ring.h                           |    8 +-
 include/linux/rculist_bl.h                         |   49 +-
 include/linux/skbuff.h                             |   70 +-
 include/linux/socket.h                             |    2 +-
 include/linux/stmmac.h                             |  124 +-
 include/linux/tcp.h                                |   14 +-
 include/linux/udp.h                                |   10 +-
 include/net/af_vsock.h                             |    9 +
 include/net/bluetooth/hci.h                        |   16 +-
 include/net/bonding.h                              |   13 +-
 include/net/cfg80211.h                             |  328 +-
 include/net/codel_impl.h                           |   45 +-
 include/net/devlink.h                              |   20 +-
 include/net/dropreason-core.h                      |   66 +-
 include/net/dropreason-qdisc.h                     |  114 +
 include/net/dropreason.h                           |    6 +
 include/net/dsa.h                                  |   16 +
 include/net/hotdata.h                              |    5 +-
 include/net/inet6_connection_sock.h                |    4 +-
 include/net/inet6_hashtables.h                     |    2 +
 include/net/inet_common.h                          |    3 +-
 include/net/inet_connection_sock.h                 |    3 +-
 include/net/inet_hashtables.h                      |    1 -
 include/net/ip.h                                   |   10 +-
 include/net/ip6_checksum.h                         |    2 -
 include/net/ip6_fib.h                              |   35 +-
 include/net/ip6_route.h                            |   41 +-
 include/net/ip6_tunnel.h                           |    2 +-
 include/net/ip_vs.h                                |  404 +-
 include/net/ipv6.h                                 |   20 +-
 include/net/ipv6_stubs.h                           |  102 -
 include/net/mac80211.h                             |  176 +-
 include/net/mana/gdma.h                            |   20 +-
 include/net/mana/mana.h                            |   18 +-
 include/net/mctp.h                                 |    1 +
 include/net/ndisc.h                                |   31 +-
 include/net/netdev_queues.h                        |   23 +-
 include/net/netdev_rx_queue.h                      |   27 +-
 include/net/netfilter/ipv4/nf_conntrack_ipv4.h     |    3 -
 include/net/netfilter/nf_conntrack_l4proto.h       |    7 -
 include/net/netfilter/nf_tables.h                  |   36 +-
 include/net/netfilter/nf_tables_ipv4.h             |   17 +-
 include/net/netfilter/nf_tables_ipv6.h             |   16 +-
 include/net/netfilter/nf_tables_offload.h          |   10 +
 include/net/netfilter/nft_fib.h                    |    2 -
 include/net/netfilter/nft_meta.h                   |    3 -
 include/net/netlink.h                              |   19 +
 include/net/netmem.h                               |   38 +-
 include/net/netns/ipv4.h                           |    9 +-
 include/net/netns/ipv6.h                           |    2 +-
 include/net/netns/mib.h                            |    5 -
 include/net/netns/vsock.h                          |    2 +
 include/net/page_pool/memory_provider.h            |    8 +-
 include/net/page_pool/types.h                      |   11 +-
 include/net/ping.h                                 |    5 +-
 include/net/rps-types.h                            |   24 +
 include/net/rps.h                                  |   49 +-
 include/net/sch_generic.h                          |   61 +-
 include/net/sock.h                                 |   34 +-
 include/net/switchdev.h                            |    1 +
 include/net/tc_wrapper.h                           |   47 +-
 include/net/tcp.h                                  |  120 +-
 include/net/transp_v6.h                            |    3 -
 include/net/tso.h                                  |  100 +
 include/net/udp.h                                  |   89 +-
 include/net/udp_tunnel.h                           |    3 +-
 include/net/udplite.h                              |   88 -
 include/net/xsk_buff_pool.h                        |    7 -
 include/trace/events/devlink.h                     |   36 +-
 include/trace/events/mptcp.h                       |    2 +-
 include/trace/events/qdisc.h                       |   51 +
 include/uapi/linux/devlink.h                       |   15 +
 include/uapi/linux/dpll.h                          |    5 +-
 include/uapi/linux/ethtool.h                       |    2 +-
 include/uapi/linux/ethtool_netlink_generated.h     |    3 +
 include/uapi/linux/if_link.h                       |   47 +
 include/uapi/linux/if_pppox.h                      |   14 +-
 include/uapi/linux/inet_diag.h                     |    9 +
 include/uapi/linux/mii.h                           |    3 +-
 include/uapi/linux/netdev.h                        |   11 +
 include/uapi/linux/netfilter/nf_tables.h           |    6 +-
 include/uapi/linux/nfc.h                           |    6 +-
 include/uapi/linux/nl80211.h                       |  272 +-
 include/uapi/linux/openvswitch.h                   |   76 +-
 include/uapi/linux/ovpn.h                          |    2 +
 include/uapi/linux/seg6_iptunnel.h                 |    1 +
 include/uapi/linux/udp.h                           |    2 +
 io_uring/zcrx.c                                    |   12 +-
 net/atm/pppoatm.c                                  |    2 +-
 net/bluetooth/hci_conn.c                           |    4 +-
 net/bluetooth/hci_core.c                           |    4 +-
 net/bluetooth/hci_event.c                          |   21 +-
 net/bluetooth/hci_sync.c                           |    2 +-
 net/bluetooth/l2cap_core.c                         |   15 +-
 net/bluetooth/sco.c                                |    3 +-
 net/bridge/Kconfig                                 |    1 -
 net/bridge/br_arp_nd_proxy.c                       |    3 +-
 net/bridge/br_device.c                             |    1 +
 net/bridge/br_netfilter_hooks.c                    |   12 +-
 net/bridge/br_netfilter_ipv6.c                     |    7 +-
 net/bridge/br_netlink.c                            |   24 +-
 net/bridge/br_private.h                            |   12 +
 net/bridge/br_stp_if.c                             |   19 +-
 net/bridge/br_switchdev.c                          |   15 +
 net/bridge/br_vlan.c                               |    7 +-
 net/bridge/netfilter/nft_meta_bridge.c             |   20 -
 net/bridge/netfilter/nft_reject_bridge.c           |    1 -
 net/caif/cfsrvl.c                                  |   14 +-
 net/can/bcm.c                                      |    5 +-
 net/can/isotp.c                                    |    3 +-
 net/can/j1939/socket.c                             |    3 +-
 net/can/raw.c                                      |   42 +-
 net/core/dev.c                                     |  289 +-
 net/core/dev.h                                     |   21 +-
 net/core/devmem.c                                  |    6 +-
 net/core/failover.c                                |   14 +-
 net/core/fib_notifier.c                            |    1 +
 net/core/filter.c                                  |  163 +-
 net/core/hotdata.c                                 |    1 -
 net/core/link_watch.c                              |    2 +-
 net/core/lwt_bpf.c                                 |   10 +-
 net/core/neighbour.c                               |    1 -
 net/core/net-sysfs.c                               |   87 +-
 net/core/net-sysfs.h                               |    1 +
 net/core/net_namespace.c                           |    2 +-
 net/core/netdev-genl-gen.c                         |   20 +
 net/core/netdev-genl-gen.h                         |    2 +
 net/core/netdev-genl.c                             |  269 +-
 net/core/netdev_queues.c                           |  113 +-
 net/core/netdev_rx_queue.c                         |  182 +-
 net/core/scm.c                                     |   12 +-
 net/core/skbuff.c                                  |   59 +-
 net/core/sock.c                                    |   84 +-
 net/core/sock_diag.c                               |    3 +-
 net/core/sysctl_net_core.c                         |  117 +-
 net/core/tso.c                                     |  269 ++
 net/devlink/Makefile                               |    2 +-
 net/devlink/core.c                                 |   91 +-
 net/devlink/dev.c                                  |    8 +-
 net/devlink/devl_internal.h                        |   39 +-
 net/devlink/netlink.c                              |   54 +-
 net/devlink/netlink_gen.c                          |  377 +-
 net/devlink/netlink_gen.h                          |    8 +-
 net/devlink/port.c                                 |   21 +-
 net/devlink/resource.c                             |  318 +-
 net/devlink/sh_dev.c                               |  161 +
 net/dns_resolver/dns_key.c                         |   16 +-
 net/dns_resolver/dns_query.c                       |   14 +-
 net/dns_resolver/internal.h                        |   14 +-
 net/dsa/tag_mxl862xx.c                             |    3 +
 net/dsa/tag_rtl8_4.c                               |   21 +-
 net/ethtool/bitset.c                               |    3 +-
 net/ethtool/bitset.h                               |    3 +
 net/ethtool/cabletest.c                            |    3 +-
 net/ethtool/channels.c                             |   30 +-
 net/ethtool/coalesce.c                             |   17 +-
 net/ethtool/common.c                               |  185 +-
 net/ethtool/debug.c                                |    4 +-
 net/ethtool/eee.c                                  |    4 +-
 net/ethtool/eeprom.c                               |   15 +-
 net/ethtool/features.c                             |    4 +-
 net/ethtool/fec.c                                  |    4 +-
 net/ethtool/ioctl.c                                |   31 +-
 net/ethtool/linkinfo.c                             |    2 +-
 net/ethtool/linkmodes.c                            |    4 +-
 net/ethtool/linkstate.c                            |    5 +-
 net/ethtool/module.c                               |    4 +-
 net/ethtool/mse.c                                  |    2 +-
 net/ethtool/netlink.c                              |    6 +-
 net/ethtool/netlink.h                              |    1 +
 net/ethtool/pause.c                                |    7 +-
 net/ethtool/phc_vclocks.c                          |    2 +-
 net/ethtool/phy.c                                  |    6 +-
 net/ethtool/plca.c                                 |    2 +-
 net/ethtool/privflags.c                            |    4 +-
 net/ethtool/pse-pd.c                               |    7 +-
 net/ethtool/rings.c                                |    2 +-
 net/ethtool/rss.c                                  |   30 +-
 net/ethtool/stats.c                                |    5 +-
 net/ethtool/strset.c                               |    7 +-
 net/ethtool/tsconfig.c                             |    6 +-
 net/ethtool/tsinfo.c                               |    8 +-
 net/ethtool/wol.c                                  |    4 +-
 net/hsr/hsr_device.c                               |    6 +-
 net/hsr/hsr_forward.c                              |    2 +-
 net/hsr/hsr_framereg.c                             |    4 +-
 net/hsr/hsr_main.c                                 |    2 +-
 net/hsr/hsr_main.h                                 |    2 +-
 net/hsr/hsr_slave.c                                |    6 +-
 net/ieee802154/socket.c                            |    6 +-
 net/ipv4/Kconfig                                   |    9 +-
 net/ipv4/Makefile                                  |    2 +-
 net/ipv4/af_inet.c                                 |   34 +-
 net/ipv4/bpf_tcp_ca.c                              |    5 +
 net/ipv4/devinet.c                                 |   55 +-
 net/ipv4/fib_semantics.c                           |   16 +-
 net/ipv4/fou_core.c                                |    3 +-
 net/ipv4/gre_demux.c                               |    8 +-
 net/ipv4/icmp.c                                    |   18 +-
 net/ipv4/inet_connection_sock.c                    |    4 -
 net/ipv4/inet_diag.c                               |   13 +-
 net/ipv4/inet_hashtables.c                         |   84 +-
 net/ipv4/inetpeer.c                                |    7 +-
 net/ipv4/ip_gre.c                                  |    1 +
 net/ipv4/ip_input.c                                |   39 +
 net/ipv4/ip_sockglue.c                             |    4 +-
 net/ipv4/ip_tunnel_core.c                          |    6 +-
 net/ipv4/ipmr.c                                    |  265 +-
 net/ipv4/ipmr_base.c                               |   18 +-
 net/ipv4/metrics.c                                 |    1 -
 net/ipv4/netfilter.c                               |    3 +-
 net/ipv4/netfilter/nft_dup_ipv4.c                  |    1 -
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    2 -
 net/ipv4/netfilter/nft_reject_ipv4.c               |    1 -
 net/ipv4/nexthop.c                                 |   28 +-
 net/ipv4/ping.c                                    |   28 +-
 net/ipv4/proc.c                                    |   16 -
 net/ipv4/raw.c                                     |    9 +-
 net/ipv4/route.c                                   |    4 +-
 net/ipv4/syncookies.c                              |    6 +-
 net/ipv4/sysctl_net_ipv4.c                         |    7 +
 net/ipv4/tcp.c                                     |  151 +-
 net/ipv4/tcp_bbr.c                                 |    9 +-
 net/ipv4/tcp_bpf.c                                 |   17 +-
 net/ipv4/tcp_cubic.c                               |   31 +-
 net/ipv4/tcp_dctcp.c                               |   12 +-
 net/ipv4/tcp_dctcp.h                               |    1 +
 net/ipv4/tcp_diag.c                                |    4 +-
 net/ipv4/tcp_fastopen.c                            |    2 +-
 net/ipv4/tcp_input.c                               |   79 +-
 net/ipv4/tcp_ipv4.c                                |  109 +-
 net/ipv4/tcp_minisocks.c                           |    5 +-
 net/ipv4/tcp_output.c                              |   83 +-
 net/ipv4/tcp_plb.c                                 |    1 +
 net/ipv4/tcp_timer.c                               |    1 -
 net/ipv4/tcp_vegas.c                               |   10 +-
 net/ipv4/tcp_vegas.h                               |    1 +
 net/ipv4/tcp_veno.c                                |    8 +-
 net/ipv4/tcp_yeah.c                                |    1 +
 net/ipv4/udp.c                                     |  494 +--
 net/ipv4/udp_bpf.c                                 |   18 +-
 net/ipv4/udp_diag.c                                |  128 +-
 net/ipv4/udp_impl.h                                |   28 -
 net/ipv4/udp_offload.c                             |    7 +-
 net/ipv4/udplite.c                                 |  135 -
 net/ipv6/Kconfig                                   |    6 +-
 net/ipv6/Makefile                                  |    2 +-
 net/ipv6/addrconf.c                                |   31 +-
 net/ipv6/addrconf_core.c                           |   91 -
 net/ipv6/af_inet6.c                                |  109 +-
 net/ipv6/datagram.c                                |    9 +-
 net/ipv6/fib6_notifier.c                           |    1 +
 net/ipv6/fib6_rules.c                              |    3 +
 net/ipv6/fou6.c                                    |    3 +-
 net/ipv6/icmp.c                                    |    6 -
 net/ipv6/ila/ila_common.c                          |    1 +
 net/ipv6/inet6_connection_sock.c                   |   19 +-
 net/ipv6/inet6_hashtables.c                        |   51 +-
 net/ipv6/ip6_checksum.c                            |   49 +-
 net/ipv6/ip6_fib.c                                 |   13 +-
 net/ipv6/ip6_gre.c                                 |    1 +
 net/ipv6/ip6_icmp.c                                |   46 +-
 net/ipv6/ip6_input.c                               |   40 +
 net/ipv6/ip6_offload.c                             |    4 +-
 net/ipv6/ip6_output.c                              |   29 +
 net/ipv6/ip6_tunnel.c                              |    9 +-
 net/ipv6/ip6_udp_tunnel.c                          |    3 +-
 net/ipv6/ip6mr.c                                   |    4 +-
 net/ipv6/ipv6_sockglue.c                           |   17 +-
 net/ipv6/ndisc.c                                   |    1 +
 net/ipv6/netfilter.c                               |   51 +-
 net/ipv6/netfilter/ip6t_eui64.c                    |    7 +-
 net/ipv6/netfilter/nft_dup_ipv6.c                  |    1 -
 net/ipv6/netfilter/nft_fib_ipv6.c                  |   81 +-
 net/ipv6/netfilter/nft_reject_ipv6.c               |    1 -
 net/ipv6/output_core.c                             |   23 -
 net/ipv6/ping.c                                    |    3 +-
 net/ipv6/proc.c                                    |   16 -
 net/ipv6/raw.c                                     |   11 +-
 net/ipv6/reassembly.c                              |    6 +
 net/ipv6/route.c                                   |   12 +-
 net/ipv6/seg6_iptunnel.c                           |  104 +-
 net/ipv6/sit.c                                     |   13 +-
 net/ipv6/tcp_ipv6.c                                |   75 +-
 net/ipv6/udp.c                                     |  346 +-
 net/ipv6/udp_impl.h                                |   32 -
 net/ipv6/udp_offload.c                             |    3 +-
 net/ipv6/udplite.c                                 |  139 -
 net/iucv/af_iucv.c                                 |   12 +-
 net/iucv/iucv.c                                    |    6 +
 net/l2tp/Kconfig                                   |    1 -
 net/l2tp/l2tp_eth.c                                |    5 +-
 net/l2tp/l2tp_ip.c                                 |    4 +-
 net/l2tp/l2tp_ip6.c                                |    6 +-
 net/l2tp/l2tp_ppp.c                                |   15 +-
 net/mac80211/Makefile                              |    3 +-
 net/mac80211/agg-rx.c                              |   49 +-
 net/mac80211/agg-tx.c                              |   42 +-
 net/mac80211/cfg.c                                 |  366 +-
 net/mac80211/chan.c                                |  421 +-
 net/mac80211/debugfs.c                             |    1 +
 net/mac80211/driver-ops.h                          |   21 +
 net/mac80211/eht.c                                 |   21 +-
 net/mac80211/he.c                                  |   40 +-
 net/mac80211/ht.c                                  |   62 +-
 net/mac80211/ibss.c                                |   24 +-
 net/mac80211/ieee80211_i.h                         |   72 +-
 net/mac80211/iface.c                               |  156 +-
 net/mac80211/link.c                                |   45 +-
 net/mac80211/main.c                                |   32 +-
 net/mac80211/mesh.c                                |   14 +-
 net/mac80211/mesh_hwmp.c                           |   20 +-
 net/mac80211/mesh_plink.c                          |   26 +-
 net/mac80211/mesh_sync.c                           |    2 +-
 net/mac80211/michael.h                             |   22 -
 net/mac80211/mlme.c                                |  220 +-
 net/mac80211/nan.c                                 |  710 +++
 net/mac80211/rc80211_minstrel_ht.c                 |   15 +-
 net/mac80211/rx.c                                  |  200 +-
 net/mac80211/s1g.c                                 |   36 +-
 net/mac80211/scan.c                                |    2 +-
 net/mac80211/spectmgmt.c                           |   31 +-
 net/mac80211/sta_info.c                            |   33 +-
 net/mac80211/sta_info.h                            |    6 +-
 net/mac80211/tdls.c                                |   29 +-
 net/mac80211/trace.h                               |  130 +-
 net/mac80211/tx.c                                  |  129 +-
 net/mac80211/util.c                                |  152 +-
 net/mac80211/vht.c                                 |   57 +-
 net/mac80211/wpa.c                                 |   56 +-
 net/mctp/route.c                                   |  112 +-
 net/mctp/test/route-test.c                         |  184 +-
 net/mctp/test/utils.c                              |   27 +
 net/mctp/test/utils.h                              |    1 +
 net/mpls/af_mpls.c                                 |    6 +-
 net/mptcp/options.c                                |    6 +-
 net/mptcp/protocol.c                               |  116 +-
 net/mptcp/protocol.h                               |   40 +-
 net/mptcp/subflow.c                                |    5 +-
 net/netfilter/Kconfig                              |   19 -
 net/netfilter/core.c                               |    6 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c          |    5 +-
 net/netfilter/ipset/ip_set_core.c                  |    2 +-
 net/netfilter/ipset/ip_set_hash_ipmac.c            |    9 +-
 net/netfilter/ipset/ip_set_hash_mac.c              |    5 +-
 net/netfilter/ipvs/ip_vs_conn.c                    | 1055 +++--
 net/netfilter/ipvs/ip_vs_core.c                    |  181 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     | 1228 ++++--
 net/netfilter/ipvs/ip_vs_est.c                     |   18 +-
 net/netfilter/ipvs/ip_vs_pe_sip.c                  |    4 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   23 +
 net/netfilter/ipvs/ip_vs_xmit.c                    |   12 +-
 net/netfilter/nf_conntrack_amanda.c                |   10 +-
 net/netfilter/nf_conntrack_core.c                  |    8 -
 net/netfilter/nf_conntrack_ftp.c                   |   10 +-
 net/netfilter/nf_conntrack_h323_asn1.c             |   45 +-
 net/netfilter/nf_conntrack_irc.c                   |   10 +-
 net/netfilter/nf_conntrack_netlink.c               |    4 +-
 net/netfilter/nf_conntrack_proto.c                 |    3 -
 net/netfilter/nf_conntrack_proto_udp.c             |  108 -
 net/netfilter/nf_conntrack_sip.c                   |    3 +-
 net/netfilter/nf_conntrack_snmp.c                  |    7 +-
 net/netfilter/nf_conntrack_standalone.c            |    2 -
 net/netfilter/nf_conntrack_tftp.c                  |    7 +-
 net/netfilter/nf_dup_netdev.c                      |    5 +-
 net/netfilter/nf_flow_table_offload.c              |    1 +
 net/netfilter/nf_log_syslog.c                      |   24 +-
 net/netfilter/nf_nat_core.c                        |    6 -
 net/netfilter/nf_nat_masquerade.c                  |   21 +-
 net/netfilter/nf_nat_proto.c                       |   20 -
 net/netfilter/nf_queue.c                           |    1 +
 net/netfilter/nf_tables_api.c                      |   98 +-
 net/netfilter/nf_tables_core.c                     |    2 +-
 net/netfilter/nfnetlink.c                          |    4 +-
 net/netfilter/nfnetlink_acct.c                     |    2 +-
 net/netfilter/nfnetlink_cthelper.c                 |    2 +-
 net/netfilter/nfnetlink_cttimeout.c                |    1 -
 net/netfilter/nfnetlink_hook.c                     |    2 +-
 net/netfilter/nfnetlink_log.c                      |   42 +-
 net/netfilter/nfnetlink_osf.c                      |    2 +-
 net/netfilter/nfnetlink_queue.c                    |   73 +-
 net/netfilter/nft_bitwise.c                        |  110 +-
 net/netfilter/nft_byteorder.c                      |   15 +-
 net/netfilter/nft_chain_filter.c                   |    1 +
 net/netfilter/nft_cmp.c                            |    5 +-
 net/netfilter/nft_compat.c                         |   12 +-
 net/netfilter/nft_connlimit.c                      |    3 +-
 net/netfilter/nft_counter.c                        |    1 -
 net/netfilter/nft_ct.c                             |   53 +-
 net/netfilter/nft_dup_netdev.c                     |    1 -
 net/netfilter/nft_dynset.c                         |    4 +-
 net/netfilter/nft_exthdr.c                         |   43 +-
 net/netfilter/nft_fib.c                            |   44 +-
 net/netfilter/nft_fib_inet.c                       |    1 -
 net/netfilter/nft_fib_netdev.c                     |    1 -
 net/netfilter/nft_flow_offload.c                   |    1 -
 net/netfilter/nft_fwd_netdev.c                     |   12 +-
 net/netfilter/nft_hash.c                           |   40 +-
 net/netfilter/nft_immediate.c                      |   18 +-
 net/netfilter/nft_inner.c                          |    2 +-
 net/netfilter/nft_last.c                           |    1 -
 net/netfilter/nft_limit.c                          |    4 +-
 net/netfilter/nft_log.c                            |    3 +-
 net/netfilter/nft_lookup.c                         |   16 +-
 net/netfilter/nft_masq.c                           |    3 -
 net/netfilter/nft_meta.c                           |  126 +-
 net/netfilter/nft_nat.c                            |    2 -
 net/netfilter/nft_numgen.c                         |   24 +-
 net/netfilter/nft_objref.c                         |    4 +-
 net/netfilter/nft_osf.c                            |   29 +-
 net/netfilter/nft_payload.c                        |   55 +-
 net/netfilter/nft_queue.c                          |    4 +-
 net/netfilter/nft_quota.c                          |    3 +-
 net/netfilter/nft_range.c                          |    3 +-
 net/netfilter/nft_redir.c                          |    3 -
 net/netfilter/nft_reject_inet.c                    |    1 -
 net/netfilter/nft_reject_netdev.c                  |    1 -
 net/netfilter/nft_rt.c                             |    3 +-
 net/netfilter/nft_set_pipapo.c                     |    4 +-
 net/netfilter/nft_set_pipapo.h                     |    3 -
 net/netfilter/nft_set_pipapo_avx2.c                |   32 +-
 net/netfilter/nft_set_rbtree.c                     |   23 +-
 net/netfilter/nft_socket.c                         |   28 +-
 net/netfilter/nft_synproxy.c                       |    5 +-
 net/netfilter/nft_tproxy.c                         |    1 -
 net/netfilter/nft_tunnel.c                         |   32 +-
 net/netfilter/nft_xfrm.c                           |   33 +-
 net/netfilter/utils.c                              |    1 -
 net/netfilter/x_tables.c                           |   12 +-
 net/netfilter/xt_connbytes.c                       |    3 +-
 net/netfilter/xt_connlimit.c                       |    3 +-
 net/netfilter/xt_dccp.c                            |    3 +
 net/netfilter/xt_hl.c                              |   27 +
 net/netfilter/xt_mac.c                             |    4 +-
 net/netfilter/xt_owner.c                           |   28 +-
 net/netfilter/xt_physdev.c                         |   22 +
 net/netfilter/xt_socket.c                          |   23 +-
 net/netfilter/xt_time.c                            |    3 +-
 net/netlink/af_netlink.c                           |    4 +-
 net/netlink/genetlink.c                            |   20 +-
 net/netlink/policy.c                               |    4 +-
 net/nfc/digital_technology.c                       |    6 +
 net/nfc/llcp_core.c                                |    2 +
 net/openvswitch/actions.c                          |    3 +-
 net/openvswitch/flow_table.c                       |    2 +-
 net/packet/af_packet.c                             |   15 +-
 net/phonet/datagram.c                              |    4 +-
 net/phonet/pep.c                                   |    2 +-
 net/psp/psp_main.c                                 |    2 +-
 net/psp/psp_sock.c                                 |    1 -
 net/qrtr/af_qrtr.c                                 |    4 +-
 net/qrtr/ns.c                                      |   79 +-
 net/rds/af_rds.c                                   |   10 +-
 net/rds/ib.c                                       |   24 +-
 net/rds/ib.h                                       |    1 +
 net/rds/ib_rdma.c                                  |    2 +-
 net/rds/send.c                                     |    2 +-
 net/rose/rose_in.c                                 |   10 +-
 net/rxrpc/Kconfig                                  |    2 +-
 net/rxrpc/output.c                                 |    2 -
 net/sched/act_ct.c                                 |    8 +-
 net/sched/cls_flower.c                             |   12 +-
 net/sched/cls_fw.c                                 |    6 +-
 net/sched/cls_u32.c                                |    5 +-
 net/sched/sch_api.c                                |    5 +-
 net/sched/sch_cake.c                               |   26 +-
 net/sched/sch_codel.c                              |   27 +-
 net/sched/sch_dualpi2.c                            |   18 +-
 net/sched/sch_fq.c                                 |   10 +-
 net/sched/sch_fq_codel.c                           |    4 +-
 net/sched/sch_fq_pie.c                             |    4 +-
 net/sched/sch_frag.c                               |    4 +-
 net/sched/sch_generic.c                            |   51 +-
 net/sched/sch_gred.c                               |    4 +-
 net/sched/sch_htb.c                                |    4 +-
 net/sched/sch_mq.c                                 |    2 +-
 net/sched/sch_mqprio.c                             |    2 +-
 net/sched/sch_pie.c                                |    4 +-
 net/sched/sch_red.c                                |    4 +-
 net/sched/sch_sfb.c                                |    4 +-
 net/sched/sch_sfq.c                                |    8 +-
 net/sched/sch_taprio.c                             |    2 +-
 net/sctp/Kconfig                                   |    1 -
 net/sctp/inqueue.c                                 |    1 +
 net/sctp/ipv6.c                                    |    2 +
 net/sctp/protocol.c                                |    2 +
 net/sctp/sm_make_chunk.c                           |    4 +-
 net/sctp/socket.c                                  |   12 +-
 net/socket.c                                       |  105 +-
 net/strparser/strparser.c                          |    8 +
 net/switchdev/switchdev.c                          |    2 +-
 net/tipc/Kconfig                                   |    1 -
 net/tipc/node.c                                    |    2 +-
 net/tipc/udp_media.c                               |    9 +-
 net/tls/Kconfig                                    |    1 -
 net/tls/tls.h                                      |    2 +-
 net/tls/tls_device_fallback.c                      |    3 -
 net/tls/tls_sw.c                                   |    3 +-
 net/unix/af_unix.c                                 |    4 +-
 net/unix/unix_bpf.c                                |    2 +-
 net/vmw_vsock/af_vsock.c                           |   60 +-
 net/vmw_vsock/hyperv_transport.c                   |    2 +-
 net/vmw_vsock/virtio_transport.c                   |    7 +
 net/vmw_vsock/virtio_transport_common.c            |    2 -
 net/vmw_vsock/vsock_bpf.c                          |    2 +-
 net/wireless/Makefile                              |    2 +-
 net/wireless/chan.c                                |  145 +-
 net/wireless/core.c                                |  131 +-
 net/wireless/core.h                                |   14 +
 net/wireless/ibss.c                                |    4 +-
 net/{mac80211/michael.c => wireless/michael-mic.c} |    6 +-
 net/wireless/mlme.c                                |   64 +-
 net/wireless/nl80211.c                             | 1215 +++++-
 net/wireless/nl80211.h                             |    5 +-
 net/wireless/of.c                                  |   13 +-
 net/wireless/pmsr.c                                |    5 +-
 net/wireless/radiotap.c                            |   10 +-
 net/wireless/rdev-ops.h                            |   94 +-
 net/wireless/reg.c                                 |   40 +-
 net/wireless/reg.h                                 |   13 +-
 net/wireless/sme.c                                 |    4 +-
 net/wireless/sysfs.c                               |   36 +-
 net/wireless/trace.c                               |    1 +
 net/wireless/trace.h                               |  290 +-
 net/wireless/util.c                                |   32 +-
 net/wireless/wext-compat.c                         |   12 +-
 net/wireless/wext-core.c                           |    3 +-
 net/wireless/wext-priv.c                           |    3 +-
 net/wireless/wext-proc.c                           |    3 +-
 net/xdp/xsk.c                                      |   90 +-
 net/xdp/xsk.h                                      |    7 -
 net/xfrm/espintcp.c                                |    7 +-
 net/xfrm/xfrm_algo.c                               |   20 -
 net/xfrm/xfrm_nat_keepalive.c                      |    4 +-
 net/xfrm/xfrm_output.c                             |    3 +-
 net/xfrm/xfrm_policy.c                             |    2 +-
 security/smack/smack_lsm.c                         |    4 +-
 tools/include/uapi/linux/netdev.h                  |   11 +
 tools/net/ynl/Makefile                             |    4 +-
 tools/net/ynl/pyynl/cli.py                         |   14 +-
 tools/net/ynl/pyynl/lib/__init__.py                |    5 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |  289 +-
 tools/net/ynl/samples/Makefile                     |   36 -
 tools/net/ynl/samples/devlink.c                    |   61 -
 tools/net/ynl/samples/ethtool.c                    |   65 -
 tools/net/ynl/samples/netdev.c                     |  128 -
 tools/net/ynl/samples/ovs.c                        |   60 -
 tools/net/ynl/samples/rt-addr.c                    |   80 -
 tools/net/ynl/samples/rt-link.c                    |  184 -
 tools/net/ynl/samples/rt-route.c                   |   80 -
 tools/net/ynl/samples/tc-filter-add.c              |  335 --
 tools/net/ynl/samples/tc.c                         |   80 -
 tools/net/ynl/{samples => tests}/.gitignore        |    4 +-
 tools/net/ynl/tests/Makefile                       |   97 +-
 tools/net/ynl/tests/config                         |    8 +
 tools/net/ynl/tests/devlink.c                      |  101 +
 tools/net/ynl/tests/devlink.sh                     |    5 +
 tools/net/ynl/tests/ethtool.c                      |   92 +
 tools/net/ynl/{pyynl => tests}/ethtool.py          |   79 +-
 tools/net/ynl/tests/ethtool.sh                     |    5 +
 tools/net/ynl/tests/netdev.c                       |  231 +
 tools/net/ynl/tests/ovs.c                          |  108 +
 tools/net/ynl/tests/rt-addr.c                      |  111 +
 tools/net/ynl/tests/rt-addr.sh                     |    5 +
 tools/net/ynl/tests/rt-link.c                      |  206 +
 tools/net/ynl/tests/rt-route.c                     |  113 +
 tools/net/ynl/tests/rt-route.sh                    |    5 +
 tools/net/ynl/tests/tc.c                           |  409 ++
 tools/net/ynl/tests/test_ynl_ethtool.sh            |    2 +-
 tools/net/ynl/tests/wireguard.c                    |  106 +
 tools/net/ynl/tests/ynl_nsim_lib.sh                |   35 +
 tools/testing/selftests/Makefile                   |    1 +
 .../selftests/bpf/prog_tests/sock_ops_get_sk.c     |   76 +
 .../selftests/bpf/prog_tests/test_dst_clear.c      |   55 +
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |   96 +-
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c   |    8 +-
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |   29 +-
 .../testing/selftests/bpf/progs/sock_ops_get_sk.c  |  117 +
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c   |   16 +-
 tools/testing/selftests/bpf/progs/test_dst_clear.c |   57 +
 tools/testing/selftests/drivers/net/.gitignore     |    1 -
 tools/testing/selftests/drivers/net/Makefile       |    2 +-
 tools/testing/selftests/drivers/net/README.rst     |  165 +-
 .../testing/selftests/drivers/net/bonding/Makefile |    1 +
 .../net/bonding/bond_stacked_header_parse.sh       |   72 +
 tools/testing/selftests/drivers/net/bonding/config |    1 +
 tools/testing/selftests/drivers/net/config         |    2 +
 tools/testing/selftests/drivers/net/gro.py         |  210 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |    7 +
 tools/testing/selftests/drivers/net/hw/config      |    5 +
 .../selftests/drivers/net/hw/ethtool_rmon.sh       |   82 +-
 .../selftests/drivers/net/hw/ethtool_std_stats.sh  |  206 +
 tools/testing/selftests/drivers/net/hw/gro_hw.py   |  294 ++
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   58 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |   18 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c      |   49 +
 tools/testing/selftests/drivers/net/hw/nk_netns.py |   29 +
 .../testing/selftests/drivers/net/hw/nk_qlease.py  |  265 ++
 tools/testing/selftests/drivers/net/hw/ntuple.py   |  162 +
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   49 +-
 tools/testing/selftests/drivers/net/hw/rss_drv.py  |  233 +-
 tools/testing/selftests/drivers/net/hw/tso.py      |    7 +-
 tools/testing/selftests/drivers/net/hw/uso.py      |  103 +
 .../selftests/drivers/net/hw/xdp_metadata.py       |  146 +
 .../selftests/drivers/net/lib/py/__init__.py       |   17 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |  220 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |    6 +-
 tools/testing/selftests/drivers/net/macsec.py      |  343 ++
 .../drivers/net/netconsole/netcons_basic.sh        |    6 +-
 .../selftests/drivers/net/netdevsim/Makefile       |    1 -
 .../selftests/drivers/net/netdevsim/devlink.sh     |   79 +-
 .../drivers/net/netdevsim/macsec-offload.sh        |  117 -
 tools/testing/selftests/drivers/net/team/Makefile  |    4 +
 tools/testing/selftests/drivers/net/team/config    |    4 +
 .../drivers/net/team/decoupled_enablement.sh       |  249 ++
 .../testing/selftests/drivers/net/team/options.sh  |   99 +-
 tools/testing/selftests/drivers/net/team/settings  |    1 +
 .../testing/selftests/drivers/net/team/team_lib.sh |  174 +
 .../drivers/net/team/teamd_activebackup.sh         |  246 ++
 .../drivers/net/team/transmit_failover.sh          |  158 +
 tools/testing/selftests/drivers/net/xdp.py         |  131 +-
 tools/testing/selftests/net/Makefile               |    6 +
 tools/testing/selftests/net/af_unix/so_peek_off.c  |   46 +
 tools/testing/selftests/net/bridge_stp_mode.sh     |  288 ++
 tools/testing/selftests/net/config                 |    2 +
 tools/testing/selftests/net/fib_tests.sh           |   19 +-
 tools/testing/selftests/net/forwarding/.gitignore  |    1 +
 tools/testing/selftests/net/forwarding/Makefile    |    4 +
 .../selftests/net/forwarding/gre_multipath.sh      |    2 +-
 .../selftests/net/forwarding/gre_multipath_nh.sh   |    2 +-
 .../net/forwarding/gre_multipath_nh_res.sh         |    2 +-
 tools/testing/selftests/net/forwarding/ipip_lib.sh |    2 +-
 tools/testing/selftests/net/forwarding/ipmr.c      |  455 ++
 tools/testing/selftests/net/forwarding/lib.sh      |  177 +-
 .../selftests/net/forwarding/local_termination.sh  |   37 +-
 tools/testing/selftests/net/fq_band_pktlimit.sh    |   16 +-
 .../testing/selftests/net/io_uring_zerocopy_tx.sh  |    9 +
 tools/testing/selftests/net/ip6_tunnel.sh          |   44 +
 tools/testing/selftests/net/ipsec.c                |    8 +-
 tools/testing/selftests/net/lib.sh                 |   21 +-
 tools/testing/selftests/net/lib/.gitignore         |    1 +
 tools/testing/selftests/net/lib/Makefile           |    1 +
 .../selftests/{drivers/net => net/lib}/gro.c       |  449 +-
 tools/testing/selftests/net/lib/py/__init__.py     |   14 +-
 tools/testing/selftests/net/lib/py/bpf.py          |   68 +
 tools/testing/selftests/net/lib/py/ksft.py         |   90 +-
 tools/testing/selftests/net/lib/py/utils.py        |   75 +-
 tools/testing/selftests/net/lib/py/ynl.py          |   18 +-
 tools/testing/selftests/net/lib/xdp_metadata.bpf.c |  163 +
 .../selftests/net/macvlan_mcast_shared_mac.sh      |   93 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |    4 +-
 .../selftests/net/netfilter/nft_tproxy_udp.sh      |   14 +-
 tools/testing/selftests/net/nk_qlease.py           | 2109 +++++++++
 tools/testing/selftests/net/nl_netdev.py           |   32 +-
 tools/testing/selftests/net/nl_nlctrl.py           |  131 +
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |    2 +-
 tools/testing/selftests/net/ovpn/Makefile          |   31 +-
 tools/testing/selftests/net/ovpn/common.sh         |  101 +-
 tools/testing/selftests/net/ovpn/data64.key        |    6 +-
 .../selftests/net/ovpn/json/peer0-float.json       |    9 +
 .../selftests/net/ovpn/json/peer0-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer0-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer0.json   |    6 +
 .../selftests/net/ovpn/json/peer1-float.json       |    1 +
 .../selftests/net/ovpn/json/peer1-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer1-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer1.json   |    1 +
 .../selftests/net/ovpn/json/peer2-float.json       |    1 +
 .../selftests/net/ovpn/json/peer2-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer2-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer2.json   |    1 +
 .../selftests/net/ovpn/json/peer3-float.json       |    1 +
 .../selftests/net/ovpn/json/peer3-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer3-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer3.json   |    1 +
 .../selftests/net/ovpn/json/peer4-float.json       |    1 +
 .../selftests/net/ovpn/json/peer4-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer4-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer4.json   |    1 +
 .../selftests/net/ovpn/json/peer5-float.json       |    1 +
 .../selftests/net/ovpn/json/peer5-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer5-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer5.json   |    1 +
 .../selftests/net/ovpn/json/peer6-float.json       |    1 +
 .../selftests/net/ovpn/json/peer6-symm-float.json  |    1 +
 .../selftests/net/ovpn/json/peer6-symm.json        |    1 +
 tools/testing/selftests/net/ovpn/json/peer6.json   |    1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  152 +-
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |   11 +-
 .../selftests/net/ovpn/test-close-socket.sh        |    2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |   96 +
 .../selftests/net/ovpn/test-symmetric-id-float.sh  |   11 +
 .../selftests/net/ovpn/test-symmetric-id-tcp.sh    |   11 +
 .../selftests/net/ovpn/test-symmetric-id.sh        |   10 +
 tools/testing/selftests/net/ovpn/test.sh           |   76 +-
 tools/testing/selftests/net/ovpn/udp_peers.txt     |   12 +-
 .../packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt   |   33 +
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |    2 +-
 .../net/packetdrill/tcp_rcv_neg_window.pkt         |   34 +
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt |   40 +
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   |  132 +
 tools/testing/selftests/net/ppp/Makefile           |   15 +
 tools/testing/selftests/net/ppp/config             |    9 +
 tools/testing/selftests/net/ppp/ppp_async.sh       |   43 +
 tools/testing/selftests/net/ppp/ppp_common.sh      |   45 +
 .../testing/selftests/net/ppp/pppoe-server-options |    2 +
 tools/testing/selftests/net/ppp/pppoe.sh           |   65 +
 tools/testing/selftests/net/rds/Makefile           |    1 +
 tools/testing/selftests/net/rds/README.txt         |    5 +-
 tools/testing/selftests/net/rds/config             |    5 +
 tools/testing/selftests/net/rds/config.sh          |   37 +-
 tools/testing/selftests/net/rds/run.sh             |    7 +-
 tools/testing/selftests/net/rds/settings           |    1 +
 tools/testing/selftests/net/rds/test.py            |  108 +-
 tools/testing/selftests/net/reuseport_bpf.c        |   11 +
 tools/testing/selftests/net/reuseport_bpf_cpu.c    |   10 +
 tools/testing/selftests/net/reuseport_bpf_numa.c   |   10 +
 tools/testing/selftests/net/reuseport_dualstack.c  |   11 +
 .../selftests/net/srv6_hencap_red_l3vpn_test.sh    |  109 +-
 tools/testing/selftests/net/xfrm_state.sh          |  613 +++
 .../tc-testing/tc-tests/infra/qdiscs.json          |    2 +-
 .../selftests/tc-testing/tc-tests/qdiscs/ets.json  |   23 +
 tools/testing/selftests/tc-testing/tdc.py          |    3 +
 tools/testing/selftests/tc-testing/tdc_config.py   |    1 +
 tools/testing/selftests/tc-testing/tdc_helper.py   |    4 +-
 tools/testing/selftests/vsock/vmtest.sh            |   45 +-
 1697 files changed, 73655 insertions(+), 26834 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 delete mode 100644 crypto/michael_mic.c
 create mode 100644 drivers/dpll/zl3073x/chan.c
 create mode 100644 drivers/dpll/zl3073x/chan.h
 delete mode 100644 drivers/net/bonding/bonding_priv.h
 create mode 100644 drivers/net/dsa/mv88e6xxx/tcam.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/tcam.h
 create mode 100644 drivers/net/dsa/mv88e6xxx/tcflower.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/tcflower.h
 delete mode 100644 drivers/net/ethernet/alteon/Kconfig
 delete mode 100644 drivers/net/ethernet/alteon/Makefile
 delete mode 100644 drivers/net/ethernet/alteon/acenic.c
 delete mode 100644 drivers/net/ethernet/alteon/acenic.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
 create mode 100644 drivers/net/ipa/data/ipa_data-v5.2.c
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c
 create mode 100644 drivers/net/netdevsim/tc.c
 delete mode 100644 drivers/net/phy/mdio-private.h
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922de.c
 delete mode 100644 include/linux/dsa/loop.h
 delete mode 100644 include/linux/mdio-gpio.h
 create mode 100644 include/linux/mlx5/lag.h
 delete mode 100644 include/linux/of_gpio.h
 delete mode 100644 include/linux/platform_data/mdio-gpio.h
 create mode 100644 include/net/dropreason-qdisc.h
 delete mode 100644 include/net/ipv6_stubs.h
 create mode 100644 include/net/rps-types.h
 delete mode 100644 include/net/udplite.h
 create mode 100644 net/devlink/sh_dev.c
 delete mode 100644 net/ipv4/udp_impl.h
 delete mode 100644 net/ipv4/udplite.c
 delete mode 100644 net/ipv6/udp_impl.h
 delete mode 100644 net/ipv6/udplite.c
 delete mode 100644 net/mac80211/michael.h
 create mode 100644 net/mac80211/nan.c
 rename net/{mac80211/michael.c => wireless/michael-mic.c} (95%)
 delete mode 100644 tools/net/ynl/samples/Makefile
 delete mode 100644 tools/net/ynl/samples/devlink.c
 delete mode 100644 tools/net/ynl/samples/ethtool.c
 delete mode 100644 tools/net/ynl/samples/netdev.c
 delete mode 100644 tools/net/ynl/samples/ovs.c
 delete mode 100644 tools/net/ynl/samples/rt-addr.c
 delete mode 100644 tools/net/ynl/samples/rt-link.c
 delete mode 100644 tools/net/ynl/samples/rt-route.c
 delete mode 100644 tools/net/ynl/samples/tc-filter-add.c
 delete mode 100644 tools/net/ynl/samples/tc.c
 rename tools/net/ynl/{samples => tests}/.gitignore (87%)
 create mode 100644 tools/net/ynl/tests/devlink.c
 create mode 100755 tools/net/ynl/tests/devlink.sh
 create mode 100644 tools/net/ynl/tests/ethtool.c
 rename tools/net/ynl/{pyynl => tests}/ethtool.py (86%)
 create mode 100755 tools/net/ynl/tests/ethtool.sh
 create mode 100644 tools/net/ynl/tests/netdev.c
 create mode 100644 tools/net/ynl/tests/ovs.c
 create mode 100644 tools/net/ynl/tests/rt-addr.c
 create mode 100755 tools/net/ynl/tests/rt-addr.sh
 create mode 100644 tools/net/ynl/tests/rt-link.c
 create mode 100644 tools/net/ynl/tests/rt-route.c
 create mode 100755 tools/net/ynl/tests/rt-route.sh
 create mode 100644 tools/net/ynl/tests/tc.c
 create mode 100644 tools/net/ynl/tests/wireguard.c
 create mode 100644 tools/net/ynl/tests/ynl_nsim_lib.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dst_clear.c
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_stacked_header_parse.sh
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
 create mode 100755 tools/testing/selftests/drivers/net/hw/gro_hw.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/ntuple.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/uso.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_metadata.py
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/decoupled_enablement.sh
 create mode 100644 tools/testing/selftests/drivers/net/team/settings
 create mode 100644 tools/testing/selftests/drivers/net/team/team_lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/teamd_activebackup.sh
 create mode 100755 tools/testing/selftests/drivers/net/team/transmit_failover.sh
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c
 create mode 100755 tools/testing/selftests/net/ip6_tunnel.sh
 rename tools/testing/selftests/{drivers/net => net/lib}/gro.c (78%)
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_metadata.bpf.c
 create mode 100755 tools/testing/selftests/net/macvlan_mcast_shared_mac.sh
 create mode 100755 tools/testing/selftests/net/nk_qlease.py
 create mode 100755 tools/testing/selftests/net/nl_nlctrl.py
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_disorder_fin_in_FIN_WAIT.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt
 create mode 100644 tools/testing/selftests/net/ppp/Makefile
 create mode 100644 tools/testing/selftests/net/ppp/config
 create mode 100755 tools/testing/selftests/net/ppp/ppp_async.sh
 create mode 100644 tools/testing/selftests/net/ppp/ppp_common.sh
 create mode 100644 tools/testing/selftests/net/ppp/pppoe-server-options
 create mode 100755 tools/testing/selftests/net/ppp/pppoe.sh
 create mode 100644 tools/testing/selftests/net/rds/config
 create mode 100644 tools/testing/selftests/net/rds/settings
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

