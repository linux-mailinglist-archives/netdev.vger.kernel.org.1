Return-Path: <netdev+bounces-69921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA784D0E6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B7B26CD3
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02483CBD;
	Wed,  7 Feb 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTDSDP6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F97128816
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329168; cv=none; b=kxtszO9ZcaWveCejE7vljcJhXQ4C/Lt16dWH1WGFhJo8AS0wLsxos3XbwSHPzN2XbZd7h+aSirzSg/scJcwjxYO9eEnM9jM1HKSo2w0GLjzztI25WslcIvokXYwDIKjFL1hV0M8gFLo16P7zC94qDFMazBXegtLedogscuYbKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329168; c=relaxed/simple;
	bh=cAKAxvCuN9Ik2FLPBgVEBYCxJ4XzFfOOpC2lROyx49U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrzsaBQiqxfpyVAaJfg/eXIyJziW8wBZcn/Z28Yf7gaP8X2q8BO4wAUdnuriUhiqSOoYGCSjv5gOlS0LQ5uY7883ng97VElqleT6aKGE3TqNtVrMPGxzDmPt/I2MJEFp/1grEIhUk4oz9KQcb2f/tFdYVVBgFxoHRP6FX5QUx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTDSDP6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E90FC433F1;
	Wed,  7 Feb 2024 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329167;
	bh=cAKAxvCuN9Ik2FLPBgVEBYCxJ4XzFfOOpC2lROyx49U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hTDSDP6kyFSEaMX+KeChpIVjBioTrU7faBthGffSZ/QB5amAF907uIgiUYotM2lF6
	 tModJLKaDc+kh4DW+5MZZJOe+Rt+d/630PXxZLkubatdYf5FZkysxPgwub+ftvpjd5
	 AiT1yneFJJKXnYzbgvqTqzimyEUziqchn/VGVSp1XmioqpsU3f1D2l9WuD3VpneleC
	 4ksLEomN6TOMjX9CMD8FSy2tf+03myzJUjA04pPosUtX7Ex8XaVTkCY5cGfqFSQr2/
	 6ibOEDnMShT9Dhmo8Pa8m7RvRAaSV6833G2OjGV6FQuX2Ft2fxdRN8TxlAu5r/Vie3
	 tWG37Vrr9aReg==
Message-ID: <6c926973-a6c5-43e1-8249-c5ee25ece715@kernel.org>
Date: Wed, 7 Feb 2024 11:06:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 07/15] ipv4: add
 __unregister_nexthop_notifier()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240206144313.2050392-1-edumazet@google.com>
 <20240206144313.2050392-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240206144313.2050392-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 7:43 AM, Eric Dumazet wrote:
> unregister_nexthop_notifier() assumes the caller does not hold rtnl.
> 
> We need in the following patch to use it from a context
> already holding rtnl.
> 
> Add __unregister_nexthop_notifier().
> 
> unregister_nexthop_notifier() becomes a wrapper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/nexthop.h |  1 +
>  net/ipv4/nexthop.c    | 19 +++++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



