Return-Path: <netdev+bounces-29120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8F781A7C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826252819C9
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02717755;
	Sat, 19 Aug 2023 16:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C19A57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66039C433C9;
	Sat, 19 Aug 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692462126;
	bh=wp4FBXXZKGNfh+5PBusUJzB/XQ7M1f57EHatbREGoAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k9SF/TcfPr49k8pmI2DXQNzo36Hy/TCu8okO2B37QUjkKpUN29pJa0ZNy1/nKTr2C
	 eosw3MGbcOpM1Ng8QSVkky9s1IrB6CCyaPtPgnMfCEoJldhFDeEz+HCgb21Rjg7gAn
	 itELLyT89TdWNVlm7w84dg/n28ughChy02j2hvD8S3M++B0RdMj28pq2FbOEvhY/6V
	 rTgmZLtu4hfPuEIEH98/JADxcnuGSuOD3F7CgKKt/DTfTl2+Qf/YnVuFCAgYzFLpsi
	 FRT1gW7bCkCPkMdpAwIzxiHB9lWu02zBVwUZcTgprqk2UYYxgnFIzKnUZI43kIwwPM
	 Iq5ik8g4xfHIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F9E8E1F65A;
	Sat, 19 Aug 2023 16:22:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch iproute2-next] devlink: spell out STATE in devlink port
 function help
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169246212632.25427.17595297909304152055.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 16:22:06 +0000
References: <20230814072901.1865650-1-jiri@resnulli.us>
In-Reply-To: <20230814072901.1865650-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 14 Aug 2023 09:29:01 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Be in-sync with port help and port man page and spell out the possible
> states instead of "STATE".
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] devlink: spell out STATE in devlink port function help
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=872148f54e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



