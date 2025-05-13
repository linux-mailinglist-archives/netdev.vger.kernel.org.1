Return-Path: <netdev+bounces-189955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79DFAB496C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FA57AB861
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5391A0BE1;
	Tue, 13 May 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glIicaYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF501E485;
	Tue, 13 May 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102799; cv=none; b=Y1+rd5VvcZJudaSvDks43lCyAj4xp87ZdRSGi2A3fWtl5PB62GAjdNrvoUG3EQKZ34tJXznUMn6pTSXz2xGRPO3ZRb5oo686DztzwVETJOJouisGP2zRKlJsjlATXtibo9mC0VeGUTrOILi6DY+lS0c/LJUj4RXSihwMQhduzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102799; c=relaxed/simple;
	bh=9xgTcf12oF78veCiay/vGsmLyUzDOipPP2Ia5mQWu4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ofsq3CK9VTmWtAAFmJIKLmBmrV2nQSbGuMhfWG2BRlF6D+ZnjGabpzBSEcTBDJKk1aOw7az6irtEqZ2VTgxBTuoko7sdFdywi2z8vGoQ5euCowFUZmJeSnHU0L+OOp8+y95oU7kVf4ue2O6zUtBoKoXGkPA0IO/n7gpQFQu+mqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glIicaYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F821C4CEE7;
	Tue, 13 May 2025 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102798;
	bh=9xgTcf12oF78veCiay/vGsmLyUzDOipPP2Ia5mQWu4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glIicaYYmKBPqwkoBfTOeMq6F6d+yxJiOjwi/WNfxuaOa2b4MZ+dXZrrKMjJczvrj
	 XwKw+g2H8oEKHVe5q7HO50NyS7pvuLlLTqnKqEP6ZK/MQ9bpJXYlHDI1TjMZzA9q8Z
	 nnr8PCvwrDJ9TgiXXY2zprvhLXopZGDZp13kcgxVxJA2fRHLGTQIA85I02xK00M414
	 tI4ZkdlhhBvOBlell7TOPKQxAFswP+h/8jwPBJtPg6iwlaRpd4KwAn0AKnZWTaQpI7
	 taxPrNwUGxlVMK+IDoNq2G2eRFb4++fShCq971bLl3i9APc7Fiai7UVVe7naOetANC
	 VyK3ggBzNP9fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A7F39D6541;
	Tue, 13 May 2025 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: b53: implement setting ageing time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710283601.1148099.15415155421490231622.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:20:36 +0000
References: <20250510092211.276541-1-jonas.gorski@gmail.com>
In-Reply-To: <20250510092211.276541-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 May 2025 11:22:11 +0200 you wrote:
> b53 supported switches support configuring ageing time between 1 and
> 1,048,575 seconds, so add an appropriate setter.
> 
> This allows b53 to pass the FDB learning test for both vlan aware and
> vlan unaware bridges.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: b53: implement setting ageing time
    https://git.kernel.org/netdev/net-next/c/e39d14a760c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



