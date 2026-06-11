Return-Path: <netdev+bounces-298270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XheLEzD6KmqC0QMAu9opvQ
	(envelope-from <netdev+bounces-298270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF1674569
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nCv4DoU8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298270-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34A7350498C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41124472789;
	Thu, 11 Jun 2026 17:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7248BD57;
	Thu, 11 Jun 2026 17:58:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200694; cv=none; b=ZVzKThu6oSf630VTZvCHcPK1D8/Hfa9Ws3Za67pdNJSIZZX91LaXn1jg86jLJIEjSazIcx2jNWOH5FSKwxJl1g9F1XKr5LkfgTTqExePw5rQb13TK1J7cni7nxNPq1mKASfgKFgt/E/G8R4rXSSnbycpWt8zQ+sZnoiT/kBd16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200694; c=relaxed/simple;
	bh=O02mcBcBOjj6KGKql2GDOPMaM82nZWPNMghaDwSrs90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kqimw4AFZg3x3j+0KwoCTi3iH7aT+9AbkA/4BkA43kHHda1fUUkn+CiZswmGkRr62CHUgE00FHl9HlMJLdoa+DAVQdj78QN0bp/I3NPRSVxcme9fvoqrp3UFToNsKvZFJZmZ8IJoRKX0cvuWYGZBqNvxHiyV+uwq21TaS1yntxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCv4DoU8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E51F00893;
	Thu, 11 Jun 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200693;
	bh=ALz+9GrPdiEVtpRLkIHlem/iZAxX+7lBScDgDqNoHVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nCv4DoU8Di0XIquePQxAP2kdOsn154otuLP43X4N9vBGV8SpWG/CThJebZgmXAxDX
	 1lS/6WBqxttNtGmWR9vmXa4+4ePNSWAnbvLyQ7IoUynNOwoUWoVamu8NP+iGGVoGgc
	 yGq6xko07BW3EY+7nicaEw5Vhx3nxY/rps+su7PHe1NjzPulGRo/gneEUuLRNxRfE+
	 s+fGT/YlxnZXjRFtPrWHSWDuedRkTOGTw4mHlpmWqOAOyt/MzlRLdkuHcTVUCGglAM
	 As5LkYwYB162uj1GjZG7nkD+ZWKdrBTVPnjVjlwUIf34C+k8vtHcibRcx+wSvnUhPb
	 XSwCRTLV62XcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938D33930F87;
	Thu, 11 Jun 2026 17:58:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-20
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069013.286318.14387798672720633781.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:10 +0000
References: <20260520204959.2902497-1-luiz.dentz@gmail.com>
In-Reply-To: <20260520204959.2902497-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298270-lists,netdev=lfdr.de,bluetooth];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91CF1674569

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 16:49:58 -0400 you wrote:
> The following changes since commit 375ba7484132662a4a8c7547d088fb6275c00282:
> 
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-20
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-20
    https://git.kernel.org/bluetooth/bluetooth-next/c/5027c886e26c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



