Return-Path: <netdev+bounces-169274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EFA432EA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87454188D223
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC52030A;
	Tue, 25 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYbcvWJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC661CAB3
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450004; cv=none; b=CED3GXqCfsvOscbS0w6jmITDr9B5Q8RwGySrDPqKUc8mfB7NHUr1lHc16SMqID0YfHXrK0simmXYdYUS2HyiGHSWyogJ+cBYfr61CT/j35g61aYuzg49R364gUrn5bEm6ucl074kNGVwl8CruWGvFQJvMM1cS1Mod/9Z/ijQSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450004; c=relaxed/simple;
	bh=crFP+aQNQvhrirnuCmYJzD9INiGo6ZyCl/4tfJXLkW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MI8HHGqRHrJHvrkDYztn4GEq11YfA4+efn6Q0IumUABvaoJ+XDw1sxR5oLB0XUfoxdWHHLkvuyPob196ln7aMH7SksNP/+hLnMqEnfEbiQGqGAmEviKPK4Gsernr/tLKbXwRHTvl4fI270kTjmLpoa46wadPlPpa9w05n6Lgc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYbcvWJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AD0C4CED6;
	Tue, 25 Feb 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450003;
	bh=crFP+aQNQvhrirnuCmYJzD9INiGo6ZyCl/4tfJXLkW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UYbcvWJlBW7PDCCvls6VWxDY9/jemfHFAcbJdHCe6Xtx1anIMnGzmrwxUeOFOq/wx
	 1JsnMXJwKczKCLoSpYDzSekai1mer0+79lPEQc/7n8GboR+6xRbA0oL0+9rkdB6rLd
	 YevgIG8RGaL6yUXMS5p5RfkVknuYwmUb+vTGPAQtm5mdjakhixEWfuUxHmTyhz+/6q
	 iX4/kK+3VOysozX9pDImlHyRJu12RAbmghcjKXwxnPEV7GkUef905mOhC3ZWYvge9l
	 /9FS86OP1KuVEhSHTyGtLytQc3UDzKOB6qOnEI17GtPnmczRB+7KsKre0XnGXp4u3+
	 0AJ/CuZQKulHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F18380CFD8;
	Tue, 25 Feb 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 1/2] net: txgbe: Add basic support for new AML
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174045003528.3679724.16102932517540026769.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 02:20:35 +0000
References: <20250221065718.197544-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250221065718.197544-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 vadim.fedorenko@linux.dev, horms@kernel.org, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 14:57:17 +0800 you wrote:
> There is a new 40/25/10 Gigabit Ethernet device.
> 
> To support basic functions, PHYLINK is temporarily skipped as it is
> intended to implement these configurations in the firmware. And the
> associated link IRQ is also skipped.
> 
> And Implement the new SW-FW interaction interface, which use 64 Byte
> message buffer.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: txgbe: Add basic support for new AML devices
    https://git.kernel.org/netdev/net-next/c/2e5af6b2ae85
  - [net-next,v4,2/2] net: wangxun: Replace the judgement of MAC type with flags
    https://git.kernel.org/netdev/net-next/c/a3ad653c9159

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



