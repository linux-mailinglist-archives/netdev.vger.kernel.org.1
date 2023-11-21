Return-Path: <netdev+bounces-49823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47F7F395C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FF61F22AE1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A8F4204B;
	Tue, 21 Nov 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIjUgw63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A513FED;
	Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85C1BC433C9;
	Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700606424;
	bh=JgXzXBcdw/xxhUYx9RjTOgLiSSE5qUg3lb9e/+H8kE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIjUgw63PfLKleuS/Pocr7mtZX2ua9oQ7TCQltUJXJ/qIOZTg2GLsJZ0t+yhMPAPt
	 NfaOHRJrl7t91JkmJKkgxygCtSjvTWx6HdXk7j6IFH1XIsQjVLbDBqG9IELYarN/EA
	 T3jaO31ej1enDGbRGFguA3ETFltmn2hk8htuGyuZRqSNGqw/GNtbhm3OgHGyYM900/
	 cgbvjB4cAyDH0sM+wAhXw5mGbfuJbA7jrjn2NAelKKSzieklW1tDi5Ngwpj1m6pOD+
	 Z5K9RStgFCf/FSvC9BW97nDEF3+LNmnaw2Ih//BRub6PGBeLPqYXN8gLBiUjc6CWGn
	 wVgG33bYDq4Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6964CC595D0;
	Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] net: usb: ax88179_178a: fix failed operations during
 ax88179_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170060642442.8112.7703368423240582165.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 22:40:24 +0000
References: <20231120120642.54334-1-jtornosm@redhat.com>
In-Reply-To: <20231120120642.54334-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, weihao.bj@ieisystem.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Nov 2023 13:06:29 +0100 you wrote:
> Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
> the following test cycle has been implemented:
>     - power on
>     - check logs
>     - shutdown
>     - after detecting the system shutdown, disconnect power
>     - after approximately 60 seconds of sleep, power is restored
> Running some cycles, sometimes error logs like this appear:
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to write reg index 0x0001: -19
>     kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0001: -19
>     ...
> These failed operation are happening during ax88179_reset execution, so
> the initialization could not be correct.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: usb: ax88179_178a: fix failed operations during ax88179_reset
    https://git.kernel.org/netdev/net/c/0739af07d1d9
  - [v2,2/2] net: usb: ax88179_178a: avoid two consecutive device resets
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



