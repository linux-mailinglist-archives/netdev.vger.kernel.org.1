Return-Path: <netdev+bounces-275798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f3vFLtZU1Gn7tAcAu9opvQ
	(envelope-from <netdev+bounces-275798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6413A883D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 640E1301221B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807F1EF36E;
	Tue,  7 Apr 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeHxDOrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A01EA7CB;
	Tue,  7 Apr 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523026; cv=none; b=O/QNJIjjC/cA9beSJkyO+kZjb3EfELHwRy9KbVhCCEE9wIQG6pLZLSVcS57mGu3fYYKP6ddn9yr91+nhqUVmejztRClxOFMvmqJaxCtMbnVGJ8if17ar7hajH9haIcYnY2b7wVavveBSYT/Js7rvgT+sIABR8NpOBPbqG5NfKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523026; c=relaxed/simple;
	bh=T07CYO6L0r6pmV66smEgTJRarzcfWbqMTR2vkiU3IuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fvhu3sYODeNp7gxk6KtK+BI0OGUiED9nKxGlehILM0hQraS69FfuW+dX7rdBQFkaQbNv0MD14F2mzkp8jfTFr8rm3VYoj1s8bfPguBXVnV90zTCipFSgevkN8TeW1vahlEg1HL0lbhtISVshncfzhhawMrCSP/bEH2W1Ge8XFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeHxDOrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B76DC4CEF7;
	Tue,  7 Apr 2026 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523026;
	bh=T07CYO6L0r6pmV66smEgTJRarzcfWbqMTR2vkiU3IuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BeHxDOrlT5hOpEAs/B2FEVdoNd9D4je+Akb1bxx7BnCmraQfvqGTinfQd0GF7PiXr
	 VbDEj2I0eX1yhPipQo/jb6ECfj0Lnz9Q8z2DpkKkNoBiiw+todQJF4h3Al3yUerb/2
	 kr7CSuw7AbgklHPrZMlgyLinOtyDVlTLxq8huqcptnI9+zCmAx3cd2PARZxTvGocFq
	 3R8OY1KTEHrTBbotXsh7pz0UFmaNY6bAAEpANSQBdFV1JkzLwQ5CUtoW7+9/Q+pb+e
	 x9jBpaysIMl0k5qqXpPc6dYATSgZYZF0UjoTO8AH0XNVLrlCwAVYa8y1BLi8iPUK02
	 ui2EJHdD2nPDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C163809A28;
	Tue,  7 Apr 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: py: color the basics in the
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552300479.3319505.1157746963786214137.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 00:50:04 +0000
References: <20260402215444.1589893-1-kuba@kernel.org>
In-Reply-To: <20260402215444.1589893-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 willemb@google.com, joe@dama.to, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275798-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E6413A883D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 14:54:44 -0700 you wrote:
> Sometimes it's hard to spot the ok / not ok lines in the output.
> This is especially true for the GRO tests which retries a lot
> so there's a wall of non-fatal output printed.
> 
> Try to color the crucial lines green / red / yellow when running
> in a terminal.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: py: color the basics in the output
    https://git.kernel.org/netdev/net-next/c/3b45559f6c0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



