Return-Path: <netdev+bounces-33872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F67A0885
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A2E1F23F6E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA721119;
	Thu, 14 Sep 2023 14:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5628E11
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F5C433C8;
	Thu, 14 Sep 2023 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703114;
	bh=qM4S6wVnaVHR0/d74jb/l/qLHq+xuqif+tUXhvjpo/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DXvHdJyrxuyrYbNOuC5WunNIZHw3j3fTbxt7Yc6Gc6o/1vY6fZfvav3EtI5ftcOkr
	 bHTzscT5h/lUjAIHpUEOuVL+I8Hne8cRZuqjAyZVUUJ6LgtdMpwopWjJRyPF/juHcE
	 D7Nn3+3QRl9Y4KBZPB0rUx6roSm7hJ4BwFgBtvTZYYMr1wwh74IY5Q7bFosITyXixH
	 3KzJ05TCgXcV16mKaSGztTmVeWuxC3dRxZgMqx5lo3+im3H1+lIlmWllXes/hDqKPj
	 hz8bRWcBCOOwZf2Sg+VW0uM0cONjazh0jRMDejZcmxo0QWb+r3qq7VMSsu1ZW6GS5p
	 yF/HGgUTLJVcg==
Message-ID: <2453b4d3-55a2-ca52-c4f6-81bbaa3d0c5b@kernel.org>
Date: Thu, 14 Sep 2023 08:51:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 01/14] ipv6: lockless IPV6_UNICAST_HOPS
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:01 AM, Eric Dumazet wrote:
> Some np->hop_limit accesses are racy, when socket lock is not held.
> 
> Add missing annotations and switch to full lockless implementation.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     | 12 +-----------
>  include/net/ipv6.h       |  2 +-
>  net/ipv6/ip6_output.c    |  2 +-
>  net/ipv6/ipv6_sockglue.c | 20 +++++++++++---------
>  net/ipv6/mcast.c         |  2 +-
>  net/ipv6/ndisc.c         |  2 +-
>  6 files changed, 16 insertions(+), 24 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



