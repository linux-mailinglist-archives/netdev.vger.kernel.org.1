Return-Path: <netdev+bounces-162202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91489A26307
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232E7161B8D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB38192D96;
	Mon,  3 Feb 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3+p2s2L"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2315383A;
	Mon,  3 Feb 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608729; cv=none; b=sk0/8IgMeMam3tCOt365STa0pvUAN+QISOK0mg3pjmyCGs2CbSETYZhSV5GcAZkTNKKl9RYK0PGsZpYxWjyJVZb3Fqkqg5EaeLnmGgU7At+EnMs460uJFP84jzjETPUZB5JrHq4Ne45HS1qrSnBz/FMhdksM6tP8TaF9gp4WcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608729; c=relaxed/simple;
	bh=+ARQPFnKVwmy9ajJ2GiTXPpjLc7E7Czv7/uNI3NNyT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2/lqc3z9FTAR0qYuWLOo5q0E5Eu9Kudk3xTwmQ4r983etiUdO8mAHrGg1+bPaf7GMpWkPd+88BqEzCg3wlkgaDtjM1J2Ah98kX3rIMk3jZ6jWhPIBqJg6/ARtKNFy23LKeZLw7zPFmP0sh/ioLfb6WsIqhV3uaRSw5YYblwc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c3+p2s2L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=YTbN/a3nvE+dze/X4n8jk+rd+TndEpXCvl/gOnToy2Y=; b=c3+p2s2LwoWj/3fvwytdsWDpJ1
	DUXXHRIul3P0scp3nbYHCaMxU1z/snV9LSe9wVVbTa953KTYFwOgDT+ZmGm/op1IoQadQf5Yo7+zc
	P2aTKQn47AY3oyGgEm1v4QPjQmjA0+8a4CqwUit8tvUZuB/RYcw7Ek7m88U1pURJIqArnwNsp67tK
	0O5k/fMz8slyYrPzD3bT7IsActeAXeuTdfECcbC3lBdwm7dLsgjvXSfccpwHcHk6I9umT93syboT9
	pq8wHKE1gYlkXQubqGYefuTyfVn+C4wNkmqSf7JfQYAkueuWez1OekIgh+VUUsYE77g4ifInkxiBR
	4t+T4i3A==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1Y1-00000001VQy-3o6G;
	Mon, 03 Feb 2025 18:51:54 +0000
Message-ID: <f3600acf-63d9-4504-8b11-7b0c8ca4c3f3@infradead.org>
Date: Mon, 3 Feb 2025 10:51:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 netdev@vger.kernel.org, workflows@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

Another nit:

On 2/3/25 5:59 AM, Simon Horman wrote:
> Document preference for non inline functions in .c files.
> This has been the preference for as long as I can recall
> and I was recently surprised to discover that it is undocumented.
> 
> Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index e497729525d5..1fbb8178b8cd 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
>  
>  Conversely, spelling and grammar fixes are not discouraged.
>  
> +Inline functions
> +----------------
> +
> +The use of static inline functions in .c file is strongly discouraged
> +unless there is a demonstrable reason for them, usually performance
> +related. Rather, it is preferred to omit the inline keyword and allow the
> +compiler to inline them as it sees fit.
> +
> +This is a stricter requirement than that of the general Linux Kernel
> +:ref:`Coding Style<codingstyle>`

Is there an ending period (full stop) after that sentence?
Could/should there be?

Thanks.

> +
>  Resending after review
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> 
> 

-- 
~Randy


