Return-Path: <netdev+bounces-61605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235E82463B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D091C21011
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68F250F8;
	Thu,  4 Jan 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4GaJSam"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A2250F1
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7791FC433C9;
	Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385828;
	bh=vjaAQ8a+s+io7ovIp6tsoHhjVRCBLLmR0roNNObvxHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y4GaJSam00MpKWzEMW939SMZA1mYlo2ZV5qSuPrz0E6y0N8F7PTY4YJKFyFVzB/zN
	 G28gEk4OySPc9gpaRGNJqoq6rONWsjRigCTOzzeEOLnRgUR9fd4DKh3VCG0E7JUHBH
	 XiKzqfCa6etEnnjSKEyVWOTfxMIf3QfjcTM5sK9B5x5QvEiCj2ielasbpo1BoaUIM4
	 +KwlZAP7xo99MMKI9dY8+VXK9BOh1JERaXzuUkpulGF5/wKwYmB+fVaogJOfLaeToS
	 AclFiG+3eFm/VFH0mQeL0d1OXLNhjapKGNkDhjJson2yloTHDwv9HjjJBbGqfNaW6o
	 8esbbpzK+tBIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 555FEC3959F;
	Thu,  4 Jan 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-01-03 (i40e, ice, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170438582834.10335.2988402067248828484.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 16:30:28 +0000
References: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  3 Jan 2024 11:32:48 -0800 you wrote:
> This series contains updates to i40e, ice, and igc drivers.
> 
> Ke Xiao fixes use after free for unicast filters on i40e.
> 
> Andrii restores VF MSI-X flag after PCI reset on i40e.
> 
> Paul corrects admin queue link status structure to fulfill firmware
> expectations for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/4] i40e: fix use-after-free in i40e_aqc_add_filters()
    https://git.kernel.org/netdev/net/c/6a15584e99db
  - [net,2/4] i40e: Restore VF MSI-X state during PCI reset
    https://git.kernel.org/netdev/net/c/371e576ff3e8
  - [net,3/4] ice: fix Get link status data length
    https://git.kernel.org/netdev/net/c/9fb266dcb6aa
  - [net,4/4] igc: Fix hicredit calculation
    https://git.kernel.org/netdev/net/c/947dfc8138df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



