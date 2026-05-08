Return-Path: <netdev+bounces-285995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D0IBIJf/mmppwAAu9opvQ
	(envelope-from <netdev+bounces-285995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE574FC311
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF00E3012231
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610E361679;
	Fri,  8 May 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWVYJkYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225E35E549
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278267; cv=none; b=K2pIf9c+jNSaYrN6rTENHcXNcRYw4/R2SQ6zLwnRJvnwmzTWGy+cOs1XBGbchlKkN6JxFWEUnrN1DWpJzuE6MlCkUXnj8A3WkbI0KLTFLZhb8N9jY5CISbwRfHQqzXEY0j55kXUgBDvg0AHM8aR+ntSk3obZL6AASTy7xhSm+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278267; c=relaxed/simple;
	bh=ZP59YedXZ3l35+IhyoNPek8+v//hmeH+lVKjMUmB6jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYs/yo2mDqSwaEBIZ7OxSqsEk+UX9qTC2E+enwKcSigONplw1vNbz9Z4jrCsyMUrNCb2/Oy1V54B6vNz+6KuY6bhR4/KJmwmzYmMyF0dUf1E6uQJHETQ/DZkcXb2bsmLj3CK8eiR6d8KcyBv+xGP/SzSkHBeNA5/PFrqMQ/pr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWVYJkYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E3C2BCB0;
	Fri,  8 May 2026 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278267;
	bh=ZP59YedXZ3l35+IhyoNPek8+v//hmeH+lVKjMUmB6jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jWVYJkYqkg686PVMDmu7LQCtqkPhxcgEwCjhjdK0OEsKmzPLvEVKO+j84ernFpHDk
	 4Doz/3HMGJeio4ZXB+cflRVAiqR079qRs1oRATkuunsBODh0dTWsDSV6ONzIga2c+q
	 r1LnoL638ivx9Z3fNVw1qC25OonKkxI43pu3DagprvgZuFepzGcVcTU/rAbzkKwvmI
	 /BVJHxqScf3asEXkDoe5Nxa5q5e6Xee8ireOxZ96cCEZMUAQ8gCNyQWNP94H1Lh7kz
	 70EImd8MEd+ipKNy8/+gxfnuAv9ReTDYDWMYbU9UNK9UbgMuHHdaQLOjad1ovMJlZx
	 a3OB/xowJiD0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA08538119CC;
	Fri,  8 May 2026 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: atheros: atl2: remove kernel
 backward-compatibility code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827821529.868876.16899896123456516633.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:10:15 +0000
References: <20260506054035.23710-1-enelsonmoore@gmail.com>
In-Reply-To: <20260506054035.23710-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mingo@kernel.org, tglx@kernel.org
X-Rspamd-Queue-Id: ABE574FC311
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-285995-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 22:40:27 -0700 you wrote:
> The atl2 driver contains code for compatibility with old kernels that
> do not support module_param_array. Backward compatibility is
> irrelevant because this driver is in-tree. Remove this unreachable
> code to simplify the driver's handling of module parameters.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: atheros: atl2: remove kernel backward-compatibility code
    https://git.kernel.org/netdev/net-next/c/ae5c3718aeec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



