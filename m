Return-Path: <netdev+bounces-136437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD49A1BFA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300031C22110
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5091B81CC;
	Thu, 17 Oct 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9VtDddN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142B144D21;
	Thu, 17 Oct 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151421; cv=none; b=t5KdrJxewwbgIb32hucDEbfgesie1kWGc+nHO0GaeauiLmmJcCLtrpzFU71nmDCJfTeIj3cYneuY0PgvyoBSuZzNH7fq4YUFQSXp04aOOUVr5FkFWqAHBmQJBy2LYdrhYauPS678OV04z+d2m73G2oc6t98QUHrg+YObm2IjEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151421; c=relaxed/simple;
	bh=Bg/wFi5bsLdXDPzOOwP8+uMrho0XzCkpRn/W+GR+TqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uaov7lZ7mgFNtygJo5o5a3JOsniHYtiOvR+JcRqcrnP4kMTf4CgG7ky+X3Xql9AS34nmvg+oT4xN3gem6fGVoUQJry7Qj2kPZPUTI9QP6K7ZaFR1D/mRWgwKRx71PRD9uBAcs5ZpO58LkWaxcVgWHe830zTNBof+bfEXjc20u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9VtDddN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55303C4CEC3;
	Thu, 17 Oct 2024 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729151421;
	bh=Bg/wFi5bsLdXDPzOOwP8+uMrho0XzCkpRn/W+GR+TqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H9VtDddNCGI5676q57Lo0VnaYfobHX6aQK34LTXCqkkqY898Luozms8AttGK5XpVz
	 6r3XchWVmeWQyo7P8RfKjFDPq3lt6gD+T8HNKUDB30FnzNXnKw2XU1HRL7SYu6dTj2
	 mA/ujgakmWcftaVd3KZaghfY+bLzWcs+mIRxIGxNFvHB57CwAfpOSml1iF8VT3wKd2
	 WWW9Aubr0Cbpp6JtHMbvN0HbmPxxmKAhmAvYMJKZTRz6HFNkBEfers6SaQAiZ6ARuw
	 KHNPWMPTB1v92rEg18hlKAEsYn+SJoxAxgSAlmh+DYF6VKnfQC33MV5s7hRv5uy0Jw
	 jqCipsUVTqqSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3913822D30;
	Thu, 17 Oct 2024 07:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/3] net: phy: realtek: read duplex and gbit
 master from PHYSR register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172915142679.2078251.79738921563508537.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 07:50:26 +0000
References: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>
In-Reply-To: <b9a76341da851a18c985bc4774fa295babec79bb.1728565530.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Oct 2024 14:07:16 +0100 you wrote:
> The PHYSR MMD register is present and defined equally for all RTL82xx
> Ethernet PHYs.
> Read duplex and Gbit master bits from rtlgen_decode_speed() and rename
> it to rtlgen_decode_physr().
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: realtek: read duplex and gbit master from PHYSR register
    https://git.kernel.org/netdev/net-next/c/081c9c0265c9
  - [net-next,v2,2/3] net: phy: realtek: change order of calls in C22 read_status()
    https://git.kernel.org/netdev/net-next/c/68d5cd09e891
  - [net-next,v2,3/3] net: phy: realtek: clear 1000Base-T link partner advertisement
    https://git.kernel.org/netdev/net-next/c/5cb409b3960e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



