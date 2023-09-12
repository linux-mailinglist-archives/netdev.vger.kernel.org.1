Return-Path: <netdev+bounces-33291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAFE79D533
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D041C20DE3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2BA18C1D;
	Tue, 12 Sep 2023 15:42:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869AAD49
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996DCC433C8;
	Tue, 12 Sep 2023 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694533374;
	bh=x5skFNfGsM7GjFcIrdwY3QQ1EP2LKjWHy0pgga2Jc68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EktgWKbYC+8UJsdJH/pQSLRhIf9lCQDtl4aoUhIn4l0c3EQCtiJk1J7TmWwq1V1AY
	 3vc/4HvNM2K8QYRHj5UJdO4xgFs0URykfdkqRtNsL3PoEa+vI9S4ECive0W5g+NVYD
	 IcTjl4qkXNTCU5bmyrlpvbJdYHFuRicdREeRwXvazEdAkzPNadpi/xY1SrDbcVy8Go
	 Jdv44TTQmIepXjZjwmAtPNIePSLfV0nbauYusmro+/83gz3waFnok4R7TCPMC/f+PQ
	 A5GChJrPYgbcYeax1HrMQYHyWMqA07nnzMht9nFcPq4MGaiDqcN1W2BG3dq0yp/O/V
	 bmOhs6WPnjGFg==
Message-ID: <195d6e8f-c305-da4a-baa5-7997c236aac4@kernel.org>
Date: Tue, 12 Sep 2023 09:42:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Content-Language: en-US
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 2:42 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> Repost according to https://lore.kernel.org/all/fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org/
>  net/ipv4/igmp.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



