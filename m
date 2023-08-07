Return-Path: <netdev+bounces-25152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036577312E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC572281586
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A497917722;
	Mon,  7 Aug 2023 21:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB14432
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D13C433C7;
	Mon,  7 Aug 2023 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443574;
	bh=JnkS8EFwYgogtGdFo6zpdHWOtKj55kJBIHRvFzKKAV0=;
	h=From:To:Cc:Subject:Date:From;
	b=EVTag0d1IqmN/uQLoKncVwG8xAkRymbenkdgjS101RbfowiGXLSxAmqk/u/9NIc54
	 INp9ub0eliIqBNNUY3uz4Z2hnGDTEv7Gp20HYxCxgnLresIy8sZisVpvR9kylrlzYy
	 HpvLamZN/gZUYPTjjJms2jIBI+Fgfz4bS7ESzU2CrDWLZX3S+xRMb45NHMQkkIdRLO
	 GCJxSuYYvcVnMF9/s3MMQ6C9qqzTx5OVdiVUE408el8D6mVPBe9v6HymCu0Q8+IzPX
	 dEqi/iV8FHs4BBTSvkqsl0KHfE5xt6XEGyVfF0uCwK3QmP/JNt4Sa5/Kcs7V360jl8
	 0k04lW7x8d2OA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/11] mlx5 fixes 2023-08-07
Date: Mon,  7 Aug 2023 14:25:56 -0700
Message-ID: <20230807212607.50883-1-saeed@kernel.org>
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


The following changes since commit 52417a95ff2d810dc31a68ae71102e741efea772:

  ionic: Add missing err handling for queue reconfig (2023-08-06 16:44:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-08-07

for you to fetch changes up to 548ee049b19fb9a3d0a4335314d0d1217a521bc5:

  net/mlx5e: Add capability check for vnic counters (2023-08-07 11:48:40 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-08-07

----------------------------------------------------------------
Chris Mi (1):
      net/mlx5e: Unoffload post act rule when handling FIB events

Daniel Jurgens (3):
      net/mlx5: Return correct EC_VF function ID
      net/mlx5: Allow 0 for total host VFs
      net/mlx5: Fix devlink controller number for ECVF

Gal Pressman (1):
      net/mlx5e: Take RTNL lock when needed before calling xdp_set_features()

Jianbo Liu (1):
      net/mlx5e: TC, Fix internal port memory leak

Lama Kayal (1):
      net/mlx5e: Add capability check for vnic counters

Moshe Shemesh (2):
      net/mlx5: Skip clock update work when device is in error state
      net/mlx5: Reload auxiliary devices in pci error handlers

Shay Drory (1):
      net/mlx5: LAG, Check correct bucket when modifying LAG

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong allocation of modify hdr pattern

 .../mellanox/mlx5/core/diag/reporter_vnic.c        | 116 ++++++++++++---------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  11 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  21 ++--
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_ptrn.c |   2 +-
 11 files changed, 106 insertions(+), 66 deletions(-)

