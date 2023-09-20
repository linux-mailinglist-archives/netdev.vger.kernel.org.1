Return-Path: <netdev+bounces-35199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20067A789F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC041C20AA1
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA815AFA;
	Wed, 20 Sep 2023 10:08:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DED154B7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA704C433C7;
	Wed, 20 Sep 2023 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204495;
	bh=nk9sUgWDYC5lpjFZ2LPWQ3HlWeTCNQ9xYNRq9k9Bbnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm5c44I6MfX1bBfajxOD6q3Tef68IFN8FwnurRhWTeFcnucuF81VdADL1RIKUOICe
	 tWfh28QwfKjuEEtEjWIgq9xSJ0MkRKt/uMoPmvgg3VSPRlDhP53orBw1b2nF6eaIwj
	 BttVVwaznlnovPNaXQn531yFoxyWVxtwgx9t8E92ar+uqKR0Ed7ABUoKyLtB1iAooA
	 znSHCWApt+cA4lZEVKPjPD70OrRq47f0lw0lafa4AOuYAu8zHVrhT+J5zUQHBtGN5z
	 KXkCKl1Zwfw38PArAaoEYFgXCZBQ/Y5AMlfesTakEr7494pri2hjJxY5dRedDis+ne
	 zPI17gs+GlFsA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 6/6] RDMA/ipoib: Add support for XDR speed in ethtool
Date: Wed, 20 Sep 2023 13:07:45 +0300
Message-ID: <ca252b79b7114af967de3d65f9a38992d4d87a14.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

The IBTA specification 1.7 has new speed - XDR, supporting signaling
rate of 200Gb.

Ethtool support of IPoIB driver translates IB speed to signaling rate.
Added translation of XDR IB type to rate of 200Gb Ethernet speed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 8af99b18d361..7da94fb8d7fa 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -174,6 +174,8 @@ static inline int ib_speed_enum_to_int(int speed)
 		return SPEED_50000;
 	case IB_SPEED_NDR:
 		return SPEED_100000;
+	case IB_SPEED_XDR:
+		return SPEED_200000;
 	}
 
 	return SPEED_UNKNOWN;
-- 
2.41.0


