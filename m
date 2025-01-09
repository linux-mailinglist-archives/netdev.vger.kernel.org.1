Return-Path: <netdev+bounces-156842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B3A07FCD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9E7A02B7
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB348199FA2;
	Thu,  9 Jan 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYakrKeB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E618D64B;
	Thu,  9 Jan 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447394; cv=none; b=DL8n/SAyC9blCyHddyUOl+wJFDKA7YAScNerMB8EUtLpDR3U7uvh0dRRbGuCCSfpWIXVjquMEzZuvmDAMMeXYkdPZvlxzyAaEQX2ESVkiPwpeloIXjd4awY352Uo5+PfjnOjX5TaH0xR+nQnLIWiTrAh1g+KCMWWc9TMvCl9Ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447394; c=relaxed/simple;
	bh=VoC61kJ9hyz56WJV8GH2dvhSGGK1cqPAuGndURdWWQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RZ8L9KGaNhg+182q3kJrk41n2tBw/NlO/RME3scRaxCZVdkZnHpFP47WzT50IYalcnbJYRh/UPYJnpybN/Ht1iSeVrpCsf7QNYUj889VFChOMzO9rFZAdNOfuqP8hrWB9ksbslESq/yo4M/VFKyxD+X/Au5VCG246JZ/1BR9YN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYakrKeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA25C4CED2;
	Thu,  9 Jan 2025 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736447394;
	bh=VoC61kJ9hyz56WJV8GH2dvhSGGK1cqPAuGndURdWWQw=;
	h=From:To:Cc:Subject:Date:From;
	b=SYakrKeB6OvyrLdhoKou+snRK5XADiOKoCMlYV9gDLWvVJXMrx11qI2/Idn2JGHaQ
	 XtOXNTLk/DwGSEHe8+i29ho8N8jurGkAydhLC5XREF1V4o4RTMJusXEuRTxjs8Wulz
	 hQVo/Q9g4cM28abJT477luDFt3NoZ0537SmsIr2ffghK11Rvb8/J2jDFEKL3Px6pfz
	 GuUyw2FpVjFTx9tjfQi8Yzd0pWZmoZk7QU8ukE0iL9zQ0TGk/HcJ5qeU5mmzTfKNyi
	 LUZd5W5qn8OJJvyn6hZG9WJ90sbl993MgMZpWLrEbsX3Uim6gT9CZMq/TgcUz+o/tG
	 BMPO5XlQxhMGw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.13-rc7
Date: Thu,  9 Jan 2025 10:29:53 -0800
Message-ID: <20250109182953.2752717-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit aba74e639f8d76d29b94991615e33319d7371b63:

  Merge tag 'net-6.13-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-03 14:36:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc7

for you to fetch changes up to b5cf67a8f716afbd7f8416edfe898c2df460811a:

  Merge tag 'nf-25-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-01-09 08:54:49 -0800)

----------------------------------------------------------------
Including fixes from netfilter, Bluetooth and WPAN.

No outstanding fixes / investigations at this time.

Current release - new code bugs:

 - eth: fbnic: revert HWMON support, it doesn't work at all
   and revert is similar size as the fixes

Previous releases - regressions:

 - tcp: allow a connection when sk_max_ack_backlog is zero

 - tls: fix tls_sw_sendmsg error handling

Previous releases - always broken:

 - netdev netlink family:
   - prevent accessing NAPI instances from another namespace
   - don't dump Tx and uninitialized NAPIs

 - net: sysctl: avoid using current->nsproxy, fix null-deref if task
   is exiting and stick to opener's netns

 - sched: sch_cake: add bounds checks to host bulk flow fairness counts

Misc:

 - annual cleanup of inactive maintainers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arkadiusz Kubalewski (1):
      ice: fix max values for dpll pin phase adjust

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Chenguang Zhao (1):
      net/mlx5: Fix variable not being completed when function returns

Chris Lu (1):
      Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.

Dan Carpenter (1):
      rtase: Fix a check for error in rtase_alloc_msix()

Daniel Borkmann (1):
      tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset

En-Wei Wu (1):
      igc: return early when failing to read EECD register

Eric Dumazet (1):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

Hao Lan (4):
      net: hns3: fixed reset failure issues caused by the incorrect reset type
      net: hns3: fix missing features due to dev->features configuration too early
      net: hns3: Resolved the issue that the debugfs query result is inconsistent.
      net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue

Jakub Kicinski (20):
      selftests: tc-testing: reduce rshift value
      Merge tag 'ieee802154-for-net-2025-01-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      Merge branch 'bnxt_en-2-bug-fixes'
      net: don't dump Tx and uninitialized NAPIs
      eth: gve: use appropriate helper to set xdp_features
      netdev: prevent accessing NAPI instances from another namespace
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'for-net-2025-01-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      MAINTAINERS: mark Synopsys DW XPCS as Orphan
      MAINTAINERS: update maintainers for Microchip LAN78xx
      MAINTAINERS: remove Andy Gospodarek from bonding
      MAINTAINERS: mark stmmac ethernet as an Orphan
      MAINTAINERS: remove Mark Lee from MediaTek Ethernet
      MAINTAINERS: remove Ying Xue from TIPC
      MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
      MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC
      Merge branch 'maintainers-spring-2025-cleanup-of-networking-maintainers'
      Merge branch 'net-sysctl-avoid-using-current-nsproxy'
      Merge tag 'nf-25-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jian Shen (2):
      net: hns3: don't auto enable misc vector
      net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jiawen Wu (1):
      net: libwx: fix firmware mailbox abnormal return

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Kalesh AP (1):
      bnxt_en: Fix possible memory leak when hwrm_req_replace fails

Keisuke Nishimura (1):
      ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()

Kory Maincent (1):
      dt-bindings: net: pse-pd: Fix unusual character in documentation

Kuniyuki Iwashima (1):
      ipvlan: Fix use-after-free in ipvlan_get_iflink().

Leo Yang (1):
      mctp i3c: fix MCTP I3C driver multi-thread issue

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not setting Random Address when required
      Bluetooth: MGMT: Fix Add Device to responding before completing

Matthieu Baerts (NGI0) (9):
      mptcp: sysctl: avail sched: remove write access
      mptcp: sysctl: sched: avoid using current->nsproxy
      mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

Michael Chan (1):
      bnxt_en: Fix DIM shutdown

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix driver sending truncated data

Pablo Neira Ayuso (2):
      netfilter: nf_tables: imbalance in flowtable binding
      netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Parker Newman (1):
      net: stmmac: dwmac-tegra: Read iommu stream id from device tree

Przemyslaw Korba (1):
      ice: fix incorrect PHY settings for 100 GB/s

Shannon Nelson (1):
      pds_core: limit loop over fw name list

Su Hui (1):
      eth: fbnic: Revert "eth: fbnic: Add hardware monitoring support via HWMON interface"

Toke Høiland-Jørgensen (1):
      sched: sch_cake: add bounds checks to host bulk flow fairness counts

Zhongqiu Duan (1):
      tcp/dccp: allow a connection when sk_max_ack_backlog is zero

 CREDITS                                            |  12 ++
 .../bindings/net/pse-pd/pse-controller.yaml        |   2 +-
 MAINTAINERS                                        |  16 +--
 drivers/bluetooth/btmtk.c                          |   7 ++
 drivers/bluetooth/btnxpuart.c                      |   1 +
 drivers/net/ethernet/amd/pds_core/devlink.c        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  38 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   3 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  14 ++-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   3 -
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  96 +++++---------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   1 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  45 +++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.c    |   9 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  41 ++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |   9 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  35 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |   4 +-
 drivers/net/ethernet/intel/igc/igc_base.c          |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   1 +
 drivers/net/ethernet/meta/fbnic/Makefile           |   1 -
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   5 -
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   7 --
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c      |  81 ------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |  22 ----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h        |   7 --
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   3 -
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |  14 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  24 ++--
 drivers/net/ieee802154/ca8210.c                    |   6 +-
 drivers/net/mctp/mctp-i3c.c                        |   4 +
 include/net/inet_connection_sock.h                 |   2 +-
 net/802/psnap.c                                    |   4 +-
 net/bluetooth/hci_sync.c                           |  11 +-
 net/bluetooth/mgmt.c                               |  38 +++++-
 net/bluetooth/rfcomm/tty.c                         |   4 +-
 net/core/dev.c                                     |  43 +++++--
 net/core/dev.h                                     |   3 +-
 net/core/link_watch.c                              |  10 +-
 net/core/netdev-genl.c                             |  11 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/mac802154/iface.c                              |   4 +
 net/mptcp/ctrl.c                                   |  17 +--
 net/netfilter/nf_conntrack_core.c                  |   5 +-
 net/netfilter/nf_tables_api.c                      |  15 ++-
 net/rds/tcp.c                                      |  39 ++++--
 net/sched/cls_flow.c                               |   3 +-
 net/sched/sch_cake.c                               | 140 +++++++++++----------
 net/sctp/sysctl.c                                  |  14 ++-
 net/tls/tls_sw.c                                   |   2 +-
 .../tc-testing/tc-tests/filters/flow.json          |   4 +-
 55 files changed, 494 insertions(+), 408 deletions(-)
 delete mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c

