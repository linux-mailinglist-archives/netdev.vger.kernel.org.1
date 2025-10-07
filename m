Return-Path: <netdev+bounces-228104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F098BBC16D9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E764C18855E5
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A0128819;
	Tue,  7 Oct 2025 13:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA8EACD;
	Tue,  7 Oct 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842082; cv=none; b=m4TXUzNVluKBjWssDHXxkrqrZ8tIF0gW0eYnexNqjUsKvMFwfwUA1xd72r+4+sFmIy5ClVmoe1ERfPh6HTLRXnpfAqGLm7DskDvAKp4/I9jPykhLqywmh4AGPQEmBFHWXGfw0ESqXMrnscWsoIMvhavMINnHY91ixi1LfpIXcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842082; c=relaxed/simple;
	bh=fJz7Hr8lw4a6M+80X290ZyvKUedwd238nl+Sbno/SL8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBKz3e0nHlAdAXnrphLrh3H3bXosthblIWwFUvazPB0J+wA/Fj7A9exIX1sP2cEAA1R9a92s6cdiLTilqmKTXOm7Wrj73yvuH37lHQRtUJZME0NJsZIAj/heYsk3zi43F1Im9VLFBDu/WIT5PNvwXtljG8E2svy1oivxKLRfioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgx5y0bw0z6L545;
	Tue,  7 Oct 2025 20:58:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 11CC41402E9;
	Tue,  7 Oct 2025 21:01:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 14:01:15 +0100
Date: Tue, 7 Oct 2025 14:01:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Alison Schofield
	<alison.schofield@intel.com>
Subject: Re: [PATCH v19 06/22] cxl: Move pci generic code
Message-ID: <20251007140113.000028ad@huawei.com>
In-Reply-To: <20251006100130.2623388-7-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
	<20251006100130.2623388-7-alejandro.lucero-palau@amd.com>
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

On Mon, 6 Oct 2025 11:01:14 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Fix cxl mock tests affected by the code move, deleting a function which
> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
> setup RCH dport component registers from RCRB").
> 

Trivial but can we pull out that code removal as a separate patch?
It's something Dave would probably pick up immediately. 

> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index ccf0ca36bc00..4b11757a46ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,9 +74,22 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>  }
>  
> +/*
> + * Assume that the caller has already validated that @pdev has CXL
> + * capabilities, any RCIEp with CXL capabilities is treated as a

In PCI spec they are RCiEP so we should match that rather than lowercase
for the P.

> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
> + * registers in a Root Complex Register Block (RCRB).
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}


