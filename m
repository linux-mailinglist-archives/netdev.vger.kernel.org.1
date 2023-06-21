Return-Path: <netdev+bounces-12463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA457379D3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BE1280E2C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628626FA9;
	Wed, 21 Jun 2023 03:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7023CB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C94C4339A;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=5gTtOrQ7jIdE7Jfqb/CAc47MksZY0gHEsCCzq5fyggI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RJUC2yi4+7/S0IHf2t6/l4SfNPTjhVXW0PO5626Cb/vQjizNkcrnXUM9DzAljPSaV
	 1436cMeBdSAZn+xIO0BtmqgyFN1EOsJ/0/0K0rKk750Q6MHcGFJkJvHf/Caa7+B9Kh
	 A1nMDMXfulrteMAOSzIYJWglmFVcRiurs7iGdrgMO5ZCFMLx0ZjqEE2GDKFqrWCpjW
	 cL1Z+gLShk90dYUfi7zzcisks3jTqGt0T7Kzzp7ckqveDN6xajP1y3r5RwE85XPRQf
	 5YlgO4sCMKfvlga4+3Nj66ZRFp3UdMtvQA1B+UjsnaBJIT/ON0G6S4ctplP/Klnj5q
	 W8PEPuiYRRDQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E686E2A035;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: phy-c45: Fix genphy_c45_ethtool_set_eee
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882224.8371.10249351032813840219.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619220332.4038924-1-andrew@lunn.ch>
In-Reply-To: <20230619220332.4038924-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 00:03:32 +0200 you wrote:
> The text has been cut/paste from genphy_c45_ethtool_get_eee but not
> changed to reflect it performs set.
> 
> Additionally, extend the comment. This function implements the logic
> that eee_enabled has global control over EEE. When eee_enabled is
> false, no link modes will be advertised, and as a result, the MAC
> should not transmit LPI.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: phy-c45: Fix genphy_c45_ethtool_set_eee description
    https://git.kernel.org/netdev/net-next/c/b7c31ccd60d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



