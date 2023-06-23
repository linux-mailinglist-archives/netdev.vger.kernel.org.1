Return-Path: <netdev+bounces-13254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076773AEDE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507A91C20F3D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551EA801;
	Fri, 23 Jun 2023 03:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1AA20
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D305C433CA;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489222;
	bh=JXJYJ3odHojaOhw0PgCXiNnbZhgi+GFSkQOklJD2uWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o+ajRF+xjOZNqM4wxbfEhfD0LhoaJfi05qHwKoCIOivMJfzl2tpbW7sHF4VzH6+bF
	 xo1+dpjImbBOWjkBUir4YJphyBvr8KHiCLZ+XgzathKX9UHVoZsJt3x5EAfBkqC8af
	 b4ciemq6/zQf4r8tuFOznQOtDis9vDqjzdT1UERYmxHzqPNftLVDFKklUDCRUgdLTC
	 MP84jWQ5btHTxxZTz5b4LnuwfAnwLbLgNWaWoOJEQZVsVAaZp0go9Hny71XxaPgZIW
	 09803ypqa9sED810jqaJp06jhjbrFIVD4oMz7gBQ2oTfdEgXfZPKZ5JjfC4xzEXcnE
	 HVYYBCJrnrANQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48326C691F0;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: keep alive neighbour entries while a TC encap
 action is using them
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748922229.4682.8257467517424949523.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230621121504.17004-1-edward.cree@amd.com>
In-Reply-To: <20230621121504.17004-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 13:15:04 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> When processing counter updates, if any action set using the newly
>  incremented counter includes an encap action, prod the corresponding
>  neighbouring entry to indicate to the neighbour cache that the entry
>  is still in use and passing traffic.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: keep alive neighbour entries while a TC encap action is using them
    https://git.kernel.org/netdev/net-next/c/9a14f2e3dab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



