Return-Path: <netdev+bounces-28305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1377EF78
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3547281D55
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9661638;
	Thu, 17 Aug 2023 03:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34736A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2ACCC433C9;
	Thu, 17 Aug 2023 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692242420;
	bh=p6lUxhyQUbyuIxDV6nWA70lZY3wzRKThzFrdN604Ng4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmx0kg/jkszFkuEp3LlYuNA6YDQfNKjZoN89rbsildmdXbTlofZ8zzoNhjyMYduPi
	 16uRTDDsQoO3c4bMrXJXZXoGf7z+W4pwr6JK6UEPwOllL4olsP8z8OZMRxG1WG2uzU
	 yTcBwavimjv2gI0gVjld+B/O2G4oOcJBL1co+Qg0f0rw5OBQi0vZwBT4g1UCmqtTCA
	 gwFBdNQQxlvb9M3l/1ZxJzm9sASKd1+zx7DsVdqxwERAE8GXM57Z/smyNRfeJ8Ovxm
	 cpBhOIy9zK03IOaN4a+GMzZbEdmeiQQP94CwQA5QWPyS6SGg4sSH6IPqxmHOrPndkW
	 Sqq3bsUIL0U7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4D34C395DF;
	Thu, 17 Aug 2023 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW
 reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169224242073.22058.9512114729208930656.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 03:20:20 +0000
References: <20230815001323.24739-1-l00g33k@gmail.com>
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
To: Alfred Lee <l00g33k@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sgarzare@redhat.com, AVKrasnov@sberdevices.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 17:13:23 -0700 you wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
    https://git.kernel.org/netdev/net/c/23d775f12dcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



