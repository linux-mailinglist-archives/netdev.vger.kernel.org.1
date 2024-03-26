Return-Path: <netdev+bounces-82116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88C88C58A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F81F288D1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE113C666;
	Tue, 26 Mar 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roSIlPEY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0E13C3D9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464413; cv=none; b=pmyq1gpq0UhvxT6BoxXy3lANz0jBQhM/ANe26dAxhweh4gZB0BorjVmoZg8n46ZdoPyyQaIZAsxwISMHDrUD0ZfO5wuFitWN2jBzH/X5M2d/bI5xD4nSnbYU9KcXODTb2WSupSTBT7XwBv61u3m/5Oe7Oo/bvNjZ6wJ8tXdQ7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464413; c=relaxed/simple;
	bh=b7vwd8IMpYoG+qgM9oe5DW4h0JPhCss+n9Hojadfseg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S76J5QHFYODK+K74FhfOhTrvj7ZTbwWkc5saI+zMjXzIGJzFFzkkDzfoJejUK3/mDKNi3jycV/XLJQR1DZlL1hWaj++Eno2sMjrYw9ZJKsRIGStPRTGZt5UrL4zctxTzer5tjPSGo2YHNWJ0rLxYx7PMETlVhguyPk8YCLj1u40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roSIlPEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDCFC433F1;
	Tue, 26 Mar 2024 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464413;
	bh=b7vwd8IMpYoG+qgM9oe5DW4h0JPhCss+n9Hojadfseg=;
	h=From:To:Cc:Subject:Date:From;
	b=roSIlPEY4dYjK/JoaWbT2/BiSESWv7zOA7sA6DGqQv2vH1g9xkb9MYcoEc6+cMC3t
	 yjBupitdJ2UMUNHMyaTqKRwnwsT1XG3HAvN25p3sfJDhEUtY7ZxzcoGVyzeroZ6I83
	 djdjjbpCRd69Aw+U2Jg0zbYu0qsHIiqBaCsYzWowBRk2kCOgrRtqzyALY8UdsEaY63
	 DRjkJmKzUiJc41nG3NaWP7iE6RYz4OW5KUA5TWGFPBShfSIAdCfC3zTIMNz5kTN6Fb
	 HLbRlwuTawLP9uEIuTd3JUuH55cCVxwB/Fksc+xkZDgQh0F15d3IfsAh7nLG3cAeaV
	 UabReNImqg01Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net 00/10] mlx5 fixes 2024-03-26
Date: Tue, 26 Mar 2024 07:46:36 -0700
Message-ID: <20240326144646.2078893-1-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
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


The following changes since commit c1fd3a9433a2bf5a1c272384c2150e48d69df1a4:

  Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver' (2024-03-26 15:32:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-03-26

for you to fetch changes up to 59049e8f7610546abee86aea4b539361997acb32:

  net/mlx5e: RSS, Block XOR hash with over 128 channels (2024-03-26 07:45:30 -0700)

----------------------------------------------------------------
mlx5-fixes-2024-03-26

----------------------------------------------------------------
Carolina Jubran (4):
      net/mlx5: RSS, Block changing channels number when RXFH is configured
      net/mlx5e: Fix mlx5e_priv_init() cleanup flow
      net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
      net/mlx5e: RSS, Block XOR hash with over 128 channels

Cosmin Ratiu (2):
      net/mlx5: Properly link new fs rules into the tree
      net/mlx5: Correctly compare pkt reformat ids

Michael Liang (1):
      net/mlx5: offset comp irq index in name by one

Rahul Rameshbabu (1):
      net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit

Shay Drory (2):
      net/mlx5: E-switch, store eswitch pointer before registering devlink_param
      net/mlx5: Register devlink first under devlink lock

 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |  8 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   | 33 +++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |  7 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c  |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 39 ++++++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  2 --
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  7 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  9 ++---
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  4 +++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 17 ++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c     | 37 ++++++++++----------
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  4 ++-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  1 -
 14 files changed, 118 insertions(+), 53 deletions(-)

