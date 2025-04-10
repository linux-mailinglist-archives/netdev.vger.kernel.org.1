Return-Path: <netdev+bounces-181320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8810A846E1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F6D1715D5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B11DDC1D;
	Thu, 10 Apr 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VooPY3R2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E416FF44
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296653; cv=none; b=gI0NTiB2MC35kDbJ6wpC2V2wKHx54P0rUU//G77+4L7GJDD2JwI3Q9M4669eKedcUPfk4hTeswfZOk9cqzDGO4GQ6BuxovkEejLOVS4v3oTTqvqFuUSXJU6A+WVoHoduSX+TggagXnC/GV/CnXvehIjCRuzzSMGH+jQYYZqENms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296653; c=relaxed/simple;
	bh=r/+xj/2SCQOifoTkYgsnzj5gMF1y2LkdK8RXNd0U/+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHlKAYXAxbZD1H3AlbrYADp18WhebOY9fAYaB2bliz+Z3Yu0VZYjHW8Y1pyj3qCJWAb6Rcz/p2yzfQETl66BuFlKAmKW6FAOuW+M8xti0kW3IPO1weAGVjLeNodrJ6kOxrTYpMV0NmgFoCQuL86JnslK8wcfk3jp1DXPAdVLNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VooPY3R2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C69CC4CEDD;
	Thu, 10 Apr 2025 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744296652;
	bh=r/+xj/2SCQOifoTkYgsnzj5gMF1y2LkdK8RXNd0U/+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VooPY3R2w60o3sxhxqdyJed8gYp6dJ4ow50zaDbaXvI0Q5kilV//qhMLoamkfD1Vn
	 HuxU1etC/y6dazf7jGHWw6AnPUizTm6MePseTmj9f9EOjOhg6QMi5cxQVLNQbU6DnJ
	 TVIh68MpRDuhXeG45qJfTeuuRaWRwlBWN5EvyRP/9LsGHIr6+XEF7gwEVHSFH6Y6xW
	 uHDhSCZALCZGfXk53b9J+vMZfDsUv312Io7fzO7QqG6N48UsVuNVW7NsCGPl8yFC5q
	 JsZC3kZEN5R/IV0xfxDTKClnw2cW5H0CU2bFNiiRywYUa17sV1QW/rYP11H+GJGstI
	 2uyJYsIgIZxGw==
Message-ID: <e1f08711-e6b6-4129-9121-78a52198b34d@kernel.org>
Date: Thu, 10 Apr 2025 08:50:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 07/14] ipv6: Convert tunnel devices'
 ->exit_batch_rtnl() to ->exit_rtnl().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-8-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250410022004.8668-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 8:19 PM, Kuniyuki Iwashima wrote:
> The following functions iterates the dying netns list and performs
> the same operations for each netns.
> 
>   * ip6gre_exit_batch_rtnl()
>   * ip6_tnl_exit_batch_rtnl()
>   * vti6_exit_batch_rtnl()
>   * sit_exit_batch_rtnl()
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  net/ipv6/ip6_gre.c    | 22 ++++++----------------
>  net/ipv6/ip6_tunnel.c | 24 ++++++++----------------
>  net/ipv6/ip6_vti.c    | 27 +++++++--------------------
>  net/ipv6/sit.c        | 23 ++++++-----------------
>  4 files changed, 27 insertions(+), 69 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



