Return-Path: <netdev+bounces-53773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1C8049D6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40BF281592
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A355D53C;
	Tue,  5 Dec 2023 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee/iwGg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA22DDA1
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6708DC433C8;
	Tue,  5 Dec 2023 06:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756818;
	bh=21glkUHZDELt2/TSWlkJfd+SjEtT7KDOY0aDbFQSM6o=;
	h=From:To:Cc:Subject:Date:From;
	b=Ee/iwGg9xKzX5mNtJYBHwSD6uF6aPgry+1dY7hWp/n7FReYGLBS9xONm14Ev/xXw3
	 tFQpjePFA+0KKH6+vGSjdnvJyucA1f61xy65pj6rIfsE4YggWXvNDqKhfZr+gRXxbv
	 uPTUBeuArdmrBIKGr/nSJobjqz/w6dztS/g9NTyFqEZ9VSc8tSY46MGrd5K9pbVNnl
	 v7IvnAemooGRByUT+HeLO1DIHwvwd/IUc45P0slf+Z2amBAFgKbsxMse3/DuVXisp8
	 CqS/s5VsT+LQbudeG/PhlFuEu4E9pDY+txIeNARUXxHtyNfwaM3Ys454U9Q2x4zIjr
	 3i98vYd2f3ZYQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net V2 00/14] mlx5 fixes 2023-12-04
Date: Mon,  4 Dec 2023 22:13:13 -0800
Message-ID: <20231205061327.44638-1-saeed@kernel.org>
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

V1->V2:
  - Drop commit #9 ("net/mlx5e: Forbid devlink reload if IPSec rules are
    offloaded"), we are working on a better fix

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 37e4b8df27bc68340f3fc80dbb27e3549c7f881c:

  net: stmmac: fix FPE events losing (2023-12-04 18:35:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-12-04

for you to fetch changes up to ca4ef28d0ad831d2521fa2b16952f37fd9324ca3:

  net/mlx5: Fix a NULL vs IS_ERR() check (2023-12-04 22:11:54 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-12-04

----------------------------------------------------------------
Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Jianbo Liu (2):
      net/mlx5e: Reduce eswitch mode_lock protection context
      net/mlx5e: Check the number of elements before walk TC rhashtable

Leon Romanovsky (4):
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Remove exposure of IPsec RX flow steering struct
      net/mlx5e: Tidy up IPsec NAT-T SA discovery

Moshe Shemesh (2):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
      net/mlx5: Nack sync reset request when HotPlug is enabled

Patrisious Haddad (2):
      net/mlx5e: Unify esw and normal IPsec status table creation/destruction
      net/mlx5e: Add IPsec and ASO syndromes check in HW

 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  56 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 441 ++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 162 +-------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  35 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   2 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  54 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  29 ++
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 16 files changed, 586 insertions(+), 310 deletions(-)

