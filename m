Return-Path: <netdev+bounces-121981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56DE95F774
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E262847F6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A4198856;
	Mon, 26 Aug 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlmvOmCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B718D64D;
	Mon, 26 Aug 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692226; cv=none; b=JPTUO7Bp/jjZU6a1thAWk39G5VL6qf/OsVjfHaMgwh4ToM/Pv2ThqqatQWhIel48b2mQgTCF82x/KKFytseqePi2hDmzro0OS3uVIC16mJIQn7V5G9ge7CKtm6y+4yHVxs0ENqY1EuYXH1Dq6isSEogKftMaOIRQ1RWm/Y0Le7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692226; c=relaxed/simple;
	bh=gKXHizFV3/H9ZePrIWsdVb0wQb0Nx6WgkqNOlr9L2Cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=goLhVGjmTp5gieyf5nSyfTHtpMaIdAjB78uJTKeXc6NQZ0Cjojj0MV9DZrWIpN4d1XrydBiNiKOPVfhYcvvq27+ejFNHCSZlLp8gU5NsT5NXss5JiUGpNEooW5HNfXZDWSZ6VSHGX9Fta9bHwLhNaR236TLUPSHZh8+b4nz51FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlmvOmCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A35C582AC;
	Mon, 26 Aug 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692226;
	bh=gKXHizFV3/H9ZePrIWsdVb0wQb0Nx6WgkqNOlr9L2Cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FlmvOmCykndCaWXkcOCkIhxYjhcLqokDCotzjOxWX0IaJ0JW/+YnnkpCxVjxqc4eZ
	 kEMeGe0zkI4ukk67um0cBcjuxdEY2XQG6frdWQsgpGmJ0x24e2yXU0l320+In+zllF
	 o9DqbJ/cYY3Eyf0FnYLBSx4yh7FSYmrpIxny+q20oD8idUriCq/iPE6tvKVnmVoXtH
	 TF2XJnkd1YJbGHgJ89Cov735xoJAWrVxEtO3RJEvtfAo1+cOGNqbvG7iVcn1Suwy/3
	 sNeibAagJEIn8nTMFxTrhi715IENDVWsTouQkReBOoDz7qd42/+JL2VXFN+6U4ckAK
	 PpCzQUPHsQoRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD63822D6D;
	Mon, 26 Aug 2024 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ag71xx: move clk_eth out of struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469222601.73019.13431495438642560359.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 17:10:26 +0000
References: <20240822192758.141201-1-rosenp@gmail.com>
In-Reply-To: <20240822192758.141201-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 12:27:52 -0700 you wrote:
> It's only used in one place. It doesn't need to be in the struct.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: ag71xx: move clk_eth out of struct
    https://git.kernel.org/netdev/net-next/c/d2ab3bb890f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



