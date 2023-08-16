Return-Path: <netdev+bounces-28208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23E77EAE5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE22281C33
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2F17AA2;
	Wed, 16 Aug 2023 20:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC317729
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F07C433C8;
	Wed, 16 Aug 2023 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692218474;
	bh=RPmVwsWqJweI89XQGrUhcOSnhBGMBcv+aHzDZTWy+ls=;
	h=From:To:Cc:Subject:Date:From;
	b=JNv8HuilN+YZZJlNwvkP/IP//4HHYMxK6gU1oTm1rubGhs0+d0jdpOzfPKLOrDURM
	 xmnDo0YxjFMkyPjTUM2ZfE7RR45YHvnimsZU2oF+1qUpgbObs7Cu8McVbJEIm8ZU7M
	 qwiAUsHNeywu8dqxvGXRMbYQ4yXznxrP5h9A4sl0kV4IOKdRW6jA5VZP/zYD8bg43h
	 JDPBWnb28oK3x6IZQQ+ZT54FF7+TBoJPtV8pXFCf4ikishnYu4Niryf+5oidWd1PQs
	 ijP1HI/bAcf3fqfhaLh5gXBC4i75EGqbuSKxEzLGm/FGlG9AX8mdAfJk7U/kROzMxk
	 dv4t9bFdppEBA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 0/2] mlx5 fixes 2023-08-16
Date: Wed, 16 Aug 2023 13:41:06 -0700
Message-ID: <20230816204108.53819-1-saeed@kernel.org>
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


The following changes since commit de4c5efeeca7172306bdc2e3efc0c6c3953bb338:

  Merge tag 'nf-23-08-16' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2023-08-16 11:11:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-08-16

for you to fetch changes up to 0fd23db0cc74cf6d28d26ce5e7802e982608d830:

  net/mlx5: Fix mlx5_cmd_update_root_ft() error flow (2023-08-16 13:39:28 -0700)

----------------------------------------------------------------
mlx5-fixes-2023-08-16

----------------------------------------------------------------
Dragos Tatulea (1):
      net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT

Shay Drory (1):
      net/mlx5: Fix mlx5_cmd_update_root_ft() error flow

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h  |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  8 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

