Return-Path: <netdev+bounces-206263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5113B025AB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083CD1CA436A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E361DDC2C;
	Fri, 11 Jul 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbnTsq2G"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3ABE4E;
	Fri, 11 Jul 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265075; cv=none; b=a7riWCTt+nyXFAQfcEaqAdqOyOSJqF3AV/JEKZn7prReBqPpFZEvW2KFIyDnSyk4LT7qVjJPKNxVEa8cmbDrVIDY9QZc3nNW3MTKYJBrYakQmc13wnLSs1UOf7dDT7rX1eu8C177y6RI4MB0ZC3tMpNnwB+95oAIgzAX5Q87y8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265075; c=relaxed/simple;
	bh=cBTjPnECA7CjZDXij2mXbtGWvIHYPz7P/FtxLGFNiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KB5nzqJD8vXdyTATrKwi3rXn7BUwRWcM1PJsC+6cL8x6aV4aeYMYR3Ttyt9C7pcRCsfqTajCeKcue8q0WR9oZxbm7MnJDsDKLY5iQDHRbVJEdC4zAYyShy3o8uF9RFnC0dQ3rXxDJtFjOxbDsGQbbkBv/fR0ZdNXGcsWfI+zqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VbnTsq2G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=9rkV9cB9YJdz5wh8MP+4PTa/IYzyAgxwFgxSFE2Qq3Y=; b=VbnTsq2GBMfMC0DWYFf9trxSrX
	JVlA0q/lYd/5bLQ4alqYbHD4JPM8FcWCNPKa9W/h7tbPy2mhwIRvd/M1j2kxFcLBbA9B33LsKo5pl
	3PVc/9Uq/CdX8RcKWITSwsZk4V+Uvyf++1/0Kv63MOYKwldtbIGQytMR5D22+gdMbBtHPt1RVdOGX
	Q6iWv+o1NwRakf+GL0edqqDNKl8nS/BAfamqAfLJr+07Ukv9FohytnAIWC8jRd8+P6bGTAv1FOrq8
	mB+jmL0IrAtVyCvo65YqqRwIQ1Ev5TfruncKhdP2kH2Noas5Sbpyh3xJQL/L3wQB0DDKNW6zyMRCZ
	yaeF4xFw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaKBn-0000000EIeH-3w6z;
	Fri, 11 Jul 2025 20:17:48 +0000
Message-ID: <7d3f6bae-f896-4067-916a-03ed5151f511@infradead.org>
Date: Fri, 11 Jul 2025 13:17:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: wangxun: fix VF drivers Kconfig
 dependencies and help text
To: Jiawen Wu <jiawenwu@trustnetic.com>, linux-kernel@vger.kernel.org
Cc: 'Mengyuan Lou' <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
 'Andrew Lunn' <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>,
 'Eric Dumazet' <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 'Paolo Abeni' <pabeni@redhat.com>
References: <20250710230506.3292079-1-rdunlap@infradead.org>
 <094401dbf240$6f60b880$4e222980$@trustnetic.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <094401dbf240$6f60b880$4e222980$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 1:47 AM, Jiawen Wu wrote:
>> --- linux-next-20250710.orig/drivers/net/ethernet/wangxun/Kconfig
>> +++ linux-next-20250710/drivers/net/ethernet/wangxun/Kconfig
>> @@ -66,35 +66,34 @@ config TXGBE
>>
>>  config TXGBEVF
>>  	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
>> -	depends on PCI
>>  	depends on PCI_MSI
>> +	depends on PTP_1588_CLOCK_OPTIONAL
>>  	select LIBWX
>>  	select PHYLINK
> 
> I think "PHYLINK" can be removed together, since the driver doesn't use it.
>  
> 

OK, I'll do that also.
Thanks.

-- 
~Randy


