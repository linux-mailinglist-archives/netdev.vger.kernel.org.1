Return-Path: <netdev+bounces-128277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7C978D0B
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD241C22E20
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033A745F4;
	Sat, 14 Sep 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLVi19b2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A516F066;
	Sat, 14 Sep 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283440; cv=none; b=UKNX8Y+8klERmNihnsUr/V9Op+vZtssdsB7iS7VS7558OahPR67tanL4c2vpbZfDYssCwj6APDisvoNvx34w6kTNHndCSsFdTHjyUKAeoRx3sNckowV0mxUMrn1d2+CEuKMJHjjnbVZLV3/NcjzUgX2YjGD7GjZFn7evzellIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283440; c=relaxed/simple;
	bh=Fe/jkW7vM2O7n8FUgTQvbPGVFaUtObCOxrHuCrGlJV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oZ9WQlPw/cRwycq6vTdlCgovnQQUnHiN//Ro5gTwf/7fdf/eZGIpETlBF8Az9ArbFMXVFxOZ0WOQZ/RRdMLrD9ByRBDU6YDsKWdoiY6W4kpcBXwYBw415CIYeh6kcwEnmN8eHMkCki+GIdMSXmfqrSKeCYsB41wRibAZY3Svjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLVi19b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ECEC4CECD;
	Sat, 14 Sep 2024 03:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283440;
	bh=Fe/jkW7vM2O7n8FUgTQvbPGVFaUtObCOxrHuCrGlJV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cLVi19b2IBwkiMWAlv7vAZGZDlC56M5zw7YAQHYGRbrBuqofhWBxSZRUwuTGElXK0
	 QDQyPype8pmravnpG35r2+KysX1Tg1jyi7Y0Jey/r0alQ3PaIjPuvG9h2SSB6tk3gi
	 DXJik0o/otRSdOyhdDrpvKYgavpd+6SahDIALq/vWd2V9xPUzQCC91HAjWzRT20BDq
	 hpGJjH+FqTRvM6eNm8j7DOuvxnsjpjYFy3Gvk/dA/FOOmoXh4bi9AMW5a+KQAXAvFz
	 /hycZcFGH8GBl9hviHI3miOO95qLC3lIuB0866cJy/abovZ4xBHcX8wA+Kuh7MKYce
	 DsIAErkV3iKDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340EE3806655;
	Sat, 14 Sep 2024 03:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Documentation: networking: Fix missing PSE
 documentation and grammar issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628344200.2438539.2596888301581438974.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:42 +0000
References: <20240912090550.743174-1-kory.maincent@bootlin.com>
In-Reply-To: <20240912090550.743174-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, o.rempel@pengutronix.de,
 horms@kernel.org, thomas.petazzoni@bootlin.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 11:05:50 +0200 you wrote:
> Fix a missing end of phrase in the documentation. It describes the
> ETHTOOL_A_C33_PSE_ACTUAL_PW attribute, which was not fully explained.
> 
> Also, fix grammar issues by using simple present tense instead of
> present continuous.
> 
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Documentation: networking: Fix missing PSE documentation and grammar issues
    https://git.kernel.org/netdev/net-next/c/9297886f9fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



