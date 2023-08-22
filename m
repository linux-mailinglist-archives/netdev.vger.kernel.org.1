Return-Path: <netdev+bounces-29747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ECB7848ED
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D612811DC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4B1DDE3;
	Tue, 22 Aug 2023 18:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD81DA5F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DFD9C43391;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727224;
	bh=yxiiLHiKyP2X6cLvUIl2LQxUUBgjHd5nokY/VVIKQ3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwzrttZVDHg1lWDqfOcv+fxmQkiEYT50cBzY007zpAl/lsbEN3w03ECN23C2Gk/Mt
	 67gyfKoTGwMqzRCDex4SkLNrd2Ui/kNg/t688vOfS2b1SOsIAW7CopezWqOLviV4oT
	 ItqCg+nZggQ17VFHQC427Oe4WLkzF8c4i5XIBc7TIFUWE/nApRlVGnLiTrkTpNyzdc
	 DcsK+SKvnyMMRxfAQjY2qJ9f8SyyAiS7KOHdH26FpAF3bOtLzMQbbi+ls3p9txh1CP
	 YmuIA6+vl4pAneRiQHuBXoxSWdju/CvdRxkYol59Bu7Hb784z/l2EpdaVJ1TAd4dI6
	 ldObUhnIetfwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81CB9E21EE2;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mscc: ocelot: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272722452.9690.3212363558579999577.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:00:24 +0000
References: <20230821130218.19096-1-yuehaibing@huawei.com>
In-Reply-To: <20230821130218.19096-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 colin.foster@in-advantage.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:02:18 +0800 you wrote:
> Commit 6c30384eb1de ("net: mscc: ocelot: register devlink ports")
> declared but never implemented ocelot_devlink_init() and
> ocelot_devlink_teardown().
> Commit 2096805497e2 ("net: mscc: ocelot: automatically detect VCAP constants")
> declared but never implemented ocelot_detect_vcap_constants().
> Commit 403ffc2c34de ("net: mscc: ocelot: add support for preemptible traffic classes")
> declared but never implemented ocelot_port_update_preemptible_tcs().
> 
> [...]

Here is the summary with links:
  - [net-next] net: mscc: ocelot: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/49e62a0462a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



