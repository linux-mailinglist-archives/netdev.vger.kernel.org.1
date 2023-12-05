Return-Path: <netdev+bounces-54132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A18060F4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA19281A7B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733226E2A2;
	Tue,  5 Dec 2023 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU69e11v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561846E5AB
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A994CC433C8;
	Tue,  5 Dec 2023 21:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812736;
	bh=rtvTLevKqEmWj7/C30ETrBHk3Or3msABwXhhkpTIka0=;
	h=From:To:Cc:Subject:Date:From;
	b=HU69e11vNlndphDe0k3719XnNa3mAIWprZL1hDLXibRgq4Tlyxd0rv1oENCuut2sc
	 96UxkjbOziXaBBVm9SMQt3iPdP/qInZFfDXlCuR+diouwF7TU0c21KRiwUtqMAy/PI
	 5wQZ2WRnNvIg0fD0EsYsbNwfMItCO3Qfo1Y61ppe1hUnO2R9hepnoK5qonOkDpGmjC
	 0P+/qdACS8MkbDb0ja6uzHyG0HR3aTwmm9W8AXXq2/3BSeL77rz7rZS2zszJ3scxLL
	 gJzh8HDDG9eHSGCnazxiixkxWOrFhcr+qkSuq7jWXQxjlx74/7iODEMZLwYG/DJh1G
	 eic6jBYY9AuTA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net V3 00/15] mlx5 fixes 2023-12-05
Date: Tue,  5 Dec 2023 13:45:19 -0800
Message-ID: <20231205214534.77771-1-saeed@kernel.org>
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

V2->V3:
  - Drop commit #8 as requested by Jianbo.
  - Added two commits from Rahul to fix snprintf return val

V1->V2:
  - Drop commit #9 ("net/mlx5e: Forbid devlink reload if IPSec rules are
    offloaded"), we are working on a better fix

Please pull and let me know if there is any problem.

Thanks,
Saeed.



The following changes since commit 3c91c909f13f0c32b0d54d75c3f798479b1a84f5:

  octeontx2-af: fix a use-after-free in rvu_npa_register_reporters (2023-12-05 15:39:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-12-05

for you to fetch changes up to 1b6c74c73e3ba05dbba2dedf6703f025563231d0:

  net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors (2023-12-05 13:43:01 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-12-05

----------------------------------------------------------------
Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Jianbo Liu (1):
      net/mlx5e: Reduce eswitch mode_lock protection context

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

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  56 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 441 ++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 160 +-------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  35 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   2 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  54 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  29 ++
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 17 files changed, 587 insertions(+), 311 deletions(-)

