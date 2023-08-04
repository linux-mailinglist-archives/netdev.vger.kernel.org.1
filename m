Return-Path: <netdev+bounces-24309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FB76FBB6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50056282511
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE4882F;
	Fri,  4 Aug 2023 08:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC38498
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92F64C433CA;
	Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691136621;
	bh=MyMAdb6CiOjLDWY+F4J50FHHSA1MHbOs6THd4Kdgwq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0iTQQONi6Ir3vbt7hU9ZPd3MxGs8U10HP9sucdulsI2YsACMmcF9YdvzAj+t3SIW
	 CC6YADlWmnybdmNjvOX6BRNg6ItjbXfeefnly2NW46CVdWwS8RI8Vy+bZ0Zk+Q3gHP
	 9mCy2jhJLZiibd1tuFABRGvfwkr+QTWDOEbGzrC/8VB540JO0j85mmeDUDo7Eiu82B
	 ZJlQQGP76YiEIvbK76StWehHR43J83v2hfcJWnCIBp6gZ3+lZM6v94sW6T90KwOl1N
	 psaMVZDjYdjwKyp8Nn4C9E3x0LLUyEiLx7fLNlFdbxrdK3FCuhealNcfOj9FcDXdHM
	 oizXo+WrmourQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76E5FC41620;
	Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: vcap api: Use ERR_CAST() in
 vcap_decode_rule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169113662147.21944.10536681717730893008.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 08:10:21 +0000
References: <20230802093156.975743-1-lizetao1@huawei.com>
In-Reply-To: <20230802093156.975743-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 2 Aug 2023 17:31:56 +0800 you wrote:
> There is a warning reported by coccinelle:
> 
> ./drivers/net/ethernet/microchip/vcap/vcap_api.c:2399:9-16: WARNING:
> ERR_CAST can be used with ri
> 
> Use ERR_CAST instead of ERR_PTR + PTR_ERR to simplify the
> conversion process.
> 
> [...]

Here is the summary with links:
  - [net-next] net: microchip: vcap api: Use ERR_CAST() in vcap_decode_rule()
    https://git.kernel.org/netdev/net-next/c/58e701264f15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



