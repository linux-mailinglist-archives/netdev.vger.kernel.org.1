Return-Path: <netdev+bounces-224085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ADAB8096B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A8F623A43
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76333AEA5;
	Wed, 17 Sep 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu2UriZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4D33AEBB
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123034; cv=none; b=nqumaCGUp5ifA7oNlhLD2i9zIt6ikiXEf1xa6HV9K6jW/SdSajaeZQlh1RLaiZhGlrbuNR8tj5Uvh/Fy0DvRbYag+DhPpM6AbqKlyaStatBMfKMENRippuo2kdwJDNiavBqVED3CHDcsfKqR21DPLtUf4m2G+leAt0piOvsr53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123034; c=relaxed/simple;
	bh=rQtaAWifWer/HWQ5iIeM0d7RTgmb27MzOxlHJR7+tkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAOrAqOGDg50uky6qJDZJIEBhfFG+RfvydjNJdU8J6htcukArookR31PgLVjRFYBcdFh1x/Fo4zSlU9x06nIXbHB/LcEAWyYjdNcJjVdmytMrLwEsvfWUYBQLlBv+jnhhMCA7IN5Ksfzb/B1mFlZgHvKQL7lR7I7VxXGMOZVnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu2UriZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4269C4CEE7;
	Wed, 17 Sep 2025 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123034;
	bh=rQtaAWifWer/HWQ5iIeM0d7RTgmb27MzOxlHJR7+tkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vu2UriZ5YJ7zYdrHwiqR4lwyTSN8Vdyohet92/9gMVEPCCD4TZuoDxbMGPON5tFoI
	 8QWBu4VLyt9aYoAqQkCIHxxHxToafE5xBaj0Cc7t9929IG69h35P6HkGaeejTXsYvT
	 uutMyAPOKJf0ZbBrSG8bqyfy2pMMcA8qSVIX8GNRwknafE9mplas9BPOflu6kn6DBf
	 f+j0+kQJRGhyjuDzQtbTzCtGgPi7HVZB7ZUz0USSBjzOc+xJh86G9ePIIUnuENDiPd
	 QVMVAF1IyV0sQveq5vGpL0sMBba4elfUjit6bEVq/fIBqZYp0/f0upwpnBRImXa+Sm
	 mJs8MOwjeUG0g==
Message-ID: <b955eb49-a177-4aaf-9e5a-e2a9ddeef1cf@kernel.org>
Date: Wed, 17 Sep 2025 09:30:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] ipv6: make ipv6_pinfo.saddr_cache a
 boolean
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> ipv6_pinfo.saddr_cache is either NULL or &np->saddr.
> 
> We do not need 8 bytes, a boolean is enough.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h             | 4 ++--
>  include/net/ip6_route.h          | 4 ++--
>  net/ipv6/af_inet6.c              | 2 +-
>  net/ipv6/inet6_connection_sock.c | 2 +-
>  net/ipv6/ip6_output.c            | 3 ++-
>  net/ipv6/route.c                 | 4 ++--
>  net/ipv6/tcp_ipv6.c              | 4 ++--
>  7 files changed, 12 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



