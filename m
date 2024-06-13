Return-Path: <netdev+bounces-103317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0B907865
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F841C21217
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A3D132127;
	Thu, 13 Jun 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjeV1G81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689E1304B0;
	Thu, 13 Jun 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296543; cv=none; b=Oruhp8Hyoat6HjLuScb8XJdW7i3lapdUmLu7ASylsmQwv/lWJOou8R+trNQfQ97pFaHxeqAG3obP6+0HArBxLpvu02DetKBdD2BgfHP2hJtDaVDXdQdV4knEPN/8sVD1rfdFME1oiRLbKXr6WADFG7qp8j6jTcaxETIuLRxUTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296543; c=relaxed/simple;
	bh=H8o7A9IqWk+q974QU4xPjvp4+wJhcqbNDuTa4aaL6L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NC0gexDE5YRY8O/Waupb3oTTYHyr05Hg5Lohr91meDMqAzHwAB6Exn/5+5ZAPAiC66g3EH+x3I8anKF4KDOwHT6eNrC+Xx6zT8pp/lvfPA8zvugq2YrT0LrwxNJVGW9gMHaFH1XFT7yn2EiIGJq5ZC6wKM776JFOHipW2SoXbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjeV1G81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C07C2BBFC;
	Thu, 13 Jun 2024 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718296543;
	bh=H8o7A9IqWk+q974QU4xPjvp4+wJhcqbNDuTa4aaL6L8=;
	h=From:To:Cc:Subject:Date:From;
	b=DjeV1G81ciCrQUdJHKS1fHNjnwqmy2/JMhf67PgwkzWqpNDaIHszgbdI10Tr0/jdw
	 BL0hGjJGODUN2TW21+quaj1ecoRe/p+l4xT2CAB8N2DUpeo4ugHLgPl+8aMT28Z2tS
	 eIAIKEoykTHeTbwhwFvA936fEQRKDwgUudmW0xbt4Q6FkJwJb3pvsfT1XQ8KMcozzD
	 BRvgwrM2l6vj3Q2IZ3mcOjxFlPu0YFs+/teaG7m4Jj29EpwmFaT6bppz7WoM3C9QXU
	 mJY/0Gl7r1D444qIHBFBEAxiHQiXiVefTU/BsGJ5cjCHrqx/vjBIjottNSDI1CIwVX
	 8m2t5lkZ8ByEw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.10-rc4
Date: Thu, 13 Jun 2024 09:35:42 -0700
Message-ID: <20240613163542.130374-1-kuba@kernel.org>
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

Slim pickings this time, probably a combination of summer, DevConf.cz,
and the end of first half of the year at corporations.

The following changes since commit d30d0e49da71de8df10bf3ff1b3de880653af562:

  Merge tag 'net-6.10-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-06-06 09:55:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4

for you to fetch changes up to a9b9741854a9fe9df948af49ca5514e0ed0429df:

  bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send() (2024-06-13 08:05:46 -0700)

----------------------------------------------------------------
Including fixes from bluetooth and netfilter.

Current release - regressions:

 - Revert "igc: fix a log entry using uninitialized netdev",
   it traded lack of netdev name in a printk() for a crash

Previous releases - regressions:

 - Bluetooth: L2CAP: fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

 - geneve: fix incorrectly setting lengths of inner headers in the skb,
   confusing the drivers and causing mangled packets

 - sched: initialize noop_qdisc owner to avoid false-positive recursion
   detection (recursing on CPU 0), which bubbles up to user space as
   a sendmsg() error, while noop_qdisc should silently drop

 - netdevsim: fix backwards compatibility in nsim_get_iflink()

Previous releases - always broken:

 - netfilter: ipset: fix race between namespace cleanup and gc
   in the list:set type

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksandr Mishin (2):
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
      bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()

Andy Shevchenko (1):
      net dsa: qca8k: fix usages of device_get_named_child_node()

Csókás, Bence (1):
      net: sfp: Always call `sfp_sm_mod_remove()` on remove

David S. Miller (2):
      Merge branch 'hns3-fixes'
      Merge branch 'geneve-fixes'

David Wei (1):
      netdevsim: fix backwards compatibility in nsim_get_iflink()

Davide Ornaghi (1):
      netfilter: nft_inner: validate mandatory meta and payload

Eric Dumazet (2):
      tcp: fix race in tcp_v6_syn_recv_sock()
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()

Florian Westphal (1):
      netfilter: Use flowlabel flow key when re-routing mangled packets

Gal Pressman (2):
      geneve: Fix incorrect inner network header offset when innerprotoinherit is set
      net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets

Geliang Tang (1):
      mailmap: map Geliang's new email address

Jakub Kicinski (4):
      Merge branch 'mptcp-various-fixes'
      Merge tag 'for-net-2024-06-10' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'nf-24-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-bridge-mst-fix-suspicious-rcu-usage-warning'

Jie Wang (1):
      net: hns3: add cond_resched() to hns3 ring buffer init process

Johannes Berg (1):
      net/sched: initialize noop_qdisc owner

Joshua Washington (1):
      gve: ignore nonrelevant GSO type bits when processing TSO headers

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type

Kory Maincent (1):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not using correct handle
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Michael Chan (1):
      bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response

Nikolay Aleksandrov (2):
      net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
      net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

Pauli Virtanen (1):
      Bluetooth: fix connection setup in l2cap_connect

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Rao Shoaib (1):
      af_unix: Read with MSG_PEEK loops if the first unread byte is OOB

Sagar Cheluvegowda (1):
      net: stmmac: dwmac-qcom-ethqos: Configure host DMA width

Sasha Neftin (1):
      Revert "igc: fix a log entry using uninitialized netdev"

Taehee Yoo (1):
      ionic: fix use after netif_napi_del()

Udit Kumar (1):
      dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0

Xiaolei Wang (1):
      net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters

Yonglong Liu (1):
      net: hns3: fix kernel crash problem in concurrent scenario

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

Ziwei Xiao (1):
      gve: Clear napi->skb before dev_kfree_skb_any()

 .mailmap                                           |  1 +
 drivers/net/dsa/qca/qca8k-leds.c                   | 12 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 51 ++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    | 12 ++-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  | 11 ++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  8 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       | 20 ++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 21 +++--
 drivers/net/ethernet/intel/igc/igc_main.c          |  5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  3 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  4 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    | 25 +++---
 drivers/net/geneve.c                               | 10 ++-
 drivers/net/netdevsim/netdev.c                     |  3 +-
 drivers/net/phy/sfp.c                              |  3 +-
 include/dt-bindings/net/ti-dp83867.h               |  4 +-
 include/dt-bindings/net/ti-dp83869.h               |  4 +-
 include/linux/pse-pd/pse.h                         |  4 +-
 include/net/bluetooth/hci_core.h                   | 36 ++++++++-
 include/net/ip_tunnels.h                           |  5 +-
 net/bluetooth/hci_sync.c                           |  2 +-
 net/bluetooth/l2cap_core.c                         | 12 +--
 net/bridge/br_mst.c                                | 13 ++-
 net/ipv4/tcp_timer.c                               |  6 +-
 net/ipv6/netfilter.c                               |  1 +
 net/ipv6/route.c                                   |  4 +-
 net/ipv6/tcp_ipv6.c                                |  3 +-
 net/mptcp/pm_netlink.c                             | 21 +++--
 net/mptcp/protocol.c                               |  1 +
 net/netfilter/ipset/ip_set_core.c                  | 93 ++++++++++++----------
 net/netfilter/ipset/ip_set_list_set.c              | 30 ++++---
 net/netfilter/nft_meta.c                           |  3 +
 net/netfilter/nft_payload.c                        |  4 +
 net/sched/sch_generic.c                            |  1 +
 net/unix/af_unix.c                                 | 18 ++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  5 +-
 40 files changed, 300 insertions(+), 171 deletions(-)

