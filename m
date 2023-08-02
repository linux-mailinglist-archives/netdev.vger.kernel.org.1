Return-Path: <netdev+bounces-23594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6A76CA39
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F48C281D59
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407EA63B7;
	Wed,  2 Aug 2023 10:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECA6AA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AFFEC433C7;
	Wed,  2 Aug 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690970422;
	bh=FPRl2HNxjLc8V+O4vQftM6yHwj2vyX/mrJkXMVdFEJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvOKquecNedOL2EJWTcos0490C8Jui3Wnh3/cCpF8C8MrmhkA+w5AK1TIfEG+QBms
	 qQoRugeRKohuI6Rc3AXwL1uhoEL6vC6mpEIq70BX77RyXSsJmNqSBm5M9f6WVpnfw8
	 XkhQWZRIeJ4QyIRwqGQMcGGigyRQ2drgpovbxu0McHIUiiQtwIeLf17aR7E4CMaO++
	 cnztIe/BXky9hXz0Al42jqq94z3/chEJHLBWA1/kmmIs/S1O7Q/KlY6wMcNsML6u4d
	 FgfCHiCSINNtpIIHueZHC/tlSvcxXMA6CrKg6J0E09rtzZ/6HiH1DKzDssKeOib427
	 mSjFmLBwV6z4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E167C6445A;
	Wed,  2 Aug 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: Fix nexthop hash size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169097042224.27102.18191188940044063073.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 10:00:22 +0000
References: <20230731200208.61672-1-bpoirier@nvidia.com>
In-Reply-To: <20230731200208.61672-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, roopa@nvidia.com, idosch@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 31 Jul 2023 16:02:08 -0400 you wrote:
> The nexthop code expects a 31 bit hash, such as what is returned by
> fib_multipath_hash() and rt6_multipath_hash(). Passing the 32 bit hash
> returned by skb_get_hash() can lead to problems related to the fact that
> 'int hash' is a negative number when the MSB is set.
> 
> In the case of hash threshold nexthop groups, nexthop_select_path_hthr()
> will disproportionately select the first nexthop group entry. In the case
> of resilient nexthop groups, nexthop_select_path_res() may do an out of
> bounds access in nh_buckets[], for example:
>     hash = -912054133
>     num_nh_buckets = 2
>     bucket_index = 65535
> 
> [...]

Here is the summary with links:
  - [net] vxlan: Fix nexthop hash size
    https://git.kernel.org/netdev/net/c/0756384fb1bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



