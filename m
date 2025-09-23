Return-Path: <netdev+bounces-225569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E87B9586A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CC1189AD93
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8382877ED;
	Tue, 23 Sep 2025 10:56:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B173258CEF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624973; cv=none; b=sM/uba+3i930x80RRsXsUD26FmJ4J9jkp/FfDdeB1+Fk2R1i1oK18iJ/L/SoSekCFMf9dzsqecbXWUG3eB4vh1zU4bj6tDQexSrHIlZikxoCsezW1kAxtZ/jqkV8DrrcdH+vaIWdd0Qz1m1AX4YEK5ye+Ac0qm+VVZSvdHsdw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624973; c=relaxed/simple;
	bh=yJtyXVVNO2NnqL0y/sx8fNHHD9S1FLmvHFYR3ysjRgI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMjZhWArf9evk4Q2jUO5pStxcTIZ8JSKXTCmpe3TKAOEW6KcsHf97uBCUn3RDfSuycUVA5muUM2JnPSsAvJHl2QGxsDoPA/+IJAdqM1Tq2E+a5qnlBKN7xmPl9qJbiv9sKuz5z5UJnF1c8+T/JIroy328VvRMA12Wxqpozz0r7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWGzW74tHz6M4tl;
	Tue, 23 Sep 2025 18:53:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F4AC14027A;
	Tue, 23 Sep 2025 18:56:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:56:08 +0100
Date: Tue, 23 Sep 2025 11:56:06 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 4/6] bnxt_en: Create an aux device for fwctl
Message-ID: <20250923115606.00003c67@huawei.com>
In-Reply-To: <20250923095825.901529-5-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-5-pavan.chebbi@broadcom.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 02:58:23 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Create an additional auxiliary device to support fwctl.
> The next patch will create bnxt_fwctl and bind to this
> device.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Just a few minor comments in here.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index b2f139eddfec..1eeea0884e09 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2340,6 +2340,8 @@ struct bnxt {
>  
>  	struct bnxt_napi	**bnapi;
>  
> +	struct bnxt_en_dev	*edev_fwctl;
> +	struct bnxt_aux_priv	*aux_priv_fwctl;
>  	struct bnxt_rx_ring_info	*rx_ring;
>  	struct bnxt_tx_ring_info	*tx_ring;
>  	u16			*tx_ring_map;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index ecad1947ccb5..c06a9503b551 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c

> +static u32 bnxt_fwctl_aux_dev_alloc_ida(void)
> +{
> +	return ida_alloc(&bnxt_fwctl_aux_dev_ids, GFP_KERNEL);

Could maybe add a pointer to the ida to the type specific structure instead of a callback?
Small increase in shared code.


> +}
> +
> +static void bnxt_fwctl_aux_dev_free_ida(struct bnxt_aux_priv *aux_priv)
> +{
> +	ida_free(&bnxt_fwctl_aux_dev_ids, aux_priv->id);
> +}

>  
> @@ -536,12 +589,27 @@ void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
>  	aux_dev = bnxt_aux_devices[auxdev_type].get_auxdev(bp);
>  	rc = auxiliary_device_add(aux_dev);
>  	if (rc) {
> -		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
> +		netdev_warn(bp->dev, "Failed to add auxiliary device for auxdev type %d\n",
> +			    auxdev_type);
>  		auxiliary_device_uninit(aux_dev);
> -		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
> +		if (auxdev_type == BNXT_AUXDEV_RDMA)
> +			bp->flags &= ~BNXT_FLAG_ROCE_CAP;

Same comment as below.

>  	}
>  }

> @@ -611,5 +679,6 @@ void bnxt_aux_device_init(struct bnxt *bp,
>  aux_dev_uninit:
>  	auxiliary_device_uninit(aux_dev);
>  exit:
> -	bp->flags &= ~BNXT_FLAG_ROCE_CAP;
> +	if (auxdev_type == BNXT_AUXDEV_RDMA)
Mixing and matching between a 'type' specific structure and specific
ID based checks normally doesn't scale well if you ever end up adding more
types.  I'd suggest moving this to data or a callback in the bnxt_auxdev struture.

> +		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
>  }

>  


