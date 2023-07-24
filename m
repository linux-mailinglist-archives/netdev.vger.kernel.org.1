Return-Path: <netdev+bounces-20572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87276028D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F3B2814EF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597F125C1;
	Mon, 24 Jul 2023 22:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16600100BE
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B77C433C7;
	Mon, 24 Jul 2023 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690238669;
	bh=73hrsrjw6DK33qytbV2VMU5PllPbT9UMq7YR1HxHFXM=;
	h=From:To:Cc:Subject:Date:From;
	b=dG3LY+W2LVxmrz1IHWxojwaAuMwZ0lzwa0R53hHbmUm248PFojKcnrEtaSE8zz9sb
	 5NOFuY6FPuG3O0fh/UlD6hncuxKZ/BRVr+ZUHq02D2crxEMxVwqC5xPOkfxBKhOyoi
	 6NRiJ+qA+Gk4vSToHvmwb7yNs/gf7SQ3trOSSmFjsletvyjqKz01ETrCmoJSh+2IYO
	 yG2WUu/lRDU2VHK5OVAL5rn7JV2w/gkE9RdpMPN7t3bTW1fPSjZ02js7yBb26VXrhs
	 a7f8tgTCXKjTkraee2PTKFLZ9RJRzW9sI0w49WdUQwF7Fbh9EHv2/1BmKMOWIKUoiE
	 nqk0tKX7ntOlg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/14] mlx5 updates 2023-07-24
Date: Mon, 24 Jul 2023 15:44:12 -0700
Message-ID: <20230724224426.231024-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds misc updates.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit dc644b540a2d2874112706591234be3d3fbf9ef7:

  tcx: Fix splat in ingress_destroy upon tcx_entry_free (2023-07-24 11:42:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-07-24

for you to fetch changes up to 67d648e27188088a28cb7ea67208b9e174af1bf3:

  net/mlx5: Remove pointless devlink_rate checks (2023-07-24 15:34:06 -0700)

----------------------------------------------------------------
mlx5-updates-2023-07-24

1) Replace current thermal implementation with hwmon API.

2) Generalize devcom implementation to be independent of number of ports
   or device's GUID.

3) Save memory on command interface statistics.

4) General code cleanups

----------------------------------------------------------------
Adham Faris (2):
      net/mlx5: Expose port.c/mlx5_query_module_num() function
      net/mlx5: Expose NIC temperature via hardware monitoring kernel API

Jiri Pirko (2):
      net/mlx5: Don't check vport->enabled in port ops
      net/mlx5: Remove pointless devlink_rate checks

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

 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
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
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   7 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  79 ++--
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c    | 428 ++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h    |  24 ++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  12 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   | 448 +++++++++++----------
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |  74 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  35 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c  | 114 ------
 drivers/net/ethernet/mellanox/mlx5/core/thermal.h  |  20 -
 include/linux/mlx5/driver.h                        |  30 +-
 include/linux/mlx5/mlx5_ifc.h                      |  14 +-
 27 files changed, 1039 insertions(+), 658 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.h

