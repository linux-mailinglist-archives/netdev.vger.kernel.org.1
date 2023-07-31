Return-Path: <netdev+bounces-22812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFD76955F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3EE1C20B6C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099C4182A8;
	Mon, 31 Jul 2023 11:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46771801F
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D302AC433C8;
	Mon, 31 Jul 2023 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690804728;
	bh=ZdZB42/MR1hgj+SktoePO/x4DWS302BFr0vT4JH85ks=;
	h=From:To:Cc:Subject:Date:From;
	b=BagvljnBgtGuS2OJyLi/7T62YySbcJZXzdcUMNi5Qq9ZiSd5kG77Tjl55vpbwKXAp
	 50/kTuRfNXX0dWxXI/LbiQ5qvF68Y+hblGv9DjYRFwz4hlG1nLDH2mKgp+mxdoOlEn
	 eNz8oJ4sfG/86l/3++4CWQeg9flm/A9Gajn4IzEfqUN8umHLT95bxvlHK/56eVee+D
	 1nzQxrPNCQrgBfQXuICAqd9DtixvmKBdjtfq/H/sZp0pKdvycqJZRtCJuf+LYiVPr/
	 iFe36B/E22lWDIh7EybacAekeB+N+wzwaGkdABUpKBg3gLJ7Ua10QCznIPdi+wlEtK
	 8WBHs01zyVSSg==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Eric Dumazet <edumazet@google.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Paul Blakey <paulb@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net 0/3] mlx5 IPsec fixes
Date: Mon, 31 Jul 2023 14:58:39 +0300
Message-ID: <cover.1690803944.git.leonro@nvidia.com>
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

The following patches are combination of Jianbo's work on IPsec eswitch mode
together with our internal review toward addition of TCP protocol selectors
support to IPSec packet offload.

Despite not-being fix, the first patch helps us to make second one more
clear, so I'm asking to apply it anyway as part of this series.

Thanks

Jianbo Liu (2):
  net/mlx5: fs_core: Make find_closest_ft more generic
  net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS
    fs_prio

Leon Romanovsky (1):
  net/mlx5e: Set proper IPsec source port in L4 selector

 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 103 ++++++++++++++----
 2 files changed, 85 insertions(+), 22 deletions(-)

-- 
2.41.0


