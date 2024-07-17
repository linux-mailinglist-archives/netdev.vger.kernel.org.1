Return-Path: <netdev+bounces-111879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB53933DBF
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC24282602
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01659180A63;
	Wed, 17 Jul 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxVu5KxN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7C1802D7
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223634; cv=none; b=UVaPrctFtutPpsKcJ30ie22i710W/dme1xevbF4h4g7fUI9AtuLVWCBMiulc9aSQV4ie6hJKawepdfTXRQMOpFGcJj6+lM+1ks2nYdE+ngDEdw4tfsyYlmWe9sDAkExsMVoyGL3Ty+NarIMufBpoRdjyhvcO0jYkxgkHm95dL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223634; c=relaxed/simple;
	bh=Ernwn1eoZlo8ZbkPi/r1PzY5kSxl2XVa9LbIRGldos4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjhWFO5BqsZPHlAvxY3BmTKK1r2o8/AgSz1V5NekGJHot/g6DfEHsD60/6MVJQ1Lv8opEAGqPCzAbznP++wMrApPadFTaa0wzx+POCvOB2IyKIgdiIJIYea4W7Id2SPmkz77Nota+nLpqTMwkFxuz3dkFT/86Gpa/6Yb8Ha+dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxVu5KxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25A65C4AF16;
	Wed, 17 Jul 2024 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223634;
	bh=Ernwn1eoZlo8ZbkPi/r1PzY5kSxl2XVa9LbIRGldos4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nxVu5KxN6g5TIh7RqtelbJecC8QYgXM6UTQ0PMw4kt4q3lnuzVzml1DtMr1eWEDvD
	 OZSv9Y6Yl9+7M6Zl4pjv0s0sxvGDBy+9anNWyvYpLRvzD7hzKJouZKHU7c5mpS1IIw
	 PrFZwXVUuBAjDPZajdYJe4RYCdyC7bNYBjWLqXpS0VhlJZb4VBAtqt1TxrPkfpbu3k
	 D1xlxLgPaUJy58TcpRnvlv6GVKRObNsbIN9BaBjn6p5fCmExeCqxkxFvR5ufk9kKAj
	 HSpEweugpwdubxI8szGxXVdtsxhuAJpZH/Oq1wH/+Gaq4ML76ZPzX1DGNmlCuSazp0
	 r1epOZSwxH5iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9409C4333D;
	Wed, 17 Jul 2024 13:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: fix s390 build.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172122363388.2499.16136423151584210961.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jul 2024 13:40:33 +0000
References: <5dfefd3e90e77828f38e68854b171a5b8b8c6ede.1721215379.git.pabeni@redhat.com>
In-Reply-To: <5dfefd3e90e77828f38e68854b171a5b8b8c6ede.1721215379.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jul 2024 13:25:06 +0200 you wrote:
> Building the fbnic nn s390, yield a build bug:
> 
> In function ‘fbnic_config_drop_mode_rcq’,
>     inlined from ‘fbnic_enable’ at drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:1836:4:
> ././include/linux/compiler_types.h:510:45: error: call to ‘__compiletime_assert_919’ declared with attribute error: FIELD_PREP: value too large for the field
> 
> The relevant mask is 9 bits wide, and the related value is the cacheline
> aligned size of struct skb_shared_info.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: fix s390 build.
    https://git.kernel.org/netdev/net/c/0e03c643dc93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



