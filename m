Return-Path: <netdev+bounces-235647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7958C33770
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46014189FAC4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A561239562;
	Wed,  5 Nov 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkxkAGnf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBF236A73
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302051; cv=none; b=uoIUAjPLjGY4i1oPa0wjPf4JC4OCyXgIu92nQEtiN+Qz55QyFcZ9uHv8henHbdFxnFS/KawOLWNAv8SrnodcROp+A2AoYdclQ++VjsZjkIq7i4Bpgh9mH7WeMQ+n4aRvDCb6kmOGuBkmMFsz/jPE2TGarut6LKP6bUlf9PI938Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302051; c=relaxed/simple;
	bh=MwWqImqkxBPIwwVgBIdHviCM0HuBw77e6odozmxOf9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=haZmcYqNrbRLpGjwykHFaRWOYBJ1t99Pfbp65b3qhJ6kBat8wTnSY5kVbbXSA05FUpkmWWrvDmWitEhd1MWI0A06sEXy+oLLCDn5zL6sqpKhi3vMUjwKzklh3IpjoKSU69T6nAyE8U4nAnNvpnjmnNat8f0zZbtp/x0GWGLRPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkxkAGnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5FAC4CEF7;
	Wed,  5 Nov 2025 00:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302050;
	bh=MwWqImqkxBPIwwVgBIdHviCM0HuBw77e6odozmxOf9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SkxkAGnfPsEzXfAIUILs0Iul8gI0G/y0rMMrdT5eYlB68jVyNZm0r2L4APlMGoG4d
	 eYNfHTCbkl50SWveG5bGtb8V3e9bUvkK1awyF4lfnUD6ZEIia4UDpNat8HZoduKk6b
	 nCXbCz1NY7LXsq2lmCda3Ft7bz/ypx0wmiKeE5X8PR4UXOSZPpFne+l3oRirslZJyf
	 fJ20FhWV5qtg2Hylojvt7et67FBoHaUpta+NqDCFdxBj11A6rQS73Cp4ER0WZ+ttdQ
	 VhKX5eIJlHh/cX9FW4uSJ8V464UokZ5tuTAA1c91R9MPgRpRaYp5QUrpJ7Y2BI3uQF
	 oiYwH5xgLzduw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC02380AA54;
	Wed,  5 Nov 2025 00:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mark deliver_skb() as unlikely and not
 inlined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230202425.3035250.6302811674647039268.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 00:20:24 +0000
References: <20251103165256.1712169-1-edumazet@google.com>
In-Reply-To: <20251103165256.1712169-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 16:52:56 +0000 you wrote:
> deliver_skb() should not be inlined as is it not called
> in the fast path.
> 
> Add unlikely() clauses giving hints to the compiler about this fact.
> 
> Before this patch:
> 
> [...]

Here is the summary with links:
  - [net-next] net: mark deliver_skb() as unlikely and not inlined
    https://git.kernel.org/netdev/net-next/c/46173144e03d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



