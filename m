Return-Path: <netdev+bounces-44883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B17DA34B
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B7B21270
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0654405D2;
	Fri, 27 Oct 2023 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZRIYbPY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AA3FE33
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E5C433C7;
	Fri, 27 Oct 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698445217;
	bh=gxbH6CBN3Q6vzd+roxXz0o3+OsSmkEcKiaL6fBdYknU=;
	h=From:To:Cc:Subject:Date:From;
	b=kZRIYbPYFVzV7VAqq0INs4MLlEDl7PnpNQWaRFXDiKxnCf938Mx5deoRWtHLAasio
	 Mqcc1uLmwFAtyJKqM3ZOgg0XJ1YWQXK6c2ye5lzWivSYNAoq208S9BD8B4P/levfZk
	 J6FE67vvk4j/2EjjC9UI2U3YmJ0us0cfaJKsGEcwToWZ+29bHCy9ymSJ76JVzsXVLi
	 YPqt1E8cRSKrXwOt7Z6fqC9GAWNwZce52HcenZIDxQMlbW/Qpy4x60/yRjTxxzE6Ja
	 EtTuZoB0QRVahr2QbLB+OFobv7AaTWq6zxsDW8kA4jqjmqRpqRkj4ZQpBTGD/pgIAs
	 r/9cWA/zB5tFw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/11] mlx5 updates 2023-10-27
Date: Fri, 27 Oct 2023 15:19:55 -0700
Message-ID: <20231027222006.115999-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides few cleanups to mlx5 prior to merge window.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit d96e48a3d55db7ee62e607ad2d89eee1a8585028:

  tools: ynl: introduce option to process unknown attributes or types (2023-10-27 14:54:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-10-27

for you to fetch changes up to 284e9944eafab558b9da5f34782288bff8752ddd:

  net/mlx5e: Access array with enum values instead of magic numbers (2023-10-27 15:05:29 -0700)

----------------------------------------------------------------
mlx5-updates-2023-10-27

Few mlx5 pending cleanups.

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

Rahul Rameshbabu (3):
      net/mlx5: Increase size of irq name buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

 .../net/ethernet/mellanox/mlx5/core/diag/crdump.c  |  5 +++-
 .../net/ethernet/mellanox/mlx5/core/en/rep/tc.c    | 14 ++++++++++
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |  4 +--
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 13 ++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 12 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 24 +++-------------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h    |  2 --
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 32 +++++++++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 20 ++------------
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  6 ++--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |  3 ++
 14 files changed, 82 insertions(+), 60 deletions(-)

