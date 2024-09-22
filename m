Return-Path: <netdev+bounces-129203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692DF97E2F3
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5CEB20AE3
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3814F883;
	Sun, 22 Sep 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbNmevul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD14CB2B;
	Sun, 22 Sep 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031628; cv=none; b=hqscmC5sa6X9CyzoTZAlPn0/yLNF8IZbLx6xXmQsjR29wi9mMjvgnsg2M3j9JBi9JrjYRaHUhfQ69X5A3Xxz1TSxqlPFBRrZxvVjAwF35A6OjFIU77ZpV99CR898OvYO3Dpl4hAtrYERPhBCxve6T9tM8WoFlGaIcw0O3rayN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031628; c=relaxed/simple;
	bh=dpwE5wWZ22Gs99n7rOIXZHEvPOyC9z92q2/TWJJuS48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rM4SGYiAhUQE/cd4YU+ir60TT7Y8qUEeT3ZH+JZ6w+B8H4L3hEtuYyxqZeExWC4lRwQTZ+53cVYztO3zlJhe7VhMnoQX2a7CtxCgAXakN2KpqqH0faMfwyuQnVykuWh3iwxMxvQNLPLoTquaEjeZOJOstN8Z0gwU/3Ue8/KGA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbNmevul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEABC4CECF;
	Sun, 22 Sep 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727031628;
	bh=dpwE5wWZ22Gs99n7rOIXZHEvPOyC9z92q2/TWJJuS48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KbNmevulMeys8+3yiT0FlL4cv1VCVMGRWBmJxSvqIjXSOmIk9bz2d0NbYxbz3xmia
	 RZZGRDSv9CMkyi5a0q2fQE6XDuyFgn+wOsdBExdBcKCOGrZJeht0neib8WQfIwiW5e
	 KHpzXUneofIVh8B6oh2vn6K0a+K1xmEk/R529RkejGPeVG5IHPnnzOL4H3owRC087u
	 0wRzk0I1DQPrmrYJ14loGaCs/0xL65KiuG9x5OY4PcgQCpI71OO2jTttF19F+eq3NU
	 HpWw70sSQ+Vh5N2DrmF7+eJE0aDg49Ntb4v2YW0sE/184mfG/O+A1V964Y780/+iFK
	 /h1It2v7KjpYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8D3806655;
	Sun, 22 Sep 2024 19:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: adjust file entry of the oa_tc6 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172703163025.2820125.10385059317065210337.git-patchwork-notify@kernel.org>
Date: Sun, 22 Sep 2024 19:00:30 +0000
References: <20240917111503.104530-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20240917111503.104530-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: parthiban.veerasooran@microchip.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Sep 2024 13:15:03 +0200 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit aa58bec064ab ("net: ethernet: oa_tc6: implement register write
> operation") adds two new file entries to OPEN ALLIANCE 10BASE-T1S MACPHY
> SERIAL INTERFACE FRAMEWORK. One of the two entries mistakenly refers
> to drivers/include/linux/oa_tc6.h, whereas the intent is clearly to refer
> to include/linux/oa_tc6.h.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: adjust file entry of the oa_tc6 header
    https://git.kernel.org/netdev/net/c/7ebf44c91069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



