Return-Path: <netdev+bounces-192520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6762AC032C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D048C1B677A3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C918DF89;
	Thu, 22 May 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxkIjG8c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74D18DB22
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885812; cv=none; b=IA5/3zm27ovTYpfXIbYMu3GI+nJaSIGbhOi2zH/clfEjm1e/3D8QcbHUQzVfsD2O+sfpNJPn8q0E8n1KsX8tOsevLT5lSXnvfeWfSUkWLAUuUKvFOR8W6cDffevZxBQfBMfVszU6hVKJx/+PnUPLo7T/xyT5NIzTRDn7JgE1x18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885812; c=relaxed/simple;
	bh=o+wmizuCZZbw2/Gj11L1g+qdfjuOF4OeS2WRUW2L9hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lfCBr1XZFhSbXoyRLS+W6Y1B2jFclcnYzu93wrwi7dPgM+64y5qQLcxewbMA1oXBPvHFYRYTZrgFwi4vaaBSu2Y1ncD/sX8quO4jpLH7wsXhFeAZqm56effjd3jZj0rfoQ4u7BKSPqSMrQ3lCGvgXGhnQshISvpyfJLV2QoKJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxkIjG8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CDFC4CEE4;
	Thu, 22 May 2025 03:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885812;
	bh=o+wmizuCZZbw2/Gj11L1g+qdfjuOF4OeS2WRUW2L9hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qxkIjG8c64Og6YEWouvOaaOCwp0kNxSxbQ10D6lRO9iYl3/fWdSlpLWEk3HZ+o2wV
	 v7X5GwBb6/CQo8Mk0s5cbq0q6cVQCuPMXHH0OE8K1ZyTmw7pyCpg/duSS+G9SioTu3
	 /kd19zYLn9FC5LNcNzl2JqZdtQYlD1Q0YxUkIEtgeP0qqv/5tkLuYst3yWuzJOy6hQ
	 Z+6xwNT4PRXFRJtdKTcNAKpplyYAl1n7cIfRZEcGzsy9T7+f54S29Fb1+lXvNuLbyd
	 ehOo8FTGHjoMBNH6s1aUHBeSyzbObfLZW1saX0fz4zBhXz1KRzxUMd0z4j6Vv8UKdT
	 JfgnPlFJPyebQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCA380AA7C;
	Thu, 22 May 2025 03:50:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add debug checks in ____napi_schedule() and
 napi_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788584749.2369658.17188045860119404191.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:47 +0000
References: <20250520121908.1805732-1-edumazet@google.com>
In-Reply-To: <20250520121908.1805732-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 12:19:08 +0000 you wrote:
> While tracking an IDPF bug, I found that idpf_vport_splitq_napi_poll()
> was not following NAPI rules.
> 
> It can indeed return @budget after napi_complete() has been called.
> 
> Add two debug conditions in networking core to hopefully catch
> this kind of bugs sooner.
> 
> [...]

Here is the summary with links:
  - [net-next] net: add debug checks in ____napi_schedule() and napi_poll()
    https://git.kernel.org/netdev/net-next/c/945301db34f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



