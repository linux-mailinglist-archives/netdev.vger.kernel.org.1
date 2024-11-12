Return-Path: <netdev+bounces-144071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD69C575A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5337C2816D6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E71CD1F0;
	Tue, 12 Nov 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP1F+LsO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729F1B5829
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413419; cv=none; b=pvgftL3+dU05TTpItYGdwfkx9hIxGea9cw0Gn+P7BpMkumlN2nJ7T04WlpM70+GJ07CDRfzHePrqTpOAJjAJUGkcyR3LZXHGuFEXmPhbDB6zUiRlVkO4fZLyg+64N2xyIQCu9HA+I8x2IaNTEMqajGtoqvI5LATpeeunfLjR2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413419; c=relaxed/simple;
	bh=3B/mpbuH8alt6Xit9pXte51viowrBD54imd7CVX2dQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boM4Ybm1YUBunSaI6+hXq0fVV1y5wMLQwLlXf3l4wCL0qOMJU7foi3APqFYxXPJtDnwi+wUDwLUQ9ZTTkizPFASNfzo2rdbinpdGYzbD62nbFfTs+1v/t22VtQYNAOoPTLPIzQlEHnjbboXig9sIirMagIcmOQp/fky8Wmy9Bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP1F+LsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF78C4CED0;
	Tue, 12 Nov 2024 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731413419;
	bh=3B/mpbuH8alt6Xit9pXte51viowrBD54imd7CVX2dQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HP1F+LsOndlKJOfq8d0KZx6/hz7ORuKsItrdVsKystUVvC3ma9N9DeFKdypllVQbi
	 2BujY1TF4QtRvHp/yzfWjlfFDuq6+sf3E1NwWHQ59h9WdgFRzGZlPW10PS4tT+nb/M
	 eQtVCjAT0w0VaEbFywATiBtaW93bDC3vAwIEF1dqWUY3kjthQgy43OSVhMhir6E2bt
	 dcXfnD1H8OsCnqPbPQRlxPo9PK2DrYwVgX3BReWwZs4wGGnBQ8X48ftyprHB1ocVM6
	 zAsvzJiQNRHvFDiMyYA0H2jvwZ/b8P2aU2THr+tR/pVRoUfCXDqSzPvArwauYvQsbx
	 jYVdGw3jCl31A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFB3809A80;
	Tue, 12 Nov 2024 12:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sched: cls_api: improve the error message
 for ID allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173141342925.502249.3229312898557283792.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 12:10:29 +0000
References: <20241108010254.2995438-1-kuba@kernel.org>
In-Reply-To: <20241108010254.2995438-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  7 Nov 2024 17:02:54 -0800 you wrote:
> We run into an exhaustion problem with the kernel-allocated filter IDs.
> Our allocation problem can be fixed on the user space side,
> but the error message in this case was quite misleading:
> 
>   "Filter with specified priority/protocol not found" (EINVAL)
> 
> Specifically when we can't allocate a _new_ ID because filter with
> lowest ID already _exists_, saying "filter not found", is confusing.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sched: cls_api: improve the error message for ID allocation failure
    https://git.kernel.org/netdev/net-next/c/a58f00ed24b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



