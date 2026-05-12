Return-Path: <netdev+bounces-287172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJizM9UzA2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:06:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38A521F38
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 423D530D1C78
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD93812EF;
	Tue, 12 May 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDpvAfxH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550543E1730
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592664; cv=none; b=b+fFgGk5kaLHQaX/I0155kZ5nfmKA49NUBQ9BLICpqtQ4nYjGMhLXzTZupdaQxPhEgw1UgPhMSkNfHSYHTSdtpFizC6Rdszkh9EDF4c5RGxj21Z0fDSdqXGAo8vCG1gW/pJWKkpz1JhC91q47z/BB73ZlLhBt3xRDoVOTbMvtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592664; c=relaxed/simple;
	bh=Wfy8WwbL/9Cw/Kbe+MbRT5OnmCMGC82DT9znqzBVkh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AO4tVzpJHNSC6Mr7tmkL5yLA/kQbDk8zTZEjXBw7RkstwsBPmfzZxc+TJdxUN29yeM2w7uRJ522SBT18FP8AhrGMsnzDqCrKsp+QkOApw7rwzP/rudV1A+TxrbdwVV/tj9o3D1t1ko/3GhbzYSBbvcr0cp0rXlhtTylcgDuG4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDpvAfxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F36C2BCB0;
	Tue, 12 May 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592664;
	bh=Wfy8WwbL/9Cw/Kbe+MbRT5OnmCMGC82DT9znqzBVkh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HDpvAfxHgfDNsF4RXpFL8dP8XSGz6UwoRdj99yEJsKnF0uBMS6DtuGf6dIatYoFAe
	 r6SO3+ofTA4ndzQayhNLeJQAGryWlBkeO71eJMCDKM7aWBq6i2q7lglmjNBJfE/714
	 P/7n1aI6wlsx54S5QTYePs3uc7U8ohPdPyT1hdROMMJYSS7X49Q8MgLCUPtN9YZK+V
	 P5FFx7fCTn27GuNv5BJdv6lkPpMz4HX3du2J7dinWtjdaXwPO9O1VNGesji3cFiJR1
	 4ZbKMUbyf1mXhiy4mFiKaeXs7PvEwp7d0SeAP48EaiQLX5hKlalwRI+7jWUM1m4+w2
	 wTVrPiGBexHoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9F3811A4A;
	Tue, 12 May 2026 13:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: ethernet: cortina: Fix various RX bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177859261029.2867035.2299356412350665354.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 13:30:10 +0000
References: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: eitschman@nebelreich.de, ulli.kroll@googlemail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org
X-Rspamd-Queue-Id: DB38A521F38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287172-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 09 May 2026 00:13:35 +0200 you wrote:
> During review of a minor patch for a bug in the Cortina
> ethernet driver, Sashiko jumped in and pointed out a number
> of nasty bugs.
> 
> This series hopefully fixes all of them.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: ethernet: cortina: No mapping is a dropped rx
    https://git.kernel.org/netdev/net/c/2cb156213093
  - [net,2/4] net: ethernet: cortina: Make RX SKB per-port
    https://git.kernel.org/netdev/net/c/06937db21ee3
  - [net,3/4] net: ethernet: cortina: Carry over frag counter
    https://git.kernel.org/netdev/net/c/ebd8ec2b309e
  - [net,4/4] net: ethernet: cortina: Fix budget accounting
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



