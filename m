Return-Path: <netdev+bounces-46166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AED47E1D06
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36782B20C40
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662215ACC;
	Mon,  6 Nov 2023 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnMzu72O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC906134BF
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60B79C433C7;
	Mon,  6 Nov 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699261824;
	bh=KXshPDcsGkmeyiz5/VgI7uy1YZDs917Qz543M1VqUQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZnMzu72OmAy6FDg9KgW7Za3dCcKUBRStpt6vzq5Uj36G3ISYl/qwPz5dj3HKxnRJc
	 hEOE71Y5dvDY2xYqK3AxrVpdiSgP3kF++6vGpXzMfD5KlBH9bfP9H9VyikuZujyfEU
	 EQgxGrQi8YHp7WKsJn93mHEqCq2LgDKGJ94me/k8KeysTyQyL+jP1/mGLKHQcRL24L
	 JLKf/lw4oFbps6JdJ/+spsh/mafTkjPwrPBwEQPWp2FdsjumkQ4M7dsNfsFBrQ8d6U
	 TR7zNosNDs43U3W3zCVqBx9jXR3Yk2UhPuhR8qH/J4e8TP5Qs4JUEyNK+KwqIMNThu
	 Nbm52pUerOryA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4750BC04DD9;
	Mon,  6 Nov 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfsd: regenerate user space parsers after ynl-gen changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169926182428.22648.746242944138972471.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 09:10:24 +0000
References: <20231102185227.2604416-1-kuba@kernel.org>
In-Reply-To: <20231102185227.2604416-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, chuck.lever@oracle.com, lorenzo@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  2 Nov 2023 11:52:27 -0700 you wrote:
> Commit 8cea95b0bd79 ("tools: ynl-gen: handle do ops with no input attrs")
> added support for some of the previously-skipped ops in nfsd.
> Regenerate the user space parsers to fill them in.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: chuck.lever@oracle.com
> CC: lorenzo@kernel.org
> 
> [...]

Here is the summary with links:
  - [net] nfsd: regenerate user space parsers after ynl-gen changes
    https://git.kernel.org/netdev/net/c/d93f9528573e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



