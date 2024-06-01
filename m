Return-Path: <netdev+bounces-99959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F478D72C6
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC41F217E8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98347A7C;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD1n0cik"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1A4437C;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285232; cv=none; b=svyrjrdSiLuVlEPiRF6hWHidUy3OLSxD2epVO8iWCWVtD4yNeTW/IGwjGulOS3NbqvCxWNjwt7YFRFWnXQW2LY+xKCyEcDX0enyDo1X/0Pv4JhLqR/xdl63+1fYnC4pmy22jnAEmuJeqo2LK4XT2c7GoD5OnnwKbowJwjQqn5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285232; c=relaxed/simple;
	bh=DmOW4BTjUz0mvgpEjHmJGdOect42gJWE//k3ifLPmJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GzgWqTtcM6Oifq0KQ4aFszgjVQvXuArRZvhIv289WDRG7+oAEs/kdU+oppO2BuehjJvqq2/IGuV4S/RUyNJySkpQzWdPkiqRjtZWZ1GXvGiLkTdaEMSTDbrgJcPvQSTTVw9vgLvAjN7H9r2KV4pBiAdLQ+9rvm3ti4rgQSBDPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD1n0cik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A0F1C4AF07;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717285232;
	bh=DmOW4BTjUz0mvgpEjHmJGdOect42gJWE//k3ifLPmJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mD1n0cikmvLD8yrotShgJ4qO4CVOc7JBp2BvDQ4DbbYzqBG127HstSHbDe+LEiiML
	 DGMJ6UuJEYro7pbX2v2375KdPz3Z89mgJQxGusGBAdHLHYJn1MfEvHrClRSxU3A2kU
	 egIujNZJiTQl+IxWs2MtZPebI9LQo8eE+eEB4a+jY7NydymRuiYurgGh7vrwsCekpv
	 HImdcnbtesHyySSVtQQq9478Mzp09kkAvuSh8g58a3WLHtQomBZ9y+pL1BqqibczfZ
	 bmVOTfDIW4HgvXRARWQpE5wKdhhkBfw0uh+iG3z4wl0Qc93poM/yHjpUVvCCUiIUqL
	 E3F+XZTpLmnVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28C5AC4936D;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/ncsi: Fix the multi thread manner of NCSI driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728523216.22535.12892429413724862460.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:40:32 +0000
References: <20240529065856.825241-1-delphine_cc_chiu@wiwynn.com>
In-Reply-To: <20240529065856.825241-1-delphine_cc_chiu@wiwynn.com>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, sam@mendozajonas.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au,
 gwshan@linux.vnet.ibm.com, delphine_cc_chiu@wiwynn.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 14:58:55 +0800 you wrote:
> Currently NCSI driver will send several NCSI commands back to back without
> waiting the response of previous NCSI command or timeout in some state
> when NIC have multi channel. This operation against the single thread
> manner defined by NCSI SPEC(section 6.3.2.3 in DSP0222_1.1.1)
> 
> According to NCSI SPEC(section 6.2.13.1 in DSP0222_1.1.1), we should probe
> one channel at a time by sending NCSI commands (Clear initial state, Get
> version ID, Get capabilities...), than repeat this steps until the max
> number of channels which we got from NCSI command (Get capabilities) has
> been probed.
> 
> [...]

Here is the summary with links:
  - [v3,net] net/ncsi: Fix the multi thread manner of NCSI driver
    https://git.kernel.org/netdev/net/c/e85e271dec02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



