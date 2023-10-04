Return-Path: <netdev+bounces-38033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D87B8ACE
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9C162816C6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6801D68D;
	Wed,  4 Oct 2023 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaF7Drkd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8471BDF1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A696DC433C9;
	Wed,  4 Oct 2023 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696444829;
	bh=TdNIT7YcFpP38LtyOuUncJP/3YiSnHJ79w9V/RLoX44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qaF7DrkdMBO/25ufp9V6HQfAvIBjLT//8Xk3cjvQ9fwDBMD5n5YXfcnX16u4XrM7S
	 6od4tG1c61ASv+7qQIsGouBru9iZ7VV6GvLzqtFdyGfzQwsCRWudPCYzkpUrOxftqG
	 n29m2HBrbTSRQIFRFuB38eLa4IDeLb5nv+kZJA8i+zj+f84MV5tM2dx5qiimVu2vIP
	 s2npcA5JDZyeyb/NDGTZofeQ22msoSegOpRveKsY31JOIYTYzNs1BiiBOTClkDwrmI
	 MDiCC0+MdlKocKMR26UG9uEXe/SfJKYXBi8dkkqkxn8/qeMZCTzIZG8sTq8PM/vPzp
	 3B3hXPIsuFyYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89FC4C395EC;
	Wed,  4 Oct 2023 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-09-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169644482956.7260.12644444542884934909.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 18:40:29 +0000
References: <20230927095835.25803-2-johannes@sipsolutions.net>
In-Reply-To: <20230927095835.25803-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 11:58:36 +0200 you wrote:
> Hi,
> 
> Here's a first wireless fixes pull request for the 6.6 cycle.
> There are quite a number of fixes here.
> 
> Note that this has conflicts with wireless-next, which I guess
> then Stephen will report between net and wireless-next after
> this is pulled, rather than between wireless and wireless-next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-09-27
    https://git.kernel.org/netdev/net/c/72897b295999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



