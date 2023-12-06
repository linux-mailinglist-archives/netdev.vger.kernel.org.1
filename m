Return-Path: <netdev+bounces-54259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEB8065F9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DBB1F2154E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B725FDF5D;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYTuxpbX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82AD286
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CD5FC433C9;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835824;
	bh=LcPV7DiEUBDx4t4JojJT2AoUqPme2vmg163uw7LU2hA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYTuxpbX3jkNatF6yFyNkrloUc/jhxV6DQwgLmzqxH/Hn1+ElXxzWtT/3asDwRdHo
	 EA3Ta3TlCsc0I1F5O2y4XHo3f4ELh3p+tTHdmyDM9hliEQKE1rIfssPyOYY3rhF1ma
	 NCVoZQoldtTnipfW/rKXzdOVYrHgg9XxTZ9tUWbQ9RVP4liY0r22m9zm7vL/MrwdmA
	 JLykaAv1bRuQtLf73nPNUo5Rk311jVJU82mMni20XC8SBcUPctospOZVPTPx++06xN
	 rPaDgePcrCaczpJgSy/+HdJNRprOevhm+L/YMvoHreyhU/werTkqhxVr1n6Qn5yq3+
	 jyi2QACZi2eLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 152CAC41671;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: pynl: make flags argument optional for do()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183582408.5454.724250771651993506.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 04:10:24 +0000
References: <20231202211005.341613-1-kuba@kernel.org>
In-Reply-To: <20231202211005.341613-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dev@codeaurora.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Dec 2023 13:10:05 -0800 you wrote:
> Commit 1768d8a767f8 ("tools/net/ynl: Add support for create flags")
> added support for setting legacy netlink CRUD flags on netlink
> messages (NLM_F_REPLACE, _EXCL, _CREATE etc.).
> 
> Most of genetlink won't need these, don't force callers to pass
> in an empty argument to each do() call.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: pynl: make flags argument optional for do()
    https://git.kernel.org/netdev/net-next/c/e136735f0c26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



