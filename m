Return-Path: <netdev+bounces-291447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE7aBZqqFGomPQcAu9opvQ
	(envelope-from <netdev+bounces-291447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8615CE2FA
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9899E301CA7D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED778388366;
	Mon, 25 May 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biDXIKMV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5439098E;
	Mon, 25 May 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739209; cv=none; b=TV59Og9RCsvFQVWgnvzz/tCgYNVXA3HLn/il5YF/YEkcW+P5Sgo6rKverfcCW/Cuw8uIkNGs2/YKrN4qz95UkR4OYDIkGGdbZQ0OhwpLpBDV8whZO9nbn0yr1sWMmbsfaleQ7rDp6SUhwOsevpYxUWL+J3o/H4gIc0iDSQqiwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739209; c=relaxed/simple;
	bh=hkjHBVj65xlKHdsXNCFFwjhUfN2Wa2/1qi9Z9Y3oJKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PkaWiV6sllC0Vtbpf3n90KdEvz8Zz4TBag+BhUo5W1u941Quskn2Hx3pjC3wKGcsOwCFgvAQm8ozwDGFow74v+0nPHB1QHht8jpKEKjjRGfRrQqiwSrY9zuERutgT/H25Sj/aCStYMy3JEbQykegh8wxNWhdyO+44FZ+sE4Ab7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biDXIKMV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4971F000E9;
	Mon, 25 May 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779739206;
	bh=qT7JMdmmZiTguJv5/hAZJHA35APPqEIOSAN2mOy0Izg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=biDXIKMVEPqGO4xKvZsmPOaFrxOXdX/dCFBvpJU/b+Dlb/sjkEZLJ+cVzOGoVs+AE
	 AkXQjL4Ro/CTiUhie+ENSACBNUKZVyJ1B3J/HTQ4FyKspCgcv95iWRaU9yrwfE3dQD
	 6FVoc1U3K5MuarPzx/KhYYPUb11nda2BGIBWAmkziDQD26Od8CSPFEmrVeMrEL/hQd
	 uPtSlX1U3/AVAnrJDrlqpKyrTV4sRPRMOuEL+RWcSNl3eHSp0kYBMzr+WRHrqiKmkJ
	 MfCM92OkcxWFRJPXAaKlUvs0lGj4QS2a1HSgJYKuy+QAgaXsZ6PFKir0ejsil7n643
	 5T8evtFWAVeUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A35380AA76;
	Mon, 25 May 2026 20:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: lan966x: cleanup error handling in
 lan966x_fdma_rx_alloc_page_pool()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973921289.3098866.10215645717913096910.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 20:00:12 +0000
References: <ag7_YBWRpRmY9MGT@stanley.mountain>
In-Reply-To: <ag7_YBWRpRmY9MGT@stanley.mountain>
To: Dan Carpenter <error27@gmail.com>
Cc: devnexen@gmail.com, horatiu.vultur@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291447-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F8615CE2FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 15:49:36 +0300 you wrote:
> This code works, but there are a few things to tidy up:
> 1. No need to an unlikely() because IS_ERR() already has an unlikely()
>    built in.
> 2. No need to use PTR_ERR_OR_ZERO() because it's not an error pointer.
> 3. Use the returned error code directly instead of using groveling in
>    rx->page_pool to find it.
> 
> [...]

Here is the summary with links:
  - [net-next] net: lan966x: cleanup error handling in lan966x_fdma_rx_alloc_page_pool()
    https://git.kernel.org/netdev/net-next/c/640656c30a6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



