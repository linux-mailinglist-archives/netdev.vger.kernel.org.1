Return-Path: <netdev+bounces-194141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10EAC76FF
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1552CA25C62
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA92528FC;
	Thu, 29 May 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsDvDVfa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B52522A1;
	Thu, 29 May 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491800; cv=none; b=Qx8i+5/FkayDhKKKuGOPWZB7S5CvsyNJ8v728MB9P98KI8jl9r4KVVNN3FOkVG/rTn3DvQIVbVEYZKlZC7fBuy3YyuQd7vFHXfQFjC937w6I5GyDaqjf5/LDjWxaFe4cr0fOPJfvBPxtwzsdxQXcp2IaXYyXqTvms/+XEqxMFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491800; c=relaxed/simple;
	bh=0o+8AD/RD1fL/iqt3WwV97aLKspgLCoi7DI91hWJWok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkbHqtL86uMoadAw05irLcXRxvGVrZx/y9RBp369tgO5Phebbo4Gy+NSQP62/kQ4FOxBVqaLn49dnZTk4Z0dPIhFX/DFs8YIrIHWw3D/0OXFyCTTtILQPggu9QoNusrxy0Q3n9kV2RjP1Drfx/WyZPyVz3bNjelnp9aL2U+3nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsDvDVfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E9C4CEEF;
	Thu, 29 May 2025 04:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491799;
	bh=0o+8AD/RD1fL/iqt3WwV97aLKspgLCoi7DI91hWJWok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UsDvDVfahBvcgRJPGHZNTl8YVuvaNMO2SUN2OWbvnBqc2V1sFlqDu6XCEBolzXBOh
	 MNEfxYFdsxw30uLJusIuXhZCXgNG6LF8XhHQkVhXNEuWIcVFXajnKUtl+kEkq3QZ3z
	 HP8Denm5Vi5EGDb5Ti/IYtPt2dxIUHir0RUUWWJnvcho1hMLJlcUCNhEZZ7nN3w6Iq
	 FJ50cIl2BJr2X8iZnJZ/tkjc7MI4SLPgCd4xzNsf0MRDDbA3kYINsj6vs8Gb02O2qS
	 aJ5CyR6nOXIki4090hdn0/lrl1iDaebZYtpKrImh1RBaYN9bRUOzbEqu8nKoChm13l
	 lyImmr1I4SWlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACEE3822D1A;
	Thu, 29 May 2025 04:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Fix sock_exceed_buf_limit not being triggered in
 __sk_mem_raise_allocated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174849183349.2759302.11005825928372039491.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 04:10:33 +0000
References: <20250527030419.67693-1-yangtengteng@bytedance.com>
In-Reply-To: <20250527030419.67693-1-yangtengteng@bytedance.com>
To:  <yangtengteng@bytedance.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 wuyun.abel@bytedance.com, shakeel.butt@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhoufeng.zf@bytedance.com,
 wangdongdong.6@bytedance.com, zhangrui.rod@bytedance.com,
 yangzhenze@bytedance.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 May 2025 11:04:19 +0800 you wrote:
> From: Tengteng Yang <yangtengteng@bytedance.com>
> 
> When a process under memory pressure is not part of any cgroup and
> the charged flag is false, trace_sock_exceed_buf_limit was not called
> as expected.
> 
> This regression was introduced by commit 2def8ff3fdb6 ("sock:
> Code cleanup on __sk_mem_raise_allocated()"). The fix changes the
> default value of charged to true while preserving existing logic.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated
    https://git.kernel.org/netdev/net/c/8542d6fac25c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



