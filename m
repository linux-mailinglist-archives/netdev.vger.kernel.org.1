Return-Path: <netdev+bounces-217532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B9B38FC6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8205E3376
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDA1A3160;
	Thu, 28 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueCfxH7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D391A256B
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341004; cv=none; b=cRuPM7T6tdgxoQGicnImW15INNIEDguId9Mq+uXihzH3LE5FxOE00B+IjZ+ddjxWHLgpUQX/P8UhdMpd5FcoBjp8X2AbmJfjMB4n/uORiqfedXd6fKx/kCMekVjU0RJfGna2ElW/d8WXwzpZkBGBpziNIO264UZ3hEUb4YoqUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341004; c=relaxed/simple;
	bh=YsQrY14JqCbf4Yz3Fm54MlzqbEGi5Nw6dKAmsf5mIV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pfzf43hCTMK8SCixLcpwNF+el/UNhxhthry7asFH01PT+pgreWJ/iR7iQ4nMd5WA4G6jbaOWNYxTro/ITNwl/WJ7uHqXJkd3Oep3erEYBLo+rO/0EfPW0Zt/c1X93/RtZg4y3JE3cJH9asVO9DvbevV0U0BQNiVO0i2Sih9T6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueCfxH7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4460C4CEF5;
	Thu, 28 Aug 2025 00:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341003;
	bh=YsQrY14JqCbf4Yz3Fm54MlzqbEGi5Nw6dKAmsf5mIV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ueCfxH7kPkCUoQJ2dufmIrGWmNb06hoM50OjoaBOmDC2nQOEHNwdKzXjy/cEktzJo
	 y8G9J3WcD0K80tEtGWm8XXsgkDqnFKqrTUpxDginDphcYNOFzHlEJnkmlCWvu02c49
	 u3OSTXQAaL0021wYVJwoZ0WUiiG4rgK/J2fknSJ1XrLDibQCC9M9DXZdGP4xqPQMsu
	 EhfVbzL3d6imE7tdiE2NluwwkgqGLjFWfsh3plE+WzUijcuWzr47+bQdMypQIL7azl
	 y4i2lCyaHX4l4KXQo7X3znlzzfbsi7mohzDx/+OPsDVTanjJu6MxXpmBtZ0C02+sIb
	 7xXnNCbfYlqig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B9383BF76;
	Thu, 28 Aug 2025 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: do not use sock_hold() in
 pppol2tp_session_get_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634101099.886655.13279428145281475261.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:30:10 +0000
References: <20250826134435.1683435-1-edumazet@google.com>
In-Reply-To: <20250826134435.1683435-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jchapman@katalix.com,
 gnault@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 13:44:35 +0000 you wrote:
> pppol2tp_session_get_sock() is using RCU, it must be ready
> for sk_refcnt being zero.
> 
> Commit ee40fb2e1eb5 ("l2tp: protect sock pointer of
> struct pppol2tp_session with RCU") was correct because it
> had a call_rcu(..., pppol2tp_put_sk) which was later removed in blamed commit.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
    https://git.kernel.org/netdev/net/c/9b8c88f875c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



