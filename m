Return-Path: <netdev+bounces-110712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D792DE4E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19560B21C43
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0EBA37;
	Thu, 11 Jul 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkj5Ix8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB89441
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664431; cv=none; b=E3ZX9RtZXFkXuVREDwl1t7f9r967psHFMzGaCopfl+9QUyjYtuV3fQ2vri55mgsO50U1xCYWAYG977Z7VvNRWzCQVxGxRp4/xaO2aH7mSbZHnHlY+/4MGq1yjhIqTfDQeiEGYxbzcdVG9JnmIY4oBgI8dRvX1AmN+XL0ysfnIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664431; c=relaxed/simple;
	bh=vAF/QTbAVMThFdr5lxV6H/OgHYccdgMNGZOJWh+1EWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJPewwq0ydhQxvmVco7bKu43XO72QSJGXK8Z4eZKbagB1dGm7eKyFN7OKSzUma1RBkJL3cW/+ZxpOKINvBfDtQhegc1ztByLMcFE95sixV082dAK0yNBICkuZIp5zjCVziKOgSh0jjdee7cISzJbvsKyqRBWXwpwLdUOYxYq5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkj5Ix8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBAC0C32786;
	Thu, 11 Jul 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720664430;
	bh=vAF/QTbAVMThFdr5lxV6H/OgHYccdgMNGZOJWh+1EWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bkj5Ix8t9FKeqEIyMPA2r+Dgfj29JUi7mnxuCMyNftSfdf4Pn0nGJDGV+BurVXjZv
	 dRP3wVZ9LjhJr5Qmz3aMkB9KvSYTh4PVo9lDJMhU1y+mzJM6NMAFcIFpC7fDjj+4H4
	 G0GOBAs7RFuWC8uQ3SQkbOW1M2HyILLeGcFCQVAiO0EzUamyhsrmOWPGzsOb3GCDYE
	 reQoyA1Ffm4fi9068udiyeOUZPxk4TSkYWV8WJXZzjtwg/qcNzk8LKBoDAz0uHPn4U
	 zcqcsb9MDuVMSJtIREhf24SNhdiPlpRfAd4C8D4aSWOceZfcIKg+pjGR/Rn2NAxiPW
	 MDd5YTKvtabgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4707C4332E;
	Thu, 11 Jul 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] e1000e: fix force smbus during suspend flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172066443066.28307.16973037048881070755.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 02:20:30 +0000
References: <20240709203123.2103296-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240709203123.2103296-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vitaly.lifshits@intel.com,
 sasha.neftin@intel.com, hui.wang@canonical.com, pmenzel@molgen.mpg.de,
 todd.e.brandt@intel.com, dmummenschanz@web.de, morx.bar.gabay@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 13:31:22 -0700 you wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Commit 861e8086029e ("e1000e: move force SMBUS from enable ulp function
> to avoid PHY loss issue") resolved a PHY access loss during suspend on
> Meteor Lake consumer platforms, but it affected corporate systems
> incorrectly.
> 
> [...]

Here is the summary with links:
  - [net] e1000e: fix force smbus during suspend flow
    https://git.kernel.org/netdev/net/c/76a0a3f9cc2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



