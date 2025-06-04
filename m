Return-Path: <netdev+bounces-195117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC580ACE1D0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A9188D82B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED341D618E;
	Wed,  4 Jun 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQowTxMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593491CB518
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052615; cv=none; b=ueWUqsjdsdyHHJ973IgEJftQrWPdupUPDkqmhhPJ+tWEhTgunQpzGBUYtnfRE5FvpRvWDXJ5GN8NVmE96EQ7aHgsgN5X7WRlA4I6QKE6JmU3++eVnLvdc6v4iLSsTaOkjhDyRx+nEIsfjlBUsJYAoVaazigwm85hs5Ibo0x1R7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052615; c=relaxed/simple;
	bh=f8DDcESDrsiykgCjvPNzSMdVbHhkDsCq0mVaR6Q5b8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhoiYIVDVbRwqrLSdEHA62UuLi9olFVl+zc5c3wUGGVDoXLlcv+1oQM4TuydfbJ/CqV1NRLjQRsxihx4g0IB911vAf+hSEp/ReFiE3skBJu0kycWg9QB8X0FppyIKJDJeye9DTJTo3eHAAJBpSOKjRg+9Q2mQM0ENCIkg3FYM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQowTxMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE553C4CEE4;
	Wed,  4 Jun 2025 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749052614;
	bh=f8DDcESDrsiykgCjvPNzSMdVbHhkDsCq0mVaR6Q5b8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FQowTxMU0KWm0LFq73Igk9dxh2Spl4DDYw7/9uNKhV5SHx9+GIRcCy654L9s751bG
	 kBkIplTaIXmIZ0cMvy4PryCbQ6Or/VfPzQKvIEgJXesvAc1JN9n0nwUSfvtbsKvV0b
	 3Ukw+JG6ZdK/BjdfOMIqm0p+CY0O8n4hgtZxXBxo/JU0fGSHLkeLoasg5gzA4x+Rco
	 4etGSBI2hanOZLJowMKBfpXPWSTRL/kdFTyu/4yfePEp0sveN3lF3QVQO0yLv5AUgB
	 b76xFNZlHG6srUtR7HXqRtfYlFkBJPIPM+FZc/OGlcpztbAAh+/FAMw+6MbxL/RQYl
	 2MoHikkBkyzbg==
Message-ID: <229ed61e-b9cc-4c35-ad40-ff14391a74aa@kernel.org>
Date: Wed, 4 Jun 2025 09:56:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: Fix validation of nexthop addresses
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrea.mayer@uniroma2.it, horms@kernel.org,
 david.lebrun@uclouvain.be, petrm@nvidia.com
References: <20250604113252.371528-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250604113252.371528-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 5:32 AM, Ido Schimmel wrote:
> The kernel currently validates that the length of the provided nexthop
> address does not exceed the specified length. This can lead to the
> kernel reading uninitialized memory if user space provided a shorter
> length than the specified one.
> 
> Fix by validating that the provided length exactly matches the specified
> one.
> 
> Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local lightweight tunnel")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Noticed this while extending End.X behavior with oif support.
> ---
>  net/ipv6/seg6_local.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


