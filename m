Return-Path: <netdev+bounces-225567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A88B95834
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E345E3A2E04
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E116320CA3;
	Tue, 23 Sep 2025 10:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2642A80
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624581; cv=none; b=CKXY2Vn2zw6Dqv86XsWFuRoZW/mCl5L50Vu6bcJHVl+ICT1FkNALV1JR0I2qq6S5F/yPmQQpku9nZAXGzrpXotWHNZJOnT15/I6+LHm1nSZjtUwYVHCMr9GmDga435okwW9IsQpQYaBDDxdT5pi0no9x3O4rRLmKl+1Y4vIj7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624581; c=relaxed/simple;
	bh=lORMk1G9eH1C4Oo8kFES0DV679FWJSH9MFUPaI6utFo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6nPPph1u28/SldmUTe0/VWysDoygSZUlZB0akDTTws43g+FL1RKdY+fUJmLSZJNohDP0U3wGaopKV/sZfjh7CcQKYETXoletEGB/oXXgghb5c6AduOEx0QvWbw5tQu5RM8uSdYtspUJi/eZv6mcSf2sSMgaI0FhMXtW+rIGum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWGr00l7pz6M4VW;
	Tue, 23 Sep 2025 18:46:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 29D0514027A;
	Tue, 23 Sep 2025 18:49:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:49:36 +0100
Date: Tue, 23 Sep 2025 11:49:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 3/6] bnxt_en: Make a lookup table for
 supported aux bus devices
Message-ID: <20250923114935.00001730@huawei.com>
In-Reply-To: <20250923095825.901529-4-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-4-pavan.chebbi@broadcom.com>
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

On Tue, 23 Sep 2025 02:58:22 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> We could maintain a look up table of aux bus devices supported
> by bnxt. This way, the aux bus init/add/uninit/del could have
> generic code to work on any of bnxt's aux devices.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Ah. Ok. This does make it more generic.  Smash this and patch 2 together
so we don't have the intermediate state where stuff is partly generic.

Key is perhaps to remember that reviewers almost always end up looking at patches
in isolation before they look at the overall result.

Jonathan

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 105 ++++++++++++++++--
>  1 file changed, 93 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index 665850753f90..ecad1947ccb5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -29,6 +29,70 @@
>  
>  static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
>  
> +struct bnxt_aux_device {
> +	const char *name;
> +	const u32 id;
> +	u32 (*alloc_ida)(void);
> +	void (*free_ida)(struct bnxt_aux_priv *priv);
> +	void (*release)(struct device *dev);
> +	void (*set_priv)(struct bnxt *bp, struct bnxt_aux_priv *priv);
> +	struct bnxt_aux_priv *(*get_priv)(struct bnxt *bp);
> +	void (*set_edev)(struct bnxt *bp, struct bnxt_en_dev *edev);
> +	struct bnxt_en_dev *(*get_edev)(struct bnxt *bp);
> +	struct auxiliary_device *(*get_auxdev)(struct bnxt *bp);
> +};



