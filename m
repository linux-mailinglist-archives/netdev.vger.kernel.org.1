Return-Path: <netdev+bounces-65357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F383A3E9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BB428A8A0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C41754D;
	Wed, 24 Jan 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7gALZd3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86317584
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084341; cv=none; b=l7AG+g0MzXDLbhWRyTbZQNxNDxBkr5FHZiOaaTA7q+bZsbEjMIV9cQT1YozEn6F7e1smMXh/A0/oHcy1AWe6uTEdcrxjux7jq9N3cq6Wro9qK3H8cRkeRNr4a085PPiYgZ4OnVhR+phkbqreQn5337S0Bc31yqvE2kHYTeCSIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084341; c=relaxed/simple;
	bh=odll+d287J3WOa68aMhoy1KT6LkUpOfpGr+yAHiktYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7u7t1STHFkvC7zyIZfRhXSj7dsghh2mSBSIOiK7M3LBL3U4xuSEcXKyrTi77si5cMqCurOi1C0q/VXrzteW+RneWjX5NufrEH9xQhCMHAP9QL3R8neOVjjnP2bKZwYJFlU4rK1HuA37Y+KvFP7FH8z+qmTervYD3/aUrIVaJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7gALZd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BCDC433F1;
	Wed, 24 Jan 2024 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084341;
	bh=odll+d287J3WOa68aMhoy1KT6LkUpOfpGr+yAHiktYM=;
	h=From:To:Cc:Subject:Date:From;
	b=F7gALZd3ZHp0WAra6Sn0N5Ny/BtUl53zCB1YuBOrfDVNno84+TCziN07UUHNHpv+d
	 KxlVr6QYJekL5+ONHjBSwI3mF6EGRqlR8xSLaDxTNF4LABqCkWCrNna1STDXBE/E4J
	 joedRyE8tTcbfO3JRY12hLabEeJsz+wjtYW9lHH/bF9yZIrDAy+3BOqciqBu/k/hgo
	 SmM/iAHA45GI8O8mikhaUiMlacL1S5NcLggaLLl1A1JB6NnLJ2S3wJ+IJm2ogpX+vn
	 hNM8gx+kvlxcg8OUCkPun2qdAgga/6I3ckPnFNHH2XRK4f8K0ZmzqVMsZlg/vcXCmk
	 Y2+vbiq+DeIlA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/14] mlx5 fixes 2024-01-24
Date: Wed, 24 Jan 2024 00:18:41 -0800
Message-ID: <20240124081855.115410-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
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


The following changes since commit 32f2a0afa95fae0d1ceec2ff06e0e816939964b8:

  net/sched: flower: Fix chain template offload (2024-01-24 01:33:59 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-01-24

for you to fetch changes up to aef855df7e1bbd5aa4484851561211500b22707e:

  net/mlx5e: fix a potential double-free in fs_any_create_groups (2024-01-24 00:15:38 -0800)

----------------------------------------------------------------
mlx5-fixes-2024-01-24

----------------------------------------------------------------
Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_any_create_groups

Leon Romanovsky (2):
      net/mlx5e: Allow software parsing when IPsec crypto is enabled
      net/mlx5e: Ignore IPsec replay window values on sender side

Moshe Shemesh (1):
      net/mlx5: Bridge, fix multicast packets sent to uplink

Rahul Rameshbabu (2):
      net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context
      net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Saeed Mahameed (1):
      net/mlx5e: Use the correct lag ports number when creating TISes

Tariq Toukan (2):
      net/mlx5: Fix query of sd_group field
      net/mlx5e: Fix inconsistent hairpin RQT sizes

Vlad Buslov (1):
      net/mlx5e: Fix peer flow lists handling

Yevgeny Kliteynik (2):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yishai Hadas (1):
      net/mlx5: Fix a WARN upon a callback command failure

Zhipeng Lu (1):
      net/mlx5e: fix a double-free in arfs_create_groups

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  5 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  | 26 +++++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_common.c    | 21 ++++++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +++--
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |  2 +-
 .../mellanox/mlx5/core/steering/dr_action.c        | 17 +++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    | 21 +++++++++++++++++
 include/linux/mlx5/driver.h                        |  1 +
 include/linux/mlx5/fs.h                            |  1 +
 include/linux/mlx5/mlx5_ifc.h                      | 12 ++++++----
 include/linux/mlx5/vport.h                         |  1 +
 20 files changed, 99 insertions(+), 41 deletions(-)

