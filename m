Return-Path: <netdev+bounces-22018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E5765B73
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C291C215D7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE7B174E7;
	Thu, 27 Jul 2023 18:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAB27159
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65016C433C8;
	Thu, 27 Jul 2023 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483163;
	bh=zS5bu786Q+Iw3ayCbVb6L5bDkgRADx7RkSFMBsqJEhs=;
	h=From:To:Cc:Subject:Date:From;
	b=hEZIzM8FqXmLYnD9JFUyHjhXNYcuH4FH4h9ay8siPqbWpi8qaVkolEQNEeyp+zbHO
	 onqOeG3TuIKXm4tCGaXmagdygAt+CY6UNoVEeG6L+LLe4Ky+Tr08o/vfyKAYZ15Rh0
	 kHPaXAWsXUv2jaCZ7drGf9KhV7Pell5jJVv7fEF0cvrqifa+c3VmDER9c7oT5TKLzC
	 Nm2fGI0w1F5gaS99XyTE7Mer+MwWYLw+9naMy7zVztVbFtve2qMJ12u84OelVZXpsl
	 jh4dgKnWouy9N1XLyP/rQlJTpKhTqcP9QHM0ouUWYjNltbax0kda+OHDsYMOQZL1EI
	 qZ86lzJIGM36g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next V2 00/15] mlx5 updates 2023-07-24
Date: Thu, 27 Jul 2023 11:38:59 -0700
Message-ID: <20230727183914.69229-1-saeed@kernel.org>
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
 - Toss the thermal implementation patches, will be sent separately.
 - Add two more cleanup patches at the end of the series.

This series adds misc updates, generally cleanups.

For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 9d0cd5d25f7d45bce01bbb3193b54ac24b3a60f3:

  Merge branch 'virtio-vsock-some-updates-for-msg_peek-flag' (2023-07-27 15:51:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-07-24

for you to fetch changes up to 9eca8bb8da4385b02bd02b6876af8d4225bf4713:

  net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix (2023-07-27 11:37:31 -0700)

----------------------------------------------------------------
mlx5-updates-2023-07-24

1) Generalize devcom implementation to be independent of number of ports
   or device's GUID.

2) Save memory on command interface statistics.

3) General code cleanups

----------------------------------------------------------------
Jiri Pirko (5):
      net/mlx5: Don't check vport->enabled in port ops
      net/mlx5: Remove pointless devlink_rate checks
      net/mlx5: Make mlx5_esw_offloads_rep_load/unload() static
      net/mlx5: Make mlx5_eswitch_load/unload_vport() static
      net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix

Parav Pandit (2):
      net/mlx5e: Remove duplicate code for user flow
      net/mlx5e: Make flow classification filters static

Roi Dayan (4):
      net/mlx5: Use shared code for checking lag is supported
      net/mlx5: Devcom, Infrastructure changes
      net/mlx5e: E-Switch, Register devcom device with switch id key
      net/mlx5e: E-Switch, Allow devcom initialization on more vports

Shay Drory (4):
      net/mlx5: Re-organize mlx5_cmd struct
      net/mlx5: Remove redundant cmdif revision check
      net/mlx5: split mlx5_cmd_init() to probe and reload routines
      net/mlx5: Allocate command stats with xarray

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 223 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/debugfs.c  |  34 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   3 -
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   6 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   4 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  45 +--
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  22 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |  17 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  18 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  93 ++---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  12 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   | 448 +++++++++++----------
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |  74 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  27 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   2 +
 include/linux/mlx5/driver.h                        |  27 +-
 21 files changed, 579 insertions(+), 538 deletions(-)

