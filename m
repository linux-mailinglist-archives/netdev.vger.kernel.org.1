Return-Path: <netdev+bounces-27174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2377AA0F
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A531C2096E
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195E79C3;
	Sun, 13 Aug 2023 16:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DFBA4E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33A93C433CA;
	Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691944221;
	bh=qgbZN4zvsuMYrMGFpIEV5rEUbmtEOT6zGVYdDfXtBmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VXSdF85BgrklUp4zGrKHpNREIE9rqADvWs0TS4zJ3fX3MZXrurqFLl2Gtef5JRvyL
	 pwhZHFyoivKQWHX0sqFn9+Nhvmv+EYyCinGiozfWew4ToC102Igv1yvYv7b1LRa2ik
	 KS3O4aTWaW0Wx0ZB1Dk/KD+kvL4JpQTKutPIE6xMMv+luptZFpMUNe0dnqjivSB5D6
	 n0rlE+llEcO6weWonWsccTktQFjGqSwW4TEFaSrx0dDX/r4vmBRKTZGt0s0lSPDtGV
	 EHo3TUYCYmvwcw1IWZgMkliFXNNnyKdzHq0DAYttrNFlJrDnv65CjhJqXqxzxaz+ge
	 epvufJXaXEkcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BCEDE3308D;
	Sun, 13 Aug 2023 16:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch iproute2-next] devlink: accept "name" command line option
 instead of "trap"/"group"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169194422110.10262.13744709760269672659.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 16:30:21 +0000
References: <20230810140102.1604684-1-jiri@resnulli.us>
In-Reply-To: <20230810140102.1604684-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 idosch@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 10 Aug 2023 16:01:02 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> It is common for all iproute2 apps to have command line option
> names matching with show command outputs. However, that is not true
> in case of trap and trap group devlink objects.
> 
> Correct would be to have "trap" and "group" in the outputs, but that is
> not possible to change now. Instead of that, accept "name" instead of
> "trap" and "group" options.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] devlink: accept "name" command line option instead of "trap"/"group"
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=27724f3cbb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



