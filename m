Return-Path: <netdev+bounces-247243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4ECF61E1
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D02C9300875D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0491F0E29;
	Tue,  6 Jan 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCiWX1GF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57B1EF39E;
	Tue,  6 Jan 2026 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660817; cv=none; b=Y/Lcea5J+I2RPzwx5lQo27NlVBfCrweqkQmbTCgwViytLJ0vkR+t+B4Ws6xgSHXeRWdwKVhAD0A9Ju/gkMqWQ5zD1YEdNw9EVMEwfqdZmZtzj6E3SfNQDMYy6jtubso7NXe28TLoDwvYemZsuxK90778PPiFmAhhGwdPKfG9Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660817; c=relaxed/simple;
	bh=4xWN1bwzbgN5DPUomxioMqX4PBUFAK4DzQGzQSGDBEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qtloj+1FDjEn+NUVNtszUyQX/EQHNtMFUHFHwjoNatH96KU/h4eW29Nw5CZQgU597f3RQ2vCv28QsoIH1dzz8hU7NkpMq/7Koym0+PpSKsPWAIrwYjQv83SVgVPy0CiGiRqPTlPOFcQlNY2BQHq9Ued3Eh7co5MxH+VxzqTdlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCiWX1GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B71CC16AAE;
	Tue,  6 Jan 2026 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660816;
	bh=4xWN1bwzbgN5DPUomxioMqX4PBUFAK4DzQGzQSGDBEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCiWX1GFTww9t2XrrAle1xK3H4ENzTP7Nz+5pJzhmZTv0p5E4Ggspo2ITv/3xxyHO
	 m9vU8eo8D8w5U/H8A8tKBK1lZqPCD0sN8bBxVmdZBjXmNSecHfH5++MQI+NateAHkw
	 5eFoZ/kVf6VPjeERB008Poj6VlH7yQXMcb2hH7gX6QwCaUtjABzgFcyGfL5XY8nE6J
	 4rMyoCX9MLJqKftvn6Ai4tfuEBsaf94z2UKnlYPFsDfFChsuPysMcwiEdmaRTfKBsV
	 CCzookdZOBV90WruFYlaGO7Zi7q+YjaVCj2tW2CkEzd0a8VNUCOHb8UvRk0h8lPIP9
	 BWx9Vx3sFPFgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B80380AADC;
	Tue,  6 Jan 2026 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] rust: net: replace `kernel::c_str!` with C-Strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176766061426.1346422.17052893149146776757.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:50:14 +0000
References: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
In-Reply-To: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, tamird@gmail.com, gregkh@linuxfoundation.org,
 daniel.almeida@collabora.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 03 Jan 2026 21:24:26 -0500 you wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v2:
> - Pick up Tomo and Daniel's tags.
> - Link to v1: https://patch.msgid.link/20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com
> 
> [...]

Here is the summary with links:
  - [v2,1/2] rust: net: replace `kernel::c_str!` with C-Strings
    https://git.kernel.org/netdev/net-next/c/7a8461a2a8da
  - [v2,2/2] drivers: net: replace `kernel::c_str!` with C-Strings
    https://git.kernel.org/netdev/net-next/c/5a69d30f30fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



