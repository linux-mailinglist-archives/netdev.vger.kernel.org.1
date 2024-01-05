Return-Path: <netdev+bounces-61738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95924824C49
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838F31C21F6E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70D626;
	Fri,  5 Jan 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL66TcCE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15666185B
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB3C6C433C7;
	Fri,  5 Jan 2024 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704416425;
	bh=W0QiAwj/eT7TxCT/oaZzYDJQRYiOuDYvuGH0aI5bAIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GL66TcCEez5/ZCUkJOLej6WhlXmLbkohH41el2Eg3mBLBJGtpYnSpwxYFqDaGfryx
	 N1/McA+6N3jur06HuKdmugN96pwshgriGtAE0NLCqRx71/SBnWLXaGVrnD0sjUReHy
	 4UMVf08gMMiuGpU0ztsYUR9TA+ZJ99bMRtRtCygvXWxQ7KrxLzbhdrEwXps6oJBljT
	 Hj/VA6lJ+CTEYrSKYpNRUGFwOaqFrNRUM8txXz2UvVX0INRAF8lCh0cUsnL7fmZtuG
	 xDg00h5YKsL4CKBxcETiIUW1saQIjHXiyT1PNy7T7j4MKGL/MX2zYLtwn8zfPfwlfm
	 74RGhHce2+8vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1150C43168;
	Fri,  5 Jan 2024 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: allow phy-mode = "1000base-x"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170441642578.24287.16232158778513004233.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 01:00:25 +0000
References: <20240103113445.3892971-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240103113445.3892971-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, Senatore@fs-net.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jan 2024 13:34:45 +0200 you wrote:
> The driver code proper is handled by the lynx_pcs. The enetc just needs
> to populate phylink's supported_interfaces array, and return true for
> this phy-mode in enetc_port_has_pcs(), such that it creates an internal
> MDIO bus through which the Lynx PCS registers are accessed.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: enetc: allow phy-mode = "1000base-x"
    https://git.kernel.org/netdev/net-next/c/14d0681b3ae2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



