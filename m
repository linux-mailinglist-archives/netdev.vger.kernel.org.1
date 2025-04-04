Return-Path: <netdev+bounces-179350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1866A7C158
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66313B2B0D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C379207DE2;
	Fri,  4 Apr 2025 16:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1C1FECAA;
	Fri,  4 Apr 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783181; cv=none; b=eedFKex5YOmqCfgK1WYSoC/3Mfq+y2kzbO7pOlfAnMYzvSM6vwNtAgdsP00EiNoRpVTzPc3EUGlhBJY71XYwLEU+/gu8hJN46ZpS7JTKh3bGp0DF2AsYvRBLfi1nnzTPilUSzlg2XGk3u24Vb5PmpwSezpoiodT1Z28kNuvZIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783181; c=relaxed/simple;
	bh=WHohB7QfNZ+s7wL0jW3IFhS9ldjJ481Ze8N799eIeQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI/P+wzjBqMFDfqD5bH60+Hyz36uWg3HCX3dEs8r9r9YSPJEsqYVlrBw1UMD3kKaKjio8FdytYziPgYlpkKtWz44o4aGNX+T7u13Tce29JxYyMcf17NRluVaLfbTmcBrHFQiC+MkGvbWWw6Z3uUMvPPCDgwVVq7m+E/TvPB0YmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTkC02qwXz67bm0;
	Sat,  5 Apr 2025 00:12:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 381E9140113;
	Sat,  5 Apr 2025 00:12:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 18:12:54 +0200
Date: Fri, 4 Apr 2025 17:12:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 08/23] sfc: initialize dpa
Message-ID: <20250404171253.00002b41@huawei.com>
In-Reply-To: <20250331144555.1947819-9-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-9-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:40 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use hardcoded values for defining and initializing dpa as there is no
> mbox available.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 3b705f34fe1b..2c942802b63c 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
> +	struct cxl_dpa_info sfc_dpa_info = { 0 };
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> @@ -75,6 +76,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl->cxlds.media_ready = true;
>  
> +	cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);

Maybe it is simpler to just pass in the total size as well?
Here that results in a repeated value, but to me it looks simpler
than setting parts of info up here and parts outside of cxl_mem_dpa_init()


> +	rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
> +	if (rc)
> +		return rc;
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;


