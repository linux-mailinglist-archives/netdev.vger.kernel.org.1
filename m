Return-Path: <netdev+bounces-69321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFC484AB30
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C411F2512B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7182EC7;
	Tue,  6 Feb 2024 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auu5hfmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A58ECF
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180930; cv=none; b=IKF8XQQcYMCx0n6Dc5eM4CfSV4lyegn0ydD1GOTiHbph3Z+WC3Od8jHYtvH1qcyPeKmFfKTVE0JLrPP80gbUHH9RKKMbROXYF2Y99Gv4k6G8LzzIKcOhD2eXFP8Jlue6PEYqkktBheLDjMKLgPHkQJjSuQXnICkKDBYhkdrcaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180930; c=relaxed/simple;
	bh=VpgReO22dBPQR/P4QEQrcbqz8MN0+wnQLMD2zSVI2G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wi8dnaxmiV0XyIjooC3szokggJ12YjETJal+FrlDOFE80Nhkv0eCG/2BEuC4PPPWyInBlXPUzQbnMsu064qGSnuKdFTUS6WkAfi8qIeqoGoR6uYXjBfO8O5kVaNWannNnk8ASmG0GVQs9HIBoGWzKZjhVPqJGRpzVEkNbTKjeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auu5hfmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2700C433C7;
	Tue,  6 Feb 2024 00:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180930;
	bh=VpgReO22dBPQR/P4QEQrcbqz8MN0+wnQLMD2zSVI2G0=;
	h=From:To:Cc:Subject:Date:From;
	b=auu5hfmfmxRT9oaoKduzDQa6w2jUU0uWuACdDExL77FWT0V80ME0uE3ifqua6RvR9
	 w7icA7IF3fBLVBDrnmGCwYNLI32fG2ZsyHFqKUC//pstt0bgZvB97V8IJIlnf4Yuy5
	 8MLDM7lDfWcLWG4jIm4Lgc8+SO9BlXHrCJ7Ark/RS55cz4r713jtA9ngfsBiztzzob
	 fMqabKZtwEX27+EO4shFPUXCj0GT2nzU/W3oQWe/NJWRjc0ehVyR71B+IFVJCB63Jk
	 RBScjqwPK+3GPEKFOvqjmG8EzwZ1TwDmn5fZTBlI24P4T5MMAxwYbPixHs7hB5effe
	 ACYgKwa6d7i/A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net-next V4 00/15] mlx5 updates 2024-01-26
Date: Mon,  5 Feb 2024 16:55:12 -0800
Message-ID: <20240206005527.1353368-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v3->v4:
 - Prevent a use after free in case of error flow inside
   mlx5dr_dbg_create_dump_data() patch #13

v2->v3:
 - Add noinline_for_stack to address large frame size issue patch #13

v1->v2:
 - Fix large stack buffer usage in patch #13

This series provides misc updates to mlx5 and xfrm,
the two xfrm patches are already acked by Steffen Klassert in the
previous release cycle.

For more information please see tag log below.
Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 8ff25dac88f616ebebb30830e3a20f079d7a30c9:

  netdevsim: add Makefile for selftests (2024-02-05 07:34:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-02-01

for you to fetch changes up to a90f55916f150ced7b2635bedd43676f922ee075:

  net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations (2024-02-05 16:45:53 -0800)

----------------------------------------------------------------
mlx5-updates-2024-02-01

1) IPSec global stats for xfrm and mlx5
2) XSK memory improvements for non-linear SKBs
3) Software steering debug dump to use seq_file ops
4) Various code clean-ups

----------------------------------------------------------------
Carolina Jubran (2):
      net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
      net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations

Gal Pressman (2):
      net/mlx5: Remove initial segmentation duplicate definitions
      net/mlx5: Change missing SyncE capability print to debug

Hamdan Igbaria (1):
      net/mlx5: DR, Change SWS usage to debug fs seq_file interface

Leon Romanovsky (4):
      xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
      xfrm: get global statistics from the offloaded device
      net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
      net/mlx5e: Delete obsolete IPsec code

Moshe Shemesh (6):
      Documentation: Fix counter name of mlx5 vnic reporter
      net/mlx5: Rename mlx5_sf_dev_remove
      net/mlx5: remove fw_fatal reporter dump option for non PF
      net/mlx5: remove fw reporter dump option for non PF
      net/mlx5: SF, Stop waiting for FW as teardown was called
      net/mlx5: Return specific error code for timeout on wait_fw_init

 Documentation/networking/devlink/mlx5.rst          |   5 +-
 Documentation/networking/xfrm_device.rst           |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  24 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  26 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |   1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c      |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  45 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  38 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   7 -
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |   9 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  21 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.c  | 734 +++++++++++++++++----
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.h  |  20 +
 include/linux/mlx5/mlx5_ifc.h                      |   1 +
 include/linux/netdevice.h                          |   2 +-
 include/net/xfrm.h                                 |  14 +-
 net/xfrm/xfrm_proc.c                               |   1 +
 net/xfrm/xfrm_state.c                              |  17 +-
 net/xfrm/xfrm_user.c                               |   2 +-
 23 files changed, 766 insertions(+), 240 deletions(-)

