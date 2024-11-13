Return-Path: <netdev+bounces-144294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE369C6751
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04891F23E74
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414415699D;
	Wed, 13 Nov 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS2zAdeu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940C1553AA;
	Wed, 13 Nov 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465023; cv=none; b=SVmbRsbQSJq+eaL3ktgib+uTrN/GI+Kqtt49sBdSa4W8sKfyWr+YzeI7zvczgoVm+DQDTbOEB0B41E9aZtptmbcn1ViLHc0CqMK3+MlydS5NtugXHyZmHMAGvuMbVnbrBRTiOh7sX/X8MqO/SAsXU1nn21Iq0qYo4jKVwsMq2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465023; c=relaxed/simple;
	bh=zLHKZJnlbuKLGagziDjOpu3KpVn7t1f9OZVaIn3hrkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOGTbBD9f26z3XzeASBzhG7zf5RK7nMhgu3VZNpf3h60vLuOuPoRmd3BIpYRaXmytf4EMwdEvAwAUxV+fH9f7ZEIR1bXcddkpJOkrp1NKn5PGhmkV0a/1Jp9ymW8z4NEWZ9Gp43c/dcX6h6gDD1MZRyHg2vwqNWMYaTLef7rNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS2zAdeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC7DC4CECD;
	Wed, 13 Nov 2024 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731465023;
	bh=zLHKZJnlbuKLGagziDjOpu3KpVn7t1f9OZVaIn3hrkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qS2zAdeuKpPI8jSN9Ka4393Vcq+XkLIFRv0rUEUFx9qhIQmT0W+aznU86eoQU4UBw
	 +AFNxUW1C0A5tIwwecx61yc15kKuz3RfD1NUXYc2PqwYuDeZAYvLF+lX0LENV59yJo
	 PCNnarzCcnEEiE+JnueX6lPogyeCFCCnOnUFHmTz0mZBjubguI0KqRHVyTGkEWf4Lk
	 9pbU66fA8HphOlnsoYmo9EdUVVcsDY7aXCFvvEnjAyjvCd7cg5YOXagLPHz7ea77Wd
	 OD/BuT+tSsiMxpL+0RtEOfEDiAFkhuZm4RsHKkK5ncWo0eg8kq9vMmUd2M7/5BiDl0
	 HU6SZsycVfdcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FAA3809A80;
	Wed, 13 Nov 2024 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for igb_msix_other"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173146503300.759199.10344686078922792522.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 02:30:33 +0000
References: <20241106111427.7272-1-wander@redhat.com>
In-Reply-To: <20241106111427.7272-1-wander@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, horms@kernel.org,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, tglx@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 08:14:26 -0300 you wrote:
> This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> 
> Sebastian noticed the ISR indirectly acquires spin_locks, which are
> sleeping locks under PREEMPT_RT, which leads to kernel splats.
> 
> Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Revert "igb: Disable threaded IRQ for igb_msix_other"
    https://git.kernel.org/netdev/net/c/50d325bb05ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



