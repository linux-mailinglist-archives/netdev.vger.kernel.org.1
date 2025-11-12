Return-Path: <netdev+bounces-237995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5FC5289F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7C23B8E4E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDDE338580;
	Wed, 12 Nov 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESP5olPZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57630C34A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954632; cv=none; b=P11FmG4V2/1eND+vd67aVr1WtHFB5SjzDA1tTsu3fku81B2vPzdWA2DYVE00knL/2LIwkaRwZ01wfmLinOmZgDGnm8k0LJILSADooH1YgnjZEV2bCnEVJ+JuUhnrRq3HrCrqUHo2VgYr6ma8MGGZZ6buC7mYmROQ2JDAWZIwxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954632; c=relaxed/simple;
	bh=qjoyQ1i0XlHCdmiLtEfyvA2R2Rbp/ZNCi/h43md7ZII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWFbUJvxA6B2ubEp7NdCkak5pBPkWtnc4b4PQscsVYlvtf+kYjs8K8BjL9HG4ozBzM6HlyhyLaYzbQFthuItoX0PyW3I2KUmp0rWYR9F0p6XymQgQbKMfJTkxG/ytIn+e0sz/AGxR/L0gGaY/X42OEaQVl4oIBk/Rfz4lqLSYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESP5olPZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09c1ed91-7a04-49b2-a721-2ea9a4b2e44a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762954627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5meFDmC+b/galNHRQvPf6ha8mxkRU8mTP4N++xpcLk=;
	b=ESP5olPZsxJhTOjB3RahqZtuI5Hcj+1ZhXMAwALRyEGmfkEo6tNBNRTF5EL/GPkl5suw8q
	qT1P2ENxpUnfald2L340mhDufR7GRp6+TL3owTJWK9PCX97qrpoK1MmHtMw7Fl/g7ftKni
	4uLn341ZR1v/LPXPrKS4N3liihjktGk=
Date: Wed, 12 Nov 2025 13:37:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 5/7] ptp: ocp: Reuse META's PCI vendor ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
 <20251111165232.1198222-6-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251111165232.1198222-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2025 16:52, Andy Shevchenko wrote:
> The META's PCI vendor ID is listed already in the pci_ids.h.
> Reuse it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 67a4c60cbbcd..4c4b4a40e9d4 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -25,8 +25,7 @@
>   #include <linux/crc16.h>
>   #include <linux/dpll.h>
>   
> -#define PCI_VENDOR_ID_FACEBOOK			0x1d9b
> -#define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
> +#define PCI_DEVICE_ID_META_TIMECARD		0x0400
>   
>   #define PCI_VENDOR_ID_CELESTICA			0x18d4
>   #define PCI_DEVICE_ID_CELESTICA_TIMECARD	0x1008
> @@ -1030,7 +1029,7 @@ static struct ocp_resource ocp_adva_resource[] = {
>   };
>   
>   static const struct pci_device_id ptp_ocp_pcidev_id[] = {
> -	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
> +	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
>   	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
>   	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
>   	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

