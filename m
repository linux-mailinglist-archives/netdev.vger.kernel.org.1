Return-Path: <netdev+bounces-83180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C84891369
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5C1F221DE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E63C482;
	Fri, 29 Mar 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUio2MCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7523C08D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691431; cv=none; b=UYcViCUIZrgJ5v20CNiBKrKnsli+40ERnNFF5ns46pY0Bnltx7QzW5tDjaCsZwY9o8dB8+mBz9vcrDwouXpRAKXUn+0YvYTRulXWGdXvnlFsUpW1i3L3NAxWL2qJ1bz3i1/7JxWg567hpJw31KDdBm9brtaWCN+A3HNujfdUK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691431; c=relaxed/simple;
	bh=He74dmmSabMF6lr+1pIZjACBp8aTSp8Qf0U8Gc33cto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EVsbSpNMyg3V7YTfWs8+yNX26ej6CZT8JL5a45ZvOMIa4FlHVot/NX0vBquv+OCoW/dya22h8EtLT+wBRlI9fnYy4bCelspm6gsDykyBvtZcndCCJ8Ip6lgXxUaFWp/bxe8qWKQ7j+Q1Eb3PrKB2qJlhqss9LIbsB7zoVV9rxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUio2MCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A718AC433F1;
	Fri, 29 Mar 2024 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711691430;
	bh=He74dmmSabMF6lr+1pIZjACBp8aTSp8Qf0U8Gc33cto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUio2MCKEiJTxJgPbeitqRP7J5yvcS4bICxkw+UITMXObSdtOBqhcAO3ML5jVDtgW
	 d58l0fdg5xAlwceebE9S6Q6sl35rDIiOcaiWc0+ORZyD0mqL2QeoLpc4QEdh7SCZJv
	 U1XREopkp5CCQEze2ndYL7gV6bEjO5XHjgJ1kMx/a8atBLHpXeBwbmLxQGOkTGbpoQ
	 mlAVHHNDQM8m7VocYVJ7vX8GteaWLLy3hWS1Clp1AuWn0POzhdoIKluMnr22pCNEma
	 xnofYicMDZwErvusnQ/CEZMu2nx9gjL+Fov7OwjzwK5SLV3afrlAZENISZ2u+x7zRH
	 8BVQ+oFSMbkng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93688D84BAA;
	Fri, 29 Mar 2024 05:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] bnxt_en: PTP and RSS updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171169143059.9577.8504327760419884567.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 05:50:30 +0000
References: <20240325222902.220712-1-michael.chan@broadcom.com>
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Mar 2024 15:28:50 -0700 you wrote:
> The first 2 patches are v2 of the PTP patches posted about 3 weeks ago:
> 
> https://lore.kernel.org/netdev/20240229070202.107488-1-michael.chan@broadcom.com/
> 
> The devlink parameter is dropped and v2 is just to increase the timeout
> accuracy and to use a default timeout of 1 second.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] bnxt_en: Add a timeout parameter to bnxt_hwrm_port_ts_query()
    https://git.kernel.org/netdev/net-next/c/7de3c2218eed
  - [net-next,02/12] bnxt_en: Retry PTP TX timestamp from FW for 1 second
    https://git.kernel.org/netdev/net-next/c/604041643a85
  - [net-next,03/12] bnxt_en: Add helper function bnxt_hwrm_vnic_rss_cfg_p5()
    https://git.kernel.org/netdev/net-next/c/1dcd70ba2437
  - [net-next,04/12] bnxt_en: Refactor VNIC alloc and cfg functions
    https://git.kernel.org/netdev/net-next/c/a4c11166a696
  - [net-next,05/12] bnxt_en: Introduce rss ctx structure, alloc/free functions
    https://git.kernel.org/netdev/net-next/c/fea41bd76634
  - [net-next,06/12] bnxt_en: Refactor RSS indir alloc/set functions
    https://git.kernel.org/netdev/net-next/c/ecb342bb6098
  - [net-next,07/12] bnxt_en: Simplify bnxt_rfs_capable()
    https://git.kernel.org/netdev/net-next/c/b09353437b28
  - [net-next,08/12] bnxt_en: Add a new_rss_ctx parameter to bnxt_rfs_capable()
    https://git.kernel.org/netdev/net-next/c/0895926f725a
  - [net-next,09/12] bnxt_en: Refactor bnxt_set_rxfh()
    https://git.kernel.org/netdev/net-next/c/77a614f7499e
  - [net-next,10/12] bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()
    https://git.kernel.org/netdev/net-next/c/b3d0083caf9a
  - [net-next,11/12] bnxt_en: Refactor bnxt_cfg_rfs_ring_tbl_idx()
    https://git.kernel.org/netdev/net-next/c/61c814bf4ad7
  - [net-next,12/12] bnxt_en: Support adding ntuple rules on RSS contexts
    https://git.kernel.org/netdev/net-next/c/2f4f9fe5bf5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



