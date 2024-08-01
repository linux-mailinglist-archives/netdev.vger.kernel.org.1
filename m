Return-Path: <netdev+bounces-114909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF8944A8C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D9CB22981
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601518E02F;
	Thu,  1 Aug 2024 11:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F51189B95;
	Thu,  1 Aug 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512588; cv=none; b=eee8LPQ+ttN1hcTVVScVdVYuQSXwM1kLtxZY7/NvWiEb144InMvXj7tGTBnq2gyHOPm2zQhpxaULpx3ZSQnmECoKZfLKgNaRk0GogSJ4CF4mFmlu78wn23p9U1P0/JaDq1h93aB+cgYVxbnpJrbAWHxFCf1zYtlN2D6ZO5CSQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512588; c=relaxed/simple;
	bh=Y1Qa+XJrdmc4zMG+gQhaBZOIJ+0ogotagu3QPj36hVg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMANIUh5WPvV1wf9IGLLNUWqgG1UmmVOkwuaIyeNEa1U9DxU72uaDjA1iLvUDRDAyd+VTtr00rPOZDzYt/eGOyBUBsPxRUSxdJ8wZvkdxJl7z7djkyRHYm/XcVMTVS/ww+0mtDu4PfiaiqmHqF40/wgqtym8lEmJnPQNFPxTcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZRq030LGz6K9rl;
	Thu,  1 Aug 2024 19:40:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CC54140CB1;
	Thu,  1 Aug 2024 19:43:04 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 12:43:03 +0100
Date: Thu, 1 Aug 2024 12:43:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <admiyo@os.amperecomputing.com>
CC: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v5 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Message-ID: <20240801124303.000040ce@Huawei.com>
In-Reply-To: <20240712023626.1010559-3-admiyo@os.amperecomputing.com>
References: <20240712023626.1010559-1-admiyo@os.amperecomputing.com>
	<20240712023626.1010559-3-admiyo@os.amperecomputing.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 22:36:25 -0400
admiyo@os.amperecomputing.com wrote:

> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Note that this patch is for code that will be merged
> in via ACPICA changes.  The corresponding patch in ACPCA
Typo in ACPICA

Add a link to the patch in the acpica tree as then
its easier to identify exactly what needs pulling in before
this merges.

> has already merged. Thus, no changes can be made to this patch.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/acpi/acpica/rsaddr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
> index fff48001d7ef..9f8cfdc51637 100644
> --- a/drivers/acpi/acpica/rsaddr.c
> +++ b/drivers/acpi/acpica/rsaddr.c
> @@ -282,9 +282,10 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
>  
>  	/* Validate the Resource Type */
>  
> -	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
> +	if (address.resource_type > 2 &&
> +	    address.resource_type < 0xC0 &&
> +	    address.resource_type != 0x0A)
>  		return (FALSE);
> -	}
>  
>  	/* Get the Resource Type and General Flags */
>  


