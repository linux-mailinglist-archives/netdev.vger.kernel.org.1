Return-Path: <netdev+bounces-40102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FB07C5C56
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D7D281F4D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4C2230F;
	Wed, 11 Oct 2023 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/tDw4wS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BE1D54E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F7C433CB;
	Wed, 11 Oct 2023 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050261;
	bh=8PENQpkW9ys3s72+iK3X9odKCSmYXkhRr1UXf42h6/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/tDw4wS7Kl9JcDfS8FHqvZ7Wtc/DsvFwRrSjK1gZcSkoCjGA+cqtYwCV7VjYWT1p
	 hkzTPvH+rqNZBFCP4WN20rCg5jgj+NVE9n59AVLOgm/XwNcHCGCQnv8t1eWkNdnFxM
	 3hy4Xjb9cNX7XyJKxpE1icIVRbCHwcs2pkOKXqynNgS7ImdhUlhukRJ1niexxJl7md
	 Ce3NbPi//VgbUnlBms0h2B2bqXZTQ1j3k7yjootp5oHO0h9PaEB00wjK1P7SdL+8Bm
	 KBbqvc3jhsHcI3k15bB6Lv9qWIRfzzt08MHXY0fP6V2WciktmpthFF5pFTHlOzUFg3
	 XFo6FQ9Rkstcg==
Message-ID: <64abbd6d-7ce7-c054-366a-8cac757852df@kernel.org>
Date: Wed, 11 Oct 2023 12:51:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/7] ipv4: remove "proto" argument from
 udp_tunnel_dst_lookup()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-3-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-3-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> The function is now UDP-specific, the protocol is always IPPROTO_UDP.
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      | 4 ++--
>  include/net/udp_tunnel.h   | 2 +-
>  net/ipv4/udp_tunnel_core.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



