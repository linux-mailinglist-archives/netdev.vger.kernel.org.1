Return-Path: <netdev+bounces-28226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27A77EB2D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C40B1C2026E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5A1802D;
	Wed, 16 Aug 2023 21:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC015AC3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50933C433C7;
	Wed, 16 Aug 2023 21:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219656;
	bh=KCJqTBYLW3C3DXjuLZpaFMyx5hoGDFCcWYCbme/RaKo=;
	h=From:To:Cc:Subject:Date:From;
	b=TGzDj6IbBOsCnF70ygtaQJvHLVe3R3cP3rB6l1PbLZuxOiDztZpXyqp8Dc5IAoNIc
	 ZloIxs6KUFXgPIvLCHAkC/k6HROrGRBf0q+7mZntko4x1v6WV0zA5XEQIxKUdo1UYX
	 QBiesOU9SS56R0oK7doZFIteQoSCLJasJcXNYI8jEQdj1dxeSsa8xxa/mkJcaloFFw
	 WMKEoHENTaGlse0ErlYtV9hW01D+VS1J0CVCHtY1RiVyqkfL5Zgl4sdR5h+OcgKkj5
	 qdNrdGb5u2R1m/IgPddPxMPP+dZ7V9oHBXUaPiQ1JNRdY1TnuRHNmc5RN/Pk+Q9HzB
	 GE4tpCynLboHg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-08-16
Date: Wed, 16 Aug 2023 14:00:34 -0700
Message-ID: <20230816210049.54733-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides misc updates to mlx5 driver.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 950fe35831af0c1f9d87d4105843c3b7f1fbf09b:

  Merge branch 'ipv6-expired-routes' (2023-08-16 12:26:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-08-16

for you to fetch changes up to f749b6035a760d51a1d45ef053702d2d3065df3f:

  net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event() (2023-08-16 13:22:34 -0700)

----------------------------------------------------------------
mlx5-updates-2023-08-16

1) aRFS ethtool stats
Improve aRFS observability by adding new set of counters. Each Rx
ring will have this set of counters listed below.
These counters are exposed through ethtool -S.

1.1) arfs_add: number of times a new rule has been created.
1.2) arfs_request_in: number of times a rule  was requested to move from
   its current Rx ring to a new Rx ring (incremented on the destination
   Rx ring).
1.3) arfs_request_out: number of times a rule  was requested to move out
   from its current Rx ring (incremented on source/current Rx ring).
1.4) arfs_expired: number of times a rule has been expired by the
   kernel and removed from HW.
1.5) arfs_err: number of times a rule creation or modification has
   failed.

2) Supporting inline WQE when possible in SW steering

3) Misc cleanups and fixups to net-next branch

----------------------------------------------------------------
Adham Faris (3):
      net/mlx5e: aRFS, Prevent repeated kernel rule migrations requests
      net/mlx5e: aRFS, Warn if aRFS table does not exist for aRFS rule
      net/mlx5e: aRFS, Introduce ethtool stats

Colin Ian King (1):
      net/mlx5e: Fix spelling mistake "Faided" -> "Failed"

Gal Pressman (1):
      net/mlx5: Remove health syndrome enum duplication

Ilpo Järvinen (1):
      net/mlx5: Convert PCI error values to generic errnos

Itamar Gozlan (1):
      net/mlx5: DR, Supporting inline WQE when possible

Jiri Pirko (3):
      net/mlx5: Call mlx5_esw_offloads_rep_load/unload() for uplink port directly
      net/mlx5: Remove VPORT_UPLINK handling from devlink_port.c
      net/mlx5: Rename devlink port ops struct for PFs/VFs

Li Zetao (1):
      net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event()

Rahul Rameshbabu (1):
      net/mlx5: Update dead links in Kconfig documentation

Saeed Mahameed (1):
      net/mlx5: IRQ, consolidate irq and affinity mask allocation

Yevgeny Kliteynik (2):
      net/mlx5: DR, Fix code indentation
      net/mlx5: DR, Remove unneeded local variable

 .../ethernet/mellanox/mlx5/counters.rst            |  23 ++++-
 .../ethernet/mellanox/mlx5/kconfig.rst             |  14 +--
 Documentation/networking/xfrm_device.rst           |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  21 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  22 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  13 ++-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  16 +--
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |   2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  20 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  12 +--
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  36 ++-----
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  14 ++-
 .../mellanox/mlx5/core/steering/dr_action.c        |   1 -
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c | 115 ++++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   2 +-
 16 files changed, 214 insertions(+), 101 deletions(-)

