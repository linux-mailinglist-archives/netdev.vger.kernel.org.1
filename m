Return-Path: <netdev+bounces-259211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCP3OjJdlWmsPgIAu9opvQ
	(envelope-from <netdev+bounces-259211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:33:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55155153712
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0D64301D941
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D62FABE1;
	Wed, 18 Feb 2026 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFAmnbOW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA18926461F;
	Wed, 18 Feb 2026 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396397; cv=none; b=M8AxPHvntxgW2FpU2Wrlfis2C6Ql6tHBP2FQEA391/qBkzR2lH9ztLFtt0ZN2i635AxdDsV2psKUtT1VCpdxbH56Phpk8bU+pY9Ds2E6rrf7MyLgbPFHXHnnIpMaW9k6oQOMd0zdfeMKZDoNLXTXysfn51t+0qPaw3Qn6dSNess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396397; c=relaxed/simple;
	bh=xlq/orPrqkjTO0YNNrdAfmcEntu7UhnfrYHyILgAIWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VKt3sZLpsxalPcJ5iq4ELlh0Na129rL6YykQgwPYZ0QARrg8pQfh74qSzxoJWPmvA8zOPZnEaWnlAod72zq+VnoiJruZsfK8TR+pRQnLAirXRaWqe4ju8qPhQekl8E/uGgS3zgF8LL6Zw4yzTDxKcjynsvK0aaCR8qJnTkb3EW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFAmnbOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A54EC19421;
	Wed, 18 Feb 2026 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771396397;
	bh=xlq/orPrqkjTO0YNNrdAfmcEntu7UhnfrYHyILgAIWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZFAmnbOWLZMMgx7JkB2LLkkaf3U2yx3L5uKLKH9g58+COilokSZxj4wpOHZ8umEqm
	 0cBN0GTFFAywodjg0OMhmjr9IDrSRrYW/KKVBOu78ossK+mupQ/W158DmOh+W9yyWa
	 n7TUiPXj/Hspf2Vt2WvXrOPkmZivL4CaxXo1LM74Miixyr5w925krGfzJXOb1a54k7
	 hpCW+LW8SjEHYN5rbtpsv59aipQhZ8nkeDD9g9oB1qPJ2vghlSK1BBRdqCvyV6zWpG
	 kUW0dVCDUUtoAXW+s5+VSsqY2/+NFvR+Nvj7VnEJzINqzvlN3/hrHYW2n/SL9bAgTm
	 GMlgaU6cygFWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0473806667;
	Wed, 18 Feb 2026 06:33:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Add validation for MTU changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177139638883.824640.16921608412951781877.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 06:33:08 +0000
References: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259211-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,kernel.org,google.com,redhat.com,lunn.ch,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55155153712
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 14 Feb 2026 09:19:49 -0800 you wrote:
> Increasing the MTU beyond the HDS threshold causes the hardware to
> fragment packets across multiple buffers. If a single-buffer XDP program
> is attached, the driver will drop all multi-frag frames. While we can't
> prevent a remote sender from sending non-TCP packets larger than the MTU,
> this will prevent users from inadvertently breaking new TCP streams.
> 
> Traditionally, drivers supported XDP with MTU less than 4Kb
> (packet per page). Fbnic currently prevents attaching XDP when MTU is too high.
> But it does not prevent increasing MTU after XDP is attached.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Add validation for MTU changes
    https://git.kernel.org/netdev/net/c/ccd8e87748ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



