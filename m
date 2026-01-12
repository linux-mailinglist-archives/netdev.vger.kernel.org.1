Return-Path: <netdev+bounces-249079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6021D13AB1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09FC2303A968
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C82F6573;
	Mon, 12 Jan 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btgVtfHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598732F60CC
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231601; cv=none; b=HV+g3sDKfUkJw/Tygj10PSXptAGSaAhRg6Kfo42YzOG3uMb5d1YaRATVfT5v68wHI2PkU9Ll/TME98BXumbRasFtZX9P53qkh7j+dMqMh5QYMEpJ0XOVlnTXEb6ft72MWmPYB5nSsvILLtVImCiGjEu6+C8mHganNnvDKtYCZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231601; c=relaxed/simple;
	bh=M4GyVpGr0tAJLt/8XIfoGD6YmFS2E3BVfl3dE1803Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTnwVEP0+M8RNx9iyCiYxtjNbHEz608NuJxinnRPmWC3GcR5/eFQ2aFF2T2IhuGHhYJsgRON3dYDVIcAtiXoI06fQPxFu1pDJJF9wT1HXAVYJ/bA2FOnqw/GuQu5YA4KFKTr8NEpDUNVojb+LyuZKzYuW8KUjsjv1M/dQTuwXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btgVtfHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE7C19423;
	Mon, 12 Jan 2026 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768231600;
	bh=M4GyVpGr0tAJLt/8XIfoGD6YmFS2E3BVfl3dE1803Dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=btgVtfHsMRX5wMkYc04iVuzHjhDNcGqvXDZpjaMEFmtPn4SqyRuauaskp6W+Xf2Rm
	 yaTs+9mXwfcVhxloXM0jEnuxz/Y+vXlIDj9Jp0qSD02JN4XK8ESWRQmYjRVJyHazv7
	 WmxPx1bprL3QRLW3CVJYlws1j0ItelfiZGOgf1wHIXzBA0nYm024oHt9is9jENqYZk
	 Trm4IWVzNA80xUTvs3xyUzutPxLOMmjNuFxXSIT0H8Qzr5oH9wc74cCK1BnhXm2i8o
	 bXxyGnQI/XEPZmAVMr5+RF2J9HoTBfvbVlWa+GDkFiWnp06BuBvDFdOP79QMNm22X2
	 EmH8PmmfVZg9A==
Message-ID: <24993fc6-4f37-4873-9435-6e2ab844e9ad@kernel.org>
Date: Mon, 12 Jan 2026 08:26:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] selftests: fib-onlink: Add a test case for
 IPv4 multicast gateway
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com
References: <20260111120813.159799-1-idosch@nvidia.com>
 <20260111120813.159799-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260111120813.159799-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:08 AM, Ido Schimmel wrote:
> A multicast gateway address should be rejected when "onlink" is
> specified, but it is only tested as part of the IPv6 tests. Add an
> equivalent IPv4 test.
> 
>  # ./fib-onlink-tests.sh -v
>  [...]
>  COMMAND: ip ro add table 254 169.254.101.12/32 via 233.252.0.1 dev veth1 onlink
>  Error: Nexthop has invalid gateway.
> 
>  TEST: Invalid gw - multicast address                      [ OK ]
>  [...]
>  COMMAND: ip ro add table 1101 169.254.102.12/32 via 233.252.0.1 dev veth5 onlink
>  Error: Nexthop has invalid gateway.
> 
>  TEST: Invalid gw - multicast address, VRF                 [ OK ]
>  [...]
>  Tests passed:  37
>  Tests failed:   0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



