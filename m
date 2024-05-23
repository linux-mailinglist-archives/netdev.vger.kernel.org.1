Return-Path: <netdev+bounces-97730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074288CCEB2
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9102BB20B9F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C913CABF;
	Thu, 23 May 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKLLuiGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27413C9B9
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454830; cv=none; b=m07I2uaGoOL6J4j3NVZdGseaZEnh0Qch7TUWilQBiRzY9ZU5+2hfuLkHuMN0t3b48t+8aeKtVoclSbvoBGdK88EcpjIztIa54u8BNhETPEeE3UWXoDztTjVSdreZ6Cu316uhLtVRkxSLjRq3UnJO0vZGOHLLQmgiiLECJ8i6w2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454830; c=relaxed/simple;
	bh=vQo7r9qQMrbUH1RG8pZdKZdwLId9bd3kdsavzhUfGGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N+z9eO68e6C8Qg/TpAFoec8a70MONw8MoaiEPmnxQLu+NU9hddm/SxFx28k5i0mAxfrixT8cbuNvjAxj5R3iolxmSU5YtB4hPxTiiBmJ0DNExf5hDIoRYGsP0YU8hpMxLKbetqbHuAR2R+Ey/YlmW/VFeOHAQ7WUKWD85Y5Ntbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKLLuiGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D238C32782;
	Thu, 23 May 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716454829;
	bh=vQo7r9qQMrbUH1RG8pZdKZdwLId9bd3kdsavzhUfGGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKLLuiGsQf5T5BkJ1rJih/lyvrpskOLiZyGoiftF5kXJEozmBQDUO1Qy6jRVYUOCA
	 wH8lRS1Mg5wCLp4DM9qzR3E8gjrBtxQOl05x9J+HktuzGX80l+S62Gg9bVzD/T1ARw
	 +9wUJ/LMylbk15baMfov9TPDNlS7vvlEMbsKqo0MMi1CIDX1tuaWcCRRF+mTh4CSss
	 5BkiGPgDSyR+PsEZV7xLhWkEeKCHtaRcC6JAdsIwI/njEuGBna+tghECekPTxsD9Yt
	 SlSLazJUYPWLC2kSw/P0MnA7AaG17GBoBKaKLNLxXsDtYrJFanXKOPOzxl9eLg6j84
	 DWZhVht4KKDQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ABEAC54BB2;
	Thu, 23 May 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171645482956.18839.2859960511467827703.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 09:00:29 +0000
References: <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
In-Reply-To: <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, jeffd@silicom-usa.com,
 kernel.org-fo5k2w@ycharbi.fr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 May 2024 17:21:27 -0700 you wrote:
> This reverts commit 565736048bd5f9888990569993c6b6bfdf6dcb6d.
> 
> According to the commit, it implements a manual AN-37 for some
> "troublesome" Juniper MX5 switches. This appears to be a workaround for a
> particular switch.
> 
> It has been reported that this causes a severe breakage for other switches,
> including a Cisco 3560CX-12PD-S.
> 
> [...]

Here is the summary with links:
  - [net] Revert "ixgbe: Manual AN-37 for troublesome link partners for X550 SFI"
    https://git.kernel.org/netdev/net/c/b35b1c0b4e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



