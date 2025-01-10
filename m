Return-Path: <netdev+bounces-156979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E748AA08842
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 07:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6DB169968
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 06:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695217995E;
	Fri, 10 Jan 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYPyS4jN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A74746E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736490012; cv=none; b=dc1aIFV0qpu73z8nfpAAbUNsMSoMcofZ+ffrfdzGYmjj2Fs68MhDJUyWVrxUV9VFWYQu0gTEzk8SPF3Nl7VrKQqI8wNRdwp9fgpoDrPnDLsI13aRtre3eMp/9rD+3lRVJKLt/DeMIGz6ksrQyaZNBd6YmSfcjjyaIuQYRP+uSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736490012; c=relaxed/simple;
	bh=d+iczIA/3qhgm3rY/0ZRklAAWgGDOIEmhGBT6C6iVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6+N1gItZRw/3cAqTwF9ygeX4kOnVgKdb5UhLgVVPTDJJ4Ow+gBI1PsBZ4vOLcxp/6cXwBWP8+NzilVkrE3uJ/rb/LF0dgX4UFyr7DlBmUkDgGZLnc6Vzz3qZEyInGVdudv/FK25VostmjKiXdZGvAIJQzGjk+vykHvVtp4wazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYPyS4jN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736490011; x=1768026011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d+iczIA/3qhgm3rY/0ZRklAAWgGDOIEmhGBT6C6iVpU=;
  b=KYPyS4jNBT6FpyhFh/mBP6CvWKk9rqerFOLkiubTWh/uc3vmndWQPiU8
   QWiP5qsXd1t48sd+J2yEuD2E+DdsV5hspB7ZYaT1UqODV1hSpavddrogC
   5TEtfRb6DUZMMb66Du9I/GkP/cOLYdnVsmJHjwm9hXA3Ing/1aXSBpiiN
   COVXnMMZe/FqqkfmjQ2kE3oerWLhHKClWbxuxONeCo2jhVrG7Pmwu0DJ9
   mKx2byf7NE6oU7YuzzGosFNzhsKrtMbsvTjcHWvxAZ4un2MUpxs/Lm6MT
   KR1lWVrAiq0en3TMJQV8fujqNnnnCOomIe/zc8wsjTJJb3+hG10g3SacQ
   Q==;
X-CSE-ConnectionGUID: P+PnbDfmTdaRIR8X+TDpEQ==
X-CSE-MsgGUID: WgObwAxjRDGRfrrj83fjbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="24379023"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="24379023"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 22:20:10 -0800
X-CSE-ConnectionGUID: cO9FtB0KT6q0Sb2kRZsdwg==
X-CSE-MsgGUID: PvsU/WNOR3635yKYYqPMzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108748076"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 22:20:08 -0800
Date: Fri, 10 Jan 2025 07:16:50 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, almasrymina@google.com
Subject: Re: [PATCH net-next] net: warn during dump if NAPI list is not sorted
Message-ID: <Z4C7Un9FoSGZ5q98@mev-dev.igk.intel.com>
References: <20250110004505.3210140-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110004505.3210140-1-kuba@kernel.org>

On Thu, Jan 09, 2025 at 04:45:04PM -0800, Jakub Kicinski wrote:
> Dump continuation depends on the NAPI list being sorted.
> Broken netlink dump continuation may be rare and hard to debug
> so add a warning if we notice the potential problem while walking
> the list.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is really a follow up to commit d6c7b03497ee ("net: make sure
> we retain NAPI ordering on netdev->napi_list") but I had to wait
> for some fixes to make it to net-next.
> 
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> ---
>  net/core/netdev-genl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a3bdaf075b6b..c59619a2ec23 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -263,14 +263,21 @@ netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
>  			struct netdev_nl_dump_ctx *ctx)
>  {
>  	struct napi_struct *napi;
> +	unsigned int prev_id;
>  	int err = 0;
>  
>  	if (!(netdev->flags & IFF_UP))
>  		return err;
>  
> +	prev_id = UINT_MAX;
>  	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
>  		if (napi->napi_id < MIN_NAPI_ID)
>  			continue;
> +
> +		/* Dump continuation below depends on the list being sorted */
> +		WARN_ON_ONCE(napi->napi_id >= prev_id);
> +		prev_id = napi->napi_id;
> +
>  		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
>  			continue;
>  

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.1

