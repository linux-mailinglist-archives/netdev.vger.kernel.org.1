Return-Path: <netdev+bounces-43058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258837D134F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A2028256E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F041E51F;
	Fri, 20 Oct 2023 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5TYyZ8B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56051DA4C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0708AC433C7;
	Fri, 20 Oct 2023 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817482;
	bh=95Ls7CeVdFQSjPfOngpnPXjenZMzg1jn2SvA01CRo0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J5TYyZ8Br1Uf9km3+TnTsSMPgGz/XWRFk4NyqV9uEvxmhXzADnctACOmn5FOQDtU0
	 7q6TUt2H3U8Z9HWvDNGSPiG8XRAtYZYQhpNZYN3xU7OKuhPRk4O2wuGIDMYpejDFxV
	 ZrHR0/sZEyCmwzx5EWIX/HPIl1AdkVz1jennrb79yH4ZoT9aFS0oRYypvV3wG4ZjQx
	 0RZEUnSSIk+JSga/I2kNS+z0zpPuNiMYLQEHMCg9/feC6iBvGMQi8i4aX5mrfF4CQV
	 N5GJ9SubDKmtHAVw3jhHBK8e1SDRlJVGctDhL6jh0Vs3UzoPOVppGzAbH4lzPErtHX
	 kUlkA/zpktc0A==
Message-ID: <ae9c237e-6a56-578c-f5fa-b93d07ab7c08@kernel.org>
Date: Fri, 20 Oct 2023 09:58:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/5] vxlan: use generic function for tunnel IPv6
 route lookup
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-6-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-6-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> The route lookup can be done now via generic function
> udp_tunnel6_dst_lookup() to replace the custom implementation in
> vxlan6_get_route().
> 
> This is similar to what already done for IPv4 in commit 6f19b2c136d9
> ("vxlan: use generic function for tunnel IPv4 route lookup").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 136 ++++++++-------------------------
>  1 file changed, 30 insertions(+), 106 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



