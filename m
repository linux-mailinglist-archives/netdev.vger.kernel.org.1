Return-Path: <netdev+bounces-35118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94197A72D8
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58341C208E9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B53D72;
	Wed, 20 Sep 2023 06:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4E185E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8B1C433C7;
	Wed, 20 Sep 2023 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695191758;
	bh=KxzxZEQn9tj38nj4mlz/1TByg245o1U0Xh4Y3H+PstI=;
	h=From:To:Cc:Subject:Date:From;
	b=CBiLt4QZMHZTy20Ofo2zlKlShlhtqvDvWRx/wtg8pg2+q05Ss8pS5JXp5qWfsRo2q
	 b78bGQrSSK1GGcTghUC8l2iUeyZe0hJ2EDnce9RE4tRhLphaNMmTzxLdogNH+9d8WZ
	 59a3xyWWCrLWilBMx7sD7MvDo/QjlhoFGJrNZkbR0a9N5Hof9SOLxcCEwh5hPRlQoO
	 e6aSWbL5RkQtFSiELiuCTtzj0XdCIMl0nI1L285FPTAcIyqvs/Yzr9IqYVcA43bduF
	 pP/QTxkxRuC1hHRMu+bngn3E3OQcYQKZ2CiKPL17RE1yStkG+HvJvk2opVSbMb3drh
	 SOqHzCaowF9tw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-09-19
Date: Tue, 19 Sep 2023 23:35:37 -0700
Message-ID: <20230920063552.296978-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds misc updates to mlx5.

For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 5bed8d585aa1db1651745173a66e32df82a5cb05:

  Merge branch 'add-wed-support-for-mt7988-chipset' (2023-09-19 18:28:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-09-19

for you to fetch changes up to e738e355045237ee8802cb2b31a8ed6f4b7ac534:

  net/mlx5: Enable 4 ports multiport E-switch (2023-09-19 23:33:09 -0700)

----------------------------------------------------------------
mlx5-updates-2023-09-19

Misc updates for mlx5 driver

1) From Erez, Add support for multicast forwarding to multi destination
   in bridge offloads with software steering mode (SMFS).

2) From Jianbo, Utilize the maximum aggregated link speed for police
   action rate.

3) From Moshe, Add a health error syndrome for pci data poisoned

4) From Shay, Enable 4 ports multiport E-switch

5) From Jiri, Trivial SF code cleanup

----------------------------------------------------------------
Erez Shitrit (3):
      net/mlx5: Bridge, Enable mcast in smfs steering mode
      net/mlx5: DR, Add check for multi destination FTE
      net/mlx5: DR, Handle multi destination action in the right order

Jianbo Liu (2):
      net/mlx5e: Consider aggregated port speed during rate configuration
      net/mlx5e: Check police action rate for matchall filter

Jiri Pirko (8):
      net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()
      net/mlx5: Use devlink port pointer to get the pointer of container SF struct
      net/mlx5: Convert SF port_indices xarray to function_ids xarray
      net/mlx5: Move state lock taking into mlx5_sf_dealloc()
      net/mlx5: Rename mlx5_sf_deactivate_all() to mlx5_sf_del_all()
      net/mlx5: Push common deletion code into mlx5_sf_del()
      net/mlx5: Remove SF table reference counting
      net/mlx5: Remove redundant max_sfs check and field from struct mlx5_sf_dev_table

Moshe Shemesh (1):
      net/mlx5: Add a health error syndrome for pci data poisoned

Shay Drory (1):
      net/mlx5: Enable 4 ports multiport E-switch

 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |  96 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   2 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  18 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |  15 --
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   | 222 ++++++---------------
 .../mellanox/mlx5/core/steering/dr_action.c        |  35 +++-
 .../mellanox/mlx5/core/steering/dr_types.h         |   1 +
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   9 +-
 include/linux/mlx5/fs.h                            |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   1 +
 11 files changed, 203 insertions(+), 208 deletions(-)

