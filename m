Return-Path: <netdev+bounces-149342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AC9E52EB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94041284220
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5001B0F19;
	Thu,  5 Dec 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaSHIPDf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AB2391A1;
	Thu,  5 Dec 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395817; cv=none; b=SEX2Fus/CwBfn2ZdKWFa31cP+6tP8Meycah7AKjXKGPKAihyDPJBieFEDg702B/C6c2aJW4D6kw5aftD26srCcxBcRWcXO1+5PAsmmj/P6aYfCalnJPiNBreKXUsNqad9VCGPJs2/BPJtincbLhd7oNj5GeMLPJ8eAI594q6tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395817; c=relaxed/simple;
	bh=hC/g/ej9iegvPjoYKMnZE1MKWG6g0oMR4/9cGEHr8+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a9QWVhQCrqksY6AEFANYBwwgujHsDlGeM4QNhy08AU8mIKXg+HRdaUHaCCOuv0wSY5gCh1NaYyexEaTy8NmBzdFBG4Y3HmJ1MpU9WpB1qrpb1FGZTFGYnvDnyHXSgdsJVgghzGruiGhVrcyf3cZJDswcERhy540uOtYL1mugvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaSHIPDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A18C4CED1;
	Thu,  5 Dec 2024 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733395816;
	bh=hC/g/ej9iegvPjoYKMnZE1MKWG6g0oMR4/9cGEHr8+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaSHIPDf9qVi7iNe6O0AMe2/c1FiuAPQtxgmI2jrOSLEuaxK7MgpUm8HNGVXxQuir
	 rkzCoR7JAsEDPO+ocgyndm4W187ANUqgwseVV1lUsYAmO5p9bh7WYYffcMtPTDdNxw
	 bEmuQnqo1i9YKR223WYgy2vKHNMByeCBldOTrCmMVDVPuUWHqQIPNJCpasnfxpokzf
	 5WT7PDOh7rBGgHRG7qfKGZD/P5Vw2ohsoljSl+jTrsWn3mBcVNhUCT/8QBg4bfhhYH
	 0sFnzgUMepiWzxA3Ls86NHaAjfDBzfBPhnpNNNFzd45PN2Z0buaSxzV85ST6VaSOZq
	 IS3WFKACkHfOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4F4380A94D;
	Thu,  5 Dec 2024 10:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 0/3] vsock/test: fix wrong setsockopt() parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173339583150.1545533.78880242047414570.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 10:50:31 +0000
References: <20241203150656.287028-1-kshk@linux.ibm.com>
In-Reply-To: <20241203150656.287028-1-kshk@linux.ibm.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
 pabeni@redhat.com, AVKrasnov@sberdevices.ru, mst@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Dec 2024 09:06:53 -0600 you wrote:
> Parameters were created using wrong C types, which caused them to be of
> wrong size on some architectures, causing problems.
> 
> The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
> didn't show it. After the fix, all tests pass on s390.
> Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
> a similar problem, which turned out to be true, hence, the second patch.
> 
> [...]

Here is the summary with links:
  - [net,v8,1/3] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
    https://git.kernel.org/netdev/net/c/7ce1c0921a80
  - [net,v8,2/3] vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
    https://git.kernel.org/netdev/net/c/3f36ee29e732
  - [net,v8,3/3] vsock/test: verify socket options after setting them
    https://git.kernel.org/netdev/net/c/86814d8ffd55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



