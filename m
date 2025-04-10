Return-Path: <netdev+bounces-181001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A3A83613
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2134A0382
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E41E3DEB;
	Thu, 10 Apr 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB0QoWkH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCB1ADC90
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249795; cv=none; b=B55lv8jwd9TLBJoFsEzmbeWmVLFC10Neu2C/fn04lAi90dsXEN31z6BKeIAatYTlx0At32oUkLgv1rElhlVHiQLnc9O+3Mu4x+iY66FsxLvXe3bEQ8TE+4Oq4yBJIJ+Ahz70Kslr68JJOvSNqCa/EaQxx0Ucj4LHGDL/KFf40cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249795; c=relaxed/simple;
	bh=P5hKgYe9rK6EAMG7n9DXrDmJ+mKE8+TRwAmZuM2sh4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gUWq80vVwRhgldGrin+H35ry2kfNjJl6RwCkqoUtF9+BOMbrSCHMxG6KFaUybLI/Uy5nadCM64jETX+UDk6ZQ/+WWu9oAD39dyy8lPCdOeoxPXwr7mkQvv/4umK7FkBYSNOZLeQKOR9FhbHp4V5bQdlNQddmIklfyyNDeIWS7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB0QoWkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D69C4CEE9;
	Thu, 10 Apr 2025 01:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249795;
	bh=P5hKgYe9rK6EAMG7n9DXrDmJ+mKE8+TRwAmZuM2sh4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KB0QoWkH1WgcXOyNQPwlflBa9evI8Fl6Gk3HrrfIT3tiCJKjgQeprcSyaWjjHoBUE
	 eAeee0HhvyhVUxrbRiZw9qGSC/+B71WkcVTBuoHSMqBf9TKHtb/E5o3PvvP67Bsi7W
	 DGIuGLQD/1aH0ywDu+lK7SUf+1AMeGERxwtlkXzWuPd1fd6V5jHrAOEdcgrRzxR1Mx
	 qJI/ibmrHIs72Hxf8SlNvN8h0vtTPTwra66KBwbkTwhvEgDvA3zQB4czUoN1o0cI7G
	 bS1IwErV1BRYnnsjqiGDGQzVvFi4bsnpwqkH44+fn68v3ov9e0fUohbN9RdPr0DUh1
	 8ZND5twTj8P5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEAF38111DC;
	Thu, 10 Apr 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove cpu stall in txq_trans_update()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424983252.3109521.1645144030455480167.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:50:32 +0000
References: <20250408202742.2145516-1-edumazet@google.com>
In-Reply-To: <20250408202742.2145516-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Apr 2025 20:27:42 +0000 you wrote:
> txq_trans_update() currently uses txq->xmit_lock_owner
> to conditionally update txq->trans_start.
> 
> For regular devices, txq->xmit_lock_owner is updated
> from HARD_TX_LOCK() and HARD_TX_UNLOCK(), and this apparently
> causes cpu stalls.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove cpu stall in txq_trans_update()
    https://git.kernel.org/netdev/net-next/c/229671ac60e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



