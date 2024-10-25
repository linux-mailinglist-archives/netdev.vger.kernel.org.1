Return-Path: <netdev+bounces-139125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB19B0542
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BE280D03
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B01FB894;
	Fri, 25 Oct 2024 14:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4C21219F;
	Fri, 25 Oct 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865651; cv=none; b=T8hv53c5L42HGmR5A00R+3YpN8Ix9GVofGV+BJK91zMr4Ul0psZ4bd0m2twGPdj+ARSrOxUPRnxN7QvMM+gJ1z4gbmdy88NCXSMuNeAv0RFoXeXHJcCQjUkZNPA079VK/cnnWSN8ji/HLwZ0AIq+roz0SQ8OT6hcr/TO+jabfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865651; c=relaxed/simple;
	bh=VIu37v08bCXoHf9y1D7PIwgF3PSYVh85dxUpuADw1so=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtnWf4f9u9oHbaX6LFcN7+1uAwSE8nRyDpSIBiEIxgssTMc2CX7cZgnQ6aR3t1UPi6ymQlNp7SOqBkxOaLIfH/oyi+xpwv5bkjdts7P4u1StsRpZkKMKAxMGZgmaUmXBEKZNPLxpHzzAED9vJhEUURO0re+ErvSjZuWXC8kSuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZl8W2PvBz67GZ3;
	Fri, 25 Oct 2024 22:11:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D0521408F9;
	Fri, 25 Oct 2024 22:14:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 16:14:04 +0200
Date: Fri, 25 Oct 2024 15:14:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v4 03/26] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20241025151402.00002e12@Huawei.com>
In-Reply-To: <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
	<20241017165225.21206-4-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:52:02 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as
> discovered during initialization. Add same field to cxl_port as registers
> discovery is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Just a trivial wrong spec reference.

> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index c06ca750168f..4a4f75a86018 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -12,6 +12,37 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.0 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_SEC,
> +	CXL_DEV_CAP_LINK,
> +	CXL_DEV_CAP_HDM,
> +	CXL_DEV_CAP_SEC_EXT,
> +	CXL_DEV_CAP_IDE,
> +	CXL_DEV_CAP_SNOOP_FILTER,
> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
> +	CXL_DEV_CAP_CACHEMEM_EXT,
> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
> +	CXL_DEV_CAP_BI_DECODER,
> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
> +	CXL_DEV_CAP_CACHEID_DECODER,
> +	CXL_DEV_CAP_HDM_EXT,
> +	CXL_DEV_CAP_METADATA_EXT,
This is the 3.1 version of the table as metadata cap wasn't
added until then.  I'd just update the reference.

> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MAILBOX_SECONDARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS,
I'd drop that trailing comma. Don't want anything to be accidentally added after this.
> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


