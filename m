Return-Path: <netdev+bounces-14607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3C742A53
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB75A280EE4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFE12B95;
	Thu, 29 Jun 2023 16:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268F12B89
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D20B6C433C9;
	Thu, 29 Jun 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688055021;
	bh=129ZAjftJOObQhFygTzl6SithcwVVa1iV9QnSZkkpQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EubKAmWwn/HvdSyK0HH8JlonthZIIqskfYD2bpp6BeNU2NoAIp7a1pHgP7JR32mPW
	 9oFQZ4VhfGJ2Mh6ELgLkZtQR94J1RppE8OXeype0hM79mygs5gvCJaVT7/FMgEzVyy
	 g+65Xda9WJYiyThpn9+d7TCS6ZX3GJrQbI7VrtoJfWgkUwxBHG8ZaVGsCs6M3nH1cI
	 GE5gwHuSR7bmOHC2MGWT7s7vDXDZuyRKsy/YcOl1DmFQIeSpWb3/ibla6hAJTlpChu
	 6eVgsHGS99eYBe4q/q5cllXM4JWS2eMQ7WE/iPJYiSqzZhcoyVeDh8GUOZqqkzF+9E
	 6JgFPLH9PEP8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3538C43158;
	Thu, 29 Jun 2023 16:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/5] Warning fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168805502172.22643.5853736488057029696.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 16:10:21 +0000
References: <20230628233813.6564-1-stephen@networkplumber.org>
In-Reply-To: <20230628233813.6564-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 28 Jun 2023 16:38:08 -0700 you wrote:
> Compiling iproute2 with -Wextra finds some possible confusing
> things. Easy enough to fix.
> 
> Stephen Hemminger (5):
>   dcb: fully initialize flag table
>   fix fallthrough warnings
>   ss: fix warning about empty if()
>   ct: check for invalid proto
>   ifstat: fix warning about conditional
> 
> [...]

Here is the summary with links:
  - [iproute2,1/5] dcb: fully initialize flag table
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9ef3210bc7df
  - [iproute2,2/5] fix fallthrough warnings
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=2b41725d2a46
  - [iproute2,3/5] ss: fix warning about empty if()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=27dce6de940a
  - [iproute2,4/5] ct: check for invalid proto
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ac6d95a8465e
  - [iproute2,5/5] ifstat: fix warning about conditional
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bbfccc11e1c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



