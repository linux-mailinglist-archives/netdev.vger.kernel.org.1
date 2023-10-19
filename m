Return-Path: <netdev+bounces-42566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37A7CF559
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E891FB20DE7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0AD2E7;
	Thu, 19 Oct 2023 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS7usoPG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FB18B0D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C948C433CB;
	Thu, 19 Oct 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697711423;
	bh=ISlzwNBz4S/jH+y76V1s9eoZT46G5gS6n3EopdgQWHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MS7usoPGfOXtFgpfdTA4GpSCDCKwDC2R+9mnJT0e3cISZPXFPK8kFSxrbYKmZDQJy
	 x1t4PYCaUCYoh1mdWlO2za66uoHDtV0qEkYR+h5ynkiCbVv8HHgB7DBIe6tKs5TUP5
	 Or6bJeHYQ+fEZuUjC1iNcEN+huiuJcmH9j0R6NcxcyDNCbLQfuwXwsUTFS3NZhQCW1
	 TJWyV6/FhXtxRP0rfhTqdVhSH9IQTE1YJ97Hz1yqyGtM5I0RPSBwDIEablfKGrQZB9
	 TlJnDwH8ZaS4efuYH+BuXpr5F/3D4h7m00/3Mux7Bv0SjxXVAg8ufvMzr2V+4mKdzF
	 4rRqsIp945Ivw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51100C73FE1;
	Thu, 19 Oct 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Remove redundant checking for
 rx_coalesce_usecs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169771142332.4277.11760009172331855104.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 10:30:23 +0000
References: <20231018030802.741923-1-yi.fang.gan@intel.com>
In-Reply-To: <20231018030802.741923-1-yi.fang.gan@intel.com>
To: Gan@codeaurora.org, Yi Fang <yi.fang.gan@intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 hong.aun.looi@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 11:08:02 +0800 you wrote:
> From: Gan Yi Fang <yi.fang.gan@intel.com>
> 
> The datatype of rx_coalesce_usecs is u32, always larger or equal to zero.
> Previous checking does not include value 0, this patch removes the
> checking to handle the value 0. This change in behaviour making the
> value of 0 cause an error is not a problem because 0 is out of
> range of rx_coalesce_usecs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: stmmac: Remove redundant checking for rx_coalesce_usecs
    https://git.kernel.org/netdev/net-next/c/392c226cda94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



