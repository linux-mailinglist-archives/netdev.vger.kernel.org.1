Return-Path: <netdev+bounces-286039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGN6GC1r/mkgqgAAu9opvQ
	(envelope-from <netdev+bounces-286039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:01:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA244FC8D2
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD198301BA74
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2973A3E87;
	Fri,  8 May 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOl4aPzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1B233721;
	Fri,  8 May 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281257; cv=none; b=bEecvgTN5YL54mSTkyGkARF37jj9vaIAdhtLnYlT9lMw+J5yF8bBMxq6ykb6e+bgUUDG135AE5yN7DAZUBALxjegkNalt8kRBJJwKZjeJqsq2qHXifq4xzFYVbXq+gfzRSYhMQ6eCBBXqUT0BckHl0vE+Z5thUAaynrGSi9Pjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281257; c=relaxed/simple;
	bh=kJMo2ETW+x+xVVES1o38BBC0AgbIcPOjAhsLm1P92AM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=heLCGslWF65UCW2Qi6+qLTOmBUSVTQhW1IRAIjhvRXx1z4U8AEsey6EeCAxxvmeKvbyVzlSoVhDpNfdN5WBbIl3EykoIvWCk/a3m5g0hkjrFS8X/4v/WBUSL6YNa5EFSnfg7fZZ8wI8zAHEhhfgvnfzflJuJHSDbbBZxjC7ge6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOl4aPzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C065C2BCB0;
	Fri,  8 May 2026 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281257;
	bh=kJMo2ETW+x+xVVES1o38BBC0AgbIcPOjAhsLm1P92AM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rOl4aPzgy3vgha3CyU/7WAKopPN89FuV64C4ylF6CX5RclQLKwXdGP5WbiMgrgMvy
	 +tqo8RxVgECSDXE8axpzzdYPQwVL951ZrsewMjNQBrwfGcFJ9b1kwWpmL5sjc1xdF5
	 ELkry0fPvOv5SIi/zwAKF55xsEFF3V0lYx69wpEXMRBjnN5/aDYJZ8wmUZOfdf2Jb5
	 MnRt4+hGoCmP1IL/KE6msZusnMj0eLhC3kvu0j3mqlLwNaZMS0vepkPCdURaVj/r/t
	 qD+OoQT+fJW+DJjLsiepsScL2jDVXu18H3E/KnJH6jzqCs4Piv7k65Eeqb97v9oMH+
	 UzAWxIGO9BP9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3938119DB;
	Fri,  8 May 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: shaper: Reject reparenting of existing nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828120555.883980.3474169363086619803.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:00:05 +0000
References: <20260506233745.111895-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260506233745.111895-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@gmail.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kees@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, p@1g4.org, pabeni@redhat.com, jiri@resnulli.us
X-Rspamd-Queue-Id: CCA244FC8D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286039-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,1g4.org,redhat.com,resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[handle.id:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:37:45 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> When an existing node-scope shaper is moved to a different parent
> via the group operation, the framework fails to update the leaves
> count on both the old and new parent shapers. Only newly created
> nodes (handle.id == NET_SHAPER_ID_UNSPEC) trigger the parent
> leaves increment at line 1039.
> 
> [...]

Here is the summary with links:
  - [net,V2] net: shaper: Reject reparenting of existing nodes
    https://git.kernel.org/netdev/net/c/a77d5a069d95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



