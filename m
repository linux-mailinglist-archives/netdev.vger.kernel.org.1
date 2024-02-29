Return-Path: <netdev+bounces-76008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E858386BF9B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F9EB230BE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1D381DE;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aET33Ubk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44156381B0;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178630; cv=none; b=XRIutXejTyrvBsQLtwCCUuaG+wkXBZ/Izsj4OXpqyXAlCIAVO/EIj0hjlCDKiH8iimAKjmnxmGGqDgGVPSgCgxLI2Tff07DiIyGoPIsMACWxtPORIouY7D0T0qxuCKcUWXfb/FQOAMjfwo4FkQSalzLNcvsm8IO8Q0ls7JgcFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178630; c=relaxed/simple;
	bh=MfMldXAflkcI5MLIcwyBc7GLJ6N/aXbliB4JGKN3ggc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDbdZ5BhUAfUkrZZCd/QP++ef7ie+phuKFS9unQ5eLbexEQsdwTOHEpmlEcRHlfDS+AOm2T+BtjTaAHu1yuk/SSHtuEqpfSb34es/VMT+8ouQd49H8IRn4xpBe5pLVlTBUJTyF2aGygxK8jrpZfkXrdSK8OeSjFHt+kXrRYlMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aET33Ubk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C47FDC43141;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178629;
	bh=MfMldXAflkcI5MLIcwyBc7GLJ6N/aXbliB4JGKN3ggc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aET33UbkB41otkfz7xKnDIKD1L5x0Cm7PqLYPmieEYpIfaetNBka664jXVsru1R6d
	 1Sm8uKOy7C2RCUou/xB46NNbxy9vpugIufvp/eskM3snDiUAGbOjJCtXtw+jhfaixW
	 feSaHA8jLd6jFKo/8S7rcNEnfC4/QPt5MQLSZUP/vOsMXD18y4ZfAMd2LuQ8jx6LKG
	 7FYGvFExbJW7wFZNQRtDshAthqrlHJWglxhXkKwb8IapmKnC3PjkBW34qbJX9EKZyT
	 YPIsAuYf7QZM0Dc2xLElAqb4Gc48yZaRksgObcxB8DMI61/4gohwalYeIwa1ZRuLta
	 1BjGPdWF9T2ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAE93D990A9;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlabel: remove impossible return value in
 netlbl_bitmap_walk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170917862969.28712.6589054034041856945.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 03:50:29 +0000
References: <20240227093604.3574241-1-shaozhengchao@huawei.com>
In-Reply-To: <20240227093604.3574241-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 17:36:04 +0800 you wrote:
> Since commit 446fda4f2682 ("[NetLabel]: CIPSOv4 engine"), *bitmap_walk
> function only returns -1. Nearly 18 years have passed, -2 scenes never
> come up, so there's no need to consider it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv4/cipso_ipv4.c        | 5 +----
>  net/ipv6/calipso.c           | 5 +----
>  net/netlabel/netlabel_kapi.c | 2 +-
>  3 files changed, 3 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] netlabel: remove impossible return value in netlbl_bitmap_walk
    https://git.kernel.org/netdev/net-next/c/9ff74d77180a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



