Return-Path: <netdev+bounces-92217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E78B5FC8
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6201C22366
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67B86AE3;
	Mon, 29 Apr 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSkNJHLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806486AE2
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410756; cv=none; b=PpYLGXO1S8vWcxEX5tgTCk75EYjMY8/wDbQ+YEqojfmIvFk5A8Bn6Epaf30n0ICWDH5DWnpsezzM6Fkb6W2lO6wTMKTsWfNq3CuYqutsp+GEbAqn3+XJV+j8d745zVnKxKqtIQ5G1bTVbI2E1lPB2kU/u2eFNJ7C0y3jyfb9UJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410756; c=relaxed/simple;
	bh=YnNGZkFthO+IGKLSlO4AbJTNHdTC6vMFBv2xF3NYB/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJlnqO5HvE0qEhXjrHKXlTIBxscncatozo20k6usgbX9K7DoXUs5iyakg3E7sUx9NsnaPvZOP+slZhEMrIXmGlb8G5+K7kPFxADkc5ZxHmCGNzHqYoC+D5vGTHto5MDePLH98b6ADSp+RHHjyhQMBHSe7ZenUwesAlRYCUUbFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSkNJHLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C4EC4AF1B;
	Mon, 29 Apr 2024 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410756;
	bh=YnNGZkFthO+IGKLSlO4AbJTNHdTC6vMFBv2xF3NYB/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hSkNJHLQQAtbiV0p4L0ihQ/BnCkQYh1iD4yZdYvEH3atNpHnN4pHfAxQQk88EH8uM
	 mUPPwcM9Ue8Nt9+TUupDs+iYi4h/UkNuWI9QWrNqYwAr0lpbbw4hfHJ5eR3HVxP76t
	 XYOM0I30JpZa3UREKjMUOzX68zHfEMbUMiDiemW7UWcb6IO9teoSeNAzTEr21alN7E
	 iEcNsrijc2Z0WvKje9g3ODiKlLlhxBC69Smyo7YJKR+xgdd5bql/sdp2ATqvfI6WRI
	 3AM5CQSWBEvv3zp2FcXE9RYvcVp5Tqq6iPK1NjvjAfxAstoLn45uWj9duDFwLOj9lK
	 +dPHm3+/6WmBA==
Message-ID: <b3fffc10-3671-4a00-b1e4-6f0f8cd861da@kernel.org>
Date: Mon, 29 Apr 2024 11:12:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net: three additions to net_hotdata
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240429134025.1233626-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/24 7:40 AM, Eric Dumazet wrote:
> This series moves three fast path sysctls to net_hotdata.
> 
> To avoid <net/hotdata.h> inclusion from <net/sock.h>,
> create <net/proto_memory.h> to hold proto memory definitions.
> 
> Eric Dumazet (5):
>   net: move sysctl_max_skb_frags to net_hotdata
>   net: move sysctl_skb_defer_max to net_hotdata
>   tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
>   net: add <net/proto_memory.h>
>   net: move sysctl_mem_pcpu_rsv to net_hotdata
> 
>  include/linux/skbuff.h     |  2 -
>  include/net/hotdata.h      |  3 ++
>  include/net/proto_memory.h | 83 ++++++++++++++++++++++++++++++++++++++
>  include/net/sock.h         | 78 -----------------------------------
>  include/net/tcp.h          | 10 +----
>  net/core/dev.c             |  1 -
>  net/core/dev.h             |  1 -
>  net/core/hotdata.c         |  7 +++-
>  net/core/skbuff.c          |  7 +---
>  net/core/sock.c            |  2 +-
>  net/core/sysctl_net_core.c |  7 ++--
>  net/ipv4/proc.c            |  1 +
>  net/ipv4/tcp.c             | 14 ++++++-
>  net/ipv4/tcp_input.c       |  1 +
>  net/ipv4/tcp_output.c      |  1 +
>  net/mptcp/protocol.c       |  3 +-
>  net/sctp/sm_statefuns.c    |  1 +
>  17 files changed, 117 insertions(+), 105 deletions(-)
>  create mode 100644 include/net/proto_memory.h
> 

For the set:

Reviewed-by: David Ahern <dsahern@kernel.org>


