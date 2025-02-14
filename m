Return-Path: <netdev+bounces-166576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2CA367C4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D25C189361A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB71C8627;
	Fri, 14 Feb 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3CIDGuR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280B1C861A;
	Fri, 14 Feb 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569804; cv=none; b=si1HMCOdrokETn1ea4ZhNzxaXRgb9/vPyLIkUf+oo66sdfoPVUv/Yjc8kVMQtuNMjAPEN+43D895hfqMqpE8lOyNn1aNamH7XTUtEtnhfccG+QEVQLhw1c3WsJRvKVYtIte6miswaURpxVqvEvNerfuoPevJWj1b/EWEuAiLSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569804; c=relaxed/simple;
	bh=GF6ka8bzFf9JhuTzUDSKq1VvXlcAT+2w2rdKwoJOJ+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bcjd+zDIc+uRLSKK2IVJj8fjRPV52F/mOyZjtRqZJq4tYpWFpXH0aUP66RdE4P5v/w3ETR6nVAMyl9cL1s2RXPAwXL1JfZs2cWnTibvt9cGgYF3Y7iVRziaVdfAudGy2gc1w1HTX6zqrZHmM1K1kvx8BgeYToXw/pxucRbPQHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3CIDGuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96836C4CED1;
	Fri, 14 Feb 2025 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569803;
	bh=GF6ka8bzFf9JhuTzUDSKq1VvXlcAT+2w2rdKwoJOJ+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3CIDGuRbagkLjpIjLRo6JD6AUNVDSPNRLInL+WexMu3ow+g+jfMR6GsqWKC6exFm
	 Ff7BEB1JNjG3pnuyTTzMwsW6w0OgdbwLj58nSbJCbmF2WT1laN416ovNuINCkDFvYv
	 Eb2GB1HUpqCZAM2m+VPAJse/LRSUbN70u3FiJENtNHHIkeB4DotHWCHoMCiPxk8vfg
	 l3yhJQ1JgM2A5jcdjK6laoYxpPIzUtULQxDwzsns7oyl9vOBcPdK8zn8I5pOogzkzb
	 HTGElNtqDQAH7XdvfzgvFVmsSRdJDwVWepJxFQqb4gywkMDiJsJ5oFnJRLUETcsQ+G
	 QBA60e++DG/gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343D2380CEE8;
	Fri, 14 Feb 2025 21:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence number
 glitch errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956983281.2115208.743152782934206798.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:50:32 +0000
References: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
In-Reply-To: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org,
 abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 12:15:35 +0100 you wrote:
> When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
> constantly being filled with errors related to a "sequence number glitch",
> e.g.:
> 
> 	[ 1903.284538] sequence number glitch prev=16 curr=0
> 	[ 1913.812205] sequence number glitch prev=50 curr=0
> 	[ 1923.698219] sequence number glitch prev=142 curr=0
> 	[ 2029.248276] sequence number glitch prev=1555 curr=0
> 	[ 2046.333059] sequence number glitch prev=70 curr=0
> 	[ 2076.520067] sequence number glitch prev=272 curr=0
> 	[ 2158.704202] sequence number glitch prev=2655 curr=0
> 	[ 2218.530776] sequence number glitch prev=2349 curr=0
> 	[ 2225.579092] sequence number glitch prev=6 curr=0
> 
> [...]

Here is the summary with links:
  - [net-next] net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors
    https://git.kernel.org/netdev/net/c/0d1fac6d26af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



