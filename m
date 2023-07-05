Return-Path: <netdev+bounces-15600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ADA748B1B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152FC1C20B85
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513C13AD0;
	Wed,  5 Jul 2023 17:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36E134CE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E59C433C8;
	Wed,  5 Jul 2023 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579896;
	bh=gaZ09ba7r2oMCzzs/80wqqJKMLY0mCoKhMl8ekyKTHs=;
	h=From:To:Cc:Subject:Date:From;
	b=TDtg8ERRMoDX6v1t6rrzUfS/jaQx96N4d/mjJs+SFYIrRofNTgQLHOTQZ/m7uzksI
	 BlkBEVLZcInx0m9AxSD+5XG7oKAD+1RrZoZQWNhvJGRWfma/IMfq0m5n2ZDGq9n6Bh
	 v5iWD/UGdWqkiAydi/QHaF2t1NQ0y9DAhuokJKpCqZMi8tifYDfTJwHrkeOok+kOE6
	 q7PjqjDJCRVTGv0ggYjk7qwqyi3eqOLDXOLxaOC8N1cF7tiqsViGK6kEDURsl9Qmv7
	 ANjzX8AKp8GjpdBSB0hCMakspzxIwbltXs+4PJGZ23+uAxNRT6hHBhdSN0+1U/C+9h
	 0b6ZKoaT7nl+w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net V2 0/9] mlx5 fixes 2023-07-05
Date: Wed,  5 Jul 2023 10:57:48 -0700
Message-ID: <20230705175757.284614-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

V1->V2:
 - Fix build issue.

This series provides bug fixes to mlx5 driver.
Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit c451410ca7e3d8eeb31d141fc20c200e21754ba4:

  Merge branch 'mptcp-fixes' (2023-07-05 10:51:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-07-05

for you to fetch changes up to 7abd955a58fb0fcd4e756fa2065c03ae488fcfa7:

  net/mlx5e: RX, Fix page_pool page fragment tracking for XDP (2023-07-05 10:57:04 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-07-05

----------------------------------------------------------------
Dragos Tatulea (2):
      net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq
      net/mlx5e: RX, Fix page_pool page fragment tracking for XDP

Maher Sanalla (1):
      net/mlx5: Query hca_cap_2 only when supported

Saeed Mahameed (1):
      net/mlx5: Register a unique thermal zone per device

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Yevgeny Kliteynik (1):
      net/mlx5e: TC, CT: Offload ct clear only once

Zhengchao Shao (3):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
      net/mlx5e: fix memory leak in mlx5e_ptp_open

 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  6 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 14 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 44 +++++++++++-----------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  3 ++
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  | 19 ++++++----
 10 files changed, 61 insertions(+), 42 deletions(-)

