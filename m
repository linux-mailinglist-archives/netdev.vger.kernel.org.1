Return-Path: <netdev+bounces-87622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9278A3DC5
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84BC1C20BCD
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A11DFF8;
	Sat, 13 Apr 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBMg+Pqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ECA50A68;
	Sat, 13 Apr 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027072; cv=none; b=OJZH8DiRlUsCxecIgzWCUXgr1df3o1M6exNKmp+2NGDVZ+mSVALt01fYWp+GdJlM2hfky+gfCJxG28gwqu41bQHe7YbA5H8oO5NGfjCPVCb7aD2OzG6Hlw0qc7XICSBrOvtduKDAY34VE6DyirJ5sboa25czYDCjGnoIKaKHHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027072; c=relaxed/simple;
	bh=TtxRo7Q+c98GYd03oJuFQLr9ap0mnMqoDm4SPFjN3uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdZ+EcK5uyrI4FaMi6rx4Lg192D3U0l/m8iRpeRjEGfz45HokVHJyZYVlhmU7mg7Z0KDA4WvDLSHsDXdYsdWOIDmnKRpc9ssfHo7VYZl54fWOrVfk7s637vKcjCvNcOU7mxyXR5/evvMu3+/y+qZ1fP+k2Ci8kNe5sFghbnok5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBMg+Pqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B84C113CD;
	Sat, 13 Apr 2024 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713027071;
	bh=TtxRo7Q+c98GYd03oJuFQLr9ap0mnMqoDm4SPFjN3uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pBMg+Pqx5tsyt349jaIfAwn8WtH3VGdbg1iLRMw8Mz16ogqQwggRbr4pU81vSA1dU
	 /1MlXPT/6HAnl7cdVC4FbTrO73s+L5uJHxEXnMxGvPtD7e2GKQVk+djhvCAt6Kh81M
	 sMIFZX7HUDoGN1Nqc9FCWZuG+wWMMDcI65/i6fWZnBviKhupZ3LIInl1FI5qP6B71k
	 F6iaeZeAotnLyTGJ5FQPU4PUnda45kdii+y5nGOpoTDlzNu4P6eVbw7n5Sf9NUCadD
	 9e/AswKue1Qw3XFZGt2eC7I4wOScQAcijxZarBnHWhGeBJGPzJP8sFZJ0EE9ViQlGk
	 ygDTNbw7p6a+g==
Message-ID: <d69cde16-a2ce-49e5-8ea6-ac6337b0b5ed@kernel.org>
Date: Sat, 13 Apr 2024 10:51:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ip6_gre: Remove generic
 .ndo_get_stats64
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
References: <20240412151928.2895993-1-leitao@debian.org>
 <20240412151928.2895993-2-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240412151928.2895993-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 9:19 AM, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ip6_gre.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



