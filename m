Return-Path: <netdev+bounces-239623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADAC6A879
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0428D4E024B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75636A022;
	Tue, 18 Nov 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVU4HZq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B67368283;
	Tue, 18 Nov 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481883; cv=none; b=GofPiAeGaY5dTqfOuRWyZlDJ3G9dnw8ejPiclz2sVUlLWKHKx+ayeXJDTOzNjje8TILn25N8M5mDzm3JujgluTfZmNUB+ZYAnty1ttmXoZ21Fc70qoN6QOcivfsUd9T2/kMG/rayebuKRTf+KwuXDNjbjcpQQM87Y0AuIyY/ZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481883; c=relaxed/simple;
	bh=i0LbVI+QNFWoYKWn/EVjpgtC/3PUyI8ix5LquE4m9wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4Uj+rSBMBvLnfeiFQ1OnWxlmUSx63/8fHRb+N55wUQXPPA/UBHBiCj0iR8zvVu/9Nd03bw+EgDACn4kbUEti8UXtNb2aaR8W+BWAFgF/k4ocptN6onV/YVXU7kB/Z2v5MOOZ6kEwWr16vRNK4szHIdSkRc99OxZUTLl80w5zFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVU4HZq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80574C2BCB3;
	Tue, 18 Nov 2025 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481881;
	bh=i0LbVI+QNFWoYKWn/EVjpgtC/3PUyI8ix5LquE4m9wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uVU4HZq3cLW1JlSW+0iPXXroPICFFq6Ai37vB7ZBB3pZzgUcFLtCdCeNKWc2fOnfL
	 XDliMUIydYTqXD8rOCXjcRseAFX39NixnNUoTDXWx59i+m5PiZhcZTAbma3HGxowFs
	 EClp880TWyqAfWo92j9abu7CkeFJMZAcIB/cG76UnjOi8lCGgojIfL6wb3+ilxPuTY
	 eWduF9BlnpoKHbbiHTMUlVPhHT+PCLaLhLL33F1MFP2ob5ceei9TQmqrzkzbqLtzhy
	 TJ817GAms/Aa7owT9iINOmNwxzuIA1gTc4q3rsEjca4MjSguxB9tMAXGBdS2RVmVXW
	 an2UGN1/YhrLQ==
Message-ID: <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
Date: Tue, 18 Nov 2025 09:04:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
Content-Language: en-US
To: azey <me@azey.net>, nicolasdichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
 <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
 <19a969f919b.facf84276222.4894043454892645830@azey.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <19a969f919b.facf84276222.4894043454892645830@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 4:00 AM, azey wrote:
> On 2025-11-18 10:05:55, +0100 Nicolas Dichtel wrote:
>> If I remember well, it was to avoid merging connected routes to ECMP routes.
>> For example, fe80:: but also if two interfaces have an address in the same
>> prefix. With the current code, the last route will always be used. With this
>> patch, packets will be distributed across the two interfaces, right?
>> If yes, it may cause regression on some setups.
> 
> Thanks! Yes, with this patch routes with the same destination and metric automatically
> become multipath. From my testing, for link-locals this shouldn't make a difference
> as the interface must always be specified with % anyway.
> 
> For non-LL addresses, this could indeed cause a regression in obscure setups. In my
> opinion though, I feel that it is very unlikely anyone who has two routes with the
> same prefix and metric (which AFAIK, isn't really a supported configuration without
> ECMP anyway) relies on this quirk. The most plausible setup relying on this I can
> think of would be a server with two interfaces on the same L2 segment, and a
> firewall somewhere that only allows the source address of one interface through.
> 
> IMO, setups like that are more of a misconfiguration than a "practical use case"
> that'd make this a real regression, but I'd completely understand if it'd be enough
> to block this.

There is really no reason to take a risk of a regression. If someone
wants ecmp with device only nexthops, then use the new nexthop infra to
do it.

