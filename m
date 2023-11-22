Return-Path: <netdev+bounces-49946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6D97F4077
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B90B208F9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F082231D;
	Wed, 22 Nov 2023 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEzOxTCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9822079
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5EEC433C8;
	Wed, 22 Nov 2023 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700642704;
	bh=hKVXQ2uG4jwZv7zXXg6r0jDUx17d9AF4dkyWu2fhhY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JEzOxTCe4he+kyfOPoWvRXQXGpUo4qsBJkMe7fjksaej4RefRqkhhTIlpOEVqru2+
	 FK5LkUwGljq2uCwohvU03EwMog5GKAsd/Uez2nFizVlVU/QLcNO2XBCXVm2ZBu75dq
	 wHnIP4iNaHLunHNKQ/a944ArBhi8LQEm5uBdLfyu7YQOIKEEgWcUSay342lh8vWojm
	 6NVWNwwSzIzS2ahoyLvqoxwFER+A1CYR1FqEppcvH2q++HF8p3HA8sV5dtfVZ56l9f
	 4R0Nrc5yJ/VQxCN7nci2bItMh04sMWO9HlHKHApPlGZ5tY7ePLeWI1ZrC2ggxsJmLd
	 3WxSv+k/g5muQ==
Message-ID: <6df5b3d0-2ff5-4c30-a0fd-20a6a6db6622@kernel.org>
Date: Wed, 22 Nov 2023 09:45:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/15] net: page_pool: add netlink-based
 introspection
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, kernel-team <kernel-team@cloudflare.com>
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121173158.32658926@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231121173158.32658926@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 02:31, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 16:00:33 -0800 Jakub Kicinski wrote:
>>    net: page_pool: split the page_pool_params into fast and slow
>>    net: page_pool: avoid touching slow on the fastpath
> 
> To relieve some of the pain and suffering this series causes to our
> build tester I'm going to apply the first 2 patches already. I hope
> that's fine. They are pretty stand-alone and have broad acks/review
> tags.

Fine by me to apply the first 2 patches. Thanks for communicating this 
as I did get confused seeing patchwork-bot reporting this was applied 
and seeing a V3 on the list.

Keep up the good work. Overall I like this netlink-based introspection.
I'll try to get some opinions from Cloudflare people how this can be
integrated into existing monitoring systems.

--Jesper

