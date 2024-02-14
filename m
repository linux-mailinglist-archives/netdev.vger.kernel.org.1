Return-Path: <netdev+bounces-71713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1968854D14
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108991C214DB
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C065D732;
	Wed, 14 Feb 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9JXnHsO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6575CDC0
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925206; cv=none; b=hpeFITYRFQ3a8rDGZuvS7VZ+3qP+6P8uTV3lFewNL5rvw2lynJw9iKasvYPV7vXALune1GGpKV/3eJOrZzW4QMt/1I1TXVrUBaSguWFCGsjf8xgMhBk7QtHv6/ILiLiJJbe1DuG3EkqhQVvQb1LQpnYgrlrl0vjT2ldFKY077SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925206; c=relaxed/simple;
	bh=TfLTaaFga3eO6GRl9+UpmmJ+YCVmTd+FMmCAOhuzOkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fbHLWnoYa6yWCW/kxoX5WJtO7uNvWBY3YdTLvcyzFi8wh4wHhUN65qW0dZyl/ibwCSMVGyOZmF7tdiPGyYZeGGkA5s1JDYitKPqJHZCBl1QeEUcUq7mEh3q/VzinX3s35ra+KqwhcJoz5pOUtDCNQ7uwx03lgnAT5bEjGdvmlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9JXnHsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507C8C433F1;
	Wed, 14 Feb 2024 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925205;
	bh=TfLTaaFga3eO6GRl9+UpmmJ+YCVmTd+FMmCAOhuzOkw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=I9JXnHsOAFspAFETfT90TB5E/OpdlRH0g9f5BP4IUP0z9ZpWnLuoUFxdY8HutqDPz
	 FLG/ccPD1YOR4edZ0ntEDGwMXmRTKS+sP8SZOBUF/4oukpzo3lE6AScJlLDHx2AUvR
	 ++QxlxD/h0R831EISUt2CROxHaFt/XuGAsU7ky+rmqSm5CYlKK9rB1AU4YllEAORTO
	 09WtHxc7MWfojh5m0IOtjoHZNNiXnQVZxGUZqCmZ9rhhivJwg1RuyjevVOFnnWhT1v
	 o1puWE6iyDDF/+Hooyd8irCwiPZ5gGAmK/077qyMH7m5yGyGHSXfu0SwVB+83AZti0
	 atAjspZGtjQNQ==
Message-ID: <28f82034-14d2-4c1b-8ff2-1a4b0dd04463@kernel.org>
Date: Wed, 14 Feb 2024 08:40:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: ipv6/addrconf: clamp preferred_lft
 to the minimum required
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240214062711.608363-1-alexhenrie24@gmail.com>
 <20240214062711.608363-4-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240214062711.608363-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 11:26 PM, Alex Henrie wrote:
> If the preferred lifetime was less than the minimum required lifetime,
> ipv6_create_tempaddr would error out without creating any new address.
> On my machine and network, this error happened immediately with the
> preferred lifetime set to 5 seconds or less, after a few minutes with
> the preferred lifetime set to 6 seconds, and not at all with the
> preferred lifetime set to 7 seconds. During my investigation, I found a
> Stack Exchange post from another person who seems to have had the same
> problem: They stopped getting new addresses if they lowered the
> preferred lifetime below 3 seconds, and they didn't really know why.
> 
> The preferred lifetime is a preference, not a hard requirement. The
> kernel does not strictly forbid new connections on a deprecated address,
> nor does it guarantee that the address will be disposed of the instant
> its total valid lifetime expires. So rather than disable IPv6 privacy
> extensions altogether if the minimum required lifetime swells above the
> preferred lifetime, it is more in keeping with the user's intent to
> increase the temporary address's lifetime to the minimum necessary for
> the current network conditions.
> 
> With these fixes, setting the preferred lifetime to 5 or 6 seconds "just
> works" because the extra fraction of a second is practically
> unnoticeable. It's even possible to reduce the time before deprecation
> to 1 or 2 seconds by setting /proc/sys/net/ipv6/conf/*/regen_min_advance
> and /proc/sys/net/ipv6/conf/*/dad_transmits to 0. I realize that that is
> a pretty niche use case, but I know at least one person who would gladly
> sacrifice performance and convenience to be sure that they are getting
> the maximum possible level of privacy.
> 
> Link: https://serverfault.com/a/1031168/310447
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  2 +-
>  net/ipv6/addrconf.c                    | 43 ++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



