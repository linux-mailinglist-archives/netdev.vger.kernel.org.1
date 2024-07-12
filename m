Return-Path: <netdev+bounces-111012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904192F42B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49FA1C21EAC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9AB67A;
	Fri, 12 Jul 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJGls8lx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D98F7D;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752632; cv=none; b=pg64OtAR7KJ5pMrh7qthdA8AH6z/Omu1X66eDw/f0fHmj5MMOg1lZoVK77A6RmaJctPuzi0HaQ0/5XIUz1mK48wkDFv1O5f07kKR2wcCHJ1aOR6f17vHSmHQoDcnCAyjrkqFCp56kC0WtiNlz9uFhWr0jpTNEfRW+a9JZhO/O/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752632; c=relaxed/simple;
	bh=nSWffd1bPlJG+fHntjmwZPKvBwDInwS+pa97uXQTnCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbbbGNWDL7S6XgyR3Sd+so9sfMIDpBMiFCcDvRzJXPQsIrxmORRGZ0Z+H1pA0k5+MbtWZsLrPR2LVuDik7xTegANpeVWGhRMvAZCFOgmj+GWs31MkLYlFvyW0BntavUj+Lns1fzd1i4ldGBil/lATn1COA9cqnPoihPgGDE/zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJGls8lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B34EDC32786;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720752631;
	bh=nSWffd1bPlJG+fHntjmwZPKvBwDInwS+pa97uXQTnCA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJGls8lx46tKB+MF0N1Z2pamJ6N+GUh4VlNnxPXdUnQminrg286qV4Cn2PlrFA2EL
	 q33hqqiOlqx+fBKTNnfJC+AM+bTAVi+HqBhi25JHqP4slERbwxWaXODQA0KVBqn/++
	 gGmOtYfGNkPBjd5dF1SAjA305a90H5yZZqFO/EwnpUJNzIVgM4u8a6EDchMti369SO
	 6WPLQ/bfRlhtLc7XS0wlBirYPM6XEbCytKr65Hu5tZHy9xC/xLlctIzdNkrBVmisw9
	 P4e6LkugxW60aID+HhKJQ9E4y3TNppekcRgHVcLg9zKHduKx9aCp0iJtiFvcOU6ewf
	 X4cc1Ye6BsbwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A29BDC43468;
	Fri, 12 Jul 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: Remove unused struct declaration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172075263166.5411.2775735137223201720.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 02:50:31 +0000
References: <20240709143410.352006-1-syoshida@redhat.com>
In-Reply-To: <20240709143410.352006-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 Jul 2024 23:34:10 +0900 you wrote:
> struct tipc_name_table in core.h is not used. Remove this declaration.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/tipc/core.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] tipc: Remove unused struct declaration
    https://git.kernel.org/netdev/net-next/c/534ea0a95e2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



