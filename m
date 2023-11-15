Return-Path: <netdev+bounces-48175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4207ECD82
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C34B20B71
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB91B4177E;
	Wed, 15 Nov 2023 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpaolTy/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118D41A80
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB44C433C7;
	Wed, 15 Nov 2023 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077012;
	bh=t9pgMXEHuZGlMkXRY6/nwnyBvN5rqlYYJpwa4cPVteY=;
	h=From:To:Cc:Subject:Date:From;
	b=DpaolTy/kM2K50WXFkeDQhIAVhbLBr6bJ7kcQLYREJOTcjV/k/uIjA8nX8TOLFEUE
	 harkAgZkXTmdfSE9xWN8xDPjI+zox2TticNTYe07jaeMt6RspV3o5ry6oOqPaOfeTc
	 KLxPGlGTqNGrGRSf+SdFJQRWm4f7k8b6gggE+RRKBEgkLApCnTNZXQ73zPhYRYvNl+
	 N0nSbhcItRgGHpxKurvLrcTU6RlVsBX4orcIV7fzdQuiuaZcpLdk6uLtdl2uIBTIUd
	 JRqHB8vVVZ5DypNbNRkb3WgXo7E94NbxoKKmw05/wn+4DEtd/fUY0fhzzR5vTNZ6Rs
	 YePFUYLVKZNCw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next V2 00/13] mlx5 updates 2023-11-13
Date: Wed, 15 Nov 2023 11:36:36 -0800
Message-ID: <20231115193649.8756-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
 - Drop lost_cqe statistic patch, will discuss later if this needs to be
   reported via standard interface.

This series adds misc updates to mlx5 driver.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit e316dd1cf1358ff9c44b37c7be273a7dc4349986:

  net: don't dump stack on queue timeout (2023-11-15 10:25:12 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-11-13

for you to fetch changes up to 23ec6972865b59d2f58a1aafd12b108b4dd6caa1:

  net/mlx5e: Remove early assignment to netdev->features (2023-11-15 11:34:31 -0800)

----------------------------------------------------------------
mlx5-updates-2023-11-13

1) Cleanup patches, leftovers from previous cycle

2) Allow sync reset flow when BF MGT interface device is present

3) Trivial ptp refactorings and improvements

4) Add local loopback counter to vport rep stats

----------------------------------------------------------------
Amir Tzin (1):
      net/mlx5e: Some cleanup in mlx5e_tc_stats_matchall()

Gal Pressman (1):
      net/mlx5e: Access array with enum values instead of magic numbers

Justin Stitt (1):
      net/mlx5: simplify mlx5_set_driver_version string assignments

Kees Cook (2):
      net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
      net/mlx5: Annotate struct mlx5_flow_handle with __counted_by

Moshe Shemesh (2):
      net/mlx5: print change on SW reset semaphore returns busy
      net/mlx5: Allow sync reset flow when BF MGT interface device is present

Or Har-Toov (1):
      net/mlx5e: Add local loopback counter to vport rep stats

Rahul Rameshbabu (4):
      net/mlx5: Refactor real time clock operation checks for PHC
      net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
      net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
      net/mlx5: Query maximum frequency adjustment of the PTP hardware clock

Tariq Toukan (1):
      net/mlx5e: Remove early assignment to netdev->features

 .../net/ethernet/mellanox/mlx5/core/diag/crdump.c  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    | 14 ++++
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 26 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 24 ++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |  2 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 32 +++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 78 ++++++++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 20 +-----
 include/linux/mlx5/mlx5_ifc.h                      |  5 +-
 14 files changed, 139 insertions(+), 77 deletions(-)

