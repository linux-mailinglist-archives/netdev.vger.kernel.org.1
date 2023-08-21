Return-Path: <netdev+bounces-29394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F146782FD3
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE73280F32
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF31173E;
	Mon, 21 Aug 2023 17:58:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656D11712
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E56C433C9;
	Mon, 21 Aug 2023 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640679;
	bh=2epbzPUicPfxKSn/FR2IY0KmEQa+ussd19335ABtUek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dr439Ng786SMv25ji3kUavO+39/C3MnPsI1M2ilwN01kqnZo7U0cjycvr2chLFOXo
	 UzKUBNQGBWYsSewYqxw3RBW4+/LqqOAfZ5pw7Ul0ZSD7ZOiu5a4QdLkBI+ezJFAYjf
	 Ekx0d7yH7l0Wucs2g0Kkubsey9vMuPkOGWGEmfw2Zz179+k9mff04T8I+YVQfEs+Ne
	 1n6sdNYaSYXi1Xnb/gHBl4jsqM/jviX3T9v2rmTxBOE/MrokIX8cz3S4HTP8vF9AKt
	 RLwl1QebyiB+Q/vX/dZphKORN7yz9I/WW1mmETPfwNWD9AiD3Z97xbGeEI/CT68ssK
	 VK0MqoBfb6jTA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net-next V2 09/14] net/mlx5: Update dead links in Kconfig documentation
Date: Mon, 21 Aug 2023 10:57:34 -0700
Message-ID: <20230821175739.81188-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Point to NVIDIA documentation for device specific information now that the
Mellanox documentation site is deprecated. Refer to kernel documentation
sources for generic information not specific to mlx5 devices.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/kconfig.rst             | 14 +++++++-------
 Documentation/networking/xfrm_device.rst           |  1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 43b1f7e87ec4..0a42c3395ffa 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -36,7 +36,7 @@ Enabling the driver and kconfig options
 
 **CONFIG_MLX5_CORE_EN_DCB=(y/n)**:
 
-|    Enables `Data Center Bridging (DCB) Support <https://community.mellanox.com/s/article/howto-auto-config-pfc-and-ets-on-connectx-4-via-lldp-dcbx>`_.
+|    Enables `Data Center Bridging (DCB) Support <https://enterprise-support.nvidia.com/s/article/howto-auto-config-pfc-and-ets-on-connectx-4-via-lldp-dcbx>`_.
 
 
 **CONFIG_MLX5_CORE_IPOIB=(y/n)**
@@ -59,12 +59,12 @@ Enabling the driver and kconfig options
 **CONFIG_MLX5_EN_ARFS=(y/n)**
 
 |    Enables Hardware-accelerated receive flow steering (arfs) support, and ntuple filtering.
-|    https://community.mellanox.com/s/article/howto-configure-arfs-on-connectx-4
+|    https://enterprise-support.nvidia.com/s/article/howto-configure-arfs-on-connectx-4
 
 
 **CONFIG_MLX5_EN_IPSEC=(y/n)**
 
-|    Enables `IPSec XFRM cryptography-offload acceleration <https://support.mellanox.com/s/article/ConnectX-6DX-Bluefield-2-IPsec-HW-Full-Offload-Configuration-Guide>`_.
+|    Enables :ref:`IPSec XFRM cryptography-offload acceleration <xfrm_device>`.
 
 
 **CONFIG_MLX5_EN_MACSEC=(y/n)**
@@ -87,8 +87,8 @@ Enabling the driver and kconfig options
 
 |    Ethernet SRIOV E-Switch support in ConnectX NIC. E-Switch provides internal SRIOV packet steering
 |    and switching for the enabled VFs and PF in two available modes:
-|           1) `Legacy SRIOV mode (L2 mac vlan steering based) <https://community.mellanox.com/s/article/howto-configure-sr-iov-for-connectx-4-connectx-5-with-kvm--ethernet-x>`_.
-|           2) `Switchdev mode (eswitch offloads) <https://www.mellanox.com/related-docs/prod_software/ASAP2_Hardware_Offloading_for_vSwitches_User_Manual_v4.4.pdf>`_.
+|           1) `Legacy SRIOV mode (L2 mac vlan steering based) <https://enterprise-support.nvidia.com/s/article/HowTo-Configure-SR-IOV-for-ConnectX-4-ConnectX-5-ConnectX-6-with-KVM-Ethernet>`_.
+|           2) :ref:`Switchdev mode (eswitch offloads) <switchdev>`.
 
 
 **CONFIG_MLX5_FPGA=(y/n)**
@@ -101,13 +101,13 @@ Enabling the driver and kconfig options
 
 **CONFIG_MLX5_INFINIBAND=(y/n/m)** (module mlx5_ib.ko)
 
-|    Provides low-level InfiniBand/RDMA and `RoCE <https://community.mellanox.com/s/article/recommended-network-configuration-examples-for-roce-deployment>`_ support.
+|    Provides low-level InfiniBand/RDMA and `RoCE <https://enterprise-support.nvidia.com/s/article/recommended-network-configuration-examples-for-roce-deployment>`_ support.
 
 
 **CONFIG_MLX5_MPFS=(y/n)**
 
 |    Ethernet Multi-Physical Function Switch (MPFS) support in ConnectX NIC.
-|    MPFs is required for when `Multi-Host <http://www.mellanox.com/page/multihost>`_ configuration is enabled to allow passing
+|    MPFs is required for when `Multi-Host <https://www.nvidia.com/en-us/networking/multi-host/>`_ configuration is enabled to allow passing
 |    user configured unicast MAC addresses to the requesting PF.
 
 
diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 83abdfef4ec3..535077cbeb07 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. _xfrm_device:
 
 ===============================================
 XFRM device - offloading the IPsec computations
-- 
2.41.0


