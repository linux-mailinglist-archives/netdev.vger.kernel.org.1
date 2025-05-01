Return-Path: <netdev+bounces-187305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4FAA64DD
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594331BC07F3
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3251225A5B;
	Thu,  1 May 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BevXe5wb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96731E9B07;
	Thu,  1 May 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132246; cv=none; b=ej/Hh74azyKbU9hERbt1wUCgNqnraETAWSaHcXQkhmNXQTCJYTw0LGlC57OdYu7L3Xy3rHSVOWKVeRsTeFCzVx3RHttQcODcV5THeXCSLioINjdz9PtEAGxPNQGrzSUV0OHBVIRcdVq87GVcOk6YJBlDLOWtl4V9MzIC+txUB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132246; c=relaxed/simple;
	bh=+bcEEHO7cmBx0tkqXSmRjumWAGStNG0clgyqUo4+AVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW8Y2I7WNlnkSTiIipek3EDjAOUgyRhhLRARRC8tj9O9GrwQCOUIInUGg1TCGHLHyHC4CuamADOk44fDKZNy65+xSvPe8jGjs/x+UWLKcDVntLMDz2VyBQS2ef2uMDyw6PuMVEPDeqUvF+irdguexrj2UGVpYK0+SNCcRe/94ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BevXe5wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4601C4CEE3;
	Thu,  1 May 2025 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746132245;
	bh=+bcEEHO7cmBx0tkqXSmRjumWAGStNG0clgyqUo4+AVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BevXe5wbVtTTTNyREagLUzH2GKbrqlBm8pbAjPxE1yiC8Tt1JS4YFubBjO9VtLuUT
	 6s3Uw6DbbJlZ5ze0LWH9tFdeY0fiMkxIpAd5lKz9Jgl+tjZkboG2/tnDdNTjliMBq/
	 0IyHfW8wIvpQoS/eGYH0fKuYpgV2DjAdzxctfERwkoKvp7Ys61sSASydtV2b1GOsI5
	 xCEDH3IcODjqvVNBNnk9JLmG6oiIaMwFGLgMrrBv/enPSkHdr1tcMNIx7qIm6a7fYw
	 p78lS/YFwgejBwCSpD/AseH1CwNXH99t9A441XMeEtlL5DfxnZURRptSQuksjAOX0C
	 dJsDkUntDve7w==
Message-ID: <e1e1fa75-e9c2-4ae7-befb-f3910a349a9f@kernel.org>
Date: Thu, 1 May 2025 14:44:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 ip6_rt_copy_init
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
Cc: syzbot <syzbot+8f8024317adff163ec5a@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, elver@google.com,
 horms@kernel.org, justinstitt@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <68135796.050a0220.14dd7d.0008.GAE@google.com>
 <202505011302.9C8E5E4@keescook>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <202505011302.9C8E5E4@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 2:12 PM, Kees Cook wrote:
> static int ip6_rt_type_to_error(u8 fib6_type)
> {
>         return fib6_prop[fib6_type];
> }
> 
> Perhaps some kind of type confusion, as this is being generated through
> ip6_rt_init_dst_reject(). Is the fib6_type not "valid" on a reject?

fib6_result is initialized to 0 in ip6_pol_route and no setting of
fib6_type should be > RTN_MAX.

> 
> The reproducer appears to be just absolutely spamming netlink with
> requests -- it's not at all obvious to me where the fib6_type is even
> coming from. I think this is already only reachable on the error path
> (i.e. it's during a "reject", it looks like), so the rt->dst.error is
> just being set weird.
> 
> This feels like it's papering over the actual problem:

yes, if fib6_type is > than RTN_MAX we need to understand where that is
happening.

> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 96f1621e2381..fba51a42e7ac 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1092,6 +1092,8 @@ static const int fib6_prop[RTN_MAX + 1] = {
>  
>  static int ip6_rt_type_to_error(u8 fib6_type)
>  {
> +	if (fib6_type > RTN_MAX)
> +		return -EINVAL;
>  	return fib6_prop[fib6_type];
>  }
>  
> 
> -Kees
> 


