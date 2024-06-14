Return-Path: <netdev+bounces-103491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338B908508
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D1A285198
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2887148FE8;
	Fri, 14 Jun 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRam2YRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470A14659D;
	Fri, 14 Jun 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350232; cv=none; b=JKPL7XIQZbmZAAtrozvPp1777n10tbU5yTepdXlX+/22gUYyMzre4K7588ipVR0hsWLt/tpYOkygX1pcUy3ljLPjmJdGxgLJ82WSvE9wQGcdw8bgRaugx9JaACmJzwQ1jjdQ2V6b8eTxA259J9krighF9FzBIh384NnAh1/5NC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350232; c=relaxed/simple;
	bh=KYK3uAsizy5cMqvfjKNpPCncJwEtmoVnTlHLRj/gliU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8NXccONVi/mP0ay9VvVuoKGjKTSiWmvB+BREeS0Q/hT7pkz76tTczhccFY8g81R60iFcQOrdgVthL377FxKDEOBqyyrO45ZNtnJupc9EMzbfFqUFPEqUGoX7mQy6k5apUol0HsXhZ/MWAVry96VPEq4sgOTLj9zCumIe+M8AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRam2YRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B36C4AF51;
	Fri, 14 Jun 2024 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718350232;
	bh=KYK3uAsizy5cMqvfjKNpPCncJwEtmoVnTlHLRj/gliU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRam2YRIRxotkL2tLaQX3PqA19ollVKEDKyRChnNrcOw56WGcIeD8hAXD5dMyn/xf
	 IZEztUcKza1lwFJ5xQs6vvQID9gKnPxv15E3kUYa67BVMbOjYumbvs/c43gI+ATXi8
	 Ht1QcWQrdqGIOVXCAKzvTDkzf8KOo7dYpEptGndXC8PjfjYXjs2wlXIjcpXVwvgwHt
	 zur5YSivUETRUcTP4u67pS2/SMG0opOLdcIR+iR4+/0c+4yuhK8h2yyoHs7rbGNMlU
	 AdKgRQ8V/sYatkjJqoXhs/+cIU5onoJ7vaWFPMmbFIssryUroczFd56EruKFXsWzg2
	 XH4NN9oEGsnNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A330C43616;
	Fri, 14 Jun 2024 07:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: hsr: Send supervisory frames to HSR network
 with ProxyNodeTable data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171835023203.4750.14652013430494509364.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 07:30:32 +0000
References: <20240610133914.280181-1-lukma@denx.de>
In-Reply-To: <20240610133914.280181-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, edumazet@google.com, olteanv@gmail.com,
 davem@davemloft.net, o.rempel@pengutronix.de, Tristram.Ha@microchip.com,
 bigeasy@linutronix.de, r-gunasekaran@ti.com, horms@kernel.org,
 n.zhandarovich@fintech.ru, m-karicheri2@ti.com, Arvid.Brodin@xdin.com,
 dan.carpenter@linaro.org, ricardo@marliere.net, casper.casan@gmail.com,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com, tanggeliang@kylinos.cn,
 shuah@kernel.org, syoshida@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 10 Jun 2024 15:39:14 +0200 you wrote:
> This patch provides support for sending supervision HSR frames with
> MAC addresses stored in ProxyNodeTable when RedBox (i.e. HSR-SAN) is
> enabled.
> 
> Supervision frames with RedBox MAC address (appended as second TLV)
> are only send for ProxyNodeTable nodes.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data
    https://git.kernel.org/netdev/net-next/c/5f703ce5c981

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



