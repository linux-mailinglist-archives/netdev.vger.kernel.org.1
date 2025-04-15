Return-Path: <netdev+bounces-182815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC4EA89F73
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E0A3B22D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A2297A68;
	Tue, 15 Apr 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaCcJTSt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A542DFA2F;
	Tue, 15 Apr 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723795; cv=none; b=gOBbfi5yjSRv3oonotVwYdkSZKgzdsZx6yF9x6aBgasG1rp3Cbe9iav7I0cuRP4K/GxYUk+llDmkrX3rz706dnyWDBl0dnwfsEZF/+6vqm60aTJjLGr5YZwd7BNU/PY3i8EEIxYuOZ35/6o7bhELBgY+EmHYF50gNG+VHsztpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723795; c=relaxed/simple;
	bh=Y1Rv2T8UXjYa+nnRgan692+MvUFpE6bW4qYgzG/dDww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xg6E7PmgViKDP30e6ZXGzfnizAI7C7bStlqwe/DZBkNb3hQ+UTmSFQiLr0eKY2TITJCKBXLbQDGDUlDqDDtg/eghSfAZ7qOiv5k9T+kcQZfCPoTTFbE8DndQb216KbgJGrb7WEvmtRxNY88E2M9SQKoHNNYJ4Us308iMTRuLVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaCcJTSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EADC4CEDD;
	Tue, 15 Apr 2025 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744723794;
	bh=Y1Rv2T8UXjYa+nnRgan692+MvUFpE6bW4qYgzG/dDww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KaCcJTStHitQknTHXZu2d0lWddWuHJr+NLQv3NE03HqVn215s8MHm+j92DmxPtve/
	 VP+/KBHEUHkwKfbTMQoWyNIXjp1GWE8QyuaTU58UpAPeQHGihBqltFy5XGy7nij5aO
	 5QX0Rke8XoDyI5+GdUlVejiMuDyGZEwEt3V9lgStB1vyiwdEiyl32Sz086YjinP9QG
	 Fd3rcL3zFbpUP/1Mr2X266DhiIxDCTcLrWB792HwhHqrmFZHgGqDMtu6OdvI+HhNtb
	 KNiJRaPKoz7XMSKVB/KLLWDpXr+57XfmA1brYm/hBf8vBSh2Ql8QrAs/xP3fiaHPvY
	 qvgyRbtV+Wyzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1C3822D55;
	Tue, 15 Apr 2025 13:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174472383281.2638597.4990280583996598554.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 13:30:32 +0000
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com, hkalavakunta@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  9 Apr 2025 18:23:08 -0700 you wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> 
> Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
> variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
> collects these stats, but they are yet to be exposed to the user.
> Therefore, no user impact.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ncsi: Fix GCPS 64-bit member variables
    https://git.kernel.org/netdev/net-next/c/e8a1bd834405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



