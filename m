Return-Path: <netdev+bounces-27489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54B77C284
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB671C20BB2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7EDF64;
	Mon, 14 Aug 2023 21:41:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3DDDCB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6667C433C8;
	Mon, 14 Aug 2023 21:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049309;
	bh=MgkdN53feOlNKdjXarDJyyatmuvzY/Ucmd6fglfoO6w=;
	h=From:To:Cc:Subject:Date:From;
	b=tzLIWcghV530N9YP9C6ycC01vrPSZQ4pJa/Ob314TWNX6yULGYC3CGAgS5tqpCEe/
	 2Lyd1opBDYKpSexGRVH7BM/MQgoShzH+3H7ghXiSy/ZsnwyGJn0DEyxStNuGbccFMm
	 ubF2KBlbmwnGwvjBHqHcbVBV+yCqpz1ZR0O3+gHuFcyXJ0MCVkQRXJ13QikRc2mE0Y
	 kEupmRg8Yd81zeA1vXWKDGuBr8YaS1UEDEjGyiZNSjygHPlO+eb93izkbkJLs4NwEN
	 7zqS2CFk+V0r4RWREImtX5F+Ht6sCnc63fQBFXcPvKUZmywD3Qs8lqIQ2D2pmOAn3x
	 YSLLLOCIe2rCw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/14] mlx5 updates 2023-08-14
Date: Mon, 14 Aug 2023 14:41:30 -0700
Message-ID: <20230814214144.159464-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides updates to mlx5 driver.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit f3cc00303cdbc82f719e0cf0dc6f057e8741b5ee:

  Merge branch 'devlink-introduce-selective-dumps' (2023-08-14 11:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-08-14

for you to fetch changes up to bd3a2f77809b84df5dc15edd72cf9955568e698e:

  net/mlx5: Don't query MAX caps twice (2023-08-14 14:40:22 -0700)

----------------------------------------------------------------
mlx5-updates-2023-08-14

1) Handle PTP out of order CQEs issue
2) Check FW status before determining reset successful
3) Expose maximum supported SFs via devlink resource
4) MISC cleanups

----------------------------------------------------------------
Jianbo Liu (1):
      net/mlx5: E-switch, Add checking for flow rule destinations

Jiri Pirko (5):
      net/mlx5: Use auxiliary_device_uninit() instead of device_put()
      net/mlx5: Remove redundant SF supported check from mlx5_sf_hw_table_init()
      net/mlx5: Use mlx5_sf_start_function_id() helper instead of directly calling MLX5_CAP_GEN()
      net/mlx5: Remove redundant check of mlx5_vhca_event_supported()
      net/mlx5: Fix error message in mlx5_sf_dev_state_change_handler()

Moshe Shemesh (1):
      net/mlx5: Check with FW that sync reset completed successfully

Rahul Rameshbabu (3):
      net/mlx5: Consolidate devlink documentation in devlink/mlx5.rst
      net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs
      net/mlx5e: Add recovery flow for tx devlink health reporter for unhealthy PTP SQ

Shay Drory (4):
      net/mlx5: Expose max possible SFs via devlink resource
      net/mlx5: Remove unused CAPs
      net/mlx5: Remove unused MAX HCA capabilities
      net/mlx5: Don't query MAX caps twice

 .../ethernet/mellanox/mlx5/counters.rst            |   6 +
 .../ethernet/mellanox/mlx5/devlink.rst             | 313 ---------------------
 .../ethernet/mellanox/mlx5/index.rst               |   1 -
 Documentation/networking/devlink/mlx5.rst          | 182 ++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |   8 +
 .../net/ethernet/mellanox/mlx5/core/en/health.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   | 237 ++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |  59 +++-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  65 +++++
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  28 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  31 ++
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |  59 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  39 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  16 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   3 +
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |  12 +-
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |  49 +++-
 include/linux/mlx5/device.h                        |  69 +----
 include/linux/mlx5/driver.h                        |   1 -
 include/linux/mlx5/mlx5_ifc.h                      |  46 +--
 25 files changed, 672 insertions(+), 569 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst

