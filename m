Return-Path: <netdev+bounces-57149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07741812482
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE55C1F2198A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19866656;
	Thu, 14 Dec 2023 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3OLaf/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E0645
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1EC433C7;
	Thu, 14 Dec 2023 01:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517109;
	bh=7QgJ+7lkaP9ERvDukejNc5mGPtSq9SVhp6/Tidz8HV0=;
	h=From:To:Cc:Subject:Date:From;
	b=A3OLaf/OLeXi+QREk0uvzEHWqQDZ06RLCWhBy13cSDpaIJ7dmxUmyByH0TKRUQvI/
	 OwQO6K/1JNY7swcOX1+9KQYG2NgXno+SjrxQFSVNzNlLirhAqJsGzC+UnBjBDGN5j2
	 sRUbBMAKf1Yl2W9Y4raLuNTWi4NeX0SGATVhaufZsA8uoNOwfYUfUbOklTNxg9aTPZ
	 WfOQVXXUbKDJmFMabM/0wkjBc0aW7TzN1WrftD29D5JPBruiAijJgWRueDo6LO6+67
	 CKhpULGoOCpOKo0qenfOxfDiPV3UvAKgr78IiBIiwR9RqQ/+8E2xUStJUkR63E2d8c
	 w535KqS4WI5/A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/15] mlx5 fixes 2023-12-13
Date: Wed, 13 Dec 2023 17:24:50 -0800
Message-ID: <20231214012505.42666-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides bug fixes to mlx5 driver.
Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 9702817384aa4a3700643d0b26e71deac0172cfd:

  Revert "tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set" (2023-12-13 10:58:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-12-13

for you to fetch changes up to b13559b76157de9d74f04d3ca0e49d69de3b5675:

  net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors (2023-12-13 17:22:20 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-12-13

----------------------------------------------------------------
Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Dan Carpenter (2):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Vlad Buslov (4):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5e: fix double free of encap_header
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 12 +++---
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    | 50 ++++++++++++----------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 10 +++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 31 ++++++++------
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  2 +-
 15 files changed, 79 insertions(+), 54 deletions(-)

