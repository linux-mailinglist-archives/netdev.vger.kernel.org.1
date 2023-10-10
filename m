Return-Path: <netdev+bounces-39412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33497BF113
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18F51C20B56
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9510FF;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raux9y7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BA656
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9657FC433C8;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=URd73g8s5ifazQo6+DqDgpvh+VBWdEb+IxSo2qmNhJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=raux9y7o/CeHLwx+dcFLejqWIZ4DerMdVerqFV1XzHBetfMcnS807dKnZAbw5ecCE
	 hqnEH4O31GHK5gg4zp4ADvm/Oi+D8M5jIje0p9Snz01Uaj1keKxuGg7zadLfS167Nz
	 Z1/AiPzVXHtJwpFNPPEQKPt6NMdzGFMgGroEfpihWRD6lrqZcW5nojdJ3enIRrba+M
	 8wh6aziuhVOl2zsCcUiD3GPXv5bPlskfgy0mMYLUmYEY3bG3TiX0GhMXFPGyUHkXmZ
	 7KhaSIrWu75Z8TieChzQ42bz0cA5XkEEAG8CxvFsw8EnOzTJK6hx3x+CLl3+LGaLsO
	 XfWIY5D8nJqoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 742DBE000A8;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: handle do ops with no input attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622547.548.5530158771040874908.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231006135032.3328523-1-kuba@kernel.org>
In-Reply-To: <20231006135032.3328523-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Oct 2023 06:50:32 -0700 you wrote:
> The code supports dumps with no input attributes currently
> thru a combination of special-casing and luck.
> Clean up the handling of ops with no inputs. Create empty
> Structs, and skip printing of empty types.
> This makes dos with no inputs work.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: handle do ops with no input attrs
    https://git.kernel.org/netdev/net-next/c/8cea95b0bd79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



