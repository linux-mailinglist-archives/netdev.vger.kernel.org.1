Return-Path: <netdev+bounces-40466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594737C7760
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDFE282ABD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E13B7B0;
	Thu, 12 Oct 2023 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLo2KOwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3B28E16
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7A8C433C9;
	Thu, 12 Oct 2023 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140389;
	bh=4cTzqrRqd2tfOjwKw7/ul5dhVW6/QY2IzPJ26/r1sls=;
	h=From:To:Cc:Subject:Date:From;
	b=HLo2KOwrbfVqxvhmi1BIc+wmX1XbSYD8xuj0iXU7Rwqn2b83PCDthkkXfx7tipzuM
	 k/z0Y95b3NEohpBqccpxJPoMedZGtrD77vsfiDU094ygThFV/Q01SQuYnFWDLG98pr
	 Y9w9JIntDLwwbWdmTJ6cRgb/hyXVi9He/DyXcaMNY+fkDwZb68T4Q1TBVw0Rn30SKU
	 19FJKx1/ap7bF3dkZbwoixO9ci6T1xxBEn3zla2tK+tOsmHYvHX6UDphpa6L841pZL
	 WSdcRB3Y8vilpKGCXZxxhV7lK8ItHhbwO3AcNYDEHAVDGRPU6guaUDQ8FWikJHuXxw
	 mWwUjO3XiScmA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/10] mlx5 fixes 2023-10-12
Date: Thu, 12 Oct 2023 12:51:17 -0700
Message-ID: <20231012195127.129585-1-saeed@kernel.org>
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


The following changes since commit b91e8403373cab79375a65f5cf3495e2cd0bbdfa:

  Merge branch 'rswitch-fix-issues-on-specific-conditions' (2023-10-12 11:22:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-10-12

for you to fetch changes up to 80f1241484dd1b1d4eab1a0211d52ec2bd83e2f1:

  net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command (2023-10-12 11:10:35 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-10-12

----------------------------------------------------------------
Amir Tzin (1):
      net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command

Dragos Tatulea (3):
      net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq
      net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq
      net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown

Jianbo Liu (1):
      net/mlx5e: Don't offload internal port if filter device is out device

Lama Kayal (1):
      net/mlx5e: Take RTNL lock before triggering netdev notifiers

Maher Sanalla (1):
      net/mlx5: Handle fw tracer change ownership event based on MTRC

Shay Drory (2):
      net/mlx5: Perform DMA operations in the right locations
      net/mlx5: E-switch, register event handler before arming the event

Vlad Buslov (1):
      net/mlx5: Bridge, fix peer entry ageing in LAG mode

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 64 ++++++++++------------
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    | 11 ++++
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  8 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 10 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 35 +++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 11 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   | 25 ++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.h   |  3 +
 .../ethernet/mellanox/mlx5/core/esw/bridge_priv.h  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 17 +++---
 13 files changed, 130 insertions(+), 65 deletions(-)

