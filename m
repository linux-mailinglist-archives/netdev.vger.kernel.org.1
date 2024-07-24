Return-Path: <netdev+bounces-112777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941E693B28D
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C604C1C23662
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941B158871;
	Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeTLA2Gu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327621DA26;
	Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830832; cv=none; b=dByQiZRZHZCytJ9OgV9Hi/XmGAkBgvgjxEdJyFYweo/hFbbhqlX/0X7SiAcPUYzt43+YHzY+si4uwEie/Jen0QURtAVxLlznPtUX+CkYV+sM8DP5rTbyBAd8uGcgFMkrq+fPnfCRY3Ddqe1thrrjd2Gkg8HM63h7yeEdPUxvYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830832; c=relaxed/simple;
	bh=J5/Me1+XnZ22kZOEKDyoSGw9tbK3RZSpPcrWZc2vqrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ktwBWRap2TgOiq9HeJvm4Q+vaALFV88/hSWigvQjETA8fz2JoTSSo7I+HzKr34FoQ/3evCD4scLBLSJz3d6gl8rZO2KTTyONeMwMNG4xGU+ymUUV0mgk0fekBdzqFqUglf8VWQc7t+0ZwkiLqXiMB1nh2bdSHQqNQTDKGOmooi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeTLA2Gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF9EFC4AF09;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721830831;
	bh=J5/Me1+XnZ22kZOEKDyoSGw9tbK3RZSpPcrWZc2vqrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qeTLA2Gu6iMHEJS9oKrLW2Y7c3TrGcps8qnp7zmuH5If9SX+d/LhIMf+fj8KV339t
	 qqof2bDoZ5z51Nrotj8CbnwkS2p8nEnuGAdAM/hOR7XZjG/z38iYYSUvbtbpEB8p8z
	 ilu5bgq5dh9BaLr3Pu3G1ESORDhupjHfzPjAvNiLXrrvm0+/Jza315jN1Thavg50kL
	 IxW1l+V6HZ292j57CFnfIVg1ASnieXv2Ury8gT7sN4mRciQMJzqA3TzzbBvLzcOgaX
	 mFdcMYVUpeT3fyBK18cU6OkBzdYA1hv/8KhCSK8JI76Ime+qFDUR2UOAD/0Z8XDIyY
	 c2UN2pBg8AGfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9173C43443;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: Update bonding entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172183083182.11114.4188482836036552715.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 14:20:31 +0000
References: <2800114.1721773356@famine>
In-Reply-To: <2800114.1721773356@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Jul 2024 15:22:36 -0700 you wrote:
> Update my email address, clarify support status, and delete the
> web site that hasn't been used in a long time.
> 
> Signed-off-by: Jay Vosburgh <j.vosburgh@gmail.com>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: Update bonding entry
    https://git.kernel.org/netdev/net/c/0fa9af961102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



