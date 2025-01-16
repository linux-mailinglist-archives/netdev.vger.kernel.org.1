Return-Path: <netdev+bounces-159061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A4A14442
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE553A88DE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABCE22DF80;
	Thu, 16 Jan 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK8DpGxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A651DAC9C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064550; cv=none; b=dPHNWSrMi3yTOfhlObvDp5qX9rV7LabOZryjtBGXaaQ+UU+5QcrgYs1LQYXPb9P9bn/IfimRWzwKiit5+H/ntZyPldZhA/N8HgRqT1EnyaQJ7SNK4eRVScAR1AZaTwXev8l0xaXYu6RnEfKQeSC2k2a5aO+CCkOphVGosU43EpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064550; c=relaxed/simple;
	bh=JlJxSvYlenP2iLoIPzDE2Ol7Pd6RmANMJ1BdSHnLjFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q20y/FzXtYxW8vV7JUHBJ0IvKhlnXoJzUGyimuYfAqTguPLf0tibKPrta0zktLMstNR239SMfot7KeCY1nSxKTk5rC9NkPIj8h/yV0T29QJP6OeRUsTx1a4zMoFMcUrzPcaCB1BoAxS8dxGMML371h59/uQet2fP9HeAlWnjui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK8DpGxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207F9C4CED6;
	Thu, 16 Jan 2025 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064550;
	bh=JlJxSvYlenP2iLoIPzDE2Ol7Pd6RmANMJ1BdSHnLjFg=;
	h=From:To:Cc:Subject:Date:From;
	b=eK8DpGxSZ/qysAyKR++XbcdxEaXVxGZKzfSovtzxBksc31WXbowLarp8YyTicIAMt
	 +fXF2+1s9gYzjACcI6Or8djBhDL5XjC8TYV3zix/ZmWfuVCabbOzmht6j7LYstYYXR
	 +PmyQ4E/tcuzFKI7iX/2N/6DmQYS61obPIgUbVRwOzK344pYWOubwVSdvfDx7ZyWzh
	 3swUcBw5OegWelKqxRVwZ4BeXX8sc2oyL9ejjMDbDKSGGPOaWqTHpUN8Y42z7OanfG
	 Wh6Dkq8QliCRfYLf8wcaXmrFe6m9o+BNqrSrQ3tc6LVxMRGZWEtwVCmB7G3y77ZxGr
	 x87t5tWJPQx5w==
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
Subject: [pull request][net-next 00/11] mlx5 updates 2025-01-16
Date: Thu, 16 Jan 2025 13:55:18 -0800
Message-ID: <20250116215530.158886-1-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds support for devmem TCP with mlx5.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 2ee738e90e80850582cbe10f34c6447965c1d87b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-16 10:34:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2025-01-16

for you to fetch changes up to 45fc1c1ce6f92b7dd1cdd5a46072d41d36a8a816:

  net/mlx5e: Support ethtool tcp-data-split settings (2025-01-16 13:52:55 -0800)

----------------------------------------------------------------
mlx5-updates-2025-01-16

devmem TCP with mlx5.

Add support for netmem, mgmt queue API and tcp-data-split.
 - Minor refactoring
 - Separate page pool for headers
 - Use netmem struct as the page frag container in mlx5
 - Support UNREADABLE netmem for special page pools
 - Implement queue management API
 - Support ethtool tcp-data-split settings

Tested with tools/testing/selftests/drivers/net/hw/ncdevmem.c

----------------------------------------------------------------
Saeed Mahameed (11):
      net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
      net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
      net/mlx5e: SHAMPO: Remove redundant params
      net/mlx5e: SHAMPO: Improve hw gro capability checking
      net/mlx5e: SHAMPO: Separate pool for headers
      net/mlx5e: SHAMPO: Headers page pool stats
      net/mlx5e: Convert over to netmem
      net/mlx5e: Handle iov backed netmems
      net/mlx5e: Add support for UNREADABLE netmem page pools
      net/mlx5e: Implement queue mgmt ops and single channel swap
      net/mlx5e: Support ethtool tcp-data-split settings

 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  49 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 279 +++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 112 +++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  53 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  24 ++
 net/Kconfig                                        |   2 +-
 8 files changed, 391 insertions(+), 142 deletions(-)

