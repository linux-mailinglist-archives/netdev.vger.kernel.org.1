Return-Path: <netdev+bounces-53223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63C801A9B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF501C20B7A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6BBA34;
	Sat,  2 Dec 2023 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNlM0e1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC25BA22
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE448C43391;
	Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701490824;
	bh=PEMYclhCkQOsQjmYM/8h/waI+etEhpl8PV98QdlSbok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNlM0e1CY9ZJ4dpvZfaaE8w6Wk6ii1Pir0PMn4+B0mZRF34dT0ORMOsP5PzvG1C2H
	 +0v1oKaPsv1IFnhcpLZCeu91xOdkksWSm5tg4n9jTO5e23NdiOmJ8sdWsNRSif8/vG
	 OzgfnczCNtqxJDZGQGSFGUq/vzEbgvAlcXx1nmaQJZt3pCWFfsbTZ2xz8D7XNBDKE8
	 GEMohJuxgmadFoTVJ1Z9uYidM1dAO1Bg/ll5yUMefohjNQlLQTJ5qAzY+yYObvDgr7
	 zEQ4IcS1pwXL8hC7J1SOZAl8zZsBTY+mN9xnRlR4jgwG1B/0AK0unSIzHsj2Itykj+
	 pqh3vD8PZXAuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A91B6C59A4C;
	Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: debugfs: update CQ context fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170149082468.6898.10971138559604830624.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 04:20:24 +0000
References: <20231130060703.16769-1-gakula@marvell.com>
In-Reply-To: <20231130060703.16769-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 pbhagavatula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 11:37:03 +0530 you wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> This patch update the CQ structure fields to support the feature
> added in new silicons and also dump these fields in debugfs.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: debugfs: update CQ context fields
    https://git.kernel.org/netdev/net-next/c/4f09947abf24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



