Return-Path: <netdev+bounces-64452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47BE8332DC
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 06:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF6B2308D
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA915CF;
	Sat, 20 Jan 2024 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAgF4q/0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4A1856
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705729232; cv=none; b=p9512C8QufBrkbW9fyiuGn/GmLFmpnlenGGHWFPDZ/31nzNOqVoCIs7oL4Gk6Yg+kN2+Mo/uXd9//Ai9cA9ez1xe+JgcQbjiRNQoHBTku0ZNob5fWOxlOpuTJSju/4f3SAYBBOtAZlJJIbXVRvH7FROjioEXz0xabs2X2IiEPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705729232; c=relaxed/simple;
	bh=RSJYmt7nODLkFyawkY4kKx4NkgKdl4OoKs16jp7GOJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CVIL3HwV14AksUb+28/JbKx2Xc1BwiRnu7TyrMr6kKbhJ0WP++hP2K8D//VKzZgAOO2spPeIa6GXhVQ3rUAxaLJjuAEiQMF3XkvoSJxJQErnCeZoRqR+wWeopcJKEkpHtk3woJnUJivWLyt5sXj/Vbty3fCA02YgzjqX7QtCtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAgF4q/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78150C43390;
	Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705729231;
	bh=RSJYmt7nODLkFyawkY4kKx4NkgKdl4OoKs16jp7GOJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LAgF4q/0vBmulO3FXpPFwIJ5ZarGsZZs5OwUenW8M7epklwyoWlwpJ6/LfFjr9J8r
	 xTv+yjKow8o2FlEN4K28ALI25Y+9SVAO8Mg0+avO4zchvJLwPD0xRpUHjyi7LXhvSo
	 Zfdlrc1bNp7rVHa11SSRWPbWyEG111IwLP858GzI2Cm1kUlpy4HLhz5uUbN6uPUuXr
	 posiUfTCpD9GNOQaXNQxBmkTgh6IvcT2oQg1DthilPyjZ1qgI/9WLEVcVx5dTo34eO
	 H6zI6JlBzf/P2EO88cK9Q7wDypTSMJ7KGSFaMHwmBQl/K6W4CSj94N9m8wq5B6BwsX
	 Zb2zScAnrI4Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61470D8C96C;
	Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] llc: Drop support for ETH_P_TR_802_2.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170572923139.12405.8069848446400899925.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 05:40:31 +0000
References: <20240119015515.61898-1-kuniyu@amazon.com>
In-Reply-To: <20240119015515.61898-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, paul.gortmaker@windriver.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jan 2024 17:55:15 -0800 you wrote:
> syzbot reported an uninit-value bug below. [0]
> 
> llc supports ETH_P_802_2 (0x0004) and used to support ETH_P_TR_802_2
> (0x0011), and syzbot abused the latter to trigger the bug.
> 
>   write$tun(r0, &(0x7f0000000040)={@val={0x0, 0x11}, @val, @mpls={[], @llc={@snap={0xaa, 0x1, ')', "90e5dd"}}}}, 0x16)
> 
> [...]

Here is the summary with links:
  - [v2,net] llc: Drop support for ETH_P_TR_802_2.
    https://git.kernel.org/netdev/net/c/e3f9bed9bee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



