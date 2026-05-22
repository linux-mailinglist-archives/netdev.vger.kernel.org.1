Return-Path: <netdev+bounces-290908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO3SDFueEGpuawYAu9opvQ
	(envelope-from <netdev+bounces-290908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB95B8F16
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CD33300F5DD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E618371CF4;
	Fri, 22 May 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLT96LS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059336C9EB;
	Fri, 22 May 2026 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474008; cv=none; b=OXamOwqHuh/foF+AGirtggIoo9ckDuI/bbgv+Tqa/keitl5/GniwZIte5XfWVTptXL5aW2AeJRBzqyDFBgP0kdPrjkHP+A/6hTvfCnzGEY24LThO8BulExNa4QbKpGxNQX6samacVcY4GanuF/BOfuepXgf0SY7+9GhPo3LhwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474008; c=relaxed/simple;
	bh=Wia0luWf8lpPKpWKgApQdNbbSECHI5yA4kF9fmcUoXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EqF3nPBY+A171NDEBO4yUFsn6yIluVwH3krC7l1OCvOJUJbEJYFhg8ZYrAoPGYHteEv/pBSTnJdhQXiFrjyrJDvqa2tdLO45Gtgi39PkrkQpdg3LPUOuV9wEyi99YqK2prwMsRuMPEg3OBtHeRTsr9zuSltlVovxBNtGR1j9HBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLT96LS3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E481F000E9;
	Fri, 22 May 2026 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779474006;
	bh=wWS5Y14cKK5L43TTlHFJl3WzEhu5crUMKgKU7tsI+nQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LLT96LS3E7RJTEOgLZAX2V7SXejPhARrnEaHk+21hBfZPR78G3O4GRqTzAnIpA/us
	 o5HnW1WLwDl4nHXmsmUYGoY90FENPCt5bDkVs6LnuR1DOYsNjKlyRWxRdaEfOZxqn6
	 lYFm2VpzM+SGG/8TScjxMjDdVgORNvIQvB5yHjPagDnxBfGvtTvosgFdh8aKUA7xig
	 Q5sPrB4RxYTPx2EjLxv8TMZ6gXzzW51kPjM9MqJJ99tThzXdJWa9OkJJHVMpdthiPx
	 sHan5OtplOJ2XneWobBifsfP5Y01eU23Set3NwjwxM3eEV/AaRs9fYTFdHN+soE3pp
	 lxXLmWaY4vL+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984A3930FB9;
	Fri, 22 May 2026 18:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] net: convert
 atm/xdp/af_iucv/l2tp_ppp/rxrpc/tipc to getsockopt_iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947401569.1320830.4340885034348634311.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 18:20:15 +0000
References: <20260520-getsock_four-v3-0-b8c0b16b7780@debian.org>
In-Reply-To: <20260520-getsock_four-v3-0-b8c0b16b7780@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jmaloy@redhat.com, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, jchapman@katalix.com, dhowells@redhat.com,
 marc.dionne@auristor.com, david+nfc@ixit.cz, sameo@linux.intel.com,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290908-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C7FB95B8F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 09:53:45 -0700 you wrote:
> This series continues the conversion of the remaining proto_ops getsockopt
> callbacks to the new getsockopt_iter callback introduced in commit 67fab22a7adc
> ("net: add getsockopt_iter callback to proto_ops").
> 
> The new callback takes a sockopt_t — a type-safe wrapper around iov_iter
> plus an optlen field — instead of raw __user pointers. This:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] af_iucv: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/347fdd4df85f
  - [net-next,v3,2/6] atm: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/4177767daf83
  - [net-next,v3,3/6] xdp: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/3c6776b5b912
  - [net-next,v3,4/6] l2tp: ppp: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/f83e9cd64593
  - [net-next,v3,5/6] rxrpc: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/4b94edae0b6c
  - [net-next,v3,6/6] tipc: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/c56dbb469fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



