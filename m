Return-Path: <netdev+bounces-98519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDA8D1A80
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85C4282842
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97F13BAC4;
	Tue, 28 May 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHVYqAur"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E271753;
	Tue, 28 May 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897632; cv=none; b=b+lcK1Jx+bSIGJAAEhQQ5e/N8g8oYZgb2FKHnzNLOa0CMy6QmBejHGuiq9M19r1fo/Bzc6AZYeL9/w2xIFido1ZsrKx9EhQ7TCPFkqHlde5jFfvRdvb1If3Rf9TQVOiNJ/FXpmQ6ZqAIBgX6UphstYY387K+o3F/RgWxL5vSbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897632; c=relaxed/simple;
	bh=+J0aDbdoJf+gZfdTIwotMwK8JZuvHa/CmdbEGGaA0aM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RWTZTLwkvKS1GX3RjkmZSEMkZUA9jvF250HQQUQcv8zOIAV8qMeduQXq2BtGFsjPox07nNw0nfu5ee8KnzoFElUKGlpzwJAYVnEVbUWu67mjaQQiZR99JjKvaqSotCICHmcCNsAdtk0vg/BwR9Uei2Y46lcC/gceNrm8Ecb0D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHVYqAur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D77F0C32781;
	Tue, 28 May 2024 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897630;
	bh=+J0aDbdoJf+gZfdTIwotMwK8JZuvHa/CmdbEGGaA0aM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BHVYqAurKXiBZko4m3/x2SC+UmWAgzVX2EjmA9cqVqjzLMzljzIx/SwmkvDNJHnTx
	 hggjhDSc3HbMl6T4B8ihKq1AFr8MBL1mfOKe05n9TmtjyQSe1CQhxdxG6U5REytHkg
	 LXUpDsbsyzhH0vzsgSnxsGFu/QJOh8aG8qZXe2mRHiakjiJC13Peega/75KqfC3+4P
	 AGBaZWP9Jfcyj4ryOv9hykYU2xF6LscivzY+oV6+0Aa7JW35MYxY5pcs8MPby5tTVx
	 VziPFXToUUqkUABceQx26KaFZCKWN/CfwVCiSFsAzAef0YoaIuLIjNbQj0CT/RrIAO
	 icqghQK+3VdHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9D8BC4361B;
	Tue, 28 May 2024 12:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net/core: remove redundant sk_callback_lock
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171689763075.20900.865720577664819841.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 12:00:30 +0000
References: <20240526145718.9542-1-gouhao@uniontech.com>
In-Reply-To: <20240526145718.9542-1-gouhao@uniontech.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com, wuyun.abel@bytedance.com,
 leitao@debian.org, alexander@mihalicyn.com, dhowells@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 gouhaojake@163.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 May 2024 22:57:17 +0800 you wrote:
> sk_callback_lock has already been initialized in sk_init_common().
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  net/core/sock.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [1/2] net/core: remove redundant sk_callback_lock initialization
    https://git.kernel.org/netdev/net-next/c/c65b6521115e
  - [2/2] net/core: move the lockdep-init of sk_callback_lock to sk_init_common()
    https://git.kernel.org/netdev/net-next/c/de31e96cf423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



