Return-Path: <netdev+bounces-180177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE29DA7FE38
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD8C3A4C56
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36AF26A1DE;
	Tue,  8 Apr 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugd/oVQU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20E26A1D7;
	Tue,  8 Apr 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110003; cv=none; b=tNc1pxS2Ffd8sPt5gOXp7IBaFH0K6t8SFBp00e0eY23lK5mCrPXEJqnN3VUAsBT/uJj654y9CNAcdu9wcrAAXmnesGi5dXjWRAEzZu2oDz9TR2zoPU1jdsHo0rh4UCP4/0NSOtvaDZL7E9iJl7c5nQuAkZyWys3J4OgJNiOi8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110003; c=relaxed/simple;
	bh=nezKGRzA0eCRz4mrbu9nFXapNZPXTwoaOMKIo5c+Tcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fnKVOIqCYiUtisZd+rIvjm+9fQIfF9ORYVuCi/AP9Y9Q08RZirEMgIQg3gqEq1tKrINGey+z4/zf+bultb/6ZKZab3NdzTZZQzvtpls3qpP6EsAGDwD6ORHo5xyojQGtZK1OtBQKfudQLH4+dE8/i9z1Upy/+8vl65YX0lL+AFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugd/oVQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33287C4CEE5;
	Tue,  8 Apr 2025 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744110003;
	bh=nezKGRzA0eCRz4mrbu9nFXapNZPXTwoaOMKIo5c+Tcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ugd/oVQUYz1MuEFrKAVGBG4Jtf21jB17eo9lV47/m/xU671qAxPvTVBTcUs6tJG6a
	 /BG1OuGDMMSqePvNEo+pue5G3k14Lb6Sf/MKYRzSHRV2Yidu3MXV8fegLbp9rcwfMg
	 Gtc26hUeS3SAKOSViLcUSIAMAKnr2ONMNJptKBzfrDi0wiomEFpo0iFrNLYSveqhn+
	 ytB2cO9PNsMP0jw+iLWCMf2+vBiMV7JEA4AWa1CS46gF5N9UMK3ImvpwVVnZpY77I9
	 KrZ8xu08NpK4vLJ3NjwkDpms/O5J1/FYwjpgryjVakOCe62P8Dj/nBp5kohxhuuyHO
	 5C4kEjaq7cYRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2A538111D4;
	Tue,  8 Apr 2025 11:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: nfp: remove __get_unaligned_cpu32 from netronome drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174411004025.1874546.1538210583155348122.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 11:00:40 +0000
References: <20250407083306.1553921-1-julian@outer-limits.org>
In-Reply-To: <20250407083306.1553921-1-julian@outer-limits.org>
To: Julian Vetter <julian@outer-limits.org>
Cc: arnd@arndb.de, louis.peens@corigine.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shannon.nelson@amd.com, vladimir.oltean@nxp.com,
 akiyano@amazon.com, csander@purestorage.com, florian.fainelli@broadcom.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Apr 2025 10:33:06 +0200 you wrote:
> The __get_unaligned_cpu32 function is deprecated. So, replace it with
> the more generic get_unaligned and just cast the input parameter.
> 
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 2 +-
>  drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - eth: nfp: remove __get_unaligned_cpu32 from netronome drivers
    https://git.kernel.org/netdev/net-next/c/fc2e4f4f7b5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



