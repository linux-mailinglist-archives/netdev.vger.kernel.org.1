Return-Path: <netdev+bounces-225686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47DB96D70
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCD23A7576
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C1327A33;
	Tue, 23 Sep 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nemr63Fb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0F327A2D
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645214; cv=none; b=CJSr/pKqQh4ltwCVX0+wBdsY5NfPe+97U5P6XiqljHDJc/Kzu1eW2CVLtUL27fnPlHktgmb/Gwh28O32ayBP6HaHmFYMfYNpIPJnPNBQ7OaUmZCm/O0J3p0kVkk/NgBZ7HKWl7ehHPNvTaoxEBb08Y4awPxoKArzzXRZujBEXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645214; c=relaxed/simple;
	bh=yyxLKFRUSaOLMyipF1taoQiRhF8zu9NLYdzoTScfv00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US4YiP1IOm2vXuseDRMoO9NI9kx4U0XtrY4StQX4XjZ+1CCIJEjAzjKRfgzjohBj0j3zjjk4d7LEjqpFZBovQt/so4fCzA2TcHPLotRFZ9chutZAd0xGWPNm0U8bPyxbGhJ22KPM53VIWk1qljjnpD3/2LjJNBlSC4PnFOawvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nemr63Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8014CC4CEF5;
	Tue, 23 Sep 2025 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758645213;
	bh=yyxLKFRUSaOLMyipF1taoQiRhF8zu9NLYdzoTScfv00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nemr63Fbqh6w+kFZnOKSJH+v2ugbEUdcPhuyOPLSRogRVG71ZKTMWINbpNzcLva4+
	 NoZ0DRoKeiufTxGcBbRop4qB5to9LOxjbxvOPwDBnZiWXjXFzFt7p1XloX0GwqV2hx
	 eZx6Y7FxB5siOUIpxRvjhuSlceFUaPC6ESyrW5WxbqjWbn1FVuFSt6xWNnP0FUx5cn
	 fVlDnSgo0lbQzAIrTm9RxkCNi1jy7f+VuAS+RGz7VcOjnwMvZ9cHsGXNtPB1RcYSSt
	 SpuKRCyMkIwAakpNLaQKHMxKB/HcziQih3MHSAoW+YJAGqzheEdIt8gPKIsYvtFhm6
	 26KOXDYZ/SURg==
Date: Tue, 23 Sep 2025 09:33:32 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v2 1/6] bnxt_en: Move common definitions to
 include/linux/bnxt/
Message-ID: <aNLL3L2SERi2IRhg@x130>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-2-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250923095825.901529-2-pavan.chebbi@broadcom.com>

On 23 Sep 02:58, Pavan Chebbi wrote:
>We have common definitions that are now going to be used
>by more than one component outside of bnxt (bnxt_re and
>fwctl)
>
>Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.
>Have a new common.h, also at the same place that will
>have some non-ulp but shared bnxt declarations.
>
>Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
>Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>---
> drivers/infiniband/hw/bnxt_re/debugfs.c       |  2 +-
> drivers/infiniband/hw/bnxt_re/main.c          |  2 +-
> drivers/infiniband/hw/bnxt_re/qplib_fp.c      |  2 +-
> drivers/infiniband/hw/bnxt_re/qplib_res.h     |  2 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +------
> .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
> .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
> .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  2 +-
> drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +-
> include/linux/bnxt/common.h                   | 20 +++++++++++++++++++
> .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  0
> 12 files changed, 30 insertions(+), 15 deletions(-)
> create mode 100644 include/linux/bnxt/common.h
> rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (100%)
>
>diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
>index e632f1661b92..a9dd3597cfbc 100644
>--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
>+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
>@@ -9,8 +9,8 @@
> #include <linux/debugfs.h>
> #include <linux/pci.h>
> #include <rdma/ib_addr.h>
>+#include <linux/bnxt/ulp.h>
>
>-#include "bnxt_ulp.h"
> #include "roce_hsi.h"
> #include "qplib_res.h"
> #include "qplib_sp.h"
>diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
>index df7cf8d68e27..b773556fc5e9 100644
>--- a/drivers/infiniband/hw/bnxt_re/main.c
>+++ b/drivers/infiniband/hw/bnxt_re/main.c
>@@ -55,8 +55,8 @@
> #include <rdma/ib_umem.h>
> #include <rdma/ib_addr.h>
> #include <linux/hashtable.h>
>+#include <linux/bnxt/ulp.h>
>
>-#include "bnxt_ulp.h"
> #include "roce_hsi.h"
> #include "qplib_res.h"
> #include "qplib_sp.h"
>diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>index ee36b3d82cc0..bb252cd8509b 100644
>--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
>@@ -46,6 +46,7 @@
> #include <linux/delay.h>
> #include <linux/prefetch.h>
> #include <linux/if_ether.h>
>+#include <linux/bnxt/ulp.h>
> #include <rdma/ib_mad.h>
>
> #include "roce_hsi.h"
>@@ -55,7 +56,6 @@
> #include "qplib_sp.h"
> #include "qplib_fp.h"
> #include <rdma/ib_addr.h>
>-#include "bnxt_ulp.h"
> #include "bnxt_re.h"
> #include "ib_verbs.h"
>
>diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
>index 6a13927674b4..7cdddf921b48 100644
>--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
>+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
>@@ -39,7 +39,7 @@
> #ifndef __BNXT_QPLIB_RES_H__
> #define __BNXT_QPLIB_RES_H__
>
>-#include "bnxt_ulp.h"
>+#include <linux/bnxt/ulp.h>
>
> extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
>
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>index d59612d1e176..917a39f8865c 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>@@ -59,10 +59,10 @@
> #include <net/netdev_rx_queue.h>
> #include <linux/pci-tph.h>
> #include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
>
> #include "bnxt.h"
> #include "bnxt_hwrm.h"
>-#include "bnxt_ulp.h"
> #include "bnxt_sriov.h"
> #include "bnxt_ethtool.h"
> #include "bnxt_dcb.h"
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>index 06a4c2afdf8a..2578bac16f6c 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>@@ -33,6 +33,7 @@
> #ifdef CONFIG_TEE_BNXT_FW
> #include <linux/firmware/broadcom/tee_bnxt_fw.h>
> #endif
>+#include <linux/bnxt/common.h>
>
> #define BNXT_DEFAULT_RX_COPYBREAK 256
> #define BNXT_MAX_RX_COPYBREAK 1024
>@@ -2075,12 +2076,6 @@ struct bnxt_fw_health {
> #define BNXT_FW_IF_RETRY		10
> #define BNXT_FW_SLOT_RESET_RETRY	4
>
>-struct bnxt_aux_priv {
>-	struct auxiliary_device aux_dev;
>-	struct bnxt_en_dev *edev;
>-	int id;
>-};
>-
> enum board_idx {
> 	BCM57301,
> 	BCM57302,
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>index 02961d93ed35..cfcd3335a2d3 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>@@ -13,12 +13,12 @@
> #include <net/devlink.h>
> #include <net/netdev_lock.h>
> #include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
> #include "bnxt.h"
> #include "bnxt_hwrm.h"
> #include "bnxt_vfr.h"
> #include "bnxt_devlink.h"
> #include "bnxt_ethtool.h"
>-#include "bnxt_ulp.h"
> #include "bnxt_ptp.h"
> #include "bnxt_coredump.h"
> #include "bnxt_nvm_defs.h"
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>index be32ef8f5c96..3231d3c022dc 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>@@ -27,9 +27,9 @@
> #include <net/netdev_queues.h>
> #include <net/netlink.h>
> #include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
> #include "bnxt.h"
> #include "bnxt_hwrm.h"
>-#include "bnxt_ulp.h"
> #include "bnxt_xdp.h"
> #include "bnxt_ptp.h"
> #include "bnxt_ethtool.h"
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>index 80fed2c07b9e..84c43f83193a 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
>@@ -17,9 +17,9 @@
> #include <linux/etherdevice.h>
> #include <net/dcbnl.h>
> #include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
> #include "bnxt.h"
> #include "bnxt_hwrm.h"
>-#include "bnxt_ulp.h"
> #include "bnxt_sriov.h"
> #include "bnxt_vfr.h"
> #include "bnxt_ethtool.h"
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
>index 61cf201bb0dc..992eec874345 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
>@@ -22,10 +22,10 @@
> #include <linux/auxiliary_bus.h>
> #include <net/netdev_lock.h>
> #include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
>
> #include "bnxt.h"
> #include "bnxt_hwrm.h"
>-#include "bnxt_ulp.h"
>
> static DEFINE_IDA(bnxt_aux_dev_ids);
>
>diff --git a/include/linux/bnxt/common.h b/include/linux/bnxt/common.h
>new file mode 100644
>index 000000000000..2ee75a0a1feb
>--- /dev/null
>+++ b/include/linux/bnxt/common.h
>@@ -0,0 +1,20 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+/*
>+ * Copyright (c) 2025, Broadcom Corporation
>+ *
>+ */
>+
>+#ifndef BNXT_COMN_H
>+#define BNXT_COMN_H
>+
>+#include <linux/bnxt/hsi.h>
>+#include <linux/bnxt/ulp.h>
>+#include <linux/auxiliary_bus.h>
>+
>+struct bnxt_aux_priv {
>+	struct auxiliary_device aux_dev;
>+	struct bnxt_en_dev *edev;
>+	int id;
>+};
>+

This file is redundant since ulp.h already holds every thing "aux", so this
struct belongs there. Also the only place you include this is file:
   drivers/net/ethernet/broadcom/bnxt/bnxt.h

So I am not sure if you have your include paths properly setup to avoid
cross subsystem includes, in-case this was the point of this patch :).

>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
>similarity index 100%
>rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
>rename to include/linux/bnxt/ulp.h
>-- 
>2.39.1
>
>

