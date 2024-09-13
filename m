Return-Path: <netdev+bounces-128190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9899786BA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC071C20FBD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3363B823A9;
	Fri, 13 Sep 2024 17:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA11EEE4;
	Fri, 13 Sep 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248515; cv=none; b=U9hw1fu2xd1FvpwjYGFbheJx9nAWraXnT21/QgQYD50CubnolwD7CTj+ck+53Rnw6BZBO6pHB8uJ/Xx0S0NcFA+SjJZmaDsjepsuywV9NxJm3vQRWvvRE8791s7FUmOi8QI4gm0H3nopoJf1tfIfxCq7TaIVPM3EWemoagWSGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248515; c=relaxed/simple;
	bh=NNwiiJSJsfFiDGLn6QJwhQlAKUnbmjGKbIJn6LVga8Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtjy4hM++e0gCBUTIhHT28rsG7vKkE6GF6xAiscRv3aBT+YmotYbe9KqHiMf+nC6s0AorhhSxeftG7luvpsj4fdmtzJVYV49nO0vaJMiYJ2FrKIol/mlVK0j7jF9oLymK0UegBpg57P5fIiVhLb7A7m+tzfw6oLslH8uJ/C/WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X51Q15FcGz6K5mD;
	Sat, 14 Sep 2024 01:24:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DF7D140B3C;
	Sat, 14 Sep 2024 01:28:30 +0800 (CST)
Received: from localhost (10.48.150.243) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 19:28:29 +0200
Date: Fri, 13 Sep 2024 18:28:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>, <netdev@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
Message-ID: <20240913182828.0000602c@Huawei.com>
In-Reply-To: <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-4-alejandro.lucero-palau@amd.com>
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

On Sat, 7 Sep 2024 09:18:19 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 12 ++++++++++++
>  include/linux/cxl/cxl.h |  2 ++
>  4 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3d6564dbda57..57370d9beb32 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/cxl/cxl.h>
>  #include <linux/cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps)
> +{
> +	if (current_caps)
> +		*current_caps = cxlds->capabilities;

I'd split this up as setting a value in a 'check_caps' and comparisom with
a list is odd.

Also bitmaps all the way would be better.
Given you know it fits in one unsigned long you can short cut the
assignment of the bits though. Easy to extend that later if the bitmap
gets bigger.


> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
> +		cxlds->capabilities, expected_caps);
> +
> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8b8abcadcb93..35f6dc97be6e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 58f325019886..bec660357eec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
> +	u32 expected, found;
>  	bool irq_avail;
>  	u16 dvsec;
>  
> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	/* These are the mandatory capabilities for a Type3 device */
> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
> +
> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
> +		dev_err(&pdev->dev,
> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
> +			expected, found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_await_media_ready(cxlds);
>  	if (rc == 0)
>  		cxlds->media_ready = true;
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 930b1b9c1d6a..4a57bf60403d 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
> +			u32 *current_caps);
>  #endif


