Return-Path: <netdev+bounces-116959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C950394C342
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBBF1F23089
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2766190067;
	Thu,  8 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8H9RLaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988018E740;
	Thu,  8 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136509; cv=none; b=jRa0nIlBW362o9nQ4BTgZ0FCQLVAdVPviR2UbXf8pfoGeibzBJ2NFU302jMfy/MFFdlGV86FUh0wOmiM2teBUejeC2xy9mLW27KqLDSXkYJ4JO2EaE1OneSx6jSWAGuqK3tmcQ0mKEdosWsuUoeHz1MMSFHDNXlxKVVy1gHSgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136509; c=relaxed/simple;
	bh=+wBfE+kitxneWQlu3bzEy3GY/tPjoRmi4VJlsfIqxAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NL87gm4EwRtpm8Uzr4jWCbVoYu3K5F8AvzGV7NL+UV4Tf+7XReTlzRtKrXPqKa/RNv4F/y9vkz77o255NDOVZLsZD/B34D3B3Nn8dDPtyfuYCjZtV5YVsguV3GcruWXcT691MFbkWE6hiINpZ4Sw65+2T2RtybFSE8PubZvO6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8H9RLaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03639C32782;
	Thu,  8 Aug 2024 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723136509;
	bh=+wBfE+kitxneWQlu3bzEy3GY/tPjoRmi4VJlsfIqxAM=;
	h=From:To:Cc:Subject:Date:From;
	b=O8H9RLaExZAb5KfgQ16wwIYFNRRdIRWwxmCe1rpYJAeCC+2MMcSA3UoZKV7O3SG+E
	 LRak7IFCSi7eF9xYVpEkk+qCS2DVvUnStPij3pXl+xzGRaXxY4t2arQwENdwZSwWSf
	 XwZ4SZM2ym550F6Vj2MXPj0ASny0hfbxt/fQLqX9vN92t+9Gvhh9x+PfI1A6zjMIvP
	 xJKmXnhS82UVJkzlDwtYoFvv50qpqJzV/G1AlzX6SviQn0jhFjoIL31b2oIE0U4GWx
	 R2dn/urJyIUdRuBTS+NdlbtDpEWja7GitZ28chG5UkoH+CB9zJLySPRHgFbc+Th4uu
	 jPBhbtAH6jIiA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.11-rc3
Date: Thu,  8 Aug 2024 10:01:48 -0700
Message-ID: <20240808170148.3629934-1-kuba@kernel.org>
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

The following changes since commit 183d46ff422ef9f3d755b6808ef3faa6d009ba3a:

  Merge tag 'net-6.11-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-08-01 09:42:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc3

for you to fetch changes up to 2ff4ceb0309abb3cd1843189e99e4cc479ec5b92:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-08-08 09:02:25 -0700)

----------------------------------------------------------------
Including fixes from bluetooth.

Current release - regressions:

 - eth: bnxt_en: fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()
   on older chips

Current release - new code bugs:

 - ethtool: fix off-by-one error / kdoc contradicting the code
   for max RSS context IDs

 - Bluetooth: hci_qca:
    - QCA6390: fix support on non-DT platforms
    - QCA6390: don't call pwrseq_power_off() twice
    - fix a NULL-pointer derefence at shutdown

 - eth: ice: fix incorrect assigns of FEC counters

Previous releases - regressions:

 - mptcp: fix handling endpoints with both 'signal' and 'subflow'
   flags set

 - virtio-net: fix changing ring count when vq IRQ coalescing not
   supported

 - eth: gve: fix use of netif_carrier_ok() during reconfig / reset

Previous releases - always broken:

 - eth: idpf: fix bugs in queue re-allocation on reconfig / reset

 - ethtool: fix context creation with no parameters

Misc:

 - linkwatch: use system_unbound_wq to ease RTNL contention

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexander Lobakin (2):
      idpf: fix memory leaks and crashes while performing a soft reset
      idpf: fix UAFs when destroying the queues

Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

Arnd Bergmann (1):
      net: pse-pd: tps23881: include missing bitfield.h header

Bartosz Golaszewski (3):
      Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
      Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
      Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown

Csókás, Bence (1):
      net: fec: Stop PPS on driver remove

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

David S. Miller (1):
      Merge branch 'virtio-net-rq-coalescing' into main

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dmitry Safonov (1):
      net/tcp: Disable TCP-AO static key after RCU grace period

Edward Cree (1):
      net: ethtool: fix off-by-one error in max RSS context IDs

Eric Dumazet (1):
      net: linkwatch: use system_unbound_wq

Florian Fainelli (1):
      net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities

Gal Pressman (1):
      ethtool: Fix context creation with no parameters

Grzegorz Nitka (2):
      ice: Fix reset handler
      ice: Skip PTP HW writes during PTP reset procedure

Heng Qi (2):
      virtio-net: check feature before configuring the vq coalescing command
      virtio-net: unbreak vq resizing when coalescing is not negotiated

Jakub Kicinski (4):
      Merge branch 'mptcp-fix-endpoints-with-signal-and-subflow-flags'
      Merge branch 'idpf-fix-3-bugs-revealed-by-the-chapter-i'
      Merge tag 'for-net-2024-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

James Chapman (1):
      l2tp: fix lockdep splat

Joe Hattori (1):
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_register()

Kuniyuki Iwashima (1):
      sctp: Fix null-ptr-deref in reuseport_add_sock().

Kyle Swenson (1):
      net: pse-pd: tps23881: Fix the device ID check

Martin Whitaker (1):
      net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.

Mateusz Polchlopek (1):
      ice: Fix incorrect assigns of FEC counts

Matthieu Baerts (NGI0) (7):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow

Michael Chan (1):
      bnxt_en : Fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()

Michal Kubiak (1):
      idpf: fix memleak in vport interrupt configuration

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Praveen Kaligineedi (1):
      gve: Fix use of netif_carrier_ok()

Russell King (Oracle) (1):
      net: stmmac: dwmac4: fix PCS duplex mode decode

Stephen Hemminger (1):
      MAINTAINERS: update status of sky2 and skge drivers

Tristram Ha (1):
      net: dsa: microchip: Fix Wake-on-LAN check to not return an error

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zhengchao Shao (1):
      net/smc: add the max value of fallback reason count

 MAINTAINERS                                        |  2 +-
 drivers/bluetooth/hci_qca.c                        | 19 ++++----
 drivers/net/dsa/bcm_sf2.c                          |  4 +-
 drivers/net/dsa/microchip/ksz_common.c             | 16 +++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 13 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 14 ++----
 drivers/net/ethernet/freescale/fec_ptp.c           |  3 ++
 drivers/net/ethernet/google/gve/gve_ethtool.c      |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c         | 12 ++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  8 ++--
 drivers/net/ethernet/intel/ice/ice_main.c          |  2 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  4 ++
 drivers/net/ethernet/intel/idpf/idpf_lib.c         | 48 +++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 43 ++++-------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  2 +-
 drivers/net/pse-pd/tps23881.c                      |  5 +-
 drivers/net/usb/qmi_wwan.c                         |  2 +
 drivers/net/virtio_net.c                           | 14 +++++-
 include/linux/ethtool.h                            | 10 ++--
 net/bluetooth/hci_sync.c                           | 14 ++++++
 net/bluetooth/l2cap_core.c                         |  1 +
 net/bridge/br_multicast.c                          |  4 +-
 net/core/link_watch.c                              |  4 +-
 net/ethtool/ioctl.c                                | 18 ++++---
 net/ipv4/tcp_ao.c                                  | 43 ++++++++++++-----
 net/l2tp/l2tp_core.c                               | 15 +++++-
 net/mptcp/options.c                                |  3 +-
 net/mptcp/pm_netlink.c                             | 47 +++++++++++-------
 net/sctp/input.c                                   | 19 ++++----
 net/smc/smc_stats.h                                |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 55 ++++++++++++++++------
 33 files changed, 276 insertions(+), 176 deletions(-)

