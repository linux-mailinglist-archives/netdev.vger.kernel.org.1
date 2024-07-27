Return-Path: <netdev+bounces-113326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8593DCF6
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C65283ACE
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265D15C3;
	Sat, 27 Jul 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6xczYE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423EA21;
	Sat, 27 Jul 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722044432; cv=none; b=NqmOlwPlH2XizlY3p1nbRSlvrukLfcFlLoxlw1A1pvWBWVLOgmr1bTdebDcmSYCjz9+mLQWv+x+2e6z0EQ76MSTKWYLho8CC/O/scMDGH1wYgZSNNwEalsHKfIjwQhQYyd9pJ+IeV1JQY98oR/0CYjeLrCWHrenrsi7GpPzjVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722044432; c=relaxed/simple;
	bh=LCWfT71sRSq7sJhE3AvBAmU9qMtViIHyXNloePJJrLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KTA+dwfso6WG1DAJv+oamM09QV9H5rH14vzAn7hahNxfAJ3Rf4RFvEfxJ3OFiYknyVJYTiCteRhLzOCwg+Dk/FpyiLHnqkECz1XdW4BEFtl891ibiQDfvqqMWOldhvm2B8RZ852GLKDqdlgts2yLemoxUMD1RRLk1RsUAZqtDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6xczYE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 713EBC4AF0A;
	Sat, 27 Jul 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722044431;
	bh=LCWfT71sRSq7sJhE3AvBAmU9qMtViIHyXNloePJJrLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o6xczYE9ccp/c2OiZvaKomPRqY43hg0r1txQglGeAcocXDeYyGGaO++G56MG9rQ9E
	 lJmtChj4BgvJl5yJ8uS6HX+hI0uKhDTabY1MgISTEPq8Yi+4QYN70Fj2W5VkoeOfGO
	 iKbjuc5hAubV7wfIWIgygnfwzyUMAb8AZ8/cw+i4OU7lxN/BX6tYN/XKzAdn4RZICc
	 TiwDKbIIQrk+r4p60qvjTFkrcrcQmtZuZlrpXVMCyIdpU1QcrN8WGXKeHc83nECEET
	 tOmMHoGMN0rEVwiMxvqCqxBdGw0drvITkDWDwPgUl2P1wf7oZGVlg6E4mQpKjfDhcf
	 DR/bQyuUPLTRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62242C4333B;
	Sat, 27 Jul 2024 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-07-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172204443139.25098.7120882781032086210.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jul 2024 01:40:31 +0000
References: <20240726150502.3300832-1-luiz.dentz@gmail.com>
In-Reply-To: <20240726150502.3300832-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jul 2024 11:05:02 -0400 you wrote:
> The following changes since commit 225990c487c1023e7b3aa89beb6a68011fbc0461:
> 
>   net: phy: realtek: add support for RTL8366S Gigabit PHY (2024-07-26 14:29:06 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-07-26
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-07-26
    https://git.kernel.org/netdev/net/c/301927d2d2eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



