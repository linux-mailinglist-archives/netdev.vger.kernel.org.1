Return-Path: <netdev+bounces-47481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06777EA682
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0731F22946
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CB2D78B;
	Mon, 13 Nov 2023 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="max+3V3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A72D631
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB06C433C7;
	Mon, 13 Nov 2023 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916474;
	bh=1EJ/0EidyMOWRsIQkPbycaMLxtwWakRXX5p7R2+NPnk=;
	h=From:To:Cc:Subject:Date:From;
	b=max+3V3Ad3EH/iJNHIF64nTjxqeKq3yA5HJ0F8ob9d55JEXRV2U7fQ3ayRb8qwUJH
	 jWVQDOHDJdDfvS5Bk9roL97mS4j5ioiJpRRYFNaQ1df/mq4SVCBfiiqaSfSya1yvzk
	 RcX/Zp4SUfhHC5HxYkHEOhF0aiEBMfxAGAj1Q2jC7503w6khbXGRLVSfp7U5i6e2VJ
	 xvZUvw/i5A/+8xw9001gIoDX+d2krPNaNKAtZVXKJtYSos9GDcRkd9tQK3QC/hD8Nk
	 MjJvpj8cHMAHtW7vqC+O6GmrBjyMLP3VuyzFmIxfWKDIiL0M8cjjCE4nFrP1XhEcdG
	 LmSBcgmaQSudA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/14] mlx5 updates 2023-11-13
Date: Mon, 13 Nov 2023 15:00:37 -0800
Message-ID: <20231113230051.58229-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds misc updates to mlx5 driver.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-11-13

for you to fetch changes up to 5e6d046ed27608f66dda31c2937dc923f15dddaf:

  net/mlx5e: Remove early assignment to netdev->features (2023-11-13 14:58:57 -0800)

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

Rahul Rameshbabu (5):
      net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
      net/mlx5: Refactor real time clock operation checks for PHC
      net/mlx5: Initialize clock->ptp_info inside mlx5_init_timer_clock
      net/mlx5: Convert scaled ppm values outside the s32 range for PHC frequency adjustments
      net/mlx5: Query maximum frequency adjustment of the PTP hardware clock

Tariq Toukan (1):
      net/mlx5e: Remove early assignment to netdev->features

 .../ethernet/mellanox/mlx5/counters.rst            |  6 ++
 .../net/ethernet/mellanox/mlx5/core/diag/crdump.c  |  5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    | 14 ++++
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 26 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 24 ++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |  2 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 32 +++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    | 78 ++++++++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 20 +-----
 include/linux/mlx5/mlx5_ifc.h                      |  5 +-
 17 files changed, 148 insertions(+), 77 deletions(-)

