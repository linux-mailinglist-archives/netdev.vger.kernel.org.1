Return-Path: <netdev+bounces-298809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WDbpDIKPLGr+SgQAu9opvQ
	(envelope-from <netdev+bounces-298809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B70067CF34
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gqb2vzT1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A63F3003817
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6C3AD500;
	Fri, 12 Jun 2026 23:00:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223E39524E;
	Fri, 12 Jun 2026 23:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305211; cv=none; b=ihBKgSfAAiC/26V7kzez0eLWxjOXJdpaCqEyJ31OknLYRxE/cpma6n3JE4s8wyoWwz6GIq1w5DQWZ1N93D9NNjF8DFVAD/oElWc9wn4f66LTXOl+VPpDKs+7FrC+q4F9zXZ7xh1rrb1uXmiwCxr0Gd36UvSI9iFqst2fXV6S3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305211; c=relaxed/simple;
	bh=HvzyHXz5OTWHG/pURoP8q86aY94wX8ghYRUyS1Al+RY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gTSuqvYnvS3hSZH1+KXNCrSSW0qIGbIB8gODqzPz5R0qkqnC01v/+GtnMe4SpV0CB2yb81PWLrfHC7JCAPXxZCOYJVg5TVjeiDHEjxM+GIQNBXb8msk9L/uspbqbyPivihj1Tq7LGaLQNmwp2eWfa7YZ7ac1tq24M5mg8Kg4IFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqb2vzT1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B27F1F000E9;
	Fri, 12 Jun 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305210;
	bh=hgDsHcqPyaAmM0OceEZwWyhzXFxL6acqtWBeT1PsHkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gqb2vzT19ymR8XRNCyfIHWopvYvVl/Xq/VLqphWZZwkyrMQkfYenFFNPis/iFHEkR
	 dvolcodhS0oux1n11SpFN2blaqQsfBGGZjzyjmCkGDKeTLczwK8vxcWcwUVR7JDPfu
	 x7pwSJDzc4B98j/75v56uco1NjqLc1NsDw7BK/iP/WjR141NkVn+F8HD/ld6DN8U2I
	 W+Q1HRZncxK0TQ7N6hC5/kOe/jNOv1xUXc0f2tPB4LnZWaLP3iqjsPypci6zD03QZO
	 2H1+lF2GZ1GTgoF8CV2rm7E+HtL3BSCz+UNAigD72Fpy83vufq2ZyEVYEeScwCGNsW
	 M42MIsxgGC5gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1982C39E9600;
	Fri, 12 Jun 2026 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] handshake: Require admin permission for DONE
 command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130520664.1282281.8159412003849271109.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:00:06 +0000
References: <20260609141831.90694-1-cel@kernel.org>
In-Reply-To: <20260609141831.90694-1-cel@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 hare@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-298809-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:hare@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B70067CF34

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 10:18:31 -0400 you wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> ACCEPT and DONE are the two downcalls of the handshake genl
> family, both intended for use by the trusted handshake agent
> (tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
> no privilege check at all.
> 
> [...]

Here is the summary with links:
  - [net-next] handshake: Require admin permission for DONE command
    https://git.kernel.org/netdev/net-next/c/81246a65303d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



