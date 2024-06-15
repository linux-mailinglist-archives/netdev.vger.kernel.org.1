Return-Path: <netdev+bounces-103762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A49095A9
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0DD1C2128D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC153A7;
	Sat, 15 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li+RevgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663341870
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718418032; cv=none; b=DT+8vlmGeXf022hfNow2G5tKQGLyBYkPdR8xf4ojIJ4+eKIAJBzKF0t+WI4W/inLQSGKzA2RVo4GAgY5JN/VvN4xA0ZC4KkFHXT24KLkPC2lnThPnpUr/OZSORt1HULuJu+/tQBYBCijQutuNQ67xIDP9/Szbr8wMXanHqIjL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718418032; c=relaxed/simple;
	bh=dXCciq7hbz+VJq0KyB26hwD3PZHzJw/KstkjzidE/tw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dNhLTuUtCsSbvx5KcvbohOnNijIp5e9m0gZYt2wh/eMjiVzyPinBi/yc+HLGNHFGzYeFWgH0NpGR8xHwVVIpVPJqBzcx45Chm+d+lZ4q81FlEW9YnIO+3RBB+haR5HQAGnfSHdkDuICO2+JXizdkEbUi1SnmwENgAPgWEqIS8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li+RevgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2940C4AF1C;
	Sat, 15 Jun 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718418030;
	bh=dXCciq7hbz+VJq0KyB26hwD3PZHzJw/KstkjzidE/tw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Li+RevgUQB0DoaHDbTBjNr0237bh3f8wJSv/YGUfEwHEblLS3FAG5UbfhQ6MovhBw
	 L7yLiQ0E3HpnsbTv8zxMN40UDOunqjNvPGuk/FDqB0Tdo9gP2aAsiw8ISzEeUWCte5
	 dWlxHMHe6zIH6V0fQ3pfY8z48Bt2eQTBSscGx53IYS5Hnv2fZ6/smDDYdTzonfTnjr
	 bFBwV/2B+ZTBHR2qtFMtt0GJGUybO4hdD4PDUM2XmxXGsYzLiHLUvIknm2svbeW8xa
	 WDorMUPsl64w8db6+4gGnyBXzMznZCjhMdxIhJjvvsI4bh2PljCh2MehEcHUMmQH/P
	 Hp/Pz99pqyXHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D025FC43616;
	Sat, 15 Jun 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3][pull request] Intel Wired LAN Driver Updates
 2024-06-11 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841803084.17922.8966790695847981662.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:20:30 +0000
References: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 13 Jun 2024 08:45:07 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> En-Wei Wu resolves IRQ collision during suspend.
> 
> Paul corrects 200Gbps speed being reported as unknown.
> 
> Wojciech adds retry mechanism when package download fails.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
    https://git.kernel.org/netdev/net/c/bc69ad74867d
  - [net,v2,2/3] ice: fix 200G link speed message log
    https://git.kernel.org/netdev/net/c/aeccadb24d9d
  - [net,v2,3/3] ice: implement AQ download pkg retry
    https://git.kernel.org/netdev/net/c/a27f6ac9d404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



