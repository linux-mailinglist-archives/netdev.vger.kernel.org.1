Return-Path: <netdev+bounces-287901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE3MDZ+dBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:02:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BC540112
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A6A3023361
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301B37EFEA;
	Thu, 14 May 2026 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4FheVcn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D761B4224
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752869; cv=none; b=CZdeVUVjVZxLOBqNdT9FKIYcAHhuh5Q7bdxAfaDEd6SAIpHDH76YDIqCPqyTSqG7T+SzVD3Sz1OpWIbprVvOSguDiU0T9nWZf24+xUoR/tLGKJXKVPWKe8BGtNqzV/myqGFCViA0CYAAE7NE/AvLR/qdiEpN1kY5DJKPGm9oWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752869; c=relaxed/simple;
	bh=7JUIb+Uxt19luN8JHIpaNm9wmgs91MMQ7PnX9LsBPJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nRPVXmdJJGZqCJMyVcCoZYHpesVuIxa9mki3rquTDpyVlbSKT2FcaCF/reDA0kTfc1a/0hqfo+qyKirsEWmEfC78cclh6ldyoHk1cQ+l6CUh1o20fS7G6rCth0qSnr87XLGhek8jMsAR2XqvZ8T0mIo0QSSBp7KYl48qqgiEMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4FheVcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACE3C2BCB3;
	Thu, 14 May 2026 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778752868;
	bh=7JUIb+Uxt19luN8JHIpaNm9wmgs91MMQ7PnX9LsBPJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4FheVcng0GcPNozk0TY9tz0LGj6FYqL+ja8KV/wYJ8RSMdjscFrhlpl/o/tzZP7g
	 xRO3nQWdpyATVcQ3NJHHvBG4i26Fdv/iP8tdvpEBM3Oi4dgn6DxICT0dw1ePO4hrL+
	 S98BJk6ZC3ULeV0/o+vz+uKKURiFVm9oB9OFW2DeWS12/qTRJFoRJ0EguQf6oOg3MH
	 8SWmFbjZy1tR+t24kmN0LVsMzsl1VHMH1d66fjovO18ivu2LrhH01U/gaHVJ2gOvYF
	 Kjz3Nf9sEkWZw5Dtiy+u0L4g5eUhGMWoRaTXekqyo2I/KtMBXZKX/V0kzUWfnunJOn
	 PqRywpRcuh5vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D59D13930924;
	Thu, 14 May 2026 10:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] net/sched: netem: enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177875281355.4048885.2526866679312105000.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 10:00:13 +0000
References: <20260509171123.307549-1-stephen@networkplumber.org>
In-Reply-To: <20260509171123.307549-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com
X-Rspamd-Queue-Id: 911BC540112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287901-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  9 May 2026 10:03:21 -0700 you wrote:
> This is a collection of improvements to netem found while
> investigating the fixes now in net tree.
> 
> v5 - minor cleanups
>    - add allocation_errors counter
>    - align counters with where impairment occurs
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] net/sched: netem: reorder struct netem_sched_data
    https://git.kernel.org/netdev/net-next/c/9371b229a1ce
  - [net-next,v5,2/5] net/sched: netem: remove useless VERSION
    https://git.kernel.org/netdev/net-next/c/4398429a5ff4
  - [net-next,v5,3/5] net/sched: netem: replace pr_info with netlink extack error messages
    https://git.kernel.org/netdev/net-next/c/675f6f1968a6
  - [net-next,v5,4/5] net/sched: netem: handle multi-segment skb in corruption
    https://git.kernel.org/netdev/net-next/c/e8be7cdedc41
  - [net-next,v5,5/5] net/sched: netem: add per-impairment extended statistics
    https://git.kernel.org/netdev/net-next/c/a2f6ed7b4873

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



