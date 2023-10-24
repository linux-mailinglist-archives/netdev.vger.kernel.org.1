Return-Path: <netdev+bounces-43763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807357D49D7
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E39F1C20A16
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D61BDE8;
	Tue, 24 Oct 2023 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI2aSFOY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD851BDC8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42BCC433C9;
	Tue, 24 Oct 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698135622;
	bh=fhZWBcd8MPqGRAu4Llwdr124i7u6xR3+iaR9nSkzKhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aI2aSFOYgTu6Q3sgv1bH7lMa1jc+Bluf942vf2+y1fOfTueZP/7dfRhK5ZARsaoLz
	 Wv5kmDLN6cbEUHr8kpr3tvGNBqYBPGHFgv319OAgwVLWcAS6PFkZq6Z+8UQagTANyU
	 549N1h6SE9RUNeAPsvhUcKHy936x+KnHF8tdUgRfgMb/QjfTmGjesRHBYYPHRSNk/j
	 tSmXa+KP6hebDjw3nKEuqDoz1pHo/E3GjyTLD9jyicPGTkZUqISUyO/r38RZinZwS4
	 x0MBf6kH52cHg/WSIjhWQT7PuRXOxJPTE6sDQX5FbJ2jYDCtjqnYczTrLoXdhksm10
	 39CtCPiLPlg1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB5EC595C3;
	Tue, 24 Oct 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: microchip: lan743x: improve throughput with
 rx timestamp config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169813562269.30900.16324458745146490166.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 08:20:22 +0000
References: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
In-Reply-To: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, kuba@kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Oct 2023 00:28:01 +0530 you wrote:
> Currently all RX frames are timestamped which results in a performance
> penalty when timestamping is not needed.  The default is now being
> changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
> support has been added to allow changing the desired RX timestamping
> mode (HWTSTAMP_FILTER_ALL -  which was the previous setting and
> HWTSTAMP_FILTER_PTP_V2_EVENT are now supported) using
> SIOCSHWTSTAMP. All settings were tested using the hwstamp_ctl application.
> It is also noted that ptp4l, when started, preconfigures the device to
> timestamp using HWTSTAMP_FILTER_PTP_V2_EVENT, so this driver continues
> to work properly "out of the box".
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: microchip: lan743x: improve throughput with rx timestamp config
    https://git.kernel.org/netdev/net-next/c/169e0a5e4320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



