Return-Path: <netdev+bounces-251129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8778DD3AC0E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC01F301A3C2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068138BF61;
	Mon, 19 Jan 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoUd/mXP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6538BDCC;
	Mon, 19 Jan 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832587; cv=none; b=Kxzplh16IAfKsBiK+4yLfDdxf3Moun12LaDsFbpp5jgpTtxB0pT5IqMUegj/CrgF6AEKmdHx9bzHNpl8hNURjjyGj/2I9g2H+iuuTfV7KIaJinCAVVUqyjtabHm3NTPw3CzAUCUq4xF2ykY33y6Ml972hiz8UgKtL1XTUWunI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832587; c=relaxed/simple;
	bh=+obUdlf0o3yDdfwDezjeu0oIGYXMP3xAIB+SFGZXSFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUHknNqNAOxshOyUWNqhFp1mEglZZbBbV77c63QuDL4zyky9Zjq5A8U+JZWifTZ5ISd+owroj/9HEXDCIQmso5Gu6mdClay2guzEd0/bfxjWmz4pQMVnfTYVz4nGPBPswzHsVcquTeGSJJ8dzHpbaMaBda33Yj8HJwF0cxGwQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoUd/mXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF31C19423;
	Mon, 19 Jan 2026 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832587;
	bh=+obUdlf0o3yDdfwDezjeu0oIGYXMP3xAIB+SFGZXSFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YoUd/mXPTHHi97mYkvJwxjL3HlfrOYfng9wWTMGYM4cTwtKTgLMATBjonZuQO1pGS
	 T33xp65FpbBjnrc5/n03K7uxxwXdd/VnEgbc05QGcrbONBteXdO9jCtIyOVTQwKPnL
	 uoEdkjTCgiNDZgJzV+A3inkdOaBa30LSK5ZAvr+3gor2/QMz0WEyqQEC+/CNpaXpNK
	 oGz8xyjdAr76v7149i+Geqde6fxcQFxdZltKHmjevweN8DWhthj6ogtgelr5qERQpk
	 1NJ8ebIFKNJ55NRH3Xjolzjh7UYdDseV1/rJRVontsN1kVE66QWbXkvhsQC91eou5R
	 xA62EJexQNQNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7887A3A55FAF;
	Mon, 19 Jan 2026 14:19:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mctp i2c: initialise event handler read bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883237711.1426077.5900427091138525650.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:37 +0000
References: <20260113-mctp-read-fix-v1-1-70c4b59c741c@codeconstruct.com.au>
In-Reply-To: <20260113-mctp-read-fix-v1-1-70c4b59c741c@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wsa@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@codeconstruct.com.au

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 17:01:16 +0800 you wrote:
> Set a 0xff value for i2c reads of an mctp-i2c device. Otherwise reads
> will return "val" from the i2c bus driver. For i2c-aspeed and
> i2c-npcm7xx that is a stack uninitialised u8.
> 
> Tested with "i2ctransfer -y 1 r10@0x34" where 0x34 is a mctp-i2c
> instance, now it returns all 0xff.
> 
> [...]

Here is the summary with links:
  - [net-next] mctp i2c: initialise event handler read bytes
    https://git.kernel.org/netdev/net-next/c/2a14e91b6d76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



