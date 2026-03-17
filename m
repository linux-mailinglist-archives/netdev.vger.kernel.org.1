Return-Path: <netdev+bounces-268401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMYnNHXBuGkfjAEAu9opvQ
	(envelope-from <netdev+bounces-268401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:50:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5792A2ECA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B0B300C6C2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DDA2C0F69;
	Tue, 17 Mar 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZdKo4AN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D62BEFF5
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715816; cv=none; b=UjqqR6VH7m9YozbIkypLuCNPLa8mF8BhytRaWs3rq5FK5t3ptxj4N8QV80aPGDhyHzRE/+5QveoZPmICoqSVJfm/T2sCZpW7DYfi0S6ycPJP4BFQ0TzKjBOjVTbJwrRqyOTOFHK6pbXgaCLStq5TwHAf2qCHdt7OzqLZfzO+mVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715816; c=relaxed/simple;
	bh=fwYLZmdG7Br26YikRB0+6SgNqUwSycahX4/4VwpeHKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nGgBSIitjjE8Ep64k1M7GUyhzCBKRHlx5Ni3irXTJP/pwwf7g5VNsIFe8Fh60z1DVfy9+/HICUskI/5srYgY1y/XsS9HSKwaWYJmMkT2o3zgXHYpXsrmG1fAGAUayhS504bFdNA4g6q/BiFA9ZJDxlEUYCO8XiS3tIh7RgbDtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZdKo4AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4A8C19421;
	Tue, 17 Mar 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715815;
	bh=fwYLZmdG7Br26YikRB0+6SgNqUwSycahX4/4VwpeHKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AZdKo4ANmmvnrETYhR18EZ+tzS1XOPkJyHwXqNAv//pv7uNiFybSkVZi7HFCXuIqE
	 GTIgQc9aJWORsVfZeQXwe+ESAS0uO7ZE4sR4EH2kxwrqEoosIdPj4/nP2w9F6iomf9
	 SeUl0emtiaXg+8Q/l7dkc0R4sbLXb78kHPI35ZnHOro+wMRKSAq/KXlIUYNRrdqdk7
	 tvpfnyoj9cOYnOJi3BEb5CdB0lxT7VR2wd/4Lpa1HCfY9eTvDsmjFr1DG+q7jMWAxK
	 jQ3vbZjmNXPy9tsk7L0w6gQiPA6GePkCrBImxa0gb9x/yHsXvA3DmWgluMtEdcDJqP
	 wNXcYXg6lGBmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E263808200;
	Tue, 17 Mar 2026 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bonding: prevent potential infinite loop in
 bond_header_parse()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371580853.3402731.12817143500896878160.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:50:08 +0000
References: <20260315104152.1436867-1-edumazet@google.com>
In-Reply-To: <20260315104152.1436867-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jiayuan.chen@shopee.com,
 jv@jvosburgh.net, andrew+netdev@lunn.ch
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,shopee.com,jvosburgh.net,lunn.ch];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268401-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: DB5792A2ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 10:41:52 +0000 you wrote:
> bond_header_parse() can loop if a stack of two bonding devices is setup,
> because skb->dev always points to the hierarchy top.
> 
> Add new "const struct net_device *dev" parameter to
> (struct header_ops)->parse() method to make sure the recursion
> is bounded, and that the final leaf parse method is called.
> 
> [...]

Here is the summary with links:
  - [v2,net] bonding: prevent potential infinite loop in bond_header_parse()
    https://git.kernel.org/netdev/net/c/b7405dcf7385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



