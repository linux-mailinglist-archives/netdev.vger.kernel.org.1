Return-Path: <netdev+bounces-257260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FIQARDShGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:23:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F3F5DBD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FAF301E3DB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEA29B217;
	Thu,  5 Feb 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRCl/q/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0420C00A;
	Thu,  5 Feb 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311913; cv=none; b=kcUj440FnorVJMtti9kBcaDtYPmzAoOZwzR9B5kbnBDcXBC0Pvwe0j4R25zH1WfiARG8PikEEXT+9rR+nKdi8rlkom5z2thd+e3NhB767FyiWqSVSD1KRga4trD05o++Tj6auEkdVg6IpmwpCfJk39NPUyTStfVPxrfnKC8GUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311913; c=relaxed/simple;
	bh=GRNHcF/2SXPZH1EwNgQ+wF0eP6oFZTcaop1/ttCKNHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=THLSPsvR9UYQ3F47KPJZMnGtocnxwJyICvzTvEeHMfW85WI/9oAzkh3zcAwPwQe3JunRbIOspJtG5vKkWZLn14/OEjdVORbP+F+3D5xq0zTHuymQNn2uzWk2G7MHscopG3IeKCK6VrzOZq7vRZdHYc+D4A9cfLjFFkDrUJ+LWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRCl/q/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829AC4CEF7;
	Thu,  5 Feb 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770311912;
	bh=GRNHcF/2SXPZH1EwNgQ+wF0eP6oFZTcaop1/ttCKNHU=;
	h=From:To:Cc:Subject:Date:From;
	b=nRCl/q/rTulT73ONWr5uWLa03EJDLVFNOjxDEq3FnWxqCcgkGtWlJVr4+pmud1N+z
	 2TFoGbNTOYgDvBpnZvYPgvG9+AEWKII6DxQQi9+IOnYiJNcZ7blqV7C5aLRuySd+Dk
	 9+nY4BVF5xa7udVq/DFaFM6XvOyQZ+Gb1SNnlUP04DiPT//tg/MYPRGnPosJExSVH2
	 uVeP7ZJn7V9mug4Cgn3JyWX3WWpJagaynOJIhPZ6I8m/vvJgHDOcCKFkaBkuaOsodl
	 VMiovVxSOYy+jRu1afv0Djnodan+S07TCqS8l5iKW/WZwD18pamEmwsjxbzvV+8O2I
	 DBPM8uMRNjy1Q==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.19-rc9/final
Date: Thu,  5 Feb 2026 09:18:31 -0800
Message-ID: <20260205171831.1944818-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 758F3F5DBD
X-Rspamd-Action: no action

Hi Linus!

Things are pretty calm in our corner, no fires, no screaming.

The following changes since commit 1cac38910ecb881b09f61f57545a771bbe57ba68:

  Merge tag 'net-6.19-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-01-29 10:21:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc9

for you to fetch changes up to bbf4a17ad9ffc4e3d7ec13d73ecd59dea149ed25:

  ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF (2026-02-05 08:38:40 -0800)

----------------------------------------------------------------
Including fixes from wireless and Netfilter.

Previous releases - regressions:

 - eth: stmmac: fix stm32 (and potentially others) resume regression

 - nf_tables: fix inverted genmask check in nft_map_catchall_activate()

 - usb: r8152: fix resume reset deadlock

 - fix reporting RXH_XFRM_NO_CHANGE as input_xfrm for RSS contexts

Previous releases - always broken:

 - sched: cls_u32: use skb_header_pointer_careful() to avoid OOB reads
   with malicious u32 rules

 - eth: ice: timestamping related fixes

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Ma (1):
      ice: Fix PTP NULL pointer dereference during VSI rebuild

Andrew Fasano (1):
      netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate()

Chen Ni (1):
      net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()

Claudiu Manoil (4):
      net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
      net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
      net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
      net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4

Daniel Hodges (1):
      tipc: use kfree_sensitive() for session key material

Debarghya Kundu (1):
      gve: Fix stats report corruption on queue count change

Eric Dumazet (4):
      net: add skb_header_pointer_careful() helper
      net/sched: cls_u32: use skb_header_pointer_careful()
      macvlan: fix error recovery in macvlan_common_newlink()
      net: add proper RCU protection to /proc/net/ptype

Grzegorz Nitka (1):
      ice: fix missing TX timestamps interrupts on E825 devices

Jacob Keller (1):
      ice: PTP: fix missing timestamps on E825 hardware

Jakub Kicinski (12):
      MAINTAINERS: add an entry for PSP
      Merge branch 'net-fix-potential-crash-in-net-sched-cls_u32-c'
      Merge branch 'net-liquidio-fix-memory-leaks-in-setup_nic_devices'
      net: don't touch dev->stats in BPF redirect paths
      net: rss: fix reporting RXH_XFRM_NO_CHANGE as input_xfrm for contexts
      Merge branch 'enetc-v4-hardware-integration-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-gro-fix-outer-network-offset'
      Merge branch 'gve-stats-reporting-fixes'
      Merge branch 'net-cpsw-execute-ndo_set_rx_mode-callback-in-a-work-queue'
      Merge tag 'wireless-2026-02-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-26-02-05' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jiayuan Chen (1):
      linkwatch: use __dev_put() in callers to prevent UAF

Johannes Berg (1):
      Merge tag 'iwlwifi-fixes-2026-02-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Junrui Luo (2):
      dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
      dpaa2-switch: add bounds check for if_id in IRQ handler

Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

Marek Behún (1):
      net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module

Max Yuan (1):
      gve: Correct ethtool rx_dropped calculation

Miri Korenblit (2):
      wifi: iwlwifi: mld: cancel mlo_scan_start_wk
      wifi: iwlwifi: mvm: pause TCM on fast resume

Mohammad Heib (2):
      ice: drop udp_tunnel_get_rx_info() call from ndo_open()
      i40e: drop udp_tunnel_get_rx_info() call from i40e_open()

Paolo Abeni (2):
      net: gro: fix outer network offset
      selftest: net: add a test-case for encap segmentation after GRO

Russell King (Oracle) (1):
      net: stmmac: fix stm32 (and potentially others) resume regression

Sergey Senozhatsky (1):
      net: usb: r8152: fix resume reset deadlock

Shigeru Yoshida (1):
      ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF

Tomas Hlavacek (1):
      net: spacemit: k1-emac: fix jumbo frame support

Zilin Guan (3):
      net: liquidio: Initialize netdev pointer before queue setup
      net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
      net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

 MAINTAINERS                                        |  12 ++
 drivers/net/ethernet/adi/adin1110.c                |   3 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  39 ++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |   4 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  10 ++
 drivers/net/ethernet/freescale/enetc/enetc.c       |  11 +-
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c  |   4 -
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  17 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |  77 ++++++---
 drivers/net/ethernet/google/gve/gve_main.c         |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c          |  26 +--
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 179 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h           |  18 ++-
 drivers/net/ethernet/spacemit/k1_emac.c            |  21 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/ti/cpsw.c                     |  41 ++++-
 drivers/net/ethernet/ti/cpsw_new.c                 |  34 +++-
 drivers/net/ethernet/ti/cpsw_priv.h                |   1 +
 drivers/net/macvlan.c                              |   5 +-
 drivers/net/phy/sfp.c                              |   2 +
 drivers/net/usb/r8152.c                            |  29 ++--
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   2 -
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   6 +-
 include/linux/skbuff.h                             |  12 ++
 net/core/filter.c                                  |   8 +-
 net/core/gro.c                                     |   2 +
 net/core/link_watch.c                              |  20 ++-
 net/core/net-procfs.c                              |  50 ++++--
 net/ethtool/common.c                               |   3 -
 net/ethtool/rss.c                                  |   9 +-
 net/ipv6/ip6_fib.c                                 |   3 +-
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/sched/cls_u32.c                                |  13 +-
 net/tipc/crypto.c                                  |   4 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  64 ++++++++
 38 files changed, 513 insertions(+), 234 deletions(-)

