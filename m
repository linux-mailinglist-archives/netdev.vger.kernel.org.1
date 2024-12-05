Return-Path: <netdev+bounces-149264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C989D9E4F86
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CAE1881E56
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC161D2F74;
	Thu,  5 Dec 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWWg2GgK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FCE1D319B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386567; cv=none; b=qYk3XzwxDMVSIhPeoad4BUFikCurqFHGb+5V58RDJR69v521ykYqvCMfpYfQagbJwVkk1n9xgWmRT24MgcCJMy5XFJlQxqOd8kx49gJA7eEwFIcNpIKWUsrvbKxuuT3PikzzHOjqGsIF1QQ+S2IBazUGp6QO2J/IXTi3y2C+hmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386567; c=relaxed/simple;
	bh=wJVRynATt9SezT5NTDUa9wdE/k8rEVIgtN2J+FJGoSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTsIyvfADtgQwuuu2kCcPtoXkDZygN2kMOvJhWxr6chbu2l/hay8/TcLyK3odyKz7ubcpLeJR8SUB9WAcyUr0fHEfxsgwrsXDrFHAMFAp0dSbgPu/VvYoBxFcfcAfxui8WiKvwcFComlcbpTB7aYDMrF1+C1eZpeQs4FM9kayX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWWg2GgK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733386566; x=1764922566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wJVRynATt9SezT5NTDUa9wdE/k8rEVIgtN2J+FJGoSc=;
  b=XWWg2GgKtNyJ+T+5Whln3P+QwQuQvFd2npYW9nb9xAsWtZ/3rJgh/QkK
   CcfG8mvLy7M5ANUAH8s/mJu8BP5lJFjiO/b11xH4aRcBiy5aVDUugKrcf
   H5ueL1V0QzpJjUlBppGtwWY0KRp0jQPRmurmQtI1fCpIiWR3Prf/etol1
   7+53mqv8JHh7VNO/v1DRXqMGyxFrpZPnJ+d4S8zWJ4pPfCDPPM5TeFReg
   /ojMu8HTaVb7kQgKlgxRYz5sCgJ+2fOhCBEMTw8t996N+Gaql/zNy///u
   BUA4G92E6md9vX+gpbNwXNOTe8h9SWEdxMkwP7t42bqwq1wdl360bHl58
   w==;
X-CSE-ConnectionGUID: ilqASUQFQ5OHdY+1qQ8AGw==
X-CSE-MsgGUID: mtMmNCh5QVyR47USPxwqmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="36523105"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="36523105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:16:05 -0800
X-CSE-ConnectionGUID: JyIM/DHlR9ePZEEZy3fzgQ==
X-CSE-MsgGUID: f0VWH+FER2+eO5EcHT2XLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99061057"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:16:04 -0800
Date: Thu, 5 Dec 2024 09:13:06 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net-next] cxgb4: add driver support for FW_CLIP2_CMD
Message-ID: <Z1FgkpNNbTVdPFhI@mev-dev.igk.intel.com>
References: <20241204135416.14041-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204135416.14041-1-anumula@chelsio.com>

On Wed, Dec 04, 2024 at 07:24:16PM +0530, Anumula Murali Mohan Reddy wrote:
> Query firmware for FW_CLIP2_CMD support and enable it. FW_CLIP2_CMD
> will be used for setting LIP mask for the corresponding entry in the
> CLIP table. If no LIP mask is specified, a default value of ~0 is
> written for mask.
> 
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c | 146 ++++++++++++++----
>  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h |   6 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   1 +
>  .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c |  23 ++-
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   3 +
>  drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |  12 ++
>  6 files changed, 152 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
> index 5060d3998889..8da9e7fe7f65 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
> @@ -18,6 +18,8 @@
>  #include "cxgb4.h"
>  #include "clip_tbl.h"
>  
> +static const u64 clip_ipv6_exact_mask[2] = { ~0, ~0 };
> +
>  static inline unsigned int ipv4_clip_hash(struct clip_tbl *c, const u32 *key)
>  {
>  	unsigned int clipt_size_half = c->clipt_size / 2;
> @@ -42,36 +44,73 @@ static unsigned int clip_addr_hash(struct clip_tbl *ctbl, const u32 *addr,
>  }
>  
>  static int clip6_get_mbox(const struct net_device *dev,
> -			  const struct in6_addr *lip)
> +			  const struct in6_addr *lip,
> +			  const struct in6_addr *lipm)
>  {
>  	struct adapter *adap = netdev2adap(dev);
> -	struct fw_clip_cmd c;
> +	struct fw_clip2_cmd c;
> +
> +	if (!adap->params.clip2_cmd_support) {
> +		struct fw_clip_cmd old_cmd;
> +
> +		memset(&old_cmd, 0, sizeof(old_cmd));
> +		old_cmd.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
> +					    FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
> +		old_cmd.alloc_to_len16 = htonl(FW_CLIP_CMD_ALLOC_F |
> +					       FW_LEN16(old_cmd));
> +		*(__be64 *)&old_cmd.ip_hi = *(__be64 *)(lip->s6_addr);
> +		*(__be64 *)&old_cmd.ip_lo = *(__be64 *)(lip->s6_addr + 8);
> +
> +		return t4_wr_mbox_meat(adap, adap->mbox, &old_cmd,
> +				       sizeof(old_cmd), &old_cmd, false);
> +	}
>  
>  	memset(&c, 0, sizeof(c));
> -	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
> +	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP2_CMD) |
>  			      FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
>  	c.alloc_to_len16 = htonl(FW_CLIP_CMD_ALLOC_F | FW_LEN16(c));
>  	*(__be64 *)&c.ip_hi = *(__be64 *)(lip->s6_addr);
>  	*(__be64 *)&c.ip_lo = *(__be64 *)(lip->s6_addr + 8);
> +	*(__be64 *)&c.ipm_hi = *(__be64 *)(lipm->s6_addr);
> +	*(__be64 *)&c.ipm_lo = *(__be64 *)(lipm->s6_addr + 8);
>  	return t4_wr_mbox_meat(adap, adap->mbox, &c, sizeof(c), &c, false);
>  }
>  
>  static int clip6_release_mbox(const struct net_device *dev,
> -			      const struct in6_addr *lip)
> +			      const struct in6_addr *lip,
> +			      const struct in6_addr *lipm)
>  {
>  	struct adapter *adap = netdev2adap(dev);
> -	struct fw_clip_cmd c;
> +	struct fw_clip2_cmd c;
> +
> +	if (!adap->params.clip2_cmd_support) {
> +		struct fw_clip_cmd old_cmd;
> +
> +		memset(&old_cmd, 0, sizeof(old_cmd));
> +		old_cmd.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
> +					    FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
> +		old_cmd.alloc_to_len16 = htonl(FW_CLIP_CMD_FREE_F |
> +					       FW_LEN16(old_cmd));
> +		*(__be64 *)&old_cmd.ip_hi = *(__be64 *)(lip->s6_addr);
> +		*(__be64 *)&old_cmd.ip_lo = *(__be64 *)(lip->s6_addr + 8);
> +
> +		return t4_wr_mbox_meat(adap, adap->mbox, &old_cmd,
> +				       sizeof(old_cmd), &old_cmd, false);
This block is similar to the block for old command in get_mbox, maybe
move to function:
olc_cmd_send(..., cmd_type)
{
	...
	old_cmd.alloc_to_len16 = htonl(cmd_type | FW_LEN16(old_cmd));
	...
}

To be honest the same can be done for whole release/get
clip6_get_mbox(...)
{
	clip6_mbox(..., ALLOC);
}

clip6_release_mbox(...)
{
	clip6_mbox(..., FREE);
}

You will safe some lines.

}
> +	}
>  
>  	memset(&c, 0, sizeof(c));
> -	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP_CMD) |
> -			      FW_CMD_REQUEST_F | FW_CMD_READ_F);
> +	c.op_to_write = htonl(FW_CMD_OP_V(FW_CLIP2_CMD) |
> +			      FW_CMD_REQUEST_F | FW_CMD_WRITE_F);
>  	c.alloc_to_len16 = htonl(FW_CLIP_CMD_FREE_F | FW_LEN16(c));
>  	*(__be64 *)&c.ip_hi = *(__be64 *)(lip->s6_addr);
>  	*(__be64 *)&c.ip_lo = *(__be64 *)(lip->s6_addr + 8);
> +	*(__be64 *)&c.ipm_hi = *(__be64 *)(lipm->s6_addr);
> +	*(__be64 *)&c.ipm_lo = *(__be64 *)(lipm->s6_addr + 8);
> +
>  	return t4_wr_mbox_meat(adap, adap->mbox, &c, sizeof(c), &c, false);
>  }
>  
>

[...]

> -- 
> 2.39.3

