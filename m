Return-Path: <netdev+bounces-66297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C783E593
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D1B1C23DE1
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0938DC1;
	Fri, 26 Jan 2024 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdYbmjTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36633CD9
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308606; cv=none; b=LkVbfHSai2Qm7ura6RGkDBOBTdSqlkvxJJ9msjdJJE2nvNIBrAUv4De3VgKq7gxXpq7j65fjBf9bBcbpeVEK5sNBbQt4yKHkLGYkQE412jFDN130BK48yuW3LiTI7Q/2vzBlV7+YoCRuOnC3xRncFJgYBeU5n44BENypdmejjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308606; c=relaxed/simple;
	bh=eqaG9oOBzOClHzWKAK9LeZkvVRFNRqF+6aG6K05PcCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtHjypgh+j7+PA99jYXSOtIBJvEl0gxDgFEOy1ICDlgNfeLj2LyA+ozoSj5SD7mLeDvn/oRbYt4nGVg6wpRJxhGQ4JVDMeAduMqvxbz4dWUSZPBikkORWWaLuInWLIsdbAkdwDGTyBjQmf6CV7NmqytbiHIAl2N0GdinE/jU1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdYbmjTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9722CC433F1;
	Fri, 26 Jan 2024 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308605;
	bh=eqaG9oOBzOClHzWKAK9LeZkvVRFNRqF+6aG6K05PcCI=;
	h=From:To:Cc:Subject:Date:From;
	b=WdYbmjTvsN6ry7BY2V5+rzzfTYPXKaMuDMABQ4ObsJiNRvPML4jRj8GvY7ELpNrmu
	 YMqTb8zD3F3Q0DmYZDBILXKDxnLZymcOaP2OG4ewulc7CD8UUVEOMolNlPOk7cjDFq
	 Y21MupeOT42F+QWT1aiqMiVeET8xPsrw9Jm9AmNdoVniTpqwzSa0PqB0oWTSglop7W
	 elpO7SISBZEnkG+VRUXJTqsencz4vqcetarI7zMR8g61HPyiItgE02xNx0vIo6cdwy
	 ZV+si9g2ysnlTcQSs5qsNROlfaB+x6wCEYAJPrsLM4MerTnoOgXyhHBOubkptJXrSN
	 SjWV65mbSf1TQ==
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
Subject: [pull request][net-next 00/15] mlx5 updates 2024-01-26
Date: Fri, 26 Jan 2024 14:36:01 -0800
Message-ID: <20240126223616.98696-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides misc updates to mlx5 and xfrm, 
the two xfrm patches are already acked by Steffen Klassert in the
previous release cycle.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 5f76499fb541c3e8ae401414bfdf702940c8c531:

  tsnep: Add link down PHY loopback support (2024-01-25 17:33:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-01-26

for you to fetch changes up to 4886ff94bf4f34611111246b989e26a4447aa063:

  net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations (2024-01-26 14:29:55 -0800)

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

