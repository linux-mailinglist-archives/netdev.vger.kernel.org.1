Return-Path: <netdev+bounces-298853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YolVJjisLGqZVAQAu9opvQ
	(envelope-from <netdev+bounces-298853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A667D624
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:02:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TYere+vC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298853-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298853-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5A83428AA0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63513D51E;
	Sat, 13 Jun 2026 01:00:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5425B0A3;
	Sat, 13 Jun 2026 01:00:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312434; cv=none; b=m4/1xlt75Pt0ibtzUC20YAiFQBSzghCuHAd8cm7WwjC79CAJENhhqti2wisyn58VOmcvnAWbnGKHWGh/r/6Ag1nfkorIHCerrN0Hzk1e0W64/VBmimnI9m5238vTg5disz1QAA50SkrapH3SfDf3qDXYLk+VttVS1pt/+w33IQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312434; c=relaxed/simple;
	bh=WfYUEOPeK03EHpwPebn+MgtHwxpMs96r3pSiOwUJEUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbIzIroSliFZ0/LaakMRtnY7W3nze0tnO/DYbYckabeX1fZQaq8HFI6dTRR9tCBuV62X4JiferSHJQ+9f9xtUMe+RDWPpOaB81BKyVS02VMCjT+JVfvhoYJqx9cHu3PiZnEKw9NROrOGS0HU/WSoRmTU/x/ONEx5lmswCbPfeu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYere+vC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80251F00A3A;
	Sat, 13 Jun 2026 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312432;
	bh=Wn0Opc5jXMGzRmeoKDOhDr/j7UkqCcoDWwPQbDZbwhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYere+vCg8GJynjh6ppeadGFRHg/TY3ukISithtp82fMR0fYjQgzZ5vuHpNbbwwXa
	 XZ4yZlaT1KUhLZkC2uHb7APx7LsBpso643TpchRdawMwbHUuPKgt5MnSCOyXsAcDKG
	 VbEhkDXm8SBzF2uteC2zk1cwdHbwz6xeM9xB8pZmivuT1TFXkZB3MkO8PTefUZ67Om
	 p2kr0BojPEdBHDdhFlisbOuIvRODl9Ih5soKM6QHXNgaqCeI51bjBJIRFD6pjKaMgO
	 9dLd/MWvZ7WyklILKDniP+dkARNBXXX4xJesXVKPwAt+gmZPMKurpxx9KiqWS5K4dO
	 TO/FjquHlWBzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A739E9607;
	Sat, 13 Jun 2026 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] docs: networking: add guidance on what to
 push
 via extack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131242913.1315131.12921841859302513787.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:29 +0000
References: <20260611172149.1877704-1-kuba@kernel.org>
In-Reply-To: <20260611172149.1877704-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298853-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:joe@dama.to,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80A667D624

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 10:21:49 -0700 you wrote:
> Every now and then someone tries to duplicated extack
> messages to dmesg. Document our guidance against this.
> Also indicate that system level faults should continue
> to go to system logs. The high level thinking is to try
> to distinguish between what's important to the user vs
> system admin.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: networking: add guidance on what to push via extack
    https://git.kernel.org/netdev/net-next/c/96fbe161e402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



