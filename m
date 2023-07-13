Return-Path: <netdev+bounces-17549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF4751F6D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5291C21311
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A1107B8;
	Thu, 13 Jul 2023 11:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E37100B5
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:04:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C898211E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689246269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dPHYn3i85bgtIPhwWNtefstu+BtnMyOoT7Fb2iJ/lDY=;
	b=YbY1WI9jREajjRK4yW78Mk9qOFlQEbFRvhcysVAy+PT8SdZAGlEXtG6+1EWiTYxDO0cs3B
	oDTYAJ7EZDchSU7lwgjKdVBpKBraaP77SK4fgiGJLG1rwu+Jpdseq9M4p42ifIXcovl0+i
	MY4FcNtSxnKdDQGaDA4BlbuFNFr2uMY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-c5vW48rUMCa2hHl6obCHSg-1; Thu, 13 Jul 2023 07:04:26 -0400
X-MC-Unique: c5vW48rUMCa2hHl6obCHSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C69358F9E43;
	Thu, 13 Jul 2023 11:04:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 893C7F66D6;
	Thu, 13 Jul 2023 11:04:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.5-rc2
Date: Thu, 13 Jul 2023 13:04:15 +0200
Message-ID: <20230713110415.38918-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus!

Notably this includes the fix for the WiFi regression you were
waiting for. 

The following changes since commit 6843306689aff3aea608e4d2630b2a5a0137f827:

  Merge tag 'net-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-05 15:44:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc2

for you to fetch changes up to 9d23aac8a85f69239e585c8656c6fdb21be65695:

  Merge branch 'net-sched-fixes-for-sch_qfq' (2023-07-13 11:12:01 +0200)

----------------------------------------------------------------
Networking fixes for 6.5-rc2, including fixes from netfilter,
wireless and ebpf

Current release - regressions:

  - netfilter: conntrack: gre: don't set assured flag for clash entries

  - wifi: iwlwifi: remove 'use_tfh' config to fix crash

Previous releases - regressions:

  - ipv6: fix a potential refcount underflow for idev

  - icmp6: ifix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev()

  - bpf: fix max stack depth check for async callbacks

  - eth: mlx5e:
    - check for NOT_READY flag state after locking
    - fix page_pool page fragment tracking for XDP

  - eth: igc:
    - fix tx hang issue when QBV gate is closed
    - fix corner cases for TSN offload

  - eth: octeontx2-af: Move validation of ptp pointer before its usage

  - eth: ena: fix shift-out-of-bounds in exponential backoff

Previous releases - always broken:

  - core: prevent skb corruption on frag list segmentation

  - sched:
    - cls_fw: fix improper refcount update leads to use-after-free
    - sch_qfq: account for stab overhead in qfq_enqueue

  - netfilter:
    - report use refcount overflow
    - prevent OOB access in nft_byteorder_eval

  - wifi: mt7921e: fix init command fail with enabled device

  - eth: ocelot: fix oversize frame dropping for preemptible TCs

  - eth: fec: recycle pages for transmitted XDP frames

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'Fix for check_max_stack_depth'

Andrew Halaney (1):
      MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DRIVER

Aravindhan Gunasekaran (1):
      igc: Handle PPS start time programming for past time values

Azeem Shaikh (1):
      net: sched: Replace strlcpy with strscpy

Björn Töpel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Dan Carpenter (1):
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()

David S. Miller (3):
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 's390-ism-fixes'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Dragos Tatulea (2):
      net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq
      net/mlx5e: RX, Fix page_pool page fragment tracking for XDP

Eric Dumazet (1):
      udp6: fix udp6_ehashfn() typo

Felix Fietkau (1):
      wifi: cfg80211: fix receiving mesh packets without RFC1042 header

Florent Revest (1):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Kauer (6):
      igc: Rename qbv_enable to taprio_offload_enable
      igc: Do not enable taprio offload for invalid arguments
      igc: Handle already enabled taprio offload for basetime 0
      igc: No strict mode in pure launchtime/CBS offload
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

Florian Westphal (2):
      netfilter: conntrack: gre: don't set assured flag for clash entries
      netfilter: conntrack: don't fold port numbers into addresses before hashing

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ivan Babrou (1):
      udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint

Jakub Kicinski (5):
      Merge branch 'fix-dropping-of-oversize-preemptible-frames-with-felix-dsa-driver'
      Merge tag 'mlx5-fixes-2023-07-05' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      docs: netdev: update the URL of the status page
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Jiasheng Jiang (1):
      net: dsa: qca8k: Add check for skb_copy

Jiawen Wu (1):
      net: txgbe: fix eeprom calculation error

Johannes Berg (1):
      wifi: iwlwifi: remove 'use_tfh' config to fix crash

Junfeng Guo (2):
      gve: Set default duplex configuration to full
      gve: unify driver name usage

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Kumar Kartikeya Dwivedi (2):
      bpf: Fix max stack depth check for async callbacks
      selftests/bpf: Add selftest for check_stack_max_depth bug

Kuniyuki Iwashima (1):
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Larysa Zaremba (1):
      xdp: use trusted arguments in XDP hints kfuncs

Lu Hongfei (1):
      net: dsa: Removed unneeded of_node_put in felix_parse_ports_node

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Maher Sanalla (1):
      net/mlx5: Query hca_cap_2 only when supported

Muhammad Husaini Zulkifli (3):
      igc: Add condition for qbv_config_change_errors counter
      igc: Remove delay during TX ring configuration
      igc: Fix TX Hang issue when QBV Gate is closed

Niklas Schnelle (3):
      s390/ism: Fix locking for forwarding of IRQs and events to clients
      s390/ism: Fix and simplify add()/remove() callback handling
      s390/ism: Do not unregister clients with registered DMBs

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Paolo Abeni (4):
      Merge tag 'nf-23-07-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      net: prevent skb corruption on frag list segmentation
      Merge branch 'net-fec-fix-some-issues-of-ndo_xdp_xmit'
      Merge branch 'net-sched-fixes-for-sch_qfq'

Pedro Tammela (5):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: reintroduce lmax bound check for MTU
      selftests: tc-testing: add tests for qfq mtu sanity check
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      selftests: tc-testing: add test for qfq with stab overhead

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Pu Lehui (1):
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

Quan Zhou (1):
      wifi: mt76: mt7921e: fix init command fail with enabled device

Rafał Miłecki (1):
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

Randy Dunlap (1):
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Ratheesh Kannoth (1):
      octeontx2-af: Promisc enable/disable through mbox

Saeed Mahameed (1):
      net/mlx5: Register a unique thermal zone per device

Sai Krishna (1):
      octeontx2-af: Move validation of ptp pointer before its usage

Shannon Nelson (1):
      ionic: remove dead device fail path

Simon Horman (1):
      net: lan743x: select FIXED_PHY

Sridhar Samudrala (2):
      ice: Fix max_rate check while configuring TX rate limits
      ice: Fix tx queue rate limit when TCs are configured

Suman Ghosh (1):
      octeontx2-pf: Add additional check for MCAM rules

Tan Tee Min (1):
      igc: Include the length/type field and VLAN tag in queueMaxSDU

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Vladimir Oltean (3):
      net: mscc: ocelot: extend ocelot->fwd_domain_lock to cover ocelot->tas_lock
      net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops
      net: mscc: ocelot: fix oversize frame dropping for preemptible TCs

Wei Fang (4):
      net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
      net: fec: recycle pages for transmitted XDP frames
      net: fec: increase the size of tx ring and update tx_wake_threshold
      net: fec: use netdev_err_once() instead of netdev_err()

Yevgeny Kliteynik (1):
      net/mlx5e: TC, CT: Offload ct clear only once

Zhang Shurong (1):
      wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Zhengchao Shao (3):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
      net/mlx5e: fix memory leak in mlx5e_ptp_open

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

 Documentation/process/maintainer-netdev.rst        |   2 +-
 MAINTAINERS                                        |   1 +
 arch/riscv/net/bpf_jit.h                           |   6 +-
 arch/riscv/net/bpf_jit_core.c                      |  19 ++-
 drivers/net/dsa/ocelot/felix.c                     |  10 +-
 drivers/net/dsa/ocelot/felix.h                     |   1 -
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  59 ++++---
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   3 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |   3 +
 drivers/net/ethernet/broadcom/bgmac.c              |   4 +-
 drivers/net/ethernet/freescale/fec.h               |  17 +-
 drivers/net/ethernet/freescale/fec_main.c          | 166 +++++++++++++-------
 drivers/net/ethernet/google/gve/gve.h              |   1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  11 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  23 ++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  22 +--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h        |   1 +
 drivers/net/ethernet/intel/igc/igc.h               |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  98 ++++++++----
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  25 ++-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |  68 ++++++--
 drivers/net/ethernet/marvell/mvneta.c              |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |  19 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  11 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  23 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |   8 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  15 ++
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  44 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  |  19 ++-
 drivers/net/ethernet/microchip/Kconfig             |   2 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   1 -
 drivers/net/ethernet/mscc/ocelot_mm.c              |  14 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   6 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   5 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |   3 -
 drivers/net/netdevsim/dev.c                        |   9 +-
 drivers/net/wireless/cisco/airo.c                  |   5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   5 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |  10 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |   4 -
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   8 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   8 +
 drivers/net/wireless/realtek/rtw89/debug.c         |   5 +-
 drivers/s390/net/ism_drv.c                         | 139 ++++++++--------
 include/linux/ism.h                                |   7 +-
 include/net/netfilter/nf_conntrack_tuple.h         |   3 +
 include/net/netfilter/nf_tables.h                  |  31 +++-
 include/net/pkt_sched.h                            |   2 +-
 include/soc/mscc/ocelot.h                          |   9 +-
 kernel/bpf/cpumap.c                                |  40 +++--
 kernel/bpf/verifier.c                              |   5 +-
 net/core/net-traces.c                              |   2 +
 net/core/skbuff.c                                  |   5 +
 net/core/xdp.c                                     |   2 +-
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/udp.c                                     |   4 +-
 net/netfilter/nf_conntrack_core.c                  |  20 +--
 net/netfilter/nf_conntrack_helper.c                |   4 +
 net/netfilter/nf_conntrack_proto_gre.c             |  10 +-
 net/netfilter/nf_tables_api.c                      | 174 +++++++++++++--------
 net/netfilter/nft_byteorder.c                      |  14 +-
 net/netfilter/nft_flow_offload.c                   |   6 +-
 net/netfilter/nft_immediate.c                      |   8 +-
 net/netfilter/nft_objref.c                         |   8 +-
 net/sched/act_api.c                                |   2 +-
 net/sched/cls_flower.c                             |  10 ++
 net/sched/cls_fw.c                                 |  10 +-
 net/sched/sch_qfq.c                                |  18 ++-
 net/wireless/util.c                                |   2 +
 .../selftests/bpf/prog_tests/async_stack_depth.c   |   9 ++
 .../selftests/bpf/progs/async_stack_depth.c        |  40 +++++
 .../selftests/tc-testing/tc-tests/qdiscs/qfq.json  |  86 ++++++++++
 91 files changed, 1011 insertions(+), 521 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/async_stack_depth.c


