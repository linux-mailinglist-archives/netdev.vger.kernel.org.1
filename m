Return-Path: <netdev+bounces-157619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8394A0B06D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B317A2472
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2C232786;
	Mon, 13 Jan 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuOe8ubG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E293C1F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755201; cv=none; b=YtLNVlCL8cw5ZfaaPkXR0WDIzw2BRCaKkl6Lh0mwgFe+lijrNXUToKVY5ZZW2TTKhBtWR2CEByyceFizyp09+IXSX6YLbTO4ryHfnCh/9d+m8srCOwv0wjOisNZ8Zq0ssrw4zkiClLExqhjxrcVvJgfP3V16xorWe6JQRkYftCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755201; c=relaxed/simple;
	bh=Aq7xA6EEXEtPwY6TNptpg0uD/b7YMBf0YvX+FfyGEYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwuo+MzAzT/gRtDgNbBEvJklefsro1EDuyS2Dkwi212jfn4te2MATMCoRbOlgvZthMBf2npvliHGS2zUHi1+uYO/03RAIik/KvBa+8SY3fe7ku4LS9RBbbnjyblclQxNfiZz7JsxtR3ng5XMRByVC/kNnJ5AcVLF4zljCQkkJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuOe8ubG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736755201; x=1768291201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aq7xA6EEXEtPwY6TNptpg0uD/b7YMBf0YvX+FfyGEYA=;
  b=QuOe8ubGqNI7F8KCVIfH5Yj8dZw/Ij9nJmHcNWN8kevn3PJG7B3atBMe
   Coxsbc4YpgP5MK3QJPo+gdQ7/ss5fKlhMD1it6cTLOV56phosK5WTF9wb
   xIJJJLf5ARnlkj94av480LjlWJ/8M0xXPBFWqqyTuedfQxQResFDbiqyo
   91XG1JDGlqJBEZqhBKHzKyMkLO1n55KYm1LuTr3wmysEZqa45i+dinvhe
   hw4wo4cV6G9vt18IXergUUxtGvm5qSgTSeZRq+Bm9CRMeaYybrUeI4ZHo
   dKS8sVDsvZjitHaFl/F2hjV57K65PdwPU6ofdz9TiBfBnGDs7YaHEWr7u
   g==;
X-CSE-ConnectionGUID: dP6KnHCjQRaJLzWT1sw6Hw==
X-CSE-MsgGUID: bYsEru8wRYu38oYAe+aL7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="36883742"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36883742"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:00:00 -0800
X-CSE-ConnectionGUID: HGbiKzS9T7+JoiARtOM7Pg==
X-CSE-MsgGUID: hVIl4MRnQIuni5ndXk41LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104190238"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 23:59:57 -0800
Date: Mon, 13 Jan 2025 08:56:39 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com
Subject: Re: [PATCH net-next 01/10] bnxt_en: Set NAPR 1.2 support when
 registering with firmware
Message-ID: <Z4THNzvTUecR8QUp@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-2-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:18PM -0800, Michael Chan wrote:
> NPAR 1.2 adds a transparent VLAN tag for all packets between the NIC
> and the switch.  Because of that, RX VLAN acceleration cannot be
> supported for any additional host configured VLANs.  The driver has
> to acknowledge that it can support no RX VLAN acceleration and
> set the NPAR 1.2 supported flag when registering with the FW.
> Otherwise, the FW call will fail and the driver will abort on these
> NPAR 1.2 NICs with this error:
> 
> bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 884d42db5554..8527788bed91 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5537,6 +5537,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
>  	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
>  		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
>  			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
> +	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
> +		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
>  	req->flags = cpu_to_le32(flags);
>  	req->ver_maj_8b = DRV_VER_MAJ;
>  	req->ver_min_8b = DRV_VER_MIN;
> @@ -8338,6 +8340,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
>  
>  	switch (resp->port_partition_type) {
>  	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
> +	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
>  	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
>  	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
>  		bp->port_partition_type = resp->port_partition_type;
> @@ -9502,6 +9505,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
>  		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
>  	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
>  		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
> +	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
> +		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
>  	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
>  		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
>  	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 094c9e95b463..a634ad76177d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2488,6 +2488,7 @@ struct bnxt {
>  	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
>  	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
>  	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
> +	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
>  
>  	u32			fw_dbg_cap;
>  
> -- 
> 2.30.1

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

