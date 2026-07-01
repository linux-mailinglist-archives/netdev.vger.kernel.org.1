Return-Path: <netdev+bounces-303441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 29KmIWp5RGqxvQoAu9opvQ
	(envelope-from <netdev+bounces-303441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC16E93C7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:20:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b9oyV9dE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303441-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303441-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E47303428F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496A312807;
	Wed,  1 Jul 2026 02:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5B25EF9C;
	Wed,  1 Jul 2026 02:20:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872424; cv=none; b=RnSx0oPVfLXyuI+OBgk3KKkbgUaFYCPBM3vEYXuNMjtwAccWRUjTVQvt7GkHtIWKMYrxngnvwQsE6vwFYtEhJeqVZsqAu/ZhtQUUA6WoXwPPvkNXUsQStoc9cq7NnUO7THX0ZulamQZNYE/1TuQ0qNc8JlGYm0ejCIPWfYa3n9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872424; c=relaxed/simple;
	bh=xGSX9gBVi2XTYHaW6mEUiwO19Akj4UKXXl+oPWzoa1E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tyq+l0OgzqM70XR9R8wExIAtrJI8C0BMUVZXwRBdhkLNg6W6GO1Ys6UWJYS/7khSorNkj27D/IoVKh2+WgVZoTjz3TyHpAs8d+IitIYXcHoTZ0lNxOuwn8/jFomVN7FuuxYb4ZCUlFWHJDta2znWrVD2Xz6NIvKCcWq4iSNL99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9oyV9dE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CCF1F000E9;
	Wed,  1 Jul 2026 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872422;
	bh=jCh0DOxNysvsMfVuj3WxslcZg95qRGWc2fGK+ArQhYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b9oyV9dEO6pjoxPRU9ljhf9k98/dDjcIEfKCcURslzvNx1HrrhA7neKhYcUP9Pag4
	 N3wT5iU/tB5/H3L5+I0U7tMgmgf566nsKqxzwTRoptjn2M6Nd0eFdJg7AVkBM+6KhA
	 WzhNp/cTI3LT5K7cFljkLCdItG7Y/aKbC5FbKANtyPAY4wXue187zBkgZd6o55xH0P
	 jc/KUNbEnq8e2v55SPYi1ag9UfuFm153xq1+/TfKOpuHFrO4WSJ1LrvKbrvipm0IMe
	 yXXOFM3/NYIS6M07VJtVMRVCzBgH4lX0RadMHXbwxZcXXgCiC6DnUwIhtd1aW8zeWl
	 UwMezcHIMdABQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A08393A967;
	Wed,  1 Jul 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_bpf: use rcu_dereference_bh() to read
 the
 filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178287240614.382687.14703752116363497366.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 02:20:06 +0000
References: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303441-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:horms@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5DC16E93C7

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 15:41:06 +0000 you wrote:
> tcf_bpf_act() can run from the tc egress path, which holds only
> rcu_read_lock_bh(), but reads prog->filter with rcu_dereference() and
> trips lockdep:
> 
>   WARNING: suspicious RCU usage
>   net/sched/act_bpf.c:47 suspicious rcu_dereference_check() usage!
>   1 lock held by syz.2.1588/12756:
>    #0: (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit net/core/dev.c:4792
>    tcf_bpf_act+0x6ae/0x940 net/sched/act_bpf.c:47
>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>    sch_handle_egress net/core/dev.c:4545 [inline]
>    __dev_queue_xmit+0x2185/0x2c00 net/core/dev.c:4808
>    packet_sendmsg+0x3dfa/0x5120 net/packet/af_packet.c:3114
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_bpf: use rcu_dereference_bh() to read the filter
    https://git.kernel.org/netdev/net/c/adc49c7ba690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



