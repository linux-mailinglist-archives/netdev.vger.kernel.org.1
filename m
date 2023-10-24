Return-Path: <netdev+bounces-43683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319187D4385
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92204B20CF1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416681861;
	Tue, 24 Oct 2023 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ/qdwbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DD185B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86048C433C9;
	Tue, 24 Oct 2023 00:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698105625;
	bh=4oWYcLHkuNEOFMr9LsI3cMKfFRst3F45y1Tf941R8is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YJ/qdwbDh1AokWdntYgGHV6Fl1APrn7e/aaXVecevg1lBzC85lbbC8NwDy8xFm5+z
	 W9iJiRlCyx4X61UpQyQL/K/Qk/DsxL7vpkxYAkz9uzZt7irSkT26DvrSw6hG9BFV0X
	 +l3/bBl+RSqE4N3QWJ39HvCqWS45MKr9o/mTvEgJiyAJDXXViruqu+UGXEPYSIZXtz
	 o4zmB+Q62xYWERIrmioXIZg0ViQc7FsBp81+IXiIJhS7bNxQyGGRxB4/duS+3/jdXt
	 j7CfK3jCl5FlQqVTK0Rn2VfkrmFqg3jLK2Oaca9hkGmrOIJPIDuv2CVNrA8Q2N6a4Q
	 M29kaAGSM0bgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E598E4CC11;
	Tue, 24 Oct 2023 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2023-10-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810562544.27223.14391491254024201624.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 00:00:25 +0000
References: <20231023182119.3629194-1-luiz.dentz@gmail.com>
In-Reply-To: <20231023182119.3629194-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 11:21:19 -0700 you wrote:
> The following changes since commit d6e48462e88fe7efc78b455ecde5b0ca43ec50b7:
> 
>   net: mdio: xgene: Fix unused xgene_mdio_of_match warning for !CONFIG_OF (2023-10-23 10:16:47 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-10-23
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2023-10-23
    https://git.kernel.org/netdev/net-next/c/f4dbc2bb7a54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



