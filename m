Return-Path: <netdev+bounces-275312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIgzNgBe0GlU7AYAu9opvQ
	(envelope-from <netdev+bounces-275312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:40:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED103995D7
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD032301AA55
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43A22652D;
	Sat,  4 Apr 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ7dzl7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FB145FE0;
	Sat,  4 Apr 2026 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775263227; cv=none; b=qg4puIWQhF0qdLel63GK+o7BtuAcopPjO3FyaQSKtg3vIfqdJ+g30qlzpd9ApW0lhKMMtqMacbd37CE/6mEeMBUCUUdSdOlPYaKLF0OK4PRH1IG9+TM5WHQ6qM5l8vJV96mqNmGg669gUbGNqcwqey2piWOedSOS+uuQvJ9VOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775263227; c=relaxed/simple;
	bh=fIaZP4a3RwdqR2OP6iHxwpQec3oUQSQxBcHAAO2X8aQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJiHVCwz+x/UwzklyJVR/QgO9JE9PukG5jvbDZQxHy24Lw/053fIc6XrG9y2F2sUeoDm8CJe3j/eo00L3RNd2E3FM4QsGx86mRuXv+n4PXccIhQOoN8JtATgBSQDDoNZL5ipovSCFHdaDXKk0HQLwAnE2iwg2vGhs9qCQMYjrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ7dzl7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D6C4CEF7;
	Sat,  4 Apr 2026 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775263227;
	bh=fIaZP4a3RwdqR2OP6iHxwpQec3oUQSQxBcHAAO2X8aQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJ7dzl7Vvc5BM+e29VunjJf4VhD35Hzq1mY2M1Vbpw5ilVliI9IUmRDJntj0DCeHk
	 hC27co6pow5Ijn19fuoyobRvA10UFaGOZorHYuMAd607sKQFvkrpHyb/L+WMamZPhV
	 +tClLM83axDCaKSgI96J6vqRyhC9JIvY3WN7TA615n/hWlFFR2C6O+JU0Dtuo2P6h2
	 sVROv0K0LMFjeLzA3gQ975QoiAfzUx6cb9S9WovxguxmD4etsGeLen8oOq+5zhEVFb
	 tBZFd6Abp50jWEIfs3dG2kO5RdgEsBiTZl24TEMypROgrJZmygPdE+0n2XIN/7mHq6
	 No19syzJKtbKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BB03809A14;
	Sat,  4 Apr 2026 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] dpll: add frequency monitoring feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177526320879.1506823.5178557278060663693.git-patchwork-notify@kernel.org>
Date: Sat, 04 Apr 2026 00:40:08 +0000
References: <20260402184057.1890514-1-ivecera@redhat.com>
In-Reply-To: <20260402184057.1890514-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 kuba@kernel.org, jiri@resnulli.us, corbet@lwn.net, mschmidt@redhat.com,
 pabeni@redhat.com, poros@redhat.com, Prathosh.Satish@microchip.com,
 skhan@linuxfoundation.org, horms@kernel.org, vadim.fedorenko@linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275312-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7ED103995D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 20:40:54 +0200 you wrote:
> This series adds support for monitoring the measured input frequency
> of DPLL input pins via the DPLL netlink interface.
> 
> Some DPLL devices can measure the actual frequency being received on
> input pins. The approach mirrors the existing phase-offset-monitor
> feature: a device-level attribute (DPLL_A_FREQUENCY_MONITOR) enables
> or disables monitoring, and a per-pin attribute
> (DPLL_A_PIN_MEASURED_FREQUENCY) exposes the measured frequency in
> millihertz (mHz) when monitoring is enabled.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] dpll: add frequency monitoring to netlink spec
    https://git.kernel.org/netdev/net-next/c/3fdea79c09d1
  - [v4,2/3] dpll: add frequency monitoring callback ops
    https://git.kernel.org/netdev/net-next/c/15ed91aa84ea
  - [v4,3/3] dpll: zl3073x: implement frequency monitoring
    https://git.kernel.org/netdev/net-next/c/bfc923b64287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



