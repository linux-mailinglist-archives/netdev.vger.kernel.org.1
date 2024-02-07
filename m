Return-Path: <netdev+bounces-69882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958784CE7A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C412847DE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79580032;
	Wed,  7 Feb 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9vTUO+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD47FBDE
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321556; cv=none; b=DzIuDyEJCGGJm9QYKrW1nTMpMka6eoZ3g6tISxHDnayjb2OCAr2bPJM9cde42hWGaz34iYx0o9L/wSpIqaot7YlUg2TR0/VbxgVVOhxaL1WMQHFFFXCJ6zqFZW3CK0qsvmFMqhMi+yh4JqdqnnTkIYAoYx+LC5nwbiv1JwTisNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321556; c=relaxed/simple;
	bh=3HnDxcHSTSy88S9pAPkg6Vx3dtiAzZ4FP7G9/sZGiKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsuz2yrZkE4d6/0bgtt/MpW2xJbNyv7RVIPzQriTaxaGioYblLSkK9M5fkHpgmuQjCNg3mczz3mauUoCbu86yPgDdi+zwSuIzkymc689ifKjbWSGQoeAXJaV4lgyQWvlOymrE38/40mp8jn0DG5itc/iYaA+AAlt1VXoBcQCEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9vTUO+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856DC433C7;
	Wed,  7 Feb 2024 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321555;
	bh=3HnDxcHSTSy88S9pAPkg6Vx3dtiAzZ4FP7G9/sZGiKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f9vTUO+a06Bn/SdLwCMMAnmsZ1LMw/ea5/mLxWaZ4eMAswimc1LxXfFgWzfHnKTxu
	 hfYV5GRxiKUQn4a3M6r6znuNOuRS6OzbCXyHe3oxLZ8FzzKntYxumIIxJwp0J9CKac
	 PuUMDdHetW1ix99iBZJCKZkxOwwh8Nc2qwiMiGEfW3sbFBuVgV2MIWbpDsbao9rznl
	 bX5BKWnqh6VEmSuxIhLRw11f+UWbVAtJH2Y3uI12mqCT9cX2RLGFNab8SM52wlTu2+
	 BVeepv4R3xJmArwuOIsFsHL82e59e/W2Fr34wLs1/PEgckb3oTNJYzF1tNromgMplI
	 YjkmUvsN2UATg==
Message-ID: <7bedca5f-de17-4692-b46a-bc5b2b974aa3@kernel.org>
Date: Wed, 7 Feb 2024 08:59:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/5] net/ipv6: set expires in
 modify_prefix_route() if RTF_EXPIRES is set.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240205214033.937814-1-thinker.li@gmail.com>
 <20240205214033.937814-5-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240205214033.937814-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 2:40 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Make the decision to set or clean the expires of a route based on the
> RTF_EXPIRES flag, rather than the value of the "expires" argument.
> 
> This patch doesn't make difference logically, but make inet6_addr_modify()
> and modify_prefix_route() consistent.
> 
> The function inet6_addr_modify() is the only caller of
> modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
> value. The RTF_EXPIRES flag is turned on or off based on the value of
> valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
> (not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
> flag remains on. The expiration value being passed is equal to the
> valid_lft value if the flag is on. However, if the valid_lft value is
> infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
> off. Despite this, modify_prefix_route() decides to set the expiration
> value if the received expiration value is not zero. This mixing of infinite
> and zero cases creates an inconsistency.
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



