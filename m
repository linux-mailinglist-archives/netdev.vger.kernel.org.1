Return-Path: <netdev+bounces-244797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130ACBEDC8
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE440300185A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B451312803;
	Mon, 15 Dec 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLOS1dY4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FF311971
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815209; cv=none; b=TW7+BLQoZJRh5klAqsDLYJ3mtfDp3xiPCznwtnBDjHmWHln685KlYwXrBIxvXUWMlhANiARX16QQ8xWOD/fcPJ+bor/GOKbINp5qBcvCUepRtt8cSo5QkpmppAbS/xc/Gnh6oTJoPlOWccl1kruNsLcqscvT0Lrh0WKtllesd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815209; c=relaxed/simple;
	bh=neCMMG6P67vgM7Vb6SDq9FY4+x9YAznwhy1I6DFyiuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cy6ZjbUHri5ITfJYrZQ/v6whIS6oWHKx5w8ASohVFSy3fqUH2afO0N2+aGRK6N9o8tWam4M9wrsvkaP9l8hGh4hIgb39eDURvVWlOyngpAiCtgQO7qIGUr3u6X5NAkGQBFNqJ0EdqG72bJXMi27ZqvPfU6fIJlJJZ5MZemd8Iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLOS1dY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D522C4CEF5;
	Mon, 15 Dec 2025 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765815208;
	bh=neCMMG6P67vgM7Vb6SDq9FY4+x9YAznwhy1I6DFyiuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fLOS1dY4KuVWeswEbYXzeASmiUE3rSLPWWeA2K03YN8LXRQ9RbReCGZxDvfgnxRae
	 JQfCix/ja2cPsBfoSorFLlMTM8BX5M670P6H7JAvsnQMsyUQLDwiIELzhb6Apyomf4
	 4V7E+Io4AuAk8UXbFBg9sjVV85aQW473i90gVnwkz1YG3p1EE+mqkVED41ETrYfXMI
	 GLjNp1rIbyIUgPEtm66k1Dd/pLFSq2qJWOZCKipBSIHYjsa9KJ5Ikm2oo2ChtWzCG2
	 zYEBpH9kozKo8HaUjBrs52azC5JqOURRIF8oXCWirVGZJ4tbkC8EZ2Fvy7MAnilhq9
	 sJ7yhPT1opwBA==
Message-ID: <d675cf53-8048-46b1-bd56-e3c15e2880bf@kernel.org>
Date: Mon, 15 Dec 2025 09:13:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.ord>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
 <aT-x1ZQtu4rsGxgI@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aT-x1ZQtu4rsGxgI@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/25 11:59 PM, Ido Schimmel wrote:
> 
> fib_nexthops.sh is for tests using nexthop objects: "This test is for
> checking IPv4 and IPv6 FIB behavior with nexthop objects".
> 
> I suggest moving this to fib_tests.sh. See commit 4d0dac499bf3
> ("selftests/net: test tcp connection load balancing") that was added as
> a test for the blamed commit.

Good catch. Yes, these tests belong in fib_tests.sh, not fib_nexthops.sh

