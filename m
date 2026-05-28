Return-Path: <netdev+bounces-292652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENE8FLQcGGq+dQgAu9opvQ
	(envelope-from <netdev+bounces-292652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:45:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0495F0D19
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1B4302E436
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428939A81E;
	Thu, 28 May 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+chlehd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0035B653
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964820; cv=none; b=n9KYtyQ3kEtDZJ/xYK1vIii7W4klo6YUEEpEszuG+xpq8lROZUCg88DRxjVuFPbCNBya4sBHq4An7wkzN9/tYqXylGB+jXbDQYi/iNh8milVBfL2uVRkIjuOPrTxf8KPvzRpka/nHsN/przARlTsFA/5iD1F06RGPlLWVfhV9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964820; c=relaxed/simple;
	bh=c3ZIKoFkG+hFqFm1f9e4EYLnRNKBe+psIFbi/SeCnE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jWe26gb+XdzZLZiGJZ/R3b3cQfNs7NC+KxmDoXxb/QgaUH2p9OhbKbXqoKY0Uz85LeA44hx8ianBceQbj3Mo2dtw25DsEDHRrm5tA4cHHDoOazhw6r91UEDWoMyVct1eTYsK5lQWQcEbVAccmUiLWJSUCT8AneT+MHxWFJqDABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+chlehd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD5F1F000E9;
	Thu, 28 May 2026 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779964817;
	bh=Bcc7J5ZtDBuNeEXCUteFW0DLh6y+iZk9h7e/iE8PjVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h+chlehdG52kSA+m7FcIhw1siwPUGuDEZGxHIsA+351vLPS9KhnwjwlBn+khrECmB
	 dyJOqmxnWfKheuhb2+ut8GNbH74cGq4mWsC6IYL3gslT5rYzZI7c0jcczaKI2Go19T
	 X7MCyhA2KVd3FqB+gznggx5HK/bUhmWtY63bjz2BooADXKR3jGm0GK1iuaQ5GrEl0k
	 mdRyqz/6sV+j/cjPPWUaONNEoY0ZkaQffcYUmxdVp1YLh9OxFpWPuRMke2tuCc+f0J
	 KK8E4oORX9jDFjlYkTaM+AkNSJaVS0cck2DqgP99uFv5Eix8iUarC5aXdBX5Y0WJWC
	 n5YoxaDlM1URg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E193811957;
	Thu, 28 May 2026 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/9] net/sched: Fix packet loops in mirred and
 netem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177996482215.867136.1413556139793444593.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 10:40:22 +0000
References: <20260525122556.973584-1-jhs@mojatatu.com>
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 stephen@networkplumber.org, will@willsroot.io, hxzene@gmail.com,
 victor@mojatatu.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292652-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF0495F0D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 May 2026 08:25:47 -0400 you wrote:
> This patchset adds a 2-bit per-skb tc_depth counter that travels with
> the packet. The existing per-CPU mirred nest tracking loses state
> when a packet is deferred through the backlog or moves between CPUs
> via XPS/RPS. A per-skb field covers both cases.
> 
> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
> which broke legitimate multi-netem configurations.
> Patch 4 uses tc_depth to stop netem duplicate recursion.
> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
> Patch 6 fixes the infinite loop in the mirred egress blockcast case.
> Patch 7 fixes drop stats in early return error scenarios in tcf_mirred_act
> for redirect (caught by Sashiko [1]).
> Patches 8-9 add mirred and netem test cases.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/9] net: Introduce skb tc depth field to track packet loops
    https://git.kernel.org/netdev/net/c/98b34f3e8c34
  - [net,v6,2/9] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
    https://git.kernel.org/netdev/net/c/eda0b7f203bb
  - [net,v6,3/9] Revert "selftests/tc-testing: Add tests for restrictions on netem duplication"
    https://git.kernel.org/netdev/net/c/b213a4c6074f
  - [net,v6,4/9] net/sched: fix packet loop on netem when duplicate is on
    https://git.kernel.org/netdev/net/c/9552b11e3eda
  - [net,v6,5/9] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
    https://git.kernel.org/netdev/net/c/db875221ab08
  - [net,v6,6/9] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
    https://git.kernel.org/netdev/net/c/a005fa5d7502
  - [net,v6,7/9] net/sched: act_mirred: Fix return code in early mirred redirect error paths
    https://git.kernel.org/netdev/net/c/e80ad525fc7e
  - [net,v6,8/9] selftests/tc-testing: Add mirred test cases exercising loops
    https://git.kernel.org/netdev/net/c/d38dc56a0225
  - [net,v6,9/9] selftests/tc-testing: Add netem test case exercising loops
    https://git.kernel.org/netdev/net/c/0f6e00aa5f65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



