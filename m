Return-Path: <netdev+bounces-62560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A917827D5D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41022284733
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD32906;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsSTPCpn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F896106;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D677C43394;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704771025;
	bh=2yueIop7bwsy2T10kDMF6s/H/q67R75wn6DSltMFEqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hsSTPCpnHgRuKoOIqrzR2IFDBn2HeIQKLFQoTtSKhlT0vSdsRiHyBXLAGQQeSW0eo
	 nHT6/8Q21i/ateunmv81LI6rA4yt6nr3eMsN6TZafJQCAFRI4BAU8xjPd8AK+Sp/9n
	 OhU92U+v9I9shlm74lNBo6aX0arjchPZ4aMBefMHOjU1IORP0aZldrj2MvQTTWeFQe
	 tmxAwpo44W4c7Hd00/MM9wtyGDpZfj0iw7pSNPoXinD3rupMGWyElvY4QzFVlgFQDd
	 zMvmb/CZogkvsOXOOIHKtt1ZJ2QhIq9NIWLHFfCl5ojiXIAqmT9ic1NqpbO+pOk8fr
	 +7aVkBCWfv5RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7B75D8C977;
	Tue,  9 Jan 2024 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] lan78xx: remove redundant statement in
 lan78xx_get_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170477102494.11770.11837169175747617857.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 03:30:24 +0000
References: <b086b296-0a1b-42d4-8e2b-ef6682598185@gmail.com>
In-Reply-To: <b086b296-0a1b-42d4-8e2b-ef6682598185@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, andrew@lunn.ch, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Jan 2024 23:21:52 +0100 you wrote:
> eee_active is set by phy_ethtool_get_eee() already, using the same
> logic plus an additional check against link speed/duplex values.
> See genphy_c45_eee_is_active() for details.
> So we can remove this line.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] lan78xx: remove redundant statement in lan78xx_get_eee
    https://git.kernel.org/netdev/net-next/c/9b0f51097147

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



