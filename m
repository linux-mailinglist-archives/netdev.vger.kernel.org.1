Return-Path: <netdev+bounces-288507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIUiLcmnB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFA5593D7
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4189D30180B7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774635E1DF;
	Fri, 15 May 2026 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8vL9k2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE6405C51;
	Fri, 15 May 2026 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886592; cv=none; b=Q0ai0Dgv5mBwJm/wvuOgrWPZhgsoyN8ZrM0GorfgmD1yQdYZgutorkH2gsuUh3ypTBYfeAYqE/nlO/byA1vTxFccSfzOoMwtqF5bSv6nH2S57nlekpPi08HZKDCnWIhpnh8ipgZ85xlb0jAbOAKhrQcgtsCEl5Ipt/jlFVuk+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886592; c=relaxed/simple;
	bh=m4is0BLM8eYxPLKf1Cs1OpVy8cGqdsYS6WsUKHT+uUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jibcenvvIxW+czfho+ZPmCfyQLHiJzxmjRc9DI6UM8xGYFAhENtHdcBteWUN8qyG1f5RuD39BNvmDPNrUmaFVehv3e/HnSw0yxmFvrFczo3DxKfCVX1p+g+ogxLNxzaWgoZm4AkMELNuf7ITQ5LqgOLTGv2hFRvffHUDJmzmAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8vL9k2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B796C2BCB0;
	Fri, 15 May 2026 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778886591;
	bh=m4is0BLM8eYxPLKf1Cs1OpVy8cGqdsYS6WsUKHT+uUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8vL9k2op4dskr+5qUvyYVPMfR9JHJvHm3mAGcaEeTZhd7sKH2W8VEEHNuXF4OnHw
	 hOKskpLLcwj1X5WsQcrOiaJqMlOeZIgX+geG/DhLluydFXYcbpSQC8xpN91AH+1tRk
	 j8rzypcNa2WXRlwUdc4sL2T7cqzBysUYMq5SxNjynsiNvXjOeanO9zKrufLt2J/d+e
	 F3QIra9dqrLhbaBsnBnoQpXditKNLt8RlduZxQPksWw32CQCVk80Sn9GnD6Q6VudIR
	 6mlpWbJoHOyJhE1eiq2iwj8CiQCTVzxPhj92w4oHtO67rIef4UWtMnTmSPk0GGU/a3
	 b4DcSZLC820Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B23930A1F;
	Fri, 15 May 2026 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: netlink: Correct buffer sizing info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177888660489.191233.9461598908219966673.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 23:10:04 +0000
References: <20260512103101.1076173-1-mail@etehtsea.me>
In-Reply-To: <20260512103101.1076173-1-mail@etehtsea.me>
To: Konstantin Shabanov <mail@etehtsea.me>
Cc: linux-doc@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 20EFA5593D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-288507-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 17:30:53 +0700 you wrote:
> Update the docs to match the code (include/linux/netlink.h):
> 
>   /*
>    *	skb should fit one page. This choice is good for headerless malloc.
>    *	But we should limit to 8K so that userspace does not have to
>    *	use enormous buffer sizes on recvmsg() calls just to avoid
>    *	MSG_TRUNC when PAGE_SIZE is very large.
>   */
>   #if PAGE_SIZE < 8192UL
>   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
>   #else
>   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
>   #endif
> 
> [...]

Here is the summary with links:
  - docs: netlink: Correct buffer sizing info
    https://git.kernel.org/netdev/net-next/c/55834f0d7421

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



