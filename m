Return-Path: <netdev+bounces-154106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE76D9FB43A
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998A67A1EFB
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4071C5F31;
	Mon, 23 Dec 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpi+774t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB71C3BFE
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979822; cv=none; b=H9YCvrQDdsT3pz5gxRNG0kuqyVaGrQkSZvOvfusMaQ1smph0an6+2dUeO/qBzjiFL8Icp9+tswlRMvDgqNmK4CVVuALJdug09j7622vLsrKJ0C1GQJY1SCKJRIRzPpV6Whzofik582pifopP4cUktrIC4wV5rNrri18ypF/VkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979822; c=relaxed/simple;
	bh=CvE9DcRN/4XD0JO/mX+XcI8G3UxI9t51U+0rJdVVvE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SY5J/gDXBDDTA0vCg5GvhoF5sFWH9CleGLubxqfGR0wI2yLUHFAD2tI7PDbnXeg+S8L/skTdAEs3Qh1CYU0E8UW4fueqhU0v9OttlUGSK+WApXHSs6oQXEv2V9WsjY1J3MvqLihGosPGSWmN0aJ51pey8uC1kdSrtn+amKDjIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpi+774t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79338C4CED3;
	Mon, 23 Dec 2024 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979820;
	bh=CvE9DcRN/4XD0JO/mX+XcI8G3UxI9t51U+0rJdVVvE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fpi+774tZPusKkDPqNA+sA6+tKgNhAaYZGMgMpMgKGicw0yJJuGcVZ2WdWL9Orb15
	 usoFeb2Il3qy7Jzei8EI5Qq+lAgRaVicpuzWM9zMw8yVePh5+j7ifQgC/657dtuBHe
	 0AvOD3AC/fJI9Ku5G4w14ZHdXpa6+jZv+aF+XV9BvRlLzz0iPkxRY2cRjLgAaWKQx6
	 yEgGBfvOcTPmcZ0JEzFd47QIfjfBVn0+6xhlkeiHyi9NXEgcxqLcklIXtQBghZD1dR
	 yF94GblaPek7Dlirwfi6X+zKekxyMMLa4NQY7eGeOnKmt3+EG7xGGIm/gZxUR/fmOv
	 9+edRTCBCW9Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE43805DB2;
	Mon, 23 Dec 2024 18:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] eth: fbnic: support basic RSS config and
 setting channel count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497983874.3929264.15451655882754072854.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:50:38 +0000
References: <20241220025241.1522781-1-kuba@kernel.org>
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 18:52:31 -0800 you wrote:
> Add support for basic RSS config (indirection table, key get and set),
> and changing the number of channels.
> 
>   # ./ksft-net-drv/run_kselftest.sh -t drivers/net/hw:rss_ctx.py
>   TAP version 13
>   1..1
>   # timeout set to 0
>   # selftests: drivers/net/hw: rss_ctx.py
>   # KTAP version 1
>   # 1..15
>   # ok 1 rss_ctx.test_rss_key_indir
>   # ok 2 rss_ctx.test_rss_queue_reconfigure
>   # ok 3 rss_ctx.test_rss_resize
>   # ok 4 rss_ctx.test_hitless_key_update
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] eth: fbnic: reorder ethtool code
    https://git.kernel.org/netdev/net-next/c/7d0bf493b135
  - [net-next,02/10] eth: fbnic: support querying RSS config
    https://git.kernel.org/netdev/net-next/c/7cb06a6a777c
  - [net-next,03/10] eth: fbnic: don't reset the secondary RSS indir table
    https://git.kernel.org/netdev/net-next/c/ef1c28817bf9
  - [net-next,04/10] eth: fbnic: support setting RSS configuration
    https://git.kernel.org/netdev/net-next/c/31ab733e999e
  - [net-next,05/10] eth: fbnic: let user control the RSS hash fields
    https://git.kernel.org/netdev/net-next/c/c23a1461bfee
  - [net-next,06/10] eth: fbnic: store NAPIs in an array instead of the list
    https://git.kernel.org/netdev/net-next/c/db7159c400ff
  - [net-next,07/10] eth: fbnic: add IRQ reuse support
    https://git.kernel.org/netdev/net-next/c/3a856ab34726
  - [net-next,08/10] eth: fbnic: centralize the queue count and NAPI<>queue setting
    https://git.kernel.org/netdev/net-next/c/557d02238e05
  - [net-next,09/10] eth: fbnic: support ring channel get and set while down
    https://git.kernel.org/netdev/net-next/c/3a481cc72673
  - [net-next,10/10] eth: fbnic: support ring channel set while up
    https://git.kernel.org/netdev/net-next/c/52dc722db0d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



