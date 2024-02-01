Return-Path: <netdev+bounces-67846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DFB8451F3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8341F25FD4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91455158D75;
	Thu,  1 Feb 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwW71SAY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628031586EC
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772730; cv=none; b=V7qgEREDakaX+Vp3rGXCAcfuVDAQYYtmtFtW+MgpzjAJ6Q4XXB2ABWYIfeZskbGO/d8KiWS4JXlgXvhs59XAfvGj7pic6jG/JTlSU3ggudpLqVOmriLWJ9Er585fzz2cy9hOmOb0WVzyUsXWPmos4YBn3IBWJU/xTDfrhkHgyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772730; c=relaxed/simple;
	bh=PGVjMBiqAlBk2bCHv2UWG4LFSmBzXpqPGGnGzqaEGFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWsQoyAdoKWynmd2XHoIGwhDXQ1pRhBoDpOmYEJV2PPPgAgXj9Qi5nyb9T9vSXxWD4fiQ4f4EqsNMfB/ygJ9ynbFaisd5kHFxDWrvXNxpmshKeJ/Kq2epzQq4S7vhZdJMoxOypIP07wWDvyfLKp0Pv4nfbL4PWBokRdvdavU5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwW71SAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C979C433C7;
	Thu,  1 Feb 2024 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772729;
	bh=PGVjMBiqAlBk2bCHv2UWG4LFSmBzXpqPGGnGzqaEGFM=;
	h=From:To:Cc:Subject:Date:From;
	b=JwW71SAYazrM4JoMdAA7rZPN81amQ6YCZbzMeS8PbqbhNFaP93oTTW2MyAOtMa3rc
	 qGNmqJtZ6jFLWm5QFCvCESlC9A2NGp6jAKKNoH4dr8ANOyWQ/ZVINVHg2RZ/fZrYAZ
	 pjKWLzO64/fLiZR2xgwGLWqvcI8ILCgtpCu3Zfes2nxnY8u8yDni4fgw7iweq54rg1
	 Xc21DXmerRMQR0ZKkutGrax7IcDNKunuoRGlRbfZLS1ZvLx7TZKJsHpFxPSpUvCxvb
	 MnhuGb8zi2HSHNt+pWMBwAov5az3EJ6KEw7cP2lrBeoKJ+HXIAFaskQgdm2OcrjXQ5
	 G2QptC4DRaveQ==
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
Subject: [pull request][net-next V2 00/15] mlx5 updates 2024-01-26
Date: Wed, 31 Jan 2024 23:31:43 -0800
Message-ID: <20240201073158.22103-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
 - Fix large stack buffer usage in patch #13

This series provides misc updates to mlx5 and xfrm,
the two xfrm patches are already acked by Steffen Klassert in the
previous release cycle.

For more information please see tag log below.
Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 1701940b1a02addc8fe445538442112e84270b02:

  Merge branch 'tools-net-ynl-add-features-for-tc-family' (2024-01-31 21:19:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-01-26

for you to fetch changes up to 62a2a0c4633c2e50da40fd1795fe28692b3a6444:

  net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations (2024-01-31 23:30:22 -0800)

----------------------------------------------------------------
mlx5-updates-2024-01-26

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
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.c  | 726 +++++++++++++++++----
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.h  |  20 +
 include/linux/mlx5/mlx5_ifc.h                      |   1 +
 include/linux/netdevice.h                          |   2 +-
 include/net/xfrm.h                                 |  14 +-
 net/xfrm/xfrm_proc.c                               |   1 +
 net/xfrm/xfrm_state.c                              |  17 +-
 net/xfrm/xfrm_user.c                               |   2 +-
 23 files changed, 761 insertions(+), 237 deletions(-)

