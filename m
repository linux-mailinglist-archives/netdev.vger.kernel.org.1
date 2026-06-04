Return-Path: <netdev+bounces-295032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y2nFNi7kIGq88wAAu9opvQ
	(envelope-from <netdev+bounces-295032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:34:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1163C888
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:34:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hb3s7SNf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295032-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295032-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BD713085FAF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E63269CE7;
	Thu,  4 Jun 2026 02:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FE271456
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540218; cv=none; b=IANoVnLw00HLyRrKsk4PUUCHglYDZ1J+yp2b4YWPratO+5r5Cx02n4Y0+1Fk/bSSrie/yesCINgmHaV28Yh0zTa6csM6Q883j02MkCGts8oImHlulROUnmX6ksX51iSiZOz7B/iOA4cA1OUxvbGGRs6kzkTPwyaF1JTgHIUc1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540218; c=relaxed/simple;
	bh=vfYnjR8kKttXVd32EkWYUcHHu4OQ/x6e//OnP9cYicY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=esgM3RTzwl58C0BrCy3FDJcjMqtrC2LKw1iQokMylL82f5xkuD1CVfER9aJunyHLzISvGIlwEPNIgRvrZ8gssbACD6di+A7/COowf7vgrtly+ygfgQpxqHZXa4vsc8f8TAIDd58H8n8xyomlZUWtEz6KEjnaM5sLLaswH7T1dF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb3s7SNf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4911F00898;
	Thu,  4 Jun 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540216;
	bh=wPfUDqaVGz/kuCeBBwaDEZE6Ai6ajcbzPk8aCxn/XRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hb3s7SNfjLt18qkz75jfuJaM9pjozHHo74Dx3Jm7sFv4iLjcBjkOLlHapPAYlWykD
	 3kkj08i6m2tr++Ly5WVl1Qy6x8xgISoOCnlbRAlKEGqMn8/nOCcHnqmhHrQrfET9YE
	 lJ63aYmKxLd/DohoprAhbz4xuVff/hhG7rLimgStm77BIoNO9uLzyUTbUl3UG7hvil
	 o5eXmsLr8VHLLTeZFGB2UBhauMh494AgjUoFZGfb2v8hQyESj9ZinTxlB2WftbhinK
	 JTllMGCPAa5zBDxIiFf0vka5+gm0m5+RAiyZstAq5akJKr9TwRTJKKAXaK+rg/S0DG
	 epWu9bzPVB9OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A439308E6;
	Thu,  4 Jun 2026 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: bnxt: disable rx-copybreak by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054021763.2211213.17711368622336501729.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:17 +0000
References: <20260602003759.1545645-1-kuba@kernel.org>
In-Reply-To: <20260602003759.1545645-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295032-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EC1163C888

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 17:37:59 -0700 you wrote:
> rx-copybreak requires an extra slab allocation. Since bnxt uses
> page pool frags and HDS by default, the rx-copybreak doesn't
> buy us anything. The extra pressure on slab causes overload
> on pre-sheaves kernels on modern AMD platforms.
> 
> In synthetic testing on net-next this patch shows little difference
> but I think copybreak is "obvious waste" at this point.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: bnxt: disable rx-copybreak by default
    https://git.kernel.org/netdev/net-next/c/bd3beb5c8691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



