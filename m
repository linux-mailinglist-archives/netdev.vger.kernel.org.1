Return-Path: <netdev+bounces-151482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66989EFABF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C272840AD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797C20ADD9;
	Thu, 12 Dec 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0kIrjIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22861547F5;
	Thu, 12 Dec 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027735; cv=none; b=Orn9ZUbs8C+HZ2Rj3CSCL6ck/2W8lHeA9mFZevguqz41nWTjeaie/UYDy+P6Y1tQ7xh22kPV+GxrA+35wnEq1L8+12lkst9cN3wIKP5AS4VN8+CDuuF4P+H3wrLKOvqPT7tyCVQVkwZgz4rMpvFQcDCKDa0ahvuhEvh93Y+gbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027735; c=relaxed/simple;
	bh=6MtRzTaHKXmGJLbXmqDTbn2UkUthBk1sXoUZ9fLjhNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIAD7DX8RjqAt8Zgg6PoEFq9gBsp2dgpP7+Oj4zzE+qxEelqbxi1C4RGDQPXJWZYMO58kJPzNP60NtKBzr0cZ+R/q34tiCt34tXjb+hHj27gx2SaekkwtWOHw31FN1uoUGIp/+7W/jR6SuGlF/lr7PBNgQd5DcqaQmeJ0iTzHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0kIrjIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B2C4CECE;
	Thu, 12 Dec 2024 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027734;
	bh=6MtRzTaHKXmGJLbXmqDTbn2UkUthBk1sXoUZ9fLjhNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0kIrjIGJ4b8STlj/Jf8eLk4B0K6US02fhHrn2T/OPwTomQadU3EtF8IDCy8xhO8B
	 N9CY2ztJGD1PxBEMzWicvJY833HoSw4FTT17K1wFTMkoA9V9UlXgTKTsUr8w0LkDb3
	 rI25r14DAbnA0joTHpztSv2S3XeXZVHII0kT4VEZFJi74WXpJ+lb8hRunUW9ZjB5QM
	 BHEYixNYmPM7izSwc4Qfo3lc86Zf8Jnw/ko7oufw7xD+LHpSVYWaz5A4aKn6VkW+5T
	 kC6ImSPCHeAZ+pF6ViP3lZz13sgHMxYZa0LvVpq/Vclf4ny75rZCzU9xFGOlxYdlCV
	 f7fqM98k9kwhw==
Date: Thu, 12 Dec 2024 18:21:10 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 18/28] sfc: get endpoint decoder
Message-ID: <20241212182110.GA2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-19-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:19PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index f2dc025c9fbb..09827bb9e861 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR_OR_NULL(cxl->cxled)) {

Hi Alejandro,

The Kernel doc for cxl_request_dpa says that it returns either
a valid pointer or an error pointer. So perhaps IS_ERR() is
sufficient here.

> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxlrd);

Otherwise, if cxl->cxlrd is NULL here, then rc, the return value for
this function, will be 0 here. Which doesn't seem to align with the
error message on the line above.

Flagged by Smatch.

> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);
> -- 
> 2.17.1
> 
> 

