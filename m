Return-Path: <netdev+bounces-15514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E574828A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF89280FD0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBD53BA;
	Wed,  5 Jul 2023 10:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144BF4A11
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 10:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C02C433C8;
	Wed,  5 Jul 2023 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688554310;
	bh=j1PRxiA3cbBtv82P0AXnECISX+jSkREEWP8RwdooE+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6yxnjU8VDYuxH6xc3n4fjR+UuqhZdEXp9TM6actgmcc2VurAGPpUA1h1co1VD3iY
	 +CEz0YGVzCfbEIVD07kHsff1tmdERyJPiqS5Wsz4/HUlyKwMhW8EYdpt8gRMJpOlJZ
	 +FAwdIEABGw/6pvPKcd47ySUgiycOwL5yLCSHeRLKdPdrXJ2+W7BnnmR7drEgv2/fu
	 NpBTgpkkB5hsFawg5uadE54c3qJBchG5DirPSEPh6dr8Qx5LUgy3Lf9l8smqWUPRqn
	 jf9t3A8B3UKhCy26XOtM6RrN/U3qgf15Rsv7iSYr6yrWao59YQxooNcJ75BwQU3Rg0
	 9qHtfFuQx1vjA==
Date: Wed, 5 Jul 2023 13:51:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Minjie Du <duminjie@vivo.com>
Cc: Markus.Elfring@web.de, Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:QLOGIC QL4xxx ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] qed: Remove a duplicate assignment in
 qed_rdma_create_srq()
Message-ID: <20230705105146.GN6455@unreal>
References: <20230705103547.15072-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705103547.15072-1-duminjie@vivo.com>

On Wed, Jul 05, 2023 at 06:35:46PM +0800, Minjie Du wrote:
> Delete a duplicate statement from this function implementation.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 1 -
>  1 file changed, 1 deletion(-)

This patch should be resubmitted after merge window ends.

Please specify net-next target in patch subject and add changelog
that describes the differences between versions.

Thanks

> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> index 5a5dbbb8d..41efced49 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> @@ -1795,7 +1795,6 @@ qed_rdma_create_srq(void *rdma_cxt,
>  
>  	opaque_fid = p_hwfn->hw_info.opaque_fid;
>  
> -	opaque_fid = p_hwfn->hw_info.opaque_fid;
>  	init_data.opaque_fid = opaque_fid;
>  	init_data.comp_mode = QED_SPQ_MODE_EBLOCK;
>  
> -- 
> 2.39.0
> 
> 

