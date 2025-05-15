Return-Path: <netdev+bounces-190598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B39AB7BBB
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8751B65212
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3319CCEA;
	Thu, 15 May 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/GLZULd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11C1401B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747277398; cv=none; b=jRehwugV/oipDmhzRAq0qS9jC4WnAg2Qb5lFPTzevv8F2vO5CfnzjbMQ2Dw4WVgIbTMtCUzgFkihiPAAExbsgIVJglJcYJsqm4lGQvW8fyU6P8hJaduKQB5dMWfxZEagmZoYf/maazzu2GkNhV8jPeTGHydgZCdYL6AI/WdCDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747277398; c=relaxed/simple;
	bh=BrML8hltOe7eGgu0ZZrHDaD0LJnVERBGsqDips0I6GI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G/a/5/42GEz+qL8sEDBsVfR6WMZYn/MU3aPqNDum242gVZ54KfL9+54F5PutJFfoOuWNDBq1IwJZnCOLsv9jkL+ZQ4f38VmH7pxsgNRKko5f9O0blVUwK5EnXMrS4koRH4EjQdMZuui/B81AMFb2mZsZ3NCaO/1pXAPnL7+kn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/GLZULd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC29C4CEE3;
	Thu, 15 May 2025 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747277397;
	bh=BrML8hltOe7eGgu0ZZrHDaD0LJnVERBGsqDips0I6GI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d/GLZULdwCgMXggIqy7mTusn8PKGdR882i0axM89tbRoH5Ky9+I35UHAjcYm/2ZPi
	 HNpRc/ll/NYHY06vbxCmDYnKT7341qIwLHx+ShZWH328XROuws+KC5qaBjxOpVuYc8
	 hmhdPtB4hAA1XObWrFudevIGJx6ZlKl/IGTXdu8FIItUfY+s0ECDrlPP1j0IO9E0bG
	 FpVEpw1rPl1AVeHduF9DoTU2wkOls+c4IewUx6rQcTAY9Uv0Lg9ULPv8yr9GVz4CF4
	 xUeTeZlWrW0jd08A2EDNX8ESIHkqYYLmrbgLHgn1qvf1vHtcyQXoXd5c7Lct2MLv4Q
	 DjfWkB8KvS3Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAB380AA66;
	Thu, 15 May 2025 02:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] misc drivers' sw timestamp changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727743500.2588817.2305951558012609292.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:50:35 +0000
References: <20250510134812.48199-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250510134812.48199-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, irusskikh@marvell.com, bharat@chelsio.com,
 ayush.sawal@chelsio.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 May 2025 21:48:09 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This series modified three outstanding drivers among more than 100 drivers
> because the software timestamp generation is too early. The idea of this
> series is derived from the brief talk[1] with Willem. In conclusion, this
> series makes the generation of software timestamp near/before kicking the
> doorbell for drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: atlantic: generate software timestamp just before the doorbell
    https://git.kernel.org/netdev/net-next/c/285ad7477559
  - [net-next,v2,2/3] net: cxgb4: generate software timestamp just before the doorbell
    https://git.kernel.org/netdev/net-next/c/aaed2789b307
  - [net-next,v2,3/3] net: stmmac: generate software timestamp just before the doorbell
    https://git.kernel.org/netdev/net-next/c/33d4cc81fcd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



