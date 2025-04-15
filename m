Return-Path: <netdev+bounces-182738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3811A89CA8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7C47A64C9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C528E5EE;
	Tue, 15 Apr 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln0qXxRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1D1C8619;
	Tue, 15 Apr 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717197; cv=none; b=VOXYdY9Oz5HPKR9aYzfkR9+yGu8ShJqI0Zh99SkrOySDMP+AvWGh+OpHEglRdNkh8Mct+OOJxiqp6y5yZrAHa4eEGf4CScOkYYmVHoWhEN24xUtM6kwkWf8nvZ3yMzC1fyEJ4lJnwNpY/yFpqVweJOHkPBYE83iNWp7p37FLmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717197; c=relaxed/simple;
	bh=0wFrY0jVFGKAMIzdrcfU4BALe7XxMacv+VYLau7nww4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKqwEBuvjerjhWfiEavfwjeaN2AE+wZMWUCDguHTYT6y/eTMw9UrjGhYMEKWqKWpwCCwwtERFYcVBfUppUukRshuiXyDC2Rf1SvXyJVgvYserO6HhCmc6NJ5D8eJvHbqlv+Y92hh7dglthxtJ8ESW9ZG1g9oejrLn5vt++hokQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln0qXxRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F06C4CEDD;
	Tue, 15 Apr 2025 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744717197;
	bh=0wFrY0jVFGKAMIzdrcfU4BALe7XxMacv+VYLau7nww4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ln0qXxRVcToNpl/mo0crif7DII2GHu++a8X9moyWg0ntnGQXSsVnI8MthlULijvaw
	 PkpiO9rJdaxofVh0SCsNpji01hCaEdDmRm3RpKGcPdUNtgVlhLIKcHY727kyk1S1Yc
	 pkF8aeDNYJcQ1nbGQfslWYfI0ojfG3NOEXN4qiWV/66PBPg7MEKKJ6FVFY66RIL4dt
	 Z67tCcU8unEduPYl4BrDaOikff2DW0q+/jz3+R5MA4I4OphH2pPX6cJtXvFm83cP9x
	 e5JbEl5kUCTUi9UKZc4DUytPiBN55yrysn6j2phl4Y2+8hF6yQiHbU/sJD+zx5Lkpd
	 p8IMrrRRU9MeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F703822D55;
	Tue, 15 Apr 2025 11:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Removing deprecated strncpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174471723506.2600560.18296799870164232004.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 11:40:35 +0000
References: <20250411085010.6249-1-kevinpaul468@gmail.com>
In-Reply-To: <20250411085010.6249-1-kevinpaul468@gmail.com>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 tung.quang.nguyen@est.tech

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 11 Apr 2025 14:20:10 +0530 you wrote:
> This patch suggests the replacement of strncpy with strscpy
> as per Documentation/process/deprecated.
> The strncpy() fails to guarantee NULL termination,
> The function adds zero pads which isn't really convenient for short strings
> as it may cause performance issues.
> 
> strscpy() is a preferred replacement because
> it overcomes the limitations of strncpy mentioned above.
> 
> [...]

Here is the summary with links:
  - [net-next] tipc: Removing deprecated strncpy()
    https://git.kernel.org/netdev/net-next/c/8c9b406ff470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



