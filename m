Return-Path: <netdev+bounces-69169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F53849E98
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31F4288FE0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DAF2E41C;
	Mon,  5 Feb 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd05C1pH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCA2DF9D
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147625; cv=none; b=j4eKd9xrEEUsTN1Ys1Oe6d6JVngHYGWGFKrx8DvNG9W97AesDRP0nKKZiBtDWjsnIuk2KwKCEiFghtZ0cX4hz6LY9FVaaGDepVeH9KPA8sR3qC8Ow3GeJUCqVD0/AqSpVJo6SDImhcOOlogBpOa0ChJi6Bbw8MD6GHhD1jdsDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147625; c=relaxed/simple;
	bh=jDKkz6Zix4ySovCgXmnQVLCBYWku0mUzf9t6NVL6yBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X21ylfiEfaIZcsaDlfr1W4gXLaWNgMMEjaulvRHCdyXsD09oztDkueM/T9KoSK9AwZ/WQiWjMVul1ZcFIm4y50D34lCoc52XCMS+rbFy035h/Qoa9Z0aFMgHFEUC+xaICx0WVfe6IHU9y/hN6/Tl83yR0lJddzz5FpxW74j5iH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd05C1pH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BEAC433F1;
	Mon,  5 Feb 2024 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147624;
	bh=jDKkz6Zix4ySovCgXmnQVLCBYWku0mUzf9t6NVL6yBM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hd05C1pHKAm6Cvjop2bGU1QzjL3Jy/u/PScKHBIGsD6T1GQkrK+mNY9daWCLB5Ugr
	 7o5sPpWytjEPQfjC7TZHqNK43Hzh5mRKKpxE44qc8Uy4csAPv/KOgjzMoQBVXLUNYM
	 LiqA0wwC7iFnYdn+cjo9bIUrxrinrPLuyXiMwbuAryhmpd0ZIWow0f3p4l8DHFR+pc
	 0BcHotGujuRrcrO4xIvBRc+JGCkNNfZR9c0qcMvz9McanL3o9vrsn8LcW632gvnCd3
	 Pu1PImAU6cXm4+59htGbVxKMZgTEAjA4qs87nUYozSG8cVqtpzL1Qx2jrALjZ37BS6
	 fGC/0HRoMyZBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B01CAE2F2ED;
	Mon,  5 Feb 2024 15:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/5] netdevsim: link and forward skbs between
 ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170714762471.16310.3984884901020396555.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 15:40:24 +0000
References: <20240130214620.3722189-1-dw@davidwei.uk>
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: kuba@kernel.org, jiri@resnulli.us, sd@queasysnail.net,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 13:46:16 -0800 you wrote:
> This patchset adds the ability to link two netdevsim ports together and
> forward skbs between them, similar to veth. The goal is to use netdevsim
> for testing features e.g. zero copy Rx using io_uring.
> 
> This feature was tested locally on QEMU, and a selftest is included.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] netdevsim: allow two netdevsim ports to be connected
    (no matching commit)
  - [net-next,v8,2/4] netdevsim: forward skbs from one connected port to another
    (no matching commit)
  - [net-next,v8,3/4] netdevsim: add selftest for forwarding skb between connected ports
    (no matching commit)
  - [net-next,v8,4/4] netdevsim: add Makefile for selftests
    https://git.kernel.org/netdev/net-next/c/8ff25dac88f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



