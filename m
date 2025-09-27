Return-Path: <netdev+bounces-226833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C5BA57A3
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AAC1C00837
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00321B9E7;
	Sat, 27 Sep 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npYmKC0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01921B9DA
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935428; cv=none; b=cFojhZIzb1+84ZcJbDbRzRoI/+REjJsYSfomQW8rnICpQNsM1KfYrnHoMSBrc2kyMdPh9gnXjWoUds64HBKXIyZe+wYX1MeGT1ve8VT2kdhVH879mFhyVSq0rMKJEYHDkReHBkPjIRtTwY+fkOWD6rG+1OtM97KJ2P38b4HwYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935428; c=relaxed/simple;
	bh=dycmrG8L42shWyOFq1LplDW0kt8JqYvNmyTy5n4cmII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElIyUsHlgtyC7gAFd9V8ifq4IGkKtNEFxXvehCtHrUVmD9ZCrqeAAojM4MXzMLcxaVmdvEmLAicUvg9EmBe12gYi03D2aCrG7yMmf0z7AshDeR1BOBzSggaPBeJrA+a7c++elVPXn5LJ4TXS+AKKEAcpMOPeQ2rNaYoFuSs5mMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npYmKC0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B32C4CEF4;
	Sat, 27 Sep 2025 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935428;
	bh=dycmrG8L42shWyOFq1LplDW0kt8JqYvNmyTy5n4cmII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=npYmKC0PdSzX7/utwapI/6czHnX7CCci2RE2SDWtAPBz+csfL1txtWcozAY8cdOhA
	 yWDMwSUFlUYXp5r8JgBXrTUTtiRKQXSXr7Jwk4E0gH/ODwDMztxneMCUaGakcEkg+t
	 t3FwgJ1P3fMGVgX1ZPD5nfAez2GGysv5u/qTBLNZLI3SbpejpqPKKDbm+Gc6pES8PV
	 /od62rPAXjVETBJ51zGyp27RkfQpylLBzSqVXzsGRHVo7JViwH/ERtQ7X2En9x/6go
	 Bezhk2RwpXP9S4/31kQQnFVEjyFtxM7XEvHw7Uqurzn46P3uJFi8n5qlE7dS2madA0
	 83Qrx3ZJsH/2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710A339D0C3F;
	Sat, 27 Sep 2025 01:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: npu: Add a NPU callback to
 initialize flow stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893542299.113130.1861554660002474046.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:10:22 +0000
References: 
 <20250924-airoha-npu-init-stats-callback-v1-1-88bdf3c941b2@kernel.org>
In-Reply-To: 
 <20250924-airoha-npu-init-stats-callback-v1-1-88bdf3c941b2@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 23:14:53 +0200 you wrote:
> Introduce a NPU callback to initialize flow stats and remove NPU stats
> initialization from airoha_npu_get routine. Add num_stats_entries to
> airoha_npu_ppe_stats_setup routine.
> This patch makes the code more readable since NPU statistic are now
> initialized on demand by the NPU consumer (at the moment NPU statistic
> are configured just by the airoha_eth driver).
> Moreover this patch allows the NPU consumer (PPE module) to explicitly
> enable/disable NPU flow stats.
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: npu: Add a NPU callback to initialize flow stats
    https://git.kernel.org/netdev/net-next/c/105ce7ad57e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



