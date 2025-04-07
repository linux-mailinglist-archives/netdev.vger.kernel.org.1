Return-Path: <netdev+bounces-179756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F50A7E720
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889BC188841D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FA20E70D;
	Mon,  7 Apr 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR1RFSB5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820691FBEAD;
	Mon,  7 Apr 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044146; cv=none; b=K58BgB6Y9UtfuZ7K4u0DNAmKO2Hmn5A6yYmZuqUGJ7MFsM4ZPtnu1OikGatrQ3iWb16ivUYp1+h8yckwWqjtGaMiPdGdkT+T9qFX5zzSo0a5sLzubFk8fizKW0Xbe1avUKwB/xO1H6BuuwXdYV/hBMDivG1lZW+3EHCnio0jsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044146; c=relaxed/simple;
	bh=WrQXXjBpiM94b86oVqkh0KjxV+FLNSgpsVk43vl3Tf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edUJGQ0m0rv9TT9loMTBzx7ZRMZcOHIc4/F2xdRlV/kp1m7SnRQwdlLwpdpj/lx9UdYJdsQGm3ce4vLu2xThxdoGbG8W+nOysFKMJfr/8O02+Jsa7vRXCR6VCqHJMTY6lsHbfr38OCLB0EbLX1dGmNrXWI4M+zDSj0FNPLHDSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR1RFSB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7458C4CEDD;
	Mon,  7 Apr 2025 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044146;
	bh=WrQXXjBpiM94b86oVqkh0KjxV+FLNSgpsVk43vl3Tf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kR1RFSB519J3NaTdfH64WZVjxAA0DmrzaSfvysqfhPHPSE8GD0zOJrG6or64tljvZ
	 iDeQjpZn/TNO6Dcf+21b5P2CcdosYJR3YJBjdikABzJG/foql1BWJWy+HhCjb5HG/e
	 tNfGfdWUpMgqPCFUukBimnl+VrAb4Pt+tLM4Nuuyv7rLkLVHePMjai+yOEMzHQRvbb
	 VbqIL7Ky+yiH3IdHqUzzwptRWSiqd5FWIIkbypA8igThHDh6+QQ5BBZbHmsA9yL8au
	 yb0jviDpLmVJTA5Q1MBPNx1mzTBVLxi1IMetrNcayeOeovwuc70f1YhCowg3G2xCia
	 ZUBy/sN9oKt+w==
Date: Mon, 7 Apr 2025 17:42:21 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: sbhatta@marvell.com, sgoutham@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] octeontx2-pf: Add error log
 forcn10k_map_unmap_rq_policer()
Message-ID: <20250407164221.GT395307@horms.kernel.org>
References: <20250407081118.1852-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407081118.1852-1-vulab@iscas.ac.cn>

On Mon, Apr 07, 2025 at 04:11:17PM +0800, Wentao Liang wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors.
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop, and report a warning if the function fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v3: Add failed queue number and error code to log.
> v2: Fix error code
> 
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..9113a9b90002 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -353,8 +353,10 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
>  
>  	/* Remove RQ's policer mapping */
>  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> -					   hw->matchall_ipolicer, false);
> +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> +		if (rc)
> +			dev_warn(pfvf->dev, "Failed to unmap RQ %d's policer (error %d).",
> +				 qidx, rc);
>  
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);

I think that you need brackets for the for loop now
that it covers more than one statement. Like this:

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index c3b6e0f60a79..7f6a435ac680 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -357,9 +357,12 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
 	mutex_lock(&pfvf->mbox.lock);
 
 	/* Remove RQ's policer mapping */
-	for (qidx = 0; qidx < hw->rx_queues; qidx++)
-		cn10k_map_unmap_rq_policer(pfvf, qidx,
-					   hw->matchall_ipolicer, false);
+	for (qidx = 0; qidx < hw->rx_queues; qidx++) {
+		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
+		if (rc)
+			dev_warn(pfvf->dev, "Failed to unmap RQ %d's policer (error %d).",
+				 qidx, rc);
+	}
 
 	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
 

Flagged by allmodconfig W=1 builds.

-- 
pw-bot: changes-requested

