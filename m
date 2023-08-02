Return-Path: <netdev+bounces-23666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DAD76D0D2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FB9281DC8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5638460;
	Wed,  2 Aug 2023 15:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAE6FDD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C53C433C7;
	Wed,  2 Aug 2023 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690988457;
	bh=y62yU1+3klsO39+IlfIlhlfbFhys4Rfxzw5N57N9DoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZgECgHqbjg9dEdqqjhdIRhCJhnNIborbV/mUgUvSqzxk79+1F/LAZZo5jhWaYVsMj
	 GscJ4/deBsXDmP871YAAgMO2wgUh+ZHsCZM8AzCFZZRwONda3WZpoE8IR4ZehhKrIw
	 oTH7yehRsL3OkSI0ILnS3EBpqppLLjdEiql3/H+2OvcchIBRSOkzcABiis1ZigVEDB
	 DI7E6DwjGUIoP3WwpMLkBvHLFDHRQmcx4+5Xbg6+xBZB6dooAz4ZME/bwiRJ79BHoi
	 H9b67WuVticw1C3GhFllOveXbIJ5yyeF5Preb/o2Cx1e0hHSQnF5KcNpgBY1TEmzB/
	 pwTih5lj5+pXQ==
Message-ID: <850515d7-6251-b503-f793-e80e6ec6df58@kernel.org>
Date: Wed, 2 Aug 2023 09:00:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] ila: Remove unnecessary file net/ila.h
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230801143129.40652-1-yuehaibing@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230801143129.40652-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/23 8:31 AM, Yue Haibing wrote:
> Commit 642c2c95585d ("ila: xlat changes") removed ila_xlat_outgoing()
> and ila_xlat_incoming() functions, then this file became unnecessary.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/ila.h       | 16 ----------------
>  net/ipv6/ila/ila_main.c |  1 -
>  net/ipv6/ila/ila_xlat.c |  1 -
>  3 files changed, 18 deletions(-)
>  delete mode 100644 include/net/ila.h
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



