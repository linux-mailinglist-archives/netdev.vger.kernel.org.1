Return-Path: <netdev+bounces-42576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C47CF63C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A98281E56
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55718C0A;
	Thu, 19 Oct 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUHwUD67"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F053179B7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D1E5C433C9;
	Thu, 19 Oct 2023 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697713823;
	bh=x7Vilo7RVB7QrsjGzn3PXT/f0rYR4arJfWxCuscoZPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YUHwUD67GFqAZErgK2PsBHJHYFywVrz/3RhS5IEsXOBhnpObUjzKkvLNaOtp5U8PH
	 5qV3dkDsiIpjPosl+ExsOGjAv02lBzl4rktcyBzrsmY1Dl5kJxigayP0/hAT9RWXi7
	 +TlrgPH+Esr+o2otftIZx/jLKIHWDA1SrvmBGIHJ4mXfsjRxjSnkjhDOdHV20U/0mp
	 J1YqNXbDq9DlnhU/kJ5cgBZHJyDbQKjvQzUeenAlUsM49LAXf+23EbAJZQ1CbMiA5f
	 HY2r6vjAYmxKQUa80Lf+8GBRqZqYErF5gH/DG16bghgwzikGuY0d1bPVQdd4dgvLK+
	 Wvt7h5lnXul0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E8FAC595CE;
	Thu, 19 Oct 2023 11:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: stmmac: use correct PPS input
 indexing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169771382351.28433.15969551932352859252.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 11:10:23 +0000
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com, kurt@linutronix.de,
 patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, vee.khee.wong@linux.intel.com, tee.min.tan@intel.com,
 rmk+kernel@armlinux.org.uk, bartosz.golaszewski@linaro.org,
 ahalaney@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Oct 2023 09:09:52 +0200 you wrote:
> The stmmac can have 0 to 4 auxiliary snapshot in channels, which can be
> used for capturing external triggers with respect to the eqos PTP timer.
> 
> Previously when enabling the auxiliary snapshot, an invalid request was
> written to the hardware register, except for the Intel variant of this
> driver, where the only snapshot available was hardcoded.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: stmmac: simplify debug message on stmmac_enable()
    https://git.kernel.org/netdev/net-next/c/3fba82343955
  - [net-next,v2,2/5] net: stmmac: use correct PPS capture input index
    https://git.kernel.org/netdev/net-next/c/7e62ac24b57a
  - [net-next,v2,3/5] net: stmmac: intel: remove unnecessary field struct plat_stmmacenet_data::ext_snapshot_num
    https://git.kernel.org/netdev/net-next/c/1dbfe73bd648
  - [net-next,v2,4/5] net: stmmac: ptp: stmmac_enable(): move change of plat->flags into mutex
    https://git.kernel.org/netdev/net-next/c/7d3077482578
  - [net-next,v2,5/5] net: stmmac: do not silently change auxiliary snapshot capture channel
    https://git.kernel.org/netdev/net-next/c/2ddd05d1d5ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



