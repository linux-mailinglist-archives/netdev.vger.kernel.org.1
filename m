Return-Path: <netdev+bounces-185793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD377A9BBBB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827891BA2919
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8F45C18;
	Fri, 25 Apr 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDybcthE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3BC23A6;
	Fri, 25 Apr 2025 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540399; cv=none; b=PwPfeUC8+4zy3FrrvhQRxMc+nTtOFVoeaywb4QjRbLEPZq0HuyNT/H6J8RfeJNLlSKHRil+OEJsqftlT8nwQoNHiLlZgTYx6wMIMGVbp28LGrkiVyNhAkTm8jkCsC2lu08or5gaGH7Y4AorFtoXM48eQjI2OBjsRhpz8/n2OyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540399; c=relaxed/simple;
	bh=cldQ+FwghzdzQNqNosTRJex6UF73Wv+Mm7TPcxAbJ1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lt4r84i6WiwXF8khhGz2J0B++cu/RMzh817OTgPqLBTh6A0ZeO6SjoRy7RJoYIKEu8cSO6Gbduqq2WHR25bI3o3PJt4OuYWdGC7/b+vTIbsO7Eg53Mjb+CG6DUmom0W5gieT5LeJtxVG6jTncbdVCAPkyv5SKqBSJlVBG5gMKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDybcthE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6051C4CEE8;
	Fri, 25 Apr 2025 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745540398;
	bh=cldQ+FwghzdzQNqNosTRJex6UF73Wv+Mm7TPcxAbJ1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YDybcthE6AQzsxvUp5Wf+Mi8S5XJOE9pbnPwMXULBQImhwRC/po1XDzJJHAFYtmYs
	 jKA5R7Tm0O40vDsH76JV5Q2Cw/8pIUUu+jLY70ayCjOwC/zavRP1eSMpGEYqc2MOqg
	 MvDBxMJ4iDCa2B53Upw6wEfka1+Y1DISUdK0z6oUiY0cZeY7D7voDY26urEXqu2YmU
	 O5JQPAMMPqATEWBmMgvPK0F4l8hlo2hMFHURfKqP3uzDBWxdW6nz0ZfDY1bJAFsrv5
	 NvljDmnqYHbIdVDeHj13MmsVjVnbqQk8J01Q5y3P+QAoaGNq1TCvzXYreeAeqFxDmp
	 Jw72MrrT0ymrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBA380CFD9;
	Fri, 25 Apr 2025 00:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rxrpc: Remove deadcode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554043732.3528880.15151083727009143758.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:20:37 +0000
References: <20250422235147.146460-1-linux@treblig.org>
In-Reply-To: <20250422235147.146460-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: horms@kernel.org, dhowells@redhat.com, marc.dionne@auristor.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 00:51:47 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove three functions that are no longer used.
> 
> rxrpc_get_txbuf() last use was removed by 2020's
> commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
> local processor work")
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rxrpc: Remove deadcode
    https://git.kernel.org/netdev/net-next/c/39144062ea33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



