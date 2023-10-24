Return-Path: <netdev+bounces-43998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1887D5C9A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D115E1F22286
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85F27EE7;
	Tue, 24 Oct 2023 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/Fd3NjF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E761173A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CA5CC433C7;
	Tue, 24 Oct 2023 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698180623;
	bh=MQxUGg4WZh0GcHoAJTOTGgL6noaomPLGUE6jIUxFnpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/Fd3NjFUs8eR8lMB10IHGZnIOJr02axBdxw1hwxAaXI6QKq5h9x505fO/lWgt4WJ
	 ISQvP7UnmwQaEUNlrIiMTOeC0E8fODzT1yHY+D45d6WHHnlUqmkPDccMlLwrbzjSER
	 IewNT0ga3mUztl1oeI2xmjT+oa0NQEqmqL+97nLVmGNDGKRRnoFmRWgs2PAGSDa+4H
	 MButw4raRHeZwvoQTPuVpa3jGVq5HzXePEWIvtKesqrf7Acq+6jxcQ5vvbVDP/zX1b
	 SK7lsUZIFicAMxjhxoqDMGOJ1OBlb0mt8LsfFF1P9D/vBtllgAx4IFsLEw4AjCegpg
	 VUpWavIhrOzNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB6CDC00446;
	Tue, 24 Oct 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] Switch DSA to inclusive terminology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169818062289.18293.8593528479742060215.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 20:50:22 +0000
References: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 11:17:27 -0700 you wrote:
> One of the action items following Netconf'23 is to switch subsystems to
> use inclusive terminology. DSA has been making extensive use of the
> "master" and "slave" words which are now replaced by "conduit" and
> "user" respectively.
> 
> Changes in v7:
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] net: dsa: Use conduit and user terms
    https://git.kernel.org/netdev/net-next/c/6ca80638b90c
  - [net-next,v7,2/2] net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT
    https://git.kernel.org/netdev/net-next/c/87cd83714f30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



