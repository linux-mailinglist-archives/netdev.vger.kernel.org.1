Return-Path: <netdev+bounces-107864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CAA91CA1A
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 03:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9100828314D
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C905661;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRQNKcdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8834C8D
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625857; cv=none; b=A6HUwtAPkUSaxhu8blGb2PA//hIn/QJDbksmBWPpOse9vrcvKtwII0mhhZuoedxHoTL0UB4lpzPQeXDnZOfaT4eNb+G99eVo+ZF1fyVtT472ow63hbXlIZlWnGCjD7gYcwF9YDlrNpOTpzDQLEt/xCOMBoe7lxIDUmqRCRTNsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625857; c=relaxed/simple;
	bh=P7Qet0Yr4Q8bBBQpN3DVspkm+inp6akobqpB30LFG48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UWUQYVzQV/05F9txBJq46o6/6ItNysevbzL4o+FSgVsSj2KtgMcklzxt7u3KAcYi8FzAuBB4Xkuupi+feJzzrIeqhVD94qjfkTlZ4zpRVlmrNqT2ToBJRk8o0esWAfR0F2dvpgUez9FZqkm4ZbSMdYzdkudcRh9fGBYzLrc7Z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRQNKcdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BD47C32781;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719625857;
	bh=P7Qet0Yr4Q8bBBQpN3DVspkm+inp6akobqpB30LFG48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRQNKcdObgpEXHpLiQUQMy47hsXAKpQkE9Inrm0g6oAWTYGwHk+v3IKP+IUUUNj/6
	 rF2fmiw6K0MMFmsupYDz/xY4D00HO9tEMfHME0sYhIFqpCR0/rcqRYZxqJpy0P9Av0
	 Um31lYzPZ00T9JL3HC8yS9H1r81TXoCbhNveEODugbRA33jEqxibDunJQkdM0GW206
	 i8MVTQyqFIKIrIjUe5uZn/gqAyJpbBjDvFG5SzuCGnhFNuYl4pJLmBt0M0xBVfrZKe
	 7Pcm6EiTTbOa2Ed5AucvOLZ1JS9ufxQXUAK09IPeQYkB3yj3tc5Jvl0fHbBoBVywMT
	 woC5QNSt6af6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A5BFC43443;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Lift UDP_SEGMENT restriction for egress
 via device w/o csum offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171962585710.15618.2691302964178977119.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jun 2024 01:50:57 +0000
References: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
In-Reply-To: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jun 2024 19:51:25 +0200 you wrote:
> This is a follow-up to an earlier question [1] if we can make UDP GSO work with
> any egress device, even those with no checksum offload capability. That's the
> default setup for TUN/TAP.
> 
> Because there is a change in behavior - sendmsg() does no longer return EIO
> error - I'm submitting through net-next tree, rather than net, as per Willem's
> advice.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] udp: Allow GSO transmit from devices with no checksum offload
    https://git.kernel.org/netdev/net-next/c/10154dbded6d
  - [net-next,v2,2/2] selftests/net: Add test coverage for UDP GSO software fallback
    https://git.kernel.org/netdev/net-next/c/3e400219c04d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



