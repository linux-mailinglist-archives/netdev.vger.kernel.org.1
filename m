Return-Path: <netdev+bounces-69886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1B84CE8A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37531F2479A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6780047;
	Wed,  7 Feb 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP97wDDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750020DCF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321791; cv=none; b=Kv1vhgCzbZFPHZl4ntdVOdqf+TP6HRtnN3vUrTKR/shj/kMVhLQ4pgAoQgnG2RoK2SVBXfFRRzKt0iVY/Gp0vP/1Z5vTNBMnbrlJq4K7BUnIZQSt+xIMcSBgcjbsbZcPY3hMA/1GZZBA6auMKXUkULjF8b91uNGdHuiw7uhdI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321791; c=relaxed/simple;
	bh=v5j98nLNU9/5bqoU2Fm6zuxbC1GM7onWDEffZ3H3+5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNTfVVUaRL0B3YqP6vSbF8eF51ESB3YAvXbbJNnqQrn6chTVdquRTE4AxG0q80lZi6oLfJsjfelK0uO+Ku4HXvW2jNRVGivxhkjKv8y3dg3QRnolswo2CTEeq+M2hsDKP6K/qdz49CiA2ZM2+hxAbVmINmaV1TDXBkFARL5XHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP97wDDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EB1C433C7;
	Wed,  7 Feb 2024 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321791;
	bh=v5j98nLNU9/5bqoU2Fm6zuxbC1GM7onWDEffZ3H3+5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NP97wDDzcfkyJoLcRsxYzpLjLSimRSx495pRvNQfxivKfrjjE/ibqTLSV9XK67PPq
	 QWAyS92MYt/JKkOjh76h2mRUWMYRak2DhziQ6bymcTvSw1J1FlLLMaVe900fP15h3i
	 KoqhnO+tGyGoI6nDPrVIUWAtscvh4qUj1BxLHlxPyFNX/2xbYbgzDP09giduPa64dW
	 XOfH8ulOCn94ihkOyEGVA/QvmmUsEjVqI/ScGJ50qhH9xp1NljoD3ZV9Dj8GvIvwXu
	 SC0PwHGZmOSORb3HJVpqQmhcaLd6UzHXdew2mmHU95jATOMQK+6RWyMFiF76a/LRmL
	 knBKf9TRzi6ZQ==
Message-ID: <f1fcebb8-7010-41ca-a162-b9e7f51113b5@kernel.org>
Date: Wed, 7 Feb 2024 09:03:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240205214033.937814-1-thinker.li@gmail.com>
 <20240205214033.937814-6-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240205214033.937814-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 2:40 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Add tests of changing permanent routes to temporary routes and the reversed
> case to make sure GC working correctly in these cases.  Add tests for the
> temporary routes from RA.
> 
> The existing device will be deleted between tests to remove all routes
> associated with it, so that the earlier tests don't mess up the later ones.
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Tested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 148 +++++++++++++++++++----
>  1 file changed, 126 insertions(+), 22 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


