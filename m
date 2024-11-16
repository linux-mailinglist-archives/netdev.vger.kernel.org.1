Return-Path: <netdev+bounces-145540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C149CFC65
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F57286678
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284922071;
	Sat, 16 Nov 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n58PvbCp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294563D
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731725421; cv=none; b=eJh0tLFi3eK3jGTAJJXr95S5eW7g2j4THGJMaAeLtTWXvnhx0Ut/KYBFIBjCsOmf2Atw5dR33EG10q5a3umtvQQ8JaPoGEdF5N0DT+7MY7yUHJcSFU7/WvVBe3LvCeaan1rzaQ1VbNlajukiuaUjT2+n3WAdPkSxJKanFdUs0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731725421; c=relaxed/simple;
	bh=CFTPSrjT3ZMM533Q+stOH/qPDzGcWtVvIygU6cPaS6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLYo27AsbgiJGNtkFZYOOJf+xeLhuCwUnYG4kW457e3/7u9eiYv3ezsd3wxtLXs7BdO+68Tlzko7q2WOCUxfHTknI21moqKNd3W/kNTXXv86YN2ribw02QbEp12OjY8GvAhlT4OuIrf2aUm1H4kbdG5iJ1hKJ9StUCg3m4np9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n58PvbCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E363C4CECF;
	Sat, 16 Nov 2024 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731725421;
	bh=CFTPSrjT3ZMM533Q+stOH/qPDzGcWtVvIygU6cPaS6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n58PvbCpTNvL+Y6K2UVzOJIQZR8pLkKulRUyKc5wdNSZGEyb9FkmZpD4Sx4BvVJeZ
	 DlI4RLdY7lanyWuiFLdxtoNfme1qVtjtD4XaBkCc/a15H6lBUaAuq0Yy+gW84NPY+C
	 uWv+Yt8UwwLDu7DLvZDk9f9GqatSHqAiDGgQKFPjJ5JuplZreQE0BKZu23jgu4X+Ay
	 4gF4d36FyB+VOIPmGw6sT0XIQq31coPiBvd0l15hajABnyL9bLxl7Z/gH04P1uIxAa
	 ineAHsYO9aalAOg3l9so77G8epMZ2JSt9XvJy9/phrhu2gRprM95xUt67F7nyrUo9c
	 hqgz5s6VOgokw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D013809A80;
	Sat, 16 Nov 2024 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/14][pull request] Intel Wired LAN Driver
 Updates 2024-11-05 (ice, ixgbe, igc. igb, igbvf, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173172543224.2804258.10934922269921483645.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 02:50:32 +0000
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 13 Nov 2024 10:54:15 -0800 you wrote:
> For ice:
> 
> Mateusz refactors and adds additional SerDes configuration values to be
> output.
> 
> Przemek refactors processing of DDP and adds support for a flag field in
> the DDP's signature segment header.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/14] ice: rework of dump serdes equalizer values feature
    https://git.kernel.org/netdev/net-next/c/8ea085937dad
  - [net-next,v2,02/14] ice: extend dump serdes equalizer values feature
    https://git.kernel.org/netdev/net-next/c/99dbcab0cdd6
  - [net-next,v2,03/14] ice: refactor "last" segment of DDP pkg
    https://git.kernel.org/netdev/net-next/c/d6920900398a
  - [net-next,v2,04/14] ice: support optional flags in signature segment header
    https://git.kernel.org/netdev/net-next/c/09ec79d42e42
  - [net-next,v2,05/14] ice: Add support for persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/492a044508ad
  - [net-next,v2,06/14] ice: only allow Tx promiscuous for multicast
    https://git.kernel.org/netdev/net-next/c/2a52984c53f3
  - [net-next,v2,07/14] ice: initialize pf->supported_rxdids immediately after loading DDP
    https://git.kernel.org/netdev/net-next/c/8cca16be5efc
  - [net-next,v2,08/14] ice: use stack variable for virtchnl_supported_rxdids
    https://git.kernel.org/netdev/net-next/c/eaa3e9876bbc
  - [net-next,v2,09/14] ice: Unbind the workqueue
    https://git.kernel.org/netdev/net-next/c/fcc17a3ba0ce
  - [net-next,v2,10/14] ixgbe: Break include dependency cycle
    https://git.kernel.org/netdev/net-next/c/4b2c75ffeaad
  - [net-next,v2,11/14] igc: remove autoneg parameter from igc_mac_info
    https://git.kernel.org/netdev/net-next/c/ade6fded7957
  - [net-next,v2,12/14] igb: Fix 2 typos in comments in igb_main.c
    https://git.kernel.org/netdev/net-next/c/f40b0acad688
  - [net-next,v2,13/14] igbvf: remove unused spinlock
    https://git.kernel.org/netdev/net-next/c/4d26b6eccdc2
  - [net-next,v2,14/14] e1000: Hold RTNL when e1000_down can be called
    https://git.kernel.org/netdev/net-next/c/e400c7444d84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



