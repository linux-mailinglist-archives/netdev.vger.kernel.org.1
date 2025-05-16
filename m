Return-Path: <netdev+bounces-191214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C631ABA654
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AE5A24A70
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140B28152D;
	Fri, 16 May 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhGF5hOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8C281522;
	Fri, 16 May 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437008; cv=none; b=tQz5qdFA0iKa1pH2kxTIbWfnujR1LUjwUi2YbzlweUZwg+QIGCEXph96vY2jXeGAuTH8/QWg7Y1ZlaBoSbJHK85BihQ+bKePRa/alZvBm2Wv8S//1fj4QpJb96BWkCDQoZbYIlhj4dgZ8MUUpokrtQHCS5iyjz2rEJksMnAnczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437008; c=relaxed/simple;
	bh=n1Ys8fduDTQfh07Uv44a8weNu3dw6dL75vBGO3h3aiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kB7AL7sX/dxWy8ly2R43g6704/qtk+9MFa86NPjWCEppBv4o7+6Wf940MSoNZdWdz911ozwFaR00JTATPyIfQp7eWemAjaPrkjeK5iig+fk/NyUBERJX9QfL0I2mYjLOQ8urrCD9oZrclbCFBO2FwewEe5oDWfT/aoZ82JRjj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhGF5hOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A707C4CEE4;
	Fri, 16 May 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437008;
	bh=n1Ys8fduDTQfh07Uv44a8weNu3dw6dL75vBGO3h3aiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhGF5hOPyqymaVvl/XzTHfBbjAZOWj/gV5SjMn1ZEAw4jBoEcv4bi/tkp58y5AkC5
	 0usQdPuR81YE7M7q4MbZEkudxsXGbdbzPPKPl4p0mk/M98O2saP8+x7YND+Og0+W0W
	 2LC2Up+PFBBZLNY4hsmJFLwT4gpnBKv7+wNCcvWyzxEy+p3kgYp8+tG+NL3dxn+HjB
	 a5NimUPR+gF8ZK6++/CgZq6miuj9HZIBZGH+DzgBjLFVvVSRTSxgqns3m3GXA26+6F
	 uArofe5er3zpApHEnyMroMxMZzmP6lTDBkJG26Q1mEVJmnon8YM6l5oVsABBln+gAn
	 6U5Usa94hTbYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D513806659;
	Fri, 16 May 2025 23:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8127A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743704474.4089123.4668526819376444633.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:44 +0000
References: <20250515095303.3138-1-hau@realtek.com>
In-Reply-To: <20250515095303.3138-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 17:53:03 +0800 you wrote:
> This adds support for 10Gbs chip RTL8127A.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v1 -> v2: update phy parameters
> 
>  drivers/net/ethernet/realtek/r8169.h          |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c     |  29 ++-
>  .../net/ethernet/realtek/r8169_phy_config.c   | 166 ++++++++++++++++++
>  3 files changed, 193 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next,v2] r8169: add support for RTL8127A
    https://git.kernel.org/netdev/net-next/c/f24f7b2f3af9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



