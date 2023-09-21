Return-Path: <netdev+bounces-35586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD477A9CE5
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A540282874
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEA171A7;
	Thu, 21 Sep 2023 19:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA19CA66
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB79C433C8;
	Thu, 21 Sep 2023 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695324291;
	bh=cRRO6uOAhR4HG9V2RmRaEO43iRghXoPNL3rvSBkt2rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IYDxgcButsi/AG/NB50WsHtVvUG8uhw3nIZpfkBJtaKf3AjtP6n+zdgiQnLWtsP7M
	 ag3wGgJwWJyDefIw2EBdPxiNmbG9J9eV4GAl7kXbZxT+PYtm9YSu6z5kFrU239wxp2
	 IPMKSbrx7Q+bJsOi5cSDQ1lnli4Wv/esc37xWX1wvRJSBOINIE+30It1VfMQSckTlZ
	 KB1qM6mEnwtsxI4loBDQ2A5foZkld4H1I7y0wFcfET+9QHue00z0RRLv7S7oLGT38a
	 QaMRshjc2Kgq3mqTjVIFT1Q0qKmtrZ1aW3RXI3Fz5tmx0o8+R2sZPH2p7XDZrZoaOM
	 Ii/GVL/AjdJfw==
Message-ID: <d81eff14-93e1-0be3-e34f-8b362f8eece2@kernel.org>
Date: Thu, 21 Sep 2023 13:24:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 8/8] inet: implement lockless
 getsockopt(IP_MULTICAST_IF)
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> Add missing annotations to inet->mc_index and inet->mc_addr
> to fix data-races.
> 
> getsockopt(IP_MULTICAST_IF) can be lockless.
> 
> setsockopt() side is left for later.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/datagram.c    |  4 ++--
>  net/ipv4/ip_sockglue.c | 25 ++++++++++++-------------
>  net/ipv4/ping.c        |  4 ++--
>  net/ipv4/raw.c         |  4 ++--
>  net/ipv4/udp.c         |  4 ++--
>  5 files changed, 20 insertions(+), 21 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>



