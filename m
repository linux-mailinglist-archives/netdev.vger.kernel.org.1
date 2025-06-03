Return-Path: <netdev+bounces-194762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D4ACC50B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3021893F49
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50422F177;
	Tue,  3 Jun 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="min/+KWm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCE22F152
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949000; cv=none; b=Pp6nMG2UFRdMgwhD/uvSPx4XvgjSf5BdqMujIowk5WcqckES1mY9VdOSosXgsNHCFQScQlRj16Iq2K8Thxo4d9rrpQB/mIksfd7rlEbTBTG5mehPOTIgmqaBs/JfNLe7829o+MbDr9z5m+/ngA5e2gYfD/YO0XO9Drb219YCeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949000; c=relaxed/simple;
	bh=13JMKJlvXaJzjrdB79q+eXqwSefPGce7G8wAUQSTfDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FeBSXQC90/XSTM7Oe7GuGVjCoYmkZSpOxyQTNFBNwGYqeOkGyorm0gFLhDapE9ndRttF0Zc2l4h8r9GOOXvQ4CYZ9XrtRGK2zI7p0wV3+AGH/mfPExuJt0IB4J37exCJ8HWamC1bnCgfuOgJ357OcialP4Pej8LKelfYjm4IkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=min/+KWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86404C4CEF0;
	Tue,  3 Jun 2025 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748948999;
	bh=13JMKJlvXaJzjrdB79q+eXqwSefPGce7G8wAUQSTfDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=min/+KWm96g96MYFDVZdeW6AbX3GtSGU/+0qPZA/4qwJW1YQv8/z51dTh7IAExuKm
	 frdxlnBk+Ws0tW720L9ZB8Od2TstEU6CEFWEayq9ea8BhtCVdTA4Vamx6j346n6YuQ
	 Ts6tp7DzCvjtofl2xdsg59pEtYeoUxhO6lNK+1lsjgMU+/Bl1MvDwGlST850yNEZ1N
	 NHfMFeFnwa34/7VgWwiNT3bcrEKusA6sEbUKvhYVaqCZYxQvef83ieowxgTCuN4GOo
	 kMF941e4doVJOMHPWGsCLDGchUmbbukI79mqn8QIYgJcadUeGuOcL85TW6cwMguyJ/
	 ncCcDyAfSgjQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C60380DBEC;
	Tue,  3 Jun 2025 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: airoha: Fix IPv6 hw acceleration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174894903200.1469579.2031889211838000906.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 11:10:32 +0000
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.kubiak@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 02 Jun 2025 12:55:36 +0200 you wrote:
> Fix IPv6 hw acceleration in bridge mode resolving ib2 and
> airoha_foe_mac_info_common overwrite in
> airoha_ppe_foe_commit_subflow_entry routine.
> Introduce UPDMEM source-mac table used to set source mac address for
> L3 IPv6 hw accelerated traffic.
> 
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: airoha: Initialize PPE UPDMEM source-mac table
    https://git.kernel.org/netdev/net/c/a869d3a5eb01
  - [net,v2,2/3] net: airoha: Fix IPv6 hw acceleration in bridge mode
    https://git.kernel.org/netdev/net/c/504a577c9b00
  - [net,v2,3/3] net: airoha: Fix smac_id configuration in bridge mode
    https://git.kernel.org/netdev/net/c/c86fac5365d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



