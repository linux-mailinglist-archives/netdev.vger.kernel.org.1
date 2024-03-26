Return-Path: <netdev+bounces-82028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C309088C1A5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE471C279AD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0270CCC;
	Tue, 26 Mar 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL6gqJwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1D6F09C;
	Tue, 26 Mar 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455031; cv=none; b=Le4Ozz2tRpTpGD+CcllIyNwr2CMvUSx1o0fW8dfa5MYgm1kqYHx7KI9FgkWxmdw+ebPqDTCeWEEcASqPPPCbni7Jm30ew2hInrX+3rCFMh1o2wlGntjVFFG+jImnTQUCudAJAKh9pqAoZvCaPCVmYCDvGkv9JvgSLU7mpvwg1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455031; c=relaxed/simple;
	bh=a0EZiR5ZF3VP25U2VLBtiwnW6Lc1VH8m8rkFsGfloNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1bOri5TggKAUp/mWCdsqxQdVvN63d5Y6eTVg7t54tokIJyoF30AvnaV4UgbS/fFLVaKn7lt/Om2oERDP0HV5aUBTvqTWm0sUhf1aLehLkD2i2x5dqGC8VvfKRosgCIxD1Q4qcLFpl03GOSVT2abvmASJfbkZGC07LZnbHPVOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL6gqJwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57290C43390;
	Tue, 26 Mar 2024 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711455031;
	bh=a0EZiR5ZF3VP25U2VLBtiwnW6Lc1VH8m8rkFsGfloNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fL6gqJwVwp3UGqPDckS3tkvFJV8Clrln2BscWiVQovoHRqEEu+R6KnhcpaxhqLxYw
	 6uLVdh75Hu6qmy6mA0qGvAu5GKo/e1b41KukQZL+dUsJ5KH4P4KXzYJOQG5bZ8A1oM
	 Pu1dHuJlpgAtVF2ZRPENxBz+LC5YxcsT1XpHtqSNCRHchGsNRrE2Ny1khjy/htMfhB
	 Dtc+aIASwuAN69Urg+k0zBZFTEtwRELGnr/5rqGKG18nuyOJVagXMDjtXKiq2vbXeK
	 p/i/r8tlgNo3eAs+rND/ES9YMfPfGW/x6GQJtbFxvvEnvu4YpTi+7dxiYp18+M1X6G
	 WJ6RLM31TSj1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42BCED2D0EE;
	Tue, 26 Mar 2024 12:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-03-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171145503126.25321.16783504439935417546.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 12:10:31 +0000
References: <20240325233940.7154-1-daniel@iogearbox.net>
In-Reply-To: <20240325233940.7154-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Mar 2024 00:39:40 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 38 non-merge commits during the last 13 day(s) which contain
> a total of 50 files changed, 867 insertions(+), 274 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-03-25
    https://git.kernel.org/netdev/net/c/37ccdf7f11b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



