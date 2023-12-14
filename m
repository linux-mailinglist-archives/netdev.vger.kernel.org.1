Return-Path: <netdev+bounces-57197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E934812557
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3138B209AD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559DB814;
	Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO7sH6WI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38740180
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDBD0C433CA;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521625;
	bh=u52HoA/r064z5Cj70vQADEgDIM05KePhooGZRdVJ7Mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MO7sH6WIO6gVLA/n1oq6Dt+yuegnSqlTZt/v91OkTr0w20E6AC+32R7FJTiv/sM7r
	 J1CB3yUOTM/Rl3XxI3grwWMw1LP+a8UxrLLIsskIq6iYkQgn0GRQR+OhsdaiyjwEK+
	 FZNj/HoRd+Fq87yLclvPRCJod3xgbdROp3Hxw9khop/Ta8c0jBaAMJRMPX5tFdSfni
	 N+77uBmryt/WKjqfX/OmtrN6X6Tlp0/vc5maQjfgarQtST/0q3VyH+VyZcoUNKMx02
	 wfic0ZyFWIkEx75rNm2ksDnowIY2QGjtUu0ok+QQSQ8FZqg3DSwZO8U0GIZ4yGbEaO
	 SCAiGV9jQlj2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDD65DD4F13;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] dpll: allocate pin ids in cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252162577.2494.3673019032132073803.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212150605.1141261-1-jiri@resnulli.us>
In-Reply-To: <20231212150605.1141261-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 16:06:05 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Pin ID is just a number. Nobody should rely on a certain value, instead,
> user should use either pin-id-get op or RTNetlink to get it.
> 
> Unify the pin ID allocation behavior with what there is already
> implemented for dpll devices.
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: allocate pin ids in cycle
    https://git.kernel.org/netdev/net-next/c/97f265ef7f5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



