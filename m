Return-Path: <netdev+bounces-227213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E1CBAA50E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE261922A7A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1A24167F;
	Mon, 29 Sep 2025 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeb8xOcb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D432253FF
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170862; cv=none; b=KJNhZuaTn5bhKH/MRJ8B0iU4bWffEVV9hAJylaRMGSyxuAE001NghfyOwBz2Kv5uyGZ/G2UVvcI8QJelFU+hDyM7Knjo7dnsDUsG17vjfibQPJyKg5mEj/yiPovM2XsXsQZhdb/6CJan1hcgMqhgdZZNKfe+R2F9T1mf27Ghs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170862; c=relaxed/simple;
	bh=XDDcgzKhI2dTDcjdlR7h9K2igzPn5BKfFGnKcmhcoXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nmh500HOc14arPe7PLi8HHbeqhdajwBw2jshamUEJXro3TqDhMsOwLSBlONM4O6kbGKJNnn+eB0Bv3sFBIeZP8udUiXjdui3i+5WEbGEeyUfyL1HtZ3wzNKZ1xZZcR38JR+5NoZlox1aJd4lc7tkrk+wv0O25ZGKDROYYoSpPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeb8xOcb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759170860; x=1790706860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XDDcgzKhI2dTDcjdlR7h9K2igzPn5BKfFGnKcmhcoXY=;
  b=jeb8xOcb+hLVbn00BMWvi06voZkE0//qbJFv8syDR26IxAW36m3bTtDE
   0st/xuCglzKEjJw3MXSaOluyRSWzR+dlT28StZea0PTuGsinsCAfmV9yh
   CVkmuay5ENCuBporemWmBor1VYcxuKAhyBmxfUBrsJ96GNEpSov++HAVf
   +ERKpjGb7GyeVpAz6MxIzdXwZwAdLKGBwKK2s/omugQ2oYOXIut74F1db
   Vq6q8kZg5my1hosGhhhbE0JRQnQBkoXbrAEqmMQDb5gN5nwn0ZU8DQh0F
   1zQlS91ubSq24EqI2h667kOlEMfeLePSZRIUS5zlxGXFomSOBT+0fXkj0
   Q==;
X-CSE-ConnectionGUID: CJXCrTd3S7izUH5WqN6rsg==
X-CSE-MsgGUID: vJ0GozJbSJGNz9q7uqyLNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61464917"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61464917"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 11:34:18 -0700
X-CSE-ConnectionGUID: t2KgBAOkTmqOZ1v/ocFanA==
X-CSE-MsgGUID: ZGx6KvdZRFahUtrZps0mDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="177874918"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.116]) ([10.125.109.116])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 11:34:17 -0700
Message-ID: <612f01e5-34f0-486a-ba7f-3a78870edb8e@intel.com>
Date: Mon, 29 Sep 2025 11:34:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/5] bnxt_fwctl: Add bnxt fwctl device
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
 michael.chan@broadcom.com
Cc: saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <20250927093930.552191-5-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250927093930.552191-5-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/25 2:39 AM, Pavan Chebbi wrote:
> Create bnxt_fwctl device. This will bind to bnxt's aux device.
> On the upper edge, it will register with the fwctl subsystem.
> It will make use of bnxt's ULP functions to send FW commands.
> 
> Also move 'bnxt_aux_priv' definition required by bnxt_fwctl
> from bnxt.h to ulp.h.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

just a minor comment below
> ---
>  MAINTAINERS                               |   6 +
>  drivers/fwctl/Kconfig                     |  11 +
>  drivers/fwctl/Makefile                    |   1 +
>  drivers/fwctl/bnxt/Makefile               |   4 +
>  drivers/fwctl/bnxt/main.c                 | 454 ++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   6 -
>  include/linux/bnxt/ulp.h                  |   8 +
>  include/uapi/fwctl/bnxt.h                 |  64 +++
>  include/uapi/fwctl/fwctl.h                |   1 +
>  9 files changed, 549 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/fwctl/bnxt/Makefile
>  create mode 100644 drivers/fwctl/bnxt/main.c
>  create mode 100644 include/uapi/fwctl/bnxt.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ba1e447f720..e30e600b23d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10120,6 +10120,12 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/fwctl/pds/
>  
> +FWCTL BNXT DRIVER
> +M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/bnxt/
> +
>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index b5583b12a011..203b6ebb06fc 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -29,5 +29,16 @@ config FWCTL_PDS
>  	  to access the debug and configuration information of the AMD/Pensando
>  	  DSC hardware family.
>  
> +	  If you don't know what to do here, say N.
> +
> +config FWCTL_BNXT
> +	tristate "bnxt control fwctl driver"
> +	depends on BNXT
> +	help
> +	  BNXT provides interface for the user process to access the debug and
> +	  configuration registers of the Broadcom NIC hardware family
> +	  This will allow configuration and debug tools to work out of the box on
> +	  mainstream kernel.
> +
>  	  If you don't know what to do here, say N.
>  endif
> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
> index c093b5f661d6..fdd46f3a0e4e 100644
> --- a/drivers/fwctl/Makefile
> +++ b/drivers/fwctl/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_FWCTL) += fwctl.o
>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>  obj-$(CONFIG_FWCTL_PDS) += pds/
> +obj-$(CONFIG_FWCTL_BNXT) += bnxt/
>  
>  fwctl-y += main.o
> diff --git a/drivers/fwctl/bnxt/Makefile b/drivers/fwctl/bnxt/Makefile
> new file mode 100644
> index 000000000000..b47172761f1e
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_FWCTL_BNXT) += bnxt_fwctl.o
> +
> +bnxt_fwctl-y += main.o
> diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
> new file mode 100644
> index 000000000000..397b85671bab
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/main.c
> @@ -0,0 +1,454 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/fwctl.h>
> +#include <uapi/fwctl/fwctl.h>
> +#include <uapi/fwctl/bnxt.h>
> +#include <linux/bnxt/hsi.h>
> +#include <linux/bnxt/ulp.h>
> +
> +struct bnxtctl_uctx {
> +	struct fwctl_uctx uctx;
> +	u32 uctx_caps;
> +};
> +
> +struct bnxtctl_dev {
> +	struct fwctl_device fwctl;
> +	struct bnxt_aux_priv *aux_priv;

> +	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
> +	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
I think these 2 don't need to be in bnxtctl_dev and can be temporary variables. Since they all get freed at the end of the function that uses it.

DJ


> +};
> +
> +DEFINE_FREE(bnxtctl, struct bnxtctl_dev *, if (_T) fwctl_put(&_T->fwctl))
> +
> +static int bnxtctl_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	struct bnxtctl_uctx *bnxtctl_uctx =
> +		container_of(uctx, struct bnxtctl_uctx, uctx);
> +
> +	bnxtctl_uctx->uctx_caps = BIT(FWCTL_BNXT_QUERY_COMMANDS) |
> +				  BIT(FWCTL_BNXT_SEND_COMMAND);
> +	return 0;
> +}
> +
> +static void bnxtctl_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *bnxtctl_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	struct bnxtctl_uctx *bnxtctl_uctx =
> +		container_of(uctx, struct bnxtctl_uctx, uctx);
> +	struct fwctl_info_bnxt *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->uctx_caps = bnxtctl_uctx->uctx_caps;
> +
> +	*length = sizeof(*info);
> +	return info;
> +}
> +
> +static bool bnxtctl_validate_rpc(struct bnxt_en_dev *edev,
> +				 struct bnxt_fw_msg *hwrm_in,
> +				 enum fwctl_rpc_scope scope)
> +{
> +	struct input *req = (struct input *)hwrm_in->msg;
> +
> +	guard(mutex)(&edev->en_dev_lock);
> +	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
> +		return false;
> +
> +	switch (le16_to_cpu(req->req_type)) {
> +	case HWRM_FUNC_VF_CFG:
> +	case HWRM_FUNC_RESET:
> +	case HWRM_FUNC_CFG:
> +	case HWRM_PORT_PHY_CFG:
> +	case HWRM_PORT_MAC_CFG:
> +	case HWRM_PORT_CLR_STATS:
> +	case HWRM_QUEUE_PRI2COS_CFG:
> +	case HWRM_QUEUE_COS2BW_CFG:
> +	case HWRM_QUEUE_DSCP2PRI_CFG:
> +	case HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG:
> +	case HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG:
> +	case HWRM_QUEUE_ADPTV_QOS_RX_TUNING_CFG:
> +	case HWRM_VNIC_RSS_CFG:
> +	case HWRM_TUNNEL_DST_PORT_ALLOC:
> +	case HWRM_TUNNEL_DST_PORT_FREE:
> +	case HWRM_QUEUE_ADPTV_QOS_TX_TUNING_CFG:
> +	case HWRM_PORT_TX_FIR_CFG:
> +	case HWRM_FW_SET_STRUCTURED_DATA:
> +	case HWRM_PORT_PRBS_TEST:
> +	case HWRM_PORT_EP_TX_CFG:
> +	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_INFO:
> +	case HWRM_CFA_FLOW_FLUSH:
> +	case HWRM_CFA_L2_FILTER_ALLOC:
> +	case HWRM_CFA_NTUPLE_FILTER_FREE:
> +	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_ALLOC:
> +	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_FREE:
> +	case HWRM_FW_LIVEPATCH:
> +	case HWRM_FW_RESET:
> +	case HWRM_FW_SYNC:
> +	case HWRM_FW_SET_TIME:
> +	case HWRM_PORT_CFG:
> +	case HWRM_FUNC_PTP_PIN_CFG:
> +	case HWRM_FUNC_PTP_CFG:
> +	case HWRM_FUNC_PTP_EXT_CFG:
> +	case HWRM_FUNC_SYNCE_CFG:
> +	case HWRM_MFG_OTP_CFG:
> +	case HWRM_MFG_TESTS:
> +	case HWRM_UDCC_CFG:
> +	case HWRM_DBG_SERDES_TEST:
> +	case HWRM_DBG_LOG_BUFFER_FLUSH:
> +	case HWRM_DBG_DUMP:
> +	case HWRM_DBG_ERASE_NVM:
> +	case HWRM_DBG_CFG:
> +	case HWRM_DBG_COREDUMP_LIST:
> +	case HWRM_DBG_COREDUMP_INITIATE:
> +	case HWRM_DBG_COREDUMP_RETRIEVE:
> +	case HWRM_DBG_CRASHDUMP_HEADER:
> +	case HWRM_DBG_CRASHDUMP_ERASE:
> +	case HWRM_DBG_PTRACE:
> +	case HWRM_DBG_TOKEN_CFG:
> +	case HWRM_NVM_DEFRAG:
> +	case HWRM_NVM_FACTORY_DEFAULTS:
> +	case HWRM_NVM_FLUSH:
> +	case HWRM_NVM_INSTALL_UPDATE:
> +	case HWRM_NVM_MODIFY:
> +	case HWRM_NVM_VERIFY_UPDATE:
> +	case HWRM_NVM_ERASE_DIR_ENTRY:
> +	case HWRM_NVM_MOD_DIR_ENTRY:
> +	case HWRM_NVM_FIND_DIR_ENTRY:
> +	case HWRM_NVM_RAW_DUMP:
> +		return scope >= FWCTL_RPC_CONFIGURATION;
> +
> +	case HWRM_VER_GET:
> +	case HWRM_FW_GET_STRUCTURED_DATA:
> +	case HWRM_ERROR_RECOVERY_QCFG:
> +	case HWRM_FUNC_QCAPS:
> +	case HWRM_FUNC_QCFG:
> +	case HWRM_FUNC_QSTATS:
> +	case HWRM_PORT_QSTATS:
> +	case HWRM_PORT_PHY_QCFG:
> +	case HWRM_PORT_MAC_QCFG:
> +	case HWRM_PORT_PHY_QCAPS:
> +	case HWRM_PORT_PHY_I2C_READ:
> +	case HWRM_PORT_PHY_MDIO_READ:
> +	case HWRM_QUEUE_PRI2COS_QCFG:
> +	case HWRM_QUEUE_COS2BW_QCFG:
> +	case HWRM_QUEUE_DSCP2PRI_QCFG:
> +	case HWRM_VNIC_RSS_QCFG:
> +	case HWRM_QUEUE_GLOBAL_QCFG:
> +	case HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_QCFG:
> +	case HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG:
> +	case HWRM_QUEUE_QCAPS:
> +	case HWRM_QUEUE_ADPTV_QOS_RX_TUNING_QCFG:
> +	case HWRM_QUEUE_ADPTV_QOS_TX_TUNING_QCFG:
> +	case HWRM_TUNNEL_DST_PORT_QUERY:
> +	case HWRM_PORT_QSTATS_EXT:
> +	case HWRM_PORT_TX_FIR_QCFG:
> +	case HWRM_FW_LIVEPATCH_QUERY:
> +	case HWRM_FW_QSTATUS:
> +	case HWRM_FW_HEALTH_CHECK:
> +	case HWRM_FW_GET_TIME:
> +	case HWRM_PORT_DSC_DUMP:
> +	case HWRM_PORT_EP_TX_QCFG:
> +	case HWRM_PORT_QCFG:
> +	case HWRM_PORT_MAC_QCAPS:
> +	case HWRM_TEMP_MONITOR_QUERY:
> +	case HWRM_REG_POWER_QUERY:
> +	case HWRM_CORE_FREQUENCY_QUERY:
> +	case HWRM_STAT_QUERY_ROCE_STATS:
> +	case HWRM_STAT_QUERY_ROCE_STATS_EXT:
> +	case HWRM_CFA_REDIRECT_QUERY_TUNNEL_TYPE:
> +	case HWRM_CFA_FLOW_INFO:
> +	case HWRM_CFA_ADV_FLOW_MGNT_QCAPS:
> +	case HWRM_FUNC_RESOURCE_QCAPS:
> +	case HWRM_FUNC_BACKING_STORE_QCAPS:
> +	case HWRM_FUNC_BACKING_STORE_QCFG:
> +	case HWRM_FUNC_QSTATS_EXT:
> +	case HWRM_FUNC_PTP_PIN_QCFG:
> +	case HWRM_FUNC_PTP_EXT_QCFG:
> +	case HWRM_FUNC_BACKING_STORE_QCFG_V2:
> +	case HWRM_FUNC_BACKING_STORE_QCAPS_V2:
> +	case HWRM_FUNC_SYNCE_QCFG:
> +	case HWRM_FUNC_TTX_PACING_RATE_PROF_QUERY:
> +	case HWRM_PCIE_QSTATS:
> +	case HWRM_MFG_OTP_QCFG:
> +	case HWRM_MFG_FRU_EEPROM_READ:
> +	case HWRM_MFG_GET_NVM_MEASUREMENT:
> +	case HWRM_STAT_GENERIC_QSTATS:
> +	case HWRM_PORT_PHY_FDRSTAT:
> +	case HWRM_UDCC_QCAPS:
> +	case HWRM_UDCC_QCFG:
> +	case HWRM_UDCC_SESSION_QCFG:
> +	case HWRM_UDCC_SESSION_QUERY:
> +	case HWRM_UDCC_COMP_QCFG:
> +	case HWRM_UDCC_COMP_QUERY:
> +	case HWRM_QUEUE_ADPTV_QOS_RX_QCFG:
> +	case HWRM_QUEUE_ADPTV_QOS_TX_QCFG:
> +	case HWRM_TF_RESC_USAGE_QUERY:
> +	case HWRM_TFC_RESC_USAGE_QUERY:
> +	case HWRM_DBG_READ_DIRECT:
> +	case HWRM_DBG_READ_INDIRECT:
> +	case HWRM_DBG_RING_INFO_GET:
> +	case HWRM_DBG_QCAPS:
> +	case HWRM_DBG_QCFG:
> +	case HWRM_DBG_USEQ_FLUSH:
> +	case HWRM_DBG_USEQ_QCAPS:
> +	case HWRM_DBG_SIM_CABLE_STATE:
> +	case HWRM_DBG_TOKEN_QUERY_AUTH_IDS:
> +	case HWRM_NVM_GET_VARIABLE:
> +	case HWRM_NVM_GET_DEV_INFO:
> +	case HWRM_NVM_GET_DIR_ENTRIES:
> +	case HWRM_NVM_GET_DIR_INFO:
> +	case HWRM_NVM_READ:
> +	case HWRM_SELFTEST_QLIST:
> +	case HWRM_SELFTEST_RETRIEVE_SERDES_DATA:
> +		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
> +
> +	case HWRM_PORT_PHY_I2C_WRITE:
> +	case HWRM_MFG_FRU_WRITE_CONTROL:
> +	case HWRM_MFG_FRU_EEPROM_WRITE:
> +	case HWRM_DBG_WRITE_DIRECT:
> +	case HWRM_NVM_SET_VARIABLE:
> +	case HWRM_NVM_WRITE:
> +	case HWRM_NVM_RAW_WRITE_BLK:
> +	case HWRM_PORT_PHY_MDIO_WRITE:
> +		return scope >= FWCTL_RPC_DEBUG_WRITE;
> +
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
> +				   struct device *dev,
> +				   int num_dma,
> +				   struct fwctl_dma_info_bnxt *msg,
> +				   struct bnxt_fw_msg *fw_msg)
> +{
> +	u8 i, num_allocated = 0;
> +	void *dma_ptr;
> +	int rc = 0;
> +
> +	for (i = 0; i < num_dma; i++) {
> +		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
> +								msg->len,
> +								&bnxt_dev->dma_addr[i],
> +								GFP_KERNEL);
> +		if (!bnxt_dev->dma_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +		num_allocated++;
> +		if (msg->dma_direction == DEVICE_WRITE) {
> +			if (copy_from_user(bnxt_dev->dma_virt_addr[i],
> +					   u64_to_user_ptr(msg->data),
> +					   msg->len)) {
> +				rc = -EFAULT;
> +				goto err;
> +			}
> +		}
> +		dma_ptr = fw_msg->msg + msg->offset;
> +
> +		if ((PTR_ALIGN(dma_ptr, 8) == dma_ptr) &&
> +		    msg->offset < fw_msg->msg_len) {
> +			__le64 *dmap = dma_ptr;
> +
> +			*dmap = cpu_to_le64(bnxt_dev->dma_addr[i]);
> +		} else {
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +		msg += 1;
> +	}
> +
> +	return 0;
> +err:
> +	for (i = 0; i < num_allocated; i++)
> +		dma_free_coherent(dev->parent,
> +				  msg->len,
> +				  bnxt_dev->dma_virt_addr[i],
> +				  bnxt_dev->dma_addr[i]);
> +
> +	return rc;
> +}
> +
> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
> +			    enum fwctl_rpc_scope scope,
> +			    void *in, size_t in_len, size_t *out_len)
> +{
> +	struct bnxtctl_dev *bnxtctl =
> +		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
> +	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
> +	struct fwctl_dma_info_bnxt *dma_buf = NULL;
> +	struct device *dev = &uctx->fwctl->dev;
> +	struct fwctl_rpc_bnxt *msg = in;
> +	struct bnxt_fw_msg rpc_in;
> +	int i, rc, err = 0;
> +
> +	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
> +	if (!rpc_in.msg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
> +			   msg->req_len)) {
> +		dev_dbg(dev, "Failed to copy in_payload from user\n");
> +		err = -EFAULT;
> +		goto free_msg_out;
> +	}
> +
> +	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in, scope)) {
> +		err = -EPERM;
> +		goto free_msg_out;
> +	}
> +
> +	rpc_in.msg_len = msg->req_len;
> +	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
> +	if (!rpc_in.resp) {
> +		err = -ENOMEM;
> +		goto free_msg_out;
> +	}
> +
> +	rpc_in.resp_max_len = *out_len;
> +	if (!msg->timeout)
> +		rpc_in.timeout = DFLT_HWRM_CMD_TIMEOUT;
> +	else
> +		rpc_in.timeout = msg->timeout;
> +
> +	if (msg->num_dma) {
> +		if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
> +			dev_err(dev, "DMA buffers exceed the number supported\n");
> +			err = -EINVAL;
> +			goto free_msg_out;
> +		}
> +
> +		dma_buf = kcalloc(msg->num_dma, sizeof(*dma_buf), GFP_KERNEL);
> +		if (!dma_buf) {
> +			err = -ENOMEM;
> +			goto free_msg_out;
> +		}
> +
> +		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
> +				   msg->num_dma * sizeof(*dma_buf))) {
> +			dev_dbg(dev, "Failed to copy payload from user\n");
> +			err = -EFAULT;
> +			goto free_dmabuf_out;
> +		}
> +
> +		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
> +					     dma_buf, &rpc_in);
> +		if (rc) {
> +			err = -EIO;
> +			goto free_dmabuf_out;
> +		}
> +	}
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (rc) {
> +		err = -EIO;
> +		goto free_dma_out;
> +	}
> +
> +	for (i = 0; i < msg->num_dma; i++) {
> +		if (dma_buf[i].dma_direction == DEVICE_READ) {
> +			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
> +					 bnxtctl->dma_virt_addr[i],
> +					 dma_buf[i].len)) {
> +				dev_dbg(dev, "Failed to copy resp to user\n");
> +				err = -EFAULT;
> +				break;
> +			}
> +		}
> +	}
> +free_dma_out:
> +	for (i = 0; i < msg->num_dma; i++)
> +		dma_free_coherent(dev->parent, dma_buf[i].len,
> +				  bnxtctl->dma_virt_addr[i],
> +				  bnxtctl->dma_addr[i]);
> +free_dmabuf_out:
> +	kfree(dma_buf);
> +free_msg_out:
> +	kfree(rpc_in.msg);
> +
> +	if (err) {
> +		kfree(rpc_in.resp);
> +		return ERR_PTR(err);
> +	}
> +
> +	return rpc_in.resp;
> +}
> +
> +static const struct fwctl_ops bnxtctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_BNXT,
> +	.uctx_size = sizeof(struct bnxtctl_uctx),
> +	.open_uctx = bnxtctl_open_uctx,
> +	.close_uctx = bnxtctl_close_uctx,
> +	.info = bnxtctl_info,
> +	.fw_rpc = bnxtctl_fw_rpc,
> +};
> +
> +static int bnxtctl_probe(struct auxiliary_device *adev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct bnxt_aux_priv *aux_priv =
> +		container_of(adev, struct bnxt_aux_priv, aux_dev);
> +	struct bnxtctl_dev *bnxtctl __free(bnxtctl) =
> +		fwctl_alloc_device(&aux_priv->edev->pdev->dev, &bnxtctl_ops,
> +				   struct bnxtctl_dev, fwctl);
> +	int rc;
> +
> +	if (!bnxtctl)
> +		return -ENOMEM;
> +
> +	bnxtctl->aux_priv = aux_priv;
> +
> +	rc = fwctl_register(&bnxtctl->fwctl);
> +	if (rc)
> +		return rc;
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(bnxtctl));
> +	return 0;
> +}
> +
> +static void bnxtctl_remove(struct auxiliary_device *adev)
> +{
> +	struct bnxtctl_dev *ctldev = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&ctldev->fwctl);
> +	fwctl_put(&ctldev->fwctl);
> +}
> +
> +static const struct auxiliary_device_id bnxtctl_id_table[] = {
> +	{ .name = "bnxt_en.fwctl", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
> +
> +static struct auxiliary_driver bnxtctl_driver = {
> +	.name = "bnxt_fwctl",
> +	.probe = bnxtctl_probe,
> +	.remove = bnxtctl_remove,
> +	.id_table = bnxtctl_id_table,
> +};
> +
> +module_auxiliary_driver(bnxtctl_driver);
> +
> +MODULE_IMPORT_NS("FWCTL");
> +MODULE_DESCRIPTION("BNXT fwctl driver");
> +MODULE_AUTHOR("Pavan Chebbi <pavan.chebbi@broadcom.com>");
> +MODULE_AUTHOR("Andy Gospodarek <gospo@broadcom.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index ea1d10c50da6..a7bca802a3e7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2075,12 +2075,6 @@ struct bnxt_fw_health {
>  #define BNXT_FW_IF_RETRY		10
>  #define BNXT_FW_SLOT_RESET_RETRY	4
>  
> -struct bnxt_aux_priv {
> -	struct auxiliary_device aux_dev;
> -	struct bnxt_en_dev *edev;
> -	int id;
> -};
> -
>  enum board_idx {
>  	BCM57301,
>  	BCM57302,
> diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
> index b1ec40cf00fa..df06f1bd210a 100644
> --- a/include/linux/bnxt/ulp.h
> +++ b/include/linux/bnxt/ulp.h
> @@ -10,6 +10,8 @@
>  #ifndef BNXT_ULP_H
>  #define BNXT_ULP_H
>  
> +#include <linux/auxiliary_bus.h>
> +
>  #define BNXT_MIN_ROCE_CP_RINGS	2
>  #define BNXT_MIN_ROCE_STAT_CTXS	1
>  
> @@ -26,6 +28,12 @@ enum bnxt_ulp_auxdev_type {
>  	__BNXT_AUXDEV_MAX
>  };
>  
> +struct bnxt_aux_priv {
> +	struct auxiliary_device aux_dev;
> +	struct bnxt_en_dev *edev;
> +	int id;
> +};
> +
>  struct bnxt_msix_entry {
>  	u32	vector;
>  	u32	ring_idx;
> diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
> new file mode 100644
> index 000000000000..a4686a45eb35
> --- /dev/null
> +++ b/include/uapi/fwctl/bnxt.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + */
> +
> +#ifndef _UAPI_FWCTL_BNXT_H_
> +#define _UAPI_FWCTL_BNXT_H_
> +
> +#include <linux/types.h>
> +
> +#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
> +#define DFLT_HWRM_CMD_TIMEOUT		500
> +#define DEVICE_WRITE			0
> +#define DEVICE_READ			1
> +
> +enum fwctl_bnxt_commands {
> +	FWCTL_BNXT_QUERY_COMMANDS = 0,
> +	FWCTL_BNXT_SEND_COMMAND
> +};
> +
> +/**
> + * struct fwctl_info_bnxt - ioctl(FWCTL_INFO) out_device_data
> + * @uctx_caps: The command capabilities driver accepts.
> + *
> + * Return basic information about the FW interface available.
> + */
> +struct fwctl_info_bnxt {
> +	__u32 uctx_caps;
> +};
> +
> +#define MAX_NUM_DMA_INDICATIONS 10
> +
> +/**
> + * struct fwctl_dma_info_bnxt - describe the buffer that should be DMAed
> + * @data: DMA-intended buffer
> + * @len: length of the @data
> + * @offset: offset at which FW (HWRM) input structure needs DMA address
> + * @dma_direction: DMA direction, DEVICE_READ or DEVICE_WRITE
> + * @unused: pad
> + */
> +struct fwctl_dma_info_bnxt {
> +	__aligned_u64 data;
> +	__u32 len;
> +	__u16 offset;
> +	__u8 dma_direction;
> +	__u8 unused;
> +};
> +
> +/**
> + * struct fwctl_rpc_bnxt - describe the fwctl message for bnxt
> + * @req: FW (HWRM) command input structure
> + * @req_len: length of @req
> + * @timeout: if the user wants to override the driver's default, 0 otherwise
> + * @num_dma: number of DMA buffers to be added to @req
> + * @payload: DMA buffer details in struct fwctl_dma_info_bnxt format
> + */
> +struct fwctl_rpc_bnxt {
> +	__aligned_u64 req;
> +	__u32 req_len;
> +	__u32 timeout;
> +	__u32 num_dma;
> +	__aligned_u64 payload;
> +};
> +#endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 716ac0eee42d..2d6d4049c205 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -44,6 +44,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
>  	FWCTL_DEVICE_TYPE_CXL = 2,
> +	FWCTL_DEVICE_TYPE_BNXT = 3,
>  	FWCTL_DEVICE_TYPE_PDS = 4,
>  };
>  


