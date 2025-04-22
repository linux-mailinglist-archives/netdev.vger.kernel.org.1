Return-Path: <netdev+bounces-184617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CAA966FA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC717860B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122522777EA;
	Tue, 22 Apr 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awxmA0WQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6037221289;
	Tue, 22 Apr 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320213; cv=none; b=gat5DAqD9KPXx0iE/gpwQ1vHf08Cx9BNZE11LKu4BwM/t5N/LVs1X+1lPNA4Y+O5ObF0/TM9CyFhTCSmxC9DuIm3NVNFD6g5hwCzlKPTCXWZDtNr2y9jyxT+2LFq2VdR0kKmnh7Frpr+PP6e9SHBCUCB+YmBwpMDCdHqXYXKASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320213; c=relaxed/simple;
	bh=GzqkO6YZ+UQLBiOzWdnJXQt/hmwj9IaJe0/G6ZIzwh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i+4J4FOYfjfACRAHoDE8zX4RHWPPRMFJwCWBGQFGkWtA4WzScQlDhpEzwiOgPgoMwDgf95C5kRIJMg0utwSBVVBeFdd5bZo/tJSRnvpAJC0jgFqB/foHbmUnxzn9LovCRBDVcGuzxWnXhoYURekVnlvzyAeAyi3MizIv4V8BujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awxmA0WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7EDC4CEE9;
	Tue, 22 Apr 2025 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745320212;
	bh=GzqkO6YZ+UQLBiOzWdnJXQt/hmwj9IaJe0/G6ZIzwh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=awxmA0WQevovM40hf0uRhZYIEUqybdo/lnKSTNRu1ZwFvgNSWfadtSGI0TYCi+D5U
	 sHQrIKvlzSbTOmOoVJBh5srf+xbhZpEOF/kKaVapC46Exl/0SQ/b5abNV4AZ372/rt
	 edt78kRyNkNn2E7OxvHQ4L6TFDOFZ77qJ8yaisxYOx72Xxf1Bg92NdkULf1n27Ir0t
	 OI5PG4L/25/q8wI4dyMoAoMrnSuylYeqs8mx/6+nQMlDBjkbXxVIHFt7OdorQH53vM
	 M5ArGqgpAgpEp28AOHHG2PIc7MvG3BDRisnsJ5ofVPwN+mMLcvXdVeDqfHw7wi5lxx
	 t9P3oSRQa91eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC0B1380CEF4;
	Tue, 22 Apr 2025 11:10:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174532025078.1524038.5341075048950701017.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 11:10:50 +0000
References: <20250416102413.30654-1-fiona.klute@gmx.de>
In-Reply-To: <20250416102413.30654-1-fiona.klute@gmx.de>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Apr 2025 12:24:13 +0200 you wrote:
> With lan88xx based devices the lan78xx driver can get stuck in an
> interrupt loop while bringing the device up, flooding the kernel log
> with messages like the following:
> 
> lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> 
> Removing interrupt support from the lan88xx PHY driver forces the
> driver to use polling instead, which avoids the problem.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: microchip: force IRQ polling mode for lan88xx
    https://git.kernel.org/netdev/net/c/30a41ed32d30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



