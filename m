Return-Path: <netdev+bounces-190486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2CAB6FCE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FE81BA065A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAB1F37D4;
	Wed, 14 May 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcSCcEgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4D1E2847
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236625; cv=none; b=joacuKISiQY00KuWY33EnNZtro+TgiTqVnPgQhwXGfLjI3+PN9v3D/slHor/9B63uSZkgoNGBgB+92tMpZrGqd4JYK8i8F8w0m8b1qNLtdMkpgUKkCiR6WngAEyb3HczBx3Wi/GfLkU+R5+RCPtUjVCJcldxwyBEjVdt30+yf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236625; c=relaxed/simple;
	bh=npri4ZBcimeJ87Czie0TyudNHrR+eXyWl0LUsMgGP44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhHDo5/nanyPbB57zmBl4dMGwvMGkY/SmUtnKppOLqgb4rNcu/mLOwbIgv7Th/ub8f2pnH3ds2MSizSVCLHIgDL34HuLcq1Et+fZQMmi55xBVNCemb4vjRdkp2JoP9E5R4B5IAsIcufBeMFjZTG4d9rKF7Dw51HwqnZUoJPPC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcSCcEgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DE1C4CEE9;
	Wed, 14 May 2025 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747236625;
	bh=npri4ZBcimeJ87Czie0TyudNHrR+eXyWl0LUsMgGP44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kcSCcEgs9pBKrk4IxSZkqv+6M2KkM7M9azZaWilHiNuP07dKOlDpEtCy+bn3KE1K1
	 G/eW92Ii0s+mx3rLcVTk2fVtKGy9LZBLaxAcDwqrWirkCqmZl5B6uqvIUjnnYp/ExI
	 o/UtB++CMoSsur0NhCYedfkRBCjoAW1mlw6Z+xGlPdEiiaaR5QX2dbKanRx3ANGIcs
	 TaXPkbYeq7s2wORjRZoF7CctfqjLO8KUjTr5YFmkZip6OBpwP3u2Klaxatdodcz+X4
	 d/iV6UoG3+uoW+i5se+rrLuIkS2im9HXrymoH3FSdbpEbOnliby8fwT+tn7l5YqVOb
	 1UjZ0OHvORHzg==
Message-ID: <51c7b462-500c-4c8b-92eb-d9ebae8bbe42@kernel.org>
Date: Wed, 14 May 2025 09:30:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/11] tcp: add tcp_rcvbuf_grow() tracepoint
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250513193919.1089692-1-edumazet@google.com>
 <20250513193919.1089692-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250513193919.1089692-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 1:39 PM, Eric Dumazet wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index a35018e2d0ba27b14d0b59d3728f7181b1a51161..88beb6d0f7b5981e65937a6727a1111fd341335b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -769,6 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
>  	if (copied <= tp->rcvq_space.space)
>  		goto new_measure;
>  
> +	trace_tcp_rcvbuf_grow(sk, time);

tracepoints typically take on the name of the function. Patch 2 moves a
lot of logic from tcp_rcv_space_adjust to tcp_rcvbuf_grow but does not
move this tracepoint into it. For sake of consistency, why not do that -
and add this patch after the code move?

> +
>  	/* A bit of theory :
>  	 * copied = bytes received in previous RTT, our base window
>  	 * To cope with packet losses, we need a 2x factor


