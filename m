Return-Path: <netdev+bounces-34216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D07A2D99
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691951C208D1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DCC612A;
	Sat, 16 Sep 2023 03:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246023D2
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25894C433C9;
	Sat, 16 Sep 2023 03:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694834239;
	bh=PA0n0xOCX4Po4HJmJwvhJDnDSY/1CQPST3MzO1PhFfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=or1gYnypAhVy6kCUcQ76KAS8w0lmaSVQ2BCPLMvfVCAeu908NI/2a7tZIQsUfczER
	 27de0z5ttBzmfHpFBKmbb0BzFhQy18t6h+JRfT7JPKcVm2IxmpUufwvSmTaQDFwIzB
	 C1CVdZ/2outwJT7N31y10ok4GyqHj9VKwh+K2uiIbhG8DQ5jp+u0epKeo7+JTedhmF
	 pRvFaKt7c7H+aOhHxI0uMaye428gdlLtkvGi0eQ2x1I1b49WGqGpZecJCpMuBetQW8
	 xpIkKilxXEtwrYM5o+fHmG4mxODCAqXSPrg6tujReeRNjDI071kNXqbBSk/v+5bMY7
	 7DtLl+yVDQSBQ==
Message-ID: <a0dfabb8-2243-0cf7-2fab-ccc1b58bd9d3@kernel.org>
Date: Fri, 15 Sep 2023 21:17:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 net-next 4/5] net-device: reorganize net_device fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-5-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230916010625.2771731-5-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/23 7:06 PM, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
> 
> Tested:
> Built and installed.
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h | 96 +++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



