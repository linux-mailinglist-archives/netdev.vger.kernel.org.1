Return-Path: <netdev+bounces-60333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241A81EA52
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90D91C2141E
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F954C7B;
	Tue, 26 Dec 2023 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8n0i2+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9D5394;
	Tue, 26 Dec 2023 22:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1440BC433CA;
	Tue, 26 Dec 2023 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703629824;
	bh=/UrFcx2H6xW+734Na6AtQpA3wjA4GVnk1sApv5tcg9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8n0i2+Nge/7XLe7owFJZKDVg/GLOS+kMc8il/F5WHbYrIMtMPm6PgWYlVwfxvup6
	 NQzUU9o3TpTFpd+atyg3uxzQ6YYEEk8ysU5Pvk5WgpmimggINB56CF06Knwg3QdF4B
	 PEV2vyLtiqOvaz7O6NXxpGfaU0R1z4yzGkKXQ+Sn9Fsv4PrEhtLGjvscjP1kMAQQXy
	 y8VOJ65qidsWPTaTdG/5DQdTRA7SOdBFFSgFWhDAlzkttEv3rkyikIPjArHWpZpN9A
	 RBLxjV0Sh0wvvGZUQzer102mKiCD4ggC7pAK4N1shgbvxQbo3uzCNohIHDH7nImHJi
	 cxV2uLSh+hXkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F095EC4314C;
	Tue, 26 Dec 2023 22:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] net: phy: at803x: better align function varibles
 to open parenthesis
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170362982398.4296.10324756769545396593.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 22:30:23 +0000
References: <20231219202124.30013-1-ansuelsmth@gmail.com>
In-Reply-To: <20231219202124.30013-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 21:21:24 +0100 you wrote:
> Better align function variables to open parenthesis as suggested by
> checkpatch script for qca808x function to make code cleaner.
> 
> For cable_test_get_status function some additional rework was needed to
> handle too long functions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: at803x: better align function varibles to open parenthesis
    https://git.kernel.org/netdev/net-next/c/7961ef1fa10e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



