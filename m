Return-Path: <netdev+bounces-212879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D706B225A7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541911B61F42
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E12ECEAC;
	Tue, 12 Aug 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBEWeRsd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A72ECD3C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997232; cv=none; b=vCfmPa9gNxXC8/uUex444cI6F2btlWxDXtFeGpVGFkmAUxO0sexgprQQyFZkTFnDQi9yAC5TgiNQOvvDlOVlYQPcZdkNEG5BFpcdTJv/ikd0A4k7pc5917B71tdWvU6u9agUyx4XlT0u05HmF3I9k5XiaIOZwfaRGXwyqZ4CZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997232; c=relaxed/simple;
	bh=UqsT07mVCynfMANd1c7qEyPk2QXTT3/sL5OPyThV6Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAqb5J7qFq1yH1KWHieZh7b4bkDaUe7LRiEaYo6WnAOTq29BIxnsJyvoiI3FbZ087Z0qglE/sAEtg2zHNLV8ECVd36kyZ0Pf6rt/QbWpBXjGNul6sRQxKEWMFZBmVRHhlQdaqlgRNlWS+ohI5D8/wGQjcJgl3qxnLHSHlcTjLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBEWeRsd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754997230; x=1786533230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UqsT07mVCynfMANd1c7qEyPk2QXTT3/sL5OPyThV6Yo=;
  b=ZBEWeRsdXz3C1RjhvElF85OXmU9FiTa0OlLvcx9Sd+XjzX7tHRmVZtl9
   pJsmobZBWZwmRMHw3vKR/hZNe6BHykp6mNhHhr7aiY902HURgOqR2pbq2
   ISk2vUCmixIl68B6w8o9J6ICZFhi9KG7+fSn1Je4cdMiplyN40GcqhODw
   W/sfDgDFA1+gSss+RFCWzRFU8bUV7+bmlTnYvmNTruzSij7tn3oMulFrT
   Iq4L6XbYhMPXSRKlhCsWhYSjaM/+UjAWBCw18uiRygz6hD8qmMPi5jCym
   yym/8YXDLhh+74+t9WRL/qI5WEFFgjLeJKI0dtWtEL8ZxYtzklVfsuX0v
   g==;
X-CSE-ConnectionGUID: xXuvS9YuTqGU1rfwzamwaw==
X-CSE-MsgGUID: QTEeV+8GQ16TWGd1jyMRkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56478239"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56478239"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:13:49 -0700
X-CSE-ConnectionGUID: HzLpChaaSwiDjsf9FgioTA==
X-CSE-MsgGUID: 17+Ltc0ESgWcVZ8UgWfzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166532950"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:13:47 -0700
Date: Tue, 12 Aug 2025 13:12:26 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v4 3/4] net: wangxun: cleanup the code in
 wx_set_coalesce()
Message-ID: <aJshmpZhMSPBAGac@mev-dev.igk.intel.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
 <20250812015023.12876-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812015023.12876-4-jiawenwu@trustnetic.com>

On Tue, Aug 12, 2025 at 09:50:22AM +0800, Jiawen Wu wrote:
> Cleanup the code for the next patch to add adaptive coalesce.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 28 ++++++-------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 590a5901cf77..c7b3f5087b66 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -343,13 +343,19 @@ int wx_set_coalesce(struct net_device *netdev,
>  	switch (wx->mac.type) {
>  	case wx_mac_sp:
>  		max_eitr = WX_SP_MAX_EITR;
> +		rx_itr_param = WX_20K_ITR;
> +		tx_itr_param = WX_12K_ITR;
>  		break;
>  	case wx_mac_aml:
>  	case wx_mac_aml40:
>  		max_eitr = WX_AML_MAX_EITR;
> +		rx_itr_param = WX_20K_ITR;
> +		tx_itr_param = WX_12K_ITR;
>  		break;
>  	default:
>  		max_eitr = WX_EM_MAX_EITR;
> +		rx_itr_param = WX_7K_ITR;
> +		tx_itr_param = WX_7K_ITR;
>  		break;
>  	}
>  
> @@ -362,34 +368,16 @@ int wx_set_coalesce(struct net_device *netdev,
>  	else
>  		wx->rx_itr_setting = ec->rx_coalesce_usecs;
>  
> -	if (wx->rx_itr_setting == 1) {
> -		if (wx->mac.type == wx_mac_em)
> -			rx_itr_param = WX_7K_ITR;
> -		else
> -			rx_itr_param = WX_20K_ITR;
> -	} else {
> +	if (wx->rx_itr_setting != 1)
>  		rx_itr_param = wx->rx_itr_setting;
> -	}
>  
>  	if (ec->tx_coalesce_usecs > 1)
>  		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
>  	else
>  		wx->tx_itr_setting = ec->tx_coalesce_usecs;
>  
> -	if (wx->tx_itr_setting == 1) {
> -		switch (wx->mac.type) {
> -		case wx_mac_sp:
> -		case wx_mac_aml:
> -		case wx_mac_aml40:
> -			tx_itr_param = WX_12K_ITR;
> -			break;
> -		default:
> -			tx_itr_param = WX_7K_ITR;
> -			break;
> -		}
> -	} else {
> +	if (wx->tx_itr_setting != 1)
>  		tx_itr_param = wx->tx_itr_setting;
> -	}
>  
>  	/* mixed Rx/Tx */
>  	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)

LGTM
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.48.1

