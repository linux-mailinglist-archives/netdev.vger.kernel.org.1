Return-Path: <netdev+bounces-218974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2BB3F260
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3773BA439
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FD35948;
	Tue,  2 Sep 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXl6S2XA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C211D5CC6;
	Tue,  2 Sep 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780606; cv=none; b=D5pbgOd5TV6YZdxyOifY7oU/x1YpNY//Nq3w6/6FiInSZ2ZWHuCrYyOSfdOnkCTQbLQZ6P+ORoiSTngEePsFpxu1zC90dToYQPooMFYEXKSbEgb5NAKZmdQuuqhDypEoq0HWo4KcPXMlUxafJHhrptPPveE3ylcUU1tTHc5Ia78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780606; c=relaxed/simple;
	bh=G3UL+zhIEv+kcRJvzWxOeNkWYM7dcXV480M745+UwG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn/KPd54S0/eT98AzqZZUj0c5k9Ztf8jEENvY7w7gNkxPpLGZ/9P1qeAtEu1x8DMi6luxIy3I93vi/iSYcYCL6GpKAs6UyMJLCtY8oTIKxNhUp1wVQPhXTXkkUYSOBFVvvWb6RCX0YVfwWFm8tBgAbML70mcVpQCWkC0/RkorPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXl6S2XA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EA7C4CEF0;
	Tue,  2 Sep 2025 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780606;
	bh=G3UL+zhIEv+kcRJvzWxOeNkWYM7dcXV480M745+UwG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RXl6S2XAmGhkdjvce4ufYzb0PLNXcS4LLPvrip8VmIMWWjFMVRjeYl/x9QSce6SJj
	 yYFu+FnclDhyIQ0a5c0jXDMrW1lQjZQJnIVbdrQDtJshiB+4zauHAkCDqBllPyXbUp
	 v1EH/h3xa4GPOzFPvbB1TYDOgQZTKRAj1G+evSd5Z7WoSkJe3Uzcf7zhWO5wbU8/Jb
	 5QqZGl/2VB7Tse+BZHPdfvSlp48zTnYPZdF5AgeCjBz+v2wCnAsDZCMg9CQ2M2gPV3
	 uCdqF9NBl0Nl3gHYepNND4cS0bkXxWS6I8AOt2+WmOgkpxn7N5gfwy5iEjWWUgSGdE
	 BMvzTluoYnr4w==
Message-ID: <8e2200fd-65ce-46f4-ab28-2231ee85a2b5@kernel.org>
Date: Mon, 1 Sep 2025 20:36:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] ipv4: cipso: Simplify IP options handling in
 cipso_v4_error()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> When __ip_options_compile() is called with an skb, the IP options are
> parsed from the skb data into the provided IP option argument. This is
> in contrast to the case where the skb argument is NULL and the options
> are parsed from opt->__data.
> 
> Given that cipso_v4_error() always passes an skb to
> __ip_options_compile(), there is no need to allocate an extra 40 bytes
> (maximum IP options size).
> 
> Therefore, simplify the function by removing these extra bytes and make
> the function similar to ipv4_send_dest_unreach() which also calls both
> __ip_options_compile() and __icmp_send().
> 
> This is a preparation for changing the arguments being passed to
> __icmp_send().
> 
> No functional changes intended.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/cipso_ipv4.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



