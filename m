Return-Path: <netdev+bounces-176483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B999A6A881
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AEB1B6361F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD92236E4;
	Thu, 20 Mar 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjId6PDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7822332C
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480422; cv=none; b=QdAcU4D8wdJeJ5HeHOTdCvIAvfTF59yB8J3gq+0Pk7/SOz/IBu/bUYWLj8VFHhXjGlUKm+3sFlnmzFpVEDKeYbPtaCRBcimTyf2CyCOSMC6PUBNcCOAchQvHAW/E5QE5461arz+wgyHf91O06s6IAALExex/kG0b3RdqKl33XYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480422; c=relaxed/simple;
	bh=kK1zvF7trXLu22tzbyAnT+VsKSHEHuKXe/qFGK7emd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDHCU9VUy92sqavBnTBYwY7gbqkRjqPe8FjhWkOZZgvGJDk9/pfBqbLAHCarqR68sQuSW3AbVc6RY836Bpxu0fCbowHM3gQTjSLQZIuzeV5BrhxtMLdHg+9fynCKOkF/jZut2O4IvveDOxMhueACk5QXVuv013QT9zFVl5+iMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjId6PDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BABC4CEDD;
	Thu, 20 Mar 2025 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480421;
	bh=kK1zvF7trXLu22tzbyAnT+VsKSHEHuKXe/qFGK7emd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjId6PDlYHm66z85AKqL6l3J7qW5Z1g/X/3JwzZlwIjsmQzdq/6f/q9kgxzB81i28
	 eATnTOS5/8onoXcRXGpFHLRzHegyLMjLJwKHpxx36tK9LjytbkjvGHHuo+2kbuFtKQ
	 islfXCdZs00HCiT/i9G0Hn8hfoy4tIC98CbvhqppgE90tNPi+Eib1LuxbYSYG5hSS5
	 PDAwXoFGg/b3QIxIebS39LjsuTLLcKuu02+eore18k5u3uEEZJYYqIA0WflXOrc4cK
	 8vXC/QX4k8aazdcmOrwNiXGV+SZv0YS0uWAwwvLHvi/rGLUl+pp736ElhFr6VBsvqy
	 pImH78dEzaAGQ==
Message-ID: <9edc25a5-514a-4334-ba52-eb42b86f2a31@kernel.org>
Date: Thu, 20 Mar 2025 08:20:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/7] nexthop: Split nh_check_attr_group().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-3-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-3-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> We will push RTNL down to rtm_new_nexthop(), and then we
> want to move non-RTNL operations out of the scope.
> 
> nh_check_attr_group() validates NHA_GROUP attributes, and
> nexthop_find_by_id() and some validation requires RTNL.
> 
> Let's factorise such parts as nh_check_attr_group_rtnl()
> and call it from rtm_to_nh_config_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 68 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 21 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



