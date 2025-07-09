Return-Path: <netdev+bounces-205214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26DAFDCF2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F066580BE7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE6185B48;
	Wed,  9 Jul 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mILgQoPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658B1865FA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024603; cv=none; b=J6NsEsIjWmklEqln4loe/3U8GIvNttJw5FeNJMFWTCeCAUgGCDkNNE1iPfZW/ErctZnvE4yPV0BKlP5GIgk4fRYsCXraIi8EkF7Tep6GYYWvKT9nKJYVARU15mMnXhi2SdY9VQo+6gCrWKh2Yjd9IgWC3tdCCf5th5GmqtJqRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024603; c=relaxed/simple;
	bh=IjHEZZ0orhwPj02urZcBVPD6WjdFrLjxddI/K67lI0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6UmXldMva9SpG+MJDK7HPhSYp5/hSKlASerGV9Fgq0K/xsQiSHoz0M2o91rUeXieqZcXSesan7qp7SRo2D0+HUzcuesUGfXuFB+BhFXRdGxgx1Y5D1Kqrauz0eCqipRMwTF4XfNKT03MJ/orWD0VjsIrshaGb+yYw0FtRO6jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mILgQoPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF664C4CEED;
	Wed,  9 Jul 2025 01:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752024602;
	bh=IjHEZZ0orhwPj02urZcBVPD6WjdFrLjxddI/K67lI0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mILgQoPo9uOoE1ThAo4mYcra1QcG/Xsx7eqoiPDouYVRitN2z1C6lt1EqPIA9aIdP
	 iaZ0iXdNsLzGk1NfVRB31WUBbEnbQ7tC+jFQ3ShGdyoG7u5Pc31LepKtRHBwtGXSfk
	 SjHMAh18MdxpGelXlFGgSYEvOBxbKoisXG5i2qDXHB1HCTsf9x+bDsn/+PfcX/dLLc
	 ADYibbb8Eamn8ws3iRIPYlHyZu+bO4RFqQJA9Fsz39CYBk16fAhNoo2DCaGwlKYrZq
	 +Am694Dzcuo9vBu0y2axjqHngbgdkb8MfSntP5jplbIR4FQ0dBhKpH6DFWyZNfI75R
	 qCw+Wm30CDxKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCED380DBEE;
	Wed,  9 Jul 2025 01:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/7] af_unix: Introduce SO_INQ & SCM_INQ.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175202462524.186229.12251717755421668788.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 01:30:25 +0000
References: <20250702223606.1054680-1-kuniyu@google.com>
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 22:35:12 +0000 you wrote:
> We have an application that uses almost the same code for TCP and
> AF_UNIX (SOCK_STREAM).
> 
> The application uses TCP_INQ for TCP, but AF_UNIX doesn't have it
> and requires an extra syscall, ioctl(SIOCINQ) or getsockopt(SO_MEMINFO)
> as an alternative.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/7] af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
    https://git.kernel.org/netdev/net-next/c/b429a5ad19cb
  - [v1,net-next,2/7] af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
    https://git.kernel.org/netdev/net-next/c/772f01049c4b
  - [v1,net-next,3/7] af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
    https://git.kernel.org/netdev/net-next/c/d0aac85449de
  - [v1,net-next,4/7] af_unix: Use cached value for SOCK_STREAM in unix_inq_len().
    https://git.kernel.org/netdev/net-next/c/f4e1fb04c123
  - [v1,net-next,5/7] af_unix: Cache state->msg in unix_stream_read_generic().
    https://git.kernel.org/netdev/net-next/c/8b77338eb2af
  - [v1,net-next,6/7] af_unix: Introduce SO_INQ.
    https://git.kernel.org/netdev/net-next/c/df30285b3670
  - [v1,net-next,7/7] selftest: af_unix: Add test for SO_INQ.
    https://git.kernel.org/netdev/net-next/c/e0f60ba041a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



