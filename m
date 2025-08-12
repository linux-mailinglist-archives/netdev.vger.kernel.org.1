Return-Path: <netdev+bounces-212890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02995B226EC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16964188C8E7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7B1A9F91;
	Tue, 12 Aug 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2rBB2ES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9C1A0BFA;
	Tue, 12 Aug 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001902; cv=none; b=ZFTI7QYDeW9xHHYmORrLGZCrQS9lHVSntewXEvEg2QCz6gt3UZonIYmUoKgqcBvNEUIz62RlbfN0URHiRUOOC4QdjhYnO6iVlbYGDTUZ2yrlE0ghhrEX03vdF7NB6c0BnlTTECmO/1XCcZKrQshiIXXQv0k+Ltqu3BUcB5iFmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001902; c=relaxed/simple;
	bh=yiBrKuWba6VUZfup9ZeV9421SjABVfIj51lBHmdRJW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vw5WBOLljLsyYxho+1JfmoHb2SxgquyaR49n9TWdPhaSNEnoCOcucEgHnTNqGNLHrOiAdNVOksa3kGjsVrzN6OHO2dqzaqz+mt9dyQZM48KcRBrzqrgCd3vtI2eZhEv/hxQV0Woag1iHJxHIRt+UguCKbkad/iTIHBHR5ZNP6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2rBB2ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA4C4CEF7;
	Tue, 12 Aug 2025 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001901;
	bh=yiBrKuWba6VUZfup9ZeV9421SjABVfIj51lBHmdRJW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2rBB2ESl52QtL7zEsFOolPtdPxh9p17mcwsc3P3pYlYohJZSXwct9V2df3myjbxQ
	 JEKrjnTHtYOY/EgxPl83sUto2F4SqU7E6GCE8YTR3SRsyop6ysCTzCvwvpHBBe/wMq
	 xIRKexZQX+kGkDevzIOHh5wK0RlRgbN7sHqttPaZi9T+3JiXw0GeadquLd2B8ids6Y
	 jDPg72Q3KPSd4H6wu0+NEKhh9DVnDllt/J5VFxwuCIsxv3GIJYWAx7dLEvhLS9lEmh
	 1w/nbm5HGn7xDNlDRn5IO24dRwOtXE2wav3L7ojvmpZPI/g3Wo8qM7D7Z+i5map/7U
	 DOP2NA8DW443A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8B383BF51;
	Tue, 12 Aug 2025 12:31:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] Fix broken link with TH1520 GMAC when
 linkspeed
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175500191323.2536290.8876313312572303826.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 12:31:53 +0000
References: <20250808093655.48074-2-ziyao@disroot.org>
In-Reply-To: <20250808093655.48074-2-ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>
Cc: fustini@kernel.org, guoren@kernel.org, wefu@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, emil.renner.berthing@canonical.com,
 jszhang@kernel.org, linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 Aug 2025 09:36:53 +0000 you wrote:
> It's noted that on TH1520 SoC, the GMAC's link becomes broken after
> the link speed is changed (for example, running ethtool -s eth0 speed
> 100 on the peer when negotiated to 1Gbps), but the GMAC could function
> normally if the speed is brought back to the initial.
> 
> Just like many other SoCs utilizing STMMAC IP, we need to adjust the TX
> clock supplying TH1520's GMAC through some SoC-specific glue registers
> when linkspeed changes. But it's found that after the full kernel
> startup, reading from them results in garbage and writing to them makes
> no effect, which is the cause of broken link.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
    https://git.kernel.org/netdev/net/c/c8a9a619c072
  - [net,v3,2/3] net: stmmac: thead: Get and enable APB clock on initialization
    https://git.kernel.org/netdev/net/c/4cc339ce482b
  - [net,v3,3/3] riscv: dts: thead: Add APB clocks for TH1520 GMACs
    https://git.kernel.org/netdev/net/c/a7f75e2883c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



