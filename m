Return-Path: <netdev+bounces-235340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A8C2EC0C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7833189AF10
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4CC211706;
	Tue,  4 Nov 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0m+rRTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A9210F59;
	Tue,  4 Nov 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219842; cv=none; b=i6z2qHH1HFr1AsKLhGm87IW6u1eV6d5V6WdPGPw6QszzVlcJNHURiNkmOUC8yLzPG2mBr9jntw/DnT665XmgnjCEBg0Wsbf1Y3gUcQFwQpDTJwamFPeixJs4v1LESSBrDm/47F3Js723KVriAIYmN3qrUqi02zETBghCzu2HnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219842; c=relaxed/simple;
	bh=2hn7TExh5bvx/aSQHQygAQxTFzzeJn1z4S8zBCuEYyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFWRLNfgO1zbrt8WAM4C2E6cYY80OKG62/jNAWXk3Tet8rz4bRvkfR54gGjsGfhfH53HjfY9auLZRz33PVnf+IK0IQTuWgA6wayFPN96q1VyJ24TzHyblRhVvV+usoLT0tSyoPcUswkWzm5iGItns+yrzFiRpypSjJ8LBn6Pq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0m+rRTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1562C116D0;
	Tue,  4 Nov 2025 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219841;
	bh=2hn7TExh5bvx/aSQHQygAQxTFzzeJn1z4S8zBCuEYyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0m+rRTQdzvbstTPD3HFTlSgA0enZRpwijBg3E7RGaOfh3LSFoYBRbsz63kvJcYwG
	 zjmBAgvtrlVnIJ8kZuYyzPAJsIJ7eoIRDUY0QTNmjeV0t4lBvrQYZ+SA6oX3WJkALx
	 G6PQxjS0s+UvxSaZ7JdfhI4thWNGQYhz3mzz0az5gTeU2bYT1iIR0d67OlRW/R9L1O
	 J+FMcfp0qvxqpBOKKv1gi8c4+lmTRjzZ7FvB1IFypDR/7/GHrNV42i7Ey05kfG0O2u
	 DIqIDM1xZX9cefoP+1YyT7WuAVTzqEZktUDcKe6bzEasrwWzWPyX59kMAjMIkSYkho
	 JhzWKtGAd9Ucg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB13809A8A;
	Tue,  4 Nov 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: rename devlink parameter ts_coarse
 into
 phc_coarse_adj
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221981575.2281445.16125578755361920845.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:30:15 +0000
References: <20251030182454.182406-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20251030182454.182406-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 19:24:53 +0100 you wrote:
> The devlink param "ts_coarse" doesn't indicate that we get coarse
> timestamps, but rather that the PHC clock adjusments are coarse as the
> frequency won't be continuously adjusted. Adjust the devlink parameter
> name to reflect that.
> 
> The Coarse terminlogy comes from the dwmac register naming, update the
> documentation to better explain what the parameter is about.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: rename devlink parameter ts_coarse into phc_coarse_adj
    https://git.kernel.org/netdev/net-next/c/209ff7af79bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



