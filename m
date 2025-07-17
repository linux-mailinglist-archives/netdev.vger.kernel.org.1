Return-Path: <netdev+bounces-207937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16321B09143
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FDA1892EB0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26B2F6FBA;
	Thu, 17 Jul 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU+X5i6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457911B4247;
	Thu, 17 Jul 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768249; cv=none; b=mJ1sLxqZzC+nFUWy3E3U0bq5qId1UgIpbAeq24ADO0uoTla2JzJTS/4/z5XHaeZHQx+IyZisb11hW39e3ho1fB89LObUe5jlWYg/vyC4TlbLJhiuQ4uc0pAqL+VmEz2V517mlYcq4zqyi+EqD35QX13PNoJXEd/RF2zHTjkPspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768249; c=relaxed/simple;
	bh=8RHVWtYzQi/sgV9PaCSQc1/swoXUbMQBDPGhbZ978TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZMU4biAb6U9SyOpbVIlPujbNjoUss85q13G6Z09AU7IWK9F7gUlVkMH9O3MzCsSHgfh4utBxqVBnm1yRhzSBfYJVA0qVelorcfGPehtrmLDQo7tB8G7wLvgASrv2GlRHCG4GEO9dy3+1uLdRLozBmU1ADeBdHjcTiJ1Pn9xfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU+X5i6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A3BC4CEE3;
	Thu, 17 Jul 2025 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752768249;
	bh=8RHVWtYzQi/sgV9PaCSQc1/swoXUbMQBDPGhbZ978TM=;
	h=From:To:Cc:Subject:Date:From;
	b=CU+X5i6SBFIL8QcCVyXMEK2y5UEtFE6TEuVN0kSBmRA2aUSYHuVKr5m9KUy2j63J4
	 pFSDeNFrGQvngva2JGYmxWfVFqr9F1LUGxNLjYsqSpv+FWOpgQEY1t08tcGY8xp+yt
	 c7DGr4VUC55/MBafC1q7x+cMRgLtZTHK4pMc5VYCERG/iq6yUPav22aJSaaak3QDus
	 UCGfAhOnG2PNd4LgutsbyzKkKi+wtxSgZywDmEB4AqDbpaobA8c3Cm870lYBsPBReb
	 REKUj2nGAoUWX05leAV8rWOZnK675KYGaEhjeYwp+YWCvU8fuzm/3Wo7lJWW3rdzmN
	 RODlWwstYenxg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.16-rc7
Date: Thu, 17 Jul 2025 09:04:08 -0700
Message-ID: <20250717160408.2981607-1-kuba@kernel.org>
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

The following changes since commit c7979c3917fa1326dae3607e1c6a04c12057b194:

  Merge tag 'net-6.16-rc6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-11 10:18:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc7

for you to fetch changes up to a2bbaff6816a1531fd61b07739c3f2a500cd3693:

  Merge tag 'for-net-2025-07-17' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2025-07-17 07:54:49 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, CAN, WiFi and Netfilter.

More code here than I would have liked. That said, better now than
next week. Nothing particularly scary stands out. The improvement to
the OpenVPN input validation is a bit large but better get them in
before the code makes it to a final release. Some of the changes
we got from sub-trees could have been split better between the fix
and -next refactoring, IMHO, that has been communicated.

We have one known regression in a TI AM65 board not getting link.
The investigation is going a bit slow, a number of people are on
vacation. We'll try to wrap it up, but don't think it should hold
up the release.

Current release - fix to a fix:

 - Bluetooth: L2CAP: fix attempting to adjust outgoing MTU, it broke
   some headphones and speakers

Current release - regressions:

 - wifi: ath12k: fix packets received in WBM error ring with REO LUT
   enabled, fix Rx performance regression

 - wifi: iwlwifi:
   - fix crash due to a botched indexing conversion
   - mask reserved bits in chan_state_active_bitmap, avoid FW assert()

Current release - new code bugs:

 - nf_conntrack: fix crash due to removal of uninitialised entry

 - eth: airoha: fix potential UaF in airoha_npu_get()

Previous releases - regressions:

 - net: fix segmentation after TCP/UDP fraglist GRO

 - af_packet: fix the SO_SNDTIMEO constraint not taking effect and
   a potential soft lockup waiting for a completion

 - rpl: fix UaF in rpl_do_srh_inline() for sneaky skb geometry

 - virtio-net: fix recursive rtnl_lock() during probe()

 - eth: stmmac: populate entire system_counterval_t in get_time_fn()

 - eth: libwx: fix a number of crashes in the driver Rx path

 - hv_netvsc: prevent IPv6 addrconf after IFF_SLAVE lost that meaning

Previous releases - always broken:

 - mptcp: fix races in handling connection fallback to pure TCP

 - rxrpc: assorted error handling and race fixes

 - sched: another batch of "security" fixes for qdiscs (QFQ, HTB)

 - tls: always refresh the queue when reading sock, avoid UaF

 - phy: don't register LEDs for genphy, avoid deadlock

 - Bluetooth: btintel: check if controller is ISO capable on
   btintel_classify_pkt_type(), work around FW returning incorrect
   capabilities

Misc:

 - make OpenVPN Netlink input checking more strict before it makes it
   to a final release

 - wifi: cfg80211: remove scan request n_channels __counted_by, its only
   yeilding false positives

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alessandro Gasbarroni (1):
      Bluetooth: hci_sync: fix connectable extended advertising when using static random address

Alok Tiwari (2):
      net: emaclite: Fix missing pointer increment in aligned_read()
      net: airoha: fix potential use-after-free in airoha_npu_get()

Antonio Quartulli (1):
      ovpn: reject unexpected netlink attributes

Arnd Bergmann (1):
      ethernet: intel: fix building with large NR_CPUS

Brett Werling (1):
      can: tcan4x5x: fix reset gpio usage during probe

Christian Eggers (3):
      Bluetooth: hci_core: fix typos in macros
      Bluetooth: hci_core: add missing braces when using macro parameters
      Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap

Christoph Paasch (1):
      net/mlx5: Correctly set gso_size when LRO is used

Dave Ertman (1):
      ice: add NULL check in eswitch lag check

David Howells (5):
      rxrpc: Fix irq-disabled in local_bh_enable()
      rxrpc: Fix recv-recv race of completed call
      rxrpc: Fix notification vs call-release vs recvmsg
      rxrpc: Fix transmission of an abort in response to an abort
      rxrpc: Fix to use conn aborts for conn-wide failures

David S. Miller (1):
      Merge branch 'tpacket_snd-bugs' into main

Dong Chenchen (2):
      net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
      selftests: Add test cases for vlan_filter modification during runtime

Felix Fietkau (1):
      net: fix segmentation after TCP/UDP fraglist GRO

Florian Westphal (6):
      selftests: netfilter: conntrack_resize.sh: extend resize test
      selftests: netfilter: add conntrack clash resolution test case
      selftests: netfilter: conntrack_resize.sh: also use udpclash tool
      selftests: netfilter: nft_concat_range.sh: send packets to empty set
      netfilter: nf_tables: hide clash bit from userspace
      netfilter: nf_conntrack: fix crash due to removal of uninitialised entry

Jakub Kicinski (9):
      Merge tag 'linux-can-fixes-for-6.16-20250715' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'fix-rx-fatal-errors'
      Merge branch 'mptcp-fix-fallback-related-races'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      tls: always refresh the queue when reading sock
      Merge tag 'ovpn-net-20250716' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'net-vlan-fix-vlan-0-refcount-imbalance-of-toggling-filtering-during-runtime'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge tag 'for-net-2025-07-17' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Jiawen Wu (4):
      net: libwx: remove duplicate page_pool_put_full_page()
      net: libwx: fix the using of Rx buffer DMA
      net: libwx: properly reset Rx ring descriptor
      net: libwx: fix multicast packets received count

Johannes Berg (4):
      wifi: iwlwifi: pcie: fix locking on invalid TOP reset
      Merge tag 'ath-current-20250714' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: cfg80211: remove scan request n_channels counted_by
      Merge tag 'iwlwifi-fixes-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Joseph Huang (1):
      net: bridge: Do not offload IGMP/MLD messages

Kuniyuki Iwashima (3):
      rpl: Fix use-after-free in rpl_do_srh_inline().
      smc: Fix various oops due to inet_sock type confusion.
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Li Tian (1):
      hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf

Luiz Augusto von Dentz (4):
      Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
      Bluetooth: SMP: If an unallowed command is received consider it a failure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Maor Gottlieb (1):
      net/mlx5: Update the list of the PCI supported devices

Markus Blöchl (1):
      net: stmmac: intel: populate entire system_counterval_t in get_time_fn() callback

Michal Swiatkowski (1):
      ice: check correct pointer in fwlog debugfs

Nathan Chancellor (1):
      phonet/pep: Move call to pn_skb_get_dst_sockaddr() earlier in pep_sock_accept()

Nithyanantham Paramasivam (1):
      wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled

Oliver Neukum (1):
      usb: net: sierra: check for no status endpoint

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mask reserved bits in chan_state_active_bitmap

Paolo Abeni (6):
      selftests: net: increase inter-packet timeout in udpgro.sh
      mptcp: make fallback action and fallback decision atomic
      mptcp: plug races between subflow fail and subflow creation
      mptcp: reset fallback status gracefully at disconnect() time
      Merge tag 'nf-25-07-17' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'wireless-2025-07-17' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Phil Sutter (1):
      Revert "netfilter: nf_tables: Add notifications for hook changes"

Ralf Lici (2):
      ovpn: propagate socket mark to skb in UDP
      ovpn: reset GSO metadata after decapsulation

Sean Anderson (1):
      net: phy: Don't register LEDs for genphy

Victor Nogueira (1):
      selftests/tc-testing: Create test cases for adding qdiscs to invalid qdisc parents

Ville Syrjälä (1):
      wifi: iwlwifi: Fix botched indexing conversion

William Liu (2):
      net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
      selftests/tc-testing: Test htb_dequeue_tree with deactivation and row emptying

Xiang Mei (1):
      net/sched: sch_qfq: Fix race condition on qfq_aggregate

Yue Haibing (1):
      ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

Yun Lu (2):
      af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
      af_packet: fix soft lockup issue caused by tpacket_snd()

Zigit Zo (1):
      virtio-net: fix recursived rtnl_lock() during probe()

Zijun Hu (1):
      Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID

 Documentation/netlink/specs/ovpn.yaml              | 153 +++++++++++++++++-
 drivers/bluetooth/bfusb.c                          |   2 +-
 drivers/bluetooth/bpa10x.c                         |   2 +-
 drivers/bluetooth/btbcm.c                          |   8 +-
 drivers/bluetooth/btintel.c                        |  30 ++--
 drivers/bluetooth/btintel_pcie.c                   |   8 +-
 drivers/bluetooth/btmtksdio.c                      |   4 +-
 drivers/bluetooth/btmtkuart.c                      |   2 +-
 drivers/bluetooth/btnxpuart.c                      |   2 +-
 drivers/bluetooth/btqca.c                          |   2 +-
 drivers/bluetooth/btqcomsmd.c                      |   2 +-
 drivers/bluetooth/btrtl.c                          |  10 +-
 drivers/bluetooth/btsdio.c                         |   2 +-
 drivers/bluetooth/btusb.c                          | 148 +++++++++--------
 drivers/bluetooth/hci_aml.c                        |   2 +-
 drivers/bluetooth/hci_bcm.c                        |   4 +-
 drivers/bluetooth/hci_bcm4377.c                    |  10 +-
 drivers/bluetooth/hci_intel.c                      |   2 +-
 drivers/bluetooth/hci_ldisc.c                      |   6 +-
 drivers/bluetooth/hci_ll.c                         |   4 +-
 drivers/bluetooth/hci_nokia.c                      |   2 +-
 drivers/bluetooth/hci_qca.c                        |  14 +-
 drivers/bluetooth/hci_serdev.c                     |   8 +-
 drivers/bluetooth/hci_vhci.c                       |   8 +-
 drivers/bluetooth/virtio_bt.c                      |  10 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |  61 ++++---
 drivers/net/ethernet/airoha/airoha_npu.c           |   3 +-
 drivers/net/ethernet/intel/fm10k/fm10k.h           |   3 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   2 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   8 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  20 +--
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   2 -
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |   5 +-
 drivers/net/ovpn/io.c                              |   7 +
 drivers/net/ovpn/netlink-gen.c                     |  61 ++++++-
 drivers/net/ovpn/netlink-gen.h                     |   6 +
 drivers/net/ovpn/netlink.c                         |  51 +++++-
 drivers/net/ovpn/udp.c                             |   1 +
 drivers/net/phy/phy_device.c                       |   6 +-
 drivers/net/usb/sierra_net.c                       |   4 +
 drivers/net/virtio_net.c                           |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   1 +
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   8 +-
 include/net/bluetooth/hci.h                        |   2 +
 include/net/bluetooth/hci_core.h                   |  50 +++---
 include/net/cfg80211.h                             |   2 +-
 include/net/netfilter/nf_conntrack.h               |  15 +-
 include/net/netfilter/nf_tables.h                  |   5 -
 include/trace/events/rxrpc.h                       |   6 +-
 include/uapi/linux/netfilter/nf_tables.h           |  10 --
 include/uapi/linux/netfilter/nfnetlink.h           |   2 -
 net/8021q/vlan.c                                   |  42 +++--
 net/8021q/vlan.h                                   |   1 +
 net/bluetooth/hci_core.c                           |   4 +-
 net/bluetooth/hci_debugfs.c                        |   8 +-
 net/bluetooth/hci_event.c                          |  19 ++-
 net/bluetooth/hci_sync.c                           |  63 ++++----
 net/bluetooth/l2cap_core.c                         |  26 ++-
 net/bluetooth/l2cap_sock.c                         |   3 +
 net/bluetooth/mgmt.c                               |  38 +++--
 net/bluetooth/msft.c                               |   2 +-
 net/bluetooth/smp.c                                |  21 ++-
 net/bluetooth/smp.h                                |   1 +
 net/bridge/br_switchdev.c                          |   3 +
 net/ipv4/tcp_offload.c                             |   1 +
 net/ipv4/udp_offload.c                             |   1 +
 net/ipv6/mcast.c                                   |   2 +-
 net/ipv6/rpl_iptunnel.c                            |   8 +-
 net/mptcp/options.c                                |   3 +-
 net/mptcp/pm.c                                     |   8 +-
 net/mptcp/protocol.c                               |  56 ++++++-
 net/mptcp/protocol.h                               |  29 +++-
 net/mptcp/subflow.c                                |  30 ++--
 net/netfilter/nf_conntrack_core.c                  |  26 ++-
 net/netfilter/nf_tables_api.c                      |  59 -------
 net/netfilter/nf_tables_trace.c                    |   3 +
 net/netfilter/nfnetlink.c                          |   1 -
 net/netfilter/nft_chain_filter.c                   |   2 -
 net/packet/af_packet.c                             |  27 ++--
 net/phonet/pep.c                                   |   2 +-
 net/rxrpc/ar-internal.h                            |   4 +
 net/rxrpc/call_accept.c                            |  14 +-
 net/rxrpc/call_object.c                            |  28 ++--
 net/rxrpc/io_thread.c                              |  14 ++
 net/rxrpc/output.c                                 |  22 +--
 net/rxrpc/peer_object.c                            |   6 +-
 net/rxrpc/recvmsg.c                                |  23 ++-
 net/rxrpc/security.c                               |   8 +-
 net/sched/sch_htb.c                                |   4 +-
 net/sched/sch_qfq.c                                |  30 ++--
 net/smc/af_smc.c                                   |  14 ++
 net/smc/smc.h                                      |   8 +-
 net/tls/tls_strp.c                                 |   3 +-
 tools/testing/selftests/net/netfilter/.gitignore   |   1 +
 tools/testing/selftests/net/netfilter/Makefile     |   3 +
 .../selftests/net/netfilter/conntrack_clash.sh     | 175 +++++++++++++++++++++
 .../selftests/net/netfilter/conntrack_resize.sh    |  97 +++++++++++-
 .../selftests/net/netfilter/nft_concat_range.sh    |   3 +
 tools/testing/selftests/net/netfilter/udpclash.c   | 158 +++++++++++++++++++
 tools/testing/selftests/net/udpgro.sh              |   8 +-
 tools/testing/selftests/net/vlan_hw_filter.sh      |  98 ++++++++++--
 .../tc-testing/tc-tests/infra/qdiscs.json          |  92 +++++++++++
 113 files changed, 1591 insertions(+), 549 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/conntrack_clash.sh
 create mode 100644 tools/testing/selftests/net/netfilter/udpclash.c

