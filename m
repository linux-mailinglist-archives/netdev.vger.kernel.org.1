Return-Path: <netdev+bounces-106475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E249168B9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F62873AA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180D15958D;
	Tue, 25 Jun 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy/l4S0T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F81509A2;
	Tue, 25 Jun 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321633; cv=none; b=CrUAj2RvyreDIAXg5MmTO29+OyEOEs6BCBIKSMjL+5kk982xD1+YO0YmGP1JB+LHd0EaG8+UXr4wu7qdp5/Qnz7buGjGjJu4OWc3zyGJA2gH9C2NjiC73jLK8AT8zs2UCxV3bIj+bsFAfzQ9XnNK9KPxDAqtgn8LkoIqU7+txIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321633; c=relaxed/simple;
	bh=lm82NzHKj3ogzCFlAYig1KlHeN90lp9YPBRS5Gn15Yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MmNg4I8z0UIrE/xmCK1F7CMHGEFJytdtq6uD81c1+YcuyfGScXnrSHc77Vbc5UgEbg5UpcCCXfbaPqJobZWiSds7pcYC2nP6nHMGWUzFnRBZ/hbx5QexpyqUGM7QfQofKXTFat6MGYky1OH+nseUK6Eqo6OyxpgG1F19MPqE9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy/l4S0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99ADFC32781;
	Tue, 25 Jun 2024 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719321630;
	bh=lm82NzHKj3ogzCFlAYig1KlHeN90lp9YPBRS5Gn15Yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iy/l4S0T/nszIY7+xhr+QPdRGkb7DsX0/VOM99H3XD604Y2bevU+BTEKwmdr9MYZE
	 TfnZKXCNaKvcrwDIjQE0z8amtENn9z4TyUAEmBvAx+k+Sfnik0IaXw4hdid3sk2/QN
	 mk5roP6h1uTmlhsKCsRKhYPHZpcHavVqJ8ScFfFzENfY7/0APMSDkpslU0kRsVlY2D
	 92hzXixq4lEBUNDfJXEq7pp5uF7iE27/NPvdsJcns+39yZ7q6pm9qxaJG7WsK9EvXO
	 Js3IIc6ikGdpJ03qUq7aDRXkshjF2cS2L1X/rNW2QZxd4hkYphkJzSBPT1bGPy6WkC
	 I+nIu5CciHkjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84537C54BD4;
	Tue, 25 Jun 2024 13:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: dsa: microchip: fix wrong register write when
 masking interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171932163053.13562.2140291314472324198.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 13:20:30 +0000
References: <1719009262-2948-1-git-send-email-Tristram.Ha@microchip.com>
In-Reply-To: <1719009262-2948-1-git-send-email-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: arun.ramadoss@microchip.com, woojung.huh@microchip.com, andrew@lunn.ch,
 vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jun 2024 15:34:22 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The switch global port interrupt mask, REG_SW_PORT_INT_MASK__4, is
> defined as 0x001C in ksz9477_reg.h.  The designers used 32-bit value in
> anticipation for increase of port count in future product but currently
> the maximum port count is 7 and the effective value is 0x7F in register
> 0x001F.  Each port has its own interrupt mask and is defined as 0x#01F.
> It uses only 4 bits for different interrupts.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: dsa: microchip: fix wrong register write when masking interrupt
    https://git.kernel.org/netdev/net/c/b1c4b4d45263

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



