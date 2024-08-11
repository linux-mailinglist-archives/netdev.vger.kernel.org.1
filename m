Return-Path: <netdev+bounces-117449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89894DFE3
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 05:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1743CB2114D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B901DE56A;
	Sun, 11 Aug 2024 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox6WnX25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94368DF58
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723348372; cv=none; b=c5i+jwsandBsdfLuRVGx87Z7DORHeCLA20dPcHQD7p+6P2mj6SzbwsFRF2AsE1Z/PfzvKZGYTi3uJ6tCL1LaGmBzawTybH5fwxlsEHxW16mOqtY/gwt/GnHqx7eg+DurRl9JPGwnaJQYrw4VklmeiQvWHYdb8LgT+niUY/FCsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723348372; c=relaxed/simple;
	bh=M33X5xjqC/YAnxZJcAjzlit2N6z6jxtR4vl7L1/TLWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g9x1Yb7Bo0BPlZNuHmQ/YVrf3ncdQN7O4KUdpSo6GYnxG9M6ud1Q2KDjuIcX+/3kUG5TJUsKi8dHpx3FI1zkCRc95Bh0rMXmRbHCiG5TWdhEN19f8FrEfNqNt2OH0s1UPSe0ZFjIz90Mt1GSgQRa8cX5qKEh20PkF4aRwRyIzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox6WnX25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C003C4AF09;
	Sun, 11 Aug 2024 03:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723348372;
	bh=M33X5xjqC/YAnxZJcAjzlit2N6z6jxtR4vl7L1/TLWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ox6WnX25Ypg6hEZcIFsM9jHsC1EF4Xc4etNTNeYVrIGeF9UFfx7HGNPX1hd6TQtb1
	 vXuTq9mw7qTqKTOUmiYsLVngWhBs6q9UxnQSWAcpFUY4bRixQZpMyuqx25aFmoxGD1
	 LYZBTQRHl93rwMu1ssDJtzBAGfROkaq7HYd3HW47HH2C50EYmWh1FqU9Mm4JiYOIju
	 D3PVf66NmOShw87bOSzeZ8jfWe49EW8HFVE3qYzPjSBZoHwzgYe1oPYj9LHoEVCklC
	 qR6SADmq9xv/OT0QpkQhtWjbsifXj+hdRS7IBPVuWSawHJjMNNKovnJRhCi1BCmIwZ
	 O63hX0p9dX1uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D183823358;
	Sun, 11 Aug 2024 03:52:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/9] l2tp: misc improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172334837098.125619.7298380307324174222.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 03:52:50 +0000
References: <cover.1723011569.git.jchapman@katalix.com>
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  7 Aug 2024 07:54:43 +0100 you wrote:
> This series makes several improvements to l2tp:
> 
>   * update documentation to be consistent with recent l2tp changes.
>   * remove inline keyword from functions in c source code.
>   * move l2tp_ip socket tables to per-net data.
>   * handle hash key collisions in l2tp_v3_session_get
>   * implement and use get-next APIs for management and procfs/debugfs.
>   * improve l2tp refcount helpers.
>   * use per-cpu dev->tstats in l2tpeth devices.
>   * flush workqueue before draining it in l2tp_pre_exit_net. This
>     fixes a change which was recently applied to net-next so isn't
>     suitable for the net tree.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/9] documentation/networking: update l2tp docs
    https://git.kernel.org/netdev/net-next/c/e2b1762cf32f
  - [v2,net-next,2/9] l2tp: remove inline from functions in c sources
    https://git.kernel.org/netdev/net-next/c/168464c19e1a
  - [v2,net-next,3/9] l2tp: move l2tp_ip and l2tp_ip6 data to pernet
    https://git.kernel.org/netdev/net-next/c/ebed6606b959
  - [v2,net-next,4/9] l2tp: handle hash key collisions in l2tp_v3_session_get
    https://git.kernel.org/netdev/net-next/c/b0a8deda060d
  - [v2,net-next,5/9] l2tp: add tunnel/session get_next helpers
    https://git.kernel.org/netdev/net-next/c/aa92c1cec92b
  - [v2,net-next,6/9] l2tp: use get_next APIs for management requests and procfs/debugfs
    https://git.kernel.org/netdev/net-next/c/1f4c3dce9112
  - [v2,net-next,7/9] l2tp: improve tunnel/session refcount helpers
    https://git.kernel.org/netdev/net-next/c/abe7a1a7d0b6
  - [v2,net-next,8/9] l2tp: l2tp_eth: use per-cpu counters from dev->tstats
    https://git.kernel.org/netdev/net-next/c/dcc59d3e328e
  - [v2,net-next,9/9] l2tp: flush workqueue before draining it
    https://git.kernel.org/netdev/net-next/c/c1b2e36b8776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



