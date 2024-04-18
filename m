Return-Path: <netdev+bounces-88949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A58A90FE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E68282736
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6CE3BBD8;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNnfHyhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8553A1D3
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406228; cv=none; b=JuL9GWrWI2moijndViUVMApSFuoemshUOYUxNL6Q7O8a5M8H759RWpHV668g5xK4VLTGrTvy4gZTjgCzUkuRGbCeA8Jd3t8i3brL/RRsu3ayWAGchqP59G5aextbwSCteWxMkd0hTeD46eLjjZPlpuGh5lo5K96U5Igubfftehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406228; c=relaxed/simple;
	bh=2G7zLW1jysTW9qKGgjYoTR1I2x6nBBABULNRqLQYTko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sx3VSHqO1LOUYd8xJssNO5iIssOf0Xlzc57p7l61cHNxKndE59NpiL+WntW/3n+SaRdJmvrxn/yKHtgbc+JPS5ib4ZTPoyRM/j3gLdnD1Tl+A9DZJS0gnuGKbBSWumv0Rtk4Bh064gv78igN76V3EemsBplnkxvwzOZ9MP/bqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNnfHyhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3632CC072AA;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713406228;
	bh=2G7zLW1jysTW9qKGgjYoTR1I2x6nBBABULNRqLQYTko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNnfHyhifMb8d638nIw04INJaVvSPIO6hUWgBsvAlTG8Uauf+2MrbhxQRKpBTQ1YL
	 w+RyfsDcv93ekDahMdQbMDYtCO2VVuoFig9pyOG7iiL5DhzinItn0QDoIqLF7z3GDk
	 79hTDZCPgzwruMTthYdooDn2nUecSN78npmZER4dyAn37rSHmvNHT4JpJmJntfWYBw
	 egQ2AIHp+sjoTgk23oa9/xsvFbinWYhB76A8sZMqqlrKVChJ6oCuWPjmCT2gsW5bcy
	 FNwLIoXU0+TAV8mNKKPCB5vL5Ia6XBmqpnZYz2NF7LavC08uzEYoM6ZxJzvkDHQuW+
	 P1tw48hgN6A+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B955C43617;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2024-04-16 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340622817.10413.11343228332677751589.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 02:10:28 +0000
References: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 16 Apr 2024 13:24:05 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Michal fixes a couple of issues with TC filter parsing; always add match
> for src_vsi and remove flag check that could prevent addition of valid
> filters.
> 
> Marcin adds additional checks for unsupported flower filters.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: tc: check src_vsi in case of traffic from VF
    https://git.kernel.org/netdev/net/c/428051600cb4
  - [net,2/3] ice: tc: allow zero flags in parsing tc flower
    https://git.kernel.org/netdev/net/c/73278715725a
  - [net,3/3] ice: Fix checking for unsupported keys on non-tunnel device
    https://git.kernel.org/netdev/net/c/2cca35f5dd78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



