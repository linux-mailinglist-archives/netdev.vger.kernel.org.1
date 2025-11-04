Return-Path: <netdev+bounces-235295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD9C2E87E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF4189B462
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657B1A5B9D;
	Tue,  4 Nov 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FAqLf4VS"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9D186E2E;
	Tue,  4 Nov 2025 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215121; cv=none; b=pAlhdXkeKs9vf7J4LJRDJoArwS628czQLqSjz90DUKoBOKPL+BEL3GHL7wsllmWxV0MH+9I7dbi52pYxxDdBTvFW4WWaFUUGIGPyfdNI2Z8J8AoxTko2UFHMQO81Ux80LjI2w/qy8i5YO2Hkap9YHUnloexdF+1FXWEWQZd93r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215121; c=relaxed/simple;
	bh=Ifrqezm9e5YRFfp+Do4S6PhVVNj4jf79q2anrhIAZxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLdCbK5LSSs9xpJiAbLKoK8zdKyByZJnRRENcoN+XncaAh6ZgAbBaLAdWfjojWlvuhxB6FRxCo7ipFIbSkacvSDHpi8RGxAUh/HqRHTPEi8AOvI14IgaBnLOSNtO/X0rtEj7rx6MkPmGe4M5VhR8emgPOGa9z9F+M/X4KAs4yJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FAqLf4VS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sBxIUpTJeGIY2hXTtX0cnKaghkTbezK2U0dIJnf6z5o=; b=FAqLf4VS6XGvwq8x2O7YH29Dc5
	EdwE6SDNYPu2xK1SthkHS6lUghrHthPSb4O4uHw31ylZKSO8jW9kJCUsIugY2dLTiFZSUBhs0Z3d3
	+BCt8pMaiTA5WOpGolxj6kbgV0umUhzptmAB6JPaSjW4C1MKh3kdmbukkASi+jvaO3lijehT7UYL6
	fL7Gl6kTFcdvYEes2BfgSN1kk55P8mDerSgO3g8OPiSa+v5btofu8ZRYDPy2pBLHSBYEdmRq7l1PO
	vT6z5gNc2s2cpJUWTCbbxTy+0rzazgmn53bjSUm3U57uvRzdoL51pK8Jgu3gvb6Aimb3rl9BZrJVt
	uaMw5oCw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4eR-0000000ApKh-3oUR;
	Tue, 04 Nov 2025 00:11:55 +0000
Message-ID: <b7150e4e-7eb9-4dd1-8b9e-7d43159b5c72@infradead.org>
Date: Mon, 3 Nov 2025 16:11:55 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/9] Documentation: xfrm_sysctl: Trim trailing
 colon in section heading
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
References: <20251103015029.17018-2-bagasdotme@gmail.com>
 <20251103015029.17018-8-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251103015029.17018-8-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 5:50 PM, Bagas Sanjaya wrote:
> The sole section heading ("/proc/sys/net/core/xfrm_* Variables") has
> trailing colon. Trim it.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/networking/xfrm_sysctl.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
> index 47b9bbdd017977..7d0c4b17c0bdf1 100644
> --- a/Documentation/networking/xfrm_sysctl.rst
> +++ b/Documentation/networking/xfrm_sysctl.rst
> @@ -4,8 +4,8 @@
>  XFRM Syscall
>  ============
>  
> -/proc/sys/net/core/xfrm_* Variables:
> -====================================
> +/proc/sys/net/core/xfrm_* Variables
> +===================================
>  
>  xfrm_acq_expires - INTEGER
>  	default 30 - hard timeout in seconds for acquire requests

-- 
~Randy

