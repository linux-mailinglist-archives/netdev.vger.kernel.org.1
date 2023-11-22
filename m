Return-Path: <netdev+bounces-49869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CD7F3B6F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6E282ADB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55C15C4;
	Wed, 22 Nov 2023 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rncI6s5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECB5666
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D344C433C8;
	Wed, 22 Nov 2023 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617686;
	bh=BUjBqXf9xx/Vd96R1BJtTAhQIV6Co8eBUZb5KZsdnJg=;
	h=From:To:Cc:Subject:Date:From;
	b=rncI6s5c8m6DAmo8IfAE2b/6dQTAVlh+W/Bbnbb4v/S1psPYQlq8AKBPwMu1GBqyH
	 17jS/RlnGNXMT0OldwzDy8GqyLcyjwmkLNdN/noBVKJYQc6C6JywGZ+avtEi9QCfas
	 cLjg78FG41HSLChfUJKQ9YpAqIHdznNov2qYwz3irgDRfGPj1km/f+gi3ca/XI59Wg
	 AsNT163d2R/6SUfoz7/Ojf9XVcx3PvHQ+lFyNWwsMA35aEFA33LQ8b8HC6zUKQ/bsk
	 XwC5vPlDAKn/e2qL52Wv2mUAb+LLn6nL+4n0uPTlLjSxY6DDEhnHvIjU0w9r36H6iJ
	 0Jq+0SIxfEhNw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net 00/15] mlx5 fixes 2023-11-21
Date: Tue, 21 Nov 2023 17:47:49 -0800
Message-ID: <20231122014804.27716-1-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
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


The following changes since commit b6fe6f03716da246b453369f98a553d4ab21447c:

  dpll: Fix potential msg memleak when genlmsg_put_reply failed (2023-11-21 17:41:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2023-11-21

for you to fetch changes up to e54ef0df31857a7961037680b8224392d0a867af:

  net/mlx5: Fix a NULL vs IS_ERR() check (2023-11-21 17:45:24 -0800)

----------------------------------------------------------------
mlx5-fixes-2023-11-21

----------------------------------------------------------------
Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Jianbo Liu (3):
      net/mlx5e: Reduce eswitch mode_lock protection context
      net/mlx5e: Check the number of elements before walk TC rhashtable
      net/mlx5e: Forbid devlink reload if IPSec rules are offloaded

Leon Romanovsky (4):
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Remove exposure of IPsec RX flow steering struct
      net/mlx5e: Tidy up IPsec NAT-T SA discovery

Moshe Shemesh (2):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
      net/mlx5: Nack sync reset request when HotPlug is enabled

Patrisious Haddad (2):
      net/mlx5e: Unify esw and normal IPsec status table creation/destruction
      net/mlx5e: Add IPsec and ASO syndromes check in HW

 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  56 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 441 ++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 162 +-------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  35 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   4 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  69 +++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  29 ++
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 17 files changed, 608 insertions(+), 310 deletions(-)

