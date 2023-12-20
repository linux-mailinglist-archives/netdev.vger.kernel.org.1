Return-Path: <netdev+bounces-59300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D702381A4DA
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B0FB24B84
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DA4878B;
	Wed, 20 Dec 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjpieujn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AE48784
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41039C433C8;
	Wed, 20 Dec 2023 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089224;
	bh=5v6ypfFrCFt0SF8radni2i5+ZpUzHmm+QcgLSA3OvJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RjpieujnTXPI3H0cBnV5sSsH9G+Byvwn8rTxWVC6YUWDb0ovx4QHyokcz/p8uuka7
	 o2khi09Sd2RTy3sgoPamoJ4Br6QtJNYPcvdvqSDzTutQS9k5MKGlMNvH/WFFNVtqxN
	 oFFk00gQI87cZEiTVd2TlAPYm6KE6gDEr9eUA3xJHRLiD6uL3hAwytsUYaXS8iHxDH
	 6PZ6rkeTO20ErbjlU5KtMuDzwK2vAzvoHxmxGcHW+q8qWZS9B82HfC0o562oyYw2Cm
	 5HD3WflVvcDGMr7qCSO8Frl74vEXdpffkTeFOSix6oAwpuPt9Md7JHAhNTqSyA6Jxj
	 hWjdrGJnlUdmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 271EAD8C985;
	Wed, 20 Dec 2023 16:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] ss: Add support for dumping TCP
 bound-inactive sockets.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170308922415.24358.15781406563969082405.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 16:20:24 +0000
References: <ef4e0489be45f59ad05f05f5cae0b070255a65ef.1702991661.git.gnault@redhat.com>
In-Reply-To: <ef4e0489be45f59ad05f05f5cae0b070255a65ef.1702991661.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, edumazet@google.com,
 kuniyu@amazon.com, mkubecek@suse.cz

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 19 Dec 2023 14:18:13 +0100 you wrote:
> Make ss aware of the new "bound-inactive" pseudo-state for TCP (see
> Linux commit 91051f003948 ("tcp: Dump bound-only sockets in inet_diag.")).
> These are TCP sockets that have been bound, but are neither listening nor
> connecting.
> 
> With this patch, these sockets can now be dumped with:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] ss: Add support for dumping TCP bound-inactive sockets.
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ae447da64975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



