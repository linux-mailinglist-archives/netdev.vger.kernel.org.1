Return-Path: <netdev+bounces-194191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A1AC7BC0
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E47A9556
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD68227EAB;
	Thu, 29 May 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8pLGpX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333920E70F;
	Thu, 29 May 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514596; cv=none; b=sPrzWk/mGrY+Bu7VqpiG9VBuib5UU+0ieo+jDb1u3Qait5kdR5L1cp1doLf1N7fOQkZ/ndfhipcrR+BPUA7QMWNBOkxOajoY/VzIynzRt57z6uoRMS4+eiXgWOd9b4MQWqfOXncX0Dkf3FjDpuK/PCHfmIfuGfg8TIKxyZsL0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514596; c=relaxed/simple;
	bh=toUK5ZMsDfjP3cYjKQaMzEVl910AbOLI7dMcvhjIReA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExS74cjK99Jnebk00ZZMBJqbi0CjgTwP6azJVjhEGEcRydSEM9Pr1cwuwHJhqlDJVR7ljwrnNnEOobMx31waX0xop8nAvO4hS05pdVrVpVOYQDUbvtumRh0nJJOLeUULgU4no7WoW8apa/5B1NoisNDtoJ5sfKTyeLjkka4KsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8pLGpX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31ADC4CEE7;
	Thu, 29 May 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514595;
	bh=toUK5ZMsDfjP3cYjKQaMzEVl910AbOLI7dMcvhjIReA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8pLGpX3iqNVBACKBqrxoFiUtbrVcwr1PsmMSGtQVzFhoBwwkeB2wLq6WENDTU8cw
	 4VFKqaM3KiIXDyDHW8BoQKAPLEdy822+iwvKPVp2OpaVZOEK4GMa577myUiUgobHtD
	 9v4vL7CLcNXT5QkyJMJl7/XnDFzRWKFJa347rfyUnESJmRHzXZw1gYaxAlocCjw2oE
	 KhNtaL1Q9ERMJqZUp36A39nolt9ghAPDOWwA84uQnnIvFEC6JnIA4rXElfarwZgiox
	 nTTucl+WSyphCzA6yEIYkv+gwgOUJ2I+CQaX+ScVVmmKdNpQWQHMC1kVXrkFf+15dr
	 O4QsqxiWE48Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD539F1DEE;
	Thu, 29 May 2025 10:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hinic3: Remove printed message during module init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174851462950.3219366.2688484199250424947.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 10:30:29 +0000
References: <5310dac0b3ab4bd16dd8fb761566f12e73b38cab.1748357352.git.geert+renesas@glider.be>
In-Reply-To: <5310dac0b3ab4bd16dd8fb761566f12e73b38cab.1748357352.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gongfan1@huawei.com, guoxin09@huawei.com, gur.stavi@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 May 2025 21:33:41 +0200 you wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> No driver should spam the kernel log when merely being loaded.
> 
> Fixes: 17fcb3dc12bbee8e ("hinic3: module initialization and tx/rx logic")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - [net] hinic3: Remove printed message during module init
    https://git.kernel.org/netdev/net/c/4257271d2a5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



