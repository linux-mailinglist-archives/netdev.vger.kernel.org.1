Return-Path: <netdev+bounces-179362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A127CA7C1B7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5B57A9056
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B991F416C;
	Fri,  4 Apr 2025 16:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25783EEA8;
	Fri,  4 Apr 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785138; cv=none; b=rALqRczeYEX6QX6/j+IGGhnKuGHeuO8CxlM/W1sjPb7lWcrWCVgXW3N9JHkXE2xWGLS5ux3PzQRSgRlJUhMnidwp4qlVkVot+TRUWzwEEWkP7aSe9ZTB+vYbbzctPEcTH+qCFWG6HPU/sEfu0AWBN1+/eYg1FTf1VboPfMlfldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785138; c=relaxed/simple;
	bh=j8cT6Urd5IfAeSfWXCd4qWEW5BHCXAxrYDCE6Lwk+aU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvefi5X1dsX6x5KkMuM55Mx2sk4W8znE952ZfwdkEQlUxbhAzv3Xto3eUvPO3ypKcvl7ml/hWJpUqDCLNn1hUTxt8yarLKxZfur5QH4vEDC/uGoQ4baSshqgmwO8jly1+vUfX0DStKkDBq9jNB+lE+sOsTcJLA9Bd5BHpLQDTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTkwg2lv7z6L4vL;
	Sat,  5 Apr 2025 00:44:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4124C14050C;
	Sat,  5 Apr 2025 00:45:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:45:33 +0200
Date: Fri, 4 Apr 2025 17:45:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 18/23] cxl: allow region creation by type2 drivers
Message-ID: <20250404174532.000071b2@huawei.com>
In-Reply-To: <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:50 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 135 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  3 files changed, 135 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 892fb799bf46..f2e1d5719a70 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	cxled->part = -1;
> +	rc = cxl_region_detach(cxled);
> +	return rc;
`	return cxl_region_detach()

Check for any other cases of this.  If we don't clean them up now we'll
just get patches form those who run scripts to find these and that's
just noise upstream that I'd rather avoid.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");


