Return-Path: <netdev+bounces-29175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29326781F2E
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 20:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD0F1C20818
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876163D7;
	Sun, 20 Aug 2023 18:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1F6FB7
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F8DEC433A9;
	Sun, 20 Aug 2023 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692555213;
	bh=ei+p8hV0PnHP7jSucthnjvGhMjYYT95mLjIgqh2mZlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BEV/j3Qpa4zIiDYyehhTr5ELnTn7pNRq9Fsl/YbHqicvn+3SYczMSLof65/mcGxCt
	 KIb+3cyvWiq7x2JEVsoHMZE82s9fbmPWw0PEqMEBeiCUKq9dGr8d0J7yFw8LcWeOQ4
	 HdXnN2Fk1TSZu45PmfEx2JdC0fWrwyQ8gMX2mK9pX6LuAfRzEadmu+4qf8/HJqUIlP
	 8E5XCv9xPUnPbg7Y9/CVX+koSOnXKOV33swWJJd9EFxSF2ufZSPMNITfQQLkm8FyI6
	 ntII1aLBYIKEg97xLWcImaKwi47T3vF034QZCvxLBqM+YfqADrQgi49fvoC1IcMVth
	 Uum086ROGCoVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23BD4E93B34;
	Sun, 20 Aug 2023 18:13:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] utils: fix get_integer() logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169255521314.4244.14290712912067106441.git-patchwork-notify@kernel.org>
Date: Sun, 20 Aug 2023 18:13:33 +0000
References: <20230819205448.428253-1-pctammela@mojatatu.com>
In-Reply-To: <20230819205448.428253-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 19 Aug 2023 17:54:48 -0300 you wrote:
> After 3a463c15, get_integer() doesn't return the converted value and
> always writes 0 in 'val' in case of success.
> Fix the logic so it writes the converted value in 'val'.
> 
> Fixes: 3a463c15 ("Add get_long utility and adapt get_integer accordingly"
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] utils: fix get_integer() logic
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=877f8149d2ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



