Return-Path: <netdev+bounces-177495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56BA70541
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803CF1886799
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F01F55F8;
	Tue, 25 Mar 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbTTrK26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C31A238D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917200; cv=none; b=TluiDRA6+740K84x42jOfw/gGvDwoK2klu8SKsLYfbm4dKsGDJB9n/r0N6TOKj1B+2Ot+/F6M8v9397JMNxTVFRy9F9eWlckRvlHpSaCvr01b3BYY3DwtsyjU/XTkCNn5cE6397HrClMG6N/kjQ61Mftat+q2nhI51Ik8ZdmTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917200; c=relaxed/simple;
	bh=jAzpBi3pKsZpLeZTcGCAb6wrfMEyeOK5mLq+AVxhbmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFQBVtbGIB6qhoH/Gg7SSzMfBeSorPdJUTJ5SH48EewoPqtcfu5WXmGiDz9B698M/g2St8Yi7aTWeXzQVr9ZVq1iAqKMhXWKHM1joVhbiKd0DtH4hPNJd5azTpU6rgfzlgIq477IwY5ewgGMQsmxnxK4NoeUF4tA6S6EcbINWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbTTrK26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D67C4CEEA;
	Tue, 25 Mar 2025 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917199;
	bh=jAzpBi3pKsZpLeZTcGCAb6wrfMEyeOK5mLq+AVxhbmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbTTrK26QzQRlMz9YI81CwDxxAqqTJxpnNk8iyKE1ild/DznNFUWV04RMjXZP0TVI
	 vzxnAHPaj56hluzdWgg7TZ+7gyL3n8+YXWM9wEqLznVVuqtdkGrYtwyiCKlAt4x6a+
	 qDPVdVCsJrL69Ban0xeSnh1YAuPZONXAYA5qx8h9mKWyjwsdT83cpYv+3kFSbdKFFG
	 fV5l5jhsylNp4tnqQwDXixFmfSNdokaxrM5W5lF0a4/+w8jXTMzo7FB6jk4yCP5wNh
	 OW0ao4q1uY1IEttqPO4uUBVOaGvmf8EuwDc+IIB6PdSNEshsw3TYK+eA0Acw+wJs4Q
	 v8UEiSA+fkiZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EDC380CFE7;
	Tue, 25 Mar 2025 15:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: au1000_eth: Mark au1000_ReleaseDB() static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291723625.621610.15007821431431312132.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:40:36 +0000
References: <20250323190450.111241-1-johan.korsnes@gmail.com>
In-Reply-To: <20250323190450.111241-1-johan.korsnes@gmail.com>
To: Johan Korsnes <johan.korsnes@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Mar 2025 20:04:50 +0100 you wrote:
> This fixes the following build warning:
> ```
> drivers/net/ethernet/amd/au1000_eth.c:574:6: warning: no previous prototype for 'au1000_ReleaseDB' [-Wmissing-prototypes]
>   574 | void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>       |      ^~~~~~~~~~~~~~~~
> ```
> 
> [...]

Here is the summary with links:
  - net: au1000_eth: Mark au1000_ReleaseDB() static
    https://git.kernel.org/netdev/net-next/c/5e8df79497ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



