Return-Path: <netdev+bounces-282578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEqqG8+w8mlItgEAu9opvQ
	(envelope-from <netdev+bounces-282578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E236F49C00C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 03:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE4513007B8D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B74260565;
	Thu, 30 Apr 2026 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvqdFcZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7388218EB1;
	Thu, 30 Apr 2026 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777512651; cv=none; b=oLtzSKg6/B+ySBfuLGQIg2exAJbH7Cr/ufQtRNLIQ9Mfb2rK1l+q6sc5uJ8Q1EyQWTZUdt+ZLNIDtpt8swUQ1x0rJv8xbtuhRL92i5UoRkrMFaTEbaxCeLVmHQpDdST4enoKihH1NBFlpmvS65SMmOngjuQeik4B+qS5w+s/aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777512651; c=relaxed/simple;
	bh=akCXjS6bdpkS5UGyzQIzzygGCFICv/2bbvKG5RHHLWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfW5R8kVQSNnhgtpMs1NOhu/C5hWbds4IeqeAq6/B8nnxcDyZ6YaC7FqvsFzKoGZxgh08IPA+YbYpjGC32QApOr352vuK1CkrZxoMvC2bZm5pikCE3b9AkBaBWGWeI1iXS+XIY9hsMdsyAGjjEbJn+CtxLfxKgYvdvk+rQdsmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvqdFcZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562DEC19425;
	Thu, 30 Apr 2026 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777512651;
	bh=akCXjS6bdpkS5UGyzQIzzygGCFICv/2bbvKG5RHHLWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kvqdFcZl39pojQR+Z1OCkhCEoXXyD5Rkf7ss4xw0/fkYK8uQ+d6OB1DRePFiv8203
	 lqDPa4A3BWpyb3A01nnLhnmW20uYA7rtukmzQP6dwTzXL09T1nIVdanDpB9VKQWxlO
	 jgvBYyl/8ASZcEaivxoqAuz+Wc1z3CNM9zXXXB3K8WkG8bR3uk6ATNuzU55SN5m5hZ
	 DSELjID7pvuc6AwtW80xG+dYwjlqWl99dZ9OAPE79HZ3L17bKwyI6rB0+VHLhvxf/p
	 JGmVTRPaG9o0ejNPHuXWiwjZujZfT6Co9+rA5QzIhB0EXqZf30PSY5uso4ml9tCkRO
	 C1OsCW3suSEUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB23809A33;
	Thu, 30 Apr 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: mdio: drop unneeded dependency on
 OF_GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751260655.2252469.769732964799912595.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:30:06 +0000
References: <20260428093338.35043-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260428093338.35043-1-bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 brgl@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: E236F49C00C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282578-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 11:33:38 +0200 you wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v3:
> - Send the next patch separately so that it can be picked up
> - Link to v2: https://patch.msgid.link/20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: mdio: drop unneeded dependency on OF_GPIO
    https://git.kernel.org/netdev/net-next/c/c13581876f2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



