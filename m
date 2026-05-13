Return-Path: <netdev+bounces-287413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDPhFC70A2rKBAIAu9opvQ
	(envelope-from <netdev+bounces-287413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:46:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68D52CF28
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A44933051E94
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF93932D5;
	Wed, 13 May 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJGdJIRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210B3921DE;
	Wed, 13 May 2026 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643965; cv=none; b=Z7XzOY6YYh2sRfgH9Gmv4g5+0vmRLzO/qwG2toSiPrUY16WIXw5nMHgyKQOozByv8ca1Y9unllYwEWUhH59KqdEmvMZK3H5Td3ow37uYCHj865z3atxbPPEmrHupFKEdt+mDYmOhZtZZWGvFcakC6QHrfgY1dq9Xq3Xsu1eMO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643965; c=relaxed/simple;
	bh=4MA51zp6KFVGMsHTJytu+1BKMCsUVq+f+b3/E1FUrug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e7UKhSWNyXsucpRDQL8Tc7RJab4GV+m7Mdj+jijc4PByGyM71gtHuEmBZPByhxnD392Jgjz/1Nibpf5NLWdUQsa06qKINZniy2oYmzGB08//VJIv/21w1BLqA4PFFE2jnwa7DOA76jnudYeqle0wStkDdOmvM/w8Zh6zU9UfS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJGdJIRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C5C2BCC7;
	Wed, 13 May 2026 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643965;
	bh=4MA51zp6KFVGMsHTJytu+1BKMCsUVq+f+b3/E1FUrug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJGdJIRcXkTXOYOzt6/BwkocoxvuLize9AUD6GQg0n8sU7gyH9sH0NCCB6Z/cHSbD
	 y3CcgQXg+lZ3RXvggKT9+FT8Lw2QZE0hT5Ms7rjqN1rRPuIrDoL6hROmcLYSY4TIe8
	 nGzqyYJ3VoUdrB0jGLoFpwgWMHXbLpI4Oo0Zx8LCPe+j9xUS68OM+A+MnnUhvm27yX
	 dCcextPWRvCUKszhuFfQK+OcwDTV61WigZ6XPkPNWc8+J9HbMR9JJ2VO5EPuf8IKYv
	 RBIr7oF6dNvA5Bmli7BR8staqyRHFIpcRpsrPRdoO+T5sNVap3/ea+iRQxwOUddWSO
	 jA3GjXp3GielQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE313822D60;
	Wed, 13 May 2026 03:45:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atm: fix skb leak in sigd_send() default branch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864391104.3173643.17276531559974621177.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:11 +0000
References: <20260509122358.1102997-1-albin_yang@163.com>
In-Reply-To: <20260509122358.1102997-1-albin_yang@163.com>
To: Yang Wei <albin_yang@163.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, albinwyang@tencent.com
X-Rspamd-Queue-Id: BD68D52CF28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,lists.sourceforge.net,vger.kernel.org,tencent.com];
	TAGGED_FROM(0.00)[bounces-287413-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 20:23:58 +0800 you wrote:
> From: Wei Yang <albinwyang@tencent.com>
> 
> The default branch in sigd_send() calls sock_put() and returns -EINVAL
> without freeing the skb, while all other exit paths do so. Add the
> missing dev_kfree_skb() before sock_put() to fix the leak.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wei Yang <albinwyang@tencent.com>
> 
> [...]

Here is the summary with links:
  - net: atm: fix skb leak in sigd_send() default branch
    https://git.kernel.org/netdev/net/c/f9e2342046ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



