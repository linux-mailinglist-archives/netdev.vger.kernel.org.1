Return-Path: <netdev+bounces-137282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D047A9A54A0
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8864C1F21C14
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0B1957E1;
	Sun, 20 Oct 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGoKlHc8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BB1953A1
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435836; cv=none; b=CywdYw8UgkACeEZiezC3EzvDsQ/SrT3lVkXDTYUEnGWjmt23/XyoZ3FQI3ilHTXtUZpS+bePPIdgLHa4bXVlKjO7dMdz+HBFR3rgaGIsMmI/6SfipJ7wVYSbY3Fd3xgp9ZJT5JRiIu8AZFil6+tvG0iZNtpfaZ9Dkp4zHdWyQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435836; c=relaxed/simple;
	bh=D6/XfeoqGQQLdU8/vjH0OPQgxdHyzfSiDBaGjP+1xmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FscymaRYrYjaHoPK3gs4Sgcz8L8eG0oxT+5EQ7MIUi78U4ajRyeLfGAxTX8pR+zy2AOqpTyl8P6fj6ho0rhUIQFaZuzcEyIwIGSS3KcKdGwySeBRUqtzSaWXXH9asbAy+Sw84eLQkhgLM1tc9venfbhPKjIpl8b0T4sPqlBSOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGoKlHc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF4C4CEE6;
	Sun, 20 Oct 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435836;
	bh=D6/XfeoqGQQLdU8/vjH0OPQgxdHyzfSiDBaGjP+1xmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGoKlHc8yZNlCDlYoBExXVqUzIaqzkY3FYJvtymykMU/PtnaUbooM8kdWALMJ1gpf
	 93RVmzNS6A9fjxsFUCMaiI486VBPB3TLVHv5S5bDCm5VJQHFFWIdv3FjWgSx+ye89i
	 D1wC5t4Uh70Os3SkcOJeTLgjat9a3TbX/HhFgQ0IYRd8Szgoby6/x3SZfPiugVWwck
	 8WxCih/xichTIzG02vPik0AVA40ZsRWUjMQuRECqpAvsszJ+WoDWTcDiyTXszSdOdS
	 r5kGjtyiR0hBzC/juG572oIjs0HRagE4UJn4nVnVhkpFsQBsnf9UjnFhpVUyKKE7Lx
	 3tNFiOO+JLTlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2B3805CC0;
	Sun, 20 Oct 2024 14:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Simon as an official reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584174.3593495.9685602976320411724.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:41 +0000
References: <20241015153005.2854018-1-kuba@kernel.org>
In-Reply-To: <20241015153005.2854018-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 08:30:05 -0700 you wrote:
> Simon has been diligently and consistently reviewing networking
> changes for at least as long as our development statistics
> go back. Often if not usually topping the list of reviewers.
> Make his role official.
> 
> Acked-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Simon as an official reviewer
    https://git.kernel.org/netdev/net/c/9f86df0e7537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



