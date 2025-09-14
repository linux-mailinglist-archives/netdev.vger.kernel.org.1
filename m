Return-Path: <netdev+bounces-222877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7BB56BFD
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BDE7A44D3
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99852DCF55;
	Sun, 14 Sep 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls2s1eC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C88EEAB;
	Sun, 14 Sep 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880606; cv=none; b=XStRiwZVkj3+MPHHvKOEyEmk/0/qU4MfVer4QxbMeQg5bxs062cS06qB4wvIoY/PHU4A2fcbcjY7JCOqDYBbcVPzLkINOKBWRrY7v9372Zu9eIMx4Jhu61X0P7yXCrvZkj52qdC8bndRMTdjGc4JdtjdreZ+lUZ03RBRF84H0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880606; c=relaxed/simple;
	bh=y8qx1rFKnW2anNvansvCmHL9i1lQ79xNOJY8imBfgGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCiN/gKPhDVdIXUvW6ijiXkOl3ZeR8yXeNwDBcOzRy4+OFkLTXch57Fusu+uzo5X4Zs2WvRCLTGy78XSHAZsl6NU8ruCCWRYDWxr0R0q3aB5FBfvfcRPe0WyGKBHcfOwhk7SSaO50aGvRZmkgzsJDBu8g+o61bM5KJorak+1fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls2s1eC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5BDC4CEF0;
	Sun, 14 Sep 2025 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880606;
	bh=y8qx1rFKnW2anNvansvCmHL9i1lQ79xNOJY8imBfgGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ls2s1eC9lLNFHCSjQaYnVpXK2izxLc5nDy0S0GoPsK6C+h3Y0o8vTVM98mFCHh4Vq
	 1R5AXC+hJZ/KfiyM5AfBasFFgFwQqIYnVVAsU3X3Wj6gx6FbvsJXP6WwimvQMZAN9n
	 rvGDDTdRhCCoalBwB+6rBMXCDgJcS3wYiPWfSb6LgTqfxw6KNt3863EGemgVPS3icn
	 RaN/7Uf2pfGGJ8p4PGE9B1IqIRXDpnKznHlp2DHPvgO6M7u93KhMHhrlDd5WQ31Sg9
	 79xzxASA5aQ5SRu1+crx31FIEelspOHj+0HoXaaAJj/5hPJxkFzVHYY0uhXUHRXbyI
	 d9e4cyvlR7Xog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AE39B167D;
	Sun, 14 Sep 2025 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix unhandled errors in
 rxgk_verify_packet_integrity()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788060785.3540305.1142492345242123313.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:10:07 +0000
References: <2038804.1757631496@warthog.procyon.org.uk>
In-Reply-To: <2038804.1757631496@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: dan.carpenter@linaro.org, netdev@vger.kernel.org,
 marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 23:58:16 +0100 you wrote:
> rxgk_verify_packet_integrity() may get more errors than just -EPROTO from
> rxgk_verify_mic_skb().  Pretty much anything other than -ENOMEM constitutes
> an unrecoverable error.  In the case of -ENOMEM, we can just drop the
> packet and wait for a retransmission.
> 
> Similar happens with rxgk_decrypt_skb() and its callers.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
    https://git.kernel.org/netdev/net/c/64863f4ca494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



