Return-Path: <netdev+bounces-152519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FF9F46B8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394851888EFF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D851DE890;
	Tue, 17 Dec 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+sjDyGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FF1DD529;
	Tue, 17 Dec 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426022; cv=none; b=fBFqMtVmffwGKB0ezRw+/cR/tiImZdfeWWq0L769mqgy4gJ0XirwlVpqcbvanvURw0Ixfhx3qOSSj4bquVCgC/L46Wfo0MOZAsxFnpIe9xefgYirQxPxo0Pab6rwAbdCn8YK6voVxzXHGIhYEbcRHlj5HLJ2dfT8W5ZKiS6nET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426022; c=relaxed/simple;
	bh=UbGKh3Jx/RLRlh/ciN6Q9BqNDd30eBQXcTW+OH5sSCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I//YSitt6B6OkUiVp18fDqlKBG9peWgdH3fF+buvsAh89MaGQ0w3sxpZ1uKeimpEGxHN+s3aF8DQ48Yc/mpfwgds2/jnJZI/TclglEGAsA+m1dtwsw21kuPpcJE4cR8LmUgDVTgIOoN8KYTpwEsmXCWeCqjDucrWqW+iQdKVils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+sjDyGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C499EC4CED3;
	Tue, 17 Dec 2024 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734426021;
	bh=UbGKh3Jx/RLRlh/ciN6Q9BqNDd30eBQXcTW+OH5sSCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+sjDyGEUqUmKPL4KS/AM5652+/9QaGYN98BnJkrYWcL3HIjimOoRc70ftiVBPvot
	 XLl6J5AtWHvCK0cNPI9MljGr7Dvd/ZD4mDERJBTdq+62kKd98eSVaaCZTdlk3Mfsjq
	 XsTP2kXbt0dH2D3itpum13vODrxRbyHRlZbgnAkWAa45LqgYTnvui187Ei2HHgQMnU
	 YOurEVzBixkrs027zcy5vP6Hf93CjNeujuNFBbURi79QZi2px4DBEUObou/DwvRyt/
	 0NziaxzOlDkTEOq/fgJ/42wW/NKjFRY63XVegu09WURhTzsSdYgvkQDTaBdJHIQjlr
	 /94s6hcnyaZwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B073806656;
	Tue, 17 Dec 2024 09:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173442603874.821155.15095548397583191279.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 09:00:38 +0000
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
In-Reply-To: <20241212130015.238863-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
 aliceryhl@google.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Dec 2024 22:00:15 +0900 you wrote:
> The alias symbol name was renamed. Adjust module_phy_driver macro to
> create the proper symbol name to fix module autoloading.
> 
> Fixes: 054a9cd395a7 ("modpost: rename alias symbol for MODULE_DEVICE_TABLE()")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net,v2] rust: net::phy fix module autoloading
    https://git.kernel.org/netdev/net/c/94901b7a74d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



