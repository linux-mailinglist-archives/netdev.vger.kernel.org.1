Return-Path: <netdev+bounces-40928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521147C91E4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD46282E82
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667163A;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUiiKtYG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE37374;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F488C433C8;
	Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244624;
	bh=R7XjRM7iJWEuyNXlp5L3QYzrLdxLerO7l23H1nDRFC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PUiiKtYGKMRp+LCBOZmajgPm9Y7UjR1rGuGnq1OvquuURpLKsrDX2/xcyc3moclk1
	 oaHd03hYvcd2kAC7I7bXXsW3d+M6+VqLICAUf5LPG33i/UGHfhrV8q7tSFKEkN7IxY
	 lnT3AUrsdOx26Yz0a/0WDda+iDICvCI5FYvQfGzdRH2Rdv/HhMcT+tDZPX6IRWMx9v
	 3voW+XpZ4lhYe+WWBblEtXEpsCnmFvEvAJxUErv8oieWErU3wPCWkgnLoQl53HsagP
	 gDKsvznEO7Aw/6V9XvBHlZ3Z6NW3iEMljatCDpmgEjHh3eTR9aLMFhEPytOxOkdaD1
	 vMw41wZQs8GDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F06FAC691EF;
	Sat, 14 Oct 2023 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qed: replace uses of strncpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724462397.2191.2269567778777339120.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:50:23 +0000
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, keescook@chromium.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 18:35:41 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch eliminates three uses of strncpy():
> 
> Firstly, `dest` is expected to be NUL-terminated which is evident by the
> manual setting of a NUL-byte at size - 1. For this use specifically,
> strscpy() is a viable replacement due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> [...]

Here is the summary with links:
  - [v2] qed: replace uses of strncpy
    https://git.kernel.org/netdev/net-next/c/a02527363abb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



