Return-Path: <netdev+bounces-182809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF25DA89F49
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF363AAF6B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8E284679;
	Tue, 15 Apr 2025 13:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED15336D;
	Tue, 15 Apr 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723317; cv=none; b=IRUx7bK3ugbGAxQ6AAT4jRWRauDc9z9crxJ3gv5gty5iLHY9fN7ZUXIdGJxTcBRVzRbZrSG7QrEzmosCA146399o4QJ5Gh8DVWwnU3OIbHllgW8x3KR583hyTnRxfp3U460+PyuKPXPhL/V0acmQF+1UllhB7YOoKN1ji+Mr2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723317; c=relaxed/simple;
	bh=yyGzD61+MYjILrn08mJKN5vTr4czMlsOzuslZ08hNT4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRApaKFPSmMrEHSUrcX6WdeLXnBI0h7/pWvikMxg/uyWRROIAMFAR/Yr98tQajyX2llD2HkzD5KE75od0erIe68uSSFrki0RoeHJsJsTH2lEjTd2hf6g8VAPhN/hOSFAaOomE+qnR63YU1bVA2Asemq+Ml8SseprzfMMhDUm3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcPst3243z6L4vb;
	Tue, 15 Apr 2025 21:20:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C193140133;
	Tue, 15 Apr 2025 21:21:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 15:21:51 +0200
Date: Tue, 15 Apr 2025 14:21:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 05/22] cxl: add function for type2 cxl regs setup
Message-ID: <20250415142150.00000f9d@huawei.com>
In-Reply-To: <20250414151336.3852990-6-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
	<20250414151336.3852990-6-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Apr 2025 16:13:19 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device initialising
> cxl_dev_state struct regarding cxl regs setup and mapping.
> 
> Export the capabilities found for checking them against the
> expected ones by the driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
One trivial thing inline.

>  drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  4 ++++
>  2 files changed, 56 insertions(+)
> 

>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
>  	int speed, bw;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index afad8a86c2bc..729544538673 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -231,4 +231,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>  struct pci_dev;
>  int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
>  		   unsigned long *found);
> +
> +struct cxl_memdev_state;

Why have this here?  only cxl_dev_state is used.

> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
> +			     unsigned long *caps);
>  #endif /* __CXL_CXL_H__ */


