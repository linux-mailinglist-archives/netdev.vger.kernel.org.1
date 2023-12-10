Return-Path: <netdev+bounces-55645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1F80BCA8
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87100B208A4
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121D1BDC7;
	Sun, 10 Dec 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTn5fYSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D428E3;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83C3DC433C9;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702235424;
	bh=xtoKuB/V5aQTclBE1TijIXIA5MMvFsOIUDUePA15oJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fTn5fYSwkkUvrDxP4edGPar1kTbyUg/lSDWLQpE0fO7MjAH2qRbaseAw1YYic51oE
	 7M7VMoUcbhvtVSQq/ez59JfxOpcGYbaBbTFWGBHd3ukUsv7YiB15mnxg3ATsFw7Ce5
	 38jd2tAq9tV+Lcn87qWGpMnLT6bhfmwlEn34ZuzEJoVg6zDjTm84CoSDfCZt7jI6sq
	 5LP6m8M/2IL556tt7xMTTvJWTCazbBIWh6ya2+GwVJYIqYq4tdpL0LgL4oRflqdGnJ
	 3L2lKexfdgLLwkrKJOL60p/5oYkBoB51V0RPtHtXRLbGyLqkSzdW49ZlEXd80xdXnP
	 6z1v1rQhhwEHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 694FDC595CE;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170223542442.32670.11976049465072620330.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 19:10:24 +0000
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 07 Dec 2023 21:34:42 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - [v2] net: ena: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/378bc9a40ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



