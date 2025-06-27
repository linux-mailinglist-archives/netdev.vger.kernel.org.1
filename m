Return-Path: <netdev+bounces-201726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B754AEAC62
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531113BF35F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852B16B3B7;
	Fri, 27 Jun 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOLnvqxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A4155A4E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750988579; cv=none; b=O/i+b3rddX47OoOlGt5lgWUIY/mkx4wbIR01Ij8jwxYXJV8UyTK6RX0Hj+m05bnndIcgFEI3D0Zoc/d3Yic66NNGezhAW3fDmjeF/iSHWiJHbe9WR4cpJDegcVBLVDkeYp3HfLob0epwnsS5iUQo/IV/08gsbr/e+7l2yaJTOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750988579; c=relaxed/simple;
	bh=nkppvgRATu6KHCAsmSWp2D8nAJmBmocgpqXdY71UlFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtSNuU3MOQbkSRtFXE4doC8Fq6DfzeyrFAEusunfeaMop0GUryqyijBqzd0zCbfjGYGKLUSiHztGt40QZy5z3fB6fNfHHOpdPR27RGhlPagRyduBXQ2sbyS8YpCsFSWDaI4+tFkSmGAVWQ4VTDNWzF4r5fRCWIbhLnZiyA51FJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOLnvqxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADEBC4CEEB;
	Fri, 27 Jun 2025 01:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750988578;
	bh=nkppvgRATu6KHCAsmSWp2D8nAJmBmocgpqXdY71UlFs=;
	h=From:To:Cc:Subject:Date:From;
	b=QOLnvqxqW1E+xfHtBr3+bC5TFZp6n2LFPWp5d/sl1Wm2PeFPhD0O3o32WWqfBNELP
	 pR5/tmPH2H/xIwD0GpD2rL90gyYBr2AacXnuZFLbmYkTFsCddhugS7KX4vuWm4+g4o
	 qk9rhIZHJK0NV5V3CdERJnOUtXUt+AA04sjK+u9ozbcSM+wvkIzbwzcufVMLQbmD1m
	 tbevtKU8vQCtYqJZKoylbfAC7Ysmt0iZlgA0Wt1tBZdSUlkj4TgilrLcSL6GIpdS6k
	 ka6IybyRWpbUc/88fXCDLzrFOtTnGi4CSXR+N12upjbR2mhBPK94d1xFR6lLkZbPWH
	 M+mT+FFAxelVg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next] MAINTAINERS: Add myself as mlx5 core and mlx5e co-maintainer
Date: Thu, 26 Jun 2025 18:42:52 -0700
Message-ID: <20250627014252.1262592-1-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

I have been working on mlx5 related code for several years,
contributing features, code reviews, and occasional maintainer tasks
when needed. This patch makes my maintainer role official.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---

Sending on behalf of Mark, Mark will be helping with maintainer tasks
and reviews, Mark is following and contributing to the netdev mailing
list, and he has a lot of experience in mlx5 especially in the
eswitch side which keeps growing as we keep scaling up virtualization
support.

Thanks,
Saeed.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d2074d16107..ad6e18100b9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15431,6 +15431,7 @@ F:	drivers/net/ethernet/mellanox/mlx4/en_*
 MELLANOX ETHERNET DRIVER (mlx5e)
 M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
+M:	Mark Bloch <mbloch@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	https://www.nvidia.com/networking/
@@ -15500,6 +15501,7 @@ MELLANOX MLX5 core VPI driver
 M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Leon Romanovsky <leonro@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
+M:	Mark Bloch <mbloch@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.49.0


