Return-Path: <netdev+bounces-277833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJy/Eb/G22lHGgkAu9opvQ
	(envelope-from <netdev+bounces-277833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8353E4BF3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D6BB301DC0D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441530E0FB;
	Sun, 12 Apr 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0LYfGpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F6285050
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010852; cv=none; b=UnWQKUfjEyuM1GhdMnCg9R0nZA8QzD/7uhZYfBbGkQ81+rY0QbNRcBEwZyCWAkdZhlGkimec0FBmW7YG9aMnmFA3YC8gs42MuPE9R1GA9awcF0zqF8B7NeY7NmNr5SSPhN2tbncUMUVEV5VKYWrxS9JiAv7UCq3lvV6yGe3ugc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010852; c=relaxed/simple;
	bh=HNnTQTtIcYaidpSEr2mmZn5t1CC5g+gTbdhjPZpYCL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LY5+J5UWDojl7ZMBN/qcGpYqWrUGYCk1N3+2uo/is/TNb2dThcmESNtSj/tNmH7y/SLBQXK82D5rTSzbXHmu6+Fp4nf4XwOC9XRRZgLGo4BxlRFNBuy5FQwY3oWjIIrvzLwQNzhcXv78gYmjkkgTcMsN6rTZ8y+HjOTHMeqHq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0LYfGpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B5C19424;
	Sun, 12 Apr 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010852;
	bh=HNnTQTtIcYaidpSEr2mmZn5t1CC5g+gTbdhjPZpYCL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z0LYfGpUu/NtYGSdrguRkCOpaEZzvX3k8r9vmXhcyJJwHHe4DnnAT/pyZ8jqZNyBN
	 PX+gE7MqwjkJ8ujlV+pU5oSlKEgQGuKPAVkZNoNvEctEHm7tqPDjgZ1/5Ao/TLoyVE
	 PFMn8LhHch0ccv5Ev/kGBccPzYRaEe+i4fifgOcJT155QJOOFJLHe4nkj+cDG1htsa
	 loEXqUeQv87AszHhB7Z95v6YmtkBsOqAWTKpiHSUjK1vjhJWXMLc/5/5v05tagyfZM
	 vem9aF143SSCAZLH7RWV6bFZ4VIje3zzURhzmv+CUH1S04BPXsy0quO6Js5pRZlPaB
	 MX4l2VBIZt4VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C2B3809A8B;
	Sun, 12 Apr 2026 16:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: return a drop_reason from tcp_add_backlog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082454.3330556.17773482752326322528.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:24 +0000
References: <20260409101147.1642967-1-edumazet@google.com>
In-Reply-To: <20260409101147.1642967-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277833-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF8353E4BF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 10:11:47 +0000 you wrote:
> Part of a stack canary removal from tcp_v{4,6}_rcv().
> 
> Return a drop_reason instead of a boolean, so that we no longer
> have to pass the address of a local variable.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-37 (-37)
> Function                                     old     new   delta
> tcp_v6_rcv                                  3133    3129      -4
> tcp_v4_rcv                                  3206    3202      -4
> tcp_add_backlog                             1281    1252     -29
> Total: Before=25567186, After=25567149, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: return a drop_reason from tcp_add_backlog()
    https://git.kernel.org/netdev/net-next/c/f5148298b0fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



