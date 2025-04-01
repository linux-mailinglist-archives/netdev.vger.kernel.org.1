Return-Path: <netdev+bounces-178477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE89A771BE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246C03AC585
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106EC2C6;
	Tue,  1 Apr 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIxcpsMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA22110;
	Tue,  1 Apr 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466245; cv=none; b=ExJEHMItawRITlOq96WC/la0JZVtVg9XzBM5cQWVixNyYrNGtA4cmEh4i1+pNtAiTzA9hR5ylsQ+ksBTFIjxkzDdczDd3hq6KpPfgh+OWADLCOQE76M2VFlaECTsVHiUtcilZtMupEawsH9phMFAC12k3zXjK5Lhvw3hmI11/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466245; c=relaxed/simple;
	bh=n2nI7bVWJSUo4e+nmn6e/SSDeji7IgYEJ7GR16ykhk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlwYM3THs6FkuWwBkmEjTk7ymA+wnZny9+UgAcSuY66rQxOBB4PBDwB81GVPddYI0jJFrMGwr/dYiuJWh4QGd+fW5dDLipvXHGFW5U1JQ1FOtXP0WrFUGJSWOyaPxekRUvqsophfcylmZQ++U1qQC9Pc9e5NM3+otrTe3UtWBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIxcpsMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC1FC4CEE5;
	Tue,  1 Apr 2025 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466244;
	bh=n2nI7bVWJSUo4e+nmn6e/SSDeji7IgYEJ7GR16ykhk8=;
	h=From:To:Cc:Subject:Date:From;
	b=QIxcpsMCfApfZ71OdtQN07KtNezz9EBufYw4dbTP8t29o9Hyp9ihsjHNY1QmgrVBi
	 U78giJ98YnPZRdR92TXorM0f0xEl1ILxGe34grV6z8X4rQXVdNcwZBqvbaxVnEt9MK
	 yIUgmnYf6JO6LR4v+ueZozCyq7IfoE2reGSNAvkVZoZSwiGssB1EKShDclp9fuyZ0d
	 qfwH65ANHZKqibdpr32qY0IjYI8LwvpI6DvdJ5KesUccrqKh46nKjB7czeYwWtdEtF
	 mdj4D8n5RAKUYDAljxlMmOKKFlnPby5ZhhG+k6M4IH7PR8uw5dmU6uTbV0bmZkcOsE
	 wzwaJBo6nhkkg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15-rc0
Date: Mon, 31 Mar 2025 17:10:43 -0700
Message-ID: <20250401001043.787834-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95:

  Merge tag 'net-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-03-26 21:48:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc0

for you to fetch changes up to f278b6d5bb465c7fd66f3d103812947e55b376ed:

  Revert "tcp: avoid atomic operations on sk->sk_rmem_alloc" (2025-03-31 16:53:54 -0700)

----------------------------------------------------------------
Rather tiny PR, mostly so that we can get into our trees your fix
to the x86 Makefile.

Current release - regressions:

 - Revert "tcp: avoid atomic operations on sk->sk_rmem_alloc",
   error queue accounting was missed

Current release - new code bugs:

 - 5 fixes for the netdevice instance locking work

Previous releases - regressions:

 - usbnet: restore usb%d name exception for local mac addresses

Previous releases - always broken:

 - rtnetlink: allocate vfinfo size for VF GUIDs when supported,
   avoid spurious GET_LINK failures

 - eth: mana: Switch to page pool for jumbo frames

 - phy: broadcom: Correct BCM5221 PHY model detection

Misc:

 - selftests: drv-net: replace helpers for referring to other files

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Cong Liu (1):
      selftests: mptcp: fix incorrect fd checks in main_loop

Dominique Martinet (1):
      net: usb: usbnet: restore usb%d name exception for local mac addresses

Eric Dumazet (2):
      net: lapbether: use netdev_lockdep_set_classes() helper
      Revert "tcp: avoid atomic operations on sk->sk_rmem_alloc"

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Geetha sowjanya (2):
      octeontx2-af: Fix mbox INTR handler when num VFs > 64
      octeontx2-af: Free NIX_AF_INT_VEC_GEN irq

Geliang Tang (1):
      selftests: mptcp: close fd_in before returning in main_loop

Haiyang Zhang (1):
      net: mana: Switch to page pool for jumbo frames

Jakub Kicinski (6):
      selftests: drv-net: replace the rpath helper with Path objects
      selftests: net: use the dummy bpf from net/lib
      selftests: net: use Path helpers in ping
      Merge branch 'selftests-drv-net-replace-the-rpath-helper-with-path-objects'
      Merge branch 'mptcp-misc-fixes-for-6-15-rc0'
      eth: gve: add missing netdev locks on reset and shutdown paths

Jim Liu (1):
      net: phy: broadcom: Correct BCM5221 PHY model detection

Lama Kayal (1):
      net/mlx5e: SHAMPO, Make reserved size independent of page size

Lubomir Rintel (1):
      rndis_host: Flag RNDIS modems as WWAN devices

Mark Zhang (1):
      rtnetlink: Allocate vfinfo size for VF GUIDs when supported

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: ignore mptcp_diag binary

Maxime Chevallier (1):
      MAINTAINERS: Add dedicated entries for phy_link_topology

Stanislav Fomichev (2):
      net: move replay logic to tc_modify_qdisc
      bnxt_en: bring back rtnl lock in bnxt_shutdown

Taehee Yoo (1):
      net: fix use-after-free in the netdev_nl_sock_priv_destroy()

 MAINTAINERS                                        |  7 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  2 +
 drivers/net/ethernet/google/gve/gve_main.c         |  4 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  8 ++-
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 46 +++-----------
 drivers/net/phy/broadcom.c                         |  6 +-
 drivers/net/usb/rndis_host.c                       | 16 ++++-
 drivers/net/usb/usbnet.c                           | 21 +++++--
 drivers/net/wan/lapbether.c                        |  2 +
 include/net/tcp.h                                  | 15 -----
 net/core/netdev-genl.c                             |  6 +-
 net/core/rtnetlink.c                               |  3 +
 net/ipv4/tcp.c                                     | 18 +-----
 net/ipv4/tcp_fastopen.c                            |  2 +-
 net/ipv4/tcp_input.c                               |  6 +-
 net/mptcp/subflow.c                                | 15 ++---
 net/sched/sch_api.c                                | 73 ++++++++--------------
 tools/testing/selftests/drivers/net/hds.py         |  2 +-
 tools/testing/selftests/drivers/net/hw/csum.py     |  2 +-
 tools/testing/selftests/drivers/net/hw/irq.py      |  2 +-
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c       | 13 ----
 tools/testing/selftests/drivers/net/lib/py/env.py  | 21 +++----
 tools/testing/selftests/drivers/net/ping.py        | 15 ++---
 tools/testing/selftests/drivers/net/queues.py      |  4 +-
 tools/testing/selftests/net/mptcp/.gitignore       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 11 ++--
 tools/testing/selftests/net/udpgro_bench.sh        |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  2 +-
 tools/testing/selftests/net/veth.sh                |  2 +-
 tools/testing/selftests/net/xdp_dummy.bpf.c        | 13 ----
 33 files changed, 141 insertions(+), 205 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
 delete mode 100644 tools/testing/selftests/net/xdp_dummy.bpf.c

