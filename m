Return-Path: <netdev+bounces-214811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9CDB2B5A3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEBF522857
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85E188734;
	Tue, 19 Aug 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRk7QPZt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E8EEDE
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565198; cv=none; b=laPV3a2NPUUYwK8TiMMlOcBqFUXlQDsyNsVqgEJO9d1m85rEs3qrYbj+nOt0TtjY4TINVriXryNZYC73qjSFM4Qb5t0FXFPqjZf57bbxYr260PTVzuz+er5TeAaFfpyNHftJLQ2o4cDvjvgAr8C243odVNt0ITMRbDpJfBxboMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565198; c=relaxed/simple;
	bh=qpMpuH8wP3ETkDPK3u5o6Uw+Mo9ZSqmkmrjRDgwdE1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aq+ZobaeIFrQHU5NQ0PmMPyZ8qasF3HkEetrpA7Dsx2NQw4hTiLVW8FgDkrvwvR52HKsL/AGECu7YmDDgDqKzyCAEB9d5VNaIn4AeIcNUZTtn8A14B6vourNBTwe8DwBFw444EIVHVOpHER5zopCsiIyzTqhVYwM+r8gyiO3dQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRk7QPZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE1DC4CEEB;
	Tue, 19 Aug 2025 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565197;
	bh=qpMpuH8wP3ETkDPK3u5o6Uw+Mo9ZSqmkmrjRDgwdE1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRk7QPZtcCffzWYEw1fUN6bwfcQqYpPmUv1TS3sXUJUD/A+Sr9Hs3W2Pvyx/GEoF7
	 hrGSxl7E3WWcBTdh3EGixEwWVlK0iT/+MpW9ojKfIk4oseg6W1GX/MPD0Mm49c/50t
	 QMMmpfX0yHC6y2K/+PJF2d3l80SNDpnw0ruKYEgKUqSn6NR0J2T1FtbFG683iqewTQ
	 nEl/hEhqsImuClTVk1wpkILyMjZCHVWK0tB2SHfbVgx6GvaDEsO2bUNqZVR4Kgz0y5
	 Rp+WVYpL73eoAW3dlnWVLcYXYlew57VTnvbxV0EMYWqT5tfVtpy6KJ4RHFChnw/mqI
	 x72ArIX1dwmOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD41383BF4E;
	Tue, 19 Aug 2025 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Fix lockdep warning during rmmod
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556520776.2966773.2798007329883348467.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:00:07 +0000
References: <20250816183850.4125033-1-michael.chan@broadcom.com>
In-Reply-To: <20250816183850.4125033-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Aug 2025 11:38:50 -0700 you wrote:
> The commit under the Fixes tag added a netdev_assert_locked() in
> bnxt_free_ntp_fltrs().  The lock should be held during normal run-time
> but the assert will be triggered (see below) during bnxt_remove_one()
> which should not need the lock.  The netdev is already unregistered by
> then.  Fix it by calling netdev_assert_locked_or_invisible() which will
> not assert if the netdev is unregistered.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Fix lockdep warning during rmmod
    https://git.kernel.org/netdev/net/c/4611d88a37cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



