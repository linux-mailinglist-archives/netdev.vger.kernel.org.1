Return-Path: <netdev+bounces-206194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B313B02016
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C85453B4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255A2EA498;
	Fri, 11 Jul 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3SHtX9R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6362EA14A;
	Fri, 11 Jul 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246604; cv=none; b=SYt08VCUiOaAWv6X810ccZsUbDQaaugYDOMg92GrXlJiGCwleR1KcgaQ7j0RjlZYzPKuiGNlWQHVe7Uc3dGQaTuUnY6Nj3kuEyOmP+8x1+5BhWgK9j7fkJ2sBGGqQMhcWEWGgyZVFaqKVYVu3PjKjrKA4GRQiJS7phtl+05FGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246604; c=relaxed/simple;
	bh=1N0whfMpaitwygkzwQVVmm5dLEbvN5tmvZIG8I/aJs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GfeYdz6MVjiZGKPaQ4cX7Qb91rbD8Rk6n/K5I9juC9w5IAHq6wc5nIw1okCwzuhDXPUz1Ss5mkS2wNWm9K9UFdLlPFEWaAbqWtzJ3qFNb3h/fF8zpS8Ys1vKrpeS//2y/f8AJs8pF5i+ZaQyClgBVhQzve/YshTQee5SM1F/C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3SHtX9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7D9C4CEF6;
	Fri, 11 Jul 2025 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752246603;
	bh=1N0whfMpaitwygkzwQVVmm5dLEbvN5tmvZIG8I/aJs8=;
	h=From:To:Cc:Subject:Date:From;
	b=l3SHtX9RsAIpCM3cH42QkTJdxuH7ol0F6dHw7DMXN+e3+1yPgg7LqrNRMBCP1ecuN
	 x7H8GYIUr3C/H46xotLHf5LKW5EPkhWMoAtr3N2I9751GRzG/U859l9+F3qzSgcld5
	 JVonFz8zZPd+qyX9R2VwQHhCXA5W4/cn5wUeu7z2bM7o12F2DfY8rvg+c+btZWdoJY
	 VajwAe+O4Ba3O7/0FzW7x/GkrFL+/vC/UsEoCWT/EwpFhCjwY61GM46cm1E+NnRET7
	 f1612A/K4H0kd0apK3wqjbVECxlmmdhS9x/yQf7csJG9vvKzkTdwdR4A7nPN7sBfUh
	 XcfBgg1l19rQg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.16-rc6 (follow up)
Date: Fri, 11 Jul 2025 08:10:02 -0700
Message-ID: <20250711151002.3228710-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit bc9ff192a6c940d9a26e21a0a82f2667067aaf5f:

  Merge tag 'net-6.16-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-10 09:18:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc6-2

for you to fetch changes up to a215b5723922f8099078478122f02100e489cb80:

  netlink: make sure we allow at least one dump skb (2025-07-11 07:31:47 -0700)

----------------------------------------------------------------
Big chunk of fixes for WiFi, Johannes says probably the last
for the release. The Netlink fixes (on top of the tree) restore
operation of iw (WiFi CLI) which uses sillily small recv buffer,
and is the reason for this "emergency PR". The GRE multicast
fix also stands out among the user-visible regressions.

Current release - fix to a fix:

 - netlink: make sure we always allow at least one skb to be queued,
   even if the recvbuf is (mis)configured to be tiny

Previous releases - regressions:

 - gre: fix IPv6 multicast route creation

Previous releases - always broken:

 - wifi: prevent A-MSDU attacks in mesh networks

 - wifi: cfg80211: fix S1G beacon head validation and detection

 - wifi: mac80211:
   - always clear frame buffer to prevent stack leak in cases which
     hit a WARN()
   - fix monitor interface in device restart

 - wifi: mwifiex: discard erroneous disassoc frames on STA interface

 - wifi: mt76:
   - prevent null-deref in mt7925_sta_set_decap_offload()
   - add missing RCU annotations, and fix sleep in atomic
   - fix decapsulation offload
   - fixes for scanning

 - phy: microchip: improve link establishment and reset handling

 - eth: mlx5e: fix race between DIM disable and net_dim()

 - bnxt_en: correct DMA unmap len for XDP_REDIRECT

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alok Tiwari (1):
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Carolina Jubran (2):
      net/mlx5: Reset bw_share field when changing a node's parent
      net/mlx5e: Fix race between DIM disable and net_dim()

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

Deren Wu (2):
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()
      wifi: mt76: mt7921: prevent decap offload config before STA initialization

Eric Dumazet (1):
      netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()

Felix Fietkau (3):
      wifi: rt2x00: fix remove callback type mismatch
      wifi: mt76: add a wrapper for wcid access with validation
      wifi: mt76: fix queue assignment for deauth packets

Guillaume Nault (2):
      gre: Fix IPv6 multicast route creation.
      selftests: Add IPv6 multicast route generation tests for GRE devices.

Hangbin Liu (1):
      selftests: net: lib: fix shift count out of range

Henry Martin (1):
      wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Jakub Kicinski (7):
      Merge tag 'wireless-2025-07-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'net-phy-microchip-lan88xx-reliability-fixes'
      Merge branch 'gre-fix-default-ipv6-multicast-route-creation'
      Merge tag 'linux-can-fixes-for-6.16-20250711' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'mlx5-misc-fixes-2025-07-10'
      Merge branch 'bnxt_en-3-bug-fixes'
      netlink: make sure we allow at least one dump skb

Jianbo Liu (1):
      net/mlx5e: Add new prio for promiscuous mode

Johannes Berg (3):
      wifi: mac80211: clear frame buffer to never leak stack
      wifi: mac80211: fix non-transmitted BSSID profile search
      Merge tag 'mt76-fixes-2025-07-07' of https://github.com/nbd168/wireless

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kuniyuki Iwashima (1):
      netlink: Fix rmem check in netlink_broadcast_deliver().

Lachlan Hodges (2):
      wifi: cfg80211: fix S1G beacon head validation in nl80211
      wifi: mac80211: correctly identify S1G short beacon

Leon Yen (1):
      wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to operate on the same channel

Lorenzo Bianconi (5):
      wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic context
      wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
      wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
      wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

Mathy Vanhoef (1):
      wifi: prevent A-MSDU attacks in mesh networks

Michael Lo (1):
      wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: fix the wrong config for tx interrupt
      wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan

Mingming Cao (1):
      ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof

Miri Korenblit (2):
      wifi: mac80211: always initialize sdata::key_list
      wifi: mac80211: add the virtual monitor after reconfig complete

Moon Hee Lee (1):
      wifi: mac80211: reject VHT opmode for unsupported channel widths

Oleksij Rempel (2):
      net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: Fix uninitialized variable with __free() in ieee80211_ml_epcs()

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Shruti Parab (1):
      bnxt_en: Flush FW trace before copying to the coredump

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Vitor Soares (1):
      wifi: mwifiex: discard erroneous disassoc frames on STA interface

 drivers/net/can/m_can/m_can.c                      |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dim.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  13 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   2 +-
 drivers/net/phy/microchip.c                        |   3 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |  10 ++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  79 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  32 +++-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  52 ++----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 199 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  16 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  11 +-
 drivers/net/wireless/mediatek/mt76/util.c          |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c     |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h     |   2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |   6 +-
 include/linux/ieee80211.h                          |  45 +++--
 include/net/netfilter/nf_flow_table.h              |   2 +-
 net/appletalk/ddp.c                                |   1 +
 net/ipv6/addrconf.c                                |   9 +-
 net/mac80211/cfg.c                                 |  14 ++
 net/mac80211/iface.c                               |   4 +-
 net/mac80211/mlme.c                                |  12 +-
 net/mac80211/parse.c                               |   6 +-
 net/mac80211/util.c                                |   9 +-
 net/netlink/af_netlink.c                           |   7 +-
 net/wireless/nl80211.c                             |   7 +-
 net/wireless/util.c                                |  52 +++++-
 tools/testing/selftests/net/gre_ipv6_lladdr.sh     |  27 +--
 tools/testing/selftests/net/lib.sh                 |   2 +-
 57 files changed, 500 insertions(+), 277 deletions(-)

