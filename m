Return-Path: <netdev+bounces-43277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98977D22A2
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D101C20A76
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4951C30;
	Sun, 22 Oct 2023 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNb4P44w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E879E3;
	Sun, 22 Oct 2023 10:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 958A4C433C9;
	Sun, 22 Oct 2023 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697970622;
	bh=6xL+0SSS+UK7MN+C6MYW1SWdb1d9d2XhbURiRwzUbTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FNb4P44wXSqQ+8vhVQKlhAidx27Qhq3AvYcBuxBb/mmPjVn39E9T6uTjHk0Cf/aey
	 6wD6mV0LC7a0Nia4D9qYLAyTk5n/ZJrIUlKw1lRfJVLcqaIgHZl6qAOFo6kGT3cC4b
	 Ng3uGlbxLi0T8zzDyd/GOWA/RQPOGXh76RiR1lfnPvTCIepQ1fT4CEKaTL+yXrBcVe
	 F+qWPkvbtXQV8PQMAI5bRCXfmNRT3t9wojoAcloP0os7Xinfuphb4zhwzVrXRMaHVS
	 ONdB9jQDAa5k6fy3VHJALXkhcbqRgA0zItCbeMjQ1cIpgBe2BAWKHF8vpAY3j5jsvB
	 PXbmkda1fr/aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78742C691E1;
	Sun, 22 Oct 2023 10:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer
 overflow in adf7242_stats_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169797062249.27139.6002805362086894264.git-patchwork-notify@kernel.org>
Date: Sun, 22 Oct 2023 10:30:22 +0000
References: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: keescook@chromium.org, michael.hennerich@analog.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, marcel@holtmann.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, stefan@osg.samsung.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Oct 2023 20:03:53 +0200 you wrote:
> strncat() usage in adf7242_debugfs_init() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
> the size of "adf7242-" that is already in the array.
> 
> [...]

Here is the summary with links:
  - [net] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
    https://git.kernel.org/netdev/net/c/ca082f019d8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



