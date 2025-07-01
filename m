Return-Path: <netdev+bounces-202795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B79AEF04D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57601BC0F9B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACD23507C;
	Tue,  1 Jul 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfXO3EcW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D01EA6F;
	Tue,  1 Jul 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356787; cv=none; b=MJndQonp+21O3qu7NcruCBySN/aYauxzxZDxfsU97blX/9OELViZMi68iSSsHVDEq7ucmq2ezpQUoRX95kcJA0dv+7/7rjI38Ouj9+yyaOpNUTpad+XNhkTlRISpulL0Z3NQyKjoUbIWJI/iBntdFcSN7N1Wdde5mxElLsRnuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356787; c=relaxed/simple;
	bh=/bVoCC58KjG3tC81okaYbYmNMbCNmMB+vqNzzJFatKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p6LfGhpX87bHZhSVcZUx5/qfFfqJJgrZ8AddYiqzkJVGffdsg/FlowfsshjLfKg8Z4pQVl6EbfQV/oB2NU9TyOz/p4w3FEQROQ2jMQVbXUiLfEPLtrNYi6ZTfu33oGS4hxaJZhjGPg3CTTbc+B03afsPQPtCnobXW3zlzpQS3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfXO3EcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B68AC4CEEB;
	Tue,  1 Jul 2025 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751356787;
	bh=/bVoCC58KjG3tC81okaYbYmNMbCNmMB+vqNzzJFatKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qfXO3EcWcBlEGCrTpt5uKHXK8DfkcUhr1pYikCl9KK1EI2ZE/AxMqqpLjT2Klk9Bh
	 NTt6QZ3eqkVRKf6tQdmYBO7/V3pXH8pVDjBtFAigesbYVom5XIxRL/nV8J20M/UhpI
	 hahOX74ujDSDSWuErWqU6amgZJkj/BOrazJFfK5GKjqrDFFU2Dqqbhc2Jl+0Hx6X5A
	 HerOnwsCI8CQ5duL+B3dmp024gKYqyGa+JSvl+p+4R8wJA7TkRUSOoiT+qIqLqNz8v
	 2/KbGDcsTsJ5U955QoCb9uPZDjAb2iLTbwAfoKp8bBxhq5Cs27FHAx5wi55/TqsbLd
	 oaCF+xLL1MsRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6D38111CE;
	Tue,  1 Jul 2025 08:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Clean up usage of ffi types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175135681200.3705465.5362877571191623980.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 08:00:12 +0000
References: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
In-Reply-To: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, dakr@kernel.org, davem@davemloft.net, andrew@lunn.ch,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Jun 2025 05:25:37 -0700 you wrote:
> Remove qualification of ffi types which are included in the prelude and
> change `as` casts to target the proper ffi type alias rather than the
> underlying primitive.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v2:
> - Use unqualified types.
> - Remove Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] Use unqualified references to ffi types
    https://git.kernel.org/netdev/net-next/c/22955d942f28
  - [net-next,v2,2/2] Cast to the proper type
    https://git.kernel.org/netdev/net-next/c/c9a7bcd2c016

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



