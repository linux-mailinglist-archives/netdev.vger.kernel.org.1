Return-Path: <netdev+bounces-33876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A27A08BF
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2331F237CE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22382628B;
	Thu, 14 Sep 2023 14:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7828E11
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8BC433C7;
	Thu, 14 Sep 2023 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703500;
	bh=vy0f9Ms6B1sm4rpMcGZCo/eaefajYqXIPDMOTyLJE7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RqRWw6sPAeZ0q00Is9nebJ7abWoz0K9qlNqqFBeNXoKLvsHPZhzS3EnLUqHF+LdbX
	 Phk1sgju8QsqYJeAyMhLwPsl7p9TSB3C5grabinCIdqKOHOqLHZs+Ykg69cWb8NOqx
	 7BLOClYVLFLVVM5bYpkz/67a6GzANsqMWhy698aqn0zOdYN7XX7/D4GztB1qfypk5M
	 ZmPQHPEZqBVoFG775WVKc2a6Uoeu1TlVLtegMGTu75Ofi4HzxreFXcTsTXo3y5id/V
	 ZZBgHS6hpPcQF6ruor0/g2P70ihUc/ytorJKRf916TOCV8yVzlbTKe26qN8BX2bSCr
	 7bB2+kMSURjwA==
Message-ID: <cb1acfdb-3a3a-adb0-812b-75f5c651a7e9@kernel.org>
Date: Thu, 14 Sep 2023 08:58:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 04/14] ipv6: lockless IPV6_MTU implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> np->frag_size can be read/written without holding socket lock.
> 
> Add missing annotations and make IPV6_MTU setsockopt() lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6_output.c    | 19 +++++++++++--------
>  net/ipv6/ipv6_sockglue.c | 15 +++++++--------
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



