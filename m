Return-Path: <netdev+bounces-41019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2417C95A3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE398B20CAA
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE92629E;
	Sat, 14 Oct 2023 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT5EV7SR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0326295
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AD0C433C8;
	Sat, 14 Oct 2023 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303970;
	bh=PSDk4CHnP9MWlhiypPzafYt6+HGi80phUKp+YN3NIKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pT5EV7SRHGkXe2jJxICPmOhaWkpbabiL1Vd8UogUdBj1U8Vwp2RoYGYe/0nx2jtZM
	 buxbeRF06KcuLmXNNoqA4CjEDboNN6DmIhPqiGwUl1jVNn3+xjdh5wKuKNGFFSwITa
	 aC4WwwfvwpPweMOqbRN3Yh287ZMUtPxBlkx3elbAGzl1bBscAHIfMZpANApMvMedaC
	 xYopg0woJs8kccgd7WYdMlldEpH45YL2wbk4wS3gz3HzffZ0bJYTDN0dtXK9xC0zxW
	 GWF2vBfQJIlNxL1UVgDc+0YlpbUHVFbYc5S4JcePjMhdPJT8n+U0m0remyfDGXHPXu
	 IyWwiGFrq0JNQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [net-next V3 07/15] net/mlx5: fix config name in Kconfig parameter documentation
Date: Sat, 14 Oct 2023 10:19:00 -0700
Message-ID: <20231014171908.290428-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
adds documentation on Kconfig options for the mlx5 driver. It refers to the
config MLX5_EN_MACSEC for MACSec offloading, but the config is actually
called MLX5_MACSEC.

Fix the reference to the right config name in the documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 0a42c3395ffa..20d3b7e87049 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -67,7 +67,7 @@ Enabling the driver and kconfig options
 |    Enables :ref:`IPSec XFRM cryptography-offload acceleration <xfrm_device>`.
 
 
-**CONFIG_MLX5_EN_MACSEC=(y/n)**
+**CONFIG_MLX5_MACSEC=(y/n)**
 
 |    Build support for MACsec cryptography-offload acceleration in the NIC.
 
-- 
2.41.0


