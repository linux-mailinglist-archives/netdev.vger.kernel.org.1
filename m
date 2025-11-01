Return-Path: <netdev+bounces-234872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8CC285CC
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E7D1898D43
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F92FD1D7;
	Sat,  1 Nov 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gpxr4WX5"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86502FD1B7;
	Sat,  1 Nov 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023419; cv=none; b=GSKSmHHytT6xwdqwyFC8/QScONRkbPGojDymOGiWmFpfPtdA1e7xR+wCE4WSUeoEEO/aIDAVk9eF0KwRUNhVC/0c9qdb6eFsQEGkH2lauZ2bFdB/trBKAJRW6xOBWbYqrcYbhKcDMQH/phu8jEwgwSNtfOBUIX0c2apuP6T290Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023419; c=relaxed/simple;
	bh=USruvl5CjYEOvcDFnyw5+pIbys/jNRpJz3iXDb7BL3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gs67PY0lzEbLQmuCTsud9NhfSUGt+J2se3tqpXxMjcRTQ2RJU6LAIf5Hy3wsrBGYBI+WJ+iLaKzFReKYXCuTMiQ8980+NjFAydAXpJzEAM62MyTjp8blu4BeKE+txyWdOKlVQ4xVOmQ9oOEqSA98/DWI/mZrgIp1uHXw37RtcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gpxr4WX5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=n7JMJ4MASkyCHMRYbjzukLiLo9MQ3yUEHlT7fG6Q+58=; b=Gpxr4WX5NePAIMI9s8R9RVqBC8
	RlzCyfNrTEZwqXGtvpaLksqQJsvt9cqicL0661HYJEvcAxLS7Z+JI5A8K24EZWTojmVxWqF51xb3H
	3gbgYgvbCoFsfrLezCAXy4QcN2JK11FCzDe6jKbc9Y10YgQiAuWnWkOMJUntIcfvf8iOxyYnWA1AU
	p9CAYAsJCEFUOtGQTZVYHMNKkxul0TWiQoZ/yRimin8nBxjVgjtbDHf4m5qAkJ7NBxhE7WKZCHMkU
	kK/kijoLweyhNigNShYvM3PIg2Hgi0FQO+BA0qb9rUOXfzvmmVvkIwQQc1Ln5L3LNblwOxHGaN6rK
	VbOSztYw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFGmW-000000081aI-3ONg;
	Sat, 01 Nov 2025 18:56:56 +0000
Message-ID: <6a336251-109a-4843-b68c-88ca93fb501d@infradead.org>
Date: Sat, 1 Nov 2025 11:56:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/8] Documentation: xfrm_sync: Number the
 fifth section
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
 <20251101094744.46932-7-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251101094744.46932-7-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/25 2:47 AM, Bagas Sanjaya wrote:
> Number the fifth section ("Exception to threshold settings") to be
> consistent with the rest of sections.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Documentation/networking/xfrm_sync.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
> index de4da4707037ea..112f7c102ad043 100644
> --- a/Documentation/networking/xfrm_sync.rst
> +++ b/Documentation/networking/xfrm_sync.rst
> @@ -179,8 +179,8 @@ happened) is set to inform the user what happened.
>  Note the two flags are mutually exclusive.
>  The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
>  
> -Exceptions to threshold settings
> ---------------------------------
> +5) Exceptions to threshold settings
> +-----------------------------------
>  
>  If you have an SA that is getting hit by traffic in bursts such that
>  there is a period where the timer threshold expires with no packets

-- 
~Randy

