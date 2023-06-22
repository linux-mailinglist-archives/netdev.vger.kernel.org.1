Return-Path: <netdev+bounces-12906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A577396F5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7628A1C2102B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46954436;
	Thu, 22 Jun 2023 05:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4323C3E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207FBC433C0;
	Thu, 22 Jun 2023 05:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412868;
	bh=OMxI9C4wnPWos1znjk/0iYqGr6DfIFAyPBnPTZxFukU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiRGAxm92Xu8WF31Kx3HmmVvzvHwUvmyX5Pr1rqJW88gdNQKRQajqKUj1yiFxqER8
	 sgU/0SabpIpdFtoKn5DAqGTPC7feTzInJA+vI2IcXa4bZFV7qhlfQevj3EJCgoUNs8
	 FeTgrS00jRy/CMDneEEznNf47wsNXbsMa3PrOVURnqdqksu4jlquKBtyS+Egp4/+jn
	 baJH2BtyIpDeZxuUlnC7Onxs8iBCzdE3w3oB6OMCyDY8u4P6BWK9Z/EKqCTb2HcC3r
	 8I4my+H/rX1FLQUU0B9EvtibmiWY5T/MzzO1Zk0p6O9goqoTyAXi/rLOKtCTWdWQcn
	 F8oGkDo6PaTkA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Automatic Verification <verifier@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next 02/15] net/mlx5: Fix SFs kernel documentation error
Date: Wed, 21 Jun 2023 22:47:22 -0700
Message-ID: <20230622054735.46790-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Indent SFs probe code example in order to fix the below error:

Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:57: ERROR: Unexpected indentation.
Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:61: ERROR: Unexpected indentation.

Fixes: e71383fb9cd1 ("net/mlx5: Light probe local SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Automatic Verification <verifier@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 .../ethernet/mellanox/mlx5/switchdev.rst      | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
index db62187eebce..6e3f5ee8b0d0 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
@@ -51,19 +51,21 @@ This will allow user to configure the SF before the SF have been fully probed,
 which will save time.
 
 Usage example:
-Create SF:
-$ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 11
-$ devlink port function set pci/0000:08:00.0/32768 \
-               hw_addr 00:00:00:00:00:11 state active
 
-Enable ETH auxiliary device:
-$ devlink dev param set auxiliary/mlx5_core.sf.1 \
-              name enable_eth value true cmode driverinit
+- Create SF::
 
-Now, in order to fully probe the SF, use devlink reload:
-$ devlink dev reload auxiliary/mlx5_core.sf.1
+    $ devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 11
+    $ devlink port function set pci/0000:08:00.0/32768 hw_addr 00:00:00:00:00:11 state active
 
-mlx5 supports ETH,rdma and vdpa (vnet) auxiliary devices devlink params (see :ref:`Documentation/networking/devlink/devlink-params.rst`)
+- Enable ETH auxiliary device::
+
+    $ devlink dev param set auxiliary/mlx5_core.sf.1 name enable_eth value true cmode driverinit
+
+- Now, in order to fully probe the SF, use devlink reload::
+
+    $ devlink dev reload auxiliary/mlx5_core.sf.1
+
+mlx5 supports ETH,rdma and vdpa (vnet) auxiliary devices devlink params (see :ref:`Documentation/networking/devlink/devlink-params.rst <devlink_params_generic>`).
 
 mlx5 supports subfunction management using devlink port (see :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>`) interface.
 
-- 
2.41.0


