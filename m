Return-Path: <netdev+bounces-78716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E768763A4
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA37E1F212AB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963656449;
	Fri,  8 Mar 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1JiNqKU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA755E78
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898632; cv=none; b=L6GZIygPa7sKuX2ArWYQMOWfHXAZ70OjX6h9xoSWJcwhjEkD480BR03sATLTIWQB5qZUYzWWyHG/Qur3GrjEzDlRfHFMpM1gCKtLLkGQgSvzHKEhhrQDDvTir6VUfk1zBV1v4v4TnB2Biba43RXAYWJxEGds9oJf1I7k+Ywj1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898632; c=relaxed/simple;
	bh=nHwWm3lY0C7P+EG9PJyATKkY5E4gTT7zAl4X3aHbtOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q38GEUt6NdnArDmcrdcHhi6+4b1dDW6hFaSgqQXkthMZCe9vXxU7eDn91vPk7SYUdO8cVBx/X3BadJnBdxn0EJosU6NYiUIVCcHw5yxBtcd5f+oFFu99ix6G8kkI4kMZtowCX5CrAjwm4FeJG+MeIj35Pmr5pVVZpwAg2QRbmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1JiNqKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09C08C433C7;
	Fri,  8 Mar 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709898631;
	bh=nHwWm3lY0C7P+EG9PJyATKkY5E4gTT7zAl4X3aHbtOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1JiNqKUqee5MCfFE5eQjxNzQPAnv8KKZEtbdKXk1qlQ0GXKVtxq3OCfIyNPZEZe0
	 fd0lOJ3f7ARhNu0O6Dqehud/i/4QNqoiKS+tYug0GL/fNT61jF04Bo+a6+hm0oiw5o
	 KIO6HVP0HHMr3i+5oBTXIDfSGtUHLsj2T3gGG2jqfXYhrQXilGEaOOboAwuUDikg7M
	 vBtuyAasYxe3rY77RVVdqMOyF6BMMcs44Isgae9LmkFUqYyr00WmIY6XsWfo3TGKOo
	 tHVrFcfPVU+HCrX9qcybzE/fPOgPGsqwwqjtjDYkb3Q34SWI22E4WLJh0QpAIK0K2s
	 I0GiQV5Q++JUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4BD8D84BB7;
	Fri,  8 Mar 2024 11:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates
 2024-03-06 (iavf, i40e, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989863093.27866.3949525843486958539.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 11:50:30 +0000
References: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240306215615.970308-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  6 Mar 2024 13:56:10 -0800 you wrote:
> This series contains updates to iavf, i40e, and ixgbe drivers.
> 
> Alexey Kodanev removes duplicate calls related to cloud filters on iavf
> and unnecessary null checks on i40e.
> 
> Maciej adds helper functions for common code relating to updating
> statistics for ixgbe.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] iavf: drop duplicate iavf_{add|del}_cloud_filter() calls
    https://git.kernel.org/netdev/net-next/c/c49172f7a8cf
  - [net-next,2/3] i40e: remove unnecessary qv_info ptr NULL checks
    https://git.kernel.org/netdev/net-next/c/60e4caf36b88
  - [net-next,3/3] ixgbe: pull out stats update to common routines
    https://git.kernel.org/netdev/net-next/c/836aeaf73aa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



