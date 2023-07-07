Return-Path: <netdev+bounces-15987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5574ACAE
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3F028168C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B558C1F;
	Fri,  7 Jul 2023 08:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FB6FA3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA042C433C7;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688718020;
	bh=YCzicnHYN554Uw+7a1ovIM3qEhqiU45mwQwmAxAwrb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xt8oPwdOBmrk9UhRAbiUpxgOzGj0xdIiEVU2SKkxnJFKZlw2Ke1dxuFslL/h5XnBE
	 fjgM+8EaHkeMXZIJJHCI+ubJfS4JuLVyo/umfcIvFBp0+qfGGUQdYJcSfqJn1MKO6K
	 vNAN/mMAHDuB2VUvYLnuX2jDCji2T1asRV5/1Q1HsT8MA7PheJk0tuCZ43Uye3/6ER
	 1bCFX9ofSXQteZNqOFkZs7fYR942VRQTYmL+qm432BXHeA6IX6CdwZtZz6sfAGYXfg
	 4HOy/sRe6k9wmx3AW+GUlZI5OD4BZuEfUYCC+IS0e1wueGNjyOXRUV/c21TPgvpC7f
	 X9yKQYrMfkOMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8E42C0C40E;
	Fri,  7 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: remove dead device fail path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168871802068.22009.18236909548766833085.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 08:20:20 +0000
References: <20230706205924.58103-1-shannon.nelson@amd.com>
In-Reply-To: <20230706205924.58103-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 brett.creeley@amd.com, drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jul 2023 13:59:24 -0700 you wrote:
> Remove the probe error path code that leaves the driver bound
> to the device, but with essentially a dead device.  This was
> useful maybe twice early in the driver's life and no longer
> makes sense to keep.
> 
> Fixes: 30a1e6d0f8e2 ("ionic: keep ionic dev on lif init fail")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] ionic: remove dead device fail path
    https://git.kernel.org/netdev/net/c/3a7af34fb6ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



