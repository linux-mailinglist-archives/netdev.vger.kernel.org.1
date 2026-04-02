Return-Path: <netdev+bounces-274547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJhVC/9vzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:32:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F84389C7E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD81430B462D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384F2F5A13;
	Thu,  2 Apr 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a19QlJI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812392F3621
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136028; cv=none; b=ks40mj9NsdaOmRcX8Whn7Jm0DVC83C/FD5XF5FuFDKQUiofLTjDbx6OkQjTzgsS/Ut76JzW6eJyW+Vj94QkMVBFeKyA7sXMQZfi9N2PEQmGod6wbvhLGx0mDjCbeg4KPpRiRUNNeYuav12V+eLFzRVADoo2TafVFFgzD/SFc2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136028; c=relaxed/simple;
	bh=ahdlY1NrYb5ezUOmeJT2DjPhXGhXzxsiCLyBQinzfjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt5OiJ2suTZDircNnSCFCSHapO+nTZ9ADowKYg7SYy/enSHpy0h9CJHZ4qnrQEZ6MeCx3w1b8M5se18wfob6r6Ve8R/13CGFWFGu1sxZwlfkCg0oGalExXx1jaU3qoyHY3boKjWnKZv/QFMRGsHzQJsUy4XULX2NMUmkKUf13Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a19QlJI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE66C19423;
	Thu,  2 Apr 2026 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775136028;
	bh=ahdlY1NrYb5ezUOmeJT2DjPhXGhXzxsiCLyBQinzfjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a19QlJI72k+l42psh9zlYWUAawwMFlwKU8zdOWQnEraUpOMJZkUrVfPPvS3YFF9Te
	 xDZudiSSqnSc3tlHz/A9HyLXFCIu+fRm/0XzDRnnUPSnX0RROZHKpTjl+kTAg0/lEh
	 UtV5ZZRsaDwmsu2HpNRX4Q8vuJVYWO7X3VXHiHJfsHwgEOgG4ROZdZ+kdwxTCAfgH6
	 KpRwHN8mOKjvVq21ZaE3U0vm14wHWZjX5SuReG+/4zc/sc10PtmVukIbz+kpqwZMvy
	 fEM+5KgKihCCA8G9FrkmzYpYS9x0ddCMX5uPnMSQAfuuiiOQTsZlkCy+/p8PA87nsR
	 jOuSn/gifFFqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EC03809A05;
	Thu,  2 Apr 2026 13:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/3] net/sched: cls_fw: fix NULL pointer
 dereference on
 shared blocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177513601079.26443.3565261619233773362.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 13:20:10 +0000
References: <20260331050217.504278-1-xmei5@asu.edu>
In-Reply-To: <20260331050217.504278-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 shuah@kernel.org, bestswngs@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274547-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8F84389C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Mar 2026 22:02:15 -0700 you wrote:
> The old-method path in fw_classify() calls tcf_block_q() and
> dereferences q->handle.  Shared blocks leave block->q NULL, causing a
> NULL deref when an empty cls_fw filter is attached to a shared block
> and a packet with a nonzero major skb mark is classified.
> 
> Reject the configuration in fw_change() when the old method (no
> TCA_OPTIONS) is used on a shared block, since fw_classify()'s
> old-method path needs block->q which is NULL for shared blocks.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
    https://git.kernel.org/netdev/net/c/faeea8bbf6e9
  - [net,v3,2/3] net/sched: cls_flow: fix NULL pointer dereference on shared blocks
    https://git.kernel.org/netdev/net/c/1a280dd4bd1d
  - [net,v3,3/3] selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks
    https://git.kernel.org/netdev/net/c/70f73562d278

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



