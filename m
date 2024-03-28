Return-Path: <netdev+bounces-82791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5988FC0B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340851F2D992
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A37657D3;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIof3JCo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBF657C5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619430; cv=none; b=XyrG+EFdw0Fh8m+jlZuuwNCdyvE7UhN8rNNTcbvzbOusLT4hNST8TDjgF2wzrOU0mTY6Dq58vQ2InONE38rL2Mo3E6Okt0aLf63f4uxcNB1wnbY/aO/UqCJlLzNtpiiQUJWwWS7LNQtvLjrktGaCboc3lPF+86I4ITilvrKtrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619430; c=relaxed/simple;
	bh=td7YF3G7td7SP5UtGsDd/CBlTqJShuZDB94LlUHikT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I4j1ELuGYScgaS1Fa/ThHsBsIgX2AV6rzOBB3uLnvv8vDcOTq8wy9dNHWaWuia7vgP0NntJEPsTzuG+8LAiZlwW1k1k5wVey4w+S686ahEW3WFPkA24qtKHs8Li1JZVr8fbZBJTW728mD7cTi400evzMc94fs6iAF6BkGQ8Z/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIof3JCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ADB9C43394;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619430;
	bh=td7YF3G7td7SP5UtGsDd/CBlTqJShuZDB94LlUHikT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DIof3JCombKxLEvlbhHoWsuzum/8UH+ylPEt/zEGoauCVHktTuFdiSU2jfiipOK3Y
	 5O05hjRXtK4OEEyXEgznLRbQbkQDGIvsgTTbHRko3K77dOq8rooSB/BrCfLAVJL6n4
	 Ty5vCzjWrxMheGZ7pE197hiHTmP+E16BVmDcRWcdGoB+Oo4Amoa8SFFYTPaaPe8S9J
	 j8tB9jHS1gGSbt5TEcel3F/of/pWyEt74gcmqAtozG7dJOHBC+pK3HBLDiwSym7zKw
	 1wGhb/qXy02eVHYYpFxSgylGRpg1PW2diTqfrBUKhxN+tJXP1XKNDkG3DZdVuYNFuj
	 9HKLg3B/x1QKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D507D95054;
	Thu, 28 Mar 2024 09:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: bcmasp: phy managements fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171161943024.10354.1449754559540600038.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 09:50:30 +0000
References: <20240325193025.1540737-1-justin.chen@broadcom.com>
In-Reply-To: <20240325193025.1540737-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 12:30:23 -0700 you wrote:
> Fix two issues.
> 
> - The unimac may be put in a bad state if PHY RX clk doesn't exist
>   during reset. Work around this by bringing the unimac out of reset
>   during phy up.
> 
> - Remove redundant phy_{suspend/resume}
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bcmasp: Bring up unimac after PHY link up
    https://git.kernel.org/netdev/net/c/dfd222e2aef6
  - [net,2/2] net: bcmasp: Remove phy_{suspend/resume}
    https://git.kernel.org/netdev/net/c/4494c10e0071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



