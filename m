Return-Path: <netdev+bounces-270161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNY4E4wOvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:20:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B963C2E317D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667673007CB2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75382701D1;
	Sat, 21 Mar 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8SnpzHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EE212B0A
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063239; cv=none; b=IDyphfs1ajRM5AV3xgcTuVKdtdSDNCwELlqJ5Wco36qu94HW10e5CTjGFJ17lFzPKaa9Bew3wC+UigtcPnfrxbF31jnpdrEGt1kP4HRXg4wm8q9CN0nqEz5s8Ibv3Tx4+a1R4tKr++RIe2hKTd8TRoprg8yOcwd5gxOimSxpEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063239; c=relaxed/simple;
	bh=oz9G4goOg+PxJLBW3LhD76SplnjTd6Lmn+KdOMRzE/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xq9fdjx9FBUmrPCrpk3mhKawDMtzZ57U0/CLXU2FFcx+jFgFmp/i4lUMsACRBMlibwk3q3WLmq+H69GBJNHWJh99+xf2lnqG5cXJh5A7+nmyRzOf6wxSGLIVjTYsxt/OI385GzKtgrLlmTqulVOS4DQVMSV394P9b9HFjAjqvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8SnpzHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45108C4CEF7;
	Sat, 21 Mar 2026 03:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774063239;
	bh=oz9G4goOg+PxJLBW3LhD76SplnjTd6Lmn+KdOMRzE/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i8SnpzHLJvJvbSMZD0fbXDL6faEVpLcvh2NO/joFnN53GNbwOS023Wx3duP7JfU3J
	 Sv92R0TLSbk9kmt1KA+ZeDAgmaLWZRhHNF+eYd6BnreISGssab8IWRv7Ixd2k02ZjW
	 eTmOqJ9XG/buRc+QtqjO5f2cww4LAOT0Szg66oIOMH6VK3Oz4wRHP9waCz0JEh9ybF
	 5bOoR7k1JgcxxG7PELvEduOxxL4h8SeLpKolkA0K7yzdhYPNCW9nW+UonFS7E7VmI9
	 KV8PkpFu7HG/l/s0+rygQazMzSzL221S6oPaGRicq4tbXL45RzsQB7uWzes2o6/eKT
	 LWWg77RXGQXOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA33808200;
	Sat, 21 Mar 2026 03:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netdevsim: correct typo in new_device_store
 error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177406322929.2737822.2090270771071150615.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 03:20:29 +0000
References: <20260319060812.495488-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260319060812.495488-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270161-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B963C2E317D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 23:08:10 -0700 you wrote:
> Fix the format hint by replacing "unit" with "uint" in the pr_err() string.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/netdevsim/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: netdevsim: correct typo in new_device_store error message
    https://git.kernel.org/netdev/net-next/c/53edd8309570

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



