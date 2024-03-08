Return-Path: <netdev+bounces-78596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D6875D66
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB9CB22BD4
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2423BB38;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnjbmFpz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4422E859
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=AOnzqQfgQKX36Di+zvQXSVC1ys8vwabst4oNR0Bn2NmDPrxuzrF/55pCTgu1IZehp41SQ4Ij+Xq7CEO3XdzYjyq7IyZGd9vEgG7D03YqX5vrmNQMj3z00jOy+UaEjrBft3WH2ANni3xZ30xgCY8mPgzLjFsuZ+a5xjVllXaXsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=pYf1ttMHdEHzIZ3tgcUFQoBtrpJa/udknJ4ErKS1X50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=saASvRYB9ecJd6f0HVEWnLpf8AialmgyEAkFj/O06lAgSBlbSq10CmWzTvtTj7glVAk7xXwmbl0aYCXjlNaiVvQI9Q0+3+vTlvtmYJL2j79oRTDQAhRZBzzgHskVwSGUC9x4WxsddVSHlMKsHd7PkLaqFUf3iC1B8bJZCo9hBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnjbmFpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C6FC4166A;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=pYf1ttMHdEHzIZ3tgcUFQoBtrpJa/udknJ4ErKS1X50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnjbmFpzp/mQ0lPIGoZCyQRb5cq/VZ8WKR2IX3UZeiv4I1j19XANhyH6OGsQ2gxrE
	 6WLdO4BWW1MbRiU0ip7CpyQm8qEcRswJXPBhmSX/p5fLaRUmiroFcHGRdLsaWjkZFE
	 APh4rhKjmAQS4COZZB2QcHY5+u1V3v7NSE2rONr5ySOMMvQJODoo9MAWVozAeyTR8E
	 3CMAPfBnaZ+GVveKOe9LHJ9+Ic1AsCg+rEuFEvwRcY6VXly7XIiY/xsuFmbax+Jjr6
	 w1Jdx1sggXa0KdOGHcPkR2CdBPozeEFI8KHM9IiCMbwFO0tC2IXFp/NaIKHXhFNEtt
	 w/q/FlEyl4JEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D5B6D84BDA;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin capabilities
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403751.8362.7998367234270091997.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306120739.1447621-1-jiri@resnulli.us>
In-Reply-To: <20240306120739.1447621-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 13:07:39 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The enum is defined, however the pin capabilities attribute does
> refer to it. Add this missing enum field.
> 
> This fixes ynl cli output:
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: spec: use proper enum for pin capabilities attribute
    https://git.kernel.org/netdev/net-next/c/5c497a64820e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



