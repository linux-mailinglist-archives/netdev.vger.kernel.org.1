Return-Path: <netdev+bounces-283528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFxZIxCx9mmgXgIAu9opvQ
	(envelope-from <netdev+bounces-283528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 214584B420D
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FFA3007CAE
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BBF38947E;
	Sun,  3 May 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMW+ssfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D421CC4F;
	Sun,  3 May 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774859; cv=none; b=JwdoJkCmGDY5R4Hg8ojBW73vS4WId7Gl08nhetFQIL8uYG3GuuetBxDq66yqjjXY7PfCmpi8hlINtJN2bpdvNFZRIIhvQBHixqf1q0UCzSeGhZYWO4Sm1YW/mXqUoA6VcJYhGIxXegrfWXucohRYaLqBc14v86btVTRVEP4YipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774859; c=relaxed/simple;
	bh=EMyqomnyxRApDEITdtBFpV/A2iTOiaKaUchQkA05FTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PL311TKyI8i85uDbBetfFpPwgwuesGa93OnbCuChYUBMokvY1PHiBTn4o5ErJu00GRUyJOlsnBxdDz5xDyzaGwnCVxkBXl1q3HaYasTB1xIT/HdKL0AzZN3fV430uORjv17wUy38FyN+3PImDR5cZEUJLTR3EfH6Mq9zqH1YxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMW+ssfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC94C19425;
	Sun,  3 May 2026 02:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774858;
	bh=EMyqomnyxRApDEITdtBFpV/A2iTOiaKaUchQkA05FTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IMW+ssfYStNYF88x7lj14xgU0XUkheaiznsUmV1iJ/xiKeWAYsdkjw3t3j4TU+i45
	 CYU2VIRXVI6frORf8lnORIKV8oih4q/LFpvqowh7C7/LfKdX469f7vf85OZ7prxmbY
	 jHUV+6Chbj5PtUtO5x9b2m6c8YT153+AnRmMUt7zIXT7tAyHEfQ/IpuYXNp1MNmw5s
	 hZdMyS7iBUHvefUpOWMrklHZby6aMSOsIqtT83603zRjkW73xIYx9WvcPnS+dlTlfx
	 ilbMv8ZHNyzltrDHKzXs7XFGtjzrfAu7z4n3y2Brsqle5poz+PBDm5nKeOHr30LMEq
	 CkwR5hkiO7QrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ECA380CFEC;
	Sun,  3 May 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] net: tls: fix a few random bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177777481080.3993534.13171841772484372879.git-patchwork-notify@kernel.org>
Date: Sun, 03 May 2026 02:20:10 +0000
References: <20260429222944.2139041-1-kuba@kernel.org>
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 214584B420D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283528-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 15:29:37 -0700 you wrote:
> Fix a few random bugs, from external reports and my local scan
> with various AI tools. Mostly corner cases in code which I don't
> think TLS maintainers would consider "battle tested".
> 
> Jakub Kicinski (7):
>   net: tls: fix silent data drop under pipe back-pressure
>   selftests: tls: add test for data loss on small pipe
>   net: tls: fix page pin leak on sendpage_ok() failure
>   net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg
>     ring
>   selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path
>   net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf
>     verdict
>   selftests: bpf: cover tls_sw_sendmsg UAF after bpf_exec_tx_verdict
>     split
> 
> [...]

Here is the summary with links:
  - [net,1/7] net: tls: fix silent data drop under pipe back-pressure
    https://git.kernel.org/netdev/net/c/7e7be31bfdb0
  - [net,2/7] selftests: tls: add test for data loss on small pipe
    https://git.kernel.org/netdev/net/c/bd3a4795d574
  - [net,3/7] net: tls: fix page pin leak on sendpage_ok() failure
    (no matching commit)
  - [net,4/7] net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
    (no matching commit)
  - [net,5/7] selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path
    (no matching commit)
  - [net,6/7] net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict
    (no matching commit)
  - [net,7/7] selftests: bpf: cover tls_sw_sendmsg UAF after bpf_exec_tx_verdict split
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



