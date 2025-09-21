Return-Path: <netdev+bounces-225043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBBB8DD68
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D0516CFEF
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D61DE887;
	Sun, 21 Sep 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNe5TKbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C441A9FAF
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758469172; cv=none; b=QbyfiWxr0Sf0qFcPxRKXJl09C+H3ySePFsp7SJZW6Rs5thSW5N6XWI/a9S3P5oPp/W5HMFxzsg3s7ZkSAdqtPJX7o/Nw09Lj9C20erkdET+2Yd/0YzO3DV+dhSb9qFSkZUemucBSjDO925/ux2CtpswV8cxfaUBS7dGQJSZJG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758469172; c=relaxed/simple;
	bh=InzM/m+BRBqtbLo+by2KnBC+K0R+ALZHED1qOjT4Nsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAurz1bE+0hwBB565ZedzAZMPLfWH8FJ0KGgI0lKGuFa1lSzSbRyTFZk3dXD7R4qbSUT5DNMXZX16d9MjKgpN2hewl1djCEnUfJoRkdcVyJlY4rIGFueM+t2xCwRVea8muH0+t24NO1H2YbDSRiTLalbQY+0iAAViORT7k7H3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNe5TKbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D97C4CEE7;
	Sun, 21 Sep 2025 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758469171;
	bh=InzM/m+BRBqtbLo+by2KnBC+K0R+ALZHED1qOjT4Nsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VNe5TKbmWDSeGnVIZbP/mzKJrKfxt1VoJ65gxIDu86WsmNHNAPBmM6Lk3brjO603p
	 x1Z+hvop53UDONiPphFYo7yLU9Ng6BxznoN7EV9UmOPweVr82eCxA1v5OHBCSHqioQ
	 HQDlyt9xEU9t1xiWRvVxyjEtMW4MlxRegjXiQykBBdq/ORfMpQlxOwStCgUG5BdLy7
	 YdOrfmifbOsjINOBeSzDfPQJFRu+oMXeamt1qUY05iXlBlwMWyKoba/JdofwXjTtCS
	 iG6YpdTWI1YR5BkgCgnICj9zGmLUomeDMz/6ca7Fd6tIGPaX/pPC+tjVWLxjUGF0G9
	 k0SIdtuwMrkPQ==
Message-ID: <a7b10e85-1201-4865-84c4-17e2d0971ac9@kernel.org>
Date: Sun, 21 Sep 2025 09:39:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] selftests: fib_nexthops: Add test cases for FDB
 status change
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, petrm@nvidia.com, aroulin@nvidia.com
References: <20250921150824.149157-1-idosch@nvidia.com>
 <20250921150824.149157-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250921150824.149157-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 9:08 AM, Ido Schimmel wrote:
> Add the following test cases for both IPv4 and IPv6:
> 
> * Can change from FDB nexthop to non-FDB nexthop and vice versa.
> * Can change FDB nexthop address while in a group.
> * Cannot change from FDB nexthop to non-FDB nexthop and vice versa while
>   in a group.
> 
> Output without "nexthop: Forbid FDB status change while nexthop is in a
> group":
> 
>  # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal"
> 
>  IPv6 fdb groups functional
>  --------------------------
>  [...]
>  TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
>  TEST: Replace FDB nexthop address while in a group                  [ OK ]
>  TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [FAIL]
>  TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [FAIL]
>  [...]
> 
>  IPv4 fdb groups functional
>  --------------------------
>  [...]
>  TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
>  TEST: Replace FDB nexthop address while in a group                  [ OK ]
>  TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [FAIL]
>  TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [FAIL]
>  [...]
> 
>  Tests passed:  36
>  Tests failed:   4
>  Tests skipped:  0
> 
> Output with "nexthop: Forbid FDB status change while nexthop is in a
> group":
> 
>  # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal"
> 
>  IPv6 fdb groups functional
>  --------------------------
>  [...]
>  TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
>  TEST: Replace FDB nexthop address while in a group                  [ OK ]
>  TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [ OK ]
>  [...]
> 
>  IPv4 fdb groups functional
>  --------------------------
>  [...]
>  TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
>  TEST: Replace FDB nexthop address while in a group                  [ OK ]
>  TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [ OK ]
>  TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [ OK ]
>  [...]
> 
>  Tests passed:  40
>  Tests failed:   0
>  Tests skipped:  0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 40 +++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>




