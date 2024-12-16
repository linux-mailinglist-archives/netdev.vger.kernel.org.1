Return-Path: <netdev+bounces-152095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1269F2A92
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B963E1889166
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936EE1CDA0B;
	Mon, 16 Dec 2024 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFyjDtsT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E371CD215
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332371; cv=none; b=tPcd1A4XioEYxN5+Xws+c5aRZGEyNoahpvCDTMOseEZvr/MCmpAY8KCkM40hpGsk3Kn48mO0AXuQQ2kJZ6MXhSKanzIUH6jUdWoYr8TUWj9Pcw/3r6dMjnLMQokxKaLuh8QyO2i1NhVgOYm21O2QwVFMmA3W3XU0uJP46EAJmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332371; c=relaxed/simple;
	bh=COAz++7EG7iVLtE17ZARIH2N/yLvtQ6Xspz083PLET8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkCabepjfImdrMTjYbza0b2EUhS/LBt02GE+nUFQjbR3Y9zA5L+JV0NgnNY7kweRgGqWJKWamyOfyAQRXKmgg2m3e0GfEVh+Z2wJdacGIWT/qlUC8O9zpn+c+3Bdh+Rw3M8t+f7ML/I4tcQTV/68DUhBDRCH0RTDhVH9gMtfzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFyjDtsT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332370; x=1765868370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COAz++7EG7iVLtE17ZARIH2N/yLvtQ6Xspz083PLET8=;
  b=LFyjDtsTcdIalGJspChQSOFRJ+KUoE0ISNqXus/DKLPM/AEVtXODRoWu
   rPHhUfn9Y2EvIV4mcLOMschlZVnRY916Sd1NZIobcz9aTBZJ4Bqr+Jw8j
   iwATppwhjYP03lmqo4XWZ4qRUB3vvDnLVNKdpwhbbD8wSUOQsDXuFhO6q
   eVfb/Lwsg1w4Hqy6rWDnguol9fg1PBZYela/pvYJofR54u1kkduQCFCxR
   ANx0O0AyJfGN46EvDgBRx5bXV9DbgBu/eE7/64ZCXVpNpXIYr7DnJNf2z
   Lv8N+V8txouiwmNXq5Z3FZZqxyXW+8N3Y0DDU7DLpmqhsyC/rQgymS5j1
   A==;
X-CSE-ConnectionGUID: JZniRB9qR46GqHAQhmEkJQ==
X-CSE-MsgGUID: R73QdexjQOemUWjfWezCAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34583966"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34583966"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:59:29 -0800
X-CSE-ConnectionGUID: Xzm6SxfhTo6L8yPZpNroYg==
X-CSE-MsgGUID: lIPTKk1zTZ24OKlT84LF1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97017567"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:59:26 -0800
Date: Mon, 16 Dec 2024 07:56:22 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 4/6] bnxt_en: Skip MAC loopback selftest if it
 is unsupported by FW
Message-ID: <Z1/PFuPhm5cOGnAv@mev-dev.igk.intel.com>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
 <20241215205943.2341612-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215205943.2341612-5-michael.chan@broadcom.com>

On Sun, Dec 15, 2024 at 12:59:41PM -0800, Michael Chan wrote:
> Call the new HWRM_PORT_MAC_QCAPS to check if mac loopback is
> supported.  Skip the MAC loopback ethtool self test if it is
> not supported.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++++
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++++---
>  3 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 631dbda725ab..5a19146d6902 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11551,6 +11551,31 @@ static int bnxt_hwrm_phy_qcaps(struct bnxt *bp)
>  	return rc;
>  }
>  
> +static int bnxt_hwrm_mac_qcaps(struct bnxt *bp)
> +{
> +	struct hwrm_port_mac_qcaps_output *resp;
> +	struct hwrm_port_mac_qcaps_input *req;
> +	int rc;
> +
> +	if (bp->hwrm_spec_code < 0x10a03)
> +		return 0;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_QCAPS);
> +	if (rc)
> +		return rc;
> +
> +	resp = hwrm_req_hold(bp, req);
> +	rc = hwrm_req_send_silent(bp, req);
> +	if (rc)
> +		goto hwrm_mac_qcaps_exit;
> +
> +	bp->mac_flags = resp->flags;
> +
> +hwrm_mac_qcaps_exit:
> +	hwrm_req_drop(bp, req);
> +	return rc;
> +}
> +
>  static bool bnxt_support_dropped(u16 advertising, u16 supported)
>  {
>  	u16 diff = advertising ^ supported;
> @@ -15679,6 +15704,10 @@ static int bnxt_probe_phy(struct bnxt *bp, bool fw_dflt)
>  		bp->dev->priv_flags |= IFF_SUPP_NOFCS;
>  	else
>  		bp->dev->priv_flags &= ~IFF_SUPP_NOFCS;
> +
> +	bp->mac_flags = 0;
> +	bnxt_hwrm_mac_qcaps(bp);
The value returned from the function is ignored. Change it to return
void, or do sth here with returned value.

Thanks
> +
>  	if (!fw_dflt)
>  		return 0;
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index d5e81e008ab5..094c9e95b463 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2668,6 +2668,11 @@ struct bnxt {
>  #define BNXT_PHY_FL_BANK_SEL		(PORT_PHY_QCAPS_RESP_FLAGS2_BANK_ADDR_SUPPORTED << 8)
>  #define BNXT_PHY_FL_SPEEDS2		(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
>  
> +	/* copied from flags in hwrm_port_mac_qcaps_output */
> +	u8			mac_flags;
> +#define BNXT_MAC_FL_NO_MAC_LPBK		\
> +	PORT_MAC_QCAPS_RESP_FLAGS_LOCAL_LPBK_NOT_SUPPORTED
> +
>  	u8			num_tests;
>  	struct bnxt_test_info	*test_info;
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index e5904f2d56df..3bc2bd732021 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4896,21 +4896,24 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
>  		bnxt_close_nic(bp, true, false);
>  		bnxt_run_fw_tests(bp, test_mask, &test_results);
>  
> -		buf[BNXT_MACLPBK_TEST_IDX] = 1;
> -		bnxt_hwrm_mac_loopback(bp, true);
> -		msleep(250);
>  		rc = bnxt_half_open_nic(bp);
>  		if (rc) {
> -			bnxt_hwrm_mac_loopback(bp, false);
>  			etest->flags |= ETH_TEST_FL_FAILED;
>  			return;
>  		}
> +		buf[BNXT_MACLPBK_TEST_IDX] = 1;
> +		if (bp->mac_flags & BNXT_MAC_FL_NO_MAC_LPBK)
> +			goto skip_mac_loopback;
> +
> +		bnxt_hwrm_mac_loopback(bp, true);
> +		msleep(250);
>  		if (bnxt_run_loopback(bp))
>  			etest->flags |= ETH_TEST_FL_FAILED;
>  		else
>  			buf[BNXT_MACLPBK_TEST_IDX] = 0;
>  
>  		bnxt_hwrm_mac_loopback(bp, false);
> +skip_mac_loopback:
>  		buf[BNXT_PHYLPBK_TEST_IDX] = 1;
>  		if (bp->phy_flags & BNXT_PHY_FL_NO_PHY_LPBK)
>  			goto skip_phy_loopback;
> -- 
> 2.30.1

