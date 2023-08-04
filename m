Return-Path: <netdev+bounces-24331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD4A76FCED
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E76428207A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A8947F;
	Fri,  4 Aug 2023 09:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E48F62
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15612C433C8;
	Fri,  4 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691140222;
	bh=ElrTr0KImreqshMP4TKsA/38QJgKf1pDIAjqzXeEBnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AS/C1L/lErzkSX8TSf7vKA/PVXhpZ7bzm5HDC2ILi0kOEHjdQHkhhtRW7eWYXQoL2
	 g2uZiGndTFXx1PfS8AtsRUQXFfxVjezevZdcvueNAuGtwTwm8wyrRf3H29qNd4U3ie
	 mDk7szWkOEwLefVCN4w6RM4S4dYShONzuWcClUsPuxGHOoz6emkPJ5wLzkpgfZKDQn
	 RPn9uEtH27wkmduTJj7T265adwwx7Tz06g3ERszrVfC1ccXJIQt+l3EpBzspACZygP
	 ZtjSRM/k1Vu5CllNZiJ/Q5/xR5X3/BOW+vFVUJMfRGXO8y5zwe6AdIYc4+NB9YTuF1
	 NUQHGArCQYDLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEF26C43168;
	Fri,  4 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] fix at803x wol setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169114022197.4386.8349205349314347060.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 09:10:21 +0000
References: <20230802191347.6886-1-leoyang.li@nxp.com>
In-Reply-To: <20230802191347.6886-1-leoyang.li@nxp.com>
To: Li Yang <leoyang.li@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, kuba@kernel.org, mail@david-bauer.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 14:13:45 -0500 you wrote:
> v3:
>   Break long lines
>   Add back error checking of phy_read
> 
> v4:
>   Disable WoL in 1588 register for AR8031 in probe
> 
> [...]

Here is the summary with links:
  - [v4,1/2] net: phy: at803x: fix the wol setting functions
    https://git.kernel.org/netdev/net/c/e58f30246c35
  - [v4,2/2] net: phy: at803x: remove set/get wol callbacks for AR8032
    https://git.kernel.org/netdev/net/c/d7791cec2304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



