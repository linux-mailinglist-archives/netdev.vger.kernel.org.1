Return-Path: <netdev+bounces-120527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3414959B4F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5124B1F22899
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C61514E2;
	Wed, 21 Aug 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEq/z59Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF31D1305;
	Wed, 21 Aug 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242249; cv=none; b=a8odLPhoaT35b1ypu10CfpdjxR8iE5KlAv6p85ZS8LXldwAv2Uw301+Whc8B+aNNuMxc2qfqD8uYtmDv/eEfCgzInwm5cIlye1Q0MVI2Dvh5uxJEjfKTC5dxEktr6Xh0NP+O8CFWCMSzVWJr7FY+As1NGLLt4pJYOVxknYuXn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242249; c=relaxed/simple;
	bh=nDrJHJu+gWDRrjhS6369DIMG9kViRlo3DMiwhc79e1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5mHpaunSOnVBAZ5GKuCrXjbWv7wB5gl6O9YBJ9FnApi9G2p1L3CHf1R0Tgv2alDKOjxrFCuM66YRU5cMofv7ucUuwSCRYtlKALrRJVrv03d6YtFcypRwYffvHgQ1Foser74wC4lDRW592lt0lNBNDARqHC59Pu3hSUcl3dioWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEq/z59Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08FAC32782;
	Wed, 21 Aug 2024 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724242248;
	bh=nDrJHJu+gWDRrjhS6369DIMG9kViRlo3DMiwhc79e1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dEq/z59YAORG5PxknZdx4N8Cqs5VqWj4TpHflRigc30LMuWj81P1QZB1COTZ8FOaV
	 Z4TknFgdk4N/oxlyXNYs58734LLu6DiE+LNHgK4CQ0YvxFd3PHnk2ibjjLQBCwJ3RS
	 mPOpBUG9VLiwUNknPY37K5+Uu4GACT6XzSOjWHVi6b79sqiPj5Rhm8g7+w+s8APjhe
	 iafpHUpMsJGCWBBTXHvxnGHgiKDORymOUjm0cgY7meyXc/bsZYjTZJcs2C0CLuxgv4
	 rQZNRcSGPXphlDFD4L6bfuuPCXJZhk39rH6+loyM6E7UtNdwSe1fmkRLXQzIfW7GmW
	 TxQIsfUOrmcYQ==
Message-ID: <aa3d740f-403e-4bd3-a74a-d077b163dbdd@kernel.org>
Date: Wed, 21 Aug 2024 15:10:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: ti: icssg-prueth: Add multicast
 filtering support in HSR mode
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jan Kiszka <jan.kiszka@siemens.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-7-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240813074233.2473876-7-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2024 10:42, MD Danish Anwar wrote:
> Add support for multicast filtering in HSR mode
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 38 +++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index b32a2bff34dc..521e9f914459 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -490,6 +490,36 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>  	return 0;
>  }
>  
> +static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +
> +	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
> +			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_BLOCK, true);
> +
> +	icssg_vtbl_modify(emac, emac->port_vlan, BIT(emac->port_id),
> +			  BIT(emac->port_id), true);
> +	return 0;
> +}
> +
> +static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +
> +	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
> +			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
> +			  ICSSG_FDB_ENTRY_BLOCK, false);
> +
> +	return 0;
> +}
> +
>  /**
>   * emac_ndo_open - EMAC device open
>   * @ndev: network adapter device
> @@ -651,6 +681,7 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>  
>  	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);

Above unsync call will already remove all MC addresses so nothing
is left to unsync in the below unsync call.
> +	__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);

Do you have to use an if/else like you do while calling __dev_mc_sync?

>  
>  	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
>  	/* ensure new tdown_cnt value is visible */
> @@ -728,7 +759,12 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>  		return;
>  	}
>  
> -	__dev_mc_sync(ndev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
> +	if (emac->prueth->is_hsr_offload_mode)
> +		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
> +			      icssg_prueth_hsr_del_mcast);
> +	else
> +		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
> +			      icssg_prueth_del_mcast);
>  }
>  
>  /**

-- 
cheers,
-roger

