Return-Path: <netdev+bounces-66407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DA83ED78
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520731C21004
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01020DE5;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjtBF3Uv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FB1E4A1;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365829; cv=none; b=K3SAt4AmXMRKc751tUrG22k/0XUzAZ4rbonEqF5k6o7Lq3z0sM7HdLERmSv9+WwrfsjKfaGRx9a9FiQ/GuFARktG7zKQnjzB9w58Clgvgpiufi/uDXkIndix6Vn7dyADgCLpXLgFMz/4FpuZ2V9WX789rVmKbmo93SOOSBsjZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365829; c=relaxed/simple;
	bh=+8O46d6Oc090iOL45O2e1rPIGLbr5cWttyA0AzVbMIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l8M9AS85EqaSCoHkFuaenSC/HZXM1ZFbJUBPpNBoWbmugx/wu1zEqanZVjGjcQ4FrCqwP8itDMORqbZ0xCzX39XOA8CB5XeK+TEjbWyRgDZIhoyozrQQmBHsZyV9oWnbCLNxLqSwXmhLchgGK1vZNkhG5jLIgPwloJpOQlKmJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjtBF3Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEE5C43394;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706365829;
	bh=+8O46d6Oc090iOL45O2e1rPIGLbr5cWttyA0AzVbMIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tjtBF3UvF9rIdagK3lXDoMv5PfFTs30BZUR949og8sbWmdQhP3u8aj7EgWwpUIxfJ
	 qL2ufhHxrO6bPV5C62R2qw4lYnyzF81CspiNnZFiC8z+5exnMIPy9FL04wkxmNcT6j
	 GPaCx+B+wU76I95B0F6jIT0oz/SXAB745TjKV4mIhnCtSbU/MP4s7klFy1N7n6ZNEW
	 RDF57pM9XLhIudG43Zq+uOQa5LNWAmUgpymnhDyKjjNiDlTLL2NEXHfypAhdZrUxTe
	 WBfnTFrw0YRU/+YFOcfN1soPfRp6DCCJAW3s9p0A3Owu+22rfhCfV2/bUYo+CookqJ
	 ZuPdjG95uF8qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1561DD8C97E;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rust: phy: use `srctree`-relative links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170636582908.20177.384966136875153449.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 14:30:29 +0000
References: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 10:45:01 +0900 you wrote:
> The relative paths like the following are bothersome and don't work
> with `O=` builds:
> 
> //! C headers: [`include/linux/phy.h`](../../../../../../../include/linux/phy.h).
> 
> This updates such links by using the `srctree`-relative link feature
> introduced in 6.8-rc1 like:
> 
> [...]

Here is the summary with links:
  - [net-next] rust: phy: use `srctree`-relative links
    https://git.kernel.org/netdev/net-next/c/1d4046b57142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



