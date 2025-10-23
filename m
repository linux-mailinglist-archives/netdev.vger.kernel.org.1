Return-Path: <netdev+bounces-231965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9087BFF09D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62F003536F7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3E2DF71E;
	Thu, 23 Oct 2025 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2+LWGJD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A423717F;
	Thu, 23 Oct 2025 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191194; cv=none; b=XEBH0j9lRVhByn7nJcALMIuHl2nVRD4CaHhlPfWAig0M0pQ03OWQD8iiEiaZfF4jmA64fY+KlKrlLdkA45INsPSiWnl7TzMMdSUhNNdQVBV5FaaY+Qcl3gHyihVStS0zT0FdkPNj0yDgEScrAOq/i1+FFjq3g+GYynPzzJSpJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191194; c=relaxed/simple;
	bh=R6+qGnRv0D3b1rTURFdmpfihKe/n286445pssQyi9dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bb2uJiNYPp3tBgt60HwsICwGlkIS4ZpfkkoLgIlqvUIwAP5CBHbDeQpcrS4f/6jNZsEzqNuKoOaWx/asNt4DFvmc4ATA+EXoeMvtLJG+MSI2gtI4TDMVjBdCNHztKMNgAyh+wXek1kHtJsAYgI67IoAwqTztN0Qe6via8KNX9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2+LWGJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D987C4CEE7;
	Thu, 23 Oct 2025 03:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191193;
	bh=R6+qGnRv0D3b1rTURFdmpfihKe/n286445pssQyi9dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2+LWGJDAQKDoiCkT+PJ1a+IEtri8Ae8qctAsQ+HJyt7QfFpCRLqVxDyr7JuTL3I+
	 l7bdCxfuZ27baZiUqoSNGpBpQsQLKpCDkGsUNMVZwmuZY8ixhwvRDKd3tGSJVv7+Bz
	 Xcl3yUsoQLzDeroBVifD6oTCtC6y61bsqDmoJdC6y0GFNGBnEv4igbJLkQHDPjo8uL
	 wqi7pVcNWWHRtP05TZVu8rCdSKv563dKmOi23kNRaoP11Ub9nKdN5/bTkU6/bh7v9s
	 xVyP5ncxnlwfnrPpqxjF5/B+0z8opd7AXy+DITE3OV1DYcgd0BUJ/NefY/qPmlW6hQ
	 2DQ2NTW39cqyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1B3809A04;
	Thu, 23 Oct 2025 03:46:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: spacemit: Avoid -Wflex-array-member-not-at-end
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119117374.2145463.16472197208570713304.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:13 +0000
References: <aPd0YjO-oP60Lgvj@kspp>
In-Reply-To: <aPd0YjO-oP60Lgvj@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@gentoo.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 12:54:10 +0100 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use regular arrays instead of flexible-array members (they're not
> really needed in this case) in a couple of unions, and fix the
> following warnings:
> 
> [...]

Here is the summary with links:
  - [next] net: spacemit: Avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/10e0378f05d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



