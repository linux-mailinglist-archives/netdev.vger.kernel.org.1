Return-Path: <netdev+bounces-157356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF207A0A067
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2E03AAFD1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108711487D1;
	Sat, 11 Jan 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duUYPFFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17881465AB
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563442; cv=none; b=ejiv9ccK3IQAOflGzH2qTgSJj0ij0FPrTi618TX4+ibsNB1QQS8h2tfjLRFXoVRKYYWlR5p+b/ETkcKZXF+kn7zvsm+jH8Jevbbs4ZQA6SyWEzx3XQYuRkrhWgALLg0G3q3dXhuWULCyu0xWQgwKRqq4U90anlzbZLlRulfJS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563442; c=relaxed/simple;
	bh=mhVqdTIxRdJlAEnki10cbFYbNF3JRVMc8Fko3gVP7G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgoKa/JQOmm75ypyXJdtoHhkyiE3ptiWast5gUCcGzNtE5yopXB9wWBOH2RtFhuj5YRvgbIQpgKwWUfuBpAg9qQM6kykpRbl8vBV3wh82v4dfqhRRjiBuQMjhcveDKPW7KP9Lir+Wn5saV3rVHLZA++ShTi2Q3DMQHFtihbxGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duUYPFFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE64C4CEE0;
	Sat, 11 Jan 2025 02:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563441;
	bh=mhVqdTIxRdJlAEnki10cbFYbNF3JRVMc8Fko3gVP7G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duUYPFFxDLH2gjcS0V3ecgO0DVtG5c4B07wmSQLyl4aB1cVIdgniDTwpoDjRFmzBP
	 yseap6oDruKWXY1fNyxErCazYkZxAt6sLbZQ/TvDqYFDpU9ku/cWR2KA3E9Pi8EOtO
	 Xc9smXgdmQ8icmZd71/0yr9J1WsNdshyqD3fAxwCZSDbIBmkS01V/y7ayWLzHtkP8L
	 6aCJPfUutgi0fx10sRDhRsSEcg+Mf5R9vy7JHiiogobHH/J63iFkJUJcYlZsCqi93r
	 PZ5Yy2SrHIhG6ivfmUEkMfIDcYVR94TvzpifryjVtozsO7HEnezzIn2lg05bEadSir
	 kFOOC7dH4sozw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] MAINTAINERS: downgrade Ethernet NIC drivers without CI reporting
Date: Fri, 10 Jan 2025 18:43:57 -0800
Message-ID: <20250111024359.3678956-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250111024359.3678956-1-kuba@kernel.org>
References: <20250111024359.3678956-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Per previous change downgrade all NIC drivers (discrete, embedded,
SoC components, virtual) which don't report test results to CI
from Supported to Maintained.

Also include all components or building blocks of NIC drivers
(separate entries for "shared" code, subsystem support like PTP
or entries for specific offloads etc.)

Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: spell commit msg
v1: https://lore.kernel.org/20250110005223.3213487-1-kuba@kernel.org
---
 MAINTAINERS | 106 ++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f3e289b391c..7229357b7554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -951,7 +951,7 @@ M:	Arthur Kiyanovski <akiyano@amazon.com>
 R:	David Arinzon <darinzon@amazon.com>
 R:	Saeed Bishara <saeedb@amazon.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
 F:	drivers/net/ethernet/amazon/
 
@@ -1124,7 +1124,7 @@ AMD PDS CORE DRIVER
 M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
 F:	drivers/net/ethernet/amd/pds_core/
 F:	include/linux/pds/
@@ -1196,7 +1196,7 @@ F:	drivers/spi/spi-amd.c
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
@@ -1702,14 +1702,14 @@ F:	drivers/edac/xgene_edac.c
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
 M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
 M:	Keyur Chudgar <keyur@os.amperecomputing.com>
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/apm/xgene-v2/
 
 APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
 M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
 M:	Keyur Chudgar <keyur@os.amperecomputing.com>
 M:	Quan Nguyen <quan@os.amperecomputing.com>
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
 F:	drivers/net/ethernet/apm/xgene/
@@ -1747,7 +1747,7 @@ F:	drivers/hwmon/aquacomputer_d5next.c
 AQUANTIA ETHERNET DRIVER (atlantic)
 M:	Igor Russkikh <irusskikh@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.marvell.com/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	Documentation/networking/device_drivers/ethernet/aquantia/atlantic.rst
@@ -1756,7 +1756,7 @@ F:	drivers/net/ethernet/aquantia/atlantic/
 AQUANTIA ETHERNET DRIVER PTP SUBSYSTEM
 M:	Egor Pomozov <epomozov@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.aquantia.com
 F:	drivers/net/ethernet/aquantia/atlantic/aq_ptp*
 
@@ -2291,7 +2291,7 @@ F:	arch/arm/mach-highbank/
 ARM/CAVIUM THUNDER NETWORK DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/cavium/thunder/
 
 ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
@@ -3666,7 +3666,7 @@ F:	include/uapi/linux/sonet.h
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/cadence/
 
 ATMEL MAXTOUCH DRIVER
@@ -4395,7 +4395,7 @@ F:	drivers/net/ethernet/broadcom/asp2/
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/broadcom/b44.*
 
 BROADCOM B53/SF2 ETHERNET SWITCH DRIVER
@@ -4579,7 +4579,7 @@ BROADCOM BNX2 GIGABIT ETHERNET DRIVER
 M:	Rasesh Mody <rmody@marvell.com>
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/broadcom/bnx2.*
 F:	drivers/net/ethernet/broadcom/bnx2_*
 
@@ -4603,14 +4603,14 @@ BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER
 M:	Sudarsana Kalluru <skalluru@marvell.com>
 M:	Manish Chopra <manishc@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
 BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/firmware/broadcom/tee_bnxt_fw.c
 F:	drivers/net/ethernet/broadcom/bnxt/
 F:	include/linux/firmware/broadcom/tee_bnxt_fw.h
@@ -4706,7 +4706,7 @@ M:	Doug Berger <opendmb@gmail.com>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
 F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
 F:	drivers/net/ethernet/broadcom/genet/
@@ -4858,7 +4858,7 @@ BROADCOM SYSTEMPORT ETHERNET DRIVER
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/brcm,systemport.yaml
 F:	drivers/net/ethernet/broadcom/bcmsysport.*
 F:	drivers/net/ethernet/broadcom/unimac.h
@@ -4867,7 +4867,7 @@ BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/broadcom/tg3.*
 
 BROADCOM VK DRIVER
@@ -4889,7 +4889,7 @@ M:	Rasesh Mody <rmody@marvell.com>
 M:	Sudarsana Kalluru <skalluru@marvell.com>
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/brocade/bna/
 
 BSG (block layer generic sg v4 driver)
@@ -5577,7 +5577,7 @@ F:	drivers/scsi/snic/
 CISCO VIC ETHERNET NIC DRIVER
 M:	Christian Benvenuti <benve@cisco.com>
 M:	Satish Kharat <satishkh@cisco.com>
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/cisco/enic/
 
 CISCO VIC LOW LATENCY NIC DRIVER
@@ -6175,7 +6175,7 @@ F:	drivers/media/dvb-frontends/cxd2820r*
 CXGB3 ETHERNET DRIVER (CXGB3)
 M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb3/
 
@@ -6196,14 +6196,14 @@ F:	drivers/crypto/chelsio
 CXGB4 ETHERNET DRIVER (CXGB4)
 M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb4/
 
 CXGB4 INLINE CRYPTO DRIVER
 M:	Ayush Sawal <ayush.sawal@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/inline_crypto/
 
@@ -6225,7 +6225,7 @@ F:	include/uapi/rdma/cxgb4-abi.h
 CXGB4VF ETHERNET DRIVER (CXGB4VF)
 M:	Potnuri Bharat Teja <bharat@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
@@ -8401,7 +8401,7 @@ M:	Ajit Khaparde <ajit.khaparde@broadcom.com>
 M:	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
 M:	Somnath Kotur <somnath.kotur@broadcom.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	http://www.emulex.com
 F:	drivers/net/ethernet/emulex/benet/
 
@@ -9440,7 +9440,7 @@ F:	samples/ftrace
 FUNGIBLE ETHERNET DRIVERS
 M:	Dimitris Michailidis <dmichail@fungible.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/fungible/
 
 FUSE: FILESYSTEM IN USERSPACE
@@ -9745,7 +9745,7 @@ M:	Jeroen de Borst <jeroendb@google.com>
 M:	Praveen Kaligineedi <pkaligineedi@google.com>
 R:	Shailend Chand <shailend@google.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
 F:	drivers/net/ethernet/google
 
@@ -10966,7 +10966,7 @@ M:	Rick Lindsley <ricklind@linux.ibm.com>
 R:	Nick Child <nnac123@linux.ibm.com>
 R:	Thomas Falcon <tlfalcon@linux.ibm.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/ibm/ibmvnic.*
 
 IBM Power VFIO Support
@@ -10977,7 +10977,7 @@ F:	drivers/vfio/vfio_iommu_spapr_tce.c
 IBM Power Virtual Ethernet Device Driver
 M:	Nick Child <nnac123@linux.ibm.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/ibm/ibmveth.*
 
 IBM Power Virtual FC Device Drivers
@@ -11510,7 +11510,7 @@ INTEL ETHERNET DRIVERS
 M:	Tony Nguyen <anthony.l.nguyen@intel.com>
 M:	Przemek Kitszel <przemyslaw.kitszel@intel.com>
 L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
-S:	Supported
+S:	Maintained
 W:	https://www.intel.com/content/www/us/en/support.html
 Q:	https://patchwork.ozlabs.org/project/intel-wired-lan/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git
@@ -13118,7 +13118,7 @@ LIBETH COMMON ETHERNET LIBRARY
 M:	Alexander Lobakin <aleksander.lobakin@intel.com>
 L:	netdev@vger.kernel.org
 L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
-S:	Supported
+S:	Maintained
 T:	git https://github.com/alobakin/linux.git
 F:	drivers/net/ethernet/intel/libeth/
 F:	include/net/libeth/
@@ -13128,7 +13128,7 @@ LIBIE COMMON INTEL ETHERNET LIBRARY
 M:	Alexander Lobakin <aleksander.lobakin@intel.com>
 L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 T:	git https://github.com/alobakin/linux.git
 F:	drivers/net/ethernet/intel/libie/
 F:	include/linux/net/intel/libie/
@@ -13931,7 +13931,7 @@ MARVELL OCTEON ENDPOINT DRIVER
 M:	Veerasenareddy Burru <vburru@marvell.com>
 M:	Sathesh Edara <sedara@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/marvell/octeon_ep
 
 MARVELL OCTEON ENDPOINT VF DRIVER
@@ -13940,7 +13940,7 @@ M:	Sathesh Edara <sedara@marvell.com>
 M:	Shinas Rasheed <srasheed@marvell.com>
 M:	Satananda Burla <sburla@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/marvell/octeon_ep_vf
 
 MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
@@ -13950,7 +13950,7 @@ M:	Subbaraya Sundeep <sbhatta@marvell.com>
 M:	hariprasad <hkelam@marvell.com>
 M:	Bharat Bhushan <bbhushan2@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/marvell/octeontx2/nic/
 F:	include/linux/soc/marvell/octeontx2/
 
@@ -13962,7 +13962,7 @@ M:	Jerin Jacob <jerinj@marvell.com>
 M:	hariprasad <hkelam@marvell.com>
 M:	Subbaraya Sundeep <sbhatta@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
@@ -14850,7 +14850,7 @@ F:	drivers/i2c/busses/i2c-mlxbf.c
 MELLANOX ETHERNET DRIVER (mlx4_en)
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/en_*
@@ -14859,7 +14859,7 @@ MELLANOX ETHERNET DRIVER (mlx5e)
 M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_*
@@ -14867,7 +14867,7 @@ F:	drivers/net/ethernet/mellanox/mlx5/core/en_*
 MELLANOX ETHERNET INNOVA DRIVERS
 R:	Boris Pismenny <borisp@nvidia.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_accel/*
@@ -14906,7 +14906,7 @@ MELLANOX MLX4 core VPI driver
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/
@@ -14928,7 +14928,7 @@ M:	Leon Romanovsky <leonro@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
-S:	Supported
+S:	Maintained
 W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	Documentation/networking/device_drivers/ethernet/mellanox/
@@ -15162,7 +15162,7 @@ META ETHERNET DRIVERS
 M:	Alexander Duyck <alexanderduyck@fb.com>
 M:	Jakub Kicinski <kuba@kernel.org>
 R:	kernel-team@meta.com
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/meta/
 F:	drivers/net/ethernet/meta/
 
@@ -16188,7 +16188,7 @@ F:	net/sched/sch_netem.c
 NETERION 10GbE DRIVERS (s2io)
 M:	Jon Mason <jdmason@kudzu.us>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/neterion/s2io.rst
 F:	drivers/net/ethernet/neterion/
 
@@ -16513,7 +16513,7 @@ M:	Manish Chopra <manishc@marvell.com>
 M:	Rahul Verma <rahulv@marvell.com>
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/qlogic/netxen/
 
 NET_FAILOVER MODULE
@@ -18290,7 +18290,7 @@ PENSANDO ETHERNET DRIVERS
 M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
 F:	drivers/net/ethernet/pensando/
 
@@ -19057,7 +19057,7 @@ F:	drivers/scsi/qedi/
 QLOGIC QL4xxx ETHERNET DRIVER
 M:	Manish Chopra <manishc@marvell.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/qlogic/qed/
 F:	drivers/net/ethernet/qlogic/qede/
 F:	include/linux/qed/
@@ -19085,7 +19085,7 @@ F:	drivers/scsi/qla2xxx/
 QLOGIC QLA3XXX NETWORK DRIVER
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/qlogic/qla3xxx.*
 
 QLOGIC QLA4XXX iSCSI DRIVER
@@ -19101,7 +19101,7 @@ M:	Shahed Shaikh <shshaikh@marvell.com>
 M:	Manish Chopra <manishc@marvell.com>
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/qlogic/qlcnic/
 
 QM1D1B0004 MEDIA DRIVER
@@ -19842,7 +19842,7 @@ M:	Paul Barker <paul.barker.ct@bp.renesas.com>
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/renesas,etheravb.yaml
 F:	drivers/net/ethernet/renesas/Kconfig
 F:	drivers/net/ethernet/renesas/Makefile
@@ -19862,7 +19862,7 @@ RENESAS ETHERNET TSN DRIVER
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/renesas,ethertsn.yaml
 F:	drivers/net/ethernet/renesas/rtsn.*
 
@@ -20012,7 +20012,7 @@ RENESAS SUPERH ETHERNET DRIVER
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/net/renesas,ether.yaml
 F:	drivers/net/ethernet/renesas/Kconfig
 F:	drivers/net/ethernet/renesas/Makefile
@@ -20855,7 +20855,7 @@ F:	include/linux/platform_data/spi-s3c64xx.h
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
@@ -21257,7 +21257,7 @@ M:	Edward Cree <ecree.xilinx@gmail.com>
 M:	Martin Habets <habetsm.xilinx@gmail.com>
 L:	netdev@vger.kernel.org
 L:	linux-net-drivers@amd.com
-S:	Supported
+S:	Maintained
 F:	Documentation/networking/devlink/sfc.rst
 F:	drivers/net/ethernet/sfc/
 
@@ -22738,7 +22738,7 @@ F:	include/linux/platform_data/dma-dw.h
 SYNOPSYS DESIGNWARE ENTERPRISE ETHERNET DRIVER
 M:	Jose Abreu <Jose.Abreu@synopsys.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/synopsys/
 
 SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
@@ -23138,7 +23138,7 @@ F:	drivers/phy/tegra/xusb*
 TEHUTI ETHERNET DRIVER
 M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ethernet/tehuti/tehuti.*
 
 TEHUTI TN40XX ETHERNET DRIVER
-- 
2.47.1


