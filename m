Return-Path: <netdev+bounces-236542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F578C3DB9C
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 00:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FBF188DA6D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC98339B34;
	Thu,  6 Nov 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5hMLTgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78753286D72;
	Thu,  6 Nov 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470038; cv=none; b=o3Mmrq3WNHknSfNFY6ezMG9x0GLcUbJ8Zl2/KA+QsgULV/fR+JOTRU+wsVbfcdITNDKgCcYO38OWefa1zZVnVSE7X3FpHo2gYJPmzRssFBTmjM7/xv+/d20twW5imb/VcOuodife7QEHpIYS5VSPRkrJhuSuIHdQoNWnu7iCZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470038; c=relaxed/simple;
	bh=nH9ur9o0wv0KcJtvkc2LZ2t1XfruLtSbEK8aE6o+8Io=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xfa3X0zwV3RadSRBYHUpJ58R0SA06ACPOD4aWZYoWg000wtxGJlT0Ux5nyu0n1Jt0eEWVeimUdm8KtLesme+Xou8YlGFIU44Y45eC0QbCfZiLW8gtD6xYGmiBUTMwzW0Ev17i7iPQ5cY5GR9XZP3N3+BYoQ9OeBcAYL5UJJz4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5hMLTgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8C0C4CEF7;
	Thu,  6 Nov 2025 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470038;
	bh=nH9ur9o0wv0KcJtvkc2LZ2t1XfruLtSbEK8aE6o+8Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5hMLTgBEv28F7a1A6RBD/CrX/9w9tEOv5hUvFLOG7gmurjH8aIxdJJ3RvCfmt7xw
	 uAN4QNTwbRtX50OvPsCq2Sl5jM9bCQRksCe34BFXYevhYFnFDtkalYj5tND1jyfAVj
	 maQB0kaLHPGHzOvj7ZaRxsD/sWl5nQr0wdLnJ33DHmZ+PfqHTPiV38845Ibo9K6Liz
	 KVsfY6DjAq1BgmUQRReDmzA6QvGQfV0un9iNjOSxaHymODhikvjGL1MqqB8tXhDTQk
	 rc5P3EdRv+VMNQAArTJ6+hFqIJX2kl2Urw7Ec1HAyre1HDE1JPa6ctixSk9LdBYRzN
	 7XaCCLYwyN2eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00039EF96E;
	Thu,  6 Nov 2025 23:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: phy: qt2025: Wait until PHY becomes
 ready
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176247001049.381420.14772714609952681580.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:00:10 +0000
References: <20251105133126.3221948-1-fujita.tomonori@gmail.com>
In-Reply-To: <20251105133126.3221948-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, aliceryhl@google.com,
 gary@garyguo.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 22:31:26 +0900 you wrote:
> Wait until a PHY becomes ready in the probe callback by
> using read_poll_timeout function.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: phy: qt2025: Wait until PHY becomes ready
    https://git.kernel.org/netdev/net-next/c/8a25a2e34157

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



