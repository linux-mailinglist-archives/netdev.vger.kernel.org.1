Return-Path: <netdev+bounces-208750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D143CB0CF2C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D8A172AA0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F7B1A3A8A;
	Tue, 22 Jul 2025 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmLOp6+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4F2E370E
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148400; cv=none; b=kWtV5Iz0NKXDPXvV7pyWrSFZOPacPb+q+jiZSZ0mO1BrRVjkz6hbycknSKFnYtHHZLfTQ0YjdNjl/BcoXh70Xo+pP0w+3G0iuj8zaF4d+XkX/O/l7R02pWDmujCKlIRlk5SuJ9utsaUyU6cxjmOZw0d0EhhmjvRW4xto5EBMDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148400; c=relaxed/simple;
	bh=u+Icubsd7Ub1Mh2tVHBNRGVP+xcHzT/4pq4xLIFNuLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kep9itQZASsFu/tLFwKnpZqsL2Fyps+joMVb1BOol62A8mb6Ya5tWv3I6veptk0VTa3Iq+xvRTdK5H3L+vZb/Y27Dtqs7zHzQPw2lC3iSiQYgC+V2EqqIb/KND3HmYL8whMjXFa6eOhCQXQsDA82bsJGo0Nv2N/aaoBTmCkqBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmLOp6+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A51C4CEED;
	Tue, 22 Jul 2025 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148399;
	bh=u+Icubsd7Ub1Mh2tVHBNRGVP+xcHzT/4pq4xLIFNuLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tmLOp6+vRefi6ZslqER6dWtbYnc57hmzu0Rk0xkcHVb+BPD1s+RWLKs89TvsGxpUP
	 jjVRTJMFz5eGxhlfeAS66kFeLZO15mQqiCHnHr0QYxIiNTc0eS4yByGimQZR7X4nIF
	 Dj4mBNPMMSxr/Cl9/k2FMZ+VOcz/ailMjVJFqocdDvCqhP7jIac7FiXSlxgeZm89q6
	 QgmkJ5phJ/2xcq6VfPQyB4fdzfOi1EOgwaZGTvdmjtNdBgIzONtbSldXfW+ApzHRBF
	 kUvUCprxE6eWMQioRA8AXKbnSbBsTlkg9hypoDRWVFGRiz1jUJI05cI/IRBwXqRd2v
	 c1M35XUj0S2JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD23383B267;
	Tue, 22 Jul 2025 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] ethtool: rss: support creating and removing
 contexts via Netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314841819.257717.8558865688426486771.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 01:40:18 +0000
References: <20250717234343.2328602-1-kuba@kernel.org>
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 gal@nvidia.com, ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 16:43:35 -0700 you wrote:
> This series completes support of RSS configuration via Netlink.
> All functionality supported by the IOCTL is now supported by
> Netlink. Future series (time allowing) will add:
>  - hashing on the flow label, which started this whole thing;
>  - pinning the RSS context to a Netlink socket for auto-cleanup.
> 
> The first patch is a leftover held back from previous series
> to avoid conflicting with Gal's fix.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ethtool: assert that drivers with sym hash are consistent for RSS contexts
    https://git.kernel.org/netdev/net-next/c/80e55735d5a5
  - [net-next,2/8] ethtool: rejig the RSS notification machinery for more types
    https://git.kernel.org/netdev/net-next/c/5f5c59b78e5a
  - [net-next,3/8] ethtool: rss: factor out allocating memory for response
    https://git.kernel.org/netdev/net-next/c/a45f98efa483
  - [net-next,4/8] ethtool: rss: factor out populating response from context
    https://git.kernel.org/netdev/net-next/c/5c090d9eae88
  - [net-next,5/8] ethtool: move ethtool_rxfh_ctx_alloc() to common code
    https://git.kernel.org/netdev/net-next/c/55ef461ce18f
  - [net-next,6/8] ethtool: rss: support creating contexts via Netlink
    https://git.kernel.org/netdev/net-next/c/a166ab7816c5
  - [net-next,7/8] ethtool: rss: support removing contexts via Netlink
    https://git.kernel.org/netdev/net-next/c/fbe09277fa63
  - [net-next,8/8] selftests: drv-net: rss_api: context create and delete tests
    https://git.kernel.org/netdev/net-next/c/4c86c9fdf6a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



