Return-Path: <netdev+bounces-60628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941A68206EA
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 16:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EECD1F217B5
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCC8F5F;
	Sat, 30 Dec 2023 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYb6Vf7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7E9465;
	Sat, 30 Dec 2023 15:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBAEC433C8;
	Sat, 30 Dec 2023 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703951004;
	bh=SuzsDyrq9tElbdRWEvJbRs0oWgQ3fj2Ces+leef/fTc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sYb6Vf7jdbjOiARQjFAbWIDbFBG1vQ1/2f1bL9q8EO+ekQpUUhT+0AWQLzjNHy8n2
	 3n1Fx74m7vOiyByepGwTaduZVoTTtIC4OnR3Yp5j/t6YMYKToZWDlepox2kBUg7V2f
	 z3NYt4sm/uLvpU1dCfCxzSUYxEOdj2KKwGUM1U5RdzTAjuxhSsUp0S7lRv+kCPYcnV
	 hZQ0chlPv3eORsYP1Is9+ZsXnR4/T+xdyx2wYXvMato/8efba77HtwkffdnE/FauIB
	 pbP3jp2jakxXs+HH0rWL4YGhTTWQrIVcNh7dC7kCS1pglPtzYWeMNq4lQeWGjpMECx
	 t816iD1ET9ZLA==
Message-ID: <41f047b1-e871-404f-9afe-e4d5f9012c01@kernel.org>
Date: Sat, 30 Dec 2023 08:43:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "net: ipv6/addrconf: clamp preferred_lft to the
 minimum required"
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 kernel@vger.kernel.org, regressions@lists.linux.dev, dan@danm.net,
 bagasdotme@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-pabeni@redhat.com, jikos@kernel.org
References: <d2f328c6-b5b4-46d0-b087-c70e2460d28a@kernel.org>
 <20231230043252.10530-1-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231230043252.10530-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 11:32 PM, Alex Henrie wrote:
> The commit had a bug and might not have been the right approach anyway.
> 
> Fixes: 629df6701c8a ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
> Fixes: ec575f885e3e ("Documentation: networking: explain what happens if temp_prefered_lft is too small or too large")
> Reported-by: Dan Moulding <dan@danm.net>
> Closes: https://lore.kernel.org/netdev/20231221231115.12402-1-dan@danm.net/
> Link: https://lore.kernel.org/netdev/CAMMLpeTdYhd=7hhPi2Y7pwdPCgnnW5JYh-bu3hSc7im39uxnEA@mail.gmail.com/
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  2 +-
>  net/ipv6/addrconf.c                    | 18 +++++-------------
>  2 files changed, 6 insertions(+), 14 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



