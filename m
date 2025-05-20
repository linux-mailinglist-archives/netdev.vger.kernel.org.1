Return-Path: <netdev+bounces-191718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AAABCDC5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AEC3B8FA0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A502571CA;
	Tue, 20 May 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf+r0fOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E9256C60
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711211; cv=none; b=TZgc/ZMzfiRIiC5lIKkmOTHczLjPrzPq5gF4tmPVWKnWXAwvWlkirenbIxhaWhuKbwUjat42B5MhciSOgK21d4FUT3CBxWdl8HXmW8k9EqUtPIyG4JEU2ACe+kFW1DpAuESDsK3HLJN6yXsnNjsVTIS2lZ33KNvjuHT6UBC8PT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711211; c=relaxed/simple;
	bh=Jtkz9+yRkeX3xjEWWeb1iy2c48fCpvht45FjB9gD0og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rxf5cJbWFWshX2n+RXMe+fVswZxl86MpwbXpEm1Nh9sQnHa5SLhOcB3fWDbtEvZSCMuoEeUobswkRly+/8eyovFC8Ywr0332ZcTF9hzkKo11V+FQs5SwY5d0+NwEpUWAjYzqp6WtIdX4PEZEbsDHhyWDIzhntp9Bxm47DYE39tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf+r0fOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18E3C4CEE4;
	Tue, 20 May 2025 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747711210;
	bh=Jtkz9+yRkeX3xjEWWeb1iy2c48fCpvht45FjB9gD0og=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rf+r0fOQznCVDkru9e8/kLIeQPyKPpGsNwIg8yXAwtZ0ANZA17Uwl8iuPWQB9EpRB
	 Zbw9sVkXOzjyCLboq0ocpqIzR3W8GDrFcc36pnINyuWWP5nSQiY4tkSD2K0JfyS/kH
	 upmnMUURGvMnlLiKMClHbdlIfIoVBRp+mmyPFJ0m+qLGGEdrNgE/HhE7HoSVgl83Bv
	 UTNnkLih6lKRewAfbLEdIDOnW4ckCln3baftlgqgY+e97jhNX6Wc1MYcQzJ9yllZbd
	 w6nN3b4Okq5xaIfV3PAi1qlPiPKzZIQuCmbXQITzWKR85Pfg8nMyNxjCf9n2RlyS5L
	 4EV8dwT2Og9EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF41380AA70;
	Tue, 20 May 2025 03:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10][pull request] idpf: add initial PTP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174771124675.1146050.13022731490334705259.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 03:20:46 +0000
References: <20250516170645.1172700-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250516170645.1172700-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 milena.olech@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 16 May 2025 10:06:34 -0700 you wrote:
> Milena Olech says:
> 
> This patch series introduces support for Precision Time Protocol (PTP) to
> Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
> supported when the PTP capability is negotiated with the Control
> Plane (CP). IDPF creates a PTP clock and sets a set of supported
> functions.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] idpf: change the method for mailbox workqueue allocation
    https://git.kernel.org/netdev/net-next/c/9525a12d6b0b
  - [net-next,v3,02/10] idpf: add initial PTP support
    https://git.kernel.org/netdev/net-next/c/8d5e12c5921c
  - [net-next,v3,03/10] virtchnl: add PTP virtchnl definitions
    https://git.kernel.org/netdev/net-next/c/bf27283ba594
  - [net-next,v3,04/10] idpf: move virtchnl structures to the header file
    https://git.kernel.org/netdev/net-next/c/c5d0607f424e
  - [net-next,v3,05/10] idpf: negotiate PTP capabilities and get PTP clock
    https://git.kernel.org/netdev/net-next/c/5cb8805d2366
  - [net-next,v3,06/10] idpf: add mailbox access to read PTP clock time
    https://git.kernel.org/netdev/net-next/c/5a27503d3862
  - [net-next,v3,07/10] idpf: add PTP clock configuration
    https://git.kernel.org/netdev/net-next/c/d5dba8f7206d
  - [net-next,v3,08/10] idpf: add Tx timestamp capabilities negotiation
    https://git.kernel.org/netdev/net-next/c/4901e83a94ef
  - [net-next,v3,09/10] idpf: add Tx timestamp flows
    https://git.kernel.org/netdev/net-next/c/1a49cf814fe1
  - [net-next,v3,10/10] idpf: add support for Rx timestamping
    https://git.kernel.org/netdev/net-next/c/494565a74502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



