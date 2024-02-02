Return-Path: <netdev+bounces-68490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8A847052
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CFD2944AD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5A145B1E;
	Fri,  2 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHc5UpRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782F14461A;
	Fri,  2 Feb 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877028; cv=none; b=NaOaucKwYVPCpnqyVh2E0+pElLDJU5WdyOx45jJUYajOuKDdWbi7AHX+j/7tFxRsZWa3rhZjpOB5XPA8CNH5OI8LsZvrkFWcn/4jvMNtfSp9tfdNl9Pt0VGRsnR7zECuSl85FYAjTkwm1nVxHbRb3+IGncEEww1u5JXlQPvSdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877028; c=relaxed/simple;
	bh=plRVnWo3cLidU9FUKqA9yG6+oyyfjWE049KtPhHgMTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsr7oIZgq94xWLCBoKAd1BEcBs1A9syCo9NwZSH+uKFOWA8mtIlLny7esEXqtc7fy4pBdNC14rfSyCuwAHVvmmGobFUTNz/iSwdmus7n0hGocD8y9+9xVDHUZUcQGQRtA8nxdFiyKof8wgXPtb3WFxBSB8b0PtfAgozK91M8G0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHc5UpRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56C8C433B1;
	Fri,  2 Feb 2024 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877025;
	bh=plRVnWo3cLidU9FUKqA9yG6+oyyfjWE049KtPhHgMTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHc5UpRMP4Cq6w5REz4SkG8TpD1WuQ5Mo3ISEtPyU+FCah3X28UJrKzySXKsbQ4Ht
	 ILjZaA+mbzAZMYoo6STEeKstfqhyKFQGDUh2sYpQWqpGnE8jJOlUt5chShxFZgVgHR
	 tgZqZSK1TrW41JW1USOzlarPCYzAAEXov7GqL0NUFVmFQuI7TcDcGO4D6JQHmDY2it
	 BmgxCTfH0tH2Y6U1qP4YhKIrUCfgZKzOnJtQswwLprAabdbVjqTxoOQUk9xyMITMAx
	 ubq4moxVmO+TEpJd0hRWSvoLyG6F1dBwHGW8miCtOOvbCeAnJxhhVW4wR3JsofILc0
	 ZceOGTz09Hb/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A76B8C04E32;
	Fri,  2 Feb 2024 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Fix from address in memcpy_to_iter_csum()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687702567.1471.17975786299632818065.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:30:25 +0000
References: <20240131155220.82641-1-bevan@bi-co.net>
In-Reply-To: <20240131155220.82641-1-bevan@bi-co.net>
To: Michael Lass <bevan@bi-co.net>
Cc: netdev@vger.kernel.org, dhowells@redhat.com, regressions@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 16:52:20 +0100 you wrote:
> While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
> address passed to csum_partial_copy_nocheck() was accidentally changed.
> This causes a regression in applications using UDP, as for example
> OpenAFS, causing loss of datagrams.
> 
> Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Signed-off-by: Michael Lass <bevan@bi-co.net>
> 
> [...]

Here is the summary with links:
  - net: Fix from address in memcpy_to_iter_csum()
    https://git.kernel.org/netdev/net/c/fe92f874f091

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



