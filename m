Return-Path: <netdev+bounces-226425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251DEBA00F0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6825381E11
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D72E0939;
	Thu, 25 Sep 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2HJQTVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105E2E0935;
	Thu, 25 Sep 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811578; cv=none; b=Tg65JwrekQm+zxXta8zRCPXQst6YROVQFGjPGSTFyw5MxdFtJUTQ+UIq7ycD1TGunX684HC2JKejEVzUPeWnYn7N8SNc3wVp+lj5NugVRuezzmxI5onrVq70IZRxoBXPN2ZXU9Q3I2gDcpXv1pG7tqLr0l1XiEPQ86+aZFaHEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811578; c=relaxed/simple;
	bh=Mj2a8aL7zcXqs6HmUXXisC7uyuh5URV9y0aKLWuWLgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cr0d/XWYKygJiEybdu6YFiI7oyv0c0VITMct4aU8qpmwm9p1x2DgS6ciFjPoLERZ4CzqQbg8IO2oRMOZVazC/wieMzLbxS6mfUGHWmXNPf9fyyziZ6aGG6FiE+Wp3owvZRTEn6nE+daOgp7sVPLL/vGBxx6OjVfbGRiCz9mWphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2HJQTVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7D6C4CEF5;
	Thu, 25 Sep 2025 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811577;
	bh=Mj2a8aL7zcXqs6HmUXXisC7uyuh5URV9y0aKLWuWLgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2HJQTVddWFsfB1mGzS2RQiKXTAexbeVXrDs+VQ9PhtMN7K59jdDrvt6nFx12OB6Q
	 jJWyFK73e68crtlEa8bkXCDg8II2UrCDSZMhWS4cBL0PBvVzeeXgo67Q5dbYWymTCr
	 +w79EOZCg6hSxpUe0O8hlqD0rSAoJ0gwtPhobWCzjJQ5y5OUIf3oHYvhswFmqERXqY
	 En0QvAs5G8W0kCPmUO8NAiyypx3tSOpOwKV7aCyd4WfpGg/2KINZcuuwVr5Pt1V1k6
	 qNv293TFDTxmCx0m1H9CawxmlfBR0STj+uKaQAiAOeieG6s84Z9ILE+T8cC5SgHIob
	 OnyPdQfBkgyBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5339D0C9F;
	Thu, 25 Sep 2025 14:46:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-08-29
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175881157349.3004481.1649684501926804999.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 14:46:13 +0000
References: <20250829191210.1982163-1-luiz.dentz@gmail.com>
In-Reply-To: <20250829191210.1982163-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 15:12:10 -0400 you wrote:
> The following changes since commit 5189446ba995556eaa3755a6e875bc06675b88bd:
> 
>   net: ipv4: fix regression in local-broadcast routes (2025-08-28 10:52:30 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-29
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-08-29
    https://git.kernel.org/bluetooth/bluetooth-next/c/0dffd938db37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



