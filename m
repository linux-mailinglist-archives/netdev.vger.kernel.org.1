Return-Path: <netdev+bounces-140056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF59B521E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946701F2450E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F5204F66;
	Tue, 29 Oct 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNMzp12B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573519995A
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227837; cv=none; b=F89L85LM12+ITja6OT4+755GtXCA/fADzTBopY8Id0h//H862OS+I5Q7OF4xkR52umvq+UfNmQ7+tbM8dvBqWzOq60/og+Isb7lZshyU2No4moXov2eQwOxSZyRDceGDTzRr+Wv4P8Gc7KbdpRG0DxIQdbfcSjZWAaH4t9yLUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227837; c=relaxed/simple;
	bh=ZKgCcpljXpNAa/Ou21ekGkyLepKWU2GgGv6RM2b/yzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EWrU4ftWCnMBJOMCUD7mJiuGBwqjA0VWE0S3mMsqz4u2iVebOBmsrSEbK44FyptsesLzUMwGTGi9QdIzaonP25f5dQ7ir9P4sCOaFXJAjsYrisZSZAO4mFNZqg9gL7ttLc6sVwOumM4eqy+upEsBQFDSNKYz6L53fISiPDBZ7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNMzp12B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B131C4CECD;
	Tue, 29 Oct 2024 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227836;
	bh=ZKgCcpljXpNAa/Ou21ekGkyLepKWU2GgGv6RM2b/yzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jNMzp12BB3c1ZEwButIb0e/jb4BtKmKn92tyZ8AP9begNQPDOvVbQq/mrqgCRdi6p
	 CJZxpHRShZ+x2n8ruIZDJJFefkWFV722EaYOQWjNwvQFuFQdoNHpS2gd0AAHGlxT1C
	 Ukl2V43Oiqga1Li3fvhjed61Kac9jfWAPFAX4WZtiX2BPapCD4LoRkq2ELOstnE0EO
	 LcaSL4AZ59ABdAKilfK/L4tHHG0xjuFTvOoJDQz31J4wj0TUE9r+U5LMNhBCMcDfHI
	 9aq5mmUCDYAH8Z1o9FrkcTtwbA2pVKGZnBrLrQ6UdGl/5uyC2PuRjm1QsWYgahg4uF
	 Ck+3LtTefk0dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E46380AC08;
	Tue, 29 Oct 2024 18:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] ipv4: Prepare core ipv4 files to future
 .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022784423.787364.13867431167954708409.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:44 +0000
References: <cover.1729530028.git.gnault@redhat.com>
In-Reply-To: <cover.1729530028.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 idosch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 11:47:52 +0200 you wrote:
> Continue preparing users of ->flowi4_tos (struct flowi4) to the future
> conversion of this field (from __u8 to dscp_t). The objective is to
> have type annotation to properly separate DSCP bits from ECN ones. This
> way we'll ensure that ECN doesn't interfere with DSCP and avoid
> regressions where it break routing descisions (fib rules in particular).
> 
> This series concentrates on some easy IPv4 conversions where
> ->flowi4_tos is set directly from an IPv4 header, so we can get the
> DSCP value using the ip4h_dscp() helper function.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ipv4: Prepare fib_compute_spec_dst() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/b76ebf22c578
  - [net-next,2/4] ipv4: Prepare icmp_reply() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/0ed373390c5c
  - [net-next,3/4] ipv4: Prepare ipmr_rt_fib_lookup() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/6ab04392dd08
  - [net-next,4/4] ipv4: Prepare ip_rt_get_source() to future .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/85ef52e8693c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



