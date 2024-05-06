Return-Path: <netdev+bounces-93684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844D8BCB7F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3E280E15
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DCD1422C5;
	Mon,  6 May 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyMkWz4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD34205F;
	Mon,  6 May 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989628; cv=none; b=loCYO4dVZ28eNFjm+b+8nYTfqc4zGaXSC5Rqoo2cwl9zs3/1G0DvnA8/S62zOPf3uKWVJ7ZpZ+/sikzQ1CAmT7PdDZT65hnvQr2N35yedGKhXVI2O7rOaOpIRTbwEYUQ0DJAAvX994W3nA/2Y22StYf5DwHIoJA6AS5QTsrr5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989628; c=relaxed/simple;
	bh=iNOxCJ7MlPjjXSp7oO333xc1yVh065WGFf1NQCW9o3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O7l2uCTNCKa5xtp8D0PNDC0EKyIw22rSYcc/BgScJcA5/5LnAvpr46SB6ThOxCounY8QoHKooIW1A+zEQUuLyZ0HNWA/jqWY6XgDW19DE8eovtODVQB+Y14Kyf9R5aTHhrO+/aeiU2fxD1sfXbFlGaCSkMhzSE5B9BLcnIWahF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyMkWz4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC75FC4AF63;
	Mon,  6 May 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714989627;
	bh=iNOxCJ7MlPjjXSp7oO333xc1yVh065WGFf1NQCW9o3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PyMkWz4WXmXvp5PrhQLHbYKWboa0pfShBktgKofA0c3ckP/KU7lEuds8BpauF5P4P
	 u0TFhXFlgM4SnA93pcymNpcJhst/PvP6vZrb/yL2cQt9K9P9r7gNd6fkyS8xX7T6IW
	 PGp2P1pdygrDqDO29o4ESI8xdv0BePKxMvJxNHSJYowf6cDi36r8uVas1hr/mJU4uv
	 33d85ifleSil0ghP5f7+8sXZtZlnORJ+aAXFvz0qfMV/jofKGPI8m332kTTnJIFAg3
	 qt4gAc7eNLxympIO2UK52j2UC9vny/FiGj/+Dzmz8V126lL1I7RrK5aIS4Ot0uNco5
	 0Mpb63Nudd0MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB085C43333;
	Mon,  6 May 2024 10:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout on HW
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171498962776.22093.11518903909371107429.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 10:00:27 +0000
References: <20240502050300.38689-1-rengarajan.s@microchip.com>
In-Reply-To: <20240502050300.38689-1-rengarajan.s@microchip.com>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 May 2024 10:33:00 +0530 you wrote:
> The PTP_CMD_CTL is a self clearing register which controls the PTP clock
> values. In the current implementation driver waits for a duration of 20
> sec in case of HW failure to clear the PTP_CMD_CTL register bit. This
> timeout of 20 sec is very long to recognize a HW failure, as it is
> typically cleared in one clock(<16ns). Hence reducing the timeout to 1 sec
> would be sufficient to conclude if there is any HW failure observed. The
> usleep_range will sleep somewhere between 1 msec to 20 msec for each
> iteration. By setting the PTP_CMD_CTL_TIMEOUT_CNT to 50 the max timeout
> is extended to 1 sec.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: microchip: lan743x: Reduce PTP timeout on HW failure
    https://git.kernel.org/netdev/net-next/c/b1de3c0df7ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



