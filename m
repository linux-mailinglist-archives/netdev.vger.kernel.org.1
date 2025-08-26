Return-Path: <netdev+bounces-216899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A1B35DDA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA85462572
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8F335BC8;
	Tue, 26 Aug 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jBhzzo8t"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058143277A4;
	Tue, 26 Aug 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208255; cv=none; b=VcOVcdQA1xxKf1ThzzoPiY6cDTjCxnlmsvPnxiImkC8ImD38NdS4ASx7HZwBlcO1YjcHGEDoqAho7k+mjuXppGcruO46UeoJjgwDoy+mrof7vPrN17hJXn4BhpZqUAbMCBwjtPb5ITuRXzSbXQ16Qq7+La+tqsm7Mvgu2vRc5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208255; c=relaxed/simple;
	bh=53euXAtwAujHlv7egdopqjh6dCpFEsIEATNegkYfzKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djGlaDx9Bb0jbkNGdBoOnkgYLWD1/rgldIgqNdRMz8jGYklFln04fJ+o5Q2UIwb1mjT9hB39Ed56t3wjEmtOk2D1E5W2Ui12QDm0L+dLP6den2YVu7xWGnMRXx/ZGIdLP5inLRZ9/E53kEP3JCz56gtVLSWWz25vPPMMbU+GwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jBhzzo8t; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95c43071-c78f-4202-9045-aacc6842b687@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756208247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo0y3d64j4e034TxOhS9qpewIMDCJA4WpwRw3J79f3s=;
	b=jBhzzo8tFO14/rVH294ATjBH/tYeq2NhRZlvubY3XR2/SNwZ74ZDvFe7Io7u1PZwJSiPLk
	vN2Fu1pxJjzRiP2km2CGmFYljeYiqBNk8GwU4OW3UkmLCCuG80xfwryZqyLmlTnp9XCtsg
	0RKtsQZiL1M30CZLajHB/YexK84fHMw=
Date: Tue, 26 Aug 2025 12:37:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 01/12] hinic3: HW initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <5f4589c1ab4f6736545a38096ce15b6569733c91.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5f4589c1ab4f6736545a38096ce15b6569733c91.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Add the hardware resource data structures, functions for HW initialization,
> configuration and releasement.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  67 ++++-
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 240 ++++++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  13 +
>   .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   8 +-
>   .../huawei/hinic3/hinic3_pci_id_tbl.h         |  10 +
>   5 files changed, 334 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> index 6e8788a64925..d145d3b05e19 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> @@ -7,15 +7,76 @@
>   #include "hinic3_mbox.h"
>   #include "hinic3_mgmt.h"
>   
> +#define HINIC3_HWDEV_WQ_NAME    "hinic3_hardware"
> +#define HINIC3_WQ_MAX_REQ       10
> +
> +enum hinic3_hwdev_init_state {
> +	HINIC3_HWDEV_MBOX_INITED = 2,
> +	HINIC3_HWDEV_CMDQ_INITED = 3,
> +};
> +
> +static int init_hwdev(struct pci_dev *pdev)
> +{
> +	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
> +	struct hinic3_hwdev *hwdev;
> +
> +	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
> +	if (!hwdev)
> +		return -ENOMEM;
> +
> +	pci_adapter->hwdev = hwdev;
> +	hwdev->adapter = pci_adapter;
> +	hwdev->pdev = pci_adapter->pdev;
> +	hwdev->dev = &pci_adapter->pdev->dev;
> +	hwdev->func_state = 0;
> +	memset(hwdev->features, 0, sizeof(hwdev->features));

no need to init values to zeros as you use kzalloc to allocate the
memory

> +	spin_lock_init(&hwdev->channel_lock);
> +
> +	return 0;
> +}
> +
>   int hinic3_init_hwdev(struct pci_dev *pdev)
>   {
> -	/* Completed by later submission due to LoC limit. */
> -	return -EFAULT;
> +	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
> +	struct hinic3_hwdev *hwdev;
> +	int err;
> +
> +	err = init_hwdev(pdev);

I think there is no reason to have another init function

> +	if (err)
> +		return err;
> +
> +	hwdev = pci_adapter->hwdev;
> +	err = hinic3_init_hwif(hwdev);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to init hwif\n");
> +		goto err_free_hwdev;
> +	}
> +
> +	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM,
> +				       HINIC3_WQ_MAX_REQ);
> +	if (!hwdev->workq) {
> +		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");
> +		err = -ENOMEM;
> +		goto err_free_hwif;
> +	}
> +
> +	return 0;
> +
> +err_free_hwif:
> +	hinic3_free_hwif(hwdev);
> +
> +err_free_hwdev:
> +	pci_adapter->hwdev = NULL;
> +	kfree(hwdev);
> +
> +	return err;
>   }

[...]

> @@ -121,6 +122,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
>   			goto err_del_adevs;
>   	}
>   	mutex_unlock(&pci_adapter->pdev_mutex);
> +
>   	return 0;
>   
>   err_del_adevs:
> @@ -132,6 +134,7 @@ static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
>   		}
>   	}
>   	mutex_unlock(&pci_adapter->pdev_mutex);
> +
>   	return -ENOMEM;
>   }
>   
> @@ -153,6 +156,7 @@ struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev)
>   	struct hinic3_adev *hadev;
>   
>   	hadev = container_of(adev, struct hinic3_adev, adev);
> +
>   	return hadev->hwdev;
>   }
>   
> @@ -333,6 +337,7 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
>   
>   err_out:
>   	dev_err(&pdev->dev, "PCIe device probe function failed\n");
> +
>   	return err;
>   }
>   
> @@ -365,6 +370,7 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   err_out:
>   	dev_err(&pdev->dev, "PCIe device probe failed\n");
> +
>   	return err;
>   }
>   

not sure it's good to have this empty lines in this particular patch

