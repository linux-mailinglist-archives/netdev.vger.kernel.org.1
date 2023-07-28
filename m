Return-Path: <netdev+bounces-22100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC367660EA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A901282544
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534715D1;
	Fri, 28 Jul 2023 00:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823077F0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4C7C433CA;
	Fri, 28 Jul 2023 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690505421;
	bh=4AjQyKL+zG68s9MzibTuzkf4ca93khV7HEeIRie39T0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k0p5bX7mabSuFRfvEWxyMZ5Ship3L7bKxsCUb9sAhX34yVhiHAsfOZ30oKS64zIo7
	 CxZJnq8BECz7BdagkOP17lzYSQ/zlZ2lop+DCcKrtJ/mavZ2ZGY9hhFH+LsLdbYws7
	 3W2e6UTN2/586nzN+dut75IYcYYY9uV4eBDjvemJC9ddW8fylSSFq+DtuxRTDtBafE
	 uXVMfj7wWKoiD+S8J+1SbQGoa0RVD3tKTHD884WuIrOSqIjlJpSQMMhgEZSg3zPkzp
	 e5ZlsWJvDwn9j/fzWprMktBmZLJlpoAGQ5r1KRfy5o1mwYk5y2Il9Z1lClTE0g72co
	 cHhIug4Fk04sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1037C40C5E;
	Fri, 28 Jul 2023 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050542178.6763.13016811942986577216.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:50:21 +0000
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 15:45:16 +0100 you wrote:
> Older DSA drivers that do not provide an dsa_ops adjust_link method end
> up using phylink. Unfortunately, a recent phylink change that requires
> its supported_interfaces bitmap to be filled breaks these drivers
> because the bitmap remains empty.
> 
> Rather than fixing each driver individually, fix it in the core code so
> we have a sensible set of defaults.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: fix older DSA drivers using phylink
    https://git.kernel.org/netdev/net/c/9945c1fb03a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



