Return-Path: <netdev+bounces-44633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CF7D8D50
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A20B212B2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B71857;
	Fri, 27 Oct 2023 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAGHgW24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF364A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCEDC433C8;
	Fri, 27 Oct 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698376226;
	bh=a/d4S259qEUW8A3MmX4wv1YER+xhGzkkkUI5hFAodEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PAGHgW24Bf0EsqnUpoTzCXLp+P7q5oaCSix1NWg2uV+g+wK7v71HfezPAZXJlpFZI
	 peGFhkqf95gFhKXcYlRSNpT1EKfnyMFUijfurLJAEhD2UGQs2YoYK+PhY6EL12D8PI
	 7Tg8YaW9n8ayyum9JIDtCMdwB0re6GgucqKgCo9W6QOClTUP/DAnvvX5eXVin76FpC
	 sh0Ca9wDJF/hDWGciDBzODrEDpsc7cnT3CXzWgj52UFGRZ+6FU3uUK+ptRGr2cDbas
	 MLfcQuE6j/5M8dGUPmlBlhEBpFVSQgfgSa9HCnN9N1oU51vzT959awmIxdC106c2UN
	 ggo3TIUoWrkqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 123DEC39563;
	Fri, 27 Oct 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Fix 2 stray ethtool -S counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169837622607.18622.4343731152237624380.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 03:10:26 +0000
References: <20231026013231.53271-1-michael.chan@broadcom.com>
In-Reply-To: <20231026013231.53271-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
 ajit.khaparde@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 18:32:31 -0700 you wrote:
> The recent firmware interface change has added 2 counters in struct
> rx_port_stats_ext. This caused 2 stray ethtool counters to be
> displayed.
> 
> Since new counters are added from time to time, fix it so that the
> ethtool logic will only display up to the maximum known counters.
> These 2 counters are not used by production firmware yet.
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Fix 2 stray ethtool -S counters
    https://git.kernel.org/netdev/net-next/c/9cfe8cf5027b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



