Return-Path: <netdev+bounces-50511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E17F5FA0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA81C20FFA
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AE24A05;
	Thu, 23 Nov 2023 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUYio1Ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685A241F2
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 13:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0FFC433C9;
	Thu, 23 Nov 2023 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700744424;
	bh=FIrOFNfKs9XEJ/yHdkAJmORn6V1oRynha/vBc4c79is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUYio1AoONSxVLrlpJo82m6FJRdBUaDHNuofLdcfV/oyvP2EaJ42/606m+3VQCCEz
	 aRY4y6fKyiVTKmz0WstNU2CHrzNjIsdIj2laQXL0OWSwZr6v13SZL55Mo65brilV8U
	 SZyagFW2fzpJX+jgvHVcpcMDecK5TkLkuA+dLw19QIlkMh4nG0T7nm8Tz/wi5zSj4Z
	 +2LjamHE8ItrZVlaxVcklp8hQ9Oy3KHTTZQeldG9nWL/Kx7Da6iRiwsBTT+Q7di7/j
	 8XFPCSIMpz2UtfcY5IBM2wby2fF0iMjWrb5nylWcQp7irqPUaDVjmmpCQ5WuHlNdUQ
	 cNuN9RT6F1z8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 770E2E00087;
	Thu, 23 Nov 2023 13:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] amd-xgbe: fixes to handle corner-cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170074442448.28364.11322550122492166195.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 13:00:24 +0000
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
In-Reply-To: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Thomas.Lendacky@amd.com,
 Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 Nov 2023 00:44:32 +0530 you wrote:
> This series include bug fixes to amd-xgbe driver.
> 
> Raju Rangoju (3):
>   amd-xgbe: handle corner-case during sfp hotplug
>   amd-xgbe: handle the corner-case during tx completion
>   amd-xgbe: propagate the correct speed and duplex status
> 
> [...]

Here is the summary with links:
  - [net,1/3] amd-xgbe: handle corner-case during sfp hotplug
    https://git.kernel.org/netdev/net/c/676ec53844cb
  - [net,2/3] amd-xgbe: handle the corner-case during tx completion
    https://git.kernel.org/netdev/net/c/7121205d5330
  - [net,3/3] amd-xgbe: propagate the correct speed and duplex status
    https://git.kernel.org/netdev/net/c/7a2323ac24a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



