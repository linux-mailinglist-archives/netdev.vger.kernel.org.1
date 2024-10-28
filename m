Return-Path: <netdev+bounces-139712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A588F9B3E43
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B111C22298
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F86200BA5;
	Mon, 28 Oct 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZmwo9uT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB78200B88;
	Mon, 28 Oct 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156433; cv=none; b=h07dzHE1j2itNjoegPWPhB7/nvr4fiy9JKYPhJAyaruZW7qhEyPEn4q43bNmKKGsKpgbSt94tjWHelEKv/SEv/4HE7m/ajLHKN/q07JKoOyD7/tYC7A3OfJWSlm5d1ekevXHmWu7d/FvpuzMukehx0Hifs4CyfGMOkJBr8kxP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156433; c=relaxed/simple;
	bh=GmaFwd1bU7p8CTe5kTFK1oVgCOqvgOs0dkvkJP3wm7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U72XbYMgLRT3hjwrXfvRn5Jq/vYvDLihHv12rV3Nx1t1P9eAhXDJrhUY7D0xtj7m1JPUOhZRFPRApFDDnTP9lp2ExoF0JqT8gfnNXwwlRVLsulYx4b7kTw3cwnWCN+XRgj2TDj9j5JyAvezWzdR4ciLKQCmtjgMO6gXnTMM2Fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZmwo9uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A41BC4CEC3;
	Mon, 28 Oct 2024 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156433;
	bh=GmaFwd1bU7p8CTe5kTFK1oVgCOqvgOs0dkvkJP3wm7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tZmwo9uTYDHZjvLdQIfSbjFepLeWsO3+Dy831Op1/NHM+85HMRAJyjomcdqVPmk3l
	 L2ANn0RQCav2TAkskjS6IfelxZ0nwsnZcQRtEB1yz9fKFXf8su52txaOgYZACFGyFR
	 wvG9f10ADDhf3PHNitcPVckWPoUARo0LoMWifeNUPIMmF6BcL+QjWAjCwvlaq8fT3v
	 EWN/lh2q2nAEQORtmLZpI2HrhZk0eP0plWIFGfBE7Gg9CYoZ5LnKDftK6Wq+A6ZrQf
	 Bw1JheFu7IPGGQUWjr6DZgocdwyqEpJrdelcVBuGs1ApuJDGLh7IzNR7nXFIOlfu+O
	 hQdMAkvGwzUxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C1380AC1C;
	Mon, 28 Oct 2024 23:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: various small improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015644054.206744.1312496729926430347.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:40 +0000
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
In-Reply-To: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yangang@kylinos.cn,
 dcaratti@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 17:14:02 +0200 you wrote:
> The following patches are not related to each other.
> 
> - Patch 1: Avoid sending advertisements on stale subflows, reducing
>   risks on loosing them.
> 
> - Patch 2: Annotate data-races around subflow->fully_established, using
>   READ/WRITE_ONCE().
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: pm: send ACK on non-stale subflows
    https://git.kernel.org/netdev/net-next/c/a42f3076648e
  - [net-next,2/4] mptcp: annotate data-races around subflow->fully_established
    https://git.kernel.org/netdev/net-next/c/581c8cbfa934
  - [net-next,3/4] mptcp: implement mptcp_pm_connection_closed
    https://git.kernel.org/netdev/net-next/c/5add80bfdc46
  - [net-next,4/4] mptcp: use "middlebox interference" RST when no DSS
    https://git.kernel.org/netdev/net-next/c/46a3282b87b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



