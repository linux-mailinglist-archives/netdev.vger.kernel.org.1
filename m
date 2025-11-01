Return-Path: <netdev+bounces-234871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303FC285C3
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 19:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 924CD34953B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863512FD1B7;
	Sat,  1 Nov 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jymu7hBN"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C52FD677;
	Sat,  1 Nov 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023390; cv=none; b=prrtxwmGvolEX1ttTD2tD1MYY+JLyHUVYMS1/gMAYAkd+LWgXnFR5F2Asjl9jLBhLGjzRIk/Bw9BAdwYbiCT3XMZzR/D/kV4vCvPjqTM66XNuuPaHYYhd/MoOMSVYJ2jiPrI8tp/mjwx5s4b1KJznvUS6tvSYUlOEFMLYpDF6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023390; c=relaxed/simple;
	bh=YigTw67cglsLpViZ/Okqy474ew4KBKQ6k5eBmEwkqZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS+92z08G9RziKbyDSmgWg+Jq39qBGIN/LnJU6Ndx5W6vfNc8JgvfFdSc3pMgYaqWP9JFP/j2g2rGl79uFO5cgFI/cqrVwmyz+Buodn3fusjBrRGNzQDNBVeudAeS1ZbqOqbI4GSbk6bBXJcFMzK76kXADgeeGve6JJOelyV408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jymu7hBN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IwPweGT8fgKILjcq4Sa1wHAoIlkTe2YX4D0a/ia0Kuc=; b=Jymu7hBNuumDCpQbLwkwa7nR1b
	G4YSRYEbdtvS6fENPzQEaroDa7G0aqk5ZPfka4azXb5CrvyLsSjeHsjQoZHo0cJVkXjxo5yT6wkjh
	jQEBjLyEYBI38Enf5xJDJTs3/JgaAM77yFodxpYAOhhjW5+u/xeuDP5pAe5RPTFXriaAEFcnsugrQ
	/cAllV7Jw8uXO1gHsjb+c5poDw9nwHYrGHINoBY4XErQdRt9XtmxoZXFDG9OXMe2HGhimD9iYBGda
	Mdtfn9a6xJdr7zPV+0j34iBjCy5aa+hMEg0RbMGYHfkfIwaPi9MdSsFsL8sokbLh8EhQfUJ+gjai9
	0FWyR7Zw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFGm1-000000081YO-0xqc;
	Sat, 01 Nov 2025 18:56:25 +0000
Message-ID: <d5db214c-8216-4f6a-a64c-8a636f194202@infradead.org>
Date: Sat, 1 Nov 2025 11:56:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/8] Documentation: xfrm_sync: Trim excess
 section heading characters
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
 <20251101094744.46932-6-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251101094744.46932-6-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/25 2:47 AM, Bagas Sanjaya wrote:
> The first section "Message Structure" has excess underline, while the
> second and third one ("TLVS reflect the different parameters" and
> "Default configurations for the parameters") have trailing colon. Trim
> them.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Documentation/networking/xfrm_sync.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
> index c811c3edfa571a..de4da4707037ea 100644
> --- a/Documentation/networking/xfrm_sync.rst
> +++ b/Documentation/networking/xfrm_sync.rst
> @@ -36,7 +36,7 @@ is not driven by packet arrival.
>  - the replay sequence for both inbound and outbound
>  
>  1) Message Structure
> -----------------------
> +--------------------
>  
>  nlmsghdr:aevent_id:optional-TLVs.
>  
> @@ -83,8 +83,8 @@ when going from kernel to user space)
>  A program needs to subscribe to multicast group XFRMNLGRP_AEVENTS
>  to get notified of these events.
>  
> -2) TLVS reflect the different parameters:
> ------------------------------------------
> +2) TLVS reflect the different parameters
> +----------------------------------------
>  
>  a) byte value (XFRMA_LTIME_VAL)
>  
> @@ -106,8 +106,8 @@ d) expiry timer (XFRMA_ETIMER_THRESH)
>     This is a timer value in milliseconds which is used as the nagle
>     value to rate limit the events.
>  
> -3) Default configurations for the parameters:
> ----------------------------------------------
> +3) Default configurations for the parameters
> +--------------------------------------------
>  
>  By default these events should be turned off unless there is
>  at least one listener registered to listen to the multicast

-- 
~Randy

