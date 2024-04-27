Return-Path: <netdev+bounces-91862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB898B4350
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D61F228FD
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758C2577B;
	Sat, 27 Apr 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfmCY1xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8D2570
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178429; cv=none; b=lM8CPmpuNrpcj8nOPSlvW2TIumwgOqzJbOxAyHVBeQD7937g9V+VREf12BlwquYajWZlSafyTiPIc3C+1CqisAN/VTiMhu0sutungh5Or8WTSefmucnHTp8f3SgfEw0m3P9TD8CYVzjUlcWL2n4CWVdU64OQtA7k5jF3d4UZq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178429; c=relaxed/simple;
	bh=67gI1qmEUOLxgfHeIHSAgsR0rNUfir32vVauY6m2kr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFi0CZXBr3K7iDZdzYu0m3+PfyNmiJwTVlHpFsEOWBwyXLffx0ezuUBXFI4dH7oKvQbI+aDu8TbLW/l2OkWObkkRBhA+rZvtC5CAQ8amnvunwv7OZLY0nfGkan8uIotfeaEwT+tOlyCXYSodRpoe2eXwhmGDrxIQLveTLJoX1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfmCY1xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B112C116B1;
	Sat, 27 Apr 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714178428;
	bh=67gI1qmEUOLxgfHeIHSAgsR0rNUfir32vVauY6m2kr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cfmCY1xbbw0wT+PYIy0xZ7EmpT8f4dekVDDLPyWbV+JaWKumNAtwfacaG06E3Apbx
	 nlaHJvbwTw/Gq8VcxxKXhVUHGn3VOL1OlFNjzTOL6SpXBsqJAlREk3EFozJYzWMXN8
	 WDGpHuNpv6E6m//upX0DGYMZkbozaZ9RZpoUhKcutScKDZl6SXqICj+bFmrhsTyP1l
	 pVWonH94AEOjXL8VFoaEJz4ecruE9/aHCw5ZfxqTOvh7+quAfKnfUIqR2GC9SHPfUr
	 7gevfntIFYzeWwL3zi6h7PHmp7uk1Tk8Haml/Fu3MkAeEi2JCylVhu0jRW25aIFXGi
	 n8XohFEZxz/iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8852DDF3C9E;
	Sat, 27 Apr 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: don't append doc of missing type
 directly to the type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171417842855.20523.3162353264464657134.git-patchwork-notify@kernel.org>
Date: Sat, 27 Apr 2024 00:40:28 +0000
References: <20240426003111.359285-1-kuba@kernel.org>
In-Reply-To: <20240426003111.359285-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Apr 2024 17:31:11 -0700 you wrote:
> When using YNL in tests appending the doc string to the type
> name makes it harder to check that we got the correct error.
> Put the doc under a separate key.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/lib/ynl.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] tools: ynl: don't append doc of missing type directly to the type
    https://git.kernel.org/netdev/net-next/c/5c4c0edca68a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



