Return-Path: <netdev+bounces-28235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D977EB4A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28C7281CB4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC251BEFD;
	Wed, 16 Aug 2023 21:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED211BEEB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03394C433BA;
	Wed, 16 Aug 2023 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219665;
	bh=2epbzPUicPfxKSn/FR2IY0KmEQa+ussd19335ABtUek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPZtLhFASUSadusACbk2w5U0kSQUyaopLwP0MjfI3zbTreMkXbfq2KpJW4pHLl0VZ
	 yDeDZRg0e+slkm13ePTufMlMmIgJ7RRSwARbrDokHPdLIBzZMnnL3aCL2b1yAodufk
	 +PseEZep2L8wg6Y/u2IwjVR/af7XO73uF49WTn1e04CogmDjG6IkmrMz8REfzLMAWG
	 Oyug+K+CR3NmxANZv9tzLVcERULmn69ngxO4PjKmOBJzgNsPYJG3UGNpRTHzjMowTx
	 RP4XSVg6miW4Rqw6MNPeuRJQJtkLICnlVJhK05ikOvbbDJ7rM/tFvPaUQwZ8PQ6m3E
	 MazRautDcXVcQ==
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
Subject: [net-next 09/15] net/mlx5: Update dead links in Kconfig documentation
Date: Wed, 16 Aug 2023 14:00:43 -0700
Message-ID: <20230816210049.54733-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
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


