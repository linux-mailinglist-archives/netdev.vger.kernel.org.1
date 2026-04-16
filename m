Return-Path: <netdev+bounces-278885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MorJZou4GnmdAAAu9opvQ
	(envelope-from <netdev+bounces-278885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C044094D0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC4130FF3C5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F21DD889;
	Thu, 16 Apr 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXqGhRxh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF31A6805;
	Thu, 16 Apr 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299446; cv=none; b=Cpud+2nHukp33Z84gJw1fSUBxEwMm1+BegtrBOnGMgtNM1YgbKkbnOHUnc2NNsxshb589/VI32d38rXPzyBo9Sqyr87zeIrz3d510CsKoW48AotqDuUgDVPOVACjOEb3IfaKVOL6M9aOdEBtYZO8qcrFYVpivTyUEIiEp8v4JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299446; c=relaxed/simple;
	bh=8hdB6viDEMIXDVmOzuuRHuVAjFMysD7iScx0KyZBz4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rB8/RiNsINatG8aVQ1ELwU7WX2UZ3R+ZHEsO7GX2AMfYBui35Kgewpls34YxinV5seQH8yfFrgkLLQhb2bjK4N47fCEwvLsOJActM0TVxEXEF+hZLjk9jpdBsF69dFAamJad28tP3OnwQieevsl8vDoRsgijTEHBQuhcMz4qXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXqGhRxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89E9C19424;
	Thu, 16 Apr 2026 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776299445;
	bh=8hdB6viDEMIXDVmOzuuRHuVAjFMysD7iScx0KyZBz4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IXqGhRxhTM5WD/LJvpHMQqA4sgum8mSVOrXSXxiSfXdrNhD50Pjb939jdVpJ74A5g
	 d9oERdEYIsQEntckzwwJ2soI7OPdosgwv7n3/4tIwLIBPSGd3GFz118YskPSjRE7wP
	 Oxb91Yzpmxz1uhBcepA5FGTh5ttSa+liL7S2eFEi3dupdjjzalSDsTMZdlI6UsKQ/6
	 nNbYbbNWLo+AX9wlU1qHDKlHofl9YEdpZwOkuFst36N97nGN95N7xjNbC354Y2/4B5
	 DF/3+MpuiTUyJexfGMYFaGs5T2tceq1MPvLHoUvdO/TuG6RRNdaDF8eexwQUD+gUOM
	 /r8JdYxO+51og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD24380A964;
	Thu, 16 Apr 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/5] bpf, sockmap: Fix af_unix null-ptr-deref in
 proto update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177629941504.2543974.17636062196868674829.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 00:30:15 +0000
References: 
 <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
In-Reply-To: 
 <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, edumazet@google.com,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org, yhs@fb.com,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 cong.wang@bytedance.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jiayuan.chen@linux.dev, yimingqian591@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278885-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 47C044094D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 14 Apr 2026 16:13:14 +0200 you wrote:
> Updating sockmap/sockhash using a unix sock races unix_stream_connect():
> when sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
> unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v4:
> - Circle back to v1 approach
> - More details in commit messages [Martin]
> - Make unix iter take the state lock [Kaniyuki]
> - Link to v3: https://lore.kernel.org/r/20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/5] bpf, sockmap: Annotate af_unix sock::sk_state data-races
    https://git.kernel.org/bpf/bpf/c/a25566084e39
  - [bpf,v4,2/5] bpf, sockmap: Fix af_unix iter deadlock
    https://git.kernel.org/bpf/bpf/c/4d328dd69538
  - [bpf,v4,3/5] selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
    https://git.kernel.org/bpf/bpf/c/997b8483d44c
  - [bpf,v4,4/5] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
    https://git.kernel.org/bpf/bpf/c/dca38b7734d2
  - [bpf,v4,5/5] bpf, sockmap: Take state lock for af_unix iter
    https://git.kernel.org/bpf/bpf/c/64c2f93fc325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



