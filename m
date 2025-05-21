Return-Path: <netdev+bounces-192103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73AABE8E3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5E44A1D9A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977814F117;
	Wed, 21 May 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4l9DWC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F52EB10
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790412; cv=none; b=MfRlYjmuBt/JBYPvtonOe4rT66B15NPtcm+exEwDNYcXN5eMHmDluhK0IGU/skXwJObmqAea0L4VPRZOulDDwkyDEDpqaOw7ljKzMfmJHWQSfRRYxdQZCOn5k9I+z4d0czSNu5sAj9lCol9S0wIgj2iQKrCxPjHDRBfT8wTjpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790412; c=relaxed/simple;
	bh=G6Jo8CpgTO7kgmLUFyNGUyOjiNJQ6cYPpGYmS7v5aj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ongHq67nPnsWMmI9n/3VuzD8vuHG7Tgg83z0CKvkTtEZT0Svk0L+1ceJQZv1qDlNLc0Q8/0aoppQzpfuwXUwnhPwhFqj2FkADb0xH5zGiGMiCGYLbe899tZMY4pZhwrM+G+dMA8F0idCczOoYbQFCeyOxfeGvufAaHreDb9I4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4l9DWC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD6BC4CEE9;
	Wed, 21 May 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790411;
	bh=G6Jo8CpgTO7kgmLUFyNGUyOjiNJQ6cYPpGYmS7v5aj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4l9DWC69XAsAp1pifFL0LJgt/CCy88kZ+JoE1h+a8fJKRE0TpSiA5B+ScrDucQgr
	 1lEv6J6yNsNBy9zoRtv+SHq+aY8p8WvlVzn9c8Ke2wyGZKkC/8TZ4Mpt5cODUxl63J
	 HPSMiz92TSX0w1OkLORRqJYLh2o9TFTVc+DVncs0CaNtYCJcU1rsoLLr53Qt/qzPvY
	 z9lAnOZlqFAbHXUqaKJIrro0SPni/58OEZx0QLp238+CGYwHqEQu6qBs+ZNPDVGtZW
	 TmJkVQQXk/4iMrImNX/Doa88lLRhHNiqYvnngpE82DQX3kIvVcvORNAYURzqNy+aqu
	 0maE/eYtouQVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA8380AAD0;
	Wed, 21 May 2025 01:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: realtek: add RTL8127-internal PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779044775.1526198.4639456892989835592.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:47 +0000
References: <20250516055622.3772-1-hau@realtek.com>
In-Reply-To: <20250516055622.3772-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 13:56:22 +0800 you wrote:
> RTL8127-internal PHY is RTL8261C which is a integrated 10Gbps PHY with ID
> 0x001cc890. It follows the code path of RTL8125/RTL8126 internal NBase-T
> PHY.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: realtek: add RTL8127-internal PHY
    https://git.kernel.org/netdev/net-next/c/83d962316128

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



