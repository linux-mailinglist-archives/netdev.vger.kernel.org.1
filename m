Return-Path: <netdev+bounces-131832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE498FAB3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B43283AC8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316F1D0B91;
	Thu,  3 Oct 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxw8MN9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FC1D0B90;
	Thu,  3 Oct 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998836; cv=none; b=H5hW6hHUrfV0QXoCCIT359MNx7I0xDKpPKIJfyWUN2s/b4o53xWnKXCNZutxkn1ywLeBuEc+apEZ8fwBUMaSfgZUM0ackmxE2SbfV5nMUsvpNdKeqXp3N23nH/BgTz+214SXcUhEv65owDJzX4n9qcdF16ArLYvMGsNZGCTVK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998836; c=relaxed/simple;
	bh=L937tdndjiR3fU0aVHRBXcEqJx6fA5/dFTyDTrR43lA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+VuNFUt+m1mVCHiZigtA7rg2bKafq3s92RMyRsbYzCgHbVMRV/bsFTF5XDo4VtBpl7M4ewZgliI2OB2g2NaFLyr1e3PiIGU8gJcK7RKp03LfqiiJ55b/HtTSKb8hZ5eC/7MLvrjuwt1Sd6s3YYpuvT8RBbSvpF9w6CGUdjVy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxw8MN9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C26C4CEC7;
	Thu,  3 Oct 2024 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727998835;
	bh=L937tdndjiR3fU0aVHRBXcEqJx6fA5/dFTyDTrR43lA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wxw8MN9ZkK2fENeXuEhj3DQwmGXLEhRzoORba+WKMA9fHFe7yg8iDJBY7qq5j4DtQ
	 s0/blE5pebpG5hcYOTGKfC4yAbw7hq2ydRHwk8kiXg5+kS2zoeYjHo94hYFZNzHtYs
	 DruWrbFMJLMGuJXDLnRf4lLv5Atp4V0wklSYcK2XMe5RyBeS7GefrW0co+lrva9RY8
	 HzNWc/wcpUdbXrd6OSxRe1BGqxO7nh1e0kkEWVBUM8LKXku5GZGOzB6TUe1TYxxRXz
	 vsrGAhIHFI2GmBQBkKqqRZQk7FYHdsSlvGsI1LIbRtiUvYdoV37DacIvXkFTiPDEFt
	 z0ahJ3XXSkZ+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDF3803263;
	Thu,  3 Oct 2024 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: microchip_t1: Interrupt support for
 lan887x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799883874.2030473.4805913584445830927.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:40:38 +0000
References: <20241001144421.6661-1-divya.koppera@microchip.com>
In-Reply-To: <20241001144421.6661-1-divya.koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kalesh-anakkur.purayil@broadcom.com, Parthiban.Veerasooran@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Oct 2024 20:14:21 +0530 you wrote:
> Add support for link up and link down interrupts in lan887x.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v1 -> v2
> - Replaced ret with rc return variable.
> - Moved interrupt APIs to proper place and removed forward declaration.
> - Removed redundant return variable declaration.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: microchip_t1: Interrupt support for lan887x
    https://git.kernel.org/netdev/net-next/c/5fad1c1a09ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



