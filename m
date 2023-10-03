Return-Path: <netdev+bounces-37645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BC7B66F7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 107231C20756
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513120B18;
	Tue,  3 Oct 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0D1548D
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41886C433C9;
	Tue,  3 Oct 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696330824;
	bh=dIPlgC9gvoPIUme9b8IduCTPIX8de21NRrrzF7KCkwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=apy7cArLeTPoV/Joj3xtri9A5FiocXGzCRCI9fQQGIi0wnV4MTVGx0QzeVDedqWjm
	 /EyvXRbU700A0owDYI1ehOgA0Ox1vNC2I+02PLukQbP5NET/bm3plOth+G7HkLe/lO
	 m88TqZas38VZt0Hr7TE3lTagC9NczFRfdzmRv4RqRGSY7zp+N2Kgc5gqCVALRz81sg
	 mL5S0uUc3m9VW5gxbo4526+1knL/o95UXtO0E0tK+/2lF8+S0uL2ByNglNUBwG0B51
	 wJCxJGQfeE5qGs9o1DjCoqlzBugxv4n40pvMcczYsjSD8CAHdqUujIN/pwU1Rw1F5C
	 kxV+/+MmIKtCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27760E632D2;
	Tue,  3 Oct 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V1] net: sfp: add quirk for FS's 2.5G copper SFP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169633082415.2756.5864136564250245678.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 11:00:24 +0000
References: <20230925080059.266240-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20230925080059.266240-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, Jose.Abreu@synopsys.com,
 linux@armlinux.org.uk, hkallweit1@gmail.com, UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Sep 2023 13:30:59 +0530 you wrote:
> Add a quirk for a copper SFP that identifies itself as "FS" "SFP-2.5G-T".
> This module's PHY is inaccessible, and can only run at 2500base-X with the
> host without negotiation. Add a quirk to enable the 2500base-X interface mode
> with 2500base-T support and disable auto negotiation.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V1] net: sfp: add quirk for FS's 2.5G copper SFP
    https://git.kernel.org/netdev/net-next/c/e27aca3760c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



