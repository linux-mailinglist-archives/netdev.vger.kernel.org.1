Return-Path: <netdev+bounces-158241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2AA11365
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AFE188A5CA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A21CDFC1;
	Tue, 14 Jan 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKmBrfVs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65026AC3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891413; cv=none; b=jswE47Zfg+g9kZguHdY6YB7WaJh0RdwdWB55rI84SUde3S/BGOxnGgpFYNq8aSTRGoZGLnY7jasiZ+Qnv7YQR3bMuKs5CjTo320PcipSYUCq4DCjQJjHzAoaOndaG8YIhar+qqIKKoktj5Jvrcn3sKSSh64YEI1wYOPm/lyKSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891413; c=relaxed/simple;
	bh=c62X6Lxfoj2f5TfKrhdxhpys1UFRLa0Bk9h2OW5hzc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bx/g83q/XwP9FhzL+b9giD5DC1XzOmF3+eZssNMNMlp1Sa+RJ5qJDiev+D2JwiM1aXWnHxgf9f847Ia5jg3X/VCzylOgHeYsrx/YR3YR1DwWqNWMfD2Qper3pZyBEk3vWM+CI7NqjuVemNOJl5wjh356k7rd9DZVF2xrxR08cZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKmBrfVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33006C4CEDD;
	Tue, 14 Jan 2025 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736891413;
	bh=c62X6Lxfoj2f5TfKrhdxhpys1UFRLa0Bk9h2OW5hzc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kKmBrfVsgj+LfTY39yrx3Nk3Nd8zpaCvKlya4uYUpREszuF9+5bdWFV2ms0XWTJUY
	 0/aeevAkIYslMcTwLtQQMmbnqgdpCGFIWJLjJ8Sjn6QxrzzovC4fKG7KmdThLRJIky
	 j14p+uknXkekZppfx2Kdfsyv5Fz0JSB+cuDjzVCsE7ynhpXhsZhUbLvJltuDrOgbUD
	 a4oTFD4fltLtaz4zjjx5nfd2ViGG5xtVti5CgT4cCV4XHSG9s8hcu+d+yaUASzX+68
	 +BVKp9DUtysu/oZ/WWMh8DMhHvfAS0R2sWmkQpTXIurOMTpw36+URBY9b5lFo2X7iy
	 difP10HXnThbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1D380AA5F;
	Tue, 14 Jan 2025 21:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4][pull request] Fix E825 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689143602.152273.9636273491319560685.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 21:50:36 +0000
References: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, richardcochran@gmail.com,
 arkadiusz.kubalewski@intel.com, przemyslaw.kitszel@intel.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 13 Jan 2025 10:28:32 -0800 you wrote:
> Grzegorz Nitka says:
> 
> E825 products have incorrect initialization procedure, which may lead to
> initialization failures and register values.
> 
> Fix E825 products initialization by adding correct sync delay, checking
> the PHY revision only for current PHY and adding proper destination
> device when reading port/quad.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] ice: Fix E825 initialization
    https://git.kernel.org/netdev/net/c/d79c304c76e9
  - [net,v2,2/4] ice: Fix quad registers read on E825
    https://git.kernel.org/netdev/net/c/dc26548d729e
  - [net,v2,3/4] ice: Fix ETH56G FC-FEC Rx offset value
    https://git.kernel.org/netdev/net/c/2e60560f1ec9
  - [net,v2,4/4] ice: Add correct PHY lane assignment
    https://git.kernel.org/netdev/net/c/258f5f905815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



