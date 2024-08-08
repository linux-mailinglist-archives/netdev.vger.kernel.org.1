Return-Path: <netdev+bounces-116679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF494B587
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0521F228BA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8614830A;
	Thu,  8 Aug 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Q9QFXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7F433C8
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087847; cv=none; b=JxVq5H8Hb7MQnnY/0T4ES5AYb6W5Mk9a13IP/E6rAqIZDa9S5tdiM3Lg8NtewjsZZXDMHJOjop/34Dz4iCU3U2Xuh+0HbJF0quy9Xr8wrPbbNMQ0OdoAYhPWc05Yz13k8Sh6VAkGsH23Moi75gJI/CcY+RCW0Yy46MMbrbv7cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087847; c=relaxed/simple;
	bh=XFDVPq51pDDwfljG/Ihcy4qCm8KimRFQCibbtpIlUGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4ehmrcOxC09FamdOCdBfyUDwetILGVgMBlzf8LeMONqZInsbwfO5AwUGsBUsn8LDISRFHNK9phQvB+LV989jF4RtvqVDdw6o1QlCMLokW0CRBANlC8NRFvo/+2YvWAMw46chNttUzayEPE4Bu/B/nJ0Usr5Ij9+dDHC3uTc2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Q9QFXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC84C4AF0B;
	Thu,  8 Aug 2024 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087846;
	bh=XFDVPq51pDDwfljG/Ihcy4qCm8KimRFQCibbtpIlUGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5Q9QFXrOTD5A2NqJMZI5xKqt4wQJXyl5v+sIwpWNltoz2xZ/viKZ+250G422kk6h
	 bjpFbOo0RPeliq8w8XxBpzgHUcIAIfbW4lu6/4Bx0vLnDoj1UykDiSOoyGoELienCt
	 Z2FuqcdFRA7UsI0y/OQSMfp01Hl5Uw0Y8C33D/VSWNdCLfbW96dgjYPL+dwwtpTFc1
	 C+sFr6RxyUTUjnBR0QFKUW/0yJY2t1sUOlmhwzuVOWeh856IfuMQfT0shGdOGVhFkv
	 mF/a6vPDSQ0xHnRrfXhWAqMyGJ/x94dUBetDSdlgME96KOb8JNo6VQdHBKCEJQN91o
	 qbAeIYMGFiBpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEC123822D3B;
	Thu,  8 Aug 2024 03:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: Increase size of queue_name buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308784526.2759733.15931779234221590658.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:45 +0000
References: <20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org>
In-Reply-To: <20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Aug 2024 12:28:24 +0100 you wrote:
> Increase size of queue_name buffer from 30 to 31 to accommodate
> the largest string written to it. This avoids truncation in
> the possibly unlikely case where the string is name is the
> maximum size.
> 
> Flagged by gcc-14:
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvpp2: Increase size of queue_name buffer
    https://git.kernel.org/netdev/net-next/c/91d516d4de48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



