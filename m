Return-Path: <netdev+bounces-154205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 189A09FC101
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 18:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6107A1B97
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290F1FF5F9;
	Tue, 24 Dec 2024 17:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4814D433;
	Tue, 24 Dec 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061362; cv=none; b=Ss+7U1Qa4/pdjrERqpThz4MemtOXKymjzSMUuqJ1nJGKBbwgYJSeLNZ36w2xNk+cjTsU0ZA+fpR4t4AoydOgsbmCiIPonpsjFxbIuOT+M4MBnNYnAMsWpZ6Ts5H9C+eLd4PNfdfvR9szkt1Y7eCtdRlKDMS966dDX26hNlqPrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061362; c=relaxed/simple;
	bh=dHrV0+HMU5ASzPuy22sP9MbaRdPb7qqtw19Dk/dtyjE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C71grbiwyiNr8+kf3YKBz9ad66p4rqhb+vq176MvytKQJLa+8B0xA/iXnR9LnLcWkL6TL0ost8RydzDYMckJpdCkSe/nmSshPcZzVLGirUKI0vQX+Yj2UOPpWhr5yDRQc4nQvyP/IDlsMkA2PTMFqG/+Q7MPi6U58nbFGMrKae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHhc55p1Dz6K8fn;
	Wed, 25 Dec 2024 01:25:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F9B4140736;
	Wed, 25 Dec 2024 01:29:19 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 18:29:18 +0100
Date: Tue, 24 Dec 2024 17:29:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 11/27] cxl: add function for setting media ready by a
 driver
Message-ID: <20241224172916.000024f2@huawei.com>
In-Reply-To: <20241216161042.42108-12-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-12-alejandro.lucero-palau@amd.com>
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

On Mon, 16 Dec 2024 16:10:26 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type-2 driver may be required to set the memory availability explicitly,
> for example because there is not a mailbox for doing so through a specific
> command.
> 
> Add a function to the exported CXL API for accelerator drivers having this
> possibility.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
I wonder if it is worth capturing the reasoning for this a comment?

Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c | 6 ++++++
>  include/cxl/cxl.h         | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c414b0fbbead..82c354b1375e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -789,6 +789,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
>  
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	cxlds->media_ready = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 44664c9928a4..473128fdfb22 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  #endif


