Return-Path: <netdev+bounces-43547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688447D3D59
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DDFB20DED
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B83200AA;
	Mon, 23 Oct 2023 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4OrmJaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EE1BDFD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3B67C433CD;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698081623;
	bh=8wJ2hGQyW1ZDhxLvU7RULva6us8h44HlAX939DZ04Ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e4OrmJaT4ohO0rA3kBvG4WlKLzJrI4/cFj8vII3dOFjxtByOHvWg6m306HxdQiUNO
	 S3iSLbnbDt6Scxpfx54OnKs9ZUvFnwfzU+JpPT8u8uhlbc/ZjQ61DBdrOZ+qSncg52
	 trXUhMkEEXcmRhvJ4XUWKa3V8sFDrTtsQwZX9xtGw88SyssKG3zUeL9eSaVluNyZPh
	 CRonBNXETvurUylLvmw1Fqhq9YEKtECBc898Jb0Poz4f3vbgVKDw2X1ryKwr8iiYHP
	 jyPPTqdrRsxgRFG19BUP/YjyML7o0Yt7Ejq7X3ajkZUzeUTI3BlD04L1pdg7B70PC3
	 uvsuoCCuGwJ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CD77E4CC1C;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tls: don't reset prot->aad_size and prot->tail_size
 for TLS_HW
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169808162357.28677.1601659913909570142.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 17:20:23 +0000
References: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
In-Reply-To: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, borisp@nvidia.com,
 edumazet@google.com, kuba@kernel.org, john.fastabend@gmail.com,
 pabeni@redhat.com, horms@kernel.org, ttoukan.linux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 16:00:55 +0200 you wrote:
> Prior to commit 1a074f7618e8 ("tls: also use init_prot_info in
> tls_set_device_offload"), setting TLS_HW on TX didn't touch
> prot->aad_size and prot->tail_size. They are set to 0 during context
> allocation (tls_prot_info is embedded in tls_context, kzalloc'd by
> tls_ctx_create).
> 
> When the RX key is configured, tls_set_sw_offload is called (for both
> TLS_SW and TLS_HW). If the TX key is configured in TLS_HW mode after
> the RX key has been installed, init_prot_info will now overwrite the
> correct values of aad_size and tail_size, breaking SW decryption and
> causing -EBADMSG errors to be returned to userspace.
> 
> [...]

Here is the summary with links:
  - [net-next] tls: don't reset prot->aad_size and prot->tail_size for TLS_HW
    https://git.kernel.org/netdev/net-next/c/b7c4f5730a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



