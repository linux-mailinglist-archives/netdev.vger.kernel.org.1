Return-Path: <netdev+bounces-240938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CBC7C469
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 04:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 994CC35658B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FFE13AD26;
	Sat, 22 Nov 2025 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuEAtwyD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D136D50C;
	Sat, 22 Nov 2025 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763781653; cv=none; b=WnQ2gCsQgAztAsetMssDlWpjn2ejJTxkBAtFE2syVMgU/csMmDRVcdluEjISwH37C/r2f0FqP6NeYvzgru21XMkJMC9HRAnUv9elxEKFTZ5RRo2BYHfV+/+o3uFwXglNMF/eXwUsEfetHHpZdfTUl48ETRUfYB1UPh2fFJy9gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763781653; c=relaxed/simple;
	bh=phFGiwlUR+mI5Shvm9dBHClGE8J/SXO1xdNYgW8pXm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KQLDu9JutNV6rgpCP/b/ugqz9Kt/xVc/aBiQ9LKvQ1RdtVOxlMFU2I3ZKIFJPmMI+++p3yh9j2BBk9kbuUOKPLQ+SeL1ss5OMopeCfcF2DT0+bTOd+do7+8ZTc4bvQiEwus/3TmwcsBjn4bETTRn9cDLBTDxGfd18nd9QgRQbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuEAtwyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEA3C4CEF1;
	Sat, 22 Nov 2025 03:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763781652;
	bh=phFGiwlUR+mI5Shvm9dBHClGE8J/SXO1xdNYgW8pXm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KuEAtwyDDNRO45D0DghmGsNoZK8dqE3Mv0TzoToYXvBj336Enqk1uY3DuPZzy4MnI
	 R1mDg1ttOlLOH7M3g2d2nDNYnebjARxy3rDnnqxvWKAlwXT/zOQcdUXxGF5kVuK+7t
	 DHlSkPmDgutcgHDCyQmlGXB+oYBNugxzfLH/+gwVYNnVWi/LlhuAm8IHYGqbSljjCN
	 ZY/x03IE3k9lXql6beHxY83jsv53D3Y0tUOmNiqXkw8P6fCO0pLaPL1UV2dz5OSH6p
	 u8DSF6VqtRgOXnHzAqER1SNFGRNiiD3jLA5CswydNtqc7GudAUVrqlQvhx0Qkqywtj
	 Hkjf5VB+/hxew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C553A78B25;
	Sat, 22 Nov 2025 03:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-11-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176378161725.2671115.16613473308232794984.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 03:20:17 +0000
References: <20251121145332.177015-1-luiz.dentz@gmail.com>
In-Reply-To: <20251121145332.177015-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 09:53:32 -0500 you wrote:
> The following changes since commit 8e621c9a337555c914cf1664605edfaa6f839774:
> 
>   Merge tag 'net-6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-20 08:52:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-11-21
    https://git.kernel.org/netdev/net/c/8a4dfa8fa6b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



