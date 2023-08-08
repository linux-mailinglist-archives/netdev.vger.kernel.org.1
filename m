Return-Path: <netdev+bounces-25539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9A774798
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB311C20EA6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF21643D;
	Tue,  8 Aug 2023 19:15:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AD13FE6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274DC433C8;
	Tue,  8 Aug 2023 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691522101;
	bh=cami2FnL6t1VvrPPlUGdxgsXrIfon9DmD7r/BuQi4Y8=;
	h=From:To:Cc:Subject:Date:From;
	b=uvgS9nbzq4JBvTMy3FByUbMJassyU4tyPYqXf5JE2Ii48u4QeVRx9jz4//08CSf/j
	 0ZMKvMnSK0/+ZcC7IwfXBDMaZ7Ymq3mcvKPxSaQGKNqumm8iaAwVJ8qjsKvy1ZeU/t
	 bEljaxvlCFpBQx/57egEiUew3JPzwDFLc3VCBqtJPvWI8qeORPoROJOQoin6B9aCAz
	 c8V+1OUoR8jeJ7FOxsB+CtrXyZ3npSZ9lAJdRN/lhsEbHqYnbkIpba9KRQHVXPM4jM
	 ktq1/5FN+3vybkgllugJVxjSRZ4H/Pkg2r+qF9bDyjZg6PeikyZ/NVG5bt6J8MiDUt
	 9dKvN1QVdHutw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 0/2] Support more IPsec selectors in mlx5 packet offload 
Date: Tue,  8 Aug 2023 22:14:53 +0300
Message-ID: <cover.1691521680.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

These two patches add ability to configure proto both UDP and TCP selectors
in RX and TX directions.

Thanks

Emeel Hakim (1):
  net/mlx5e: Support IPsec upper protocol selector field offload for RX

Leon Romanovsky (1):
  net/mlx5e: Support IPsec upper TCP protocol selector

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 13 +++---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 45 ++++++++++++++-----
 2 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.41.0


