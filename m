Return-Path: <netdev+bounces-41612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07B7CB719
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC417281623
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73FE3AC09;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5Ef6oGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA738FB1;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E746C43395;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697499625;
	bh=e7qgiujjUVa5yHpuG+b1NZk2F8mymAlM6GQvCqMJAV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m5Ef6oGLnfHHPgFWyY4S1XxZP5p6jM5aLF44CzW4HJlmcNFwN+pVqG2sSAOYPJwGN
	 CW8/GYBaNh1y4/Z4VG2bMye2peKektfi8a0o+I95imifDTHvxBbztu4qR2HnHc3+WY
	 A2XsBXc9Qp2/sQHUvUoYuSyhJj4dol3BfVkNy5wd9xzM+CbxSRChr269Z00lilIxmZ
	 LpuZmTTCU6H1V3S7krWAv9yxuj78EtreRxxEU4yFEtZLA9g/m22EZLjfW8FCyQ/RCg
	 jNdEYZgHSuL0jH/OMvB+IrFf1jaQYDrRnkUL7eMpvEMaTVRnUDbbFIkZcbIpaiekAA
	 evaaTQHvXEyew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3561AC04E32;
	Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749962521.28594.9573819095136256613.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012-strncpy-drivers-net-usb-sr9800-c-v1-1-5540832c8ec2@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-usb-sr9800-c-v1-1-5540832c8ec2@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 22:33:34 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Other implementations of .*get_drvinfo use strscpy so this patch brings
> sr_get_drvinfo() in line as well:
> 
> [...]

Here is the summary with links:
  - net: usb: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/1cfce8261d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



