Return-Path: <netdev+bounces-284169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K4JGaJU+WnF7wIAu9opvQ
	(envelope-from <netdev+bounces-284169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC84C5F97
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CDE5304DEA0
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89FC39B952;
	Tue,  5 May 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr3oL4+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9139B48A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947679; cv=none; b=NPd/sxx86v9SDEkj6BQ+Cx/yt8ZyHtGPfsMK2sWeiALkNJmnDL5KakGDACQB/5S0mr7kuAmjo3HF9fV5p6vYe0uMZ9x9dpIzK1DpKjbj8SWb6SMqDEgDN/NYis74iVYgaxCVZL4Cu7dFZVFBnDlpDG7Wqz2rpXH12QYslQ8+3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947679; c=relaxed/simple;
	bh=lG1TqnXXVZGpTnXq0OKnmLyaLOrCj5AlUinQexugCrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRegrnu2XDKPRKT1VUY1+HM5Lrh0Cc6b9g9QLTYN5BJwWuXvI1q47dmvyR4qzyMuHzXah1YHgaPh0f0U1BJra+soS73mKt6rd5m9ckEbEzQ5azhOMo6/o2mShaaAnz5GJVf7VfPYMG8sc/k5iHPGywjs9ibKsAIkMZogV+W4gfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr3oL4+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D0C2BCB8;
	Tue,  5 May 2026 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947679;
	bh=lG1TqnXXVZGpTnXq0OKnmLyaLOrCj5AlUinQexugCrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xr3oL4+obKlnJmDIEWdq3+bn/4dZUXQ60EZ+u4Z+DBFxys9hDd7QNbWafJIhDpAbP
	 KhQbIdPmrrklyKl1Q+yHXNS9aREm2LF2i5Kp+uCPQe8opJMUY+LLHxVK5o0hi8GDEW
	 AOS02EgjWh9KOMoJCrzUrGMPAxfIruVgCI+pcll81elnjD5/dFl0NlFz2I6/tYjDpX
	 9zbB0uWTKKmZhYoH8PyCjXQSeJRK2ZmgZTvh3in9o4C0lh6f5xEMIVKAhfUrEJ1fB/
	 qkbo/JSikEKNagswBsGn7pMg1WC70AuWIBhSntfr4FZnI8/kz+wtwu3tSqRPq82tGC
	 YGgeu9cNuRkiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC4439301A2;
	Tue,  5 May 2026 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: add qstats_cpu_drop_inc() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794762979.1391894.15675959486729697037.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:29 +0000
References: <20260501135916.2566766-1-edumazet@google.com>
In-Reply-To: <20260501135916.2566766-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: BFCC84C5F97
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284169-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 13:59:16 +0000 you wrote:
> 1) Using this_cpu_inc() is better than going through this_cpu_ptr():
> 
> - Single instruction on x86.
> - Store tearing prevention.
> 
> 2) Change tcf_action_update_stats() to use this_cpu_add().
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: add qstats_cpu_drop_inc() helper
    https://git.kernel.org/netdev/net-next/c/3f3aa77ff1c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



