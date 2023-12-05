Return-Path: <netdev+bounces-54034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FC805B0C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC036281345
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4D692BB;
	Tue,  5 Dec 2023 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWOT32AM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210069280
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 17:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C717C433C8;
	Tue,  5 Dec 2023 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796826;
	bh=H3KZtBSZ/Y7IZExJ1XMvnf0C8QVYrYDG6bmeA/QsFY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GWOT32AMpkGzabfcEnFawwGtfWkRrz4gc0Yl859VUGbPcHVVcnI/lZ2xtm/uAOpvi
	 vPlD/WjjMyJIgQ31gnUBJT0hoacFazL+mOpX/+MH4n+yTP4S6DVVyYYOyMymeKY4Vr
	 pPychQHoLqnM1k64+dq0OgdLe9lnK4KNI9OteRT3VGPblDV/cA9BAU7wckLQITK5/8
	 oqBAFC3GuE4CAEKJRupAeWjFO55Bi8kTU0ETwk8lzCOik1M72YqS+KN+WQrZt+YC0O
	 Ag/KUrtJCc1hzpe5Q4djCbyTEBhLpuh+lCs9bzbViv2z/gH8t56fr0jk46PZD97zGO
	 ZldQFR+uRNBpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61B84C43170;
	Tue,  5 Dec 2023 17:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] sfc: Implement ndo_hwtstamp_(get|set)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170179682639.32274.15529514811167186143.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 17:20:26 +0000
References: <20231130135826.19018-1-alex.austin@amd.com>
In-Reply-To: <20231130135826.19018-1-alex.austin@amd.com>
To: Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 13:58:24 +0000 you wrote:
> Implement ndo_hwtstamp_get and ndo_hwtstamp_set for sfc and sfc-siena.
> 
> Alex Austin (2):
>   sfc: Implement ndo_hwtstamp_(get|set)
>   sfc-siena: Implement ndo_hwtstamp_(get|set)
> 
>  drivers/net/ethernet/sfc/ef10.c             |  4 +--
>  drivers/net/ethernet/sfc/efx.c              | 24 +++++++++++++----
>  drivers/net/ethernet/sfc/net_driver.h       |  2 +-
>  drivers/net/ethernet/sfc/ptp.c              | 30 ++++++++-------------
>  drivers/net/ethernet/sfc/ptp.h              |  7 +++--
>  drivers/net/ethernet/sfc/siena/efx.c        | 24 +++++++++++++----
>  drivers/net/ethernet/sfc/siena/net_driver.h |  2 +-
>  drivers/net/ethernet/sfc/siena/ptp.c        | 30 +++++++++------------
>  drivers/net/ethernet/sfc/siena/ptp.h        |  7 +++--
>  drivers/net/ethernet/sfc/siena/siena.c      |  2 +-
>  10 files changed, 76 insertions(+), 56 deletions(-)

Here is the summary with links:
  - [net-next,1/2] sfc: Implement ndo_hwtstamp_(get|set)
    https://git.kernel.org/netdev/net-next/c/1ac23674a971
  - [net-next,2/2] sfc-siena: Implement ndo_hwtstamp_(get|set)
    https://git.kernel.org/netdev/net-next/c/d82afc800c1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



