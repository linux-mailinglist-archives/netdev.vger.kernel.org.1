Return-Path: <netdev+bounces-40919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E387C91C9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935A3282F84
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB37FE;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmU7OCJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA331116;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18603C43395;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=FzTtcAKUWEbdKPYDmJ8HdxMqckUGXa+85ouyCmBblj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dmU7OCJS34LdFPJov/Hl8cZsx84Is4guicLy+j81W2feW3DoEkoQVkeF8iK/U0kW1
	 MGKZ48XBKt++4v9WCFc25fFDtp1dSt/3dxdpXlPxW3Zx1eBl0hlYW7O1ceN5gZVuWP
	 LLS47Xn0Io7GcKnmiaaNvhhqVEQWKNlr/Boh/8wBwrcs4MoHb7Qr8rprT3v9H8PsIV
	 eVHmJq8HJ2H4Kc6ymBEE0g9p7BhA7Qo1+BVIcQ7utMUQO5QpwNvxcGtBbgI3fYIZ75
	 7EQluos3YP8qQN+j1+2pbASzk2IYv0P4vrZvpplcTLhEKFJ1vIn3UUOk07JZDQDRfW
	 Papeb7nWmeibg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2F29E1F66D;
	Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342698.24435.5110584850065672168.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:26 +0000
References: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 20:38:19 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `desc` is expected to be NUL-terminated as evident by the manual
> NUL-byte assignment. Moreover, NUL-padding does not seem to be
> necessary.
> 
> [...]

Here is the summary with links:
  - sfc: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/220dd227ca3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



