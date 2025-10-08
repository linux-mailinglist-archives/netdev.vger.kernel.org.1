Return-Path: <netdev+bounces-228245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23967BC58C5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E1619E27C2
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A332F0C7E;
	Wed,  8 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WvDpijsU"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244792EC55D
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936764; cv=none; b=LhewIm6FoyvGldij/lpYBiyAYOBns3g+Maq7Gz0T/LDgno9YylUuBr7XZ3+TGDRu75635NES3ImAcsXcyontjRyFgrAIjJt9U27LBmUUV8AVUv7cPFAIlyH0Zgcg/vc+1mFrTCCBr68+kfZ4pbH0SHgD0eEY9Gr0bplC95qU+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936764; c=relaxed/simple;
	bh=dpweNp1UTyxQM0s2/8LARt1MWLRdZHExNLUozHTEJrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WevDieIG5Urpc5WbUwITxuqoxmmA/nnWMACrYxU6zN8fN80PONPWs5VXpqo/1UKXL8ikBxANtF7hsSWFPKnN1tKip6q1SCbxMB66E6dDTYaEOFuNgbh6GiFb+Jy7Kz1imsZni4mBu2QbA1zEwGm/cpmE92I+tMrYSXD41ZAIZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WvDpijsU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d95b97d5-d007-460f-b5ad-a4818acb29c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759936748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhkKw+krLJuUpERYXgvwDH4kTAo80j012GYjIQB7COM=;
	b=WvDpijsUigCpL5i00LZdehXzT5rRVMCUrc3F6E/D4k2lI3iIofJCma7O28JE8aYyKTJuCN
	CcvDgEPnvXSi9fpxEy259HjTKDxrnbUIYTVe2bvg7xUTVAFQHq7FEo1g1valbNMfpEaxZZ
	bxyRMUfV36WD2yP6K3UnQ/Yv6Iwo21Q=
Date: Wed, 8 Oct 2025 16:19:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: zl3073x: Increase maximum size of flash utility
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20251008141418.841053-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251008141418.841053-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/10/2025 15:14, Ivan Vecera wrote:
> Newer firmware bundles contain a flash utility whose size exceeds
> the currently allowed limit. Increase the maximum allowed size
> to accommodate the newer utility version.
> 
> Without this patch:
>   # devlink dev flash i2c/1-0070 file fw_nosplit_v3.hex
>   Failed to load firmware
>   Flashing failed
>   Error: zl3073x: FW load failed: [utility] component is too big (11000 bytes)
> 
> Fixes: ca017409da694 ("dpll: zl3073x: Add firmware loading functionality")
> Suggested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/fw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
> index d5418ff74886..def37fe8d9b0 100644
> --- a/drivers/dpll/zl3073x/fw.c
> +++ b/drivers/dpll/zl3073x/fw.c
> @@ -37,7 +37,7 @@ struct zl3073x_fw_component_info {
>   static const struct zl3073x_fw_component_info component_info[] = {
>   	[ZL_FW_COMPONENT_UTIL] = {
>   		.name		= "utility",
> -		.max_size	= 0x2300,
> +		.max_size	= 0x4000,
>   		.load_addr	= 0x20000000,
>   		.flash_type	= ZL3073X_FLASH_TYPE_NONE,
>   	},

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

