Return-Path: <netdev+bounces-56665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB381067C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3852A1F2131E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2670E394;
	Wed, 13 Dec 2023 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4uanzp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4E375
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81680C433C9;
	Wed, 13 Dec 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702427423;
	bh=LUlMJBR5mggwxL69y8+9nF1dcZlohJWk+9gPPfg9zmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V4uanzp8GYWP78RqswSOTEu7hUpJD8PPj1qZ4bO17wtEsMuw9MaNaph6fnRkBQL9G
	 tavR4RURhv6jYm7KQ1emxRf2WinDwEYiywUpL4pGwTvrc5/6p+UPrnPHmo8fTBYmNh
	 eU6EvswjKdUdMU/QxQns7sYoJUudLEPucYA1Y/MyphZ2Hi4dzbffW8bziCitkjvS9H
	 0gnW+M8LEhlQtXMSNHzUTAfTUiUsuSQ2wSV5hGHcw3meIdgY0JI7tIAHun7mg+rL1T
	 NN9Dos/a+zQcW4xWTsJlQAsg7yyxT2l7jTvpMELizj4yFFMQyjS6CMrAPm+KqhQuI0
	 +T1kDVDsCYu5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A3EDFC907;
	Wed, 13 Dec 2023 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] dpll: sanitize possible null pointer dereference in
 dpll_pin_parent_pin_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242742341.9113.5143294970110464218.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:30:23 +0000
References: <20231211083758.1082853-1-jiri@resnulli.us>
In-Reply-To: <20231211083758.1082853-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, gregkh@linuxfoundation.org,
 hdthky0@gmail.com, michal.michalik@intel.com, milena.olech@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 09:37:58 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> User may not pass DPLL_A_PIN_STATE attribute in the pin set operation
> message. Sanitize that by checking if the attr pointer is not null
> and process the passed state attribute value only in that case.
> 
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] dpll: sanitize possible null pointer dereference in dpll_pin_parent_pin_set()
    https://git.kernel.org/netdev/net/c/65c95f78917e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



