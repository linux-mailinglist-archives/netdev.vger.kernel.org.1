Return-Path: <netdev+bounces-128187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558259786A9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1271C21F40
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4A823A9;
	Fri, 13 Sep 2024 17:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BF6F31E;
	Fri, 13 Sep 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248360; cv=none; b=DKtUq4f3yR3obWZEIJYpaKmhMFhfSbYvKpE4PFTkDZzX8pCCvA3xxZes0MzvZlSwgQT3lQG6yQQS2QqwRyVcBFKp8vC049M5wmt94Gg8SxQSu0/a8Vq/D5+BnWwJPLRpeUSePlvvRgcu/P+Ye40rTGCmdXMP1ToCaYBQCoexYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248360; c=relaxed/simple;
	bh=Q7v6WtNSxqiahvcKhz94EHajHld1UkemIm9D62ImlIc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5i9RmDbSYsf3fe+i4Abl9DKxgsTRDq7MFIK/gVxRjYQIn1L9Nhr6K+fJYY7xA+QZKDpAJolqgrRzJcLozQI/j0fjxYMgBoyj7QYoHJo0zHK0vsGoTJHPWkJDg8xPofMZmAQ11YxvDQmxA870Fym/kopWMNWOE/hI08imGBI7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X51M15v5Nz6K5cM;
	Sat, 14 Sep 2024 01:21:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 62A93140122;
	Sat, 14 Sep 2024 01:25:54 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 19:25:53 +0200
Date: Fri, 13 Sep 2024 18:25:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20240913182552.000003ed@Huawei.com>
In-Reply-To: <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-3-alejandro.lucero-palau@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 7 Sep 2024 09:18:18 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field for keeping device capabilities as discovered during
> initialization.
> 
> Add same field to cxl_port which for an endpoint will use those
> capabilities discovered previously, and which will be initialized when
> calling cxl_port_setup_regs for no endpoints.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Hi,

My only real suggestion on this one is to use a bitmap to make
it easy to extend the capabilities as needed in future.
That means passing an unsigned long pointer around.


> @@ -600,6 +600,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -623,6 +624,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	u32 capabilities;

Use DECLARE_BITMAP() for this to make life easy should we ever
have more than 32.

>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..37c043100300 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -424,6 +424,7 @@ struct cxl_dpa_perf {
>   * @ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -438,6 +439,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	u32 capabilities;

As above, use a bitmap and access it with the various bitmap operators
so that we aren't constrained to 32 bits given half are
used already.


>  };
>  
>  /**

> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index e78eefa82123..930b1b9c1d6a 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -12,6 +12,36 @@ enum cxl_resource {
>  	CXL_ACCEL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
Trivial but cxl tends to do
/*
 * Capabilities ..

style multiline comments.

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
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MAILBOX_SECONDARY,

Dan raised this one already - definitely not something any
driver in Linux should be aware of.  Hence just drop this entry.

> +	CXL_DEV_CAP_MEMDEV,
> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


