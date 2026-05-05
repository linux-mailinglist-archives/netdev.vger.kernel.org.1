Return-Path: <netdev+bounces-284177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MoDAs9Y+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 038084C60BB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9426B300B9E0
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F93A8FF6;
	Tue,  5 May 2026 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1PMT8Yq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBAF3A7F75
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948862; cv=none; b=fSLAy9shMLSIbPuctpBASuvTozpi0741f3OIGQRJw3Yj/lNK00O0pUrIAmUe+NjZMZHKZoeiJuo+LVckM90mfMStDo28a0+ZTeBMKTfPajX0EQr5smbnzpqJMhXW/+eOPhrc8TMGwdsxxXGPi2Om30owai5dVkY70XOSGxtCqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948862; c=relaxed/simple;
	bh=nMVA8taU+9uc5GeXWS1mdP0oXmuGECdZbORfbB6hLsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O5exgtM6vZVMRNioj5UohEdtpnmzx5r0dv2tr2Tp6jTG/4tskebAGW4hn4HiChtKQioGPgP5aIP7T6p7WrtgB7OAeKD3pzlbUnKNP/8GkCSl1JLtD49Z75pSzMTy4+vE3YDH2utyScqdihrR1u4ZeFlvmyfAk/no+eSwkvzdGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1PMT8Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E503C2BCB8;
	Tue,  5 May 2026 02:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948862;
	bh=nMVA8taU+9uc5GeXWS1mdP0oXmuGECdZbORfbB6hLsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K1PMT8Yq/P94inoRVo6ASog8DcpwsQme7KIZBC05N/woWYTwkK44lfHLZOBYmVoxP
	 eCwGYeakWCM5cqsm7/P+epp7nSkFx+LPUXZqOuMNoq63CYU/hGYqDvyNwMB+YIns1b
	 BojJlGFaQa7Clrk2K9fkifJ41kSBMxzp8NZgmTwuBM2Im5/obgBeUFZPkf/GikjIp8
	 4kAym+tijzOZqzCiinX9jQx4yVetz/xyw+WCGIku5NKInSb1dAc8NmcBuYi9+D92bC
	 exZEnZDzSfYWA8wy3Z06To7NlM6VTJo0R/lTkdOIbOWDxaNkmUx2pDAwU8yXPXwviO
	 NmurGeQV2VB2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE1139301A2;
	Tue,  5 May 2026 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipmr: Add __rcu to netns_ipv4.mrt.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794881305.1397274.3711796595324240725.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:13 +0000
References: <20260502180755.359554-1-kuniyu@google.com>
In-Reply-To: <20260502180755.359554-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, lkp@intel.com
X-Rspamd-Queue-Id: 038084C60BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284177-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 May 2026 18:07:47 +0000 you wrote:
> kernel test robot reported this Sparse warning:
> 
>   $ make C=1 net/ipv4/ipmr.o
>   net/ipv4/ipmr.c:312:24: error: incompatible types in comparison expression (different address spaces):
>   net/ipv4/ipmr.c:312:24:    struct mr_table [noderef] __rcu *
>   net/ipv4/ipmr.c:312:24:    struct mr_table *
> 
> [...]

Here is the summary with links:
  - [v1,net] ipmr: Add __rcu to netns_ipv4.mrt.
    https://git.kernel.org/netdev/net/c/a6039776c799

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



