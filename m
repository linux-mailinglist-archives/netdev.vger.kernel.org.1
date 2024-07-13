Return-Path: <netdev+bounces-111302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B046A9307E1
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20171C2186A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEFA16B395;
	Sat, 13 Jul 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijVlBnrK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D616133E;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911031; cv=none; b=rjLnhmcLWJkqEJNwu1s5HZIR1f4XYDu0NzzeSC/mil7Tjk4NbTSjqlELbUK6E18xXKXEmPNxgMyX5ns96P25tMvTs/D298FhzBL3afHEEMQ/ttHVKrfK9EWkw+wjio3zzkvD4HqIwgkN+zFYm5kMN7T5S1LtjevDHlwUAraJw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911031; c=relaxed/simple;
	bh=Sp26K7KbvWIcQM3Bbac4+fi4FVPWvyBhxzNqpYmgA6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P8dzUh73cz9cudJLmwx/aHYXIpsraAlnReO/a6eCXkH/3Cisj+o/v3VJXMlQUoEhSTBbk9WyQtWlfqv57WEQFCNxwKxsFqAw+lAEKn2yc77BjiYNUrMNzHdLF9ll/5PkPGc2G0zMoSMCnkG4u8+UTAUw7XqM1kt7iNF3/uCx9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijVlBnrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04668C4AF0C;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911030;
	bh=Sp26K7KbvWIcQM3Bbac4+fi4FVPWvyBhxzNqpYmgA6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ijVlBnrKYQxHrOrhQyT3A604znag36kND17UaVvIuHwPwcjnAzIL/18koT0mjav5v
	 xKq80w4En4ZrboXbndMIcvRGdCfvb/UGvBLuKB3CX6Y4uLc/W4lYzhk1/ydSkhTOvU
	 /NkV9Z1Ne6KyCEqUOTZ0XQhPiNvnS/ewBPN+hd9AcbiTd/mKlPMrXxKPQ3UgpaKtqX
	 E/BtfCMKUVg2ZyIktNNMKYm/PYbDJIxfhMBlvBQCWGRIU37Y/qcPG+Mix47/ZBOgXz
	 rbccc8gA6GWdb8U1mh88ljufvP18TJRQLSRSxA7ru3WkNpoxgnAYgZrsdfpnlcj5l0
	 LG9whD/nb3ZNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4E44DAE962;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091102993.32137.4734670797558697451.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:50:29 +0000
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
In-Reply-To: <20240711154741.174745-1-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 17:47:43 +0200 you wrote:
> Change the data type of the variable freq in mvpp2_rx_time_coal_set()
> and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
> the data type u32.
> 
> Change the data type of the function parameter clk_hz in
> mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
> and remove the following Coccinelle/coccicheck warning reported by
> do_div.cocci:
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvpp2: Improve data types and use min()
    https://git.kernel.org/netdev/net-next/c/f7023b3d697c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



