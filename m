Return-Path: <netdev+bounces-299993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jgtVAUDlMWrvrQUAu9opvQ
	(envelope-from <netdev+bounces-299993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:07:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B46695D25
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LidMjA0V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299993-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B89B0300251A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B77EEA8;
	Wed, 17 Jun 2026 00:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609811DA23;
	Wed, 17 Jun 2026 00:07:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654836; cv=none; b=iFOoQn3o+zLUWiKunzPn1ci2/CgGYgMGjZ3KuOTuuBlAm16+c++KC0zkncKm5mCZjhuQURGY+fATxd6yFhQ9Sq1iaw9acCVN7AGCs1NOxjenqFkb6PjJviF/i7ZIcGryGxTSWV/4tAvkmTV5vG8zLV/MfOFl3Vh5OfmJETTQy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654836; c=relaxed/simple;
	bh=kP6QcqmcQi00XG/X3AvG51xlL3xnOhskaIvIdyN4DfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELmZIUbBrsZhtrSCNWLGnj9jre/f2fHcCcE2vSU9al8iysBFVagMTQ4dlirDra6P3Byxq2pTyIfCz6sHwhFOKB16e7A+FE6eP3OhDM7fJ17vuJy4T52+WSxkBIxUXoyhRvkGLm7L+E8u7GkVJRGdC6E/HMfJF3pRToE1/RStboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LidMjA0V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6EC1F00A3A;
	Wed, 17 Jun 2026 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781654826;
	bh=lNWpbDKYfvMByOpubc2C81ewVTr7mbwz1zLumDsXxy8=;
	h=From:To:Cc:Subject:Date;
	b=LidMjA0V++NbIaV3dSfFq21RaqUtC+9i17m/JlsAn0DGemHa2yETwFKbyySP9sdK3
	 m9HKZuuADdVlwDddLJG5HykpGtHqj3lyA/uAKn9d8zLlLEYklyfOYaawDAPVXkARgL
	 OZP48/hY05z8UUVsGoZ577XubP9rn5F5MIUG+aSHnbJTFlSrX3WekS8KrIeISrMTMg
	 3znE7uAIQ10+9gD4spWmKsvKtlp9ucLR430pMTqFz3TULQflOGJvz3DeIPq+DE1zMc
	 dVi6D0LOwoFrJ8h2equZMvc7wU2PvLQCrWZmQr7HNYXo6Up584wWBfkLmk/JSFs877
	 WhZLOLIa0CFIw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for 7.2
Date: Tue, 16 Jun 2026 17:07:05 -0700
Message-ID: <20260617000705.931602-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9B46695D25

Hi Linus!

The following changes since commit 22e2036479cb77df6281ebbd376ae6c330774790:

  Merge tag 'net-7.1-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-11 10:17:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.2

for you to fetch changes up to d954a67a7dfa58b7a9b3194322d321b940eb60c8:

  ipv4: fib_rule: Move fib4_rules_exit() to ->exit(). (2026-06-16 15:42:53 -0700)

----------------------------------------------------------------
Networking changes for 7.2.

Core & protocols
----------------

 - Work on removing rtnl_lock protection throughout the stack continues.
   In this chapter:
    - don't use rtnl_lock for IPv6 multicast routing configuration
    - don't take rtnl_lock in ethtool for modern drivers
    - prepare Qdisc dump callbacks for rtnl_lock removal

 - Support dumping just ifindex + name of all interfaces, under RCU.
   It's a common operation for Netlink CLI tools (when translating
   names to ifindexes) and previously required full rtnl_lock.

 - Support dumping qdiscs and page pools for a specific netdev. Even tho
   user space wants a dump of all netdevs, most of the time, the OOO
   programming model results in repeating the dump for each netdev.
   Which, in absence of a cache, leads to a O(n^2) behavior.

 - Flush nexthops once on multi-nexthop removal (e.g. when device goes
   down), another O(n^2) -> O(n) improvement.

 - Rehash locally generated traffic to a different nexthop on retransmit
   timeout.

 - Honor oif when choosing nexthop for locally generated IPv6 traffic.

 - Convert TCP Auth Option to crypto library, and drop non-RFC algos.

 - Increase subflow limits in MPTCP to 64 and endpoint limit to 256.

 - Support MPTCP signaling of IPv6 address + port (ADD_ADDR). We need
   to selectively skip reporting of the standard TCP Timestamp option,
   because they won't fit into the header space together (12 + 30 > 40).

 - Support using bridge neighbor suppression, Duplicate Address
   Detection, Gratuitous ARP and unsolicited NA forwarding - in EVPN
   deployments, e.g. VXLAN fabrics (IPv4 and IPv6).

 - Improve link state reporting for upper netdevs (e.g. macvlan) over
   tunnel devices (again, mostly for EVPN deployments).

 - Support binding GENEVE tunnels to a local address.

 - Speed up UDP tunnel destruction (remove one synchronize_rcu()).

 - Support exponential field encoding in multicast (IGMPv3 and MLDv2).

 - Support attaching PSP crypto offload to containers (veth, netkit).

 - Add a new IPSec Netlink message XFRM_MSG_MIGRATE_STATE that allows
   migrating individual IPsec SAs independently of their policies.
   The existing XFRM_MSG_MIGRATE is tightly coupled to policy+SA
   migration, lacks SPI for unique SA identification, and cannot express
   reqid changes or migrate Transport mode selectors. The new interface
   identifies the SA via SPI and mark, supports reqid changes, address
   family changes, encap removal, and uses an atomic create+install
   flow under x->lock to prevent SN/IV reuse during AEAD SA migration.

 - Implement GRO/GSO support for PPPoE.

 - Convert sockopt callbacks in a number of protocols to iov_iter.

Cross-tree stuff
----------------

 - Remove support for Crypto TFM cloning (unblocked after the TCP Auth
   Option rework). This feature regressed performance for all crypto API
   users, since it changed crypto transformation objects into reference-
   -counted objects.

 - Add FCrypt-PCBC implementation to rxrpc and remove it from the global
   crypto API as obsolete and insecure.

Wireless
--------

 - Major rework of station bandwidth handling, fixing issues with lower
   capability than AP.

 - Cleanups for EMLSR spec issues (drafts differed).

 - More Neighbor Awareness Networking (Wi-Fi Aware) work (multicast,
   schedule improvements, multi-station etc.)

 - Some Ultra High Reliability (UHR) / IEEE 802.11bn (D1.4) work
   (e.g. non-primary channel access, UHR DBE support).

 - Fine Timing Measurement ranging (i.e. distance measurement) APIs.

Netfilter
---------

 - Use per-rule hash initval in nf_conncount. This avoids unnecessary
   lock contention with short keys (e.g. conntrack zones) in different
   namespaces.

 - Various safety improvements, both in packet parsing and object
   lifetimes. Notably add refcounts to conntrack timeout policy.

Deletions
---------

 - Remove TLS + sockmap integration. TLS wants to pin user pages
   to avoid a copy, and sockmap wants to write to the input stream.
   More work on this integration is clearly needed, and we can't find
   any users (original author admitted that they never deployed it).

 - Remove support for TLS offload with TCP Offload Engine (the far
   more common opportunistic offload is retained). The locking looks
   unfixable (driver sleeps under TCP spin locks) and people from
   the vendor that added this are AWOL.

 - Remove more ATM code, trying to leave behind only what PPPoATM needs,
   AAL5 and br2684 with permanent circuits.

 - Remove AppleTalk. Let it join hamradio in our out of tree protocol
   graveyard, I mean, repository.

 - Disable 32-bit x_tables compatibility (32bit binaries on 64bit kernel)
   interface in user namespaces. To be deleted completely, soon.

 - Remove 5/10 MHz support from cfg80211/mac80211.

Drivers
-------

 - Software:
   - Support DEVMEM/DMABUF Tx over NETMEM_TX_NO_DMA devices (netkit).
   - bonding: add knob to strictly follow 802.3ad for link state.

 - New drivers:
   - Alibaba Elastic Ethernet Adaptor (cloud vNIC).
   - NXP NETC switch within i.MX94.

 - DPLL:
   - Add operational state to pins (implement in zl3073x).
   - Add generic DPLL type, for daisy-chaining DPLLs (implement in ice).

 - Ethernet high-speed NICs:
   - Huawei (hinic3):
     - enhance tc flow offload support with queue selection, tunnels
   - nVidia/Mellanox:
     - avoid over-copying payload to the skb's linear part (up to 60%
       win for LRO on slow CPUs like ARM64 V2)
     - expose more per-queue stats over the standard API
     - support additional, unprivileged PFs in the DPU configuration
     - support Socket Direct (multi-PF) with switchdev offloads
     - add a pool / frag allocator for DMA mapped buffers for control
       objects, save memory on systems with 64kB page size
     - take advantage of the ability to dynamically change RSS table
       size, even when table is configured by the user
     - increase the max RSS table size for even traffic distribution

 - Ethernet NICs:
   - Marvell/Aquantia:
     - AQC113 PTP support
   - Realtek USB (r8152):
     - support 10Gbit Link Speeds and Energy-Efficient Ethernet (EEE)
     - support firmware loaded (for RTL8157/RTL8159)
     - support for the RTL8159
   - Intel (ixgbe):
     - support Energy-Efficient Ethernet (EEE) on E610 devices

 - Ethernet switches:
   - Airoha:
     - support multiple netdevs on a single GDM block / port
   - Marvell (mv88e6xxx):
     - support SERDES of mv88e6321
   - Microchip (ksz8/9):
     - rework the driver callbacks to remove one indirection layer
   - Motorcomm (yt921x):
     - support port rate policing
     - support TBF qdisc offload
     - support ACL/flower offload
   - nVidia/Mellanox:
     - expose per-PG rx_discards
   - Realtek:
     - rtl8365mb: bridge offloading and VLAN support

 - Ethernet PHYs:
   - Airoha:
     - support Airoha AN8801R Gigabit PHYs.
   - Micrel:
     - implement 3 low-loss cable tunables
   - Realtek:
     - support MDI swapping for RTL8226-CG
     - support MDIO for RTL931x
   - Qualcomm:
     - at803x: Rx and Tx clock management for IPQ5018 PHY
   - Motorcomm:
     - support YT8522 100M RMII PHY
     - set drive strength in YT8531s RGMII
   - TI:
     - dp83822: add optional external PHY clock

 - Bluetooth:
   - hci_sync: add support for HCI_LE_Set_Host_Feature [v2]
   - SMP: use AES-CMAC library API
   - Intel:
     - support Product level reset
     - support smart trigger dump
   - Mediatek:
     - add event filter to filter specific event
   - Realtek:
     - fix RTL8761B/BU broken LE extended scan

 - WiFi:
   - Broadcom (b43):
     - new support for a 11n device
   - MediaTek (mt76):
     - support mt7927
     - mt792x: broken usb transport detection
     - mt7921: regulatory improvements
   - Qualcomm (ath9k):
     - GPIO interface improvements
   - Qualcomm (ath12k):
     - WDS support
     - replace dynamic memory allocation in WMI Rx path
     - thermal throttling/cooling device support
     - 6 GHz incumbent interference detection
     - channel 177 in 5 GHz
   - Realtek (rt89):
     - RTL8922AU support
     - USB 3 mode switch for performance
     - better monitor radiotap support
     - RTL8922DE preparations

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (2):
      wifi: ath12k: Fix invalid IRQ requests during AHB probe
      wifi: ath12k: add hardware parameters for maximum supported clients

Aaron Katzin (1):
      wifi: iwlwifi: pcie: add debug print for resume flow if powered off

Abid Ali (1):
      net: stmmac: mmc: Remove duplicate mmc_rx crc

Aditya Garg (4):
      net: mana: Use per-queue allocation for tx_qp to reduce allocation size
      net: mana: Use kvmalloc for large RX queue and buffer allocations
      net: mana: initialize gdma queue id to INVALID_QUEUE_ID
      net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

Aditya Kumar Singh (1):
      wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts

Agalakov Daniil (2):
      e1000: limit endianness conversion to boundary words
      e1000e: limit endianness conversion to boundary words

Aishwarya R (2):
      wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
      wifi: ath12k: Add debugfs support to simulate incumbent signal interference

Akash Sukhavasi (2):
      dt-bindings: net: remove obsolete mdio.txt
      dt-bindings: net: dsa: remove obsolete dsa.txt

Aleksander Jan Bajkowski (3):
      net: phy: realtek: replace magic number with register bit macros
      net: phy: intel-xway: fix typo in Kconfig description
      net: phy: intel-xway: add PHY-level statistics via ethtool

Aleksandr Loktionov (3):
      ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
      igb: use ktime_get_real helpers in igb_ptp_reset()
      e1000e: use ktime_get_real_ns() in e1000e_systim_reset()

Alessio Ferri (7):
      b43: add firmware mappings for rev22
      b43: add d11 core revision 0x16 to id table
      b43: route d11 corerev 22 to 24-bit indirect radio access
      b43: support radio 2057 rev 8
      b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
      b43: add channel info table for N-PHY r8 + radio 2057 r8
      b43: add RF power offset for N-PHY r8 + radio 2057 r8

Alexander Vassilevski (1):
      net: ethernet: ti: am65-cpsw-nuss: remove dead vid check in slave_add_vid()

Alexej Sidorenko (1):
      Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan

Alice Mikityanska (2):
      net/sched: act_csum: don't mangle UDP tunnel GSO packets
      geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE

Allison Henderson (28):
      selftests: rds: Increase selftest timeout
      selftests: rds: Update USAGE string for run.sh
      selftests: rds: Fix more pylint errors
      selftests: rds: Add timeout flag to run.sh
      selftests: rds: Add RDS_LOG_DIR env variable
      selftests: rds: Add SUDO_USER env variable
      selftests: rds: Remove tmp pcaps
      selftests: rds: Stop tcpdump on timeout
      selftests: rds: Fix gcov collection
      selftests: rds: Make rds selftests TAP compliant
      selftests: rds: Fix stale log clean up
      selftests: rds: Fix TAP-prefixed prints in check_gcov*
      selftests: rds: Disarm signal alarm on test completion
      net/rds: Don't sleep inside rds_ib_conn_path_shutdown
      selftests: rds: Add helper function setup_tcp() in test.py
      selftests: rds: Add helper function check_info() in test.py
      selftests: rds: Add helper function send_burst() in test.py
      selftests: rds: Add helper function recv_burst() in test.py
      selftests: rds: Add helper function verify_hashes() in test.py
      selftests: rds: Add helper function snd_rcv_packets() in test.py
      selftests: rds: Handle errors in netns_socket
      selftests: rds: Register network teardown via atexit
      selftests: rds: Add ROCE support to test.py
      selftests: rds: Add ROCE support to run.sh
      selftests: rds: Rename run.sh to rds_run.sh
      selftests: rds: pin RDS sockets to their intended transport
      selftests: rds: support RDS built as loadable modules
      selftests: rds: report missing RDMA prereqs as XFAIL

Alvin Šipraga (5):
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}

Andreas Kemnade (1):
      wifi: wlcore: enable the right set of ciphers

Andrei Otcheretianski (1):
      wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()

Andy Shevchenko (1):
      net: dsa: realtek: Use %pM format specifier for MAC addresses

AngeloGioacchino Del Regno (2):
      dt-bindings: net: Add support for Airoha AN8801R GbE PHY
      net: phy: Introduce Airoha AN8801R Gigabit Ethernet PHY driver

Ankit Garg (1):
      gve: make nic clock reads thread safe

Antony Antony (16):
      xfrm: remove redundant assignments
      xfrm: add extack to xfrm_init_state
      xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
      xfrm: fix NAT-related field inheritance in SA migration
      xfrm: rename reqid in xfrm_migrate
      xfrm: split xfrm_state_migrate into create and install functions
      xfrm: check family before comparing addresses in migrate
      xfrm: add state synchronization after migration
      xfrm: add error messages to state migration
      xfrm: move encap and xuo into struct xfrm_migrate
      xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
      xfrm: extract address family and selector validation helpers
      xfrm: make xfrm_dev_state_add xuo parameter const
      xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
      xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
      xfrm: add documentation for XFRM_MSG_MIGRATE_STATE

Arjan van de Ven (1):
      wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

Arnd Bergmann (10):
      net: cs89x0: remove ISA bus probing
      ne2k: fold drivers/net/Space.c into ne.c
      w5100: remove MMIO support
      w5300: remove unused driver
      w5100: remove unused gpio link detection
      wifi: ath10k: drop gpio_led reference
      dt-bindings: net: add st,stlc4560/p54spi binding
      p54spi: convert to devicetree
      ARM: dts: omap2: add stlc4560 spi-wireless node
      net: dsa: b53: hide legacy gpiolib usage on non-mips

Aviel Zohar (2):
      wifi: mt76: mt7925: validate skb length in testmode query
      wifi: mt76: mt7915: validate skb length in txpower SKU query

Avinash Bhatt (12):
      wifi: iwlwifi: fix buffer overflow when firmware reports no channels
      wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API VER_3
      wifi: iwlwifi: mld: add chan-load hysteresis for MLO scan triggers
      wifi: iwlwifi: mld: add duplicated beacon RSSI adjustment
      wifi: iwlwifi: mld: Add KUnit tests for channel-load thresholds
      wifi: iwlwifi: mld: implement PSD/EIRP RSSI adjustment
      wifi: iwlwifi: mld: update link grading tables per bandwidth
      wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
      wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit
      wifi: iwlwifi: mld: add KUnit tests for duplicated beacon RSSI adjustment
      wifi: iwlwifi: mld: add KUnit tests for PSD/EIRP RSSI adjustment
      wifi: iwlwifi: mld: add KUnit tests for link grading

Avinash Duduskar (6):
      rds: tcp_listen: fix typos in comments
      Documentation: networking: ip-sysctl: fix typo in tcp_ecn_option
      Documentation: networking: devlink: stmmac: fix typo in phc_coarse_adj
      llc: avoid sparse cast-truncates warning in counter clamps
      net: socket: clean up __sys_accept4 comment
      netfilter: nf_conntrack_proto_tcp: fix typos in comments

Avraham Stern (6):
      wifi: mac80211: accept protected frames for NAN device
      wifi: iwlwifi: mld: call iwl_mld_free_ap_early_key() for AP only
      wifi: iwlwifi: mld: add support for nan schedule config command version 2
      wifi: iwlwifi: mld: add handler for NAN ULW attribute notification
      wifi: iwlwifi: mld: nan: add availability attribute to schedule config
      wifi: iwlwifi: mld: add support for deferred nan schedule config

Baochen Qiang (1):
      wifi: ath12k: fix EAPOL TX failure caused by stale tcl_metadata bits

Bartosz Golaszewski (1):
      net: mdio: drop unneeded dependency on OF_GPIO

Bastien Curutchet (Schneider Electric) (16):
      net: dsa: microchip: Remove unused ksz8_all_queues_split()
      net: dsa: microchip: remove unused port_cleanup() callback
      net: dsa: microchip: split ksz_connect_tag_protocol()
      net: dsa: microchip: remove unused phylink_mac_link_up() callback
      net: dsa: microchip: bypass dev_ops for port_setup()
      net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
      net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()
      net: dsa: microchip: remove useless common cls_flower_{add/del} operations
      net: dsa: microchip: implement get_phy_flags only if needed
      net: dsa: microchip: wrap the MAC configuration checks in a function
      net: dsa: microchip: remove setup_rgmii_delay() KSZ operation
      net: dsa: microchip: implement .support_eee() only if needed
      net: dsa: microchip: implement .{get/set}_wol only if needed
      net: dsa: microchip: implement port_hsr_join for KSZ9477 only
      net: dsa: microchip: implement lan937x-specific MDIO registration
      net: dsa: microchip: implement port_teardown only if needed

Benjamin Berg (13):
      wifi: mac80211_hwsim: remove unused nan_vif struct member
      wifi: mac80211_hwsim: move NAN related variables into a struct
      wifi: mac80211_hwsim: split NAN handling into separate file
      wifi: mac80211_hwsim: rename and switch simulation time to boottime
      wifi: mac80211_hwsim: move timestamp writing later in the datapath
      wifi: mac80211_hwsim: register beacon timer by calculating TBTT
      wifi: mac80211_hwsim: refactor NAN timer handling
      wifi: mac80211_hwsim: switch to use TXQs
      wifi: mac80211_hwsim: limit TX of frames to the NAN DW
      wifi: mac80211_hwsim: select NAN TX channel based on current TSF
      wifi: mac80211_hwsim: only RX on NAN when active on a slot
      wifi: mac80211_hwsim: protect tsf_offset using a spinlock
      wifi: mac80211_hwsim: implement NAN synchronization

Birger Koblitz (5):
      r8152: Fix double consecutive clearing of PLA_MCU_SPDWN_EN bit
      r8152: Use ocp/mdio test and clear functions in r8157_hw_phy_cfg()
      r8152: Add support for 10Gbit Link Speeds and EEE
      r8152: Add support for the RTL8159 chip
      r8152: Add firmware upload capability for RTL8157/RTL8159

Bitterblue Smith (16):
      wifi: rtw89: usb: Support 2 bulk in endpoints
      wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_post_init() for RTL8922AU
      wifi: rtw89: usb: Enable RX aggregation for RTL8922AU
      wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func() for USB
      wifi: rtw89: Let hfc_param_ini have separate settings for USB 2/3
      wifi: rtw89: Add rtw8922a_hfc_param_ini_usb{2,3}
      wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8922au.c
      wifi: rtw89: Enable the new rtw89_8922au module
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor
      wifi: rtl8xxxu: Detect the maximum supported channel width
      wifi: rtw89: Add missing TX queue mappings for RTL8922AU
      wifi: rtw88: Add more validation for the RX descriptor
      wifi: rtw89: usb: Support switching to USB 3 mode

Bjoern A. Zeeb (1):
      wifi: mt76: fix argument to ieee80211_is_first_frag()

Bobby Eshleman (12):
      net: convert netmem_tx flag to enum
      net: netkit: declare NETMEM_TX_NO_DMA mode
      net: devmem: support TX over NETMEM_TX_NO_DMA devices
      selftests: drv-net: ncdevmem: add -n flag to skip NIC configuration
      selftests: drv-net: make attr _nk_guest_ifname public
      selftests: drv-net: refactor devmem command builders into lib module
      selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem tests
      net: devmem: allow bind-rx from non-init user namespaces
      selftests: drv-net: add userns devmem RX test
      selftests/vsock: accept vng 1.33 or >= 1.36
      selftests/vsock: skip vng setsid workaround on >= 1.41

Breno Leitao (37):
      netlink: convert to getsockopt_iter
      vsock: convert to getsockopt_iter
      net: selftests: add getsockopt_iter regression tests
      mctp: convert to getsockopt_iter
      llc: convert to getsockopt_iter
      x25: convert to getsockopt_iter
      kcm: convert to getsockopt_iter
      selftests: net: getsockopt_iter: cleanup
      netpoll: expose UDP packet builder helpers for netconsole
      netconsole: move netpoll_send_udp() from netpoll
      netconsole: move push_ipv6() from netpoll
      netconsole: move push_ipv4() from netpoll
      netconsole: move push_eth() from netpoll
      netconsole: move push_udp() from netpoll
      netconsole: move netpoll_udp_checksum() from netpoll
      netpoll: rename and export netpoll_zap_completion_queue()
      netconsole: move find_skb() from netpoll
      af_iucv: convert to getsockopt_iter
      atm: convert to getsockopt_iter
      xdp: convert to getsockopt_iter
      l2tp: ppp: convert to getsockopt_iter
      rxrpc: convert to getsockopt_iter
      tipc: convert to getsockopt_iter
      netconsole: do not schedule skb pool refill from NMI
      netconsole: do not dequeue pooled skbs that cannot satisfy len
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()
      netconsole: clean up deactivated targets dropped before the cleanup worker
      netconsole: close netdevice unregister window during target resume
      selftests: net: rds: add getsockopt() conversion test
      rds: convert to getsockopt_iter
      Bluetooth: hci_sock: write the full optval for getsockopt
      Bluetooth: hci_sock: convert to getsockopt_iter
      Bluetooth: ISO: convert to getsockopt_iter
      Bluetooth: RFCOMM: convert to getsockopt_iter
      Bluetooth: L2CAP: convert to getsockopt_iter
      Bluetooth: SCO: convert to getsockopt_iter
      netconsole: clear cached dev_name on resume-window cleanup

Brett Creeley (1):
      ionic: Fix check in ionic_get_link_ext_stats

Bryam Vargas (1):
      wifi: mac80211: bound S1G TIM PVB walk to the TIM element

Byungchul Park (1):
      ice: access @pp through netmem_desc instead of page

Carl Lee (2):
      nfc: nxp-nci: Add ISO15693 support
      nfc: nxp-nci: treat -ENXIO in IRQ thread as no data available

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Support Product level reset

Chelsy Ratnawat (2):
      wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313()
      wifi: rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()

Chen Zhang (2):
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d922
      Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923

Chenguang Zhao (3):
      net/ethtool: drop duplicate TSCONFIG HWTSTAMP BUILD_BUG_ON from SET handler
      netlabel: fix IPv6 unlabeled address add error handling
      net: txgbe: fix phylink leak on AML init failure

Chia-Yuan Li (2):
      wifi: rtw89: add IO offload support via firmware
      wifi: rtw89: offload DMAC and CMAC init IO to firmware

Chih-Kang Chang (3):
      wifi: rtw89: use struct to fill C2H recv ack
      wifi: rtw89: check scan C2H event recv ack instead of C2H event done ack
      wifi: rtw89: suspend DIG when remain-on-channel

Chin-Yen Lee (2):
      wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers
      wifi: rtw89: wow: send ARP reply packets instead of Null packets to keep alive

Chris Lu (3):
      Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
      Bluetooth: btusb: MT7925: Add VID/PID 0e8d/8c38
      Bluetooth: btmtk: add event filter to filter specific event

Christoph Paasch (2):
      net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
      net/mlx5e: Avoid copying payload to the skb's linear part

Christophe JAILLET (2):
      netconsole: Constify struct configfs_item_operations and configfs_group_operations
      nfc: nci: uart: Constify struct tty_ldisc_ops

Christos Longros (1):
      wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

Chuck Lever (7):
      tls: Avoid evaluating freed skb in tls_sw_read_sock() loop
      tls: Re-present partially-consumed records in tls_sw_read_sock()
      tls: Move decrypt-failure abort into tls_rx_one_record()
      tls: Factor tls_strp_msg_consume() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record
      handshake: Require admin permission for DONE command

Chukun Pan (1):
      net: phy: realtek: Add support for PHY LEDs on RTL8221B

Corinna Vinschen (1):
      iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test

Cosmin Ratiu (3):
      ipv4: Provide a FIB flushing signal from nexthop removal functions
      ipv4: Flush the FIB once on multiple nexthop removal
      ipv4: Add __must_check to nexthop removal functions

Costa Shulyupin (2):
      include: Remove unused ks8851_mll.h
      net: Remove orphaned ax25_ptr references

Cris (1):
      Bluetooth: btusb: Add support for TP-Link TL-UB250

D. Wythe (1):
      net/smc: cap allocation order for SMC-R physically contiguous buffers

Daiki Harada (2):
      igb: use napi_schedule_irqoff() instead of napi_schedule()
      igc: use napi_schedule_irqoff() instead of napi_schedule()

Dan Carpenter (2):
      net: lan966x: cleanup error handling in lan966x_fdma_rx_alloc_page_pool()
      wifi: mwifiex: remove an unnecessary check

Daniel Borkmann (5):
      net: Stop leased rxq before uninstalling its memory provider
      selftests/net: Move netkit lease hw setup into per-test fixtures
      selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
      selftests/net: Add netkit io_uring ZC test for large rx_buf_len
      selftests/net: Add hugepage kernel config dependency for zcrx

Daniel Gabay (13):
      wifi: cfg80211: validate cipher suite for NAN Data keys
      wifi: mac80211_hwsim: add NAN_DATA interface limits
      wifi: mac80211_hwsim: add NAN PHY capabilities
      wifi: mac80211_hwsim: implement NAN schedule callbacks
      wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
      wifi: mac80211_hwsim: add NAN data path TX/RX support
      wifi: mac80211_hwsim: Declare support for secure NAN
      wifi: mac80211_hwsim: enable NAN_DATA interface simulation support
      wifi: mac80211: allow cipher change on NAN_DATA interfaces
      wifi: iwlwifi: mld: fix NAN DW end notification handler
      wifi: iwlwifi: mld: add NULL check for channel in DW end handler
      wifi: iwlwifi: mld: validate aux sta before flush in stop_nan
      wifi: iwlwifi: print UHR rate type

Daniel Golle (4):
      net: dsa: mxl862xx: store firmware version for feature gating
      net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
      net: dsa: mxl862xx: move API macros to mxl862xx-host.h
      net: dsa: mxl862xx: add support for SerDes ports

Daniel Lezcano (2):
      wifi: ath: Use the unified QMI service ID instead of defining it locally
      wifi: ath: Fix the license marking

Daniel Zahka (4):
      netdevsim: psp: reset spi on key rotation and check for exhaustion on alloc
      selftests: drv-net: tso: add new tests for ip6tnl, ipip, and sit tunnels
      netdevsim: psp: update rx stats on the peer netdevsim
      netdevsim: psp: use atomic64 for psp stats counters

Danielle Ratson (8):
      bridge: Do not suppress ARP probes and DAD NS unconditionally
      selftests: net: Add tests for ARP probe and DAD NS handling
      bridge: uapi: Add neigh_forward_grat netlink attributes
      bridge: Add internal flags for neigh_forward_grat
      bridge: Add selective forwarding of gratuitous neighbor announcements
      bridge: Add port-level netlink handling for neigh_forward_grat
      bridge: Add per-VLAN netlink handling for neigh_forward_grat
      selftests: net: Add tests for neigh_forward_grat option

David 'equinox' Lamparter (1):
      if_ether.h: add 802.1AC, warn about GRE 0x00FE

David Ahern (1):
      xfrm: Reject excessive values for XFRMA_TFCPAD

David Carlier (4):
      ixgbe: E610: do not fill EEE lp_advertised from local PHY caps
      netfilter: nfnl_cthelper: apply per-class values when updating policies
      netfilter: flowtable: avoid num_encaps underflow on bridge VLAN untag
      net: garp: reload skb header pointers after pskb_may_pull()

David Heidelberg (1):
      MAINTAINERS: Update address for David Heidelberg

David Howells (2):
      rxrpc: Fix UAF in rxgk_issue_challenge()
      afs: Fix netns teardown to cancel the preallocation charger

David Laight (3):
      net: eth: benet: Use strscpy() to copy strings into arrays
      atm: drv: Replace strcpy() + strlcat() with snprintf()
      rfkill: Replace strcpy() with memcpy()

David Lee (1):
      wifi: rtw89: usb: skip ACPI capability check for USB devices

David Thompson (1):
      net: lan743x: avoid netdev-based logging before netdev registration

David Yang (17):
      net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
      net: dsa: yt921x: Refactor long register helpers
      net: dsa: yt921x: Add port police support
      net: mention the convention for .ndo_setup_tc()
      net/sched: prefer existing extack message in qdisc_offload_graft_helper()
      net/sched: tbf: add extack to offload params
      net: dsa: yt921x: Add port TBF support
      net: dsa: sja1105: flower: reject cross-chip redirect
      net: mscc: ocelot: validate netdev belongs to switch in .netdev_to_port()
      net: dsa: tag_yt921x: handle ACL tag code
      net: dsa: yt921x: Add ACL support
      net: dsa: dsa_loop: avoid devlink resource IDs collision with PARENT_TOP
      net: dsa: b53: avoid devlink resource IDs collision with PARENT_TOP
      net: dsa: hellcreek: avoid devlink resource IDs collision with PARENT_TOP
      net: dsa: mv88e6xxx: Avoid devlink resource IDs collision with PARENT_TOP
      devlink: Warn on resource ID collision with PARENT_TOP
      net: dsa: sja1105: fix lastused timestamp in flower stats

Deepanshu Kartikey (2):
      xfrm: cleanup error path in xfrm_add_policy()
      wifi: mac80211_hwsim: reject NAN on multi-radio wiphys

Devin Wittmayer (2):
      wifi: mt76: mt7925: add Netgear A8500 USB device ID
      wifi: mt76: mt7921: assert sniffer on chanctx change

Dian-Syuan Yang (3):
      wifi: rtw89: disable HTC field in AP mode
      wifi: rtw89: disable CSI STBC for VHT 160MHz
      wifi: rtw89: pci: enable LTR based on pcie control register

Dimitri Daskalakis (1):
      selftests: drv-net: Enable ntuple-filters if supported

Dmitry Antipov (1):
      wifi: mac80211: use kstrtobool_from_user() in debugfs callbacks

Dongyang Jin (1):
      wifi: iwlwifi: mld: fix indentation in iwl_mld_fill_supp_rates()

Dragos Tatulea (5):
      net/mlx5: Update IFC allowed_list_size field bits
      selftests: iou-zcrx: defer listen() until after zcrx setup
      net/mlx5: Check max_macs devlink param value against max capability
      netdev: expose io_uring rx_page_order order via netlink
      io_uring/zcrx: selftests: verify rx_buf_len for large chunks

Dylan Eskew (2):
      wifi: mt76: mt7996: reduce phy work in set_coverage
      wifi: mt76: mt7996: limit work in set_bitrate_mask

ElXreno (2):
      wifi: mt76: route TDLS-peer frames as 3-addr non-DS in HW encap
      wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

Emmanuel Grumbach (18):
      wifi: iwlwifi: don't blindly start the responder upon BSS_CHANGED_FTM_RESPONDER
      wifi: iwlwifi: fix the access to CNVR TOP registers
      wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
      wifi: iwlwifi: mld: move iwl_mld_link_info_changed_ap_ibss to ap.c
      wifi: iwlwifi: rename iwl_system_statistics_notif_oper
      wifi: iwlwifi: introduce iwl_system_statistics_notif_oper version 4
      wifi: iwlwifi: mld: support the new statistics APIs
      wifi: iwlwifi: remove nvm_ver for devices that don't need it
      wifi: iwlwifi: implement the new RSC notification
      wifi: iwlwifi: led_compensation is needed for iwldvm only
      wifi: iwlwifi: shadow_ram_support is needed for iwldvm only.
      wifi: iwlwifi: max_event_log_size is needed for iwldvm only
      wifi: iwlwifi: smem_offset smem_len are not needed from 22000 and up
      wifi: iwlwifi: reduce the log level of firmware debug buffer size mismatch
      wifi: iwlwifi: move pcie content to pcie internal transport
      wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c
      wifi: iwlwifi: add support for AX231
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 106

Eric Biggers (19):
      net/tcp-ao: Drop support for most non-RFC-specified algorithms
      net/tcp-ao: Use crypto library API instead of crypto_ahash
      net/tcp-ao: Use stack-allocated MAC and traffic_key buffers
      net/tcp-ao: Return void from functions that can no longer fail
      net/tcp: Remove tcp_sigpool
      Documentation/tcp_ao: Document the supported MAC algorithms and lengths
      crypto: hash - Remove support for cloning hash tfms
      crypto: cipher - Remove crypto_clone_cipher()
      crypto: api - Remove crypto_clone_tfm()
      crypto: api - Remove per-tfm refcount
      crypto: api - Fold __crypto_alloc_tfmgfp() into __crypto_alloc_tfm()
      crypto: api - Fold crypto_alloc_tfmmem() into crypto_create_tfm_node()
      net/rxrpc: Add local FCrypt-PCBC implementation
      net/rxrpc: Use local FCrypt-PCBC implementation
      net/rxrpc: Reimplement DES-PCBC using DES library
      crypto: fcrypt - Remove support for FCrypt block cipher
      crypto: pcbc - Remove support for PCBC mode
      Bluetooth: Remove unneeded crypto kconfig selections
      Bluetooth: SMP: Use AES-CMAC library API

Eric Dumazet (88):
      net: dummy: do not acquire RTNL for too long
      net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
      tcp: add tcp_mstamp_refresh_inline()
      selftests/net: packetdrill: add tcp_syncookies_ip[46]_9k
      net/sched: propagate tc_fill_tclass() error
      net/sched: tc_dump_qdisc_root() refactor
      net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
      net/sched: speedup tc_dump_qdisc() when tcm_ifindex is provided
      ip6mr: plug drop_reason to ip6mr_cache_report()
      tcp: move tp->delivered and tp->delivered_ce to tcp_sock_write_tx group
      tcp: move tp->segs_in and tp->segs_out to tcp_sock_write_txrx group
      tcp: move tp->first_tx_mstamp and tp->delivered_mstamp to tcp_sock_write_tx
      tcp: move tp->bytes_acked to tcp_sock_write_tx group
      tcp: move max_packets_out, cwnd_usage_seq, rate_delivered and rate_interval_us to tcp_sock_write_tx group
      net/sched: taprio: prepare taprio_dump() for RTNL removal
      net/sched: add qstats_cpu_drop_inc() helper
      net/sched: speedup tc_dump_qdisc() when tcm_handle is provided
      net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
      net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
      net/sched: annotate data-races around sch->qstats.backlog
      net/sched: add qdisc_qlen_lockless() helper
      net/sched: add const qualifiers to gnet_stats helpers
      net/sched: mq: no longer acquire qdisc spinlocks in dump operations
      net/sched: mq_prio: no longer acquire qdisc spinlocks in mqprio_dump()
      net/sched: mq_prio: no longer acquire qdisc spinlocks in mqprio_dump_class_stats()
      rtnetlink: add RTEXT_FILTER_NAME_ONLY support
      net: constify sk_skb_reason_drop() sock parameter
      tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
      ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
      ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
      net: make is_skb_wmem() available to modules
      net/sched: fq_codel: local packets no longer count against memory limit
      netlink: add one debug check in nla_nest_end()
      net/sched: qdisc_qstats_qlen_backlog() runs locklessly
      net: ioam6: no longer acquire qdisc spinlock while calling qdisc_qstats_qlen_backlog()
      net/sched: sch_hfsc: annotate data-races in hfsc_dump_class_stats()
      net: always declare __sock_wfree() and tcp_wfree()
      net/sched: sch_dualpi2: annotate data-races in dualpi2_dump_stats()
      net/sched: sch_htb: do not change sch->flags in htb_dump()
      net/sched: sch_htb: annotate data-races (I)
      net/sched: sch_htb: annotate data-races (II)
      net/sched: sch_htb: annotate data-races (III)
      net/sched: sch_htb: fix htb_dump_class_stats() vs offload mode
      net/sched: sch_drr: annotate data-races around cl->deficit
      net/sched: sch_drr: make cl->quantum lockless
      net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
      rtnetlink: do not use RTNL in rtnl_af_register() and rtnl_af_unregister()
      dpll: change dpll_netdev_pin_handle_size() to assume DPLL_A_PIN_ID will be used
      net/sched: sch_ets: make cl->quantum lockless
      rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
      net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
      rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY
      rtnetlink: do not assume RTNL is held in link_master_filtered()
      rtnetlink: add RTEXT_FILTER_NAME_ONLY support to rtnl_dump_ifinfo()
      ipv6: guard against possible NULL deref in __in6_dev_stats_get()
      ipv6: frags: cleanup __IP6_INC_STATS() confusion
      tcp: change bpf_skops_hdr_opt_len() signature
      ipv4: raw: remove six obsolete EXPORT_SYMBOL_GPL()
      mptcp: change mptcp_established_options() to return opt_size
      bonding: annotate data-races in sysfs and procfs
      rtnetlink: use dev_isalive() in rtnl_getlink()
      bridge: add a READ_ONCE() in br_timer_value()
      bridge: add bridge_flags_bit enum
      bridge: use BR_PROMISC_BIT
      bridge: use BR_ADMIN_COST_BIT
      bridge: provide lockless access to p->path_cost
      bridge: provide lockless access to p->designated_cost
      bridge: provide lockless access to p->designated_port
      bridge: provide lockless access to p->priority
      bridge: provide lockless access to p->port_id
      bridge: provide lockless access to p->config_pending
      bridge: read p->flags once in br_port_fill_attrs()
      ipv4: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
      ipv6: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
      neighbour: remove obsolete EXPORT_SYMBOL()
      ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and ip6erspan_tunnel_xmit()
      ip6_tunnel: annotate data-races around t->err_count and t->err_time
      ip_tunnel: annotate data-races around t->err_count and t->err_time
      net: watchdog: fix refcount tracking races
      bridge: use atomic ops to read/change p->flags in sysfs
      bridge: use atomic ops to read/change p->flags in br_netlink.c
      net: bridge: use atomic ops to read/change p->flags (I)
      net: bridge: use atomic ops to read/change p->flags (II)
      net: bridge: use atomic ops to read/change p->flags (III)
      tcp: refine tcp_sequence() for the FIN exception
      tipc: fix UAF in tipc_l2_send_msg()
      tcp: ipv6: clamp default adverting MSS to avoid GSO_BY_FRAGS (0xFFFF)
      net: serialize netif_running() check in enqueue_to_backlog()

Eric Huang (2):
      wifi: rtw89: phy: support static PD level setting
      wifi: rtw89: use firmware offload for PHY and RF batch register writes

Eric Joyner (3):
      ionic: Update ionic_if.h with new extra port stats
      ionic: Report "rx_bits_phy" stat to ethtool
      ionic: Get "link_down_count" ext link stat from firmware

Erni Sri Satya Vennela (4):
      net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG
      net: mana: hardening: Reject zero max_num_queues from GDMA_QUERY_MAX_RESOURCES
      net: mana: Expose hardware diagnostic info via debugfs
      net: mana: Cache MANA_QUERY_LINK_CONFIG result to avoid repeated HWC queries

Ethan Nelson-Moore (13):
      net: ethernet: atheros: atl2: remove kernel backward-compatibility code
      net: arcnet: com20020: remove misleading references to multicast
      net: arcnet: fix typos in comments
      net: arcnet: remove ISA and PCMCIA support; modernize documentation
      net: arcnet: remove code depending on nonexistent config option
      net: arcnet: expand unnecessary I/O abstraction macros
      docs: net: arcnet: remove outdated/irrelevant information; improve style
      net: arcnet: com20020-pci: avoid -Wformat-truncation warning
      bluetooth: remove all PCMCIA drivers
      net: fec: remove reference to nonexistent CONFIG_GILBARCONAP option
      net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro name in comment
      net/mlx5: HWS: correct CONFIG_MLX5_HW_STEERING macro name in comment
      sctp: correct CONFIG_SCTP_DBG_OBJCNT macro name in comment

Felix Fietkau (4):
      net: pppoe: implement GRO/GSO support
      wifi: mac80211: report assoc_link_id in station info for non-MLD STAs on MLD AP
      wifi: mt76: mt7996: fix out-of-bounds array access during hardware restart
      wifi: mt76: mt7996: add missing max_remain_on_channel_duration

Fernando Fernandez Mancera (12):
      ipv6: addrconf: fix temp address generation after prefix deprecation
      selftests: fib_tests: add temporary IPv6 address renewal test
      netfilter: nfnetlink_osf: fix mss parsing on big-endian architectures
      netfilter: synproxy: drop packets if timestamp adjustment fails
      netfilter: synproxy: adjust duplicate timestamp options
      netfilter: synproxy: fix unaligned memory access in timestamp adjustment
      netfilter: synproxy: protect nf_ct_seqadj_init() with conntrack lock
      selftests: net: add getsockopt_iter binary to .gitignore
      ipv4: centralize devconf sysctl handling
      ipv4: handle devconf post-set actions on netlink updates
      selftests: net: add test for IPv4 devconf netlink notifications
      netfilter: nf_tables: use DEBUG_NET_WARN_ON_ONCE in packet and control paths

Fidan Aliyeva (7):
      mv88e6xxx: Add mv88e6352_reset for 6352 family
      mv88e6xxx: Cache scratch config3 of 6352
      mv88e6xxx: Use cached config3 in 6352 has_serdes
      mv88e6xxx: Remove locks for 6352's has_serdes
      mv88e6xxx: Add mv88e6352_serdes_get_lane
      mv88e6xxx: Refactor 6352's serdes functions
      mv88e6xxx: Add SERDES Support for mv88e6321

Fidelio Lawson (3):
      net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
      net: ethtool: add KSZ87xx low-loss cable PHY tunables
      net: phy: micrel: expose KSZ87xx low-loss cable tunables

Florian Westphal (12):
      netfilter: x_tables: disable 32bit compat interface in user namespaces
      netfilter: add option for GCOV profiling
      netfilter: nf_conncount: use per-rule hash initval
      netfilter: nft_set_rbtree: remove dead conditional
      netfilter: nft_set_pipapo_avx2: restore performance optimization
      netdevsim: tc: allow to test nf_tables offload control plane code
      selftests: netfilter: add phony nft_offload test
      netfilter: nf_conncount: callers must hold rcu read lock
      netfilter: nf_conncount: use per nf_conncount_data spinlocks
      netfilter: nf_conncount: split count_tree_node rbtree walk into helper
      netfilter: nf_conncount: add sequence counter to detect tree modifications
      netfilter: nf_conncount: gc and rcu fixes

Frank Li (1):
      dt-bindings: net: dsa: Convert lan9303.txt to yaml format

Fushuai Wang (1):
      net/mlx5: Simplify cpumask operations in comp_irq_request_sf()

Gal Pressman (5):
      net/mlx5e: Count full skb length in TSO byte counters
      net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
      net/mlx5e: Report RX HW-GRO netdev stats
      net/mlx5e: Report TX csum_none netdev stat
      net/mlx5e: Report stop and wake TX queue stats

Geert Uytterhoeven (1):
      dibs: Improve DIBS prompts and help texts

Geliang Tang (2):
      selftests: tls: use ASSERT_GE in test_mutliproc
      selftests: mptcp: sockopt: set EXIT trap earlier

George Moussalem (5):
      net: dsa: qca8k: Add support for force mode for fixed link topology
      net: dsa: qca8k: fix led devicename when using external mdio bus
      dt-bindings: net: ethernet-phy: increase max clock count to two
      dt-bindings: net: qca,ar803x: Add clocks for IPQ5018 PHY
      net: phy: at803x: add RX and TX clock management for IPQ5018 PHY

Giuseppe Caruso (1):
      netfilter: nf_conntrack_ftp: avoid u16 overflows

Greg Patrick (1):
      net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO

Grzegorz Nitka (13):
      dpll: add generic DPLL type
      dpll: allow registering FW-identified pin with a different DPLL
      dpll: fix stale iteration in dpll_pin_on_pin_unregister()
      dpll: send delete notification before unregister in on-pin rollback
      dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
      dpll: guard sync-pair removal on full pin unregister
      dpll: balance create/delete notifications in __dpll_pin_(un)register
      dpll: extend pin notifier with notification source ID
      dpll: allow fwnode pins to attempt state change without capability bit
      ice: introduce TXC DPLL device and TX ref clock pin framework for E825
      ice: implement CPI support for E825C
      ice: add Tx reference clock index handling to AN restart command
      ice: implement E825 TX ref clock control and TXC hardware sync status

Guangshuo Li (2):
      net: cpsw_new: unregister devlink on port registration failure
      net: lan966x: restore RX state on reload failure

Haiyang Zhang (1):
      net: mana: Add support for PF device 0x00C1

Hangtian Zhu (1):
      wifi: ath12k: allow peer_id 0 in dp peer lookup

Haoxiang Li (3):
      net: thunderx: fix PTP device ref leak in nicvf_probe()
      net: microchip: sparx5: clean up PSFP resources on flower setup failure
      bnx2x: fix resource leaks in bnx2x_init_one() error paths

Hongling Zeng (1):
      wifi: mt76: mt7921: fix resource leak in probe error path

Hrvoje Nuic (1):
      Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

Hugo Villeneuve (1):
      wifi: rtlwifi: fix typos in comments in rtl8821ae_card_disable()

Hyunwoo Kim (1):
      rxrpc: Don't move a peeked OOB message onto the pending queue

Ido Schimmel (9):
      net: Set dev->proto_down before changing carrier state
      net: Do not turn on carrier when protodown is on
      net: Do not unconditionally turn on carrier when turning off protodown
      selftests: net: Add protodown tests
      bridge: Add missing READ_ONCE() annotations around FDB destination port
      bridge: mcast: Synchronously shutdown port multicast timers
      ipv6: Select best matching nexthop object in fib6_table_lookup()
      ipv6: Honor oif when choosing nexthop for locally generated traffic
      selftests: fib_tests: Add test cases for route lookup with oif

Ilan Peer (15):
      wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
      wifi: mac80211: Allow setting MAC address on interface creation
      wifi: mac80211_hwsim: Do not declare support for NDPE
      wifi: mac80211_hwsim: Support Tx of multicast data on NAN
      wifi: mac80211: Allow per station GTK for NAN Data interfaces
      wifi: mac80211_hwsim: Do not declare NAN support for Extended Key ID
      wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
      wifi: iwlwifi: mld: Do not declare support for NDPE
      wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID
      wifi: iwlwifi: mld: Add support for multiple NAN Management stations
      wifi: iwlwifi: mld: Replace static declarations of IWL_MLD_ALLOC_FN
      wifi: iwlwifi: mld: Add support for NAN multicast data
      wifi: iwlwifi: mld: Disallow using a per-STA GTK for Tx
      wifi: iwlwifi: mld: Require HT support for NAN
      wifi: mac80211: Free keys associated with NAN Device

Ingyu Jang (1):
      wifi: mt76: Drop unneeded mt76_register_debugfs_fops() return checks

Ioana Ciornei (10):
      dpaa2-switch: rework FDB management on the bridge leave path
      dpaa2-switch: fix the error path in dpaa2_switch_rx()
      dpaa2-switch: remove duplicated check for the maximum number of VLANs
      dpaa2-switch: support VLAN flag changes on existing VIDs
      dpaa2-switch: fix handling of NAPI on the remove path
      dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
      dpaa2-switch: factor out the FDB in-use check into a helper
      dpaa2-switch: move FDB selection for join path into a helper
      dpaa2-switch: move FDB selection for leave path into a helper
      dpaa2-switch: unify the FDB update logic in dpaa2_switch_port_set_fdb()

Israel Kozitz (3):
      wifi: cfg80211: fix max_channel_switch_time documentation unit
      wifi: iwlwifi: mld: fix NAN max channel switch time unit
      wifi: iwlwifi: mld: support FW TLV for NAN max channel switch time

Ivan Vecera (4):
      dpll: add pin operational state
      dpll: zl3073x: implement pin operational state reporting
      dpll: add fractional frequency offset to pin-parent-device
      dpll: zl3073x: report FFO as DPLL vs input reference offset

JB Tsai (5):
      wifi: mt76: mt7921: refactor regulatory domain handling to regd.[ch]
      wifi: mt76: mt7921: refactor CLC support check flow
      wifi: mt76: mt7921: refactor regulatory notifier flow
      wifi: mt76: mt7921: add auto regdomain switch support
      wifi: mt76: mt7921: disable auto regd changes after user set

Jacob Keller (2):
      i40e: only timestamp PTP event packets
      ice: mention fw_activate action along with devlink reload

Jakub Kicinski (233):
      selftests: drv-net: rss: add case for field config on RSS context
      psp: validate protocol before mutating skb in psp_dev_encapsulate()
      psp: add a comment about a psp_dev add netlink notification
      psp: validate IPv4 header fields in psp_dev_rcv()
      Merge branch 'net-psp-add-more-validation'
      Merge branch 'net-mlx5-fix-e-switch-work-queue-deadlock-with-devlink-lock'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2026-04-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'bridge-do-not-suppress-arp-probes-and-dad-ns-unconditionally'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'net-sched-tc_dump_qdisc-optimizations'
      net: tls: reshuffle the device ops check
      Merge branch 'tcp-move-some-fastpath-fields-to-appropriate-groups'
      Merge branch 'net-mlx5-enable-sub-page-allocations-for-mlx5_frag_buf'
      Merge branch 'net-dsa-yt921x-add-port-police-support'
      Merge branch 'intel-wired-lan-updates-2024-04-30-ixgbe-i40e-ice'
      Merge branch 'net-convert-af_netlink-and-af_vsock-to-getsockopt_iter-api'
      Merge branch 'net-bridge-mcast-support-exponential-field-encoding'
      Merge branch 'udp_tunnel-speed-up-udp-tunnel-device-destruction-part-i'
      Merge branch 'selftests-drv-net-convert-so_txtime-to-drv-net'
      Merge branch 'fixes-for-mv88e6xxx-for-6320-6321-family'
      Merge branch 'selftests-rds-log-collection-tap-compliance-and-cleanups'
      Merge branch 'net-mana-avoid-queue-struct-allocation-failure-under-memory-fragmentation'
      Merge tag 'wireless-next-2026-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-mlx5e-report-more-netdev-stats'
      Merge branch 'r8152-add-support-for-the-rtl8159-10gbit-usb-ethernet-chip'
      Merge branch 'net-mlx5-improve-representor-lifecycle-and-late-ib-representor-loading'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      net: page_pool: support dumping pps of a specific ifindex via Netlink
      selftests: net: add tests for filtered dumps of page pool
      Merge branch 'keep-phy-link-during-wol-sleep-cycle'
      Merge branch 'net-fix-protodown-with-macvlan'
      Merge branch 'net-mlx5-icm-page-management-in-vhca_id-mode'
      Merge branch 'net-dsa-microchip-remove-one-indirection-layer'
      Merge branch 'net-convert-four-more-protocols-to-getsockopt_iter'
      Merge branch 'ipv4-flush-the-fib-once-on-multiple-nexthop-removal'
      Merge branch 'log-clean-up-and-tap-follow-ups'
      Merge branch 'net-mlx5-steering-misc-enhancements'
      Merge branch 'mptcp-pm-in-kernel-increase-limits'
      Merge branch 'net-phy-motorcomm-add-acpi-_dsd-property-support'
      Merge branch 'net-sched-prepare-lockless-qdisc-dumps'
      Merge branch 'rework-pci_device_id-initialisation'
      Merge branch 'net-use-ip_outnoroutes-drop-reason'
      Merge branch 'dpll-rework-fractional-frequency-offset-reporting'
      Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
      Merge branch 'netpoll-move-out-netconsole-specific-functions'
      Merge branch 'net-mlx5e-improve-rss-indirection-table-sizing-and-resizing'
      Merge branch 'net-sched-refine-fq_codel-memory-limits'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-sched-changes-around-qdisc_qstats_qlen_backlog'
      Merge branch 'net-dsa-microchip-remove-unnecessary-ksz_dev_ops-callbacks'
      Merge branch 'net-sched-sch_htb-first-round-of-fixes'
      Merge branch 'net-mlx5-frag-buffer-improvements'
      Merge branch 'net-mlx5e-simplify-and-optimize-napi-poll-flow'
      Merge branch 'net-devmem-support-devmem-with-netkit-devices'
      Merge branch 'gve-add-support-for-ptp-gettimex64'
      Revert "Merge branch 'gve-add-support-for-ptp-gettimex64'"
      Merge branch 'selftests-rds-add-roce-support-to-rds-selftests'
      Merge branch 'net-sched-sch_drr-lockless-cl-deficit-and-cl-quantum'
      Merge branch 'udp_tunnel-speed-up-udp-tunnel-device-destruction-part-ii'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2026-05-21' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-convert-atm-xdp-af_iucv-l2tp_ppp-rxrpc-tipc-to-getsockopt_iter'
      Merge branch 'arcnet-remove-outdated-drivers-and-information-and-unused-code-small-cleanups-and-documentation-improvements'
      Merge branch 'net-dsa-yt921x-add-port-tbf-support'
      Merge branch 'net-dsa-microchip-remove-unnecessary-ksz_dev_ops-callbacks'
      Merge branch 'net-mlx5-add-satellite-pf-support'
      Merge branch 'octeontx2-af-npc-enhancements'
      Merge branch 'add-ovs-packet-family-ynl-spec-and-unicast-notification-support'
      Merge tag 'nf-next-26-05-25' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'rtnetlink-rtnl-avoidance-in-rtnl_getlink-and-rtnl_dump_ifinfo'
      Merge branch 'ipv6-frags-adopt-__in6_dev_stats_get-a-bit-more'
      Merge branch 'introduce-airoha-an8801r-series-gigabit-ethernet-phy-driver'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      docs: net: netdevices: small fixes and clarifications
      docs: net: fix minor issues with driver guide
      docs: net: statistics: fix kernel-internal stats list
      docs: net: update devmem code examples
      docs: net: fix minor issues with the NAPI guide
      docs: net: refresh netdev feature guidance
      docs: net: fix minor issues with checksum offloads
      docs: net: add Rx notes to the checksum guide
      docs: net: render the checksum comment in checksum-offloads.rst
      docs: net: fix minor issues with segmentation offloads
      Merge branch 'docs-net-updates-for-old-and-cobwebbed-docs'
      net: ethtool: don't take rtnl_lock for global string dump
      Merge branch 'selftests-mptcp-reduce-bufferbloat-and-cleanup'
      Merge tag 'wireless-next-2026-05-28' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'remove-unused-support-for-crypto-tfm-cloning'
      docs: net: page_pool: drop reference to removed PP_FLAG_PAGE_FRAG
      docs: clarify page pool NAPI consumer requirement
      docs: page_pool: drop the mention of the legacy stats API
      net: make page_pool_get_stats() void
      Merge branch 'docs-page_pool-tweaks-and-updates'
      Merge branch 'net-mdio-realtek-rtl9300-soc-independent-command-runner'
      Merge branch 'mv88e6xxx-serdes-on-mv88e6321'
      Merge branch 'add-starfive-jhb100-soc-sgmii-gmac-support'
      Merge branch 'net-phy-dp83822-add-optional-external-phy-clock'
      Merge tag 'batadv-next-pullrequest-20260601' of https://git.open-mesh.org/batadv
      Merge branch 'netdevsim-psp-fix-issues-with-stats-collection'
      Merge branch 'net-airoha-preliminary-patches-to-support-multiple-net_devices-connected-to-the-same-gdm-port'
      Merge branch 'net-mlx5-avoid-payload-in-skb-s-linear-part-for-better-gro-processing'
      Merge branch 'dpaa2-switch-various-improvements'
      Merge branch 'net-mlx5-add-switchdev-mode-support-for-socket-direct-single-netdev-part-1-2'
      Merge branch 'geneve-allow-binding-udp-socket-to-a-specific-address'
      eth: bnxt: disable rx-copybreak by default
      net: rename netdev_ops_assert_locked()
      net: ethtool: cmis_cdb: hold instance lock for ops locked devices
      net: document NETDEV_CHANGENAME as ops locked
      net: ethtool: add netif_get_link_ksettings() for correct ops-locked use
      net: bonding: don't recurse on the slave's netdev ops lock
      net: team: don't recurse on the port's netdev ops lock
      net: bridge: don't recurse on the port's netdev ops lock
      net: sched: don't recurse on the netdev ops lock in qdiscs
      leds: trigger: netdev: don't recurse on the netdev ops lock
      scsi: fcoe: don't recurse on the netdev's ops lock
      net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked
      Merge branch 'net-ethtool-make-sure-__ethtool_get_link_ksettings-is-ops-locked'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl: try to avoid the very slow YAML loader
      Merge branch 'rndis_host-add-le310x1-id-and-enable-low-power-handling'
      Merge branch 'selftests-rds-roce-support-follow-ups'
      Merge tag 'batadv-next-pullrequest-20260603' of https://git.open-mesh.org/batadv
      Merge branch 'bridge-prepare-lockless-br_port_fill_attrs-i'
      Merge branch 'net-devmem-allow-bind-rx-from-non-init-user-namespaces'
      Merge branch 'net-mdio-realtek-rtl9300-refactor-initialization-and-port-lookup'
      Merge branch 'net-airoha-support-multiple-net_devices-connected-to-the-same-gdm-port'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge tag 'nf-next-26-06-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'batadv-next-pullrequest-20260605' of https://git.open-mesh.org/batadv
      Merge branch 'so_txtime-improvements'
      Merge branch 'ip6mr-no-rtnl-for-rtnl_family_ip6mr-rtnetlink'
      Merge branch 'tls-receive-path-fixes-and-clean-ups'
      selftests: drv-net: gro: signal over-coalescing more reliably
      net: ethtool: serialize broadcast notification sequence allocation
      net: ethtool: relax ethnl_req_get_phydev() locking assertion
      net: ethtool: make dev->hwprov ops-protected
      net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
      net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
      net: ethtool: optionally skip rtnl_lock in cable test handlers
      net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
      net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
      net: ethtool: optionally skip rtnl_lock in RSS context handlers
      net: ethtool: ioctl: concentrate the locking
      net: ethtool: optionally skip rtnl_lock on IOCTL path
      docs: net: ethtool: document ops-locked drivers and op_needs_rtnl
      Merge branch 'net-ethtool-let-ops-locked-drivers-run-without-rtnl_lock'
      Merge branch 'consolidate-fcrypt-and-pcbc-code-into-net-rxrpc'
      Merge branch 'mana-per-vport-eq'
      Merge branch 'add-motorcomm-8531s-set-ds-func-and-8522-driver'
      Merge branch 'net-add-retry-mechanism-to-ndo_set_rx_mode_async'
      Merge branch 'net-dsa-realtek-rtl8365mb-bridge-offloading-and-vlan-support'
      Merge branch 'bonding-3ad-fix-carrier-state-with-no-usable-slaves'
      Merge tag 'wireless-next-2026-06-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-dsa-yt921x-add-acl-support'
      selftests: drv-net: so_txtime: remember to deploy the binaries
      selftests: drv-net: so_txtime: check IP versions
      net: shaper: drop redundant xa_lock() bracketing
      net: shaper: drop unnecessary kfree_rcu in pre_insert
      net: shaper: add a comment why we don't need kfree_rcu() in flush
      net: shaper: add a note that we expect cap dumps to be tiny
      net: sched: avoid printing uninitialized link speed
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-fib-fix-two-use-after-free-in-drivers-during-rcu-dump'
      Merge branch 'ipq5018-add-and-enable-gephy-rx-and-tx-clocks'
      Merge branch 'mptcp-pm-drop-tcp-ts-with-add_addrv6-port'
      Merge branch 'ksz87xx-add-support-for-low-loss-cable-equalizer-errata'
      Merge branch 'tipc-fix-netlink-gate-and-receive-path-bugs'
      Merge tag 'nfc-net-next-20260611' of https://codeberg.org/linux-nfc/linux
      Merge tag 'for-net-next-2026-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'selftests-xsk-simplify-umem-setup'
      docs: net: fix minor issues with XDP metadata docs
      ethtool: tsconfig: always take rtnl_lock
      Merge branch 'net-remove-tls_toe'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge branch 'ipv6-mcast-annotate-data-races-in-proc-net-igmp6'
      Merge branch 'avoid-mistaken-parent-class-deactivation-during-peek'
      Merge branch 'net-mdio-realtek-rtl9300-add-rtl931x-support'
      Merge branch 'net-mana-fix-error-path-issues-in-queue-setup'
      Merge branch 'ipv6-honor-oif-when-choosing-nexthop-for-locally-generated-traffic'
      docs: networking: add guidance on what to push via extack
      Merge branch 'net-bridge-take-care-of-p-flags-accesses'
      Merge branch 'net-dsa-microchip-remove-unnecessary-dsa_switch_ops-callbacks'
      Merge branch 'psp-add-support-for-dev-assoc-disassoc'
      Merge branch 'netdevsim-add-fake-ft-cls_flower-offload'
      Merge branch 'vsock-consolidate-acceptq-accounting-into-core-helpers'
      Merge tag 'ipsec-next-2026-06-12' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'dpll-ice-add-generic-dpll-type-and-full-tx-reference-clock-control-for-e825'
      Merge branch 'net-stmmac-fixes-for-maximum-tx-rx-queues-to-use-by-driver'
      Merge branch 'octeontx2-af-npc-enhancements'
      Merge branch 'intel-wired-lan-driver-updates-2026-06-09-idpf-ice-i40e-iavf-ixgbe-igc-igb-e1000e-e1000'
      Merge branch 'dpaa2-switch-fdb-management-refactoring'
      Merge branch 'net-hns3-enhance-tc-flow-offload-support'
      Merge branch 'net-mlx5-add-switchdev-mode-support-for-socket-direct-single-netdev-part-2-2'
      Merge branch 'ipv4-fib-remove-rtnl-in-fib_net_exit_batch'
      Merge branch 'devlink-warn-on-resource-id-collision-with-parent_top'
      Merge branch 'octeontx2-quiesce-stale-mailbox-irq-state-before-request_irq'
      Merge branch 'selftests-vsock-improve-vng-version-and-quirk-handling'
      Merge branch 'netdev-expose-page-pool-order-via-netlink'
      Merge tag 'nf-next-26-06-14' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-sfp-extend-smbus-support'
      Merge branch 'net-dsa-netc-add-bridge-mode-support'
      Merge branch 'net-atlantic-add-ptp-support-for-aqc113-antigua'
      docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and rekey
      docs: net: fix minor issues with devlink docs
      docs: net: fix minor issues with strparser docs
      Merge branch 'docs-net-more-adjustments-to-docs'
      Merge branch 'tcp-rehash-onto-different-local-ecmp-path-on-retransmit-timeout'
      Merge branch 'icssg-xdp-zero-copy-bug-fixes'
      Merge branch 'mac-phy-interrupt-changed-to-level-triggered-interrupt'
      Merge branch 'net-dsa-mxl862xx-serdes-ports'
      Merge branch 'ionic-expose-more-port-stats-to-ethtool'
      Merge branch 'extend-netkit-io_uring-zc-selftests'
      atm: remove AAL3/4 transport support
      atm: remove the unused send_oam / push_oam callbacks
      atm: remove dead SONET PHY ioctls
      atm: remove the local ATM (NSAP) address registry
      atm: remove SVC socket support and the signaling daemon interface
      atm: remove the unused change_qos device operation
      atm: remove the unused pre_send and send_bh device operations
      atm: remove unused ATM PHY operations
      atm: remove orphaned uAPI for deleted drivers, protocols and SVCs
      Merge branch 'atm-remove-more-dead-code'
      tls: reject the combination of TLS and sockmap
      tls: remove dead sockmap (psock) handling from the SW path
      selftests/bpf: remove sockmap + ktls tests
      selftests/bpf: drop the unused kTLS program from test_sockmap
      selftests/bpf: test that TLS crypto is rejected on a sockmap socket
      Merge branch 'tls-reject-the-combination-of-tls-and-sockmap'
      appletalk: stop storing per-interface state in struct net_device
      appletalk: move the protocol out of tree
      Merge branch 'appletalk-move-the-protocol-out-of-tree'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jakub Raczynski (4):
      net/sun: Fix multiple typos in comments
      net/stmmac: Apply TBS config only to used queues
      net/stmmac: Apply MTL_MAX queue limit if config missing
      net/intel: Replace manual array size calculation with ARRAY_SIZE

Jamal Hadi Salim (1):
      net/sched: cls_flow: Dont expose folded kernel pointers

Jan Hoffmann (1):
      net: phy: realtek: support MDI swapping for RTL8226-CG

Jan Volckaert (1):
      net: usb: qmi_wwan: add MeiG SRM813Q

Jann Horn (1):
      net: block MSG_NO_SHARED_FRAGS in sendmsg()

Javier Tia (9):
      wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
      wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
      wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
      wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
      wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
      wifi: mt76: mt7925: add MT7927 chip ID helpers
      wifi: mt76: mt7925: add MT7927 firmware paths
      wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
      wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927

Jay Ng (1):
      wifi: iwlwifi: remove unused header inclusions

Jedrzej Jagielski (6):
      ixgbe: E610: add discovering EEE capability
      ixgbe: E610: update EEE supported speeds
      ixgbe: E610: use new version of 0x601 ACI command buffer
      ixgbe: E610: update ACI command structs with EEE fields
      ixgbe: move EEE config validation out of ixgbe_set_eee()
      ixgbe: E610: add EEE support

Jeff Johnson (7):
      wifi: ath12k: Fix HTC prototype ath12k_base parameters
      wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature
      wifi: ath12k: Remove macro HAL_RX_EHT_SIG_OFDMA_EB2_MCS
      wifi: ath12k: Update Qualcomm copyrights
      wifi: ath11k: Update Qualcomm copyrights
      wifi: ath10k: Update Qualcomm copyrights
      wifi: ath: Update copyright in testmode_i.h

Jeffrey Altman (1):
      rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc

Jeremy Kerr (1):
      net: mctp: test: remove skb dumps from test output

Jesse Brandeburg (1):
      mailmap: add entry for Jesse Brandeburg

Jiajia Liu (4):
      wifi: mt76: add wcid publish check in mt76_sta_add
      wifi: mt76: transform aspm_conf for pci_disable_link_state
      Bluetooth: btmtk: remove extra copy in cmd array init
      Bluetooth: hci_event: fix simultaneous discovery stuck in FINDING

Jiawen Wu (3):
      net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
      net: wangxun: avoid statistics updates during device teardown
      net: txgbe: rework service event handling

Jiayuan Chen (2):
      rds: annotate data-race around rs_seen_congestion
      net/sched: cls_bpf: prevent unbounded recursion in offload rollback

Jijie Shao (6):
      net: hns3: refactor add_cls_flower to prepare for multiple actions
      net: hns3: improve the unused_tuple parameter setting
      net: hns3: support two more actions for tc flow
      net: hns3: support IP and tunnel VNI dissectors for tc flow
      net: hns3: debugfs support for dumping fd rules
      net: hns3: move fd code to a separate file

Joe Damato (1):
      bnxt: fix head underflow on XDP head-grow

Johan Hovold (10):
      wifi: mt76: drop redundant device reference
      wifi: mt76x0u: drop redundant device reference
      wifi: mt76x2u: drop redundant device reference
      wifi: mt76: mt792xu: drop redundant device reference
      wifi: mt7601u: drop redundant device reference
      Bluetooth: btusb: fix use-after-free on registration failure
      Bluetooth: btusb: fix use-after-free on marvell probe failure
      Bluetooth: btusb: fix wakeup source leak on probe failure
      Bluetooth: btusb: fix wakeup irq devres lifetime
      Bluetooth: btusb: clean up probe error handling

Johannes Berg (120):
      wifi: mac80211: remove NAN guards on ieee80211_sta_cur_vht_bw() calls
      wifi: mac80211: set cur_max_bandwidth to maximum
      wifi: mac80211: use max BW for HT channel width update
      wifi: mac80211: use chandef in ieee80211_get_sta_bw()
      wifi: mac80211: use chandef in TDLS chanctx handling
      wifi: mac80211: remove ieee80211_sta_cap_chan_bw()
      wifi: nl80211: document channel opmode change channel width
      wifi: mac80211: simplify ieee80211_sta_rx_bw_to_chan_width()
      wifi: mac80211: clean up STA NSS handling
      wifi: mac80211: clean up initial STA NSS/bandwidth handling
      wifi: mac80211: clean up ieee80211_sta_cap_rx_bw()
      wifi: mac80211: remove ieee80211_sta_cur_vht_bw()
      wifi: cfg80211: remove HE/SAE H2E required fields
      wifi: nl80211: reject beacons with bad HE operation
      wifi: cfg80211: move AP HT/VHT/... operation to beacon info
      wifi: nl80211: reject too short HT/VHT/HE/EHT capability/operation
      wifi: cfg80211: provide HT/VHT operation for AP beacon
      wifi: nl80211: always validate AP operation/PHY regulatory
      wifi: mac80211: clarify per-STA bandwidth handling
      wifi: mac80211: fix per-station PHY capability bandwidth
      wifi: mac80211: clarify an 802.11 VHT spec reference
      wifi: nl80211: check link is beaconing for color change
      wifi: mac80211: always allow transmitting null-data on TXQs
      Merge tag 'ath-next-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: move frame RX handling to type files
      wifi: mac80211: update UHR capabilities field order
      wifi: ieee80211: define UHR ML-PM extended MLD capability
      wifi: mac80211: track AP's extended MLD capa/ops
      wifi: cfg80211: ensure UHR ML-PM flag is consistent
      wifi: cfg80211: allow devices to advertise extended MLD capa/ops
      wifi: mac80211: mlme: advertise driver's extended MLD capa/ops
      wifi: mac80211: use struct for ieee80211_determine_ap_chan() args
      wifi: mac80211: move ieee80211_chandef_usable() up
      wifi: mac80211: carry element parsing frame type/from_ap
      wifi: cfg80211: allow representing NPCA in chandef
      wifi: cfg80211: add helper for parsing NPCA to chandef
      wifi: mac80211: use NPCA in chandef for validation
      wifi: mac80211: remove NPCA during chandef downgrade
      wifi: mac80211: add NPCA to chandef tracing
      wifi: mac80211: allow only AP chanctx sharing with NPCA
      wifi: mac80211: mlme: use NPCA chandef if capable
      wifi: mac80211: set AP NPCA parameters in bss_conf
      wifi: cfg80211: separate NPCA validity from chandef validity
      wifi: mac80211: don't parse full UHR operation from beacons
      wifi: mac80211: check AP using NPCA has NPCA capability
      wifi: mac80211_hwsim: claim HT STBC capability
      wifi: mac80211: explicitly disable FTM responder on AP stop
      wifi: mac80211: check stations are removed before MLD change
      wifi: mac80211_hwsim: advertise NPCA capability
      wifi: cfg80211: add a function to parse UHR DBE
      wifi: iwlwifi: mld: tlc: separate from link STA
      wifi: iwlwifi: mld: disable queue hang detection for NAN data
      wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
      wifi: iwlwifi: mld: add NAN link management
      wifi: iwlwifi: add NAN schedule command support
      wifi: iwlwifi: mld: implement NAN peer station management
      wifi: iwlwifi: mld: add peer schedule support
      wifi: iwlwifi: mld: clean up station handling in key APIs
      wifi: iwlwifi: mld: add TLC support for NAN stations
      wifi: iwlwifi: mld: track TX/RX IGTKs separately
      wifi: iwlwifi: mld: don't report bad STA ID in EHT TB sniffer
      wifi: iwlwifi: api: RX: define UHR RX PHY flags
      wifi: iwlwifi: fw: api: fix UHR U-SIG whitespace
      wifi: iwlwifi: fw: api: add/fix some UHR sniffer definitions
      wifi: iwlwifi: pcie: fix ACPI DSM check
      wifi: iwlwifi: advertise UHR capabilities for such devices
      wifi: iwlwifi: print FSEQ sha1 in addition to version
      wifi: iwlwifi: tighten flags in debugfs command sending
      wifi: iwlwifi: define new FSEQ TLV with MAC ID
      wifi: iwlwifi: set state to NO_FW on reset
      wifi: iwlwifi: mld: support NPCA capability for UHR devices
      wifi: iwlwifi: mld: implement UHR DPS
      wifi: iwlwifi: mld: give link STA debugfs files a namespace
      wifi: iwlwifi: mld: set correct key mask for NAN
      wifi: iwlwifi: mld: add UHR DUO support
      wifi: iwlwifi: mld: implement UHR multi-link PM
      wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
      wifi: iwlwifi: mld: add link and link station FW IDs to debugfs
      wifi: iwlwifi: api: remove NAN_GROUP
      wifi: iwlwifi: api: clean up/fix some kernel-doc references
      wifi: iwlwifi: pcie: add two LNL PCI IDs
      wifi: iwlwifi: clean up location format/BW encoding
      wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
      wifi: iwlwifi: fw: separate ini dump allocation
      wifi: iwlwifi: fw: dbg: always use non-tracing PRPH access
      wifi: iwlwifi: fw: separate out old-style dump code
      wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
      wifi: iwlwifi: transport: add memory read under NIC access
      wifi: mac80211_hwsim: add debug messages for link changes
      Merge tag 'iwlwifi-next-2026-05-26' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-next-20260526' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: cfg80211: remove 5/10 MHz channel support
      wifi: mac80211: remove 5/10 MHz channel code
      wifi: ieee80211: define some UHR link reconfiguration frame types
      wifi: mac80211: unify link STA removal in vif link removal
      wifi: mac80211: clean up return in ieee802_11_find_bssid_profile()
      wifi: mac80211: rename "multi_link_inner" variable
      wifi: mac80211: clarify beacon parsing with MBSSID/EMA
      wifi: mac80211: use local ml_basic_elem in parsing
      wifi: cfg80211: harden cfg80211_defragment_element()
      wifi: mac80211: always expose multi-link element
      wifi: mac80211: mlme: allow UHR only with MLO
      wifi: mac80211: explain ieee80211_determine_chan_mode() parsing
      wifi: Update UHR PHY capabilities to D1.4
      wifi: Update UHR MAC capabilities to D1.4
      wifi: mac80211: refactor link STA bandwidth update
      wifi: mac80211: parse and apply UHR DBE channel
      wifi: mac80211: AP: handle DBE for clients
      wifi: mac80211_hwsim: claim DBE capability
      Merge tag 'rtw-next-2026-06-03' of https://github.com/pkshih/rtw
      wifi: iwlwifi: fw: cut down NIC wakeups during dump
      wifi: iwlwifi: mvm: rename iwl_mvm_mac80211_idx_to_hwrate()
      wifi: iwlwifi: move iwl_fw_rate_idx_to_plcp() to mvm
      wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o netdetect
      wifi: iwlwifi: mvm: fix P2P-Device binding handling
      wifi: iwlwifi: pcie: fix write pointer move detection
      Merge tag 'ath-next-20260602' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-next-2026-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'mt76-next-2026-06-09' of https://github.com/nbd168/wireless
      Merge tag 'ath-next-20260609' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Johnson Tsai (5):
      wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
      wifi: rtw89: debug: disable inactive power save to reduce bus overhead
      wifi: rtw89: 8832cu: Add ID 2c7c:8206 for RTL8832CU
      wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
      wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432

Jonas Jelonek (2):
      net: sfp: apply I2C adapter quirks to limit block size
      net: sfp: extend SMBus support

Jordan Rhee (2):
      gve: skip error logging for retryable AdminQ commands
      gve: implement PTP gettimex64

Jordan Walters (1):
      Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Jose Ignacio Tornos Martinez (2):
      wifi: ath11k: fix warning when unbinding
      net: wwan: t7xx: Add delay between MD and SAP suspend

Julian Anastasov (2):
      ipvs: add conn_max sysctl to limit connections
      ipvs: fix doc syntax for conn_max sysctl

Junjie Cao (2):
      wifi: iwlwifi: mld: fix race condition in PTP removal
      wifi: iwlwifi: mvm: fix race condition in PTP removal

Junrui Luo (1):
      wifi: iwlwifi: mld: validate sta_mask before ffs() in BA session handlers

Justin Chen (2):
      net: bcmasp: Divide init to allow partial bring up
      net: bcmasp: Keep phy link during WoL sleep cycle

Justin Iurman (1):
      ipv6: exthdrs: recompute network header pointer once

Justin Lai (1):
      rtase: Fix flow control configuration

Kavita Kavita (3):
      wifi: cfg80211: indicate (Re)Association frame encryption to userspace
      wifi: mac80211: set assoc_encrypted for EPP associations
      wifi: mac80211_hwsim: Add support for extended FTM ranging

Keno Fischer (1):
      mlxsw: spectrum_ethtool: expose per-PG rx_discards

Kexin Sun (1):
      wifi: ath10k: update outdated comment for renamed ieee80211_tx_status()

KhaiWenTan (1):
      igc: skip RX timestamp header for frame preemption verification

Kiran K (2):
      Bluetooth: btintel_pcie: Add support for smart trigger dump
      Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW

Kiran Kumar K (1):
      octeontx2-af: kpu: Default profile updates

Konstantin Shabanov (1):
      docs: netlink: Correct buffer sizing info

Krzysztof Kozlowski (2):
      net: Unify user-visible "Qualcomm" name
      wifi: ath: Unify user-visible "Qualcomm" name

Kuan-Chung Chen (7):
      wifi: rtw89: mlo: rearrange MLSR link decision flow
      wifi: rtw89: phy: support per PHY RX statistics
      wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7 chips
      wifi: rtw89: debug: add PMAC counter in bb_info
      wifi: rtw89: debug: extend bb_info with TX status and PER
      wifi: rtw89: debug: add RX statistics in bb_info
      wifi: rtw89: debug: add BB diagnose

Kuniyuki Iwashima (51):
      udp_tunnel: Pass struct sock to udp_tunnel_sock_release().
      udp_tunnel: Pass struct sock to setup_udp_tunnel_sock().
      udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
      udp_tunnel: Pass struct sock to udp_tunnel_{push,drop}_rx_port().
      udp_tunnel: Pass struct sock to udp_tunnel_notify_{add,del}_rx_port().
      vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
      vxlan: Store struct sock in struct vxlan_sock.
      vxlan: Free vxlan_sock with kfree_rcu().
      geneve: Store struct sock in struct geneve_sock.
      bareudp: Store struct sock in struct bareudp_dev.
      fou: Store struct sock in struct fou.
      amt: Store struct sock in struct amt_dev.
      pfcp: Store struct sock in struct pfcp_dev.
      tipc: Store struct sock in struct udp_bearer.
      udp_tunnel: Remove synchronize_rcu() in udp_tunnel_sock_release().
      vxlan: Remove synchronize_net() in vxlan_sock_release().
      geneve: Remove synchronize_net() in geneve_sock_release().
      geneve: Remove synchronize_net() in geneve_unquiesce().
      bareudp: Remove synchronize_net() in bareudp_sock_release().
      bareudp: Use rtnl_dereference() in bareudp_sock_release().
      af_unix: Remove sock->state assignment.
      geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
      geneve: Pass struct geneve_dev to geneve_create_sock().
      geneve: Pass struct geneve_dev to geneve_find_sock().
      geneve: Add dualstack flag to struct geneve_config.
      geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
      geneve: Move udp_conf.local_ip6 under CONFIG_IPV6 in geneve_create_sock().
      selftest: net: Extend ipmr.c for IP6MR.
      ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
      ip6mr: Use MAXMIFS in mr6_msgsize().
      ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
      ip6mr: Convert ip6mr_rtm_getroute() to RCU.
      ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
      net: Remove rtnl_held of struct fib_dump_filter.
      ip6mr: Free mr_table after RCU grace period.
      ip6mr: Call fib_rules_unregister() without RTNL.
      ip6mr: Move unregister_netdevice_many() out of mroute_clean_tables().
      ip6mr: Move unregister_netdevice_many() out of ip6mr_free_table().
      ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
      ip6mr: Remove RTNL in ip6mr_rules_init() and ip6mr_net_init().
      ip6mr: Replace RTNL with a dedicated mutex for MFC.
      ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq} under CONFIG_IPV6_MROUTE.
      ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
      net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
      ipmr: Convert mr_table.cache_resolve_queue_len to u32.
      ipv4: fib: Flush all fib_info in fib_table_flush() during netns dismantle.
      ipv4: fib: Call fib_proc_exit() and nl_fib_lookup_exit() at ->pre_exit().
      ipv4: fib: Free net->ipv4.{fib_table_hash,notifier_ops} without RTNL.
      ipv4: fib: Avoid calling fib_trie_table() in fib_new_table() for dying net.
      ipv4: fib: Convert fib_net_exit_batch() to ->exit_rtnl().
      ipv4: fib_rule: Move fib4_rules_exit() to ->exit().

Kwan Lai Chee Hou (1):
      wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode

Lachlan Hodges (5):
      wifi: mac80211: skip NSS and BW init for S1G sta
      wifi: mac80211: don't recalc min def for S1G chan ctx
      wifi: mac80211_hwsim: don't run RC update on new STA on S1G vif
      wifi: mac80211_hwsim: modernise S1G channel list
      wifi: mac80211: basic S1G rx rate reporting support

Larysa Zaremba (1):
      ixgbe: do not configure xps for XDP queues

Len Bao (1):
      eth: dpaa2: constify dpaa2_ethtool_stats and dpaa2_ethtool_extras

Li Daming (1):
      rxrpc: serialize kernel accept preallocation with socket teardown

Li Xiasong (1):
      tipc: restrict socket queue dumps in enqueue tracepoints

Linmao Li (1):
      ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD

Linus Walleij (2):
      wifi: ath9k: Obtain system GPIOS from descriptors
      dt-bindings: net: lan966x: Accept standard ethernet prefixes

Long Li (6):
      net: mana: Create separate EQs for each vPort
      net: mana: Query device capabilities and configure MSI-X sharing for EQs
      net: mana: Introduce GIC context with refcounting for interrupt management
      net: mana: Use GIC functions to allocate global EQs
      net: mana: Allocate interrupt context for each EQ when creating vPort
      RDMA/mana_ib: Allocate interrupt contexts on EQs

Lorenzo Bianconi (26):
      net: airoha: Rename get_src_port_id callback in get_sport
      net: airoha: configure QoS channel for HW accelerated flowtable traffic
      net: airoha: Introduce airoha_fe_get()/airoha_qdma_get() register read helpers
      net: airoha: Reserve RX headroom to avoid skb reallocation
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airoha_is_lan_gdm_port()
      net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
      net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
      net: airoha: Rename airoha_set_gdm2_loopback in airoha_enable_gdm2_loopback
      net: airoha: Report extack error to the user if airoha_tc_htb_modify_queue() fails
      dt-bindings: net: airoha: Add GDM port ethernet child node
      net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration
      wifi: mt76: mt7996: Fix NULL pointer dereference in mt7996_init_tx_queues()
      wifi: mt76: mt7996: Fix possible token leak in mt7996_tx_prepare_skb()
      wifi: mt76: mt7996: Fix possible NULL pointer dereference in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7996: fix reading zeroed info->control.flags after mt76_tx_status_skb_add()
      wifi: mt76: mt7996: remove redundant pdev->bus check in probe
      net: airoha: move get_sport() callback at the beginning of airoha_enable_gdm2_loopback()
      net: airoha: simplify WAN device check in airoha_dev_init()
      net: airoha: better handle MIBs for GDM ports with multiple devs attached
      net: airoha: use int instead of atomic_t for qdma users counter

Louis Kotze (2):
      wifi: cfg80211: fix grammar in MLO group key error message
      wifi: rtw89: phy: increase RF calibration timeouts for USB transport

Louis Scalbert (6):
      tools: missed broadcast_neigh if_link uapi header
      netlink: specs: rt-link: missed broadcast-neigh
      bonding: 3ad: add lacp_strict configuration knob
      bonding: 3ad: fix carrier when no usable slaves
      bonding: 3ad: fix mux port state on oper down
      selftests: bonding: add test for lacp_strict mode

Louis-Alexis Eyraud (4):
      net: phy: Add Airoha phy library for shared code
      net: phy: air_phy_lib: Factorize BuckPBus register accessors
      net: phy: Rename Airoha common BuckPBus register accessors
      net: phy: air_an8801: ensure maximum available speed link use

Luca Ellero (1):
      net: phy: dp83867: add MDI-X management

Luiz Angelo Daros de Luca (4):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: reject unsupported topologies
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
      net: dsa: realtek: rtl8365mb: add bridge port flags

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Add support for HCI_LE_Set_Host_Feature [v2]

Luka Gejak (4):
      net: hsr: reject unresolved interlink ifindex
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures
      net: hsr: require valid EOT supervision TLV

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS

Lukas Wunner (1):
      bnxt_en: Drop pci_save_state() after pci_restore_state()

Mahanta Jambigi (1):
      Documentation: net/smc: correct old value of smcr_max_recv_wr

Maharaja Kennadyrajan (5):
      wifi: ath12k: handle thermal throttle stats WMI event
      wifi: ath12k: configure firmware thermal throttling via WMI
      wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
      wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
      wifi: ath12k: add thermal cooling device support

Manuel Stocker (1):
      net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package

Maoyi Xie (4):
      rds: filter RDS_INFO_* getsockopt by caller's netns
      mlxsw: spectrum_fid: use a dedicated list head pointer for sorted insert
      wifi: nl80211: re-check wiphy netns in testmode and vendor dump continuations
      hsr: broadcast netlink notifications in the device's net namespace

Marco Crivellari (3):
      ipmr: Replace use of system_unbound_wq with system_dfl_wq
      idpf: Replace use of system_unbound_wq with system_dfl_wq
      ipvs: Replace use of system_unbound_wq with system_dfl_long_wq

Marco Elver (1):
      Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref

Marek Behún (6):
      net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
      net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
      net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported ports
      net: dsa: mv88e6xxx: define .pot_clear() for 6321
      net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
      net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family

Mark Bloch (10):
      net/mlx5: E-Switch, move work queue generation counter
      net/mlx5: E-Switch, introduce generic work queue dispatch helper
      net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
      net/mlx5: Lag: refactor representor reload handling
      net/mlx5: E-Switch, let esw work callers choose GFP flags
      net/mlx5: E-Switch, add representor lifecycle lock
      net/mlx5: Lag, avoid LAG and representor lock cycles
      net/mlx5: E-Switch, serialize representor lifecycle
      net/mlx5: E-Switch, unwind only newly loaded representor types
      net/mlx5: E-Switch, load reps via work queue after registration

Markus Stockhausen (24):
      net: mdio: realtek-rtl9300: enhance documentation & naming
      net: mdio: realtek-rtl9300: Add device specific info structure
      net: mdio: realtek-rtl9300: Add ports to info structure
      net: mdio: realtek-rtl9300: Add pages to info structure
      net: mdio: realtek-rtl9300: Add register structure
      net: mdio: realtek-rtl9300: Add command/C22 register
      net: mdio: realtek-rtl9300: Add I/O register
      net: mdio: realtek-rtl9300: Add port mask register
      net: mdio: realtek-rtl9300: Link I/O functions in info structure
      net: mdio: realtek-rtl9300: provide generic command runner
      net: mdio: realtek-rtl9300: use command runner for write_c22()
      net: mdio: realtek-rtl9300: use command runner for read_c45()
      net: mdio: realtek-rtl9300: use command runner for read_c22()
      net: mdio: realtek-rtl9300: Refactor otto_emdio_map_ports()
      net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
      net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
      net: mdio: realtek-rtl9300: relocate topology setup
      net: mdio: realtek-rtl9300: relocate c22/c45 device tree readout
      net: mdio: realtek-rtl9300: reorder controller setup
      dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
      net: mdio: realtek-rtl9300: Add prefix to register field defines
      net: mdio: realtek-rtl9300: Make otto_emdio_read_cmd() generic
      net: mdio: realtek-rtl9300: Add registers for high port count models
      net: mdio: realtek-rtl9300: Add support for RTL931x

Martin Kaiser (1):
      wifi: rtw88: remove rtw_txq_dequeue

Martin Karsten (1):
      net: napi: Skip last poll when arming gro timer in busy poll

Masashi Honma (9):
      wifi: mac80211: Use struct instead of macro for PREQ frame
      wifi: mac80211: Use struct instead of macro for PREP frame
      wifi: mac80211: Use struct instead of macro for PERR frame
      wifi: mac80211: Fix overread in PREQ frame processing
      wifi: mac80211: Fix overread in PREP frame processing
      wifi: mac80211: Fix PERR frame processing
      wifi: mac80211: Add KUnit test for ieee80211_mesh_preq_size_ok
      wifi: mac80211: Add KUnit test for ieee80211_mesh_prep_size_ok
      wifi: mac80211: Add KUnit test for ieee80211_mesh_perr_size_ok

Matt Vollrath (1):
      e1000e: Use __napi_schedule_irqoff()

Matthieu Baerts (NGI0) (25):
      mptcp: pm: in-kernel: explicitly limit batches to array size
      mptcp: pm: in-kernel: increase all limits to 64
      mptcp: pm: kernel: allow flushing more than 8 endpoints
      mptcp: pm: in-kernel: increase endpoints limit
      selftests: mptcp: join: allow changing ifaces nr per test
      selftests: mptcp: join: validate 8x8 subflows
      selftests: mptcp: pm: validate new limits
      selftests: mptcp: pm: use simpler send/recv forms
      selftests: mptcp: simult_flows: disable GSO
      selftests: mptcp: simult_flows: adapt limits
      mptcp: options: suboptions sizes can be negative
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
      tcp: allow mptcp to drop TS for some packets
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers
      mptcp: pm: remove add_ prefix from timer
      mptcp: pm: make mptcp_pm_add_addr_send_ack static
      mptcp: pm: avoid using del_timer directly
      mptcp: options: rst: drop unused skb parameter

Maxime Chevallier (1):
      net: phy: aquantia: use ADVERTISE_XNP for extended next page advertising

Maximilian Pezzullo (2):
      igb: fix typos in comments
      igc: fix typos in comments

Md Shofiqul Islam (1):
      sctp: Fix typo in comment

Meghana Malladi (3):
      net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
      net: ti: icssg: Use undirected TX tag for native XDP in HSR offload mode
      net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode

Miaoqing Pan (3):
      wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
      wifi: ath11k: add MSDU length validation for TKIP MIC error
      wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()

Michael Bommarito (5):
      wifi: mac80211: add KUnit coverage for negotiated TTLM parser
      tipc: require net admin for TIPCv2 netlink mutators
      tipc: prevent snt_unacked underflow on CONN_ACK
      tipc: reject inverted service ranges from peer bindings
      net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: add support for RTL8367SB

Mike Marciniszyn (Meta) (4):
      net: mdio: Add support for RSFEC Control register for PMA
      net: eth: fbnic: Consolidate register reads for ids and devs
      net: eth: fbnic: Add pma read and write access
      net: eth: fbnic: Fix addr validation in pcs write

Miles Krause (1):
      nfc: trf7970a: fix comment typos

Minda Chen (8):
      dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
      dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
      net: stmmac: starfive: Add jhb100 SGMII interface
      net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
      net: ncsi: Set ncsi_stop_dev() to inline while NET_NCSI not enabled
      net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
      net: motorcomm: phy: set drive strength in YT8531s RGMII
      net: phy: motorcomm: Add YT8522 100M RMII PHY support

Minxi Hou (8):
      selftests: openvswitch: add vlan() and encap() flow string parsing
      selftests: openvswitch: add pop_vlan test
      netlink: specs: add OVS packet family specification
      tools: ynl: add unicast notification receive support
      selftests: openvswitch: add dec_ttl action support and test
      selftests/net/openvswitch: guard command substitutions against empty output
      selftests/net/openvswitch: add flow modify test
      selftests/net/openvswitch: add SET action test

Miri Korenblit (34):
      wifi: mac80211: track the id of the NAN cluster we joined
      wifi: mac80211: avoid out-of-bounds access in monitor
      wifi: mac80211: add NAN channel evacuation support
      wifi: cfg80211: don't allow NAN DATA on multi radio devices
      wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed
      wifi: iwlwifi: mld: set NAN phy capabilities
      wifi: iwlwifi: mld: use host rate for NAN management frames
      wifi: iwlwifi: mld: extract NAN capabilities setting to a function
      wifi: iwlwifi: mld: don't allow softAP with NAN
      wifi: iwlwifi: bump core version for BZ/SC/DR to 103
      wifi: iwlwifi: mld: allow NAN data
      wifi: iwlwifi: support a TLV indicating num of mgmt mcast keys
      wifi: iwlwifi: mark that we support iwl_rx_mpdu_desc version 7 and 8
      wifi: iwlwifi: stop supporting cores 97 to 100
      wifi: iwlwifi: mld: stop supporting iwl_compressed_ba_notif version 5 and 6
      wifi: iwlwifi: mld: stop supporting MAC_PM_POWER_TABLE version 1
      wifi: iwlwifi: mld: stop supporting TLC_MNG_UPDATE_NTFY_API_S_VER_3
      wifi: iwlwifi: mld: stop supporting rate_n_flags version 2
      wifi: iwlwifi: bump core version for BZ/SC/DR to 104
      wifi: iwlwifi: define MODULE_FIRMWARE with the correct API
      wifi: iwlwifi: mld: evacuate NAN channels on link switch
      wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
      wifi: iwlwifi: mld: purge async notifications upon nic error
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
      wifi: mac80211: add an option to filter out a channel in combinations check
      wifi: mac80211: refactor ieee80211_nan_try_evacuate
      wifi: mac80211: fix channel evacuation logic
      wifi: iwlwifi: remove stale comment
      wifi: iwlwifi: remove mvm prefix from marker command
      wifi: iwlwifi: mld: fix smatch warning
      wifi: iwlwifi: mld: always allow mimo in NAN
      wifi: iwlwifi: fix a typo
      wifi: iwlwifi: trans: export the maximum supported hcmd size
      wifi: iwlwifi: mvm: remove __must_check annotation from command sending

Moriya Itzchaki (1):
      wifi: iwlwifi: fix STEP_URM register address for SC devices

Moshe Shemesh (26):
      mlx5: Rename the vport number enums for host PF and VF
      net/mlx5: Add function_id_type for enable/disable_hca cmds
      net/mlx5: Remove unused host_sf_enable field
      net/mlx5: Extend query_esw_functions output for multi-function support
      net/mlx5: Relax capability check for eswitch query paths
      net/mlx5: Make debugfs page counters by function type dynamic
      net/mlx5: Add VHCA_ID page management mode support
      net/mlx5: Use helper to parse host PF info
      net/mlx5: Use v1 response layout for query_esw_functions
      net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
      net/mlx5: Switch vport HCA cap helpers to kvzalloc
      net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
      net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
      net/mlx5: Use vport helper for IPsec eswitch set caps
      net/mlx5: Generalize enable/disable HCA for any PF vport
      net/mlx5: Add satellite PF vport support
      net/mlx5: Introduce generic helper for PF SFs info
      net/mlx5: Initialize host PF host number earlier
      net/mlx5: Initialize satellite PF SF vports
      net/mlx5: Support SPF SFs in SF hardware table
      net/mlx5: Expose PF number from query_esw_functions
      net/mlx5: Map SF controller to pfnum for satellite PFs
      net/mlx5: Register devlink ports for satellite PFs
      net/mlx5: Support state get/set for satellite PF ports
      net/mlx5: Add FDB peer miss rules for satellite PFs
      net/mlx5: Add SPF function type for page management

Muhammad Bilal (1):
      netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read

Myeonghun Pak (1):
      wifi: mt76: mt7925: clean up DMA on probe failure

Natalia Wochtman (1):
      ice: remove redundant checks from PTP init

Nathan Chancellor (1):
      wifi: mac80211: Fix -Wc23-extensions in hwmp_route_info_get()

Nazim Amirul (3):
      net: stmmac: Improve Tx timer arm logic further
      net: stmmac: xgmac: report L3/L4 filter match count in ethtool stats
      net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

Neal Cardwell (1):
      tcp_bbr: fix SPDX-License-Identifier to be GPL-2.0 OR BSD-3-Clause

Neil Spring (2):
      tcp: rehash onto different local ECMP path on retransmit timeout
      selftests: net: add local ECMP rehash test

Nicolai Buchwitz (1):
      net: bcmgenet: convert RX path to page_pool

Nicolas Escande (2):
      wifi: ath12k: avoid dynamic alloc when parsing wmi tb
      wifi: ath12k: unify error handling in some ath12k_wmi_xxx() functions

Nikhil P. Rao (1):
      pds_core: quiesce DMA before freeing resources

Nils Helmig (1):
      Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV

Nimrod Oren (5):
      net/mlx5: wire frag buf pools lifecycle hooks
      net/mlx5: add frag buf pools create/destroy paths
      net/mlx5: use internal dma pools for frag buf alloc
      net/mlx5: use numa_mem_id() for default frag buf allocations
      net/mlx5: add debugfs stats for frag buf dma pools

Oliver Neukum (1):
      net: usb: usbnet: use proper ep number macros

Or Har-Toov (1):
      net/mlx5: Register SF resource on satellite PF ports

Ovidiu Panait (2):
      net: stmmac: dwmac4: Report DCB feature capability
      net: bcmgenet: Use weighted round-robin TX DMA arbitration

Pablo Martin-Gomez (4):
      wifi: Remove invalid 128TU transition timeout constant
      wifi: Remove EMLMR Delay subfield definitions
      wifi: Rename EMLSR delay constants and add EMLMR helpers and definitions
      wifi: Update EML function documentation to remove EMLSR-specific references

Pablo Neira Ayuso (11):
      netfilter: allow nfnetlink built-in only
      netfilter: nfnetlink_cthelper: use {READ,WRITE}_ONCE for accessing helper flags
      netfilter: cttimeout: detach dataplane timeout policy and repurpose refcount
      netfilter: nf_conntrack_helper: dynamically allocate struct nf_conntrack_helper
      netfilter: nf_conntrack_pptp: move GRE specific cleanup to GRE tracker
      netfilter: nf_conntrack_helper: add refcounting from datapath
      netfilter: conntrack: revert ct extension genid infrastructure
      netfilter: conntrack: call nf_ct_gre_keymap_destroy() if master helper is pptp
      netfilter: conntrack: check NULL when retrieving ct extension
      netfilter: flowtable: bail out if forward path cannot be discovered
      netfilter: nf_dup_netdev: add nf_dev_xmit_recursion*() helpers and use them

Pagadala Yesu Anjaneyulu (4):
      wifi: iwlwifi: add RF name handling for PE chip type for debugfs
      wifi: iwlwifi: add XIAOMI to PPAG approved list
      wifi: iwlwifi: mld: disallow puncturing in US/CA for WH
      wifi: iwlwifi: mld: set fast-balance scan for active EMLSR

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Paolo Abeni (20):
      Merge branch 'reimplement-tcp-ao-using-crypto-library'
      Merge branch 'dpll-add-pin-operational-state'
      Merge branch 'first-series-for-xpcs-based-rsfec-configuration'
      Merge branch 'net-sched-netem-enhancements'
      Merge branch 'bridge-add-selective-forwarding-of-gratuitous-neighbor-announcements'
      Merge branch 'eea-add-basic-driver-framework-for-alibaba-elastic-ethernet-adaptor'
      Merge branch 'net-mlx5-prepare-eswitch-infrastructure-for-satellite-pf-support'
      Merge branch 'add-preliminary-netc-switch-support-for-i-mx94'
      Merge branch 'net-mdio-realtek-rtl9300-groundwork-for-multi-soc-support'
      Merge branch 'mv88e6xxx-cache-scratch-config3-of-6352'
      Merge branch 'net-enetc-prepare-for-enetc-v4-vf-support'
      Merge branch 'wangxun-improve-service-task-synchronization'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'netconsole-fix-reported-problems'
      Merge branch 'ipv4-igmp-annotate-diagnostic-procfs-data-races'
      Merge branch 'selftests-drv-net-so_txtime-trivial-fixes'
      Merge branch 'net-rds-convert-rds-to-getsockopt_iter'
      Merge branch 'net-shaper-follow-ups-to-recent-fixes'
      virtio_net: do not allow tunnel csum offload for non GSO packets
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Patrisious Haddad (1):
      net/mlx5: Add vhca_id_type support to IPsec alias creation

Pauli Virtanen (1):
      Bluetooth: 6lowpan: fix cyclic locking warning on netdev unregister

Peddolla Harshavardhan Reddy (12):
      wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
      wifi: cfg80211: Add MAC address filter to remain_on_channel
      wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
      wifi: cfg80211: add start/stop proximity detection commands
      wifi: cfg80211: add proximity detection capabilities to PMSR
      wifi: cfg80211: add NTB continuous ranging and FTM request type support
      wifi: cfg80211: extend PMSR FTM response for proximity ranging
      wifi: cfg80211: add role-based peer limits to FTM capabilities
      wifi: cfg80211: add ingress/egress distance thresholds for FTM
      wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
      wifi: cfg80211: allow suppressing FTM result reporting for PD requests
      wifi: cfg80211: add LTF keyseed support for secure ranging

Petr Wozniak (1):
      net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c

Ping-Ke Shih (42):
      wifi: mac80211: add __packed to union members of struct ieee80211_rx_status
      wifi: rtl8xxxu: validate action frame size before using in rtl8xxxu_dump_action()
      wifi: rtlwifi: validate action frame size in rtl_action_proc()
      wifi: rtlwifi: validate action frame size before using in _rtl_pci_tx_isr()
      wifi: rtw89: 8922d: fix typo rx_freq_frome_ie
      wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
      wifi: rtw89: add AMPDU to radiotap
      wifi: rtw89: add VHT beamformed to radiotap
      wifi: rtw89: SNIFFER_MODE bit along IEEE80211_CONF_MONITOR
      wifi: rtw89: phy: define PHY status IE length for generations
      wifi: rtw89: phy: enable IE-09/IE-10 PHY status report for monitor mode
      wifi: rtw89: move HE radiotap to an individual function
      wifi: rtw89: fill VHT radiotap
      wifi: rtw89: fill HE-SU/HE-TB/HE-MU/HE-EXT_SU radiotap
      wifi: rtw89: debug: make implementation of beacon_info entry in order
      wifi: rtw89: add debugfs entry of monitor mode options to capture HE-MU packets
      wifi: rtw89: phy: check length before parsing PHY status IE
      wifi: rtw89: phy: skip trailing 8-byte zeros of PHY status IE for RTL8922D
      wifi: rtw89: phy: support PHY status IE-09 GEN2 for RTL8922D
      wifi: rtw89: check skb headroom before adding radiotap
      wifi: rtw89: phy: define BB wrap data for RTL8922D variants
      wifi: rtw89: phy: set BB wrap of out-of-band DPD
      wifi: rtw89: phy: set BB wrap of DPD by bandwidth
      wifi: rtw89: phy: set BB wrap of control options
      wifi: rtw89: phy: set BB wrap of QAM threshold
      wifi: rtw89: phy: set BB wrap of QAM options
      wifi: rtw89: phy: set BB wrap of trigger-base partial band
      wifi: rtw89: phy: set BB wrap of CIM3K
      wifi: rtw89: phy: change order to align register order
      wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
      wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant
      wifi: rtw89: pci: not disable PCI completion timeout control for a variant of RTL8922DE
      wifi: rtw89: pci: disable PCI PHY error flag 8
      wifi: rtw89: clear auto K delay value before downloading firmware
      wifi: rtw89: 8922d: change naming number and update values for WDE/PLE quota
      wifi: rtw89: mac: add field of release report size to DLE quota
      wifi: rtw89: mac: consolidate quota into a struct for variant chips
      wifi: rtw89: 8922d: add quota for RTL8922DE variant
      wifi: rtw89: 8922d: refactor digital power compensation to support new format
      wifi: rtw89: 8922d: support new digital power compensation format
      wifi: rtw89: fw: load TX compensation element by RFE type
      wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)

Piotr Kwapulinski (1):
      ixgbe: e610: remove redundant assignment

Po-Hao Huang (2):
      wifi: rtw89: 8852a: refine power save to lower latency
      wifi: rtw89: correct drop logic for malformed AMPDU frames

Pratham Gupta (1):
      netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump

Przemyslaw Korba (2):
      ice: dpll: Fix compilation warning
      idpf: add padding to PTP virtchnl structures

Qingfang Deng (6):
      ppp: add PPPOX symbol
      pppoe: optimize hash with word access
      selftests: net: test PPPoE packets in gro.sh
      selftests: net: add tests for PPPoL2TP
      selftests: net: add socat syslog for PPPoL2TP
      selftests: net: do not detect PPPoX loopback

Raf Dickson (5):
      vsock: use sk_acceptq_is_full() helper in all transports
      vsock: introduce vsock_pending_to_accept() helper
      vsock: fold sk_acceptq_added() into vsock_add_pending()
      vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
      vsock: fold sk_acceptq_removed() into vsock_remove_pending()

Rafael J. Wysocki (1):
      ptp: vmw: Drop ptp_vmw_acpi_device

Rajat Gupta (1):
      wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link

Ratheesh Kannoth (12):
      net/mlx5e: Reduce stack use reading PCIe congestion thresholds
      devlink: pass param values by pointer
      octeontx2-af: npc: Fix size of entry2cntr_map
      octeontx2-af: fix NPC mailbox codes in mbox.h
      octeontx2-af: enforce single RVU AF probe
      octeontx2-af: npc: cn20k: debugfs enhancements
      devlink: heap-allocate param fill buffers in devlink_nl_param_fill
      octeontx2-af: npc: cn20k: add subbank search order control
      octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
      octeontx2-af: npc: Support for custom KPU profile from filesystem
      octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc
      octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.

Ravindra (2):
      Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
      Bluetooth: btintel_pcie: Separate coredump work from RX work

Remy D. Farley (1):
      doc/netlink: rt-link: fix binary attributes marked as strings

Ripan Deuri (1):
      wifi: ath12k: fix error unwind on arch_init() failure in PCI probe

Robert Marko (3):
      net: phy: micrel: use dev_err_probe()
      dt-bindings: net: pse-pd: microchip,pd692x0: add port disable GPIO
      net: pse-pd: pd692x0: support disabling disable ports GPIO

Rong Zhang (1):
      Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925

Rosen Penev (29):
      wifi: ath9k: use non devm for nvmem_cell_get
      wifi: ath9k: owl: move name into owl_nvmem_probe
      wifi: ath9k: use kmemdup and kcalloc
      wifi: ath12k: use kzalloc_flex
      wifi: rt2x00: allocate anchor with rt2x00dev
      wifi: plfxlc: use module_usb_driver() macro
      smc: Use flexible array for SMCD connections
      net: ibm: emac: Use napi_gro_receive() for Rx packets
      net: ibm: emac: Reserve VLAN header in MJS limit
      wifi: ath11k: use kzalloc_flex for struct scan_req_params
      net: fec_mpc52xx_phy: Add missing MODULE_DESCRIPTION()
      net: fec_mpc52xx: add missing kernel-doc for @may_sleep
      net: b44: use ethtool_puts
      net: ibm: emac: fix unchecked platform_get_irq return value
      wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
      wifi: wcn36xx: allocate chan_surveys with main struct
      wifi: ath9k_htc: use module_usb_driver
      wifi: ath9k: Clear DMA descriptors without memset
      wifi: ath9k: remove TX99 power array zero init
      wifi: ath9k: remove disabling of bands
      wifi: ath9k_htc: allocate tx_buf and buf together
      netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
      net: ibm: emac: mal: fix unchecked platform_get_irq return values
      net: ibm: emac: Clear MAL descriptors without memset
      net: ibm: emac: mal: fix potential system hang in mal_remove()
      wifi: mt76: fix of_get_mac_address error handling
      wifi: brcm80211: change current_bss to value
      wifi: brcmfmac: flowring: simplify flow allocation
      net: dsa: hellcreek: replace kcalloc with struct_size

Runyu Xiao (6):
      wifi: qtnfmac: topaz: defer IRQ enabling until IPC init
      ipv6: use READ_ONCE() for bindv6only default in inet6_create()
      ipv6: use READ_ONCE() in ipv6_flowlabel_get()
      kcm: use WRITE_ONCE() when changing lower socket callbacks
      octeontx2-pf: clear stale mailbox IRQ state before request_irq()
      octeontx2-vf: clear stale mailbox IRQ state before request_irq()

Ruoyu Wang (1):
      net: wwan: t7xx: check skb_clone in control TX

Ryder Lee (5):
      wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO for mt7996
      wifi: mt76: mt7915: fix potential tx_retries underflow
      wifi: mt76: mt7921: fix potential tx_retries underflow
      wifi: mt76: mt7925: fix potential tx_retries underflow
      wifi: mt76: mt7996: fix potential tx_retries underflow

Sabrina Dubroca (2):
      tls: remove tls_toe and the related driver
      net: remove some unused EXPORT_SYMBOL()s

Saeed Mahameed (1):
      devlink: Implement devlink param multi attribute nested data values

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant

Sajal Gupta (1):
      net: usb: pegasus: replace simple_strtoul with kstrtouint

Samuel Moelius (5):
      Bluetooth: hci: validate codec capability element length
      Bluetooth: L2CAP: validate connectionless PSM length
      Bluetooth: vhci: validate devcoredump state before side effects
      net: pfcp: allocate per-cpu tstats for PFCP netdevs
      net/sched: act_pedit: require matching IPv4 L4 protocol

Sean Wang (22):
      wifi: mt76: connac: replace is_mt7925() with is_connac3()
      wifi: mt76: mt7925: use link-specific removal for non-MLD STA
      wifi: mt76: connac: tolerate inactive BSS deactivation
      wifi: mt76: mt792x: add MT7927 WFSYS reset support
      wifi: mt76: mt792x: factor out common DMA queue allocation
      wifi: mt76: mt7925: switch DMA init to common mt792x queue helpers
      wifi: mt76: mt792x: add MT7927-specific PCIe DMA support
      wifi: mt76: mt7925: sync MT7927 BSS band assignment
      wifi: mt76: mt7925: add MBMC event handling
      wifi: mt76: mt792x: enable CNM ops for MT7927
      wifi: mt76: mt7925: add MT7927 PCIe support
      wifi: mt76: mt7925: add MT7927 USB support
      wifi: mt76: mt7925: keep TX BA state in the primary WCID
      wifi: mt76: mt7925: pass WCID explicitly to mt7925_mcu_sta_ba()
      wifi: mt76: mt7925: program BA state on active links
      wifi: mt76: mt792x: skip MLD header rewrite for 802.3 encap TX
      wifi: mt76: mt7921u: add MT7902 USB support
      wifi: mt76: connac: use a helper to cache txpower_cur
      wifi: mt76: connac: factor out rate power limit calculation
      wifi: mt76: mt792x: report txpower for the requested vif link
      wifi: mt76: mt792x: add common USB transport reset helpers
      wifi: mt76: mt7921u: escalate broken USB transport to device reset

Sechang Lim (1):
      tcp: clear sock_ops cb flags before force-closing a child socket

Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      net: ethernet: oa_tc6: mdiobus->parent initialized with NULL
      net: ethernet: oa_tc6: Remove FCS size in RX frame
      dt-bindings: net: updated interrupt type to be active low, level triggered

Sergey Senozhatsky (1):
      Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()

Sergey Shtylyov (1):
      Bluetooth: hci_h5: reset hci_uart::priv in the close() method

Shahar Tzarfati (6):
      wifi: iwlwifi: mld: expose beacon avg signal
      wifi: iwlwifi: Add names for Killer BE1735x and BE1730x
      wifi: iwlwifi: cfg: Revert "wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file"
      wifi: iwlwifi: remove orphaned DC2DC config enum
      wifi: iwlwifi: stop supporting core101
      wifi: iwlwifi: mld: drop TLC config cmd v4/v5 compat code

Shaoxu Liu (2):
      rndis_host: add Telit LE310X1 RNDIS USB ID
      rndis_host: enable power management for Telit LE310X1

Shay Drory (29):
      net/mlx5: LAG, factor out shared FDB code into dedicated file
      net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy transition
      net/mlx5: E-Switch, move devcom init from TC to eswitch layer
      net/mlx5: LAG, replace peer count check with direct peer lookup
      net/mlx5: LAG, prepare for SD device integration
      net/mlx5: LAG, extend shared FDB API with group_id filter
      net/mlx5: SD, introduce Socket Direct LAG
      net/mlx5: LAG, block RoCE and VF LAG for SD devices
      net/mlx5: LAG, block multipath LAG for SD devices
      net/mlx5: SD, keep netdev resources on same PF in switchdev mode
      net/mlx5e: TC, track peer flow slots with bitmap
      net/mlx5e: TC, enable steering for SD LAG
      net/mlx5e: Verify unique vhca_id count instead of range
      net/mlx5: Add sd_group_size bits for SD management
      net/mlx5: E-Switch, skip uplink IB rep load for SD secondary devices
      net/mlx5: devcom, expose locked variant of send_event
      net/mlx5: devcom, add DEVCOM_CANT_FAIL for non-rollback events
      net/mlx5: SD, make primary/secondary role determination more robust
      net/mlx5: SD, add L2 table silent mode query support
      net/mlx5: SD, expend vport metadata for SD secondary devices
      net/mlx5: SD, support switchdev mode transition with shared FDB
      net/mlx5: E-Switch, notify SD on eswitch disable
      net/mlx5: LAG, store demux resources per master lag_func
      net/mlx5: LAG, disable both regular and SD LAG on lag_disable_change
      net/mlx5: LAG, introduce software vport LAG implementation
      net/mlx5: LAG, add MPESW over SD LAG support
      net/mlx5: E-Switch, Tie rep load/unload to SD LAG state
      net/mlx5: SD, defer vport metadata init until SD is ready
      net/mlx5: SD, enable SD over ECPF and allow switchdev transition

Shin-Yi Lin (1):
      wifi: rtw89: Correct data type for scan index to avoid infinite loop

Simon Schippers (4):
      tun/tap: add ptr_ring consume helper with netdev queue wakeup
      vhost-net: wake queue of tun/tap after ptr_ring consume
      ptr_ring: move free-space check into separate helper
      tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present

Stanislav Fomichev (3):
      net: change ndo_set_rx_mode_async return type to int
      net: add retry mechanism to ndo_set_rx_mode_async
      bnxt: convert to core rx_mode retry mechanism

Stefan Wahren (2):
      net: phy: dp83822: Improve readability in dp8382x_probe
      net: phy: dp83822: Add optional external PHY clock

Stefano Garzarella (1):
      Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"

Steffen Klassert (1):
      Merge branch 'xfrm: XFRM_MSG_MIGRATE_STATE new netlink message'

Stepan Ionichev (1):
      wifi: wcn36xx: fix spelling mistakes in dxe header comment

Stephen Hemminger (5):
      net/sched: netem: reorder struct netem_sched_data
      net/sched: netem: remove useless VERSION
      net/sched: netem: replace pr_info with netlink extack error messages
      net/sched: netem: handle multi-segment skb in corruption
      net/sched: netem: add per-impairment extended statistics

Sukhdeep Singh (12):
      net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
      net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
      net: atlantic: decouple aq_set_data_fl3l4() from driver internals
      net: atlantic: add AQC113 hardware register definitions and accessors
      net: atlantic: add AQC113 filter data structures, firmware query and register dump
      net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address
      net: atlantic: implement AQC113 L2/L3/L4 RX filter ops
      net: atlantic: add AQC113 PTP traffic class and TX path setup
      net: atlantic: extend hw_ops and TX descriptor for AQC113 PTP
      net: atlantic: add AQC113 PTP hardware ops in hw_atl2
      net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
      net: atlantic: add AQC113 PTP support in aq_ptp and driver core

Suraj Gupta (1):
      net: axienet: Use dedicated ethtool_ops for the dmaengine path

Sven Eckelmann (41):
      batman-adv: drop batman-adv specific version
      MAINTAINERS: Rename batman-adv T(ree)
      MAINTAINERS: Don't send batman-adv patches to netdev
      batman-adv: add missing includes
      batman-adv: use atomic_xchg() for gw.reselect check
      batman-adv: extract netdev wifi detection information object
      batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
      batman-adv: tt: replace open-coded overflow check with helper
      batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
      batman-adv: use neigh_node's orig_node only as id
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: initialize dec_cwnd explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      batman-adv: tp_meter: fix fast recovery precondition
      batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
      batman-adv: tp_meter: add only finished tp_vars to lists
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: use locking for all congestion control variables
      batman-adv: tp_meter: consolidate congestion control variables
      batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
      batman-adv: prevent ELP transmission interval underflow
      batman-adv: tt: sync local and global tvlv preparation return values
      batman-adv: tt: directly retrieve wifi flags of net_device
      batman-adv: tp_meter: initialize last_recv_time during init
      batman-adv: convert cancellation of work items to disable helper
      batman-adv: drop duplicated wifi_flags assignments
      batman-adv: use GFP_KERNEL allocations for the wifi detection cache
      batman-adv: document cleanup of batadv_wifi_net_devices entries
      batman-adv: correct batadv_wifi_* kernel-doc
      batman-adv: tp_meter: update stale kernel-doc after refactoring
      batman-adv: bla: update stale kernel-doc
      batman-adv: uapi: keep kernel-doc in struct member order
      batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
      batman-adv: fix kernel-doc typos and grammar errors

Tamizh Chelvam Raja (10):
      wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type in Rx path
      wifi: ath12k: Set WDS vdev parameter for 4-address station interface
      wifi: ath12k: Add support for 4-address mode
      wifi: ath12k: Add 4-address mode support for eth offload
      wifi: ath12k: Add support for 4-address NULL frame handling
      wifi: ath12k: Add support for 4-address frame notification
      wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
      wifi: mac80211: Add sta pointer sanity check in ieee80211_8023_xmit()
      wifi: mac80211: Add multicast to unicast support for 802.3 path
      wifi: mac80211: Add 802.3 multicast encapsulation offload support

Tao Cui (1):
      net: ethtool: fix missing closing paren in rings_reply_size()

Tariq Toukan (2):
      net/mlx5e: Reduce branches in napi poll
      net/mlx5e: Let kTLS RX get async ICOSQ param in napi poll

Thiyagarajan Pandiyan (1):
      wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications

Thomas Richard (1):
      dt-bindings: net: microchip: Add LAN7500 and LAN7505 devices

Thorsten Blum (3):
      net/dns_resolver: consolidate namelen checks in dns_query
      wifi: cfg80211: use strscpy in cfg80211_wext_giwname
      net/dns_resolver: use kasprintf + kmemdup_nul to simplify dns_query

Tim Bird (3):
      llc: Add SPDX id lines to some llc source files
      llc: Add SPDX id lines to llc header files
      Bluetooth: Add SPDX id lines to some source files

Tristan Madani (6):
      wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
      wifi: rtw89: add bounds check on firmware mac_id in link lookup
      wifi: ath9k: fix OOB access from firmware tx status queue ID
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      wifi: wcn36xx: fix OOB read from short trigger BA firmware response

Tushar Vyavahare (4):
      selftests/xsk: Introduce helpers for setting UMEM properties
      selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
      selftests/xsk: Use umem_size() helper consistently
      selftests/xsk: Introduce mmap_size in umem struct

Ujjal Roy (5):
      ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
      ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
      ipv4: igmp: encode multicast exponential fields
      ipv6: mld: encode multicast exponential fields
      selftests: net: bridge: add MRC and QQIC field encoding tests

Uwe Kleine-König (The Capable Hub) (12):
      atm: solos-pci: Simplify initialisation of pci_device_id array
      net: nfp: Drop PCI class entries with .class_mask = 0
      net: Consistently define pci_device_ids using named initializers
      mlxsw: minimal: Use named initializers for struct i2c_device_id
      mctp: i2c: Use named initializers for struct i2c_device_id
      net: dsa: Use named initializers for struct i2c_device_id
      dpll: zl3073x: Use named initializers for struct i2c_device_id
      net: pse-pd: Use named initializers for arrays of i2c_device_data
      s390/ism: Drop superfluous zeros in pci_device_id array
      net: Use named initializer for zorro_device_id arrays
      nfc: Use named initializers for struct i2c_device_id
      ethernet: 3c509: Improve style of pnp_device_id array terminator

Vadim Fedorenko (2):
      pps: bump PPS device count
      ptp: ocp: add shutdown callback

Vaibhav Gupta (1):
      gve: Use generic power management

Victor Nogueira (11):
      selftests/tc-testing: Add support for ifb devices
      selftests/tc-testing: Adapt idempotent qdisc notify callback tests to recent fq_codel changes
      net/sched: Update function name in TCQ_F_NOPARENT comment
      net/sched: sch_hfsc: Don't make class passive twice
      selftests: tc: act_pedit: require matching IPv4 L4 protocol
      net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
      selftests/tc-testing: Verify child qdisc will not mistakenly deactivate QFQ parent
      net/sched: sch_dualpi2: Add missing module alias
      selftests/tc-testing: Verify IFE can handle truncated inner Ethernet header

Vladimir Oltean (18):
      net: dsa: microchip: move KSZ8 ksz_dev_ops to ksz8.c
      net: dsa: microchip: move KSZ9477 and LAN937 ksz_dev_ops to individual drivers
      net: dsa: microchip: move phylink_mac_ops to individual drivers
      net: dsa: microchip: ensure each ksz_dev_ops has its own dsa_switch_ops
      net: dsa: microchip: hook up ksz_switch_alloc() to chip-specific dsa_switch_ops
      net: dsa: microchip: split ksz_get_tag_protocol()
      net: dsa: microchip: bypass dev_ops for FDB ageing operations
      net: dsa: microchip: bypass dev_ops for change_mtu() operation
      net: dsa: microchip: bypass dev_ops for VLAN operations
      net: dsa: microchip: bypass dev_ops for FDB and MDB operations
      net: dsa: microchip: bypass dev_ops for mirror operations
      net: dsa: microchip: bypass dev_ops for phylink_get_caps()
      net: dsa: microchip: don't reset on shutdown or driver removal
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
      net: dsa: microchip: remove dev_ops->setup() and teardown()
      net: dsa: microchip: remove VLAN operations for ksz8463

Wayen.Yan (7):
      net: airoha: Fix error handling in airoha_ppe_flush_sram_entries()
      net: airoha: Fix register index for Tx-fwd counter configuration
      net: airoha: Fix debugfs new-tuple display for IPv4 ROUTE entries
      net: airoha: Fix non-standard return value in airoha_ppe_get_wdma_info()
      net: airoha: Fix always-true condition in PPE1 queue reservation loop
      net: airoha: Fix typos in comments and Kconfig
      net: airoha: Fix MODULE_LICENSE to match SPDX GPL-2.0-only identifier

Wei Fang (37):
      dt-bindings: net: dsa: update the description of 'dsa,member' property
      dt-bindings: net: dsa: add NETC switch
      net: enetc: add pre-boot initialization for i.MX94 switch
      net: enetc: add basic operations to the FDB table
      net: enetc: add support for the "Add" operation to VLAN filter table
      net: enetc: add support for the "Update" operation to buffer pool table
      net: enetc: add support for "Add" and "Delete" operations to IPFT
      net: enetc: add multiple command BD rings support
      net: dsa: add NETC switch tag support
      net: dsa: netc: introduce NXP NETC switch driver for i.MX94
      net: dsa: netc: add phylink MAC operations
      net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
      net: dsa: netc: initialize buffer pool table and implement flow-control
      net: dsa: netc: add support for the standardized counters
      net: dsa: netc: add support for ethtool private statistics
      net: enetc: use enetc_set_si_hw_addr() for setting MAC address
      net: enetc: move VF message handlers to enetc_msg.c
      net: enetc: relocate SR-IOV configuration helper for common PF support
      net: enetc: integrate enetc_msg.c into enetc-pf-common driver
      net: enetc: use read_poll_timeout() for VF mailbox polling
      net: enetc: convert mailbox messages to new formats
      net: enetc: add VF-PF messaging support for IP minor revision query
      net: enetc: align v1 CBDR API with v4 for VF driver sharing
      net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF support
      net: enetc: add generic helper to initialize SR-IOV resources
      net: enetc: use MADDR_TYPE for MAC filter array size
      net: enetc: dynamically allocate rxmsg based on VF count
      net: dsa: netc: fix unmet Kconfig dependencies for NET_DSA_NETC_SWITCH
      net: enetc: add interfaces to manage dynamic FDB entries
      net: enetc: add "Update" and "Delete" operations to VLAN filter table
      net: enetc: add interfaces to manage egress treatment table
      net: enetc: add "Update" operation to the egress count table
      net: dsa: netc: initialize the group bitmap of ETT and ECT
      net: enetc: add helpers to set/clear table bitmap
      net: dsa: netc: add VLAN filter table and egress treatment management
      net: dsa: netc: add bridge mode support
      net: dsa: netc: implement dynamic FDB entry ageing

Wei Qisen (1):
      net: sfp: add quirk for OEM 2.5G optical modules

Wei Wang (10):
      psp: add admin/non-admin version of psp_device_get_locked
      psp: add new netlink cmd for dev-assoc and dev-disassoc
      psp: add a new netdev event for dev unregister
      selftests/net: psp: refactor test builders to use ksft_variants
      selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
      selftests/net: rename _nk_host_ifname to nk_host_ifname
      selftests/net: psp: support PSP in NetDrvContEnv infrastructure
      selftests/net: psp: add dev-assoc data path test
      selftests/net: psp: add cross-namespace notification tests
      selftests/net: psp: add dev-get, no-nsid, and cleanup tests

Wei Zhang (4):
      wifi: ath11k: cancel SSR work items during PCI shutdown
      wifi: ath11k: raise max vdevs to 4 on hardware with P2P and dual-station support
      wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
      wifi: ath12k: fix NULL deref in change_sta_links for unready link

Weiming Shi (1):
      Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

Wen Gong (1):
      wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported

Wentao Guan (1):
      net: ethernet: mtk_wed: debugfs: correct index in wed_amsdu_show()

Wentao Liang (3):
      net: qrtr: fix node refcount leak on ctrl packet alloc failure
      mlxsw: fix refcount leak in mlxsw_sp_port_lag_join()
      mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()

Willem de Bruijn (8):
      selftests: net: py: support cmd verifying expected failure
      selftests: net: py: add tc utility
      selftests: drv-net: convert so_txtime to drv-net
      selftests: drv-net: cope with slow env in so_txtime.py test
      net: sch_fq: update flow delivery time on earlier EDT packet
      net: ensure SCM_TXTIME delivery time is no older than system boot
      net_sched: sch_fq: convert skb->tstamp if not monotonic
      selftests: drv-net: extend so_txtime with FQ with other clocks

William Theesfeld (1):
      net/mlx5: convert miss_list allocation to kvmalloc_array()

Xiang Mei (1):
      bridge: cfm: reject invalid CCM interval at configuration time

Xin Long (1):
      sctp: validate embedded address parameter length

Xiuzhuo Shang (1):
      Bluetooth: qca: Add BT FW build version to kernel log

Xuan Zhuo (9):
      eea: introduce PCI framework
      eea: introduce ring and descriptor structures
      eea: probe the netdevice and create adminq
      eea: create/destroy rx,tx queues for netdevice open and stop
      eea: implement packet receive logic
      eea: implement packet transmit logic
      eea: introduce ethtool support
      eea: introduce callback for ndo_get_stats64 and register netdev
      net: remove SIOCSHWTSTAMP and SIOCGHWTSTAMP from ndo_eth_ioctl comment

Yael Chemla (5):
      net/mlx5e: remove channel count limit for XOR8 RSS hash
      net/mlx5e: advertise max RSS indirection table size to ethtool
      net/mlx5e: resize non-default RSS indirection tables on channel change
      net/mlx5e: resize configured default RSS context table on channel change
      net/mlx5e: increase RSS indirection table spread factor

Yevgeny Kliteynik (3):
      net/mlx5: HWS, Check if device is down while polling for completion
      net/mlx5: HWS, Handle destroying table that has a miss table
      net/mlx5: DR, Remove unused field of struct mlx5dr_matcher_rx_tx

Yiming Qian (1):
      net: skmsg: preserve sg.copy across SG transforms

Yingying Tang (1):
      wifi: ath12k: add channel 177 to the 5 GHz channel list

Yizhou Zhao (2):
      fddi: validate skb length before parsing headers
      6lowpan: fix NHC entry use-after-free on error path

Yong Wang (1):
      net: ife: require ETH_HLEN to be pullable in ife_decode()

Yuho Choi (1):
      sctp: Unwind address notifier registration on failure

Yuqi Xu (1):
      wifi: cfg80211: reject duplicate wiphy cipher suite entries

Yury Norov (1):
      net: hsr: simplify fill_last_seq_nrs()

Yuyang Huang (6):
      ipv4: igmp: annotate data-races around im->users
      ipv6: mcast: annotate data-races around mca_users
      ipv4: igmp: annotate data-races around in_dev->mc_count
      ipv4: igmp: annotate data-races around timer-related fields
      ipv6: mcast: annotate data-races around mca_flags
      ipv6: mcast: annotate igmp6 timer expiry race

Zenm Chen (2):
      wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S
      Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB

Zhao Dongdong (2):
      net: page_pool: silence static analysis warnings in page_pool_nl_stats_fill()
      Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path

Zhengchuan Liang (1):
      net: atm: reject out-of-range traffic classes in QoS validation

Zhi-Jun You (1):
      net: ethernet: mtk_wed: fix loading WO firmware for MT7986

Zijing Yin (1):
      netdevsim: fib: fix use-after-free of FIB data via debugfs

Zijun Hu (2):
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device
      Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

Zong-Zhe Yang (10):
      wifi: rtw89: 8852bt: configure support_noise field explicitly
      wifi: rtw89: chan: introduce new helper to get entity current configuration
      wifi: rtw89: 8922d: update RF calibration flow for MLD
      wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
      wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C command
      wifi: rtw89: fw: dump status of H2C command and C2H event for SER
      wifi: rtw89: fw: load TX power track element according to AID
      wifi: rtw89: Wi-Fi 7 configure TX power limit for large MRU
      wifi: rtw89: debug: show large MRU in txpwr_table dbgfs
      wifi: rtw89: 8922d: configure TX shape settings

chunzhi.lin (2):
      net: phy: motorcomm: use device properties for firmware tuning
      docs: acpi: dsd: add Motorcomm yt8xxx PHY properties

longlong yan (1):
      selftests/net: bind_bhash: fix memory leak in bind_socket

luke-yj.chen (1):
      Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609

pengdonglin (1):
      wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock

yuan.gao (1):
      inet: frags: remove redundant assignment in inet_frag_reasm_prepare()

傅继晗 (1):
      wifi: mac80211: fix monitor mode frame capture for real chanctx drivers

 .mailmap                                           |    1 +
 .../ABI/testing/sysfs-class-ieee80211-rtw89        |   24 +
 Documentation/admin-guide/kernel-parameters.txt    |   20 +-
 Documentation/admin-guide/sysctl/net.rst           |   46 +-
 Documentation/arch/m68k/kernel-options.rst         |   24 +-
 .../devicetree/bindings/net/airoha,an8801.yaml     |  120 +
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   56 +-
 Documentation/devicetree/bindings/net/dsa/dsa.txt  |    4 -
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |    6 +-
 .../devicetree/bindings/net/dsa/lan9303.txt        |  100 -
 .../bindings/net/dsa/nxp,netc-switch.yaml          |  131 +
 .../devicetree/bindings/net/dsa/smsc,lan9303.yaml  |  123 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |    9 +-
 Documentation/devicetree/bindings/net/mdio.txt     |    1 -
 .../devicetree/bindings/net/microchip,lan8650.yaml |    2 +-
 .../devicetree/bindings/net/microchip,lan95xx.yaml |    2 +
 .../bindings/net/microchip,lan966x-switch.yaml     |   10 +-
 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |    4 +
 .../devicetree/bindings/net/qca,ar803x.yaml        |   19 +
 .../bindings/net/realtek,rtl9301-mdio.yaml         |    9 +-
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   31 +-
 .../bindings/net/wireless/st,stlc4560.yaml         |   61 +
 Documentation/driver-api/dpll.rst                  |   58 +-
 .../acpi/dsd/motorcomm-yt8xxx-phy.rst              |  107 +
 Documentation/firmware-guide/acpi/index.rst        |    1 +
 Documentation/netlink/specs/devlink.yaml           |    4 +
 Documentation/netlink/specs/dpll.yaml              |   62 +-
 Documentation/netlink/specs/handshake.yaml         |    1 +
 Documentation/netlink/specs/netdev.yaml            |   17 +-
 Documentation/netlink/specs/ovs_packet.yaml        |  130 +
 Documentation/netlink/specs/psp.yaml               |   73 +-
 Documentation/netlink/specs/rt-link.yaml           |   28 +-
 Documentation/networking/arcnet-hardware.rst       | 2979 +-------------------
 Documentation/networking/arcnet.rst                |  235 +-
 Documentation/networking/bonding.rst               |   23 +
 Documentation/networking/checksum-offloads.rst     |   67 +-
 .../device_drivers/ethernet/cirrus/cs89x0.rst      |  647 -----
 .../networking/device_drivers/ethernet/index.rst   |    1 -
 .../networking/devlink/devlink-health.rst          |   12 +-
 .../networking/devlink/devlink-params.rst          |    2 +-
 Documentation/networking/devlink/devlink-port.rst  |    5 +-
 Documentation/networking/devlink/devlink-trap.rst  |    8 +-
 Documentation/networking/devlink/index.rst         |   10 +-
 Documentation/networking/devlink/stmmac.rst        |    2 +-
 Documentation/networking/devmem.rst                |   27 +-
 Documentation/networking/driver.rst                |   20 +-
 Documentation/networking/dsa/dsa.rst               |    2 +-
 Documentation/networking/dsa/lan9303.rst           |    2 +-
 Documentation/networking/ip-sysctl.rst             |    8 +-
 Documentation/networking/ipvs-sysctl.rst           |   44 +
 Documentation/networking/mptcp-sysctl.rst          |   13 +
 Documentation/networking/napi.rst                  |   11 +-
 .../networking/net_cachelines/net_device.rst       |    4 +-
 .../networking/net_cachelines/tcp_sock.rst         |   10 +-
 Documentation/networking/netdev-features.rst       |   65 +-
 Documentation/networking/netdevices.rst            |   49 +-
 Documentation/networking/netmem.rst                |    8 +-
 Documentation/networking/page_pool.rst             |   60 +-
 Documentation/networking/segmentation-offloads.rst |   37 +-
 Documentation/networking/skbuff.rst                |    6 -
 Documentation/networking/smc-sysctl.rst            |    8 +-
 Documentation/networking/statistics.rst            |   19 +-
 Documentation/networking/strparser.rst             |   22 +-
 Documentation/networking/tcp_ao.rst                |   38 +-
 Documentation/networking/tls-offload.rst           |   52 +-
 Documentation/networking/xdp-rx-metadata.rst       |    2 +-
 Documentation/networking/xfrm/index.rst            |    1 +
 .../networking/xfrm/xfrm_migrate_state.rst         |  274 ++
 Documentation/networking/xsk-tx-metadata.rst       |   30 +-
 .../translations/zh_CN/networking/netmem.rst       |    7 +-
 Documentation/userspace-api/netlink/intro.rst      |    4 +-
 MAINTAINERS                                        |   34 +-
 arch/arm/boot/dts/ti/omap/omap2.dtsi               |    4 +
 .../arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi |   12 +
 arch/arm/configs/am200epdkit_defconfig             |    1 -
 arch/arm/configs/dove_defconfig                    |    1 -
 arch/arm/configs/ixp4xx_defconfig                  |    1 -
 arch/arm/configs/multi_v5_defconfig                |    1 -
 arch/arm/configs/mv78xx0_defconfig                 |    1 -
 arch/arm/configs/mvebu_v5_defconfig                |    1 -
 arch/arm/configs/omap1_defconfig                   |    1 -
 arch/arm/configs/orion5x_defconfig                 |    1 -
 arch/arm/configs/pxa_defconfig                     |    5 -
 arch/arm/configs/spitz_defconfig                   |    3 -
 arch/arm/configs/wpcm450_defconfig                 |    1 -
 arch/arm/mach-omap2/board-n8x0.c                   |   18 -
 arch/loongarch/configs/loongson32_defconfig        |    3 -
 arch/loongarch/configs/loongson64_defconfig        |    3 -
 arch/m68k/configs/amiga_defconfig                  |    3 -
 arch/m68k/configs/apollo_defconfig                 |    3 -
 arch/m68k/configs/atari_defconfig                  |    3 -
 arch/m68k/configs/bvme6000_defconfig               |    3 -
 arch/m68k/configs/hp300_defconfig                  |    3 -
 arch/m68k/configs/mac_defconfig                    |    3 -
 arch/m68k/configs/multi_defconfig                  |    3 -
 arch/m68k/configs/mvme147_defconfig                |    3 -
 arch/m68k/configs/mvme16x_defconfig                |    3 -
 arch/m68k/configs/q40_defconfig                    |    3 -
 arch/m68k/configs/sun3_defconfig                   |    3 -
 arch/m68k/configs/sun3x_defconfig                  |    3 -
 arch/mips/configs/bigsur_defconfig                 |    2 -
 arch/mips/configs/decstation_64_defconfig          |    2 -
 arch/mips/configs/decstation_defconfig             |    2 -
 arch/mips/configs/decstation_r4k_defconfig         |    2 -
 arch/mips/configs/fuloong2e_defconfig              |    1 -
 arch/mips/configs/gpr_defconfig                    |    2 -
 arch/mips/configs/ip22_defconfig                   |    2 -
 arch/mips/configs/ip27_defconfig                   |    2 -
 arch/mips/configs/ip30_defconfig                   |    2 -
 arch/mips/configs/ip32_defconfig                   |    2 -
 arch/mips/configs/lemote2f_defconfig               |    2 -
 arch/mips/configs/malta_defconfig                  |    3 -
 arch/mips/configs/malta_kvm_defconfig              |    3 -
 arch/mips/configs/malta_qemu_32r6_defconfig        |    2 -
 arch/mips/configs/maltaaprp_defconfig              |    2 -
 arch/mips/configs/maltasmvp_defconfig              |    2 -
 arch/mips/configs/maltasmvp_eva_defconfig          |    2 -
 arch/mips/configs/maltaup_defconfig                |    2 -
 arch/mips/configs/maltaup_xpa_defconfig            |    3 -
 arch/mips/configs/mtx1_defconfig                   |    9 -
 arch/mips/configs/rm200_defconfig                  |    2 -
 arch/mips/configs/sb1250_swarm_defconfig           |    2 -
 arch/parisc/configs/generic-64bit_defconfig        |    2 -
 arch/powerpc/configs/44x/akebono_defconfig         |    1 -
 arch/powerpc/configs/44x/bamboo_defconfig          |    1 -
 arch/powerpc/configs/44x/currituck_defconfig       |    1 -
 arch/powerpc/configs/44x/ebony_defconfig           |    1 -
 arch/powerpc/configs/44x/eiger_defconfig           |    1 -
 arch/powerpc/configs/44x/fsp2_defconfig            |    1 -
 arch/powerpc/configs/44x/icon_defconfig            |    1 -
 arch/powerpc/configs/44x/iss476-smp_defconfig      |    1 -
 arch/powerpc/configs/44x/katmai_defconfig          |    1 -
 arch/powerpc/configs/44x/rainier_defconfig         |    1 -
 arch/powerpc/configs/44x/redwood_defconfig         |    1 -
 arch/powerpc/configs/44x/sequoia_defconfig         |    1 -
 arch/powerpc/configs/44x/taishan_defconfig         |    1 -
 arch/powerpc/configs/52xx/cm5200_defconfig         |    1 -
 arch/powerpc/configs/52xx/motionpro_defconfig      |    1 -
 arch/powerpc/configs/52xx/tqm5200_defconfig        |    1 -
 arch/powerpc/configs/83xx/asp8347_defconfig        |    1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |    1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig    |    1 -
 arch/powerpc/configs/amigaone_defconfig            |    1 -
 arch/powerpc/configs/cell_defconfig                |    1 -
 arch/powerpc/configs/chrp32_defconfig              |    1 -
 arch/powerpc/configs/ep8248e_defconfig             |    1 -
 arch/powerpc/configs/fsl-emb-nonhw.config          |    1 -
 arch/powerpc/configs/g5_defconfig                  |    1 -
 arch/powerpc/configs/linkstation_defconfig         |    1 -
 arch/powerpc/configs/mgcoge_defconfig              |    1 -
 arch/powerpc/configs/mpc83xx_defconfig             |    1 -
 arch/powerpc/configs/mvme5100_defconfig            |    1 -
 arch/powerpc/configs/pmac32_defconfig              |    1 -
 arch/powerpc/configs/powernv_defconfig             |    1 -
 arch/powerpc/configs/ppc44x_defconfig              |    1 -
 arch/powerpc/configs/ppc64_defconfig               |    1 -
 arch/powerpc/configs/ppc64e_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    6 -
 arch/powerpc/configs/ps3_defconfig                 |    1 -
 arch/s390/configs/debug_defconfig                  |    3 -
 arch/s390/configs/defconfig                        |    3 -
 arch/sh/configs/hp6xx_defconfig                    |    1 -
 arch/sh/configs/landisk_defconfig                  |    1 -
 arch/sh/configs/r7780mp_defconfig                  |    1 -
 arch/sh/configs/r7785rp_defconfig                  |    1 -
 arch/sh/configs/se7712_defconfig                   |    1 -
 arch/sh/configs/sh2007_defconfig                   |    2 -
 arch/sparc/configs/sparc32_defconfig               |    1 -
 arch/sparc/configs/sparc64_defconfig               |    2 -
 crypto/Kconfig                                     |   18 -
 crypto/Makefile                                    |    2 -
 crypto/ahash.c                                     |   70 -
 crypto/api.c                                       |   76 +-
 crypto/cipher.c                                    |   28 -
 crypto/cmac.c                                      |   16 -
 crypto/cryptd.c                                    |   16 -
 crypto/hmac.c                                      |   31 -
 crypto/internal.h                                  |   10 -
 crypto/pcbc.c                                      |  195 --
 crypto/shash.c                                     |   37 -
 crypto/tcrypt.c                                    |    4 -
 crypto/testmgr.c                                   |   15 -
 crypto/testmgr.h                                   |   45 -
 drivers/atm/solos-pci.c                            |    8 +-
 drivers/bluetooth/Kconfig                          |   42 +-
 drivers/bluetooth/Makefile                         |    3 -
 drivers/bluetooth/bluecard_cs.c                    |  908 ------
 drivers/bluetooth/bt3c_cs.c                        |  749 -----
 drivers/bluetooth/btintel.c                        |   10 +-
 drivers/bluetooth/btintel.h                        |    9 +
 drivers/bluetooth/btintel_pcie.c                   |  502 +++-
 drivers/bluetooth/btintel_pcie.h                   |   26 +-
 drivers/bluetooth/btmtk.c                          |   39 +-
 drivers/bluetooth/btmtk.h                          |    7 +
 drivers/bluetooth/btmtksdio.c                      |    2 +-
 drivers/bluetooth/btqca.c                          |    2 +
 drivers/bluetooth/btrsi.c                          |   12 +-
 drivers/bluetooth/btrtl.c                          |   13 +
 drivers/bluetooth/btusb.c                          |   94 +-
 drivers/bluetooth/dtl1_cs.c                        |  614 ----
 drivers/bluetooth/hci_h5.c                         |    1 +
 drivers/bluetooth/hci_qca.c                        |   11 +-
 drivers/bluetooth/hci_vhci.c                       |   10 +
 drivers/dibs/Kconfig                               |   10 +-
 drivers/dpll/dpll_core.c                           |   51 +-
 drivers/dpll/dpll_core.h                           |    5 +-
 drivers/dpll/dpll_netlink.c                        |   94 +-
 drivers/dpll/dpll_netlink.h                        |    4 +-
 drivers/dpll/dpll_nl.c                             |    7 +-
 drivers/dpll/dpll_nl.h                             |    2 +-
 drivers/dpll/zl3073x/chan.c                        |   31 +-
 drivers/dpll/zl3073x/chan.h                        |   14 +
 drivers/dpll/zl3073x/core.c                        |   45 -
 drivers/dpll/zl3073x/devlink.c                     |    6 +-
 drivers/dpll/zl3073x/dpll.c                        |  148 +-
 drivers/dpll/zl3073x/i2c.c                         |   10 +-
 drivers/dpll/zl3073x/ref.h                         |   14 -
 drivers/dpll/zl3073x/regs.h                        |   24 +-
 drivers/gpio/gpio-ath79.c                          |   57 +-
 drivers/infiniband/hw/mana/main.c                  |   85 +-
 drivers/infiniband/hw/mana/mana_ib.h               |   14 +
 drivers/infiniband/hw/mana/qp.c                    |   68 +-
 drivers/infiniband/hw/mlx5/counters.c              |    4 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |    6 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    6 +-
 drivers/infiniband/sw/rxe/rxe_ns.c                 |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    9 +-
 drivers/leds/trigger/ledtrig-netdev.c              |   37 +-
 drivers/net/Kconfig                                |    7 -
 drivers/net/Makefile                               |    1 -
 drivers/net/Space.c                                |  237 --
 drivers/net/amt.c                                  |   80 +-
 drivers/net/arcnet/Kconfig                         |   52 +-
 drivers/net/arcnet/Makefile                        |    5 -
 drivers/net/arcnet/arc-rimi.c                      |  386 ---
 drivers/net/arcnet/arcdevice.h                     |   36 +-
 drivers/net/arcnet/com20020-isa.c                  |  230 --
 drivers/net/arcnet/com20020-pci.c                  |  251 +-
 drivers/net/arcnet/com20020.c                      |  107 +-
 drivers/net/arcnet/com20020.h                      |    6 +-
 drivers/net/arcnet/com20020_cs.c                   |  330 ---
 drivers/net/arcnet/com90io.c                       |  427 ---
 drivers/net/arcnet/com90xx.c                       |  716 -----
 drivers/net/arcnet/rfc1201.c                       |    2 +-
 drivers/net/bareudp.c                              |   52 +-
 drivers/net/bonding/bond_3ad.c                     |   27 +-
 drivers/net/bonding/bond_main.c                    |   22 +-
 drivers/net/bonding/bond_netlink.c                 |   16 +
 drivers/net/bonding/bond_options.c                 |   92 +-
 drivers/net/bonding/bond_procfs.c                  |   48 +-
 drivers/net/bonding/bond_sysfs.c                   |   98 +-
 drivers/net/can/sja1000/plx_pci.c                  |  167 +-
 drivers/net/dsa/Kconfig                            |    2 +
 drivers/net/dsa/Makefile                           |    1 +
 drivers/net/dsa/b53/b53_common.c                   |   21 +-
 drivers/net/dsa/b53/b53_priv.h                     |   25 +-
 drivers/net/dsa/dsa_loop.c                         |    1 +
 drivers/net/dsa/hirschmann/hellcreek.c             |   14 +-
 drivers/net/dsa/hirschmann/hellcreek.h             |    3 +-
 drivers/net/dsa/lan9303_i2c.c                      |    2 +-
 drivers/net/dsa/microchip/ksz8.c                   |  725 ++++-
 drivers/net/dsa/microchip/ksz8.h                   |   62 +-
 drivers/net/dsa/microchip/ksz8863_smi.c            |    8 +-
 drivers/net/dsa/microchip/ksz8_reg.h               |   23 +-
 drivers/net/dsa/microchip/ksz9477.c                |  589 +++-
 drivers/net/dsa/microchip/ksz9477.h                |   48 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c            |   12 +-
 drivers/net/dsa/microchip/ksz_common.c             | 1243 +-------
 drivers/net/dsa/microchip/ksz_common.h             |  162 +-
 drivers/net/dsa/microchip/ksz_spi.c                |    8 +-
 drivers/net/dsa/microchip/lan937x.h                |   21 +-
 drivers/net/dsa/microchip/lan937x_main.c           |  383 ++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   57 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |    7 +-
 drivers/net/dsa/mv88e6xxx/devlink.c                |    9 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |    1 +
 drivers/net/dsa/mv88e6xxx/global2_scratch.c        |   38 +-
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |   12 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |   55 +-
 drivers/net/dsa/mv88e6xxx/port.h                   |   11 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   84 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |    4 +
 drivers/net/dsa/mxl862xx/Makefile                  |    2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-api.h            |  215 ++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h            |    9 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h           |    8 +
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c        |  446 +++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h        |   21 +
 drivers/net/dsa/mxl862xx/mxl862xx.c                |   55 +-
 drivers/net/dsa/mxl862xx/mxl862xx.h                |   57 +
 drivers/net/dsa/netc/Kconfig                       |   16 +
 drivers/net/dsa/netc/Makefile                      |    3 +
 drivers/net/dsa/netc/netc_ethtool.c                |  291 ++
 drivers/net/dsa/netc/netc_main.c                   | 2524 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c               |   87 +
 drivers/net/dsa/netc/netc_switch.h                 |  206 ++
 drivers/net/dsa/netc/netc_switch_hw.h              |  372 +++
 drivers/net/dsa/ocelot/felix.c                     |    9 +-
 drivers/net/dsa/ocelot/felix.h                     |    2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   22 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |    3 +-
 drivers/net/dsa/qca/qca8k.h                        |    1 +
 drivers/net/dsa/realtek/Makefile                   |    5 +
 drivers/net/dsa/realtek/realtek.h                  |   46 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             |  576 ++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |   32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  |  734 ++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c          |  214 ++
 drivers/net/dsa/realtek/rtl8365mb_table.h          |  138 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           |  944 +++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |   39 +
 drivers/net/dsa/realtek/rtl8366rb.c                |    3 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |  563 ++++
 drivers/net/dsa/realtek/rtl83xx.h                  |   27 +
 drivers/net/dsa/sja1105/sja1105_flower.c           |    4 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    3 +-
 drivers/net/dsa/sja1105/sja1105_vl.c               |    3 +-
 drivers/net/dsa/xrs700x/xrs700x_i2c.c              |    4 +-
 drivers/net/dsa/yt921x.c                           | 1664 ++++++++++-
 drivers/net/dsa/yt921x.h                           |  391 ++-
 drivers/net/dummy.c                                |   13 +-
 drivers/net/ethernet/3com/3c509.c                  |    2 +-
 drivers/net/ethernet/3com/3c59x.c                  |   80 +-
 drivers/net/ethernet/3com/typhoon.c                |   75 +-
 drivers/net/ethernet/8390/Kconfig                  |    1 -
 drivers/net/ethernet/8390/hydra.c                  |    4 +-
 drivers/net/ethernet/8390/ne.c                     |  237 +-
 drivers/net/ethernet/8390/ne2k-pci.c               |   24 +-
 drivers/net/ethernet/8390/xsurf100.c               |    4 +-
 drivers/net/ethernet/8390/zorro8390.c              |    6 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/adaptec/starfire.c            |    4 +-
 drivers/net/ethernet/agere/et131x.c                |    6 +-
 drivers/net/ethernet/airoha/Kconfig                |    2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 1089 ++++---
 drivers/net/ethernet/airoha/airoha_eth.h           |   63 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |    2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   79 +-
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |    2 -
 drivers/net/ethernet/alibaba/Kconfig               |   28 +
 drivers/net/ethernet/alibaba/Makefile              |    5 +
 drivers/net/ethernet/alibaba/eea/Makefile          |    9 +
 drivers/net/ethernet/alibaba/eea/eea_adminq.c      |  542 ++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h      |   83 +
 drivers/net/ethernet/alibaba/eea/eea_desc.h        |  138 +
 drivers/net/ethernet/alibaba/eea/eea_ethtool.c     |  273 ++
 drivers/net/ethernet/alibaba/eea/eea_ethtool.h     |   48 +
 drivers/net/ethernet/alibaba/eea/eea_net.c         |  887 ++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h         |  198 ++
 drivers/net/ethernet/alibaba/eea/eea_pci.c         |  744 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.h         |   73 +
 drivers/net/ethernet/alibaba/eea/eea_ring.c        |  249 ++
 drivers/net/ethernet/alibaba/eea/eea_ring.h        |   99 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c          |  814 ++++++
 drivers/net/ethernet/alibaba/eea/eea_tx.c          |  500 ++++
 drivers/net/ethernet/amazon/ena/ena_devlink.c      |    8 +-
 drivers/net/ethernet/amd/a2065.c                   |    8 +-
 drivers/net/ethernet/amd/ariadne.c                 |    4 +-
 drivers/net/ethernet/amd/pds_core/core.c           |    4 +
 drivers/net/ethernet/amd/pds_core/core.h           |    2 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |    2 +-
 .../net/ethernet/aquantia/atlantic/aq_filters.c    |   98 +-
 .../net/ethernet/aquantia/atlantic/aq_filters.h    |    3 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |   35 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |   30 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   53 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |    5 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |  555 +++-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h    |   17 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   26 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |    5 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   15 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |  857 +++++-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h   |   12 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_internal.h   |   70 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.c        |  322 +++
 .../aquantia/atlantic/hw_atl2/hw_atl2_llh.h        |   97 +-
 .../atlantic/hw_atl2/hw_atl2_llh_internal.h        |  200 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.c      |   34 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h      |   17 +-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   |   71 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |   37 +-
 drivers/net/ethernet/broadcom/Kconfig              |    1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  260 +-
 drivers/net/ethernet/broadcom/b44.c                |   10 +-
 drivers/net/ethernet/broadcom/bnx2.c               |   62 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   76 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   61 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |    8 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  249 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    5 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |   10 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |    7 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |    8 +-
 drivers/net/ethernet/chelsio/cxgb/common.h         |    2 +-
 drivers/net/ethernet/chelsio/cxgb/subr.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    7 +-
 .../net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |    4 +-
 drivers/net/ethernet/chelsio/inline_crypto/Kconfig |   12 -
 .../net/ethernet/chelsio/inline_crypto/Makefile    |    1 -
 .../ethernet/chelsio/inline_crypto/chtls/Makefile  |    6 -
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |  584 ----
 .../chelsio/inline_crypto/chtls/chtls_cm.c         | 2336 ---------------
 .../chelsio/inline_crypto/chtls/chtls_cm.h         |  218 --
 .../chelsio/inline_crypto/chtls/chtls_hw.c         |  462 ---
 .../chelsio/inline_crypto/chtls/chtls_io.c         | 1836 ------------
 .../chelsio/inline_crypto/chtls/chtls_main.c       |  642 -----
 drivers/net/ethernet/cirrus/Kconfig                |   20 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |  636 +----
 drivers/net/ethernet/dec/tulip/de2104x.c           |    6 +-
 drivers/net/ethernet/dec/tulip/dmfe.c              |   12 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c        |   78 +-
 drivers/net/ethernet/dec/tulip/uli526x.c           |    6 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |   13 +-
 drivers/net/ethernet/dlink/dl2k.h                  |   12 +-
 drivers/net/ethernet/dlink/sundance.c              |   14 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |    2 +-
 drivers/net/ethernet/fealnx.c                      |    8 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |    4 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  279 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |    2 +
 drivers/net/ethernet/freescale/enetc/Makefile      |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   22 +-
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |    4 -
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c  |   16 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |    1 -
 .../net/ethernet/freescale/enetc/enetc_mailbox.h   |  170 ++
 drivers/net/ethernet/freescale/enetc/enetc_msg.c   |  209 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  142 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   10 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |   31 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.h |   11 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |  173 +-
 .../net/ethernet/freescale/enetc/netc_blk_ctrl.c   |  185 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c        |  817 +++++-
 .../net/ethernet/freescale/enetc/ntmp_private.h    |  136 +-
 drivers/net/ethernet/freescale/fec_main.c          |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    1 +
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c   |    1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    6 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   17 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns3/Makefile       |    1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    6 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   53 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  155 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c  | 2593 +++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h  |   33 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 2488 +---------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    6 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   12 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |   12 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c    |    7 +-
 drivers/net/ethernet/ibm/emac/core.c               |   28 +-
 drivers/net/ethernet/ibm/emac/mal.c                |   15 +-
 drivers/net/ethernet/intel/e100.c                  |    9 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |   10 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   19 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  479 +++-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   59 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    9 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   10 +
 drivers/net/ethernet/intel/iavf/iavf_adminq.h      |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   20 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   12 +-
 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   30 +-
 drivers/net/ethernet/intel/ice/ice.h               |   12 +
 drivers/net/ethernet/intel/ice/ice_adapter.c       |    4 +
 drivers/net/ethernet/intel/ice/ice_adapter.h       |    7 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |    2 +
 drivers/net/ethernet/intel/ice/ice_common.c        |    5 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c           |  362 +++
 drivers/net/ethernet/intel/ice/ice_cpi.h           |   58 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  502 +++-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |   36 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |    2 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   51 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    6 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   37 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   17 +
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h       |    5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c         |  354 +++
 drivers/net/ethernet/intel/ice/ice_txclk.h         |   40 +
 drivers/net/ethernet/intel/ice/ice_type.h          |    2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    2 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |   12 +-
 drivers/net/ethernet/intel/igb/e1000_defines.h     |    2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c         |    2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h         |    2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c         |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   72 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |    5 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    4 +-
 drivers/net/ethernet/intel/igc/igc_diag.c          |    2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   46 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |   87 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  224 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  139 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |   32 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |    2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   49 +-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |  163 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  |  641 +++--
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.h  |   18 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   32 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   19 +
 .../ethernet/marvell/octeontx2/af/npc_profile.h    | 1196 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   14 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   12 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |  114 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   77 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  526 +++-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.h    |   17 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   12 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    1 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   48 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   26 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |   22 +-
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c    |    6 +-
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c        |    8 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |  387 ++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |   42 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   72 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/ecpf.c     |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/ecpf.h     |    4 +-
 .../mellanox/mlx5/core/en/pcie_cong_event.c        |   45 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |   36 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |   40 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_priv.h   |    7 +
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |    5 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h        |   12 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  111 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   61 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   33 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   83 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |   35 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |    3 +-
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c    |    6 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   64 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec.c    |   85 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  637 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  100 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  729 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   21 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    4 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  743 +++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  133 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |    4 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  125 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |    4 +
 .../ethernet/mellanox/mlx5/core/lag/shared_fdb.c   |  306 ++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   44 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    6 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         |   10 +
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  655 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |   31 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   58 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    9 +
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |  253 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   27 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   19 +-
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |   89 +-
 .../mellanox/mlx5/core/sf/mlx5_ifc_vhca_event.h    |    8 -
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |    5 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |   12 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |    2 +-
 .../mellanox/mlx5/core/steering/hws/table.c        |    3 +
 .../mellanox/mlx5/core/steering/hws/vport.c        |    2 +-
 .../mellanox/mlx5/core/steering/sws/dr_icm_pool.c  |    2 +-
 .../mellanox/mlx5/core/steering/sws/dr_types.h     |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   12 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    8 +-
 drivers/net/ethernet/mellanox/mlxsw/minimal.c      |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |    8 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   18 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |    4 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |    7 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c       |  137 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   10 +-
 drivers/net/ethernet/micrel/ksz884x.c              |    8 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   48 +-
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |   29 +-
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |    5 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |   18 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  444 ++-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |    2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  329 ++-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   27 +-
 drivers/net/ethernet/mscc/ocelot.h                 |    2 +-
 drivers/net/ethernet/mscc/ocelot_flower.c          |    4 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |    4 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c    |   10 +-
 drivers/net/ethernet/natsemi/natsemi.c             |    4 +-
 drivers/net/ethernet/netronome/nfp/devlink_param.c |    6 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |   65 +-
 .../net/ethernet/netronome/nfp/nfp_netvf_main.c    |   33 +-
 drivers/net/ethernet/oa_tc6.c                      |  140 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |   10 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    6 +
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   27 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   64 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |    1 -
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    8 +
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |   65 +-
 drivers/net/ethernet/pensando/ionic/ionic_stats.h  |    2 +
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   20 +-
 drivers/net/ethernet/qualcomm/Kconfig              |    4 +-
 drivers/net/ethernet/realtek/8139too.c             |   52 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    8 +-
 drivers/net/ethernet/realtek/rtase/rtase.h         |    4 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |    3 +
 drivers/net/ethernet/rocker/rocker_main.c          |    4 +-
 drivers/net/ethernet/sis/sis190.c                  |    6 +-
 drivers/net/ethernet/sis/sis900.c                  |   10 +-
 drivers/net/ethernet/sis/sis900.h                  |    2 +-
 drivers/net/ethernet/smsc/epic100.c                |   18 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   59 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |    6 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |    6 +
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |    2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   14 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    8 +-
 drivers/net/ethernet/sun/cassini.c                 |   16 +-
 drivers/net/ethernet/sun/cassini.h                 |   16 +-
 drivers/net/ethernet/sun/sunbmac.h                 |    2 +-
 drivers/net/ethernet/sun/sungem.c                  |   30 +-
 drivers/net/ethernet/sun/sungem.h                  |    4 +-
 drivers/net/ethernet/sun/sunhme.c                  |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    6 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    4 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   48 +-
 drivers/net/ethernet/ti/tlan.c                     |   41 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |    3 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |    9 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c      |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |    8 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   40 +-
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c  |   26 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     |    9 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h     |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   43 +-
 .../net/ethernet/wangxun/txgbevf/txgbevf_main.c    |   18 +-
 drivers/net/ethernet/wiznet/Kconfig                |   59 +-
 drivers/net/ethernet/wiznet/Makefile               |    4 +-
 drivers/net/ethernet/wiznet/w5100-spi.c            |    2 +-
 drivers/net/ethernet/wiznet/w5100.c                |  412 +--
 drivers/net/ethernet/wiznet/w5100.h                |    3 +-
 drivers/net/ethernet/wiznet/w5300.c                |  687 -----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   27 +-
 drivers/net/geneve.c                               |  309 +-
 drivers/net/gtp.c                                  |   10 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    2 +-
 drivers/net/mctp/mctp-i2c.c                        |    4 +-
 drivers/net/mdio/Kconfig                           |    2 +-
 drivers/net/mdio/mdio-i2c.c                        |   59 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |    2 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c            |  898 +++---
 drivers/net/netconsole.c                           |  262 +-
 drivers/net/netdevsim/bpf.c                        |    6 -
 drivers/net/netdevsim/dev.c                        |    4 +-
 drivers/net/netdevsim/ethtool.c                    |    1 +
 drivers/net/netdevsim/fib.c                        |   17 +-
 drivers/net/netdevsim/netdev.c                     |    7 +-
 drivers/net/netdevsim/netdevsim.h                  |   10 +-
 drivers/net/netdevsim/psp.c                        |   48 +-
 drivers/net/netdevsim/tc.c                         |   20 +-
 drivers/net/netkit.c                               |    8 +-
 drivers/net/ovpn/udp.c                             |    2 +-
 drivers/net/pfcp.c                                 |   18 +-
 drivers/net/phy/Kconfig                            |   14 +-
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/air_an8801.c                       | 1156 ++++++++
 drivers/net/phy/air_en8811h.c                      |  316 +--
 drivers/net/phy/air_phy_lib.c                      |  211 ++
 drivers/net/phy/air_phy_lib.h                      |   41 +
 drivers/net/phy/aquantia/aquantia_main.c           |    6 +-
 drivers/net/phy/dp83822.c                          |   12 +-
 drivers/net/phy/dp83867.c                          |   60 +
 drivers/net/phy/intel-xway.c                       |   79 +
 drivers/net/phy/micrel.c                           |   61 +
 drivers/net/phy/motorcomm.c                        |  118 +-
 drivers/net/phy/phy_device.c                       |    3 +
 drivers/net/phy/phy_link_topology.c                |   10 +
 drivers/net/phy/qcom/at803x.c                      |   12 +
 drivers/net/phy/realtek/realtek_main.c             |  326 ++-
 drivers/net/phy/sfp.c                              |  248 +-
 drivers/net/ppp/Kconfig                            |    6 +
 drivers/net/ppp/Makefile                           |    6 +-
 drivers/net/ppp/pppoe.c                            |  173 +-
 drivers/net/pse-pd/pd692x0.c                       |    9 +-
 drivers/net/pse-pd/si3474.c                        |    4 +-
 drivers/net/pse-pd/tps23881.c                      |    4 +-
 drivers/net/team/team_core.c                       |    4 +-
 drivers/net/tun.c                                  |  109 +-
 drivers/net/usb/pegasus.c                          |   16 +-
 drivers/net/usb/qmi_wwan.c                         |    2 +
 drivers/net/usb/r8152.c                            |  368 ++-
 drivers/net/usb/rndis_host.c                       |   16 +
 drivers/net/usb/usbnet.c                           |   10 +-
 drivers/net/virtio_net.c                           |   15 +-
 drivers/net/vxlan/vxlan_core.c                     |   63 +-
 drivers/net/vxlan/vxlan_multicast.c                |    8 +-
 drivers/net/wan/farsync.c                          |   24 +-
 drivers/net/wan/pc300too.c                         |   14 +-
 drivers/net/wan/pci200syn.c                        |    6 +-
 drivers/net/wan/wanxl.c                            |   11 +-
 drivers/net/wireguard/socket.c                     |    8 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |    1 -
 drivers/net/wireless/ath/ath10k/ce.c               |    1 -
 drivers/net/wireless/ath/ath10k/core.h             |    1 -
 drivers/net/wireless/ath/ath10k/coredump.c         |    1 -
 drivers/net/wireless/ath/ath10k/coredump.h         |    2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |    1 -
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    1 -
 drivers/net/wireless/ath/ath10k/htc.c              |    1 -
 drivers/net/wireless/ath/ath10k/htt.c              |    2 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    3 +-
 drivers/net/wireless/ath/ath10k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath10k/leds.c             |    8 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    1 -
 drivers/net/wireless/ath/ath10k/pci.h              |    2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    4 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |    2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |    3 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h          |    2 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath10k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath10k/usb.h              |    2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |    2 +-
 drivers/net/wireless/ath/ath10k/wow.c              |    2 +-
 drivers/net/wireless/ath/ath11k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath11k/ahb.h              |    2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    1 -
 drivers/net/wireless/ath/ath11k/ce.h               |    2 +-
 drivers/net/wireless/ath/ath11k/core.c             |   10 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |    1 -
 drivers/net/wireless/ath/ath11k/coredump.h         |    2 +-
 drivers/net/wireless/ath/ath11k/debug.c            |    1 -
 drivers/net/wireless/ath/ath11k/debugfs.c          |    1 -
 drivers/net/wireless/ath/ath11k/debugfs.h          |    2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |    1 -
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |    2 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   59 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h            |    2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    1 -
 drivers/net/wireless/ath/ath11k/dp_tx.h            |    2 +-
 drivers/net/wireless/ath/ath11k/fw.c               |    1 -
 drivers/net/wireless/ath/ath11k/fw.h               |    2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |    2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h           |    2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c           |    2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h           |    2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |    2 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    2 +-
 drivers/net/wireless/ath/ath11k/htc.h              |    2 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   72 +-
 drivers/net/wireless/ath/ath11k/mac.h              |    2 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    4 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |    2 +-
 drivers/net/wireless/ath/ath11k/p2p.c              |    2 +-
 drivers/net/wireless/ath/ath11k/p2p.h              |    2 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    8 +
 drivers/net/wireless/ath/ath11k/pcic.c             |    1 -
 drivers/net/wireless/ath/ath11k/pcic.h             |    2 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    3 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    3 +-
 drivers/net/wireless/ath/ath11k/reg.h              |    2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h          |    2 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |    1 -
 drivers/net/wireless/ath/ath11k/spectral.h         |    2 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath11k/testmode.h         |    2 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath11k/thermal.h          |    2 +-
 drivers/net/wireless/ath/ath11k/trace.h            |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |    2 +-
 drivers/net/wireless/ath/ath11k/wow.c              |    2 +-
 drivers/net/wireless/ath/ath11k/wow.h              |    2 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    6 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |    2 +-
 drivers/net/wireless/ath/ath12k/acpi.h             |    2 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |   25 +-
 drivers/net/wireless/ath/ath12k/core.c             |   56 +-
 drivers/net/wireless/ath/ath12k/core.h             |   21 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |    2 +-
 drivers/net/wireless/ath/ath12k/coredump.h         |    2 +-
 drivers/net/wireless/ath/ath12k/dbring.h           |    2 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    2 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   46 +
 drivers/net/wireless/ath/ath12k/debugfs.h          |    2 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   10 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c           |    2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.h           |    2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    6 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |    2 +-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |    2 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   81 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    3 +-
 drivers/net/wireless/ath/ath12k/hal.h              |    4 +-
 drivers/net/wireless/ath/ath12k/hif.h              |    2 +-
 drivers/net/wireless/ath/ath12k/htc.h              |    8 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   25 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  342 ++-
 drivers/net/wireless/ath/ath12k/mac.h              |    3 +
 drivers/net/wireless/ath/ath12k/p2p.c              |    1 -
 drivers/net/wireless/ath/ath12k/p2p.h              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath12k/peer.c             |   11 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    1 -
 drivers/net/wireless/ath/ath12k/reg.c              |    2 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    2 +-
 drivers/net/wireless/ath/ath12k/testmode.h         |    2 +-
 drivers/net/wireless/ath/ath12k/thermal.c          |  252 +-
 drivers/net/wireless/ath/ath12k/thermal.h          |   35 +
 drivers/net/wireless/ath/ath12k/trace.c            |    2 +-
 drivers/net/wireless/ath/ath12k/trace.h            |    2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |   95 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |   43 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |    4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |   16 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |    1 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c     |    4 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h     |    1 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   48 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  827 ++++--
 drivers/net/wireless/ath/ath12k/wmi.h              |  145 +-
 drivers/net/wireless/ath/ath12k/wow.h              |    2 +-
 drivers/net/wireless/ath/ath5k/base.c              |    2 -
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    3 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |    6 +-
 drivers/net/wireless/ath/ath9k/ar9002_mac.c        |   15 +-
 drivers/net/wireless/ath/ath9k/ar9003_mac.c        |   23 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |    4 +-
 .../net/wireless/ath/ath9k/ath9k_pci_owl_loader.c  |   31 +-
 drivers/net/wireless/ath/ath9k/common-init.c       |    8 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   24 +-
 drivers/net/wireless/ath/ath9k/hif_usb.h           |    4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   18 -
 drivers/net/wireless/ath/ath9k/hw.c                |   49 +-
 drivers/net/wireless/ath/ath9k/hw.h                |    5 +-
 drivers/net/wireless/ath/ath9k/init.c              |   12 +-
 drivers/net/wireless/ath/ath9k/recv.c              |    4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    7 +-
 drivers/net/wireless/ath/testmode_i.h              |    2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |    4 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |   13 +-
 drivers/net/wireless/ath/wcn36xx/smd.c             |   13 +
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |    2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 drivers/net/wireless/broadcom/b43/main.c           |   22 +-
 drivers/net/wireless/broadcom/b43/radio_2057.c     |  230 +-
 drivers/net/wireless/broadcom/b43/tables_nphy.c    |   58 +
 .../broadcom/brcm80211/brcmfmac/flowring.c         |   10 +-
 .../broadcom/brcm80211/brcmfmac/flowring.h         |    2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |    4 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |    3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   17 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |   40 +-
 .../wireless/broadcom/brcm80211/brcmsmac/main.h    |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |   13 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   52 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   23 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   38 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   29 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   19 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |   20 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   20 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   30 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |    8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   22 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   17 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h |   11 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   16 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |  107 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  184 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   48 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   90 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c    | 1022 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 1388 ++-------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   15 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |   32 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   15 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   25 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  152 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  138 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   58 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.h        |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  173 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.h        |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   74 +-
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   30 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |  189 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   62 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |  168 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  580 +++-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   43 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  373 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   20 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   36 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |  749 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |   41 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   35 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   24 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |  210 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   44 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  253 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   32 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |  108 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    1 +
 .../intel/iwlwifi/mld/tests/chan_load_thresh.c     |  139 +
 .../intel/iwlwifi/mld/tests/link-selection.c       |  286 +-
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    |  474 +++-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   68 +-
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  486 ++--
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   50 +-
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c   |    5 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   30 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   32 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   22 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    9 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   32 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   11 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |  108 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |   21 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |   98 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |   67 +-
 drivers/net/wireless/intersil/p54/p54spi.h         |    3 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    3 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |   37 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |    2 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |    2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   19 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |    1 +
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |    2 -
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    1 -
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |    3 -
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   21 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   13 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   49 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    3 -
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    5 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    3 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    8 +
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |    2 -
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   98 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c   |  206 ++
 drivers/net/wireless/mediatek/mt76/mt7921/regd.h   |   19 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   11 +-
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |    2 -
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  101 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  120 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |  151 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |   12 +-
 .../net/wireless/mediatek/mt76/mt7925/testmode.c   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   22 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   33 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   56 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  198 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |   23 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   79 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   51 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   29 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   36 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   22 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/pci.c           |    8 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |    2 +
 drivers/net/wireless/mediatek/mt7601u/usb.c        |    3 -
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    3 +-
 drivers/net/wireless/purelifi/plfxlc/usb.c         |   25 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |    4 +-
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |    6 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   11 +-
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c      |    1 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   77 +-
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |    2 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    7 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |   17 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   21 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.h   |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    3 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   29 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |   31 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |    6 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    8 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |   25 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   22 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |   12 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    3 +
 drivers/net/wireless/realtek/rtw89/chan.c          |   92 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |   21 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  815 +++++-
 drivers/net/wireless/realtek/rtw89/core.h          |  347 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  940 +++++-
 drivers/net/wireless/realtek/rtw89/fw.c            |  502 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  115 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  153 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   52 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   29 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   68 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   41 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    6 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   15 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  622 +++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  164 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  724 +++--
 drivers/net/wireless/realtek/rtw89/ps.c            |    6 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  289 ++
 drivers/net/wireless/realtek/rtw89/regd.c          |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   58 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   63 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   68 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |   13 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  335 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   22 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922au.c     |   86 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      |  445 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c  |   92 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h  |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |    2 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    4 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |  110 +
 drivers/net/wireless/realtek/rtw89/usb.c           |  199 +-
 drivers/net/wireless/realtek/rtw89/usb.h           |   11 +-
 drivers/net/wireless/ti/wlcore/main.c              |   23 +-
 drivers/net/wireless/virtual/Makefile              |    2 +
 drivers/net/wireless/virtual/mac80211_hwsim_i.h    |  168 ++
 .../{mac80211_hwsim.c => mac80211_hwsim_main.c}    | 1095 ++++---
 drivers/net/wireless/virtual/mac80211_hwsim_nan.c  | 1346 +++++++++
 drivers/net/wireless/virtual/mac80211_hwsim_nan.h  |  102 +
 drivers/net/wwan/Kconfig                           |    4 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |    3 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c             |    2 +
 drivers/nfc/microread/i2c.c                        |    2 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    4 +-
 drivers/nfc/nxp-nci/core.c                         |    1 +
 drivers/nfc/nxp-nci/i2c.c                          |   12 +-
 drivers/nfc/pn533/i2c.c                            |    4 +-
 drivers/nfc/pn544/i2c.c                            |    4 +-
 drivers/nfc/s3fwrn5/i2c.c                          |    4 +-
 drivers/nfc/st-nci/i2c.c                           |    4 +-
 drivers/nfc/st21nfca/i2c.c                         |    4 +-
 drivers/nfc/trf7970a.c                             |    6 +-
 drivers/ptp/ptp_ocp.c                              |    1 +
 drivers/ptp/ptp_vmw.c                              |    3 -
 drivers/s390/net/ism_drv.c                         |    4 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |    3 +
 drivers/scsi/fcoe/fcoe.c                           |    6 +-
 drivers/scsi/fcoe/fcoe_transport.c                 |    4 +-
 drivers/usb/atm/ueagle-atm.c                       |    6 +-
 drivers/vhost/net.c                                |   21 +-
 fs/afs/rxrpc.c                                     |    6 +-
 include/crypto/hash.h                              |    8 -
 include/crypto/internal/cipher.h                   |    2 -
 include/linux/atalk.h                              |  186 --
 include/linux/atm_tcp.h                            |   24 -
 include/linux/atmdev.h                             |   70 +-
 include/linux/crypto.h                             |    1 -
 include/linux/dpll.h                               |   32 +-
 include/linux/dsa/tag_netc.h                       |   14 +
 include/linux/ethtool.h                            |   38 +-
 include/linux/fsl/netc_global.h                    |    6 +
 include/linux/fsl/ntmp.h                           |  241 +-
 include/linux/ieee80211-eht.h                      |  163 +-
 include/linux/ieee80211-mesh.h                     |  212 ++
 include/linux/ieee80211-s1g.h                      |    2 +-
 include/linux/ieee80211-uhr.h                      |  238 +-
 include/linux/ieee80211.h                          |   18 +
 include/linux/if_bridge.h                          |   77 +-
 include/linux/if_tun.h                             |    3 +
 include/linux/igmp.h                               |  167 +-
 include/linux/ks8851_mll.h                         |   21 -
 include/linux/llc.h                                |    8 +-
 include/linux/mlx5/driver.h                        |   20 +-
 include/linux/mlx5/eswitch.h                       |    8 +-
 include/linux/mlx5/mlx5_ifc.h                      |   84 +-
 include/linux/mlx5/vport.h                         |    4 +-
 include/linux/mroute_base.h                        |    2 +-
 include/linux/net/intel/libie/adminq.h             |    1 +
 include/linux/netdev_features.h                    |    3 +-
 include/linux/netdevice.h                          |   49 +-
 include/linux/netfilter/x_tables.h                 |   17 +
 include/linux/netpoll.h                            |   18 +-
 include/linux/phy_link_topology.h                  |    5 +
 include/linux/platform_data/wiznet.h               |   23 -
 include/linux/ptr_ring.h                           |   20 +-
 include/linux/skbuff.h                             |    3 +-
 include/linux/skmsg.h                              |   24 +-
 include/linux/socket.h                             |    2 +-
 include/linux/tcp.h                                |   40 +-
 include/net/Space.h                                |    7 -
 include/net/act_api.h                              |    4 +-
 include/net/addrconf.h                             |    5 +-
 include/net/af_vsock.h                             |    1 +
 include/net/amt.h                                  |    2 +-
 include/net/bluetooth/bluetooth.h                  |    5 +-
 include/net/bluetooth/hci.h                        |   11 +-
 include/net/bluetooth/hci_core.h                   |    5 +-
 include/net/bluetooth/hci_mon.h                    |    5 +-
 include/net/bluetooth/hci_sock.h                   |    5 +-
 include/net/bluetooth/l2cap.h                      |    6 +-
 include/net/bluetooth/mgmt.h                       |    5 +-
 include/net/bluetooth/rfcomm.h                     |    5 +-
 include/net/bluetooth/sco.h                        |    5 +-
 include/net/bond_options.h                         |    1 +
 include/net/bonding.h                              |    1 +
 include/net/cfg80211.h                             |  290 +-
 include/net/devlink.h                              |   12 +-
 include/net/dsa.h                                  |    5 +-
 include/net/fib_rules.h                            |    5 +
 include/net/gen_stats.h                            |   16 +-
 include/net/ip_fib.h                               |    6 +-
 include/net/ip_vs.h                                |   22 +
 include/net/ipv6.h                                 |   12 +
 include/net/llc.h                                  |    8 +-
 include/net/llc_c_ac.h                             |    8 +-
 include/net/llc_c_ev.h                             |    8 +-
 include/net/llc_c_st.h                             |    8 +-
 include/net/llc_conn.h                             |    8 +-
 include/net/llc_if.h                               |    8 +-
 include/net/llc_pdu.h                              |    8 +-
 include/net/llc_s_ac.h                             |    8 +-
 include/net/llc_s_ev.h                             |    8 +-
 include/net/llc_s_st.h                             |    8 +-
 include/net/llc_sap.h                              |    8 +-
 include/net/mac80211.h                             |   79 +-
 include/net/mana/gdma.h                            |   36 +-
 include/net/mana/mana.h                            |   29 +-
 include/net/mld.h                                  |  187 +-
 include/net/mptcp.h                                |   18 +-
 include/net/ncsi.h                                 |    2 +-
 include/net/netdev_lock.h                          |   23 +-
 include/net/netfilter/ipv4/nf_conntrack_ipv4.h     |    4 +
 include/net/netfilter/nf_conntrack_extend.h        |   12 -
 include/net/netfilter/nf_conntrack_helper.h        |   44 +-
 include/net/netfilter/nf_conntrack_timeout.h       |   27 +-
 include/net/netfilter/nf_dup_netdev.h              |   36 +-
 include/net/netlink.h                              |    5 +-
 include/net/netns/ipv6.h                           |    5 +-
 include/net/page_pool/helpers.h                    |    2 +-
 include/net/pkt_cls.h                              |    1 +
 include/net/psp/types.h                            |   23 +
 include/net/sch_generic.h                          |   87 +-
 include/net/sctp/sctp.h                            |    2 +-
 include/net/smc.h                                  |    2 +-
 include/net/sock.h                                 |   25 +-
 include/net/tcp.h                                  |   82 +-
 include/net/tcp_ao.h                               |   74 +-
 include/net/tls.h                                  |    6 +-
 include/net/tls_toe.h                              |   77 -
 include/net/udp_tunnel.h                           |   14 +-
 include/net/vxlan.h                                |    5 +-
 include/net/xfrm.h                                 |   78 +-
 include/soc/mscc/ocelot.h                          |    2 +-
 include/trace/events/skb.h                         |    4 +-
 include/uapi/linux/atm_eni.h                       |   24 -
 include/uapi/linux/atm_he.h                        |   21 -
 include/uapi/linux/atm_idt77105.h                  |   29 -
 include/uapi/linux/atm_nicstar.h                   |   54 -
 include/uapi/linux/atm_tcp.h                       |   62 -
 include/uapi/linux/atm_zatm.h                      |   47 -
 include/uapi/linux/atmarp.h                        |   42 -
 include/uapi/linux/atmclip.h                       |   22 -
 include/uapi/linux/atmdev.h                        |   18 -
 include/uapi/linux/atmlec.h                        |   92 -
 include/uapi/linux/atmmpc.h                        |  127 -
 include/uapi/linux/atmsvc.h                        |   56 -
 include/uapi/linux/batadv_packet.h                 |    6 +-
 include/uapi/linux/devlink.h                       |    1 +
 include/uapi/linux/dpll.h                          |   25 +
 include/uapi/linux/ethtool.h                       |    3 +
 include/uapi/linux/if_bridge.h                     |    1 +
 include/uapi/linux/if_ether.h                      |    6 +
 include/uapi/linux/if_link.h                       |   20 +
 include/uapi/linux/llc.h                           |    7 -
 include/uapi/linux/mdio.h                          |   10 +
 include/uapi/linux/netdev.h                        |    2 +
 include/uapi/linux/nl80211.h                       |  303 +-
 include/uapi/linux/pkt_sched.h                     |   10 +
 include/uapi/linux/pps.h                           |    2 +-
 include/uapi/linux/psp.h                           |   13 +
 include/uapi/linux/rtnetlink.h                     |    1 +
 include/uapi/linux/tls.h                           |    2 +-
 include/uapi/linux/xfrm.h                          |   25 +
 io_uring/zcrx.c                                    |    8 +
 net/6lowpan/nhc.c                                  |    2 +-
 net/802/Makefile                                   |    1 -
 net/802/fddi.c                                     |    5 +
 net/802/garp.c                                     |    5 +-
 net/Kconfig                                        |    1 -
 net/Makefile                                       |    1 -
 net/appletalk/Kconfig                              |   30 -
 net/appletalk/Makefile                             |   10 -
 net/appletalk/aarp.c                               | 1041 -------
 net/appletalk/atalk_proc.c                         |  242 --
 net/appletalk/ddp.c                                | 2017 -------------
 net/appletalk/sysctl_net_atalk.c                   |   58 -
 net/atm/Makefile                                   |    2 +-
 net/atm/addr.c                                     |  162 --
 net/atm/addr.h                                     |   21 -
 net/atm/atm_sysfs.c                                |   25 -
 net/atm/br2684.c                                   |    3 +-
 net/atm/common.c                                   |   93 +-
 net/atm/common.h                                   |    7 +-
 net/atm/ioctl.c                                    |   58 -
 net/atm/pppoatm.c                                  |    3 +-
 net/atm/proc.c                                     |   56 -
 net/atm/protocols.h                                |    1 -
 net/atm/pvc.c                                      |    6 +-
 net/atm/raw.c                                      |   21 +-
 net/atm/resources.c                                |   59 +-
 net/atm/signaling.c                                |  297 --
 net/atm/signaling.h                                |   31 -
 net/atm/svc.c                                      |  696 -----
 net/batman-adv/Makefile                            |    1 +
 net/batman-adv/bat_iv_ogm.c                        |   67 +-
 net/batman-adv/bat_v.c                             |   14 +-
 net/batman-adv/bat_v_elp.c                         |   21 +-
 net/batman-adv/bat_v_ogm.c                         |   62 +-
 net/batman-adv/bitarray.c                          |    2 +-
 net/batman-adv/bitarray.h                          |    2 +-
 net/batman-adv/bridge_loop_avoidance.c             |   49 +-
 net/batman-adv/bridge_loop_avoidance.h             |    2 +-
 net/batman-adv/distributed-arp-table.c             |   19 +-
 net/batman-adv/fragmentation.c                     |    4 +-
 net/batman-adv/gateway_client.c                    |    9 +-
 net/batman-adv/gateway_common.c                    |   14 +-
 net/batman-adv/hard-interface.c                    |  223 +-
 net/batman-adv/hard-interface.h                    |   35 +-
 net/batman-adv/hash.h                              |    4 +-
 net/batman-adv/log.h                               |    2 +-
 net/batman-adv/main.c                              |   45 +-
 net/batman-adv/main.h                              |    4 -
 net/batman-adv/mesh-interface.c                    |   48 +-
 net/batman-adv/multicast.c                         |    6 +-
 net/batman-adv/netlink.c                           |   92 +-
 net/batman-adv/originator.c                        |   14 +-
 net/batman-adv/routing.c                           |    6 +-
 net/batman-adv/send.c                              |    8 +-
 net/batman-adv/tp_meter.c                          |  769 ++---
 net/batman-adv/translation-table.c                 |   66 +-
 net/batman-adv/tvlv.c                              |   63 +-
 net/batman-adv/tvlv.h                              |    3 +-
 net/batman-adv/types.h                             |  299 +-
 net/batman-adv/version.c                           |   12 +
 net/bluetooth/6lowpan.c                            |   25 +-
 net/bluetooth/Kconfig                              |    6 +-
 net/bluetooth/af_bluetooth.c                       |    5 +-
 net/bluetooth/bnep/core.c                          |    5 +-
 net/bluetooth/bnep/netdev.c                        |    5 +-
 net/bluetooth/bnep/sock.c                          |    5 +-
 net/bluetooth/ecdh_helper.c                        |    5 +-
 net/bluetooth/ecdh_helper.h                        |    5 +-
 net/bluetooth/eir.c                                |    8 +-
 net/bluetooth/hci_codec.c                          |    2 +-
 net/bluetooth/hci_conn.c                           |    5 +-
 net/bluetooth/hci_core.c                           |    7 +-
 net/bluetooth/hci_debugfs.c                        |    5 +-
 net/bluetooth/hci_debugfs.h                        |    5 +-
 net/bluetooth/hci_event.c                          |   12 +-
 net/bluetooth/hci_sock.c                           |   31 +-
 net/bluetooth/hci_sync.c                           |   24 +-
 net/bluetooth/hidp/core.c                          |    5 +-
 net/bluetooth/hidp/hidp.h                          |    5 +-
 net/bluetooth/hidp/sock.c                          |    5 +-
 net/bluetooth/iso.c                                |   27 +-
 net/bluetooth/l2cap_core.c                         |   44 +-
 net/bluetooth/l2cap_sock.c                         |   66 +-
 net/bluetooth/lib.c                                |    5 +-
 net/bluetooth/mgmt.c                               |    5 +-
 net/bluetooth/mgmt_util.c                          |    5 +-
 net/bluetooth/mgmt_util.h                          |    5 +-
 net/bluetooth/rfcomm/core.c                        |    5 +-
 net/bluetooth/rfcomm/sock.c                        |   35 +-
 net/bluetooth/rfcomm/tty.c                         |    5 +-
 net/bluetooth/sco.c                                |   64 +-
 net/bluetooth/selftest.c                           |    5 +-
 net/bluetooth/selftest.h                           |    5 +-
 net/bluetooth/smp.c                                |  185 +-
 net/bluetooth/smp.h                                |    5 +-
 net/bridge/Makefile                                |    6 +
 net/bridge/br_arp_nd_proxy.c                       |   48 +-
 net/bridge/br_cfm.c                                |    6 +
 net/bridge/br_cfm_netlink.c                        |    4 +-
 net/bridge/br_device.c                             |    2 +-
 net/bridge/br_fdb.c                                |    9 +-
 net/bridge/br_forward.c                            |   28 +-
 net/bridge/br_if.c                                 |   17 +-
 net/bridge/br_input.c                              |   14 +-
 net/bridge/br_ioctl.c                              |   10 +-
 net/bridge/br_mrp.c                                |   20 +-
 net/bridge/br_mrp_netlink.c                        |    8 +-
 net/bridge/br_multicast.c                          |   35 +-
 net/bridge/br_netlink.c                            |  150 +-
 net/bridge/br_private.h                            |    5 +-
 net/bridge/br_stp.c                                |   51 +-
 net/bridge/br_stp_bpdu.c                           |    2 +-
 net/bridge/br_stp_if.c                             |   16 +-
 net/bridge/br_stp_timer.c                          |    2 +-
 net/bridge/br_switchdev.c                          |    8 +-
 net/bridge/br_sysfs_if.c                           |   72 +-
 net/bridge/br_vlan.c                               |    1 +
 net/bridge/br_vlan_options.c                       |   26 +-
 net/bridge/netfilter/Makefile                      |    4 +
 net/bridge/netfilter/ebtables.c                    |    4 +
 net/core/dev.c                                     |  133 +-
 net/core/dev.h                                     |    8 +
 net/core/dev_addr_lists.c                          |   55 +-
 net/core/dev_ioctl.c                               |    4 +-
 net/core/devmem.c                                  |    6 +-
 net/core/devmem.h                                  |   10 +-
 net/core/drop_monitor.c                            |    6 +-
 net/core/fib_rules.c                               |    6 +-
 net/core/filter.c                                  |   27 +
 net/core/gen_stats.c                               |   51 +-
 net/core/link_watch.c                              |    2 +-
 net/core/lock_debug.c                              |    3 +-
 net/core/neighbour.c                               |    7 -
 net/core/net-sysfs.c                               |    6 -
 net/core/netdev-genl-gen.c                         |   40 +-
 net/core/netdev-genl.c                             |   65 +-
 net/core/netdev_queues.c                           |    2 +-
 net/core/netdev_rx_queue.c                         |    8 +-
 net/core/netpoll.c                                 |  189 +-
 net/core/page_pool.c                               |   10 +-
 net/core/page_pool_user.c                          |   52 +-
 net/core/rtnetlink.c                               |  188 +-
 net/core/skbuff.c                                  |    7 +-
 net/core/skmsg.c                                   |   54 +-
 net/core/sock.c                                    |   35 +-
 net/core/sock_destructor.h                         |   12 -
 net/core/stream.c                                  |    1 -
 net/devlink/netlink_gen.c                          |    2 +
 net/devlink/param.c                                |  127 +-
 net/devlink/resource.c                             |    2 +
 net/dns_resolver/dns_query.c                       |   37 +-
 net/dsa/Kconfig                                    |   10 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag_netc.c                                 |  214 ++
 net/dsa/tag_yt921x.c                               |    2 +
 net/dsa/user.c                                     |    2 +-
 net/ethtool/cabletest.c                            |   12 +-
 net/ethtool/cmis_cdb.c                             |    3 +
 net/ethtool/cmis_fw_update.c                       |    8 +-
 net/ethtool/common.c                               |    4 +-
 net/ethtool/common.h                               |   83 +
 net/ethtool/ioctl.c                                |  151 +-
 net/ethtool/linkinfo.c                             |    4 +-
 net/ethtool/linkmodes.c                            |    4 +-
 net/ethtool/mm.c                                   |    5 +-
 net/ethtool/module.c                               |    8 +-
 net/ethtool/netlink.c                              |   72 +-
 net/ethtool/netlink.h                              |   12 +-
 net/ethtool/phy.c                                  |    1 -
 net/ethtool/rings.c                                |    4 +-
 net/ethtool/rss.c                                  |   21 +-
 net/ethtool/tsconfig.c                             |   14 +-
 net/ethtool/tsinfo.c                               |   32 +-
 net/handshake/genl.c                               |    2 +-
 net/hsr/hsr_forward.c                              |    2 +-
 net/hsr/hsr_framereg.c                             |   18 +-
 net/hsr/hsr_netlink.c                              |   16 +-
 net/ife/ife.c                                      |    2 +-
 net/ipv4/Kconfig                                   |    8 +-
 net/ipv4/Makefile                                  |    5 +-
 net/ipv4/af_inet.c                                 |    9 +-
 net/ipv4/devinet.c                                 |  156 +-
 net/ipv4/fib_frontend.c                            |   66 +-
 net/ipv4/fib_rules.c                               |   11 +-
 net/ipv4/fib_semantics.c                           |    4 -
 net/ipv4/fib_trie.c                                |   14 +-
 net/ipv4/fou_core.c                                |   21 +-
 net/ipv4/igmp.c                                    |   52 +-
 net/ipv4/inet_connection_sock.c                    |    7 +-
 net/ipv4/inet_fragment.c                           |    4 -
 net/ipv4/inet_hashtables.c                         |    2 -
 net/ipv4/ip_gre.c                                  |    8 +-
 net/ipv4/ip_output.c                               |    1 -
 net/ipv4/ip_tunnel.c                               |   13 +-
 net/ipv4/ipcomp.c                                  |    2 +-
 net/ipv4/ipip.c                                    |    8 +-
 net/ipv4/ipmr.c                                    |   22 +-
 net/ipv4/ipmr_base.c                               |    2 +-
 net/ipv4/netfilter/Makefile                        |    4 +
 net/ipv4/netfilter/arp_tables.c                    |    4 +
 net/ipv4/netfilter/ip_tables.c                     |    4 +
 net/ipv4/netfilter/nf_nat_h323.c                   |   12 +
 net/ipv4/netfilter/nf_nat_pptp.c                   |   14 +-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |   27 +-
 net/ipv4/nexthop.c                                 |   88 +-
 net/ipv4/raw.c                                     |    6 -
 net/ipv4/route.c                                   |    3 -
 net/ipv4/syncookies.c                              |    6 +-
 net/ipv4/tcp.c                                     |   26 +-
 net/ipv4/tcp_ao.c                                  |  669 +++--
 net/ipv4/tcp_bbr.c                                 |    2 +-
 net/ipv4/tcp_input.c                               |   27 +-
 net/ipv4/tcp_ipv4.c                                |    1 -
 net/ipv4/tcp_minisocks.c                           |    2 -
 net/ipv4/tcp_output.c                              |   89 +-
 net/ipv4/tcp_plb.c                                 |    2 +-
 net/ipv4/tcp_sigpool.c                             |  366 ---
 net/ipv4/tcp_timer.c                               |    2 +-
 net/ipv4/udp_tunnel_core.c                         |   23 +-
 net/ipv6/Makefile                                  |    4 +
 net/ipv6/addrconf.c                                |   25 +-
 net/ipv6/addrconf_core.c                           |    6 -
 net/ipv6/af_inet6.c                                |    5 +-
 net/ipv6/exthdrs.c                                 |    9 +-
 net/ipv6/inet6_connection_sock.c                   |    8 +-
 net/ipv6/ioam6.c                                   |    4 +-
 net/ipv6/ip6_fib.c                                 |    1 -
 net/ipv6/ip6_flowlabel.c                           |    4 +-
 net/ipv6/ip6_gre.c                                 |   10 +-
 net/ipv6/ip6_offload.c                             |    2 +
 net/ipv6/ip6_output.c                              |    1 -
 net/ipv6/ip6_tunnel.c                              |   13 +-
 net/ipv6/ip6_udp_tunnel.c                          |    6 +-
 net/ipv6/ip6mr.c                                   |  329 ++-
 net/ipv6/ipcomp6.c                                 |    2 +-
 net/ipv6/mcast.c                                   |   83 +-
 net/ipv6/netfilter/Makefile                        |    4 +
 net/ipv6/netfilter/ip6_tables.c                    |    4 +
 net/ipv6/output_core.c                             |    1 -
 net/ipv6/reassembly.c                              |   46 +-
 net/ipv6/route.c                                   |   30 +-
 net/ipv6/sit.c                                     |   22 +-
 net/ipv6/syncookies.c                              |    2 +
 net/ipv6/tcp_ao.c                                  |  131 +-
 net/ipv6/tcp_ipv6.c                                |   21 +-
 net/iucv/af_iucv.c                                 |   14 +-
 net/kcm/kcmsock.c                                  |   24 +-
 net/key/af_key.c                                   |   12 +-
 net/l2tp/l2tp_core.c                               |    2 +-
 net/l2tp/l2tp_ppp.c                                |   20 +-
 net/llc/Makefile                                   |    8 +-
 net/llc/af_llc.c                                   |   26 +-
 net/llc/llc_c_ac.c                                 |   16 +-
 net/llc/llc_c_ev.c                                 |    8 +-
 net/llc/llc_c_st.c                                 |    8 +-
 net/llc/llc_conn.c                                 |    8 +-
 net/llc/llc_core.c                                 |    8 +-
 net/llc/llc_if.c                                   |    8 +-
 net/llc/llc_input.c                                |    8 +-
 net/llc/llc_pdu.c                                  |    8 +-
 net/llc/llc_proc.c                                 |    8 +-
 net/llc/llc_s_ac.c                                 |    8 +-
 net/llc/llc_s_ev.c                                 |    8 +-
 net/llc/llc_s_st.c                                 |    8 +-
 net/llc/llc_sap.c                                  |    8 +-
 net/llc/llc_station.c                              |    8 +-
 net/mac80211/Makefile                              |    2 +-
 net/mac80211/agg-rx.c                              |   22 +-
 net/mac80211/ap.c                                  |  353 +++
 net/mac80211/cfg.c                                 |  250 +-
 net/mac80211/chan.c                                |  238 +-
 net/mac80211/debugfs.c                             |   47 +-
 net/mac80211/eht.c                                 |  179 +-
 net/mac80211/he.c                                  |   30 +-
 net/mac80211/ht.c                                  |   77 +-
 net/mac80211/ibss.c                                |   34 +-
 net/mac80211/ieee80211_i.h                         |  153 +-
 net/mac80211/iface.c                               |   68 +-
 net/mac80211/key.c                                 |   22 +-
 net/mac80211/link.c                                |   35 +-
 net/mac80211/main.c                                |    7 +-
 net/mac80211/mesh.c                                |   36 +-
 net/mac80211/mesh_hwmp.c                           |  176 +-
 net/mac80211/mesh_plink.c                          |    5 +-
 net/mac80211/mlme.c                                | 1150 ++++++--
 net/mac80211/nan.c                                 |  137 +
 net/mac80211/ocb.c                                 |    5 +-
 net/mac80211/offchannel.c                          |   17 +-
 net/mac80211/parse.c                               |   71 +-
 net/mac80211/rate.c                                |   12 +-
 net/mac80211/rx.c                                  |   78 +-
 net/mac80211/spectmgmt.c                           |   10 -
 net/mac80211/sta_info.c                            |  366 ++-
 net/mac80211/sta_info.h                            |   51 +-
 net/mac80211/status.c                              |   34 +-
 net/mac80211/tdls.c                                |   24 +-
 net/mac80211/tests/.kunitconfig                    |    4 +
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/chan-mode.c                     |    4 +-
 net/mac80211/tests/elems.c                         |  282 ++
 net/mac80211/tests/ttlm.c                          |  175 ++
 net/mac80211/trace.h                               |   14 +-
 net/mac80211/tx.c                                  |  131 +-
 net/mac80211/uhr.c                                 |    5 +-
 net/mac80211/util.c                                |   81 +-
 net/mac80211/vht.c                                 |  350 +--
 net/mctp/af_mctp.c                                 |   10 +-
 net/mctp/test/route-test.c                         |    6 -
 net/mpls/af_mpls.c                                 |    6 +-
 net/mptcp/ctrl.c                                   |   18 +-
 net/mptcp/options.c                                |   97 +-
 net/mptcp/pm.c                                     |  191 +-
 net/mptcp/pm_kernel.c                              |   95 +-
 net/mptcp/pm_userspace.c                           |    6 +-
 net/mptcp/protocol.h                               |   48 +-
 net/mptcp/subflow.c                                |    4 +-
 net/netfilter/Kconfig                              |   10 +-
 net/netfilter/Makefile                             |    6 +-
 net/netfilter/ipset/Kconfig                        |    9 +
 net/netfilter/ipset/Makefile                       |    3 +
 net/netfilter/ipvs/Kconfig                         |    9 +
 net/netfilter/ipvs/Makefile                        |    3 +
 net/netfilter/ipvs/ip_vs_conn.c                    |   14 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   63 +-
 net/netfilter/nf_conncount.c                       |  243 +-
 net/netfilter/nf_conntrack_amanda.c                |   39 +-
 net/netfilter/nf_conntrack_broadcast.c             |    3 +
 net/netfilter/nf_conntrack_core.c                  |   92 +-
 net/netfilter/nf_conntrack_expect.c                |   33 +-
 net/netfilter/nf_conntrack_extend.c                |   32 +-
 net/netfilter/nf_conntrack_ftp.c                   |   22 +-
 net/netfilter/nf_conntrack_h323_main.c             |  125 +-
 net/netfilter/nf_conntrack_helper.c                |  125 +-
 net/netfilter/nf_conntrack_irc.c                   |   11 +-
 net/netfilter/nf_conntrack_netbios_ns.c            |   20 +-
 net/netfilter/nf_conntrack_netlink.c               |   30 +-
 net/netfilter/nf_conntrack_ovs.c                   |    9 +-
 net/netfilter/nf_conntrack_pptp.c                  |   92 +-
 net/netfilter/nf_conntrack_proto.c                 |   15 +-
 net/netfilter/nf_conntrack_proto_gre.c             |   70 +
 net/netfilter/nf_conntrack_proto_tcp.c             |   18 +-
 net/netfilter/nf_conntrack_sane.c                  |    8 +-
 net/netfilter/nf_conntrack_seqadj.c                |   19 +-
 net/netfilter/nf_conntrack_sip.c                   |   46 +-
 net/netfilter/nf_conntrack_snmp.c                  |   21 +-
 net/netfilter/nf_conntrack_tftp.c                  |    5 +-
 net/netfilter/nf_conntrack_timeout.c               |   27 +-
 net/netfilter/nf_dup_netdev.c                      |   15 +-
 net/netfilter/nf_flow_table_path.c                 |   82 +-
 net/netfilter/nf_nat_sip.c                         |   12 +
 net/netfilter/nf_synproxy_core.c                   |   40 +-
 net/netfilter/nf_tables_api.c                      |   38 +-
 net/netfilter/nf_tables_core.c                     |    8 +-
 net/netfilter/nf_tables_offload.c                  |    2 +-
 net/netfilter/nf_tables_trace.c                    |    6 +-
 net/netfilter/nfnetlink_cthelper.c                 |   89 +-
 net/netfilter/nfnetlink_cttimeout.c                |  112 +-
 net/netfilter/nfnetlink_osf.c                      |    6 +-
 net/netfilter/nft_ct.c                             |   12 +-
 net/netfilter/nft_ct_fast.c                        |    2 +-
 net/netfilter/nft_exthdr.c                         |    2 +-
 net/netfilter/nft_fib.c                            |    2 +-
 net/netfilter/nft_fwd_netdev.c                     |   17 +-
 net/netfilter/nft_inner.c                          |    2 +-
 net/netfilter/nft_lookup.c                         |    2 +-
 net/netfilter/nft_masq.c                           |    2 +-
 net/netfilter/nft_meta.c                           |   10 +-
 net/netfilter/nft_payload.c                        |    6 +-
 net/netfilter/nft_redir.c                          |    2 +-
 net/netfilter/nft_reject.c                         |    8 +-
 net/netfilter/nft_rt.c                             |    2 +-
 net/netfilter/nft_set_hash.c                       |    2 +-
 net/netfilter/nft_set_pipapo.c                     |    2 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   35 +-
 net/netfilter/nft_set_rbtree.c                     |    9 +-
 net/netfilter/nft_socket.c                         |    8 +-
 net/netfilter/nft_tunnel.c                         |    2 +-
 net/netfilter/nft_xfrm.c                           |    6 +-
 net/netfilter/xt_CT.c                              |    3 -
 net/netlabel/netlabel_unlabeled.c                  |    2 +-
 net/netlink/af_netlink.c                           |   21 +-
 net/nfc/nci/uart.c                                 |    2 +-
 net/openvswitch/conntrack.c                        |    2 +-
 net/psp/psp-nl-gen.c                               |   36 +-
 net/psp/psp-nl-gen.h                               |    7 +
 net/psp/psp.h                                      |    4 +-
 net/psp/psp_main.c                                 |  118 +-
 net/psp/psp_nl.c                                   |  387 ++-
 net/qrtr/af_qrtr.c                                 |    6 +-
 net/rds/af_rds.c                                   |   99 +-
 net/rds/connection.c                               |   13 +
 net/rds/ib_cm.c                                    |   25 +-
 net/rds/info.c                                     |   76 +-
 net/rds/info.h                                     |    3 +-
 net/rds/send.c                                     |    2 +-
 net/rds/tcp.c                                      |   63 +-
 net/rds/tcp_listen.c                               |    4 +-
 net/rfkill/core.c                                  |    6 +-
 net/rxrpc/.kunitconfig                             |    6 +
 net/rxrpc/Kconfig                                  |   13 +-
 net/rxrpc/Makefile                                 |    3 +-
 net/rxrpc/af_rxrpc.c                               |   16 +-
 net/rxrpc/ar-internal.h                            |   21 +-
 net/rxrpc/call_accept.c                            |   25 +-
 {crypto => net/rxrpc}/fcrypt.c                     |  354 +--
 net/rxrpc/key.c                                    |    1 -
 net/rxrpc/local_object.c                           |    2 +-
 net/rxrpc/recvmsg.c                                |   13 +-
 net/rxrpc/rxgk.c                                   |    3 +-
 net/rxrpc/rxkad.c                                  |  429 +--
 net/rxrpc/server_key.c                             |    1 -
 net/rxrpc/tests/Makefile                           |    3 +
 net/rxrpc/tests/rxrpc_kunit.c                      |  140 +
 net/sched/act_api.c                                |    2 +-
 net/sched/act_bpf.c                                |    2 +-
 net/sched/act_csum.c                               |    8 +-
 net/sched/act_ife.c                                |   12 +-
 net/sched/act_mpls.c                               |    2 +-
 net/sched/act_pedit.c                              |    4 +
 net/sched/act_police.c                             |    4 +-
 net/sched/act_skbedit.c                            |    2 +-
 net/sched/act_skbmod.c                             |    2 +-
 net/sched/cls_bpf.c                                |   10 +-
 net/sched/cls_flow.c                               |   12 +-
 net/sched/sch_api.c                                |  154 +-
 net/sched/sch_cake.c                               |   20 +-
 net/sched/sch_cbs.c                                |   10 +-
 net/sched/sch_choke.c                              |    8 +-
 net/sched/sch_codel.c                              |   50 +-
 net/sched/sch_drr.c                                |   20 +-
 net/sched/sch_dualpi2.c                            |  116 +-
 net/sched/sch_etf.c                                |    8 +-
 net/sched/sch_ets.c                                |   16 +-
 net/sched/sch_fq.c                                 |   85 +-
 net/sched/sch_fq_codel.c                           |   56 +-
 net/sched/sch_fq_pie.c                             |    8 +-
 net/sched/sch_generic.c                            |   59 +-
 net/sched/sch_gred.c                               |    4 +-
 net/sched/sch_hfsc.c                               |   30 +-
 net/sched/sch_hhf.c                                |    7 +-
 net/sched/sch_htb.c                                |   82 +-
 net/sched/sch_mq.c                                 |   37 +-
 net/sched/sch_mqprio.c                             |   93 +-
 net/sched/sch_multiq.c                             |    4 +-
 net/sched/sch_netem.c                              |  235 +-
 net/sched/sch_prio.c                               |    6 +-
 net/sched/sch_qfq.c                                |    8 +-
 net/sched/sch_red.c                                |    6 +-
 net/sched/sch_sfb.c                                |    8 +-
 net/sched/sch_sfq.c                                |   11 +-
 net/sched/sch_skbprio.c                            |    4 +-
 net/sched/sch_taprio.c                             |   50 +-
 net/sched/sch_tbf.c                                |   19 +-
 net/sched/sch_teql.c                               |    2 +-
 net/sctp/endpointola.c                             |    2 +-
 net/sctp/ipv6.c                                    |   12 +-
 net/sctp/protocol.c                                |   20 +-
 net/sctp/sm_make_chunk.c                           |   10 +-
 net/shaper/shaper.c                                |   18 +-
 net/smc/smc_core.c                                 |    4 +
 net/smc/smc_ism.c                                  |   10 +-
 net/socket.c                                       |    2 +-
 net/tipc/bearer.c                                  |    1 +
 net/tipc/name_distr.c                              |   13 +-
 net/tipc/netlink.c                                 |   12 +
 net/tipc/socket.c                                  |   42 +-
 net/tipc/udp_media.c                               |   32 +-
 net/tls/Kconfig                                    |   10 -
 net/tls/Makefile                                   |    1 -
 net/tls/tls.h                                      |    6 +-
 net/tls/tls_device.c                               |   11 +-
 net/tls/tls_main.c                                 |   38 +-
 net/tls/tls_strp.c                                 |   26 +-
 net/tls/tls_sw.c                                   |  466 +--
 net/tls/tls_toe.c                                  |  141 -
 net/unix/af_unix.c                                 |    7 +-
 net/vmw_vsock/af_vsock.c                           |   31 +-
 net/vmw_vsock/hyperv_transport.c                   |    3 +-
 net/vmw_vsock/virtio_transport_common.c            |    3 +-
 net/vmw_vsock/vmci_transport.c                     |   10 +-
 net/wireless/chan.c                                |  287 +-
 net/wireless/core.c                                |   61 +-
 net/wireless/core.h                                |    5 +-
 net/wireless/mlme.c                                |   11 +-
 net/wireless/nl80211.c                             |  665 ++++-
 net/wireless/nl80211.h                             |    5 +-
 net/wireless/pmsr.c                                |  190 +-
 net/wireless/rdev-ops.h                            |   26 +-
 net/wireless/reg.c                                 |    3 +
 net/wireless/scan.c                                |    6 +-
 net/wireless/sme.c                                 |    1 +
 net/wireless/tests/chan.c                          |  192 +-
 net/wireless/trace.h                               |   38 +-
 net/wireless/util.c                                |   32 +-
 net/wireless/wext-compat.c                         |    6 +-
 net/x25/af_x25.c                                   |   16 +-
 net/xdp/xsk.c                                      |   24 +-
 net/xdp/xsk_buff_pool.c                            |    2 +-
 net/xfrm/xfrm_compat.c                             |    5 +-
 net/xfrm/xfrm_device.c                             |    2 +-
 net/xfrm/xfrm_policy.c                             |   25 +-
 net/xfrm/xfrm_state.c                              |  152 +-
 net/xfrm/xfrm_user.c                               |  503 +++-
 security/selinux/nlmsgtab.c                        |    3 +-
 tools/include/uapi/linux/if_link.h                 |    2 +
 tools/include/uapi/linux/netdev.h                  |    2 +
 tools/net/ynl/pyynl/lib/nlspec.py                  |    9 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |    5 +
 tools/net/ynl/ynltool/page-pool.c                  |    6 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c        |  420 +--
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |  197 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.h  |    3 +-
 .../selftests/bpf/progs/test_sockmap_kern.h        |   56 -
 .../selftests/bpf/progs/test_sockmap_ktls.c        |   61 -
 tools/testing/selftests/bpf/test_sockmap.c         |  250 +-
 tools/testing/selftests/drivers/net/.gitignore     |    1 +
 tools/testing/selftests/drivers/net/Makefile       |    2 +
 .../testing/selftests/drivers/net/bonding/Makefile |    1 +
 .../drivers/net/bonding/bond_lacp_strict.sh        |  347 +++
 tools/testing/selftests/drivers/net/config         |    5 +
 tools/testing/selftests/drivers/net/gro.py         |   29 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |    3 +
 tools/testing/selftests/drivers/net/hw/config      |    5 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |   77 +-
 .../testing/selftests/drivers/net/hw/devmem_lib.py |  222 ++
 tools/testing/selftests/drivers/net/hw/gro_hw.py   |   10 +
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c  |    6 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   38 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    4 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |   58 +-
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |   46 +
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |   39 +
 .../testing/selftests/drivers/net/hw/nk_qlease.py  |  306 +-
 tools/testing/selftests/drivers/net/hw/ntuple.py   |    5 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   98 +-
 tools/testing/selftests/drivers/net/hw/tso.py      |    3 +
 .../selftests/drivers/net/hw/userns_devmem.py      |   49 +
 .../selftests/drivers/net/lib/py/__init__.py       |    9 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |  160 +-
 tools/testing/selftests/drivers/net/psp.py         |  425 ++-
 .../selftests/{ => drivers}/net/so_txtime.c        |   33 +-
 tools/testing/selftests/drivers/net/so_txtime.py   |  118 +
 tools/testing/selftests/net/.gitignore             |    2 +-
 tools/testing/selftests/net/Makefile               |    5 +-
 tools/testing/selftests/net/bind_bhash.c           |    9 +-
 tools/testing/selftests/net/config                 |    3 +
 tools/testing/selftests/net/ecmp_rehash.sh         | 1109 ++++++++
 tools/testing/selftests/net/fib_tests.sh           |  308 +-
 .../selftests/net/forwarding/bridge_vlan_mcast.sh  |  140 +-
 tools/testing/selftests/net/forwarding/ipmr.c      |  189 +-
 tools/testing/selftests/net/getsockopt_iter.c      |  300 ++
 tools/testing/selftests/net/lib/gro.c              |  120 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    8 +-
 tools/testing/selftests/net/lib/py/netns.py        |   75 +-
 tools/testing/selftests/net/lib/py/utils.py        |   58 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  116 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   56 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |    8 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   34 +-
 tools/testing/selftests/net/netfilter/Makefile     |    1 +
 tools/testing/selftests/net/netfilter/config       |    6 +
 .../testing/selftests/net/netfilter/nft_offload.sh |  132 +
 tools/testing/selftests/net/nl_netdev.py           |  119 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  292 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  403 ++-
 .../net/packetdrill/tcp_syncookies_ip4_9k.pkt      |   37 +
 .../net/packetdrill/tcp_syncookies_ip6_9k.pkt      |   36 +
 tools/testing/selftests/net/ppp/Makefile           |    1 +
 tools/testing/selftests/net/ppp/config             |    2 +
 .../testing/selftests/net/ppp/pppoe-server-options |    1 +
 tools/testing/selftests/net/ppp/pppol2tp.sh        |  110 +
 tools/testing/selftests/net/protodown.sh           |  182 ++
 tools/testing/selftests/net/rds/.gitignore         |    1 +
 tools/testing/selftests/net/rds/Makefile           |    6 +-
 tools/testing/selftests/net/rds/README.txt         |   59 +-
 tools/testing/selftests/net/rds/config             |    1 -
 tools/testing/selftests/net/rds/config.sh          |   18 +-
 tools/testing/selftests/net/rds/getsockopt.c       |  208 ++
 tools/testing/selftests/net/rds/rds_run.sh         |  319 +++
 tools/testing/selftests/net/rds/run.sh             |  227 --
 tools/testing/selftests/net/rds/settings           |    2 +-
 tools/testing/selftests/net/rds/test.py            |  659 +++--
 tools/testing/selftests/net/rtnetlink.py           |   41 +-
 tools/testing/selftests/net/so_txtime.sh           |  110 -
 tools/testing/selftests/net/tcp_ao/config          |    4 -
 .../testing/selftests/net/tcp_ao/key-management.c  |   41 +-
 .../selftests/net/test_bridge_neigh_suppress.sh    |  468 ++-
 tools/testing/selftests/net/tls.c                  |    4 +-
 tools/testing/selftests/tc-testing/config          |    1 +
 .../selftests/tc-testing/plugin-lib/nsPlugin.py    |    7 +
 .../selftests/tc-testing/tc-tests/actions/ife.json |   55 +
 .../tc-testing/tc-tests/actions/pedit.json         |   49 +
 .../tc-testing/tc-tests/infra/qdiscs.json          |  344 ++-
 tools/testing/selftests/tc-testing/tdc.py          |    3 +
 tools/testing/selftests/tc-testing/tdc_config.py   |    1 +
 tools/testing/selftests/vsock/vmtest.sh            |   53 +-
 1913 files changed, 85554 insertions(+), 49966 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8801.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/dsa.txt
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lan9303.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml
 delete mode 100644 Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst
 create mode 100644 Documentation/networking/xfrm/xfrm_migrate_state.rst
 delete mode 100644 crypto/pcbc.c
 delete mode 100644 drivers/bluetooth/bluecard_cs.c
 delete mode 100644 drivers/bluetooth/bt3c_cs.c
 delete mode 100644 drivers/bluetooth/dtl1_cs.c
 delete mode 100644 drivers/net/Space.c
 delete mode 100644 drivers/net/arcnet/arc-rimi.c
 delete mode 100644 drivers/net/arcnet/com20020-isa.c
 delete mode 100644 drivers/net/arcnet/com20020_cs.c
 delete mode 100644 drivers/net/arcnet/com90io.c
 delete mode 100644 drivers/net/arcnet/com90xx.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_l2.c
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_l2.h
 rename drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} (75%)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_table.c
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_table.h
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_vlan.c
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_vlan.h
 create mode 100644 drivers/net/ethernet/alibaba/Kconfig
 create mode 100644 drivers/net/ethernet/alibaba/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/Makefile
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
 delete mode 100644 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
 delete mode 100644 drivers/net/ethernet/wiznet/w5300.c
 create mode 100644 drivers/net/phy/air_an8801.c
 create mode 100644 drivers/net/phy/air_phy_lib.c
 create mode 100644 drivers/net/phy/air_phy_lib.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (90%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h
 delete mode 100644 include/linux/atalk.h
 delete mode 100644 include/linux/atm_tcp.h
 create mode 100644 include/linux/dsa/tag_netc.h
 delete mode 100644 include/linux/ks8851_mll.h
 delete mode 100644 include/linux/platform_data/wiznet.h
 delete mode 100644 include/net/Space.h
 delete mode 100644 include/net/tls_toe.h
 delete mode 100644 include/uapi/linux/atm_eni.h
 delete mode 100644 include/uapi/linux/atm_he.h
 delete mode 100644 include/uapi/linux/atm_idt77105.h
 delete mode 100644 include/uapi/linux/atm_nicstar.h
 delete mode 100644 include/uapi/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_zatm.h
 delete mode 100644 include/uapi/linux/atmarp.h
 delete mode 100644 include/uapi/linux/atmclip.h
 delete mode 100644 include/uapi/linux/atmlec.h
 delete mode 100644 include/uapi/linux/atmmpc.h
 delete mode 100644 include/uapi/linux/atmsvc.h
 delete mode 100644 net/appletalk/Kconfig
 delete mode 100644 net/appletalk/Makefile
 delete mode 100644 net/appletalk/aarp.c
 delete mode 100644 net/appletalk/atalk_proc.c
 delete mode 100644 net/appletalk/ddp.c
 delete mode 100644 net/appletalk/sysctl_net_atalk.c
 delete mode 100644 net/atm/addr.c
 delete mode 100644 net/atm/addr.h
 delete mode 100644 net/atm/signaling.c
 delete mode 100644 net/atm/signaling.h
 delete mode 100644 net/atm/svc.c
 create mode 100644 net/batman-adv/version.c
 delete mode 100644 net/core/sock_destructor.h
 create mode 100644 net/dsa/tag_netc.c
 delete mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/mac80211/ap.c
 create mode 100644 net/mac80211/tests/.kunitconfig
 create mode 100644 net/mac80211/tests/ttlm.c
 create mode 100644 net/rxrpc/.kunitconfig
 rename {crypto => net/rxrpc}/fcrypt.c (65%)
 create mode 100644 net/rxrpc/tests/Makefile
 create mode 100644 net/rxrpc/tests/rxrpc_kunit.c
 delete mode 100644 net/tls/tls_toe.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_strict.sh
 create mode 100644 tools/testing/selftests/drivers/net/hw/devmem_lib.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/userns_devmem.py
 rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (95%)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh
 create mode 100644 tools/testing/selftests/net/getsockopt_iter.c
 create mode 100755 tools/testing/selftests/net/netfilter/nft_offload.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_ip4_9k.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
 create mode 100755 tools/testing/selftests/net/ppp/pppol2tp.sh
 create mode 100755 tools/testing/selftests/net/protodown.sh
 create mode 100644 tools/testing/selftests/net/rds/getsockopt.c
 create mode 100755 tools/testing/selftests/net/rds/rds_run.sh
 delete mode 100755 tools/testing/selftests/net/rds/run.sh
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

