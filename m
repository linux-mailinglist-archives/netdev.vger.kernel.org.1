Return-Path: <netdev+bounces-227444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF8BAF871
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC71926CF1
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD827A124;
	Wed,  1 Oct 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loKRzPYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22229279DDB
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305615; cv=none; b=CUzW+MJNYG2tvgvdaNuIK+XxvXg8aJgBKVvGGYWCnroOsIZMxY4GevCV7jRfHm66a20H+PUnQsmsDbES25JaLXklMbxumafyWDlB1+1Te/QARvIKRo4XJfTI7pxBdHrxv4vZPs0Jzwhf4cmZmbOZI7otB3dWa4Ye0jB1I98zgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305615; c=relaxed/simple;
	bh=0G8AzvXcU7k9AueoVmmm8z2mWxmRzK/utx70FGakqZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0iZCOmM0grj7JGZxQtJKrJcgt/0eDOS4VqCp42aTNossLk1RNZ/LL2rfizmyTbBzx6mmrw+B0XGyvs767BsEyruLzSL6q34pyMvrgHfqO1ms0EiCVG35u4T2jSGDJqyy/bq+icFvw8uxoESXIA6YEawQiVOjMHhMMqC2ZEqkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loKRzPYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FE2C4CEF4;
	Wed,  1 Oct 2025 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759305614;
	bh=0G8AzvXcU7k9AueoVmmm8z2mWxmRzK/utx70FGakqZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=loKRzPYq8XGx9T4xi+sAHrdHlNaJ9DnhKUSR8DePGJyA5BcmuMi1RwSlirK4o/sPV
	 LB4Zt/CDslCj70KsO/NCNjkUoDjeZnqOV+7pootaPSHY14BrSRJL2p054TRakp9VXM
	 gTAs9U+6IFvZP04UVOEXYuKuAi2YO7MUPUCN7tnzAkwKx7FbBqA5xYlBceWjJi4iDw
	 0FNYDZwh8nmkjlfxZWZA9zPikjbAMeVn0wK/ZX959sTpjUEcsotqGxAQpf9TfXHAwb
	 0B3eNdNQSBrzfmhtstu1eeC5vDSwvPdkIwBfaHpGTChxxtvplNMXJQO+cE4fiFvSm0
	 KQEA13n+QcR2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7145439D0C3F;
	Wed,  1 Oct 2025 08:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "Documentation: net: add flow control
 guide
 and document ethtool API"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175930560701.2373658.8805390365413315395.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 08:00:07 +0000
References: 
 <c6f3af12df9b7998920a02027fc8893ce82afc4c.1759239721.git.pabeni@redhat.com>
In-Reply-To: 
 <c6f3af12df9b7998920a02027fc8893ce82afc4c.1759239721.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, o.rempel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Sep 2025 15:45:06 +0200 you wrote:
> This reverts commit 7bd80ed89d72285515db673803b021469ba71ee8.
> 
> I should not have merged it to begin with due to pending review and
> changes to be addressed.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "Documentation: net: add flow control guide and document ethtool API"
    https://git.kernel.org/netdev/net-next/c/1a98f5699bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



