Return-Path: <netdev+bounces-50032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6197F45D5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04ADD280EAB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD64AF7F;
	Wed, 22 Nov 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imGjrmTj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E84AF61
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4641C433CB;
	Wed, 22 Nov 2023 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700655625;
	bh=+qGKi7yoLgD3Amn7/E17WsjpjAvJxo+YUlSs/0AMxvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=imGjrmTjiid+HaMBZyiZjZMA9j+pT4Pb+ByelzEEwK9gL6lPjrlE4iSZCUatffoQ7
	 D0agCc0D+DZuElQSSh5RgdGvQwVqkYclUmjkZxyXMrBwPqf+oelLNlVgNZjWJcQ6a5
	 Yf7lZ+7yYecVpY5EkZWzy+vSikAAE0QZV9Wmu7DCUHWP9fl85dj/seP6U6CgbhKOe/
	 a83j/A9W2HxR8FDbeP9+M6ivjHU3cM8JqAhqU9EY17tZKnNoYVlHfnCl8B+GX59/0c
	 pCbGBXk942oVQbz68QfI0T0HBMevLsYJdFuzczARvMZ2K90z8Q89c/6maQDhtVdOiV
	 NhLJhLrnMTngw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD00BEAA95A;
	Wed, 22 Nov 2023 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] Revert "net: r8169: Disable multicast filter for
 RTL8168H and RTL8107E"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170065562577.16844.5218103100995614665.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 12:20:25 +0000
References: <373ee2fc-e78f-48e6-826e-e8de464848b7@gmail.com>
In-Reply-To: <373ee2fc-e78f-48e6-826e-e8de464848b7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, nic_swsd@realtek.com, ptf@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 09:09:33 +0100 you wrote:
> This reverts commit efa5f1311c4998e9e6317c52bc5ee93b3a0f36df.
> 
> I couldn't reproduce the reported issue. What I did, based on a pcap
> packet log provided by the reporter:
> - Used same chip version (RTL8168h)
> - Set MAC address to the one used on the reporters system
> - Replayed the EAPOL unicast packet that, according to the reporter,
>   was filtered out by the mc filter.
> The packet was properly received.
> 
> [...]

Here is the summary with links:
  - [RESEND,net] Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"
    https://git.kernel.org/netdev/net/c/6a26310273c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



