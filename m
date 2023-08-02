Return-Path: <netdev+bounces-23672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82476D11C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39131C21308
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910438839;
	Wed,  2 Aug 2023 15:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CA8BE3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB2C433C8;
	Wed,  2 Aug 2023 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988984;
	bh=YrzpzPickNgUVSyYCQF1QK9PcxzGL14goCfH88SPDmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tZrZmtsv2Yib0ypbJyfNiG6bsFTZpqAIE7UUFAA7bKoLpjJCyYCadyLcQZ8Z6ZEbM
	 AQvatsj2ER4ibeGDmNYRIWKu4lA90hsXogAYOsuEl3t902AkaK62bfVIDjAnlw5xl9
	 HCISTdN+KtjGSlMaUPtibVYBqBAnlT4tqnoNY53n42RI2vDK2EUAL4OzSL8CkaQtvl
	 wtGDIyHOsQhZU/j4CZvthy+beOoT/R4Zt1IRwlcaXztoKYpF3cTRkgReIFdnN5RoBs
	 O4wYhmJtPv+AKdkx+7vtsx4/XpUABuQqu0WvYWmPhmgGiVFhdeXwhxnlOu69oTHsSM
	 5RTNWhNaK41tg==
Message-ID: <e1cdc917-f18c-59df-0956-ffb1c16c2a9c@kernel.org>
Date: Wed, 2 Aug 2023 09:09:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net 4/6] tcp_metrics: annotate data-races around
 tm->tcpm_vals[]
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230802131500.1478140-1-edumazet@google.com>
 <20230802131500.1478140-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230802131500.1478140-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/23 7:14 AM, Eric Dumazet wrote:
> tm->tcpm_vals[] values can be read or written locklessly.
> 
> Add needed READ_ONCE()/WRITE_ONCE() to document this,
> and force use of tcp_metric_get() and tcp_metric_set()
> 
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



