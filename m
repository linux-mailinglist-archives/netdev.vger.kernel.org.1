Return-Path: <netdev+bounces-179210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C8A7B238
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0894E1734F3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC11A5BAC;
	Thu,  3 Apr 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWqdNvTh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB415575C
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743721796; cv=none; b=csK0FUX9nn7atmVFxb/daieQRkaGmtYVo6EXNbkD2I1k+VVsBHxuM2T0DsoyopVdTZHWkmKIXPhJAIOZlu2W929DY3nGZqYIjt3eUTbaHEFQQFCqbMMnXUUE+P5wWtnNGJm6SEk3SqEXgXDNadLVRc26j+u91mQInMMFlzNk8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743721796; c=relaxed/simple;
	bh=kl/CXr8lLgpnSjZoO4Kg1lU9wPFN6qLKcTt/qcjKIk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shBkWK45eR4U0HVmYoxIZwixwVLeCMUsaJ+eVcR+tKqzVPCFVinfe/A6og+MJUmIUeO3q4kCg6Gicf574f1RLuUImFqTCeW0Kw0cbENQzBZjQJcPAbL4XMZGjkb6Q7uJbCeFtD5vtOpbQxJ378ZIyxr2+W4H+19JX8u06Lbog2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWqdNvTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C657C4CEE3;
	Thu,  3 Apr 2025 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743721795;
	bh=kl/CXr8lLgpnSjZoO4Kg1lU9wPFN6qLKcTt/qcjKIk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWqdNvTh85OsCDvsrffJKqMmglIFIhebeVIsVcDt2wM8VSIpVYOvOOTjbV8vzkSM2
	 vaf7DfeRsBzG2A/aAUI+/pf8frOiZd/DL0PD2cZJWr8BCNHSedjQtyReM3G/qhKhSO
	 7dTWMUI+iOI3zbI300HfzFfUGWFM9KHvassbjbRJnBmj4bF/TzHp635v43OsDILUeT
	 yMH7VWUwFyvoCT4eRsgkUD3jthv1RDRMw+cuuUklhzePDuScD86qTZz4hlUcI80VmY
	 durmjEFBAhgRROsKa+oxo4V0ueeZtLLBB6aejLIMasiKsPmhePtAvi2bYU43HcrPzh
	 uS6v0s8N4lr2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EBB380664C;
	Thu,  3 Apr 2025 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-04-02 (igc, e1000e, ixgbe, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174372183200.2713510.8157446029269788483.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 23:10:32 +0000
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  2 Apr 2025 10:38:52 -0700 you wrote:
> For igc:
> Joe Damato removes unmapping of XSK queues from NAPI instance.
> 
> Zdenek Bouska swaps condition checks/call to prevent AF_XDP Tx drops
> with low budget value.
> 
> For e1000e:
> Vitaly adjusts Kumeran interface configuration to prevent MDI errors.
> 
> [...]

Here is the summary with links:
  - [net,1/5] igc: Fix XSK queue NAPI ID mapping
    https://git.kernel.org/netdev/net/c/dddeeaa16ce9
  - [net,2/5] igc: Fix TX drops in XDP ZC
    https://git.kernel.org/netdev/net/c/d931cf9b38da
  - [net,3/5] e1000e: change k1 configuration on MTP and later platforms
    https://git.kernel.org/netdev/net/c/efaaf344bc29
  - [net,4/5] ixgbe: fix media type detection for E610 device
    https://git.kernel.org/netdev/net/c/40206599beec
  - [net,5/5] idpf: fix adapter NULL pointer dereference on reboot
    https://git.kernel.org/netdev/net/c/4c9106f4906a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



