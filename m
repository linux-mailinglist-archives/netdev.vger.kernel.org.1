Return-Path: <netdev+bounces-245781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D0CD7706
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D4FF30019E2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0938327C0B;
	Mon, 22 Dec 2025 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqtLy96z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFB3168F5
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445194; cv=none; b=qEaIHMcQJOnPNgUZXdqxj5lDNzjxYJRFsGkgy84AOtaaLwWIOIgv0xEklFNi1Nba3sEPo/X7QdAURfU4dLG43yActLYhBxhyy5KMIhS8qPiXM/+G3xz6IZ3uM93OmVaWE+7dEhiG0R7hDSfJbODpLn7FhXwtCI94HGNgoKm3j78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445194; c=relaxed/simple;
	bh=DH+rusyvZH1z7ZKyUHPX8GnUs1uZuSiQzGaYME2MmzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSVJM5oWiqAqyzmn+YNrV8np8putL3Uz+n9yDTuhVA2sQgMC308JmWwAmkhSKLiRtjVjWuuITMYdULL7GJ0PpxBTQd1PWqKgmC0XhGZIBeqNj8JNpueyX1tac7UYeFjEVToj4SGs+kHyWdxcF6kRObtmixoF1ePgT16/xe8wdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqtLy96z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3C0C4CEF1;
	Mon, 22 Dec 2025 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766445193;
	bh=DH+rusyvZH1z7ZKyUHPX8GnUs1uZuSiQzGaYME2MmzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PqtLy96zUAQ4LGEJILEsjXB4Cr6iij7xdXJqe1mLCL4/dDNe6+5JQHhvPyiE0BeLo
	 RKf3rXrmth9wP2dht3PvWwTw86rhN7CQOe2gqNjt2ml87AbtVHRxyVHhKqq1Ke5MNW
	 Kvd4qqbde88KTjnh3A6lxiFbtFbhyyzIUfXn5szMSwmWgGrX+uCNQSXDtZmzkVOgcj
	 ooV/7/iEf6OlU0xZsV5/wtZkzeZJQEb93jNUmcUuCfr9cg2SB20zSpDE1D74HAc0oc
	 mMZJOGVvIlvwriLHQmZ6uquvgMxN7Yfe6iH/u5fdeahrxxHWG5u1kOB6XZ+n5AefOY
	 yCHaP4HZXYeXg==
Message-ID: <0bb9f0dd-686b-4034-aa64-71247b523725@kernel.org>
Date: Mon, 22 Dec 2025 18:13:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test cases for error
 routes deletion
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20251221144829.197694-1-idosch@nvidia.com>
 <20251221144829.197694-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251221144829.197694-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/25 7:48 AM, Ido Schimmel wrote:
> Add test cases that check that error routes (e.g., blackhole) are
> deleted when their nexthop is deleted.
> 
> Output without "ipv4: Fix reference count leak when using error routes
> with nexthop objects":
> 
>  # ./fib_nexthops.sh -t "ipv4_fcnal ipv6_fcnal"
> 
>  IPv4 functional
>  ----------------------
>  [...]
>        WARNING: Unexpected route entry
>  TEST: Error route removed on nexthop deletion                       [FAIL]
> 
>  IPv6
>  ----------------------
>  [...]
>  TEST: Error route removed on nexthop deletion                       [ OK ]
> 
>  Tests passed:  20
>  Tests failed:   1
>  Tests skipped:  0
> 
> Output with "ipv4: Fix reference count leak when using error routes
> with nexthop objects":
> 
>  # ./fib_nexthops.sh -t "ipv4_fcnal ipv6_fcnal"
> 
>  IPv4 functional
>  ----------------------
>  [...]
>  TEST: Error route removed on nexthop deletion                       [ OK ]
> 
>  IPv6
>  ----------------------
>  [...]
>  TEST: Error route removed on nexthop deletion                       [ OK ]
> 
>  Tests passed:  21
>  Tests failed:   0
>  Tests skipped:  0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


