Return-Path: <netdev+bounces-21627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F576412F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A31C213BA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC61BF0F;
	Wed, 26 Jul 2023 21:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC931BEFD
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B2FC433C7;
	Wed, 26 Jul 2023 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407129;
	bh=Yjr8JtpxvVZa+p4W6remtB2YP1lqrxAEkNRdtmt8ePw=;
	h=From:To:Cc:Subject:Date:From;
	b=aidMl5eH7/ZhpRSbEcs5KseSvK7Aw5fQp+U9es5vW7d3x9vcQoGq4d6kC1wKoYSep
	 y6WtqdcSc7DjIigx6vX5GlPqo+LCh3bFlmr4VIVy88mLKRAzP53z4AEieRkUKmOI3g
	 9mJXQBum1iTllkKuOOfh2vCMPvWsSUN1SdgmyvmtNvlRU/9FQF0nR6sLycMMX8R+AI
	 tRyGq3hqdYOEG/CHRFo2/8em9ENxHoU6I+hBq353dvBKnViGfSDE1DzfnuA7JQLtdv
	 oIk0m/V3JsrM8yNetXabzBeGIlHUvzlXp2onLBgPsSIGV4agiYoX3vh769vNw69WKn
	 umVR9NTSQwpDw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/15] mlx5 fixes 2023-07-26
Date: Wed, 26 Jul 2023 14:31:51 -0700
Message-ID: <20230726213206.47022-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
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


The following changes since commit fa29d467977d50400f6bb1374e942e7474fdf53c:

  Merge branch 'tools-ynl-gen-fix-parse-multi-attr-enum-attribute' (2023-07-26 13:38:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-07-26

for you to fetch changes up to 53d737dfd3d7b023fa9fa445ea3f3db0ac9da402:

  net/mlx5: Unregister devlink params in case interface is down (2023-07-26 14:31:05 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-07-26

----------------------------------------------------------------
Amir Tzin (1):
      net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set

Chris Mi (2):
      net/mlx5e: Don't hold encap tbl lock if there is no encap action
      net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supported

Dragos Tatulea (2):
      net/mlx5e: xsk: Fix invalid buffer access for legacy rq
      net/mlx5e: xsk: Fix crash on regular rq reactivation

Jianbo Liu (2):
      net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
      net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink reload

Shay Drory (3):
      net/mlx5: Honor user input for migratable port fn attr
      net/mlx5: DR, Fix peer domain namespace setting
      net/mlx5: Unregister devlink params in case interface is down

Vlad Buslov (1):
      net/mlx5: Bridge, set debugfs access right to root-only

Yuanjun Gong (1):
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Zhengchao Shao (3):
      net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
      net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 ---
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |  5 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |  4 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |  8 ------
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c | 29 +++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/macsec_fs.c        |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  | 10 ++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 29 ++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 20 +++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 21 +++++++++++++---
 .../mellanox/mlx5/core/esw/bridge_debugfs.c        |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 17 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  4 +--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  1 +
 .../mellanox/mlx5/core/steering/dr_action.c        |  2 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |  5 ++--
 .../mellanox/mlx5/core/steering/dr_domain.c        | 19 +++++++++-----
 .../mellanox/mlx5/core/steering/dr_ste_v0.c        |  7 +++---
 .../mellanox/mlx5/core/steering/dr_ste_v1.c        |  7 +++---
 .../mellanox/mlx5/core/steering/dr_types.h         |  2 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |  4 +--
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |  2 +-
 26 files changed, 137 insertions(+), 73 deletions(-)

