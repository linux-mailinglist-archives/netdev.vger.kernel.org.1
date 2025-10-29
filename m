Return-Path: <netdev+bounces-233782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FFC1842A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 05:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DEC14E35CD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2442EA737;
	Wed, 29 Oct 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHurocPo"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A52765EA;
	Wed, 29 Oct 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713677; cv=none; b=D3X5j6yRU5MbyyE5z94VeBrlqT+SzwsLEV5q4VKCO+n2Y8mFTYIUXonbBgEFh105nDywIyBkAVjm671QKmZzMLfYxbmhSqTrwDqgsNHflsaFNPX3POORAfKzCV1Aw9uLIsIFaILcAO4H6YSl3SGchVcyCHWi/XAt9CkOhVJQDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713677; c=relaxed/simple;
	bh=Yxtz0VGw/gUgDhlLxzM64pLnCZzVNIMicJTeXRIWr64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAW971+ghch6z3XfEZIdET1XFvbKp0FvN6LIbxoORMZo3PKq9RWHTPv0KdIuddanCrKnFYyIhgwWxcFfPeIPAT50EmGDZrCFllTdA55+EvnOMqbC5bEhegH69lZyCi6agKRxzAxSso8MX8NkxTHZ3pvs4C5x5Nf7Qnuy5MFW0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iHurocPo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dxPuUYKzQQu126OnSRntHDbA5U4uP2M8U3VvHJ0dodE=; b=iHurocPofv+Q+oW0q0Lc5DReCY
	S6LJGZxjifzNa3Gut89+rQdAJkBm4WHkjy7Zk9eoTVHd4l1H6B9Uh5rriK6mUSrd1+HavsFZPIFBf
	axBL3eUots5WCbN5kawYUDtaGI0sD3A4gait/hSMCaoi+Ou4enXclcRiUdvOMihdc9WN9i1uVJp2m
	MWCxuaZd51iMEf/EwIo47GQWvq+2wL2yDSVJwClU8YCv81HDchyC29VGxulokU4bcBNalkGK0jd3x
	k+d89ws70XPnakJekI8YiCU5VpyAB2J3p5czjK7ovZxiB6M8GLwhYyStnNsRNp+XvQETRefoIr+N6
	IcOn9fSw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyCe-0000000HEjt-1k69;
	Wed, 29 Oct 2025 04:54:32 +0000
Message-ID: <36fd9408-9008-46e2-87ab-bbc6a84b46ab@infradead.org>
Date: Tue, 28 Oct 2025 21:54:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: netconsole: Remove obsolete
 contact people
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matt Mackall <mpm@selenic.com>, Satyam Sharma <satyam@infradead.org>,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <20251028132027.48102-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251028132027.48102-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/25 6:20 AM, Bagas Sanjaya wrote:
> Breno Leitao has been listed in MAINTAINERS as netconsole maintainer
> since 7c938e438c56db ("MAINTAINERS: make Breno the netconsole
> maintainer"), but the documentation says otherwise that bug reports
> should be sent to original netconsole authors.
> 
> Remove obsolate contact info.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Satyam Sharma <satyam@infradead.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> 
>  Documentation/networking/netconsole.rst | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index 59cb9982afe60a..2555e75e5cc1c3 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -19,9 +19,6 @@ Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
>  
>  Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
>  
> -Please send bug reports to Matt Mackall <mpm@selenic.com>
> -Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
> -
>  Introduction:
>  =============
>  
> 
> base-commit: 5f30bc470672f7b38a60d6641d519f308723085c

-- 
~Randy

