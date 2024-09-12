Return-Path: <netdev+bounces-127900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB2976F92
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3451F249A5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD817837A;
	Thu, 12 Sep 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="AloeqwPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291180B
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162257; cv=none; b=i72M3krP1vjs9khRDqBBzWKqUPQRMKBJQa3+Oi9MYGZUo/ggSVrWV0oHZtUwYSiSUxRNTTCj1cJS2cefKKImYnxcZr1qEnYWL7GPuYXkYt9Jsegpua6jZ6N/t4jvINxa2bYLOVCgiaDVkgKsNde3a8q74dxVmOI87mv4UPOCMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162257; c=relaxed/simple;
	bh=eD1YwOOfm4ZDKrIxqWl7qhFwM93j7BlfJsU7w40/iRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yh+q1Upcb15pNXltH2NEyHJQyP+fbC5n31oYL3gbYPyuG+fzXofgwEd5czSdc5eZwVy3og4Gs1Y0cqMdi00/9dt1gljkN1TmDatOHGppC075j+OLqbA0Ej0IEt+uAW8QFSBEd8/fgv+iM+kBTaDiEVY2vn3QjfFEREJViDcP7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=AloeqwPj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1726162244;
	bh=eD1YwOOfm4ZDKrIxqWl7qhFwM93j7BlfJsU7w40/iRM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AloeqwPjo41qCVaOlLgcdh9VbtDnZFgR1JFStX4xl5kCu4RGXuplBOAVOdGwbeQH3
	 mjvSPqGeaVPHWW26y/yYzktF83MFz3zAy0Gq6M2whBmp//N/YZ6Ym/Hx+eQ/FKkp1G
	 2h1bavE8fwl9qNBrtg3PsP+fdTpE3kvRoCLVX40oOzcQXO1whH5ey/EDP0/yB80pgl
	 yEpG5i+XJl2MpjiMRJOn9GXeg/t6Hgggj0COKYbluavqYDm/hcCOmkgck3ONKOwlsP
	 MJ0wFuGWHZ3PF3bheKoced7WqaPZ0JGea+zSrpKMNnh7Jo3nP99NBq//owK7URUztM
	 lqpInGvIESB9w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A0A3260078;
	Thu, 12 Sep 2024 17:30:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id E8BDC200612;
	Thu, 12 Sep 2024 17:30:40 +0000 (UTC)
Message-ID: <2accf73b-ef0c-4755-82c8-fbe1758fc570@fiberby.net>
Date: Thu, 12 Sep 2024 17:30:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute] man: replace use of term whitelist
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240912172226.13352-1-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240912172226.13352-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 9/12/24 5:22 PM, Stephen Hemminger wrote:
> Avoid use of term whitelist because it propgates white == good
> assumptions. Not really neede on the man page.
> See: https://inclusivenaming.org/word-lists/tier-1/whitelist/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   man/man8/tc-ife.8 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man/man8/tc-ife.8 b/man/man8/tc-ife.8
> index fd2df6c3..7565c592 100644
> --- a/man/man8/tc-ife.8
> +++ b/man/man8/tc-ife.8
> @@ -120,7 +120,7 @@ Match with skb mark of 17:
>   
>   Configure the sending side to encode for the filters above. Use a destination
>   IP address of 192.168.122.237/24, then tag with skb mark of decimal 17. Encode
> -the packaet with ethertype 0xdead, add skb->mark to whitelist of metadatum to
> +the packaet with ethertype 0xdead, add skb->mark to allowed list of metadatum to

Might as well retire "packaet" while at it.

>   send, and rewrite the destination MAC address to 02:15:15:15:15:15.
>   
>   .RS

