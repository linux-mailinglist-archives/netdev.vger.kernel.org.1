Return-Path: <netdev+bounces-29864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55620784FD5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F6C281271
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE96AA8;
	Wed, 23 Aug 2023 05:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEE1851
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0802EC433C7;
	Wed, 23 Aug 2023 05:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767424;
	bh=3eJzft9lzIjN98BSZsttZgGpPh0THqN0c9UbCpX+KvY=;
	h=From:To:Cc:Subject:Date:From;
	b=nVjTBRgKmvst85J9HVmSiwU42pFNfLehAVVtSvUadS9sOlL4VYOjjJNetZ+iHJFlS
	 zRMkPzQ59bmaenPE/g7jUQFgvTlBiKXuijNq+Wc2N78c7ntBdHiUf8IbUSoQT2stTN
	 em1HYb5RWhSvAvnvqgFPAVN5J6wsCpK6X4J+9ppr3vqN4lJCoWo+QX02h9aI9P6kkj
	 M9FihIWInRLis/Bu2k3ngY0SiWXu3OIFLBhXfLPMvMrPwjq79wR9lXOsMg23wHkxXU
	 zCFTYMg/ilEMdjgjKyuTMILAo791BCPTk06koMG03jT8scOZqRONnGpPSyFcwXePGi
	 7esza8id9b38w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-08-22
Date: Tue, 22 Aug 2023 22:09:57 -0700
Message-ID: <20230823051012.162483-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides misc updates and cleanups to mlx5.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 6176b8c4a19e150c4176b1ed93174e2f5965c4b5:

  Merge tag 'nf-next-23-08-22' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next (2023-08-22 18:47:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-08-22

for you to fetch changes up to b8c697e177bba0f802232c3f06b7769b1e1fc516:

  net/mlx5e: Support IPsec upper TCP protocol selector (2023-08-22 21:34:18 -0700)

----------------------------------------------------------------
mlx5-updates-2023-08-22

1) Patches #1..#13 From Jiri:

The goal of this patchset is to make the SF code cleaner.

Benefit from previously introduced devlink_port struct containerization
to avoid unnecessary lookups in devlink port ops.

Also, benefit from the devlink locking changes and avoid unnecessary
reference counting.

2) Patches #14,#15:

Add ability to configure proto both UDP and TCP selectors in RX and TX
directions.

----------------------------------------------------------------
Emeel Hakim (1):
      net/mlx5e: Support IPsec upper protocol selector field offload for RX

Jiri Pirko (13):
      net/mlx5: Rework devlink port alloc/free into init/cleanup
      net/mlx5: Push out SF devlink port init and cleanup code to separate helpers
      net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()
      net/mlx5: Allow mlx5_esw_offloads_devlink_port_register() to register SFs
      net/mlx5: Introduce mlx5_eswitch_load/unload_sf_vport() and use it from SF code
      net/mlx5: Remove no longer used mlx5_esw_offloads_sf_vport_enable/disable()
      net/mlx5: Don't register ops for non-PF/VF/SF port and avoid checks in ops
      net/mlx5: Embed struct devlink_port into driver structure
      net/mlx5: Reduce number of vport lookups passing vport pointer instead of index
      net/mlx5: Return -EOPNOTSUPP in mlx5_devlink_port_fn_migratable_set() directly
      net/mlx5: Relax mlx5_devlink_eswitch_get() return value checking
      net/mlx5: Check vhca_resource_manager capability in each op and add extack msg
      net/mlx5: Store vport in struct mlx5_devlink_port and use it in port ops

Leon Romanovsky (1):
      net/mlx5e: Support IPsec upper TCP protocol selector

 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  13 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  45 +++--
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c | 169 ++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 158 ++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  74 ++++++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 203 +++++++--------------
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |  12 +-
 7 files changed, 371 insertions(+), 303 deletions(-)

