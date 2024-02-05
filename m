Return-Path: <netdev+bounces-69024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3D8492FC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 05:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8442829CE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B658BFA;
	Mon,  5 Feb 2024 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvYJ0EZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D2BE47
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108147; cv=none; b=t4nE+PyxZgpdN0a8iXZWvOozjKfkq/sEljUY+tJKw3POsVWiL4kc8RKBX09Hjuc9i1Q58lTZhTN2S/l7hMngF0B3RiyWhQUsmYyQQ5Edmp1N8Jq65M2Dtbfed7iVTooRcr9yj3+0HvYAfsPQwCBvLdqBPpbN7s7tJ6qWHQ+PY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108147; c=relaxed/simple;
	bh=ZT5n0LsFax+60TmZk1Jf8zcD6OTCxxqDRrMjnBkSo50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCVYyYQtzDrx66i/Y6xcTa/L5hwE5nTiHwZlMjNgOlGycf+M4ylX+c+NR4eMuGIg9NAOYCw333mbE/pHk45xGyRBd37ZVO/HP+0Hxj1k15EDmd08pvie6VUgKMYnSiEoUdB0TiXIFGv9wV9oILPi66FKxZTNtHRi+/bKgzGTlA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvYJ0EZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5190C433C7;
	Mon,  5 Feb 2024 04:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707108146;
	bh=ZT5n0LsFax+60TmZk1Jf8zcD6OTCxxqDRrMjnBkSo50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UvYJ0EZhWccPym6qL1koz2y8fyVTFbDO3KwPO5OLU8rM5Za9dt5SRLWxWa6HSMz60
	 uyErejVlGyz9Ho5XrHJGtrbDLDHRwvIKETxYObxAxLbnMLDJQjAPZwqxFjoDdNDkAn
	 6RG6vASMtlzVOUzujSKWjlqETiM00fQU+3y4XZUAgEFE7E1UysQh9v9KLnOQqqsNha
	 sDlhvKCD7KqI7S95M4Eshv1gtJB6R+2Bdop/tIMEdqSjFFjmy7ObfSlnWu0R3o182d
	 pj6UgsfDnuF8io8I5eh1r5mwOLndfMvIB5IFLC3h75A0M/oqFn5sV9MBhSJjAUKc3j
	 mEeFU5GEdYpVQ==
Message-ID: <7eaf1386-3ddc-40cb-b975-ff80a6504b41@kernel.org>
Date: Sun, 4 Feb 2024 21:42:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net/ipv6: Remove unnecessary clean.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-3-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240202082200.227031-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 1:21 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The route here is newly created. It is unnecessary to call
> fib6_clean_expires() on it.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  net/ipv6/route.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



