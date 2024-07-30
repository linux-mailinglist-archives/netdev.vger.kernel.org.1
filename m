Return-Path: <netdev+bounces-114217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBF94185B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC543B2A592
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4E18990C;
	Tue, 30 Jul 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAcg5fZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138B1A6190;
	Tue, 30 Jul 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356430; cv=none; b=hUriAUi+dqYBD+s7OPDyjPDmNY/62w+YAFp25tRDch1UGUlToqx/9q6+BhJfN0u8bfFUHZuY7aVEkljd+O1cY0w1vhjDRDYvISaEAmUvyBIpdmrtDUxUuxnr/8tQV7+CZWpSij9lT05G3XR39eEsJgEThlTo8cuUajTk6eBt8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356430; c=relaxed/simple;
	bh=BUUyY1NTz3JrwklnZ/Mk1s3DehDybPuYkwhI5XkEtLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TH3IxE55ZtTxYsaYK7CmiffMJ8spqLR4oJeHrn1Fj4shj1rmAy99VTMKDEjNaR0j1YNNlWAilZPNOAbBZNmcvMhBGhazcErsI+dqbHftwkvTY2DjSf5fIOHUJsLIPamG6BRL75JupdI6SPeYaT68SOEFVCSYpEq5OF9ZqajxxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAcg5fZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85926C4AF0C;
	Tue, 30 Jul 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356430;
	bh=BUUyY1NTz3JrwklnZ/Mk1s3DehDybPuYkwhI5XkEtLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WAcg5fZ1skHq3iYqMc8IUfB/jA7JF4wcIzUJSb7VvWTkC3VWJ9cKGK6B/VoUaT9EM
	 iEESRyZtsKQJpXDXeSpdk/tk/N2XVgJB4H10fKKY/C4cl1/d1mefL3hDmgbMDni52n
	 OV5rO/OBi6OcEEP7X1trOUvQn//pUsrJBGSAIFU81u04QCz46/NfyYuk219b5PsCRR
	 T97IbGQkEzwQDug5bzCN3zYpH2nLX1WyqbLefxuAC1MFcM2QJiOYvhfpn1HV/TwveW
	 aYSOTuhn7jWLZuFafDSWDOLdU+ZBc3F7/L3kFnYbLU+z8Y6F88DmWCABtExJhokD7p
	 y7aATP87ypOpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73D1DC6E398;
	Tue, 30 Jul 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mvpp2: Don't re-use loop iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172235643047.2398.10999820377012165647.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 16:20:30 +0000
References: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
In-Reply-To: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stefanc@marvell.com, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jul 2024 11:06:56 -0500 you wrote:
> This function has a nested loop.  The problem is that both the inside
> and outside loop use the same variable as an iterator.  I found this
> via static analysis so I'm not sure the impact.  It could be that it
> loops forever or, more likely, the loop exits early.
> 
> Fixes: 3a616b92a9d1 ("net: mvpp2: Add TX flow control support for jumbo frames")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net: mvpp2: Don't re-use loop iterator
    https://git.kernel.org/netdev/net/c/0aa3ca956c46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



