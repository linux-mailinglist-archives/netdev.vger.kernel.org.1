Return-Path: <netdev+bounces-169232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED4A4303D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39BE1892869
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255132063FD;
	Mon, 24 Feb 2025 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLvLBq61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41215B10D;
	Mon, 24 Feb 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437401; cv=none; b=I3j2dh8pGdYwkBOGB+DJE6g94muFIiIUQ7nQnkthfs7iIt+rzqCNI7iZZj5iH+haq//3OAZWIKIjbxO+GoFcgiiUukCOws+XgNjB6XBME3tZmTbXGzNwClmeJr1bInRSpewGCSSgQzfCKLGJvQN4ehQBtn51q/8SR30YqW27mbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437401; c=relaxed/simple;
	bh=m0VWXQc0+KWLoKOvTalZ2lmiF3taoCMKhQo96UyWEKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/otPoldAf6FiAQNCVHNL/4caC2GSVGKNbTLguqiSY6jSHHA4zpFjyEXzzKWP5wbjzGAoaJrFhEi+iVTKVUAf/qbnAXPNkTvrPD8UscAQeQwJCpiRQGzABkEgiK/KH7U/RuYI1n2fS3HLlTl5FZxWq8/oIvO/Fhk4HKr++Mc4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLvLBq61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA0CC4CED6;
	Mon, 24 Feb 2025 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740437400;
	bh=m0VWXQc0+KWLoKOvTalZ2lmiF3taoCMKhQo96UyWEKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uLvLBq615Kcjje0MOmwxsSIdxiJZrKWKkp8J8mAmiM+1TrN/+EcnxrRez9Bb6hGqo
	 /T94aMwAgEubKncBuYB3iWqgq1Vxsxw4SYAaTrTzN7c4PjrvRbirufBp20OBSNunEW
	 L5Jafls1ZVskNSEjbO2t/rD+ClLoPJjN2EX1ieerDMgGOCsNhP0W44oYvw8qTjV5Cz
	 G6mogAV+6nFglfwVsO75yRzxmq7jtSvvCGfBioqFpe/wWyK57jgIx3xGl5I/F20Lio
	 fbl4rpNRY+z8jpfJnnS1cO+CGJq4B6B/aRPdK5vVbw+CffpzSb7JaQ13nDzPxbxDOj
	 GLn04/xeb0rEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D68380CFD7;
	Mon, 24 Feb 2025 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove shadow variable in netdev_run_todo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043743202.3635590.16881580455531026695.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:50:32 +0000
References: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
In-Reply-To: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 09:51:27 -0800 you wrote:
> Fix a shadow variable warning in net/core/dev.c when compiled with
> CONFIG_LOCKDEP enabled. The warning occurs because 'dev' is redeclared
> inside the while loop, shadowing the outer scope declaration.
> 
> 	net/core/dev.c:11211:22: warning: declaration shadows a local variable [-Wshadow]
> 		struct net_device *dev = list_first_entry(&unlink_list,
> 
> [...]

Here is the summary with links:
  - [net-next] net: Remove shadow variable in netdev_run_todo()
    https://git.kernel.org/netdev/net-next/c/7183877d6853

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



