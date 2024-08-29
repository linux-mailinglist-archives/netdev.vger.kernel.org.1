Return-Path: <netdev+bounces-123179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4957963F57
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92312285E67
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07318D646;
	Thu, 29 Aug 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr4gvnY3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DA18D63A;
	Thu, 29 Aug 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922047; cv=none; b=gm87jiWZuVXbS/eozcUMto9DdDDSvTJUHYFuK1uJB3ZYSgYruPhxS+52LlvhRhzaZqroVfBRRXshJ0xE5ZzeAQOgCdhkHvjhRk+YSNYS6pu4mGoPQM0ggI9EEi0PTSI1t/bEQp+C/GK0+lFWRupVMPHt7uQ/KZ8MbMbrtovP7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922047; c=relaxed/simple;
	bh=6BojiaNWUY09XBvuS+zgRQKR6lgsm6LPxHreDLz8anY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alqiKUSO82criCXSfdUMyqp3Zx9zOpFarWyDUZAGwQ5uCSdZYGjjbE6AQLZL1gjdbj16m95+e+hbLjR6ckxD0MVLzq/A0D3bm2M2+T59hii5YaDR2p0mO1Z+9pDyCb0/zxKuwI93BCmEH+Q3C0ILDJ3Xc1B8UT2VJVb8NAMAbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr4gvnY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBDC4CEC2;
	Thu, 29 Aug 2024 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724922046;
	bh=6BojiaNWUY09XBvuS+zgRQKR6lgsm6LPxHreDLz8anY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qr4gvnY3g7/9kYCSLW3h01eJ+Nm41iaYXHBgNo7u3GufcGV6443rKUI4dM5DLJbNO
	 YctmfqOAFpZv9T82uxodQ5jNDeMLz8wnAZOibSQc8MhA3HH/lL/Ma44YKa1QMpWxef
	 ruXtp3CC/eJSBECUGVGLh/ZaPy8YLBvwwByURQXPAHjYGZ4dYIludXmyffsHW/gVvu
	 52K44tM+Zt2FRiUr+0K4ShjjFZulTBjhvcTQkeueGBdvuJiQ5C+JKBB2htQSrb3tZ9
	 RKZ8V79yw7dJY+s22BV4cGBzl9SxgD37MJ9xspc2aJxEwecpPltlXo/4MGoaJj3UTv
	 zxazmR5RDS/xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAE3809A80;
	Thu, 29 Aug 2024 09:00:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mailmap: update entry for Sriram Yagnaraman
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172492204679.1873855.17669189582904040941.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 09:00:46 +0000
References: <20240828072417.4111996-1-sriram.yagnaraman@ericsson.com>
In-Reply-To: <20240828072417.4111996-1-sriram.yagnaraman@ericsson.com>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.fijalkowski@intel.com, kurt@linutronix.de, davem@davemloft.net,
 georg.kunz@ericsson.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Aug 2024 09:24:17 +0200 you wrote:
> Link my old est.tech address to my active mail address
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net,v2] mailmap: update entry for Sriram Yagnaraman
    https://git.kernel.org/netdev/net/c/6213dcc752f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



