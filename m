Return-Path: <netdev+bounces-49822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB137F395B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4B71C20E9A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426323BB2B;
	Tue, 21 Nov 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xupgcuot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24367584C8;
	Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAA1EC433D9;
	Tue, 21 Nov 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700606424;
	bh=BCqZvJQBa/wE6TafX7ndIlv2XcDSydEYgzFZ8mfueQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XupgcuotIa2srbEszQDG45/XAkGEU1Owo0a1PTXnu91iRoCHt4z/uxFVqO83ZS1MH
	 kcCulnq3sNCSoWgFv1V0tYyvdE9TCujTB8sBKhvS9SgcBmiseWsJPsFUK947V6/KHC
	 9PiIAcn8bsghK8DYiQSAHiChNpchrUVAw4oX1UOEEL0sR87iTu7AQHd2f6bCRKwyjc
	 YrNQ6tC6mPGW267Iz8yWfFhg4+ozEGLClCg2ru3bsVNGodprKV8dCBQ7Vw2+iaeUkP
	 HdXhklwj5Fne/e0OaOKFb8fym/6QRZ3qnj3BuMeufrNFGDICvv6oxP2nRk1Sn28ptr
	 esn6PTkHlvHLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A16FDC691E1;
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
 <170060642465.8112.10987867450533291011.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 22:40:24 +0000
References: <20231120120642.54334-1-jtornosm@redhat.com>
In-Reply-To: <20231120120642.54334-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, weihao.bj@ieisystem.com

Hello:

This series was applied to netdev/net-next.git (main)
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
    (no matching commit)
  - [v2,2/2] net: usb: ax88179_178a: avoid two consecutive device resets
    https://git.kernel.org/netdev/net-next/c/d2689b6a86b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



