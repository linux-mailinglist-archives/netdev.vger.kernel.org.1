Return-Path: <netdev+bounces-43054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E67D1327
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC21E1C20B5B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A91E515;
	Fri, 20 Oct 2023 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4fgf+oD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF581DA4C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54445C433C8;
	Fri, 20 Oct 2023 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817151;
	bh=+yx/tmH5yW0oAyCTNoFQHXoiPxtokmxvoGUKDiF+kVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j4fgf+oDTeZ+MeiOPVacRXf7dueEt4T7tPLUNkxVCnVG9iTFv2jsaSmX9dTzrlG9N
	 EfNyn4CxV0rjVSSXyxkXI+xtJQrdhPkLQHQSgpLrR09pcI6967+Z41ANSucjB+iEwY
	 P6XkDgaOjN9uMAquFfa/TxgAIxHJ02YoAZ6LM5VwkfW8Pv9CaVnYMCLbU3Zmpx1ris
	 vt3W6EItqGtXOIM+CfEPGWkL0bVLjSRsOwF8+9utOxyWAS7lLMOcOU9sHgdQMA5wb4
	 l7mCDCn8qXPWNSZbOyvdP9SFa87LGNpaX6BxiRU4opgO4uB5AGNxJlbMrfuDpkEMkU
	 v/1nwkEPERksg==
Message-ID: <dc9f1c9d-d619-d2cc-5211-a3ffe4e8e3bf@kernel.org>
Date: Fri, 20 Oct 2023 09:52:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/5] ipv6: rename and move
 ip6_dst_lookup_tunnel()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-2-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-2-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> At the moment ip6_dst_lookup_tunnel() is used only by bareudp.
> Ideally, other UDP tunnel implementations should use it, but to do so
> the function needs to accept new parameters that are specific for UDP
> tunnels, such as the ports.
> 
> Prepare for these changes by renaming the function to
> udp_tunnel6_dst_lookup() and move it to file
> net/ipv6/ip6_udp_tunnel.c.
> 
> This is similar to what already done for IPv4 in commit bf3fcbf7e7a0
> ("ipv4: rename and move ip_route_output_tunnel()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 10 +++---
>  include/net/ipv6.h        |  6 ----
>  include/net/udp_tunnel.h  |  7 ++++
>  net/ipv6/ip6_output.c     | 68 --------------------------------------
>  net/ipv6/ip6_udp_tunnel.c | 69 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 81 insertions(+), 79 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



