Return-Path: <netdev+bounces-12904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D87396F3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF41281800
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D210C;
	Thu, 22 Jun 2023 05:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00F17E0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03AAC433C0;
	Thu, 22 Jun 2023 05:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412866;
	bh=quZI4i8J3Qef5anMThWqPMzmxIXVFd39TP8ryOomEy8=;
	h=From:To:Cc:Subject:Date:From;
	b=Vkp77bpTGV9AaKzO43Ef7d/hEGK2kHjb+N+AqNyk7bkd9H1HU0SwsY2vDXIztb2V1
	 ecj0SAioHAZI8aNxbP+roMU5b3aHhHtYZfLhorpV+JxgxPLAcinNGogZd2P9wJfW0K
	 o3sLabZE43w7OW4jvwh0rB79GU/dBiwFZNYLbU0as0XD2NMnPAVepmk/OaI8EgZ5Ui
	 jvSl9G2CNo1vnZRykg2L900a7F+l8Ro8ikxXHT7xf42yMrsZktLLTBH3ZYucKUdFAV
	 R8e7aGkxvGW6qKxmprRV5dqsPQn79z8X/L2iYnEyFvnqC0o8tMePqLCthP75oim/hM
	 YwgMEJncfybzg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-06-21
Date: Wed, 21 Jun 2023 22:47:20 -0700
Message-ID: <20230622054735.46790-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides minor cleanups and bug fixes for net-next branch.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 53bf91641ae19fe51fb24422de6d07565a3536d0:

  inet: Cleanup on charging memory for newly accepted sockets (2023-06-21 17:37:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-06-21

for you to fetch changes up to e921b6931f93b34ede1dbf150042bfac6475db09:

  net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type() (2023-06-21 22:43:55 -0700)

----------------------------------------------------------------
mlx5-updates-2023-06-21

mlx5 driver minor cleanup and fixes to net-next

----------------------------------------------------------------
Dan Carpenter (1):
      net/mlx5: Fix error code in mlx5_is_reset_now_capable()

Jiri Pirko (4):
      net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
      net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
      net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
      net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()

Lama Kayal (1):
      net/mlx5: Fix reserved at offset in hca_cap register

Roi Dayan (7):
      net/mlx5: Lag, Remove duplicate code checking lag is supported
      net/mlx5e: Use vhca_id for device index in vport rx rules
      net/mlx5e: E-Switch, Add peer fdb miss rules for vport manager or ecpf
      net/mlx5e: E-Switch, Use xarray for devcom paired device index
      net/mlx5e: E-Switch, Pass other_vport flag if vport is not 0
      net/mlx5e: Remove redundant comment
      net/mlx5e: E-Switch, Fix shared fdb error flow

Shay Drory (2):
      net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
      net/mlx5: Fix SFs kernel documentation error

 .../ethernet/mellanox/mlx5/switchdev.rst           | 22 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  6 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 24 +++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 61 ++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 15 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  | 10 +---
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 10 files changed, 84 insertions(+), 68 deletions(-)

