Return-Path: <netdev+bounces-165334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1302A31AA3
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A5E3A7597
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9B481B3;
	Wed, 12 Feb 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXppZOuH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4383594B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320813; cv=none; b=KhDaDilN9Gq6Nz8sEhoLuQdJAR4XvL0PqL5fieEuT7wSUOUpiReXlJJeuCzULisc6L1LB3JHp7Pll0Z3jI3+HJQ8EI3IUSq7Co5tXCtFbbnR2x2x9wikB2swe4Gm4+cWmszd4JEsPUnpenIvUqvk6AeoKfDXLmrYbzR4Vs7bFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320813; c=relaxed/simple;
	bh=3x3R4QYel84mzB3s0t2I4Avb7Lna6MbGp7d5z3QUGKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HR04w2eGCmzaGg17BCinG6VVcKOVh2vtqeICIZR7aghZDkJK30z723ZsNRS737zIn+yxybA7pT6gqITQ4gjUhjElJGT8inm7GRBK9FFRjW3wpO1iKC4inpvGXPe7WIQsvh2WehXyVPEcjkgNzLaFK8qMXYRcpfRS3NJnLhID7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXppZOuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B285C4CEE6;
	Wed, 12 Feb 2025 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320813;
	bh=3x3R4QYel84mzB3s0t2I4Avb7Lna6MbGp7d5z3QUGKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hXppZOuHkxMSztLH8OOi9LxEPSaddhguzqRp1g7ldYe98zdxvS4joklABiaZTIWX2
	 0XBQ72pvvSCm32ToKcY3V52e53Q3/0aDBZBwZfZk8IUXbQU9gYl6nZvZCDJqSNzx8U
	 e6CKmnbUcokaY+dKjAyvYP9S4b1u7IMEkQSo07CA1AcvL4mGPyTo/7bGFvz21ZBlyE
	 prUuXhiljUY3c3IizQbyd4qgmBauS+Mi5qS0oAaNy/dfSfqKPopCNqmyHZoRUcXgvF
	 EA+KoGvkpC0OkNqZGjO6v4JQCv8qh46eakGNNYxWe9acCr6sH6iltOvGReSmPqjfJF
	 xIViZOTpee0tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC3380AA7A;
	Wed, 12 Feb 2025 00:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT and
 PHY_FORCE_TIMEOUT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932084200.51333.5580928222536528355.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:42 +0000
References: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
In-Reply-To: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 9 Feb 2025 13:12:44 +0100 you wrote:
> Both definitions are unused. Last users have been removed with:
> 
> f3ba9d490d6e ("net: s6gmac: remove driver")
> 2bd229df5e2e ("net: phy: remove state PHY_FORCING")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: remove unused PHY_INIT_TIMEOUT and PHY_FORCE_TIMEOUT
    https://git.kernel.org/netdev/net-next/c/16d11fdaeb22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



