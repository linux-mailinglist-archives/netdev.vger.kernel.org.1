Return-Path: <netdev+bounces-53217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E58801A59
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E831F2113C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D698C16;
	Sat,  2 Dec 2023 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZtqaapI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E58C06;
	Sat,  2 Dec 2023 04:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F341C433C9;
	Sat,  2 Dec 2023 04:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701489628;
	bh=dmTVe7Jfk5XVaQr11+fG5u2ls/Otpzli4MRTijejyj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZtqaapIqszXORqal74nOxtsifAPTl1E24zpUzeiY5QgC7x9LqlAdDgw+Jl8KLggr
	 WbID3pVP2kOg9PXHRUBo3ZYbNyrG4Y73rjfC8IfPGRqryqOCwXjSSAksRNE2Gq+6X4
	 bAGa+7dG1qOYmVtLMDmwUqIRn+4f5leZPFPi4/9AFiprUFQLo6kLxyaZk9YIjo2IbS
	 PpG+KaOHehA2grjZYkbLkVnVpQEJzpDVkOsVjvzu8BcVgsyGFdlKjUTAx0EAu1v629
	 Fi3JktkLqIf5oWzTI6fmK2iVTShkdEhLjelsKnL55QAwuoTJ9Og4Ngw9mmB0KrZmzj
	 zJnME/YRUpsmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FE3EDFAA84;
	Sat,  2 Dec 2023 04:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: networking: add missing PLCA messages
 from the message list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170148962811.21400.18267093303639323876.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 04:00:28 +0000
References: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, corbet@lwn.net, piergiorgio.beruto@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 20:13:59 +0100 you wrote:
> Physical Layer Collision Avoidance messages are correctly documented but
> were left-out of the global list of ethnl messages, add them to the
> list.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [net-next] Documentation: networking: add missing PLCA messages from the message list
    https://git.kernel.org/netdev/net-next/c/cc124ad39288

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



