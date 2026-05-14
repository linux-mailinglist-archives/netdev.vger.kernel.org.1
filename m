Return-Path: <netdev+bounces-287763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEBJJ9EeBWopSwIAu9opvQ
	(envelope-from <netdev+bounces-287763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:01:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0553C80B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D1583019103
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B88232395;
	Thu, 14 May 2026 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4CwoOv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27651531C8
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720461; cv=none; b=f/7OcpiG47j0hOdGznyRbZBA7m6ao5k78tshVqYGjsxnoKORJJlaNQIWxo9mGNqiZluR5zGUW4m43/c2StN+pTqNgn3EAXvfGHEFK6gxk+k9ZdPWgGVj6tihS+bUOedJfrDiVSKimGR1jCy6NUCYS91x57+OK9/ESUNleNyT2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720461; c=relaxed/simple;
	bh=RVgJqKZrccWNNwd54MTood0Mg9KBZcJ2KyxNiwNlyso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQ9tx2EPEbyPW8owc2Ct8nIEgMQOeyW90rw6EMfwQX+6MobD+XnDXZXvMFRVrInw4ZSwj2yB6DtGVdsdMu/eEeHpFd27s/Ka/pB56q4/hzG4YzpkdO9aZkvYrlFR2jtuReF9NvW0sYD0wQ8GBBpEoe1F+KEuV98otsRF9w2mWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4CwoOv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF6C19425;
	Thu, 14 May 2026 01:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720461;
	bh=RVgJqKZrccWNNwd54MTood0Mg9KBZcJ2KyxNiwNlyso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V4CwoOv/REhkP6/nyNrKo3aIyqGJzStTAfo4BioK4RTm6cwjBn5B0Lupv5Sh8lwSk
	 qiCBbKzVeqU5zoQFo97UtzBbbp7tSbayHRK4Naor4Sv+HuRPm74Za5FSdTaYptaFnB
	 pKe0lGTXGD4jm0xPEC+yU0uyxQ+zx6Et558jogaMJI+RDe57Hw5tzR8EmrySprDHe1
	 ASsjkrNPCfkQ223diQAh7+BkNkP9KDJcQQVxVClELAJX1vpHWil15X0D83VL47xaGO
	 m+efCf3geFgECXPS+hQhmks/jnmENICDJE9mzWqr2baQWua3XAr//sYJkNsh6YDZCt
	 0KYtPhpJHmbdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E48393088E;
	Thu, 14 May 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net/sched: sch_cbs: Call qdisc_reset for child
 qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872040656.3902227.15382281185669127478.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:00:06 +0000
References: <20260511183058.422998-1-jhs@mojatatu.com>
In-Reply-To: <20260511183058.422998-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, vinicius.gomes@intel.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com, pctammela@mojatatu.com,
 graypanda.inzag@gmail.com
X-Rspamd-Queue-Id: 3CE0553C80B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287763-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 14:30:57 -0400 you wrote:
> During a reset, CBS is not calling reset on its child qdisc, which
> might cause qlen/backlog accounting issues. For example, if we have CBS
> with a QFQ parent and a netem child with delay, we can create a scenario
> where the parent's qlen underflows. QFQ, specifically, uses qlen to
> check whether it should deference a pointer, so this scenario may cause
> a null-ptr deref in QFQ:
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: sch_cbs: Call qdisc_reset for child qdisc
    https://git.kernel.org/netdev/net/c/320fb29ea23c
  - [net,v2,2/2] selftests/tc-testing: Add QFQ/CBS qlen underflow test
    https://git.kernel.org/netdev/net/c/59afae20080a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



