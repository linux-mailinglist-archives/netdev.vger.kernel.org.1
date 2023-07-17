Return-Path: <netdev+bounces-18205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DB755C78
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564431C20A9D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625829449;
	Mon, 17 Jul 2023 07:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6F8BF4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7205EC43397;
	Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689577823;
	bh=FA4D+NiphNgtcehoQNL6NVhnONI6sZ1UVAoWYDdmFEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o8zBtY8oxHXd8Rza8oalEC+y3HBnxVT/y0/AFCs3qZZ7mFw1jOVK8MigCVrhVVB9d
	 JoF+UcGselilZKWlL/EIFQuDMocGxTvWKVviJ/4Ku59AuyYSlxOJvs61QkqwaO4OmG
	 F8G2LQbwt3yT6mWUf7JfZbHT34yICvdej6fN61Q42Fzm7sn70kLM4dwi3zIb1RSr53
	 SbEbU7H2RigvacZAfMI7ExhotF4OFdg+3sRq+kiO+SfIVZlhcmQ2Pj3mJtOfUEphYd
	 u8DAd2kX+FzouGj/JHJKsUq6yhZnqrbOMeSntO2Xyb+I/wjTHMyPVsWq/A7SIdo5hO
	 qwznYU69G4Opw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40CC3C59A4C;
	Mon, 17 Jul 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next resubmit] net: fec: Refactor: rename `adapter` to
 `fep`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168957782326.7157.15063018814601841800.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 07:10:23 +0000
References: <c68ee91e04144f0e8aa5569613a73fd3@prolan.hu>
In-Reply-To: <c68ee91e04144f0e8aa5569613a73fd3@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, davem@davemloft.net,
 a.fatoum@pengutronix.de, andrew@lunn.ch, Csokas.Bence@prolan.hu,
 kuba@kernel.org, maciej.fijalkowski@intel.com, kernel@pengutronix.de,
 simon.horman@corigine.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 11:09:33 +0000 you wrote:
> Rename local `struct fec_enet_private *adapter` to `fep` in `fec_ptp_gettime()` to match the rest of the driver
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [net-next,resubmit] net: fec: Refactor: rename `adapter` to `fep`
    https://git.kernel.org/netdev/net-next/c/f08469d0f664

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



