Return-Path: <netdev+bounces-39417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5A7BF11B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAA281D91
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440188F63;
	Tue, 10 Oct 2023 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klRtq/dA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8D1C06;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B949FC433A9;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=EeLf/BSDH3FguVNAD/id6IC30XdWEcWyl9KuPVMXqsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klRtq/dArl66N9Hu0gw19UsoQKYbxJQVfYkdxHSS/2WSQb8C5+iVfmQ3qiqWHQcA8
	 THsFTzQSgDrxlbe/AG/RzR1DQl6IelQ9Sd37iONMIcYALM53pD35jgAlbR+sU2ZzDI
	 m5HK0dQ3CRrE4e1Xa119k5t5YD9zP6ykWoDiCWrjf3TguFH7XgSJwbaPMcikpAjiZM
	 d6ufdEkEv2C9+/cYWGGm9q/f976JKlfrTFfh8EAF3OGy1mfq+3xu7sTw3F9f6ulx+q
	 YtmTqOyDllcYLGFt7er0hzKVe91gsrKQMtJ+mV+ZR82TIYT0qJmBev3FEH4tu8Ms3J
	 W+IW/FlDnhCGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98AF3E0009B;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: liquidio: replace deprecated strncpy with strscpy_pad
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622562.548.12764552380663468970.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_main-c-v1-1-663e3f1d8f99@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 21:41:01 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know `fw_type` must be NUL-terminated based on use here:
> |       static bool fw_type_is_auto(void)
> |       {
> |       	return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
> |       		       sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
> |       }
> ...and here
> |       module_param_string(fw_type, fw_type, sizeof(fw_type), 0444);
> 
> [...]

Here is the summary with links:
  - net: liquidio: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/092b0be65032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



