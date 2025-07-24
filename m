Return-Path: <netdev+bounces-209757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA089B10B56
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062AA583525
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516682D781A;
	Thu, 24 Jul 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRwFfiSi"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A02D641C
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363528; cv=none; b=XhZ7yZBfVpzdJsONhH/x7LjrpFjQQHuegs+OAO34TLQ9xT2h192qJK3HcUqPlt1SVsGVZV7JH3EtWvd/RpjeOni4CnDtNpvsyyIcyw3RtFY1at4kCJoFzTkY+hlkV15vaY9AwgLQqoIA1WDgDqC8R5Rm6PRqFs3S1V+qFEp7uFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363528; c=relaxed/simple;
	bh=++PbZMPB9w+uxx6N/IcuC9y7r1xlp0Hw0nxM4L8VEsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPC2lrETV6T+lcfPp09xnpZZ+TLvcqbJbW/WQXs355w7nCw3LwX+spxNZQEHREqEHXz9SLpvIgtdhFfK1nQ1K6Z91vixYVcBGXOaM0OFFt7a7WmLqgfqzqzM1c0BVIroMcwwectDqWavW09h+mlmgoZLLh1y5p8jaqdf3paqP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRwFfiSi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a716f1d-5a37-4634-be93-ba37b3b817c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753363523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEXQdyoUreQlmJlsZ2BgZUtS3jfDILQNhinD3l474p8=;
	b=fRwFfiSiAciRirtf3vltzdHFAjFtGJ2m5X0Ei52Y3TTpxY70+RDaQ+EBEoQghrlPwtOFC9
	2o7Gs44F7uFXst1T1trgXe5au0Y9sb+5hNPRmch9NdjBdv1teOSXwH0c/nErxPgmMoEfjR
	Vy07839RGq3SSM7onsbrOt8YkCrKU/I=
Date: Thu, 24 Jul 2025 14:25:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] octeontx2-af: use unsigned int as iterator for
 unsigned values
To: Simon Horman <horms@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250724-octeontx2-af-unsigned-v1-1-c745c106e06f@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250724-octeontx2-af-unsigned-v1-1-c745c106e06f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2025 14:10, Simon Horman wrote:
> The local variable i is used to iterate over unsigned
> values. The lower bound of the loop is set to 0. While
> the upper bound is cgx->lmac_count, where they lmac_count is
> an u8. So the theoretical upper bound is 255.
> 
> As is, GCC can't see this range of values and warns that
> a formatted string, which includes the %d representation of i,
> may overflow the buffer provided.
> 
> GCC 15.1.0 says:
> 
>    .../cgx.c: In function 'cgx_lmac_init':
>    .../cgx.c:1737:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size between 4 and 6 [-Wformat-overflow=]
>     1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
>          |                                                 ^~
>    .../cgx.c:1737:37: note: directive argument in the range [-2147483641, 254]
>     1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
>          |                                     ^~~~~~~~~~~~~~~
>    .../cgx.c:1737:17: note: 'sprintf' output between 12 and 24 bytes into a destination of size 16
>     1737 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Empirically, changing the type of i from (signed) int to unsigned int
> addresses this problem. I assume by allowing GCC to see the range of
> values described above.
> 
> Also update the format specifiers for the integer values in the string
> in question from %d to %u. This seems appropriate as they are now both
> unsigned.
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

