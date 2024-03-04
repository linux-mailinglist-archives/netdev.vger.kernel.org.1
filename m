Return-Path: <netdev+bounces-77037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA886FE35
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B04A1F21849
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED2224ED;
	Mon,  4 Mar 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2LWzi9L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3418EAD
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546427; cv=none; b=pwm6RxpG/XbSk5PM7mfmqgc+84hlBrkreBxhfpm5opR55GF/1xlyfN07PrhpMJMSiHFYPWX2l9tH4nXTUaZKkuj2y0qgkuAUufNDj0DWi0K2NOFQveup7vVgWo26LagoNPGbztJDZSFqUPSHv1wVOsxMG6JtnpzkrlvrlJAjEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546427; c=relaxed/simple;
	bh=/QhG5IY3S1+Bsd+z+qb/NvVEHtl9Al8c33eW84Scq6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XlDOCHmjs1JMLedIyTfvTluuYQ0vPYCwnB2y+35hlOqXmVZgySHG0aBXyww9VoWK+QyNevct6utQSKP62lRQGnFayu1FMD7Vz0Boc9JSrkQXseEdbCeKMiBR6HYGXvDZl4izIB+MU/5jS1+pRuUAZajdhBui4Al+e83540MMPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2LWzi9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0EFEC43394;
	Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709546426;
	bh=/QhG5IY3S1+Bsd+z+qb/NvVEHtl9Al8c33eW84Scq6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V2LWzi9L2VDYUZEdiDxX3na1yKj0NcJNNT0ERByTFXqH5IlCamhGfThDuoenvvpV3
	 vVFxK2tNRDlmR833/uUNoe5XUuWcLFOGUKOCUb4wPtpA2wL2YM3wunawuDPJFX3K9v
	 LDDDopy4a27ogtiDts4Sfi8cJrSAWTHzNQNy3c0xOXJ9UQyq627/B0HykBzO6VHjhn
	 SQ9lZyUqoRigoTR4PaNizWuutXYJIZbHWhL1bLrczuyXWNHZydk6bS3/Je/6uGKiyP
	 LUsnEwPA5U4BnUC9O1dWQI3DTvbQ9MDfGEDUngZEsTegpGiCd2Dtv5zxune9GSUq6Z
	 49HOOIfAxtLjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89216C595C4;
	Mon,  4 Mar 2024 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] geneve: make sure to pull inner header in geneve_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954642655.21816.5794869351787210905.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:00:26 +0000
References: <20240229131152.3159794-1-edumazet@google.com>
In-Reply-To: <20240229131152.3159794-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, fw@strlen.de,
 eric.dumazet@gmail.com, syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 13:11:52 +0000 you wrote:
> syzbot triggered a bug in geneve_rx() [1]
> 
> Issue is similar to the one I fixed in commit 8d975c15c0cd
> ("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
> 
> We have to save skb->network_header in a temporary variable
> in order to be able to recompute the network_header pointer
> after a pskb_inet_may_pull() call.
> 
> [...]

Here is the summary with links:
  - [net] geneve: make sure to pull inner header in geneve_rx()
    https://git.kernel.org/netdev/net/c/1ca1ba465e55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



