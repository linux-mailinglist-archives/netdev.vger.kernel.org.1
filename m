Return-Path: <netdev+bounces-302296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dldcLNwuP2pXPwkAu9opvQ
	(envelope-from <netdev+bounces-302296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:01:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994286D0C30
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:00:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oLYcekoP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302296-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BD173016C19
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C12773DE;
	Sat, 27 Jun 2026 02:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22526FA4B;
	Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525639; cv=none; b=iwTMHQfMW1UDZPrxCoixNwbEHRfrFVmVuwqrFFzoHAXwMf+d5u+7vfFK2mbWgjn4dM3LmQ8F9n6slAU6atZFDEHLZHX7n8EBrdK5LRTGWhQZmiI4P4ogkbU/h+kKNqbRLjy5w5VnvF3IOb8aZsmuo9WO/4a9TcDjCIcKyHMMV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525639; c=relaxed/simple;
	bh=uSv7uId4Z0E891CAD78oLyzZuB0lM067i7irWiMsZiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f3GLNTWjHoAOIA/6r0ipQx2H1IAuhl+4Kne5uJAnKi2hKanx/p0fEJVTDACdo40Vye5epcFQ+5N0AhePkzfWxDqqop56+EVOKKtT5hapcgpfBYWVmtNzP8MjycbBH0kwARzNqD1m97a9VHHNywMXImyNWzn2IJpUPy0QE/TT6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLYcekoP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3E71F00A3A;
	Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525637;
	bh=wwXltDt8hUiSby2DBmR6jK0QaWZT3W5aCkZkHrdqTNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oLYcekoPEGv62Gh2t/p2dys2ZbHT1bFDlMYHZKX7LCL88ZMSuAHN9sIH87pPYi561
	 VxMJY8dmgCb8FK2FKMPykOPJnIcPuJsFYjpKpbfD0E5QnZNsT846gNTYpnSiyg+5Gl
	 YKl/iJf4FgOxNK5mf//DFkV/7EFmmgW3fDz9N9Xps5PqcmGgx3uLoWv5a4povJ5rhf
	 3m+gGcjrZS3e+FhOWoivZti0fpV/pnJEDTYwUepy6l16aDXS1/OD4w48+BdsjmrvIL
	 9sLO8IoiO61BK1TRfamsC7cdWhUxjXTh9zo1ViAYvI6qJp/cVic0tOZVKcZRALZurH
	 VWYpRMyyBMqdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A883938C76;
	Sat, 27 Jun 2026 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qede: fix out-of-bounds check for cqe->len_list[]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252562330.1167656.14912063533919224131.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 02:00:23 +0000
References: <20260623144602.3521-1-matvey.kovalev@ispras.ru>
In-Reply-To: <20260623144602.3521-1-matvey.kovalev@ispras.ru>
To: Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Pavel.Zhigulin@kaspersky.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302296-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:matvey.kovalev@ispras.ru,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Pavel.Zhigulin@kaspersky.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ispras.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 994286D0C30

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 17:45:54 +0300 you wrote:
> Move index check before element access.
> 
> Fixes: 896f1a2493b5 ("net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()")
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
> 
> [...]

Here is the summary with links:
  - qede: fix out-of-bounds check for cqe->len_list[]
    https://git.kernel.org/netdev/net/c/f9ba47fce593

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



