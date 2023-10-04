Return-Path: <netdev+bounces-37886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0E7B78BB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id CCA4F1F21DE8
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043579F2;
	Wed,  4 Oct 2023 07:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77A1856
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 07:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D900C433C8;
	Wed,  4 Oct 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696404624;
	bh=p4yLinEjIJBrFuw8sXLaLQnAZFkhWiUPbGiv8DnPTD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qLrfTSxxcorg5t4dgwYQ9KAYYXZ1iL19zW+mWGa9Y6BVy2W0gsBct/LFcyWaD/XuC
	 SbTdMVqE9Gcs8b8dbJ5TCuf4bBDkhmNZ8l6ShyFnf/9utRnuo/GPUdzJoVTTT7QsNg
	 p60f6U/92iIBJeL3iVcB/iUjjFYfi5gs5QlSd/PLiBiKPQ4F4nF+GHGk6FnGfFDSJv
	 +/6bFrGSieIFs8rlp+hFIcGCQAjD4YItalzzDLPaFfS1XR1Uzhf3eQerpdRRjv71hY
	 3E6/hp2BgX59AL0LJ7uoXGPEd4Ovw3M9gIwXR1lC8gqpaUf4B8ECh5BeDFDOhi8/i+
	 UJCtjNVUiGbEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CCFCC595D0;
	Wed,  4 Oct 2023 07:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169640462443.26245.17654721515803300599.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 07:30:24 +0000
References: <20230925103057.104541-1-sgarzare@redhat.com>
In-Reply-To: <20230925103057.104541-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Sep 2023 12:30:57 +0200 you wrote:
> In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
> the `iov` has 0 lenght.
> In this case, we should skip the iov and go to the next one.
> But calling vringh_kiov_advance() with 0 lenght does not cause the
> advancement, since it returns immediately if asked to advance by 0 bytes.
> 
> Let's restore the code that was there before commit b8c06ad4d67d
> ("vringh: implement vringh_kiov_advance()"), avoiding using
> vringh_kiov_advance().
> 
> [...]

Here is the summary with links:
  - vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
    https://git.kernel.org/netdev/net/c/7aed44babc7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



