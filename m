Return-Path: <netdev+bounces-99775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A480D8D65BC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576531F222D8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75956B72;
	Fri, 31 May 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFJEN/L0"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D91859;
	Fri, 31 May 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169436; cv=none; b=Yz480NWFwolF2vNcAA6HDdkCzJ5keGr3ySpYg/20RLHxJLp+GoMg86aZSrFbNTS5OULoLtMlD/JNsjoxKU1pMF4VsC90/cqyxZGztsezXQ4+KmSqJwl81y2addzqv3/UMblH8bxylKrkcHuecISwEKpZCF649mRQL1HbXzQ+Lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169436; c=relaxed/simple;
	bh=b8edFq+BX78eQRN1Ba8dv8UAmRIZpk2lXQ0Ky4bIJnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beVZzaoefzKwx3GiBSnvnD61tblVPwixN2WKWXIwHxaG7Y0MBj8E1z58sUZFen1YiCot2398KwCdV8wsIYvrHOy+nZiNN7xhcQcvSA9Ra7rLYctNykTzk+mxqrpkHJDO0z8P60zsTZnUXDVUwlw16AeIeesxurxXUmJ4HBNJgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFJEN/L0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ae2+xYZ7D6L0nBQ0Vqf/ep5G4lxJjwrzH4Lp6YJWsIo=; b=KFJEN/L09A6KG0/i631h7Qvmi1
	t9m0j4bCm75IjozOHqDRmqvh4Eg+Nii93D5Jw3S4f8uSXWFynnhzerME3xOJ2/THcvi+5F7oJH7JH
	QWpOUwYfClymAm/XOkMEAWMZnpmPMUr9WI2FlxveqnMARE7h6JqeORe0laBLE4OPJ5JXLvQ9VByRg
	AOgGy7jgATX5GdWMxfmSqYAgfcZOyGfcglVBgY+06f36QPCBSPyh3ckQzH9XI+ZnK5ARBFXm8hCKP
	EJFO81cC5JARECborKg4LZiARZnptCHW6V1smuUqtwJVmoCxJcAPvxUf6mDUTNE1Nz3m8+ET1JZm8
	FF2TejbQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD4D5-0000000AgS0-3Clf;
	Fri, 31 May 2024 15:30:28 +0000
Message-ID: <98b1a3a4-5db8-4b69-9e3e-99f2dadf1b43@infradead.org>
Date: Fri, 31 May 2024 08:30:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
To: Yojana Mallik <y-mallik@ti.com>, schnelle@linux.ibm.com,
 wsa+renesas@sang-engineering.com, diogo.ivo@siemens.com, horms@kernel.org,
 vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 rogerq@kernel.org
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240531064006.1223417-2-y-mallik@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 11:40 PM, Yojana Mallik wrote:
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 1729eb0e0b41..4f00cb8fe9f1 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -145,6 +145,15 @@ config TI_AM65_CPSW_QOS
>  	  The EST scheduler runs on CPTS and the TAS/EST schedule is
>  	  updated in the Fetch RAM memory of the CPSW.
>  
> +config TI_K3_INTERCORE_VIRT_ETH
> +	tristate "TI K3 Intercore Virtual Ethernet driver"
> +	help
> +	  This driver provides intercore virtual ethernet driver
> +	  capability.Intercore Virtual Ethernet driver is modelled as

	  capability. Intercore

> +	  a RPMsg based shared memory ethernet driver for network traffic

	  a RPMsg-based

> +	  tunnelling between heterogeneous processors Cortex A and Cortex R
> +	  used in TI's K3 SoCs.


OK, the darned British spellings can stay. ;)
(the double-l words)

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

