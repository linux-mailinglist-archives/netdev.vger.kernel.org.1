Return-Path: <netdev+bounces-47334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DBD7E9ACA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54940280C9A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0A1CAA7;
	Mon, 13 Nov 2023 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGSDZhT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361631CA96
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4A42C43395;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873824;
	bh=lsuyU462acZPew4lIcaiw0PWHQuwasNLzdBbK/6/nhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vGSDZhT+p21V02PpTuy9s2Xij89dheJW7eDrr/GAO3QrCZ344itXoL3XauSKM03b9
	 SqoGU+HpEKsX6/cCLClBkYTXOByUkt4u3rDz1guxSM4PdG6WB+gDl9/4iB8TK7sXuX
	 D0ZfwxVhmhnjx+dlSh+pJ5LycOwdiqxIEI8l1WM+mN9y4uVlQVbFH/RD+TsXNK6CHh
	 RWk6G9p9crd2c7ykjR/WOYNqlvSqkIoGLdQp+UbqW5JNlfMz5OqirkSCJFzPiFtLVM
	 jUkpm7GiP0v/E2CzUWdcLQuwQmLp9sCSDiz9EaFOPITLksiXDk5lL39x+Uc88qNt4Z
	 rvG29sFPStoRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83907E32715;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: fix typo in header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169987382453.356.3314257711307546565.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 11:10:24 +0000
References: <20231110120546.15540-1-kabel@kernel.org>
In-Reply-To: <20231110120546.15540-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 13:05:46 +0100 you wrote:
> The quotes symbol in
>   "EEE "link partner ability 1
> should be at the end of the register name
>   "EEE link partner ability 1"
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: fix typo in header
    https://git.kernel.org/netdev/net/c/438cbcdf105d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



