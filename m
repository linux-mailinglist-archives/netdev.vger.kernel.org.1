Return-Path: <netdev+bounces-243679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD647CA5BB9
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 01:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCF683010973
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9B3770B;
	Fri,  5 Dec 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VD5WOk6O"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB01F19A
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764893568; cv=none; b=O0bTecm7wi7hvZhnc9vTtdwndCSYlNhjoL7CXT/mAs9WbBez+SlwQ7PKnB1OcgPTg9hk1ov9YyAy6rrjbUzv3tOgXu499ORvt3dQ/2i4NaB9BohKyFZdrj9ahMwms11Rqp9z8eH6ZO5au+8g9LsFNEZ+5jKeNY8vX7kr+gKnVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764893568; c=relaxed/simple;
	bh=4LsnmxMeYoPnM0nGNCKxP2EzUnn38VfGBZhTK9C7oC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpAIBhVlrk7kGYxVFt4kpxwCz/Ake06CNPX9bSsZqdRXJjxeh4r/pg1erBfmXUSIPRlSKXilrlzPjK+Soy99+0ph38G9RRP+JnAYqvFu32Ac7/K0S8LVgnRje8Q40PFgrL1SOo0zWyfhDw7leCeHYw9sh3JtVVITxDT0twBXaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VD5WOk6O; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea427664-d7a9-4bf8-86e7-47dc8fc84ba4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764893554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1JGu9+HlOFuxrbQp1L4DjUhuEjjOrAZT3J7k/6lVbo=;
	b=VD5WOk6Oxsz+AP5rZKxUhc1gjV3xq74BGMi7Gw1E3b7PMAGF1hw3pwAL+3uaALKfI0c1XC
	eIgN060e2fMi1NJmTl3OjrWPLkJN+H4mbSgO10YVH9LmZaxEgBSwsHG6ZNB113GADsQUaW
	vVMDLPgJLgpWYYhF1z6WEhLyB5x3+y8=
Date: Fri, 5 Dec 2025 00:12:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL
 dependency
To: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 MD Danish Anwar <danishanwar@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Roger Quadros <rogerq@ti.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, "Andrew F. Davis"
 <afd@ti.com>, Parvathi Pudi <parvathi@couthit.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Meghana Malladi <m-malladi@ti.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Mohan Reddy Putluru <pmohan@couthit.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251204100138.1034175-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251204100138.1034175-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/12/2025 10:01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new icssg-prueth driver needs the same dependency as the other parts
> that use the ptp-1588:
> 
> WARNING: unmet direct dependencies detected for TI_ICSS_IEP
>    Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PTP_1588_CLOCK_OPTIONAL [=m] && TI_PRUSS [=y]
>    Selected by [y]:
>    - TI_PRUETH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PRU_REMOTEPROC [=y] && NET_SWITCHDEV [=y]
> 
> Add the correct dependency on the two drivers missing it, and remove
> the pointless 'imply' in the process.
> 
> Fixes: e654b85a693e ("net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms")
> Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/ti/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index a54d71155263..fe5b2926d8ab 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -209,6 +209,7 @@ config TI_ICSSG_PRUETH_SR1
>   	depends on PRU_REMOTEPROC
>   	depends on NET_SWITCHDEV
>   	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	help
>   	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
>   	  This subsystem is available on the AM65 SR1.0 platform.
> @@ -234,7 +235,7 @@ config TI_PRUETH
>   	depends on PRU_REMOTEPROC
>   	depends on NET_SWITCHDEV
>   	select TI_ICSS_IEP
> -	imply PTP_1588_CLOCK
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	help
>   	  Some TI SoCs has Programmable Realtime Unit (PRU) cores which can
>   	  support Single or Dual Ethernet ports with the help of firmware code

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

