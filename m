Return-Path: <netdev+bounces-225042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE918B8DD62
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA033B43F9
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395D1AAA1B;
	Sun, 21 Sep 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTs3mBzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0A1A9FAF
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469015; cv=none; b=Q1yayvGn1CKniyMpE/YGsoMSgUTCW0GlwfTgXbeg0TFPRs+jsFk77wAi3cDQTTSRjyuWskWlvrrgn0XUTOmDw3YNU9uzvm1PAwY2W1YddwZ40sMEbelGujzMcBkX4hhXnHdq8hTiuhEzeCiUzs8El5a+bQnw9TzOGbgnykFs21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469015; c=relaxed/simple;
	bh=FCgS0HgQ/HUSUZ8y3DMXXE0wsNgyBzO422vG4ekO2lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvfqKEEw/H+vJ7VRj0RasuLMYjRx9R4a57wWpFemNuFgvxWjPYTxV2rtJHSjuS94LAm346AWvkmAQPkzP14gW7NgYkkF/XC3S0KPx7o8ReUARz4dHkt7AuUrZ6ndmi1fbqxq5ADGohDETtAvh+JKJ9zHzc4l5AmGCscdHz1MkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTs3mBzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA659C4CEE7;
	Sun, 21 Sep 2025 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469015;
	bh=FCgS0HgQ/HUSUZ8y3DMXXE0wsNgyBzO422vG4ekO2lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTs3mBzXcIQ+tloYQPu7y+t899Y6mGbVPeCzRu82eV+wdWYjzFsPikNGbpsdzoTK/
	 fzBmIZoeR2lE3C64dU0ULAf+HuttT+vPHXavtNMSxWxsc9p7/W1GSqxIcn2j2j9Lq9
	 oujDYbfdBufjmALnlRw5HjuHZmFMJRnWoFMfRv5+YXC6SRypxZBFhJvtQm97AIoTHA
	 D6nUplm5lFwsS0000eGzvb0o7PD2opiHS1oMxjRKho8PwK9WsuxOLddGfZoK8P6W/J
	 gXWBm3NsKYKFlYRZwmUtxQDt0fcmfvpWh1EmJscAjUSj10E5UKlLwvy6RS1p4ZI7Pc
	 eVEizkm4OgYlQ==
Message-ID: <4d304e61-cdfa-45d9-b5ee-ac756bd4923b@kernel.org>
Date: Sun, 21 Sep 2025 09:36:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: fib_nexthops: Fix creation of non-FDB
 nexthops
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com, aroulin@nvidia.com
References: <20250921150824.149157-1-idosch@nvidia.com>
 <20250921150824.149157-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250921150824.149157-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 9:08 AM, Ido Schimmel wrote:
> The test creates non-FDB nexthops without a nexthop device which leads
> to the expected failure, but for the wrong reason:
> 
>  # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v
> 
>  IPv6 fdb groups functional
>  --------------------------
>  [...]
>  COMMAND: ip -netns me-nRsN3E nexthop add id 63 via 2001:db8:91::4
>  Error: Device attribute required for non-blackhole and non-fdb nexthops.
>  COMMAND: ip -netns me-nRsN3E nexthop add id 64 via 2001:db8:91::5
>  Error: Device attribute required for non-blackhole and non-fdb nexthops.
>  COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 63/64 fdb
>  Error: Invalid nexthop id.
>  TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
>  [...]
> 
>  IPv4 fdb groups functional
>  --------------------------
>  [...]
>  COMMAND: ip -netns me-nRsN3E nexthop add id 14 via 172.16.1.2
>  Error: Device attribute required for non-blackhole and non-fdb nexthops.
>  COMMAND: ip -netns me-nRsN3E nexthop add id 15 via 172.16.1.3
>  Error: Device attribute required for non-blackhole and non-fdb nexthops.
>  COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 14/15 fdb
>  Error: Invalid nexthop id.
>  TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
> 
>  COMMAND: ip -netns me-nRsN3E nexthop add id 16 via 172.16.1.2 fdb
>  COMMAND: ip -netns me-nRsN3E nexthop add id 17 via 172.16.1.3 fdb
>  COMMAND: ip -netns me-nRsN3E nexthop add id 104 group 14/15
>  Error: Invalid nexthop id.
>  TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
>  [...]
>  COMMAND: ip -netns me-0dlhyd ro add 172.16.0.0/22 nhid 15
>  Error: Nexthop id does not exist.
>  TEST: Route add with fdb nexthop                                    [ OK ]
> 
> In addition, as can be seen in the above output, a couple of IPv4 test
> cases used the non-FDB nexthops (14 and 15) when they intended to use
> the FDB nexthops (16 and 17). These test cases only passed because
> failure was expected, but they failed for the wrong reason.
> 
> Fix the test to create the non-FDB nexthops with a nexthop device and
> adjust the IPv4 test cases to use the FDB nexthops instead of the
> non-FDB nexthops.
> 
> Output after the fix:
> 
>  # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v
> 
>  IPv6 fdb groups functional
>  --------------------------
>  [...]
>  COMMAND: ip -netns me-lNzfHP nexthop add id 63 via 2001:db8:91::4 dev veth1
>  COMMAND: ip -netns me-lNzfHP nexthop add id 64 via 2001:db8:91::5 dev veth1
>  COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 63/64 fdb
>  Error: FDB nexthop group can only have fdb nexthops.
>  TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
>  [...]
> 
>  IPv4 fdb groups functional
>  --------------------------
>  [...]
>  COMMAND: ip -netns me-lNzfHP nexthop add id 14 via 172.16.1.2 dev veth1
>  COMMAND: ip -netns me-lNzfHP nexthop add id 15 via 172.16.1.3 dev veth1
>  COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 14/15 fdb
>  Error: FDB nexthop group can only have fdb nexthops.
>  TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
> 
>  COMMAND: ip -netns me-lNzfHP nexthop add id 16 via 172.16.1.2 fdb
>  COMMAND: ip -netns me-lNzfHP nexthop add id 17 via 172.16.1.3 fdb
>  COMMAND: ip -netns me-lNzfHP nexthop add id 104 group 16/17
>  Error: Non FDB nexthop group cannot have fdb nexthops.
>  TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
>  [...]
>  COMMAND: ip -netns me-lNzfHP ro add 172.16.0.0/22 nhid 16
>  Error: Route cannot point to a fdb nexthop.
>  TEST: Route add with fdb nexthop                                    [ OK ]
>  [...]
>  Tests passed:  30
>  Tests failed:   0
>  Tests skipped:  0
> 
> Fixes: 0534c5489c11 ("selftests: net: add fdb nexthop tests")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



