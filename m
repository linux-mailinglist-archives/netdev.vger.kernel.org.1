Return-Path: <netdev+bounces-47445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A317EA535
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD06C280EA0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD424A05;
	Mon, 13 Nov 2023 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqJjOe0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916B250EF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E5C433C8;
	Mon, 13 Nov 2023 21:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909711;
	bh=9ZwL/3rior7KF910z81YX+yJYX2r0jiQGh1cqcQY4UY=;
	h=From:To:Cc:Subject:Date:From;
	b=RqJjOe0Smvv1fGdrHnQJpYv0Dimjf3Y+428mNt66MuZsa18CQGA5fU5jZV3l0InpL
	 y2iu5490ALFg9+BbrHzzJ7ZBvjQXnnPXb4OKaNgSqoDj+3cO5g7sSVZWqTtbAtyThn
	 8PrNlMBJUcRGFhrvoTgZpDoOwhjiqOTrMgSTlCfHjpNDxQzf8KYYULMLijfOu2Hkdy
	 vcTdG7oSBEEofFPVwIMqi/65ta42j/C6HZYi7+kNEsc8Fuk57Tkr6xvFPNlXhjdDR8
	 XowXbBx9xKTyhGnC8/tmeQNVF6AccbIXhjU+NHtxaMSoA27riYwu39/VjJCHNIuYSu
	 Ut40ggFKbsXEg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/17] mlx5 fixes 2023-11-13
Date: Mon, 13 Nov 2023 13:08:09 -0800
Message-ID: <20231113210826.47593-1-saeed@kernel.org>
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


The following changes since commit c0a2a1b0d631fc460d830f52d06211838874d655:

  ppp: limit MRU to 64K (2023-11-13 11:09:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-11-13

for you to fetch changes up to 30dca69fd65acc858b144debcd25e52ffed8db50:

  net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors (2023-11-13 13:07:17 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-11-13

----------------------------------------------------------------
Chris Mi (1):
      net/mlx5e: TC, Don't offload post action rule if not supported

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Dust Li (1):
      net/mlx5e: fix double free of encap_header

Erez Shitrit (1):
      net/mlx5: DR, Allow old devices to use multi destination FTE

Gavin Li (1):
      net/mlx5e: fix double free of encap_header in update funcs

Itamar Gozlan (1):
      Revert "net/mlx5: DR, Supporting inline WQE when possible"

Jianbo Liu (1):
      net/mlx5e: Don't modify the peer sent-to-vport rules for IPSec offload

Maher Sanalla (1):
      net/mlx5: Free used cpus mask when an IRQ is released

Rahul Rameshbabu (7):
      net/mlx5: Decouple PHC .adjtime and .adjphase implementations
      net/mlx5e: Avoid referencing skb after free-ing in drop path of mlx5e_sq_xmit_wqe
      net/mlx5e: Track xmit submission to PTP WQ after populating metadata map
      net/mlx5e: Update doorbell for port timestamping CQ before the software counter
      net/mlx5: Increase size of irq name buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

Vlad Buslov (1):
      net/mlx5e: Fix pedit endianness

 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  20 +++-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 ++
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 +++---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  14 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  85 +++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  25 +++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  42 --------
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   3 +
 .../mellanox/mlx5/core/steering/dr_action.c        |   3 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c | 115 +++------------------
 16 files changed, 159 insertions(+), 221 deletions(-)

