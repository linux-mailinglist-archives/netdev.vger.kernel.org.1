Return-Path: <netdev+bounces-13518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBB73BEC8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB865281CB2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915510788;
	Fri, 23 Jun 2023 19:29:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11F101ED
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E3C433C8;
	Fri, 23 Jun 2023 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548554;
	bh=MQllYB9Hz0JezsDr1ljy7pTPbaRgOkAdFSAu57LHU8g=;
	h=From:To:Cc:Subject:Date:From;
	b=nzYTiNv64KgZ0P9E4nrxm3WjJfTle2CC5WMZ/DNxJp5regj9qzvDtSZXYBF0oZ9Tp
	 ANt7cvSuAEyDzxUK7qNBynIIeYQf2u4sb7DmY4sqvlpygxIVTequfZKh62DI4MiQNh
	 WZ1ERath44Fqk3wuTzWebGr7biKJ6MnjfMC0xpI6447ipWDT4mGxp+9Cnicsrqpkej
	 eZbQZ4Oy1yVEL5k/2AA3KlpMxvJZEQ6f3pvu3yCFK0JSN8UIN8Q625WMPmD2VlYBMK
	 tdkxuBFZ0BR0xHvgu0iBrMZMrqEOVp4ZlZqxJ48Ovlv3be97mcTJBaa9hrR6YjG/Py
	 9civ3+DY7S9og==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next V2 00/15] mlx5 updates 2023-06-21
Date: Fri, 23 Jun 2023 12:28:52 -0700
Message-ID: <20230623192907.39033-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
    - Correct Fixes tag for patch #11

This series provides minor cleanups and bug fixes for net-next branch.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit faaa5fd30344f9a7b3816ae7a6b58ccd5a34998f:

  dt-bindings: net: altr,tse: Fix error in "compatible" conditional schema (2023-06-23 12:49:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-06-21

for you to fetch changes up to 29e4c95faee52a9b7a4f1293cb92cd17a0b5fd91:

  net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type() (2023-06-23 12:27:35 -0700)

----------------------------------------------------------------
mlx5-updates-2023-06-21

mlx5 driver minor cleanup and fixes to net-next

----------------------------------------------------------------
Dan Carpenter (1):
      net/mlx5: Fix error code in mlx5_is_reset_now_capable()

Jiri Pirko (4):
      net/mlx5: Remove redundant MLX5_ESWITCH_MANAGER() check from is_ib_rep_supported()
      net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
      net/mlx5: Remove redundant check from mlx5_esw_query_vport_vhca_id()
      net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()

Lama Kayal (1):
      net/mlx5: Fix reserved at offset in hca_cap register

Roi Dayan (7):
      net/mlx5: Lag, Remove duplicate code checking lag is supported
      net/mlx5e: Use vhca_id for device index in vport rx rules
      net/mlx5e: E-Switch, Add peer fdb miss rules for vport manager or ecpf
      net/mlx5e: E-Switch, Use xarray for devcom paired device index
      net/mlx5e: E-Switch, Pass other_vport flag if vport is not 0
      net/mlx5e: Remove redundant comment
      net/mlx5e: E-Switch, Fix shared fdb error flow

Shay Drory (2):
      net/mlx5: Fix UAF in mlx5_eswitch_cleanup()
      net/mlx5: Fix SFs kernel documentation error

 .../ethernet/mellanox/mlx5/switchdev.rst           | 22 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  6 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  6 +--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 24 +++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 61 ++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 15 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  | 10 +---
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 10 files changed, 84 insertions(+), 68 deletions(-)

