Return-Path: <netdev+bounces-35577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E87A9CE8
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBDAB234AD
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469409CA47;
	Thu, 21 Sep 2023 19:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF99CA44
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AB2C433C7;
	Thu, 21 Sep 2023 19:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695323967;
	bh=gt3+IUqzsgZTbbFvTe17jpOoBcyy5J7T0LcvLUMas3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M84d+F2pZx8LRZ2NeFxGgvVOY7gq1c+qr9d9AaSHsD0M+SwDZ2rUTGysDAisCLDFH
	 U59Q7SLEzQ+btLbeokBSnGejQ1Y08SwsdQCEB7ihoMlLLaGMjov8Hy1hVRvcH65meA
	 5lJ+E6FyLYHZEazQM7vOKiZyOIb0UjWr/cxJKg51/jaY9+/BOv/zw+oFsKekEonf6F
	 5UNpBXv9ZweWDNoGE70A4xOywT/sMYWqIQ5LVMUaLp34xIX3JrAkdRS8ufu4Q9ZbvK
	 jq2lSdAlk8iuhiagswO3gy8J6rtGbxSPJOCOUlbVEYhpzVyZSAGWOx3h/o+P2VtEie
	 DiyImRTC5uJEQ==
Message-ID: <04589a05-441a-1a55-b6e4-c266ca87eff2@kernel.org>
Date: Thu, 21 Sep 2023 13:19:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 6/8] inet: implement lockless
 getsockopt(IP_UNICAST_IF)
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-7-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> Add missing READ_ONCE() annotations when reading inet->uc_index
> 
> Implementing getsockopt(IP_UNICAST_IF) locklessly seems possible,
> the setsockopt() part might not be possible at the moment.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/datagram.c    |  2 +-
>  net/ipv4/ip_sockglue.c | 10 +++++-----
>  net/ipv4/ping.c        |  2 +-
>  net/ipv4/raw.c         | 13 +++++++------
>  net/ipv4/udp.c         | 12 +++++++-----
>  5 files changed, 21 insertions(+), 18 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



