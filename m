Return-Path: <netdev+bounces-95662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3EC8C2F1B
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A39B21B78
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3C208A0;
	Sat, 11 May 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnsyAptQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFE125C0
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395234; cv=none; b=JQxBrWhDqEvFvdNl5GLX3mf9bjzg1O5tJYDP1lbUH9kkg9yDFimOTKdgzKaD6lb4D2gTVo5I67BlT3+2zqfpZbE9Lvbk2Il3/84l3WYFbbjz7jyTGAEIv1OO5aBTr6LZBoG7TEI4qH4/FejSnEoEu7PEcZaOs9ZM0DinvHpULb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395234; c=relaxed/simple;
	bh=F7NBBto7gR24NxPHf7H871rWnIzi7znwYyywhqwoFyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCkDAsc/TV+IbyAd2GklZ/ZVNSy4O7A+FkPyXDmN6s5bCO9MFQKwq/eHNY0iM07fpLhsOWPyc3JZyRFIGbzLnvt2DFuJEu0xiOpHoKMajXuaESIeWcawb7y07NoBtlruIOORBIP5dIzVhd7L2zxjsQi/m7oXQSMYGHMdIYGRaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnsyAptQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891BFC32782;
	Sat, 11 May 2024 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715395233;
	bh=F7NBBto7gR24NxPHf7H871rWnIzi7znwYyywhqwoFyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jnsyAptQxG6Y7aCoPaGcTlmEXT6w8HhwqpROsUJVwmmFOYbFrZun0sUCYASAcaeg1
	 8OTsEmeYMsrZOKZFL5ECNiCV+PuPJECeAhkORldMKT2PUohJ0Rlv3utpPDUTmEtiY+
	 LoArgQYJwqE0WYQJrbFdkH9T+q9WMyPU2sA8d5i08YABu7omB6WX8FmJXlEsALbkxm
	 HRAl7OLQ/TxOgfxOGndzsjiRDcejGxvNvIiAxLiJzrE15f1HpDXe7ImMKHSI1XuLcl
	 yA0r7pimy8E7m2KQBJ5b2r1Qakh1141cnvGvBRh3x2KCcq79AMaVGcXkUilNHECHhN
	 33qat/x9iXeEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79636C32759;
	Sat, 11 May 2024 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates
 2024-05-08 (most Intel drivers)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539523349.2430.10387396169491466882.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:40:33 +0000
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  8 May 2024 10:33:32 -0700 you wrote:
> This series contains updates to i40e, iavf, ice, igb, igc, e1000e, and ixgbe
> drivers.
> 
> Asbjørn Sloth Tønnesen adds checks against supported flower control flags
> for i40e, iavf, ice, and igb drivers.
> 
> Michal corrects filters removed during eswitch release for ice.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] i40e: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/174ee5bcfeb7
  - [net-next,2/7] iavf: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/c7b9c4944246
  - [net-next,3/7] ice: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/21e1fe9e84f4
  - [net-next,4/7] igb: flower: validate control flags
    https://git.kernel.org/netdev/net-next/c/fb324f2b22a6
  - [net-next,5/7] ice: remove correct filters during eswitch release
    https://git.kernel.org/netdev/net-next/c/8e3a90f2e3aa
  - [net-next,6/7] igc: fix a log entry using uninitialized netdev
    https://git.kernel.org/netdev/net-next/c/86167183a17e
  - [net-next,7/7] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
    https://git.kernel.org/netdev/net-next/c/6918107e2540

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



