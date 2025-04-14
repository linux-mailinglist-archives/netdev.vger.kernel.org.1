Return-Path: <netdev+bounces-182316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAFA887B8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ABB177AC8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FB0279787;
	Mon, 14 Apr 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Dfn27v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2719A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645775; cv=none; b=m04MkyuARrtQN6Eac+H5p0iMegit6asn4jfe5qA1h6kMJkJv8V2NsF707+OR5Y0w+d+4ldPh0qeX4fNxffFpscG7/VR7X1FJWKEIdUJjFiSyGkiwF3/zeZdvLvD/jXtXaLXrVpG79S778zZI+QD8yjInGArgbV1KtaERAhdmuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645775; c=relaxed/simple;
	bh=0OlpI8A8o3k0NMv+HqSy0AS0cRdyO/+tn5fykeOZP7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCbAxbXsdw+x6N2yqTDkSTXrecwUyNSyGGZXfkTqT6ol/yz1xL+on0fA+p6/huIl/rD/KKktV+hN2EnyBLiGtVX+YlDJ2YjiNvLuC9YZHP1Nzq7w8oe1pI0pfUNVfDGx10XaPbJsgwyoEbJUuuNTWqNKY68RhuGErOysth4MVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Dfn27v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A9FC4CEEB;
	Mon, 14 Apr 2025 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744645775;
	bh=0OlpI8A8o3k0NMv+HqSy0AS0cRdyO/+tn5fykeOZP7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7Dfn27v2z9ZYmy0BaU3Q/yhi7InElazHQbj4WEnKg/E8+xjMDxQj75Ocy4CAujAD
	 cTTFE0mMPKjwFvgLVjQNK3KZG+wUXT3oYuoqWs6NR4ZUpCo5fmm/bYSZH62yM67h8k
	 fBksYdPnntidj7W9Sw6E8crMJWCOkfjhbbbF/tpvG319NLX5Ad35iRuJvMW6DWkb44
	 eZKXIMntYOv4gjlwPFzlRrSqhvgVTLN459PNe4jMWtq09WmEgrdldKGth+7UEqAwqd
	 yG61IBJHmyiyaEIDBozSik5zC/IWCYP3C5PF9BDCSpJ2knidaqT6qnqpTL9xXiP0GP
	 MPnffgRyhJkww==
Date: Mon, 14 Apr 2025 16:49:30 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v3] net: airoha: Add matchall filter offload
 support
Message-ID: <20250414154930.GU395307@horms.kernel.org>
References: <20250410-airoha-hw-rx-ratelimit-v3-1-5ec2a244925e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-airoha-hw-rx-ratelimit-v3-1-5ec2a244925e@kernel.org>

On Thu, Apr 10, 2025 at 05:25:37PM +0200, Lorenzo Bianconi wrote:
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:
> 
> $tc qdisc add dev eth0 handle ffff: ingress
> $tc filter add dev eth0 parent ffff: matchall action police \
>  rate 100mbit burst 1000k drop
> 
> The current implementation supports just drop/accept as exceed/notexceed
> actions. Moreover, rate and burst are the only supported configuration
> parameters.
> 
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v3:
> - remove duplicated entries configuring REG_PPE_DFT_CPORT0() regs
> - Link to v2: https://lore.kernel.org/r/20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org
> 
> Changes in v2:
> - Validate act police mtu parameter
> - Link to v1: https://lore.kernel.org/r/20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


