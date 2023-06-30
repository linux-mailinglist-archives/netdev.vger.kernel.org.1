Return-Path: <netdev+bounces-14857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C47441F2
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6301C20C3A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B632F174E6;
	Fri, 30 Jun 2023 18:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470C174DE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F56C433C0;
	Fri, 30 Jun 2023 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148946;
	bh=BjVsPuT1OwHsloGgJIwGlJP506AOb5q1KGhWNUEl1fs=;
	h=From:To:Cc:Subject:Date:From;
	b=rqtySgfH6vOO4KLY5d+9EC/hwte11GQbQlz07V9sGiEQoL2fsPaykpNed7CvDUg2l
	 IiqGwRsDBvOF96cPzeCxVtQN7LUt99s1sNufbKqvQA7wKPPODu6haQtYG4/9PUUAVW
	 GIRc+ldIS7eyqi2hqzNsQIKyoRS2HRw8bgPbgzVWh6i6uf8OBePf6gpUG03zUFtlcS
	 uLmiNTLtwHPDaIsqolEv7Y3aXrvDdkavM629Xw6RWNfDGDae/LmpuU5QvmlABUsRVB
	 ls8tXQrneBTJbZp90+a7TEoAacdHWjHDzFWBf/OJAv40Nqa1bw29YCu5F/t668aob6
	 FycaB/0pesIlQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 0/9] mlx5 fixes 2023-06-30
Date: Fri, 30 Jun 2023 11:15:35 -0700
Message-ID: <20230630181544.82958-1-saeed@kernel.org>
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


The following changes since commit 08fc75735fda3be97194bfbf3c899c87abb3d0fe:

  mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init (2023-06-29 19:10:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-06-30

for you to fetch changes up to 17aeb926904c07ca4f97da51e5d89d3b44b559ed:

  net/mlx5e: RX, Fix page_pool page fragment tracking for XDP (2023-06-30 11:14:19 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-06-30

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

