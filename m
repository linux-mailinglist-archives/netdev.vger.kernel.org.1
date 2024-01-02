Return-Path: <netdev+bounces-60914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95E821D89
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C500B20BD3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD6107A9;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCXYiAm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA41095C
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BC9FC433C7;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205225;
	bh=bMND71j7RFfLWvIUSP/qAp1o9tq1QYOO/jPvdRrcLBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCXYiAm5tx4u5LKKN4y2JIBdI++X0+4qQfKmrkWsZU//pJp9fp0LyVVBNAHVBXb9F
	 SWYWePiz5PKHDZ4ORE50ue8Y4H76cL6vY6kpVHcPlLBr38tMtdJPM7O8/H7lUC3tNl
	 VU1C2VXvrZb+7d/SzgTIHJxW6sHzALsa3op+V0d5TwIwR9FppPF6uZPT+yreDt4HgU
	 Cg08QNCuLj28Q5hubC5eis3IO8x3NwUBU9wl3maTa0l2XMyAZxYgwhC7geIeUAetPB
	 bHeNRb1KKK1K+iF9nDrGgjulVPXv9DmkKO/WCPvQ2kNhAghYe3/ZcMNf1ZuebelRTl
	 lxiqye+U3jsNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6418BC395C5;
	Tue,  2 Jan 2024 14:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: do not set port down when adding to
 bond
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420522540.14312.12858059741624146846.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 14:20:25 +0000
References: <20231223125922.3280841-1-liuhangbin@gmail.com>
In-Reply-To: <20231223125922.3280841-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, bpoirier@nvidia.com, jay.vosburgh@canonical.com,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 23 Dec 2023 20:59:22 +0800 you wrote:
> Similar to commit be809424659c ("selftests: bonding: do not set port down
> before adding to bond"). The bond-arp-interval-causes-panic test failed
> after commit a4abfa627c38 ("net: rtnetlink: Enslave device before bringing
> it up") as the kernel will set the port down _after_ adding to bond if setting
> port down specifically.
> 
> Fix it by removing the link down operation when adding to bond.
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: do not set port down when adding to bond
    https://git.kernel.org/netdev/net/c/61fa2493ca76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



