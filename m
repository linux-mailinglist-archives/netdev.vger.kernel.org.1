Return-Path: <netdev+bounces-55352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B680A837
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8091C20939
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071D37145;
	Fri,  8 Dec 2023 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtHzNZYj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848323528F
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 16:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7636C433C7;
	Fri,  8 Dec 2023 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702051696;
	bh=WRAWj2ekfrkNQWP5Ttm8+HYYOa724JQ0wYvzT5FrS3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XtHzNZYjcBGFAOEdW1dYM1D+gqELb7t5Z04Ed+0j/4n2c0nj38BUWyUi/RDq8eUf0
	 84RaKhySmn/rTmmtRQ+lspOhGwxfGqEm1Z11v900Fpk8RvjHzKE/vkMZ7ouVyI48mH
	 yZfCVnrMDpQHRiuypMbpBun5Cn0G9JhTDSsdO3yrOWv/O0pmXv1MuoYsfGr7SQHEll
	 lKjbQrM+YmST+716ArfyJkWhoHyStn+j+g3Vvl9bycnm2sRSv5E4Qd7mz/rPYHNCo5
	 y0gk1RpX8P1s3VPXefdoG7UCEWx6zlRgfa/UhcXftNZeBFAd/S1nCYbBWYtWf3ekMl
	 6tMT+LsOuiZ2A==
Message-ID: <61832830-e4a8-4058-8cfb-2c088845a9cf@kernel.org>
Date: Fri, 8 Dec 2023 09:08:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ipv6: annotate data-races around
 np->ucast_oif
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231208101244.1019034-1-edumazet@google.com>
 <20231208101244.1019034-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208101244.1019034-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 3:12 AM, Eric Dumazet wrote:
> np->ucast_oif is read locklessly in some contexts.
> 
> Make all accesses to this field lockless, adding appropriate
> annotations.
> 
> This also makes setsockopt( IPV6_UNICAST_IF ) lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/datagram.c      |  2 +-
>  net/ipv6/icmp.c          |  4 +--
>  net/ipv6/ipv6_sockglue.c | 58 ++++++++++++++++++----------------------
>  net/ipv6/ping.c          |  4 +--
>  net/ipv6/raw.c           |  2 +-
>  net/ipv6/udp.c           |  2 +-
>  net/l2tp/l2tp_ip6.c      |  2 +-
>  7 files changed, 34 insertions(+), 40 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



