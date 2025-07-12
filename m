Return-Path: <netdev+bounces-206302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F5B0285E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D378F5413A4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB178F26;
	Sat, 12 Jul 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGEBXw+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7E2F43
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280792; cv=none; b=pT1nTMU30BbXWEYOHB9b3+PlKv6bFZ9OQmemDZo3KTGgFvht2F7J9DxNsssYFduG2K3sMXAuMX4nVvbZSm+uwbVg74RaB0qLB5bydO6OJ2pJIeTqdPxG3f0mHrKbnOL2U1L6139/xf2S1xY3xoo3ViiAB4Q9Rz+W9WFJuNazNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280792; c=relaxed/simple;
	bh=tRbjyakX1bgZGxi0AlFKIgxvxaDmRzMlLSlBqD9s2mA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nj84HRCbH6ZtiYObTa+iCk0/zfqF2oj/JOXNdv+hXzKVjJepr8kkabsX/K4fPJFOCkheIsPuBi05QZ6tiPRzDhHjeisWkJE5sWOFrRC7MLdEDs+StqzT6KtdfSZllUNDOrtF1BPnpOeiisWEuAHO1DmzF7o9VZt4DZM8aOJEF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGEBXw+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B69AC4CEF5;
	Sat, 12 Jul 2025 00:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752280792;
	bh=tRbjyakX1bgZGxi0AlFKIgxvxaDmRzMlLSlBqD9s2mA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mGEBXw+3+4n5U7qcVMRjYepUqNhLMxlEXFNCdIOM8XjOp88/+6+cecTJ+Txjgp3wp
	 EPHVdqH71wKq9GPdQRi2g9uFXd27ofL3YdP+UE+OrbEDwGeX1ruNH7j/gOKsj3lB5X
	 zO5Tsd5fd31KN3ILKnQvBX5ysXsxzSsXEw9ZlkdSgTxkqh0qvRWkzzyt5PjpFXD2z7
	 w0WngiONl0F5lV+NLxUBKYIJEnMeyeyujuB64jN7SY1OkQ0kpMYeAsrBDSoVUU+7hI
	 rSP9oyLUVt7AaGX+n0hfNkljcAaWPWaDdkvs2XuNdvW2KXZP4tb/cKLdPQjtt6cGxj
	 rgkwtivc4yQ6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC0383B275;
	Sat, 12 Jul 2025 00:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ll_temac: Fix incorrect PHY node reference
 in
 debug message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228081404.2448508.492562991467261376.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 00:40:14 +0000
References: <20250710183737.2385156-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250710183737.2385156-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 11:37:34 -0700 you wrote:
> In temac_probe(), the debug message intended to print the resolved
> PHY node was mistakenly using the controller node temac_np
> instead of the actual PHY node lp->phy_node. This patch corrects
> the log to reference the correct device tree node.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ll_temac: Fix incorrect PHY node reference in debug message
    https://git.kernel.org/netdev/net-next/c/a393644d7d16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



