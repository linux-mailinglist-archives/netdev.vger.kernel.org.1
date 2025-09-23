Return-Path: <netdev+bounces-225564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB9B9572F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F58189AF82
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B31D63F5;
	Tue, 23 Sep 2025 10:35:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016A2594BD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623747; cv=none; b=ceGc+cgHXjcI0nHDZW7j0uL7pCROib4XPM64BcHvakY5YgHFmADGinKRuNF8cXXxDksVdketSt9jibNraTgdfqPjacbTY39WCJFRMz1uSyspmoG7EmBx1ehSP69LV7WEFFYUff3+tTvOiIkn67+d4L/5O7D0ciF+XU3rvcZ0sMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623747; c=relaxed/simple;
	bh=wSFHc1i5/7QGnUyylcL4SPLwXpS9RoscdTzn9/vUsJ0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgmAD6QnTGs6n8cByzdLifag3IXYc8kUp7FBy+OOfNGzxC+UiH9gyd9xG/WnMm739Ji9ezNVxH5mXtZjuCcyIIjlLpdk5U8dglqE8ZBjuT2H6fjHEtnlFSZ9QzokF7lAujEAaytvinVXEqIBzhq2e/zz+4fYdjEjJ4kg+lM+ozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWGYD2W5Vz6L5D7;
	Tue, 23 Sep 2025 18:33:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 67C491402ED;
	Tue, 23 Sep 2025 18:35:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:35:41 +0100
Date: Tue, 23 Sep 2025 11:35:40 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 1/6] bnxt_en: Move common definitions to
 include/linux/bnxt/
Message-ID: <20250923113540.000032ab@huawei.com>
In-Reply-To: <20250923095825.901529-2-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-2-pavan.chebbi@broadcom.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 02:58:20 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> We have common definitions that are now going to be used
> by more than one component outside of bnxt (bnxt_re and
> fwctl)
> 
> Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.
> Have a new common.h, also at the same place that will
> have some non-ulp but shared bnxt declarations.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
One really minor comment inline. Given this does exactly what you say
FWIW.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/include/linux/bnxt/common.h b/include/linux/bnxt/common.h
> new file mode 100644
> index 000000000000..2ee75a0a1feb
> --- /dev/null
> +++ b/include/linux/bnxt/common.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2025, Broadcom Corporation
> + *

Totally trivial but this blank line adds nothing useful.

> + */
> +
> +#ifndef BNXT_COMN_H
> +#define BNXT_COMN_H
> +
> +#include <linux/bnxt/hsi.h>
> +#include <linux/bnxt/ulp.h>
> +#include <linux/auxiliary_bus.h>
> +
> +struct bnxt_aux_priv {
> +	struct auxiliary_device aux_dev;
> +	struct bnxt_en_dev *edev;
> +	int id;
> +};
> +
> +#endif /* BNXT_COMN_H */
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
> similarity index 100%
> rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> rename to include/linux/bnxt/ulp.h


