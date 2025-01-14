Return-Path: <netdev+bounces-158276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92786A114E8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DE93A58EC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC92236F8;
	Tue, 14 Jan 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYb5R2Wg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4E22333A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895619; cv=none; b=iNrOe3ImSxjqFDDPN+Tn2Alhbzj4jMz0DJ0SVH+Yoc43omPlxzDPWEeGLrP4b3fQO0tsQI8uOb9W/mYeMOEEPiqK4dMhVI6HB2sCtL0u/Bo7b9vCQrf1Bb1q0pcB+YF2BDLisrkIjtL55UQOhjktNc2eXAtbTqH8PfQHcarGG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895619; c=relaxed/simple;
	bh=TZSwFNsSDMehy/iEufxY5k+rzQ6v3CQl3U4wfcVkIH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIt71qYW2tCJVc26rZYTYuI9u2RYPHYQNoRnoQLpzO5uLb2idd9gcOEZwCEj3JIIX9CmmbLQVXDq3MDOugmbdPLVYfcrgOfNUBNMKhrHrKhTYHJ9RDg+zO0KVDlLqidFQc3rjyXbdinpSrJRZOceC8nvicDV4vHMC/VVXHEqEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYb5R2Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE36C4CEDD;
	Tue, 14 Jan 2025 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895617;
	bh=TZSwFNsSDMehy/iEufxY5k+rzQ6v3CQl3U4wfcVkIH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mYb5R2WgatsiRQLJVJvnGtLqa4BRk8K3pMhv5jLeFfh2Vokry2R2zlpKdDn5Ok8/o
	 uLZPk973k9U7I7o3DJN4gHl2Xar27uAP/r701qOV7h7UV/ixoUiyHzllFuVOH74sHJ
	 mT+iTtC8iDq3tmQhWhjhXWzqWPGUAHL7w1ziQyZAEFcKzak8Wx2fHUUycpJiN3zXYY
	 yapgPiUnMn6z1pF9JfNbqZlm72136GY8SyKoVIcgeKY0pFRaBP9ZPeHe5z/SfGzX53
	 bPgXHvLtH4VBF7MnSebMEZJf1tUKwzpCJHq2POogLFU3w32BSuBj/4fKFNUo1lU5NR
	 HK8A9OgeSmFkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC8380AA5F;
	Tue, 14 Jan 2025 23:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689564054.170851.16667788845634635761.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:00:40 +0000
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
In-Reply-To: <20250110223939.37490-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 23:39:39 +0100 you wrote:
> Use netif_queue_set_napi() to link queues to NAPI instances so that they
> can be queried with netlink.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 11}'
> [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
>  {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
> 
> [...]

Here is the summary with links:
  - [net-next] tsnep: Link queues to NAPIs
    https://git.kernel.org/netdev/net-next/c/b1b5cff6002a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



