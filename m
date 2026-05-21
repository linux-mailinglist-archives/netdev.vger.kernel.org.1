Return-Path: <netdev+bounces-290170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKwAJBtSDmqX9wUAu9opvQ
	(envelope-from <netdev+bounces-290170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F359D4C8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0853302F7D0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84525B0A5;
	Thu, 21 May 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFYPa6d9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D891A9B24;
	Thu, 21 May 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323409; cv=none; b=Pw4Vh32drUCh9XpVA1j8M4SKupg06/UbiPAOjJmSoRpVrgekjo57E6ak7mPT95q5Mf4No1axUDLYomz0PATgDDR2Vm+MVlD2jD4UrT18NxKdh83A8zdvvYOKrHnBdSTTh7/3EF1+cpwOr6dytX44eDdNgtqY8yNPnhWvuGO88Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323409; c=relaxed/simple;
	bh=/pGfnhdQ1kLWJaijDfKPcOvydaMXNMxF5XJTyMVFazM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbQzZKZNZXnA7wTpvfLOhcT9ET+9WfkwCggAHtE5bW3WTARDuXfvLp7BmBZVuZJBigwKGU3LC3eQkv4v37W6dvsX+K1Cd1DE3FXu/t5aBdL9GgyFt5I6OaklqVfRQLaXESEiIyDtpfhxmffGSc2DU9pup8mHgCLySXNFfw9iukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFYPa6d9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCAD1F00A3B;
	Thu, 21 May 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779323406;
	bh=x1QbEU4Zhxd3K/Td3Tn7bQAyEvhMcbs2AMdSSiP1WSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YFYPa6d9CyLG6V/xuJGl7mUaF+zUIBsektY50wFz5SeKpQ+OghbhHlHqQECRm3nIP
	 4cbtr7OxF84gH/VyA4LSfkMfyYufG3A/BTYZBOohv088j2NdGvbD6BuROgzAGnz5Iv
	 cJrR1c2bMwBgjjpt5D9xEf7vcG3dNXRQQyh8c162BGcieUZFlWEXIlCgbyMmDhm20w
	 7LKWyAZisN6SPZRgts3QrrscpnLEoBjjllZIIN2vygQGHgbNcwa7laVe5BRHKbsZFL
	 BiPtNJPK9ICxIJyz7BAGQyS5WpawL2g7/58pPOW2metkDmj0vna+eyBQJbyEmK/dPA
	 zCBGaDsNnF44Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09AD3930C25;
	Thu, 21 May 2026 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932341638.3808433.11694641840948060521.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:30:16 +0000
References: <20260520204959.2902497-1-luiz.dentz@gmail.com>
In-Reply-To: <20260520204959.2902497-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290170-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F1F359D4C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 16:49:58 -0400 you wrote:
> The following changes since commit 375ba7484132662a4a8c7547d088fb6275c00282:
> 
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-20
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-20
    https://git.kernel.org/netdev/net/c/5027c886e26c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



