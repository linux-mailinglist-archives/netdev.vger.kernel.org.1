Return-Path: <netdev+bounces-154197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A99FC0DF
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A01655BE
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F664212D85;
	Tue, 24 Dec 2024 17:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A60212D81;
	Tue, 24 Dec 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060143; cv=none; b=WMEDizlztLIr6Dai63fA18YXbSHVwepV5BRXcSsLr7LCc2cjzxVec4LA6fKA/xbqEduRm0nEQHDlxk0VpiIJH782xgZKEobnbv++BfCOUxZpLSHkche23Gh7VPnSDX46fQ0+KfezrQtUeAlY0X1kyYCrywBzmtGP+CUj5lHPce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060143; c=relaxed/simple;
	bh=ocS4G37wEkMxNyZA5IatIoJBifawVua2lXfnSCGodiQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Feyyd9oJo6sKiE0dT1JyO18QNBfIoYUYCpKqPmgaF+HkYIzFm+nJQiMKcXiuEulukpp6ls5D/Irc5dsTR1EzdK2IGcWJizFBTMWiOBBUCTTkb0dxh0S9iIwVRogr5SnD8FmYcQb/Xw5XY2zkAkikBw8P++IBqSaV6zErZwxTuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHh8c62qWz6K5pN;
	Wed, 25 Dec 2024 01:05:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EFF6140680;
	Wed, 25 Dec 2024 01:08:58 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:08:57 +0100
Date: Tue, 24 Dec 2024 17:08:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <20241224170855.0000295c@huawei.com>
In-Reply-To: <20241216161042.42108-4-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-4-alejandro.lucero-palau@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Dec 2024 16:10:18 +0000
<alejandro.lucero-palau@amd.com> wrote:

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
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Use set_bit() not dereference and |= to set the bits in the bitmap
At that point you can void need to force the length of the bitmap.

Jonathan

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 59cb35b40c7e..ac3a27c6e442 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c

> @@ -113,11 +118,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>   * @dev: Host device of the @base mapping
>   * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>   * @map: Map object describing the register block information found
> + * @caps: capabilities to be set when discovered
>   *
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -146,10 +152,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -157,6 +165,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);

Ah. That would will be why the 64 below. use set_bit() for these, not a dereference.


>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -421,7 +430,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -431,12 +440,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> +		cxl_probe_device_regs(host, base, dev_map, caps);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found: %s%s%s\n",
> @@ -455,7 +464,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 19e5d883557a..f656fcd4945f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -12,6 +12,25 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> + *
> + * and currently being used for kernel CXL support.
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_HDM,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS = 64

Why set it to 64?  All the bitmaps etc will autosize so
you just need to ensure you use correct set_bit() and test_bit()
that are happy dealing with bitmaps of multiple longs.


> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


