Return-Path: <netdev+bounces-27934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C077DAAF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D3B281761
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1197C8CB;
	Wed, 16 Aug 2023 06:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622AC2EF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE55C433C8;
	Wed, 16 Aug 2023 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692168751;
	bh=9x6XYCIJfZswqP71VF9xof0678DuoczWTBVfmmHFNoE=;
	h=From:To:Cc:Subject:Date:From;
	b=Qk2/Mu80XH2lI/JVifFwYdyM/VWRmEtd3lxhgLl3D4U4WZZd//hMvjsf27IRvMF11
	 5CnW8cqLPskd5tnXDQcbSEe9VZRQhQsK8zTeuyiggL+syP8A7DUZGtSiebjdCtYPrJ
	 Pc0jJcDBbsD/NsIt4zs2/b+Ij7VZsNpTUwAywbSvHdLdIAdrcL0KD+Jm9OPh31FQ0D
	 NpMiGJTOrSzM/aaWbqQOeDbKJoBkaK8N7wKrwunNH+b0efvnGQzuJ456UUCluwLQrx
	 NNWLrA3YXqoK3YOFkZ1BN/czm0drz43Ke0ub81Zkz8Vx98WkUSNwvvwg9+rtdEUYmS
	 4n8OJPb9mt3yA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 0/2] mlx5 RDMA LAG fixes
Date: Wed, 16 Aug 2023 09:52:22 +0300
Message-ID: <cover.1692168533.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

These two not urgent fixes to mlx5 RDMA LAG logic.

Thanks

Mark Bloch (2):
  RDMA/mlx5: Get upper device only if device is lagged
  RDMA/mlx5: Send correct port events

 drivers/infiniband/hw/mlx5/main.c             | 57 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 29 ++++++++++
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 75 insertions(+), 13 deletions(-)

-- 
2.41.0


