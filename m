Return-Path: <netdev+bounces-60939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97AD821F03
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4216C1F227ED
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949B14A92;
	Tue,  2 Jan 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH2V2bpL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94114A86
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7215FC433C7;
	Tue,  2 Jan 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704210792;
	bh=Qx6gm/R7ydGVtnRaFT2kBGQXKFtwiD3wlXhbIiYXlWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uH2V2bpLRAKBjfy5jprulB51DXZSTKRO6UFmAuqQ2W0ozDTlQKNIXXyWa+30e6MR/
	 94bGXHfWonbedaVcxM9KcOd8gpP8XAc2faK2Lk99f3dP3e73m0kjLWW1QgAFOIEscR
	 Rx/R4nskecfC3fQxL5cWIMLrqgxyH6eF+CbGqVZRCcjRj9Uq/h+WUByg0HL9O6RL/F
	 TB3HONYM4EnOJAi8GUUSLNVousLzqkyt998LvhWwPLf/oTsCEVFW9wRMMjax28SGXx
	 5eNvK6393umiofoQJH2Ai21fILH0cVk3oQG5Rtg5iKC+hItukNPlbq7pNsETneRlMb
	 KHr1ZciSY8qag==
Message-ID: <92bde58c-eea8-400a-9773-b364208a7326@kernel.org>
Date: Tue, 2 Jan 2024 08:53:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] fib: remove unnecessary input parameters in
 fib_default_rule_add
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240102071519.3781384-1-shaozhengchao@huawei.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240102071519.3781384-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/24 12:15 AM, Zhengchao Shao wrote:
> When fib_default_rule_add is invoked, the value of the input parameter
> 'flags' is always 0. Rules uses kzalloc to allocate memory, so 'flags' has
> been initialized to 0. Therefore, remove the input parameter 'flags' in
> fib_default_rule_add.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  include/net/fib_rules.h | 3 +--
>  net/core/fib_rules.c    | 3 +--
>  net/ipv4/fib_rules.c    | 6 +++---
>  net/ipv4/ipmr.c         | 2 +-
>  net/ipv6/fib6_rules.c   | 4 ++--
>  net/ipv6/ip6mr.c        | 2 +-
>  6 files changed, 9 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



