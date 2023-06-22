Return-Path: <netdev+bounces-13014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D625739D93
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF22814E4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA63AAB4;
	Thu, 22 Jun 2023 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579C5676
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D1EC433CA;
	Thu, 22 Jun 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687426820;
	bh=ufbnZe7Ld3Hls25KBbaJXsFu1DmFhGZkThJF6gd87qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gmOsq1+56Z4wMtvgA5JrZEWiEamF2NBoR4nLHBQexWVc1iTNtfvFW1sNcj4NvL7gC
	 FPQ0YW7iMjZTZR9Q8f6/W3vKQC6kNaOrif0eDZ59MAp5e6lCLw/8+hEPDDPDz7ZV46
	 u9s5JqgmMFit/pVW2FBw0Moa5m6UCbgyhBcK6FPfgFJAfM8abGM2JSkvE+4j3xVQrO
	 5piZCdzWdjCjQD+zLRedRK8wvkviVEovl8E2u1ZXVflfXLnec6QudzEY35g7NqSnGt
	 WxXWRL524bTqInCxcN/2LXC8VWW5ijU4PlFxTqe8Od1pNtuFGaCjlIZLMenGsI+lni
	 zzTgq+VMphouw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FBC9C691EF;
	Thu, 22 Jun 2023 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: iosm: Convert single instance struct member to
 flexible array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168742682025.2644.13888689959448952935.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 09:40:20 +0000
References: <20230620194234.never.023-kees@kernel.org>
In-Reply-To: <20230620194234.never.023-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: m.chetan.kumar@intel.com, flokli@flokli.de, bagasdotme@gmail.com,
 linuxwwan@intel.com, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gustavoars@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jun 2023 12:42:38 -0700 you wrote:
> struct mux_adth actually ends with multiple struct mux_adth_dg members.
> This is seen both in the comments about the member:
> 
> /**
>  * struct mux_adth - Structure of the Aggregated Datagram Table Header.
>  ...
>  * @dg:		datagramm table with variable length
>  */
> 
> [...]

Here is the summary with links:
  - net: wwan: iosm: Convert single instance struct member to flexible array
    https://git.kernel.org/netdev/net/c/dec24b3b3394

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



