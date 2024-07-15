Return-Path: <netdev+bounces-111549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC4931831
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405A91C21202
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4362AF1A;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGTi4ajm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2817BB7;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059830; cv=none; b=U3S8Wq9USRBteU4d3hMlSnYUnj93qOsbJ0OCrDxnf/ERxxUM46AAVNyIKeU33TZm5eAO1pjQil5jn9GKb9cowy3Yc/aC+G+D8Y6GCFaLNaw9SZadllNWd/UXzXGs/Q3BHL1l/AmyH0emzs3HO3LfyALQwmsOJZz9AC6h7Bl87t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059830; c=relaxed/simple;
	bh=64a8ORXuX1kJfQgq6DJvoO6pwPh4aU+hZ8LkAgCd5dI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nzf/rG8vmyGugGtqqYpud57MabEIEl5J2k2CJV7/WmQ2eICUa3DfLL+1GBm1Yaaf6gAVm5NTWgr8cFojggp7zRq3DjtEbDwoAiJGW70n3Iud+EIeWatWGOac8ggGG+iBPKZP0KwL8vRyHQtg/7y1ZiFC9nPMEsVpoTOx2VmMl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGTi4ajm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E772EC4AF10;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059830;
	bh=64a8ORXuX1kJfQgq6DJvoO6pwPh4aU+hZ8LkAgCd5dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGTi4ajmTobmKapMutzX2QPGO6gQbWyKDWWT8Wza8PsuUI0GeHCmsVnu1d+JJgliD
	 gO0eEUHP5aAOZYtCa/M/W0XGrWYmEsNEhkje1mjS5mnkYQm3IP8k0Sq7HaZOZddRh1
	 aIbSQT4PeUlxDPI9MREItpNxbyXVtZVhBkGE5VUs/urEfEe3DNHpqd5hENvF4OXnk1
	 0uvKOGdq4QtozoYGkn3ajyWzCIUu4Myo8T7FYm23k0JIJryzDad9SQMqMumxIOc2H/
	 psvPjRiJElZml8m3MTYeI2Uqr+kPE6et7Xbwq4gf7xrnyt/bSBVCHdl6flqEaxCJxf
	 sp2ZoyiB/ItMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDD2FC4332E;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dsa: lan9303: consistent naming for PHY address
 parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105982983.6134.1611053719217544657.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 16:10:29 +0000
References: <20240715123050.21202-1-ceggers@arri.de>
In-Reply-To: <20240715123050.21202-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jbe@pengutronix.de, sr@denx.de, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jul 2024 14:30:50 +0200 you wrote:
> Name it 'addr' instead of 'port' or 'phy'.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  drivers/net/dsa/lan9303_mdio.c | 8 ++++----
>  include/linux/dsa/lan9303.h    | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] dsa: lan9303: consistent naming for PHY address parameter
    https://git.kernel.org/netdev/net-next/c/f96eb1172ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



