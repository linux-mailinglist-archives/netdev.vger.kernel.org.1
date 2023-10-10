Return-Path: <netdev+bounces-39483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0887BF71B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA21C20A3C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6D171B3;
	Tue, 10 Oct 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryUbXkqM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31649EAF9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76611C433C9;
	Tue, 10 Oct 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696929623;
	bh=NerkXt+rZPAlIupXJbcBKtsX2t6qQ5YjxKM52f99KNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ryUbXkqMfY8RPPCD9gbx7vuqOtYjaTjR3sUkUgC00poq+dgxfJ+FMgUUZhYaqcffU
	 h3XQ2eiSDGxC3T/ewHsb4Sw5bjGAklxQho6BdCh80FsN1Ik42KLgJg+wxC+ezyy0BV
	 25fVHynjmGm+hwkcrxYq1pcioa7dUNQPxi3ra7NirkdGrGwk05eOtVQPIhQK0lqb72
	 QE+7Jeskx8SWefUSDyEUGMuqMVKiNBa1OTfyp2j85q0c9mhBQ9SVjnVxF0VCWwJAP9
	 MwiqKqu5lwo+Rz4DCPOJrgDbT6GHejW0soTw1Ilo0MgU8tXi8musx/Ne5iKkfTyVdI
	 3dnz4wRBEeSbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54698C595C5;
	Tue, 10 Oct 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: Fix uninitialized var in
 ksz9477_acl_move_entries()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169692962334.26090.2044433680478545315.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 09:20:23 +0000
References: <20231006115822.144152-1-o.rempel@pengutronix.de>
In-Reply-To: <20231006115822.144152-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 linux@armlinux.org.uk, dan.carpenter@linaro.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, petrm@nvidia.com, lukma@denx.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 13:58:22 +0200 you wrote:
> Address an issue in ksz9477_acl_move_entries() where, in the scenario
> (src_idx == dst_idx), ksz9477_validate_and_get_src_count() returns 0,
> leading to usage of uninitialized src_count and dst_count variables,
> which causes undesired behavior as it attempts to move ACL entries
> around.
> 
> Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ksz9477 switches")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: microchip: Fix uninitialized var in ksz9477_acl_move_entries()
    https://git.kernel.org/netdev/net-next/c/59fe651753fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



