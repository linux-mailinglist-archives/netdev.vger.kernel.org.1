Return-Path: <netdev+bounces-99087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828848D3AD0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33181C20B96
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5381802A3;
	Wed, 29 May 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFAF77Tr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB27D3FB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996458; cv=none; b=Gvi+ud2a/X/EpnFWBxFSuqy9l8/uZ4COLKTZUB4ySqhL5GSJVkcG8fbSkaaemBlR1Gbf3uwUBT83gpmmtI+V+0ic70gRZKT9mIyWR00xX3kQ1t0gfNgf8F3q4ZNyAwyrq6eaHhw43Sgj5S0osK/GSWh8SgtxJBFL6EXGjW689bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996458; c=relaxed/simple;
	bh=a3pqrwjW4lOHGgbEmiPhagxaC/JNiDLHZeERdWEsdgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taEYF7gx2c57udlN0zyMRfUxosw4cvgDwvW8pSgsnqTT/yyWoH8M9QNgwxVGWWoiHw2UL7OOj3kflNP0+B02KH1urYNQM0mtXFmsrU0gEHAbOXHACeSRCu04yib7U6x48hxOwVNM7BThz+VPmDTUTZ141nZrCrv2jAtTZ16b4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFAF77Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231F4C113CC;
	Wed, 29 May 2024 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716996457;
	bh=a3pqrwjW4lOHGgbEmiPhagxaC/JNiDLHZeERdWEsdgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFAF77TrA3QbjABKOQEDJxYK3nAJ1h/4BsnSwmJFC9D3hVGKNlejsKNixhRBAnLF6
	 62aVEfH9j689k5TKTQLpjzD8ihMmkZ0S1id1MygqDvzXSRHrGBtCkrqxZNRvb9Apgm
	 DftSohxduVOBYjzkormMSoQtgPFojUbYB06e9+YZm6LZZ4cPJfcIszKPSQE4yqSieu
	 AdQALr0f5YW7jfR/KUrQqaZz/ifxFqI1g+0QNeZC0gUAgjyng1HGq1yLfz6qqX+iDf
	 qczeFFhMEQFbgiLL6ptavsve52pthwxfjaGoNNqaZaUj85B4alHarCsR98REB4pUBa
	 EuRJeKnzMHB1g==
Message-ID: <87566a43-6cae-4bc9-98ca-793d6aba92b2@kernel.org>
Date: Wed, 29 May 2024 09:27:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] ipv6: sr: restruct ifdefines
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vasiliy Kovalev <kovalev@altlinux.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Guillaume Nault <gnault@redhat.com>,
 Simon Horman <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>
References: <20240529040908.3472952-1-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240529040908.3472952-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 10:09 PM, Hangbin Liu wrote:
> There are too many ifdef in IPv6 segment routing code that may cause logic
> problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister error
> path"). To avoid this, the init functions are redefined for both cases. The
> code could be more clear after all fidefs are removed.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: add a new label to call seg6_iptunnel_exit directly (Sabrina Dubroca)
>     add suggested-by tag (Sabrina Dubroca)
> ---
>  include/net/seg6.h      |  7 +++++++
>  include/net/seg6_hmac.h |  7 +++++++
>  net/ipv6/seg6.c         | 33 +++++----------------------------
>  3 files changed, 19 insertions(+), 28 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks for the followup; looks much cleaner to me.


