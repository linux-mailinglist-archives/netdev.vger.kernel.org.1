Return-Path: <netdev+bounces-221151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90078B4A81C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC204E1808
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537327E7EB;
	Tue,  9 Sep 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iffideYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE47E107
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410202; cv=none; b=Z/fbrpTrd/dipFMDLIpXA1aCOSPXpdkDS7dtnfgdD3oPcy7GMrMAaEcdQyshCI0FeNTtlfQwOv7cobua2ii6pO+n//SnyuWbs3W6Uz8u0kULZslaBRLk4fvlLM8sMqUOBb832BE+lDmVN/9mgriT7pbnKZfBrPmJVuwzC8kLo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410202; c=relaxed/simple;
	bh=PzgtR2EZWBff1tdfxXd6jX7Dq26BSfHcjm/x9I8yUv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZZFp9rlmfvDSwpa9NDX/10ZtmzS5mjq9BcdpVVPo/ejEI7FJ/mn/pn3o81BHqcQ04lThVXwuXNXAzEa8sogVN1LZClQkc8SSfNlWF/w7Ffwa0mp8ypX+cmj2O/qCNZYXWKQsjajfk9F1qHonybB9MFb7d+hGdiWPYWGYl9+zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iffideYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D19C4CEF5;
	Tue,  9 Sep 2025 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757410202;
	bh=PzgtR2EZWBff1tdfxXd6jX7Dq26BSfHcjm/x9I8yUv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iffideYUQPDy1FxMZ03x8EUzpIZk86yXTI/ousYxbQVZcpdrhFuKtjoyI4nCfacS8
	 ybQ+XVzIY/+Z8pdWiKmv/oHMxHrOt9h5JqQiFOrYkyZ5VZHUNJRunQCTA4Q/hj9X6d
	 2uXcQmSkxyatxiDzkASrzWahxlXaEXVUdpcyRTsvRPAcY7/Xj9K9BocPtUKK0Beneg
	 NzzfU4t+yq5ZMtg4ltCmaqMT6R5ubRxk+7rbUpTJWwmOMC3AyMyWNbZMrg548FqlUx
	 lZSy8VByRvgXyLtrlT891gZKBOSr6KFsGItPd1bZZRgPgVbBTDvXu8j3lVyZh1OD+I
	 W3I4EoKp2/wYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF383BF69;
	Tue,  9 Sep 2025 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] hsr: use netdev_master_upper_dev_link() when
 linking lower ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175741020602.597824.1332330545808844088.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 09:30:06 +0000
References: <20250902065558.360927-1-liuhangbin@gmail.com>
In-Reply-To: <20250902065558.360927-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, acsjakub@amazon.de,
 bigeasy@linutronix.de, ffmancera@riseup.net, ap420073@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  2 Sep 2025 06:55:58 +0000 you wrote:
> Unlike VLAN devices, HSR changes the lower device’s rx_handler, which
> prevents the lower device from being attached to another master.
> Switch to using netdev_master_upper_dev_link() when setting up the lower
> device.
> 
> This could improves user experience, since ip link will now display the
> HSR device as the master for its ports.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] hsr: use netdev_master_upper_dev_link() when linking lower ports
    https://git.kernel.org/netdev/net-next/c/d67ca09ca39f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



