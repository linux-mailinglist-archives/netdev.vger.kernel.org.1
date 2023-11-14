Return-Path: <netdev+bounces-47839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928607EB90C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3321AB20A50
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB43307B;
	Tue, 14 Nov 2023 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMR2nM87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD933070
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFE7C433C7;
	Tue, 14 Nov 2023 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999137;
	bh=QMJdWMqLHPy8yIc5MmLbKVaoClw9SzxYCU0Fx9nsJ8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=GMR2nM87L2JFXpGDtLzvNhNMf+lnpWcN9MF6xfpXkWo7FDkuB76Kmd4hGVYrR1a2W
	 E4myGPYF0xHMKc46DnhkNrduGlmgMIr0+F36fd7HW799uc0StPQ8ZfbsyrwiTaxzgM
	 GwOK99Jj4o7VF+LI+lZ+ec/Y9LYoaxkK8IQOHzd4BWFwe53NNcBWjpN3tUBtCpeaVe
	 ZtB79K51BYDQowqDEmEuXF9jIx162qeJY8nNmeN+ByPIO2YlZKCiMRlITYFVIUVt1m
	 95D3gkIJgZXGa1Hida3mW+nitk5FXesjDlD458EI+loKVZq/SnHnY26SNxnEJSDiKh
	 +nooh1EBt6lVA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net V2 00/15] mlx5 fixes 2023-11-13
Date: Tue, 14 Nov 2023 13:58:31 -0800
Message-ID: <20231114215846.5902-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

V1->v2:
 - Toss two patches to comply with max of 15 patches rule.

This series provides bug fixes to mlx5 driver.
Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 4b7b492615cf3017190f55444f7016812b66611d:

  af_unix: fix use-after-free in unix_stream_read_actor() (2023-11-14 10:51:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-11-14

for you to fetch changes up to 67e715ed3c91d6704aa0e26664f3f01abaad699f:

  net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors (2023-11-14 13:56:18 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-11-14

----------------------------------------------------------------
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
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 +++---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  60 ++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  25 +++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  42 --------
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   3 +
 .../mellanox/mlx5/core/steering/dr_action.c        |   3 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c | 115 +++------------------
 15 files changed, 131 insertions(+), 216 deletions(-)

