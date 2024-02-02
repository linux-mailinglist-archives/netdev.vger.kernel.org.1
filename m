Return-Path: <netdev+bounces-68676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2115A847956
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C340B290848
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FC126F0A;
	Fri,  2 Feb 2024 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho8hp45t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B663BA
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900940; cv=none; b=OJQL7DViM1uRyvbAQCkyI65tXSd2Ez45Bs/mU7zpZ9iDVwLcTr4C18I8KKMxfO2LaFb4HaoG5p5+W6Ajxg0LrqKbxatBkm1dDSMcmOmszGMmalo8EZKKwMYbdHNYIADSdypeqmxNBKGTKAGC98B1OYLDK5W3oidQkqwxePhLFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900940; c=relaxed/simple;
	bh=taFUclpbUTvzRPc0uY+oUF90+feNngtjXRn73wDsFE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maA/w0Ln046E8V8ux2s0OKnm5VM9nmZvG7x7qrlHAhy3fbgEbyR0fekN9aQF/TzGNh1kquYA51+svMSu16t7+nKG5YDzDe6wTNLrKViaxdFcYILvNqejz5BfxiKSJu3B7NsJdrux7oEXFKgsTQCMO234J4v6EyxUvGQQoSconaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho8hp45t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E998C433C7;
	Fri,  2 Feb 2024 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900939;
	bh=taFUclpbUTvzRPc0uY+oUF90+feNngtjXRn73wDsFE4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ho8hp45ttgOFrGP1hQXSCcIyVkJsdjCT62UtcXu+3ZWAKFo1WFwco4S3LNMTN73WU
	 gHaACFqS5uAjG9PtWHtv3xj5n7ZuLDDyqa2ZRiodXTRa4hMVyloq3aZDjjNkCSgav2
	 ITi+HXn1bx27fHiExyTcNu2VnwBF+f0OnaX6j/Sh3nroA/ik4veGd1llMIOWMC5ZRE
	 mRcSguWEwq+O9avYTP+u4O1/cp6KMlvZpRVThPi2TUgq3ws9LvK0bbjhzQqUEB5RuA
	 rIDY8wxEGXOl//DX2fgDToD1EtWnfaSLNmH3VAP56/6L3BtW8mMS7HdC95HK4W1lbL
	 1JMtGHBP5lB8A==
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
Subject: [pull request][net-next V3 00/15] mlx5 updates 2024-01-26
Date: Fri,  2 Feb 2024 11:08:39 -0800
Message-ID: <20240202190854.1308089-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

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

The following changes since commit d81c0792e640586c8639cf10ac6d0a0e79da6466:

  Merge tag 'batadv-next-pullrequest-20240201' of git://git.open-mesh.org/linux-merge (2024-02-02 12:44:16 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-02-01

for you to fetch changes up to 0a332c1b835952240cfa066b002489f82103f4fe:

  net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations (2024-02-02 11:06:12 -0800)

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
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.c  | 735 +++++++++++++++++----
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.h  |  20 +
 include/linux/mlx5/mlx5_ifc.h                      |   1 +
 include/linux/netdevice.h                          |   2 +-
 include/net/xfrm.h                                 |  14 +-
 net/xfrm/xfrm_proc.c                               |   1 +
 net/xfrm/xfrm_state.c                              |  17 +-
 net/xfrm/xfrm_user.c                               |   2 +-
 23 files changed, 766 insertions(+), 241 deletions(-)

