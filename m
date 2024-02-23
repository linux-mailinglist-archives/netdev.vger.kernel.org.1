Return-Path: <netdev+bounces-74245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB809860963
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226732830AA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FDCA73;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVLFMgqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE91D30B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659029; cv=none; b=luJ0gWOOLsE9uxbvN/knL5j+2RA7K+LpWkA+UPMVDsyAhlg7HZTZFNLtj5AJDe1E3azZJIyDWhJRZnIYkFPNmyl6cpJdVI8M9+3UMog551w4PPiprdNZREHJFNlJO8dTrLX/RiqIbF4oiJt50z/0xE19pxzSkUDkMTamAHX6sOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659029; c=relaxed/simple;
	bh=MEJVOsMx1foBdh95V8cUKey+1BND9CWIbv9QPCbHOok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UrA2cRXEjJ8RRuLwa8pbkwslCuVgpqNE1GtXj/80SgzxSt0r/iDcfLlP1fVeSzTbY6zM+DFymkMr+lD/P6mZD8RY0BMlPmHT6D/9rQQU1KSn9dDElyoApt8AYPy6d10JX/CqSOS9TD4fa5vEVBld4l+zpk2ldO8uez6fFsSH2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVLFMgqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BAC0C433C7;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708659029;
	bh=MEJVOsMx1foBdh95V8cUKey+1BND9CWIbv9QPCbHOok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NVLFMgqcwnhWvFHSyN/BEP5PVqQ4uAs+37v92zD1CKNEQicQVjowP85meGtl56vN5
	 dX1UrhdDiYndpQdHwQ5rdRwQmILp82myxIxVNAIUDqjtN3I4EUBQqxrUrNtLluQrqV
	 B4SkMgNZ1DAU6ag5QnMtFKrZa4BZpgB5eKD0IKpG/OLsRja/xdFoZGBWCADszF6MS/
	 hZQ0Ib7jO6N4bZKrnyqNcb78Eq4EhgutdNj42oZzz6JpBIi28GwdvEeBUNNDW11udM
	 tZUJ/z2NYNr/RbezPDw6QDrRBH5PLppd/jly3ATIZYkwiEVBQwVXxWjuv/ZdzesAp9
	 Ym77XMAeMfIRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16E37D84BB9;
	Fri, 23 Feb 2024 03:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2024-02-20 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865902908.26504.16185634061481745228.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:30:29 +0000
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 20 Feb 2024 13:44:36 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Yochai sets parent device to properly reflect connection state between
> source DPLL and output pin.
> 
> Arkadiusz fixes additional issues related to DPLL; proper reporting of
> phase_adjust value and preventing use/access of data while resetting.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: fix connection state of DPLL and out pin
    https://git.kernel.org/netdev/net/c/e8335ef57c68
  - [net,2/6] ice: fix dpll input pin phase_adjust value updates
    https://git.kernel.org/netdev/net/c/3b14430c65b4
  - [net,3/6] ice: fix dpll and dpll_pin data access on PF reset
    https://git.kernel.org/netdev/net/c/fc7fd1a10a9d
  - [net,4/6] ice: fix dpll periodic work data updates on PF reset
    https://git.kernel.org/netdev/net/c/9a8385fe14bc
  - [net,5/6] ice: fix pin phase adjust updates on PF reset
    https://git.kernel.org/netdev/net/c/ee89921da471
  - [net,6/6] ice: Fix ASSERT_RTNL() warning during certain scenarios
    https://git.kernel.org/netdev/net/c/080b0c8d6d26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



