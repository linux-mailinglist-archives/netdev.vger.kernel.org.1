Return-Path: <netdev+bounces-71446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB138534D4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53221F2A4F8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8325FF1E;
	Tue, 13 Feb 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiNM/kdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669885FF1D
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838574; cv=none; b=uKSZK7LEXLFTxPjcEzPh2uJcUPsObiDMIjopGINYg1nGEVmPRDmK1x1NF+i2a7WUU5fh3tZDahjhU7ssSn4pWE3j1i5ibmJU64GyupwfOT4NJUJbApkM2jGKDBwz66k7f9bO+sEzWbW4UZoqIzpLyJ8oKBFEzuml9Q65O6VElKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838574; c=relaxed/simple;
	bh=O24jml7aHnSI9nOmtkxatUqzG7Sgv6G7E46+iuSZY8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZaACdeI2wlt/jm0MTkLIMKJfM2XQtuyCTciVpQpVKkExRVG90HVIl4QLw1mLtMzilOpqLqSgEpevOuI3iM34UCg4cs+FSy86yxyFdIMwHgVJFYeMky/oHfgWMDMoscYkQI+YCVpcjlG31dfN1ScXWGQPBHa1gYGy6oQF+srobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiNM/kdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71945C433F1;
	Tue, 13 Feb 2024 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838574;
	bh=O24jml7aHnSI9nOmtkxatUqzG7Sgv6G7E46+iuSZY8Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iiNM/kdy+YT/9+FduYhO17/IRYpGmaZI+N8awAkUf16IhIyfJwJ3Ij/flcVwaa/38
	 VRFnXjtknRIfOz58dZTvjEXwWEMYsfYEZlsCDJvhi6/66XLm12afmFzt/2mP2XC3/H
	 kHqio5vzkzQ0bcBOlDdmVtE6PKwZV2B8aJiIWt/cVp6qHegA/qyYtzKYFHjRB/6VwD
	 2mENH71MlbakAVPLhhIjs6iyyWeImfQhkr7jr/juseAeotDvbPL1xp16qd94CzNDuo
	 XUOJkS9gXmaMcUQvz7tljf2BoIxz46iDnFIEvNFI39EtiqUgeoVgdx+xQ6ToscWlpW
	 1F+2vqA5X73JQ==
Message-ID: <94aad0b2-142e-40eb-b81f-c98457bd1b58@kernel.org>
Date: Tue, 13 Feb 2024 08:36:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: ipv6/addrconf: introduce a
 regen_min_advance sysctl
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240209061035.3757-2-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240209061035.3757-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 11:10 PM, Alex Henrie wrote:
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 7afff42612e9..fcd6aa71b4fa 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2535,6 +2535,14 @@ max_desync_factor - INTEGER
>  
>  	Default: 600
>  
> +regen_min_advance - INTEGER
> +	How far in advance (in seconds), at minimum, to create a new temporary
> +	address before the current one is deprecated. This value is added to
> +	the amount of time that may be required for duplicate address detection
> +	to detemine when to create a new address.

s/detemine/determine/

Add some more comments here - e.g., RFC 8981 recommends a minimum of no
less than 2 seconds which is the default.

> +
> +	Default: 2
> +
>  regen_max_retry - INTEGER
>  	Number of attempts before give up attempting to generate
>  	valid temporary addresses.



