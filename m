Return-Path: <netdev+bounces-54260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D78065FB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9749B211E6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD786DF6D;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVILv7uq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE45DF46
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44DF7C433CC;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835824;
	bh=PMur+rXz4uLnFPzldaoXSLSsKa/YpTjCYkarehiUeeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VVILv7uqxIMhb20oIYthvdSSweNdE/8g7tuVQOw4aTw09ED0Sy1Xu/c71xt/82Aae
	 3B2AkSozbF7gnJxIa20FGLaipXpwFj6JheVY91UDqKwf7MHDaUkIb+BwXl76krl5PS
	 Cz3fz2gjdZ6LtV7h8ibpx1bVG/0dELmh0b2ULs0D563BkCnGDEbtdAsxHc6TKEf/xH
	 n1PJt2jt0p6XLI2gxzFXmV1DkVrw8n1f1FwSgVUug0tef/Mg1T+lps8v61pg0OwSXL
	 QYLBQd09Knd9hhyWzvwyr88P+vO4IowTDYK/o5a8wFuIVfw3Y7EP/DNPzkdmKv4wfO
	 4glwpMzjxi+zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29C40C1614E;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: move private definitions to a separate
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183582416.5454.4276753130094452158.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 04:10:24 +0000
References: <20231202211225.342466-1-kuba@kernel.org>
In-Reply-To: <20231202211225.342466-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Dec 2023 13:12:25 -0800 you wrote:
> ynl.h has a growing amount of "internal" stuff, which may confuse
> users who try to take a look at the external API. Currently the
> internals are at the bottom of the file with a banner in between,
> but this arrangement makes it hard to add external APIs / inline
> helpers which need internal definitions.
> 
> Move internals to a separate header.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: move private definitions to a separate header
    https://git.kernel.org/netdev/net-next/c/f3c928008ab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



