Return-Path: <netdev+bounces-81244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31F886BDD
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC761F24BBC
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3463F405E5;
	Fri, 22 Mar 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YD5g7g6S"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB63E487
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109425; cv=none; b=QRMqRW2xmWqHIq3OQ+W94FY8wdgCFDBqITPAp1zFGiKXLiEy+kSlvIFmpLagAn9N7v/x+sXmXBPQzTJm2nXxQOdCiR0J31PH/XU5LmPzcp2qXH6tzIkDhJc8Rznjq4ZYgXD7lO42s76OhY7d2tShfy8o5/DZPUihJlsRlN9DOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109425; c=relaxed/simple;
	bh=I3Jk5nesrXWQB9vsFuBtdZubxAsXAduwyL+nfRHe2U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWkN92Oe/DW3Nurs1nRUtGC4++D9hDxVMpjZWbVbiYOojYukYyGhNjqK3iHXAK9xKVDrAIASx4z6I9xXg69isBT2yVFWdb3eCaRGgiRKUgtZxEsizccXvylAQTx4kgouy5c3nlC0uPfwguDq8p7mKUEl+E+Wf8CXi3J6GxG1rMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YD5g7g6S; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6002602f-47db-42a5-9171-6bdad714e9b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711109420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFTcZCeNF3rcJ30Y7k8mKITzxXBHmzYgd3RvPsRTQ9s=;
	b=YD5g7g6S7jswv7R4JuPaK5g16b4Ok2/uhNb0k9xqaqBkBbkbPJXnolqwJ82/DeE7SQh0Mk
	BMu32jHQEdVevicK87wnpewaOKLZTsc6GUaeLnBPd/mOkUMzSYqr+aApmVXLrlsGbXX+Hz
	g0gTt6InxZEXRGisiycvg/o39ZXqGW8=
Date: Fri, 22 Mar 2024 12:10:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] dpll: indent DPLL option type by a tab
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
References: <20240322114819.1801795-1-ppandit@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240322114819.1801795-1-ppandit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/03/2024 11:48, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Indent config option type by a tab. It helps Kconfig parsers
> to read file without error.
> 
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>   drivers/dpll/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v1:
>    - Add Fixes tag and specify -net tree in the subject.
> v0: https://lore.kernel.org/netdev/CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com/T/#t
> 
> diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
> index a4cae73f20d3..20607ed54243 100644
> --- a/drivers/dpll/Kconfig
> +++ b/drivers/dpll/Kconfig
> @@ -4,4 +4,4 @@
>   #
>   
>   config DPLL
> -  bool
> +	bool

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

