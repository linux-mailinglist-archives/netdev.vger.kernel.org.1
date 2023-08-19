Return-Path: <netdev+bounces-29091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9CA781960
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9346F281C39
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2C611F;
	Sat, 19 Aug 2023 11:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD9611E
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 11:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D05F0C43391;
	Sat, 19 Aug 2023 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692445903;
	bh=GyFU6T0F2OLpd6ALmXN+jAt+vbRAupCEOdTo8blHr2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3Hq3ZLeskmN+egFuL4uTPl3pS4N5Pan9mqN2RTBePrAs2EHkWtv/6OIanl57V49l
	 KAe9YLvKHnO85BqGHZzv4+HpSrYDSdQ1Q57rn+MVi/p3H2OPmTX9TtN1eWN7iYHec2
	 rt8DUEgAJk+uDqGvQHfhYk8b/PCiyd+qTlV/xzWQ+LJ6jKcRW24LuwQsCPDO/uwhml
	 m4mNwWl1pgjiCoXiU7SubfJYR7ywJ2Cx4nEXGOCPjw0WtMoJn9qyrCP0eptVA3qs1o
	 2B2Yik6e8jq/J6MYlFAHVhyTWyVNGRhHFRQSCgZdyjwc7hwAPTJVdxG56ip/9eKMsh
	 UdrQj/O+h721Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB93FC395DC;
	Sat, 19 Aug 2023 11:51:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net/smc: several features's implementation
 for smc v2.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169244590269.30754.2401576809256028711.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 11:51:42 +0000
References: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20230817132032.23397-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
 tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 17 Aug 2023 21:20:26 +0800 you wrote:
> This patch set implement several new features in SMC v2.1(https://
> www.ibm.com/support/pages/node/7009315), including vendor unique
> experimental options, max connections per lgr negotiation, max links
> per lgr negotiation.
> 
> v1 - v2:
>  - rename field fce_v20 to fce_v2_base in struct
>    smc_clc_first_contact_ext_v2x
>  - use smc_get_clc_first_contact_ext in smc_connect
>    _rdma_v2_prepare
>  - adding comment about field vendor_oui in struct
>    smc_clc_msg_smcd
>  - remove comment about SMC_CONN_PER_LGR_MAX in smc_
>    clc_srv_v2x_features_validate
>  - rename smc_clc_clnt_v2x_features_validate
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net/smc: support smc release version negotiation in clc handshake
    https://git.kernel.org/netdev/net-next/c/1e700948c9db
  - [net-next,v2,2/6] net/smc: add vendor unique experimental options area in clc handshake
    https://git.kernel.org/netdev/net-next/c/7290178a82fc
  - [net-next,v2,3/6] net/smc: support smc v2.x features validate
    https://git.kernel.org/netdev/net-next/c/6ac1e6563f59
  - [net-next,v2,4/6] net/smc: support max connections per lgr negotiation
    https://git.kernel.org/netdev/net-next/c/7f0620b9940b
  - [net-next,v2,5/6] net/smc: support max links per lgr negotiation in clc handshake
    https://git.kernel.org/netdev/net-next/c/69b888e3bb4b
  - [net-next,v2,6/6] net/smc: Extend SMCR v2 linkgroup netlink attribute
    https://git.kernel.org/netdev/net-next/c/bbed596c74a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



