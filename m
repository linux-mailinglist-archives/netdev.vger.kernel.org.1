Return-Path: <netdev+bounces-147260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C105A9D8C8D
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D897166AAD
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931AF157A6C;
	Mon, 25 Nov 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVX1xvOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06E1CD2C
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561220; cv=none; b=I8FFSjJTH1yLsqh6L0Cge5tvjIKLssBERypuv9Rm8WGBlZR+LZwC+MWUe+tuG6nq7qVdbeCy5irt0wx0QQ6aYimoLHlVU6gtojhDuU9APrf62Xk7JungHK7/cl0i7E/rAAHvYyFq9eF2GHTrcd0f2CzvcXxLPUjnbb9Pj2MKPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561220; c=relaxed/simple;
	bh=V+nI29JBH/YaUXCWXgsHl9TfasPvB+cBwwng/71yIFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDFNQzuz30lqy+0CXohpn53t1Bh4KH4FoP2IM3OmmSiduxIIt7pY4XdzYGEMz4YLoDJZshzEfxQ69S/TuEZ3sq6vTIBtUUVQeEwy5VNuTRdc2zoaf9L7Y88YafdoxLaavEIssLoHHwhNnn8A3poMUjXI1cA3FFCa/+ugOyCM04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVX1xvOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF043C4CECE;
	Mon, 25 Nov 2024 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732561219;
	bh=V+nI29JBH/YaUXCWXgsHl9TfasPvB+cBwwng/71yIFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mVX1xvOMbIk7KctOZNbx7+CraGed1uY3TXM+NmgxF5ganwguRWRZHP0yy6GeCdCog
	 q+mxS3lcRiljV1djBw7H0qflEcxumHKZM3LWwfOFVLXESPzObW+cNwiC1o39tvryxK
	 Ck7KzVgQbF6TvUr9Z5cpu505hFkMILwdq6Ta27co+UBrq9PWTYmFaHLh6GJVrQQ3sL
	 Kxtkhm7AX+x9kfIgNqvFyw00Brvjr+toCgypLMuSn8q1EnrZjZon6WeawpIbW+c1w/
	 89azJ2OPpyfLqDZBnCMQswWgoAvnwv0+RTmY2LXRarJsYhfAWEMH68v6JFKD8AgPj6
	 2/zD1Ojw/IXJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4AC3809A00;
	Mon, 25 Nov 2024 19:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v4] rxclass: Make output for RSS context action
 explicit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173256123251.4006343.6336661823202115514.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 19:00:32 +0000
References: <6f294267b30c93707509d742c34461668a0efc68.1731636671.git.dxu@dxuuu.xyz>
In-Reply-To: <6f294267b30c93707509d742c34461668a0efc68.1731636671.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ecree.xilinx@gmail.com, jdamato@fastly.com, davem@davemloft.net,
 mkubecek@suse.cz, kuba@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Thu, 14 Nov 2024 19:12:08 -0700 you wrote:
> Currently `ethtool -n` prints out misleading output if the action for an
> ntuple rule is to redirect to an RSS context. For example:
> 
>     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
>     New RSS context is 1
> 
>     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>     Added rule with ID 0
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v4] rxclass: Make output for RSS context action explicit
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=54eba3e91248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



