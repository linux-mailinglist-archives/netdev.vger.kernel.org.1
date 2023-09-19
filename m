Return-Path: <netdev+bounces-34973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5F7A642B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715E51C20ADA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F75A37CB5;
	Tue, 19 Sep 2023 13:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF837CAD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 055D6C433C8;
	Tue, 19 Sep 2023 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695128424;
	bh=io+ftfpQvg06fIDKmyqURafsvt5q7qt204CiUaXIDaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZm79v6gA5CJtbgpugwqz0ydh+DJNDJpnOXlqkdiWm+2Rp6/KYzdF37Ny2zZCDqYG
	 FSA5wWotjEFujCSmdYciisiWR3J/h/F5VxVHMwgtzlJY5Ve82yF0U0CP3xpAStaxGl
	 nQDkp+4h22nger1NbN/Vy64Anapm9/joI2tTsO2qHcFhl2TTOwH22DL8swzop4gG/t
	 0Hfj5Sh2eflYQ1RpxvkZ2XNjcF7rVXRl5XSHvNQsll6k+punGFD0HoPGlDxOUri1bK
	 ZXSlMSi5+BbK31ZR+/stDAZ5geiwiroWt33/JnknJ03pRsmb4Qjjj8wFWkVqadCuwF
	 KYQ4UJYfNpaow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE0A6E11F4A;
	Tue, 19 Sep 2023 13:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: use DEV_STATS_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169512842290.4172.7265017257182697521.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 13:00:22 +0000
References: <20230918091351.1356153-1-edumazet@google.com>
In-Reply-To: <20230918091351.1356153-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 09:13:51 +0000 you wrote:
> syzbot/KCSAN reported data-races in br_handle_frame_finish() [1]
> This function can run from multiple cpus without mutual exclusion.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> Handles updates to dev->stats.tx_dropped while we are at it.
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/44bdb313da57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



