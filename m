Return-Path: <netdev+bounces-265859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGkrJY99r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:10:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F57244100
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 229973026A52
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7732E138;
	Tue, 10 Mar 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPle6Dw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE53246FD
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108615; cv=none; b=VTLbMarmcJBQ3Zrx8s9jvPHq6KG8QzkYe2jRqg15bm64yUtenrpMsMr8BJqO/UnREWLOVU9yqcghhkJEAKlfe2rQVejc0PhRz4nGqEeejO3cvro7XmpIF94YoWiwFZXEEU7LOvasp8foDDbs0jc0kr9IlLg7ZzpHKD0aRffrX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108615; c=relaxed/simple;
	bh=xOX1Tgea6sBAe1cKM1iIh7wKEwsEfRY6zIlgbi7NEuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0ykjvtTtVYndb+nO4rAi3cHwy7eTpyTcmwJMGtAYMR4NfUcl4UzJW+2P/Va5BIVdaj42je8t9yOzXe2JdBSoe/8ZHRATcyf5gdoUa+O49yacXt5WjZ1mOvJhJGJrSvbGG70zgTAcDxyAug1tO6iUt0i7HHxhKjfc4zZ3/EdWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPle6Dw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6332AC4CEF7;
	Tue, 10 Mar 2026 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108615;
	bh=xOX1Tgea6sBAe1cKM1iIh7wKEwsEfRY6zIlgbi7NEuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OPle6Dw6I8CbKYgZ0/EM+u2f6CMNXwaf9uYayVCbdOPWgewG436XLG2NCwoSW/SHf
	 QUQ0QrhSrMJuQe9zEDChvH3B58nslZrigvO2Kb6PuyRGDCJcxn0senD4OnxUcXxM0O
	 9cbBmpleQ9Wb1NeSCRDTEomZDOEs0hgMoYh14tKfrmEtLXKnFTzorF7e7wQDzt9zjZ
	 g0zah37kw1sBXvWqJw6XKY6Ol07whiDqE6FH0w/wz9GcZJsCueYxN2KUowa8aYFqIF
	 zULztfx6Fti93XG7R6tCgX30vGlXxp7sbnBrMUontoFWqyHq3N8o2/+IF9LhNGcscv
	 veRSBeRbA2iMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4D3808200;
	Tue, 10 Mar 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: am65-cpsw: Use also port
 number to identify timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310861229.2026004.10002739128726004925.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:10:12 +0000
References: <20260306144439.cVwaaopR@linutronix.de>
In-Reply-To: <20260306144439.cVwaaopR@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, edumazet@google.com, kuba@kernel.org,
 martin.kaistra@linutronix.de, pabeni@redhat.com
X-Rspamd-Queue-Id: 47F57244100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265859-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Mar 2026 15:44:39 +0100 you wrote:
> The driver uses packet-type (RX/TX) PTP-message type and PTP-sequence
> number to identify a matching timestamp packet for a skb. If the same
> PTP packet arrives on both ports (as in a PRP environment) then it is
> not obvious which event belongs to which skb.
> 
> The event contains also the port number on which it was received.
> Instead of masking it out, use it for matching.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps
    https://git.kernel.org/netdev/net-next/c/a23c657e332f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



