Return-Path: <netdev+bounces-96260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D229B8C4C00
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3C1F22893
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 05:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117A17C8B;
	Tue, 14 May 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgYcIGLs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D414A84
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715664630; cv=none; b=lRfYhdWdMJyoZPD6tsR3shr73CkIIt5EQtjjEgU2Pc1xgNDT5WKiVUxvFDutVwgo8HP3LqOVfuMNRoMzDTXV+kkEshDD5d+3IcQsxSoEpnr9CVxe3cTazMYSwrRlYR2Ak7iACqRoojfLWrkE5RrnFS+/SgE4oIYqUrpG6Wdri3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715664630; c=relaxed/simple;
	bh=BIqqfQzKpPT2zJV1BiTqG3znlwBhyNyz1TOrCQxTFhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rsvl9u3eFRTRCpVrIHzBUtW+ejDzp+eYYgNAj5/NC2oa/bJLpjr0eUg04K9WIN31OKhxeRG5lIyucgdKPgPWi/s8Vw664whc5XS0+hiH8moWDghOArbgbtkjzd5PPsLLaxbLkVW46KBBuKz1eqPZ6+AiZsvKX6uvhulpsatxxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgYcIGLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F1FC4AF07;
	Tue, 14 May 2024 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715664629;
	bh=BIqqfQzKpPT2zJV1BiTqG3znlwBhyNyz1TOrCQxTFhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FgYcIGLs+YVTqaWLOSZX6H6OzRGfS6F85cafzS7Iq0VgMnnVpupgcQN4viHvyVvA6
	 JDk2tYnq4/6Mfp3xSr7k2NBOJlPolHvMidQqj21vrWD9Cwm1tKqSLKjEvt23ULOweb
	 DAV90NklmbtOAPJYT9W/tKwI58EkteoU24D4UhuJFpJ/LmMouVTpZ5HMc/6KXFhn40
	 TTGLjwjr+Sbm1tNhoRgLtkTY8bx2aG3m9dKBqcht5UNrERpd2IxPvNF1K+YctFJ3f9
	 8CJqJ/XW8FCyzCl4yHWg8RFCj4hNyeGrT3Z+VZLxU2NQZBqT8q7adpPFgGTOoQ0BtS
	 RIuGHABt191ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA4A4C43445;
	Tue, 14 May 2024 05:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rtmon: Align usage with ip help
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171566462882.15721.2861315908046797968.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 05:30:28 +0000
References: <20240513185217.13925-1-yedaya.ka@gmail.com>
In-Reply-To: <20240513185217.13925-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 13 May 2024 21:52:17 +0300 you wrote:
> Also update the man page accordingly, and add ip-monitor to see also
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  ip/rtmon.c       |  4 ++--
>  man/man8/rtmon.8 | 31 +++++++++++++++++++++++++------
>  2 files changed, 27 insertions(+), 8 deletions(-)

Here is the summary with links:
  - rtmon: Align usage with ip help
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3cd62286ac72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



