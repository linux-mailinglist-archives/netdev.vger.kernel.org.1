Return-Path: <netdev+bounces-50608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433A7F649A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDFE1C20DD1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105323FB32;
	Thu, 23 Nov 2023 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UthFXOJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAF3FB2B
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2783C433B7;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758826;
	bh=c1xQdKu33/2/hzLvS6W0JiVMAuAHBG5kYzsJtKNVht4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UthFXOJBPFmYIunQY/p6IYFXB+AxH9hSI+ir01MRWXSYWHCudEPvLRsyb46Nv9asc
	 ZAVXcSu2bhPlzvuXL2qu7/7aYF+uhJG78HazYUp1sce2xE1pd/31SKZeCIfhaRjorG
	 pFt0uecXIdvg28tlTMIQqyX2ogu2JVtFeDjT+0hZOoZCRLGx31cE8yG0Puzp2sARpu
	 WqZ9TQTygSsbIVXZRqIywzzB4hkP6kVHot1lsFNvl6Cfv0tbOtQoGKiZ0MI9SUiNHr
	 r0Bkl+AIaRGQq4IDqFTQjCf/Yf2nRF5ukubFXz+2WRYr4jzjiSNKdGO+3lNKRBNJCe
	 CAsRgS+zLA2Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 911F5E19E3A;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty
 record
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075882659.541.15438374448743865458.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 17:00:26 +0000
References: <20231122214447.675768-1-jannh@google.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, dhowells@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 22:44:47 +0100 you wrote:
> syzkaller discovered that if tls_sw_splice_eof() is executed as part of
> sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
> gets confused because the empty ciphertext buffer does not have enough
> space for the encryption overhead. This causes tls_push_record() to go on
> the `split = true` path (which is only supposed to be used when interacting
> with an attached BPF program), and then get further confused and hit the
> tls_merge_open_record() path, which then assumes that there must be at
> least one populated buffer element, leading to a NULL deref.
> 
> [...]

Here is the summary with links:
  - [net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
    https://git.kernel.org/netdev/net/c/53f2cb491b50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



