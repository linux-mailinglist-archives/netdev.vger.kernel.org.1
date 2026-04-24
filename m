Return-Path: <netdev+bounces-280930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrzMUHm6mmjFQAAu9opvQ
	(envelope-from <netdev+bounces-280930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330124597FA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C263007E02
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E502D8DDF;
	Fri, 24 Apr 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh3OoQWm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336A2E3FE;
	Fri, 24 Apr 2026 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002047; cv=none; b=KLyKjs7L6maYicdEQnOU4md+dk3SHIdLjo1f1jn7VOS/NDkKMaGghidMEcCsNu2C23HR9XLWhTQa4Y5kf9a0Zv8e/z5WGomEzC38bjhwWQEfJ2Y0GVTiitZ0XeQxqiUSOn8fBLTQjAbbyusRRC0Hz9NkYuhMZNPoYke7mX67nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002047; c=relaxed/simple;
	bh=0wxYqtxE3UIMzurHgMJXcwbbShaJ/8VU0s3pGn5hVCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHtLzBbgZMJRmNxHcVVMXXbCmOUKoIFMBDoXgYtQx+MzwuH4O+SkzhIVOf57TGw1E8XeQ8w/pDGzxkEZVIfwAD67b62i88iQc9RUyHuF8jqfk5hGqi/ikbPKqK3JjUqw6JrRd7I/2fCQR+6hEVlttu3NLyGLLnZzTa+q47UOHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh3OoQWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90854C19425;
	Fri, 24 Apr 2026 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777002046;
	bh=0wxYqtxE3UIMzurHgMJXcwbbShaJ/8VU0s3pGn5hVCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fh3OoQWmc8PEdQIODW8CjTDGV+ngVllfAeXgRC4UemxvxpTvMBbcS/5JkdKxZFwYZ
	 LoF3dsanzqHLgw3AErCg+cJSDwCbn1goImbOcytfEoIc4BJS9YgpP4HyO4s2HjloE1
	 BwTJcKe2AWPDLjGu+SM/V5vwD8aKLy7sLFV/COdpirdjv9sEnrJeDE+cs6Z/fl7meQ
	 m0nYHkonS+vj+clTmuP0s30SOmPktk/49PF48HGuSlhClrcndi5j1E1JOf9hbdiHb0
	 +gxu9Ya3/KnJRPpzurkchvrpmvZmstPXQ72rHlm3b3hjNNiaFUYdP+Cgc/PxMjq3CZ
	 M5PCT/8gu7oeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FC63811955;
	Fri, 24 Apr 2026 03:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_skb_fib_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177700200756.900079.314534091561331618.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 03:40:07 +0000
References: <20260423183831.1325480-2-bestswngs@gmail.com>
In-Reply-To: <20260423183831.1325480-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, john.fastabend@gmail.com, sdf@fomichev.me,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 hawk@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, xmei5@asu.edu,
 paul.chaignon@gmail.com
X-Rspamd-Queue-Id: 330124597FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280930-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,fomichev.me,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 23 Apr 2026 11:38:32 -0700 you wrote:
> When tot_len is not provided by the user, bpf_skb_fib_lookup()
> resolves the FIB result's output device via dev_get_by_index_rcu()
> to check skb forwardability and fill in mtu_result. The returned
> pointer is dereferenced without a NULL check. If the device is
> concurrently unregistered, dev_get_by_index_rcu() returns NULL and
> is_skb_forwardable() crashes at dev->flags:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()
    https://git.kernel.org/bpf/bpf/c/1081de1accb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



