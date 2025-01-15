Return-Path: <netdev+bounces-158338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1BA116D8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A67B3A8495
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F2322E3F3;
	Wed, 15 Jan 2025 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUniUdzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68422DF88;
	Wed, 15 Jan 2025 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905827; cv=none; b=gXcDfqaeccrxRAZchQ0M86sbzC2ivxx5uQqVq27xr3Mo4BaJZqJcr6O6BWFv4V+ptnw5N1FlMGDEUOrrA0xZvRidEX/taxRhdzewW+KVA7HLiA7fBynjEXfYAhVXygF3BglkjpDPSLzjpj/t2K5G79jC9dKdxmq26a2E9Y+zXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905827; c=relaxed/simple;
	bh=33uoSImIzuTdBDvMv8qoCTzaNxaRps/HfBT+V0d0t4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ud4UKo+cnZJfKg3AFx5cOzltMwVStS1TmP7o7wS/Rzhk3l2oU1EVY/8QwRoUWaLW/OVugmf3pPdNvR70BGo9CGTYAE0n9s8qctoiO3kJWH0IT2IxTywG4FTHTC25TXm7CW4P9MW6A3vqjOJzJOs3y/hZvJgDwtO5FzVTdCkk8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUniUdzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F64C4CEDD;
	Wed, 15 Jan 2025 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905827;
	bh=33uoSImIzuTdBDvMv8qoCTzaNxaRps/HfBT+V0d0t4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUniUdzX1I+ic+sODC3f6QDOH0qwnssl0T9aFR1CxOmwzADfwKBcAb9k4hXPLSoqM
	 Pp+7lfr05jHt0h/J/qy3CDWpXtCf7Zj19TVgBgQWsWQuHkQ5bkh8QTlflz15rp3zfb
	 O+K1A4ycphxLSTdom7QYVhZlbNe5GmVsPhyrNZSc3QvCbjEKlww45iBFvinYIR0QD0
	 dxZnpWs/QSDn5CkDCHdNO1lDXt4b2d0Jp8PdaeQGJgMK1NqX+ec2mX8Mc8ELZSPmo/
	 hvH0jFvN5nJ2xMjC9sdAdwK7yDchhVqCvKP2yHy2I9z2mOq1EkFNOLJAlhjCfdAvj7
	 wc1OdizacgeRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 14D93380AA5F;
	Wed, 15 Jan 2025 01:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] socket: Remove unused kernel_sendmsg_locked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690584973.216599.5579823911359263622.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 01:50:49 +0000
References: <20250112131318.63753-1-linux@treblig.org>
In-Reply-To: <20250112131318.63753-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jan 2025 13:13:18 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of kernel_sendmsg_locked() was removed in 2023 by
> commit dc97391e6610 ("sock: Remove ->sendpage*() in favour of
> sendmsg(MSG_SPLICE_PAGES)")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] socket: Remove unused kernel_sendmsg_locked
    https://git.kernel.org/netdev/net-next/c/b6be5ba8f1c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



