Return-Path: <netdev+bounces-44795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC27D9DE1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806B1C2107C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113038F87;
	Fri, 27 Oct 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvQ4ReV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D138BCE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70978C433C7;
	Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698423627;
	bh=pbQpkrLmhOr95SBwPRLVHVDYU5YlN4lqDj8t/a27xWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IvQ4ReV2McgibPyla6LV9O83jfVi4O6aaa+fshY8ZPIlhKDsDRmJTf48ZwTI5rHQS
	 OGXOkD1XtVJ7M/qEsaG3sLyzSDcQCzBOwCVYNOYx5kqireeVK5/OmhT4LHRJqOsy0w
	 cQ9UWEEhLUNH8lgo2vwzvdIQYeswy9+TkOVgsJG3RVOYJBnPAd3iMKYA08i++88TaZ
	 u9Ck16hPug+1CGn8luqzUDqArHwmphoU65/70hJZTEIoOzUrkKAOndzgg4GJls6rfl
	 y153OhX/sFMuPDR9tc5I3AR9rKIpYnG83zZNHCKQKJyDuUMiPFLS4S7s2wdDcRYzph
	 iscyIYRiM2f4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53B4DC4316B;
	Fri, 27 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Remove module remnants.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169842362733.5811.12334263850114419002.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 16:20:27 +0000
References: <20231026212305.45545-1-kuniyu@amazon.com>
In-Reply-To: <20231026212305.45545-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 14:23:05 -0700 you wrote:
> Since commit 97154bcf4d1b ("af_unix: Kconfig: make CONFIG_UNIX bool"),
> af_unix.c is no longer built as module.
> 
> Let's remove unnecessary #if condition, exitcall, and module macros.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Remove module remnants.
    https://git.kernel.org/netdev/net-next/c/3a04927f8d4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



