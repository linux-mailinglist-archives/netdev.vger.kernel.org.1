Return-Path: <netdev+bounces-298999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id biGSJDmWLWr0hgQAu9opvQ
	(envelope-from <netdev+bounces-298999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95767F30D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ayNpZfpB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298999-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298999-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41123022FBF
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54337754B;
	Sat, 13 Jun 2026 17:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8035C1A6;
	Sat, 13 Jun 2026 17:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372421; cv=none; b=ju1N+bDvdSa3RPLVr+VYpIPGRGg8BpzQWxxLtaifb87OYSk2aPue2T1XgL8vfJHfwDicYM1ofwCJj9YOGV7Y2pifKgfgGv3Cj3lNKmeGopfm9+iucwERPePv18mg1M7k2V4ifcq9xhLxnqAy72LUB3W5mmkJS60Se0U1ULsYgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372421; c=relaxed/simple;
	bh=eu+gGcc3tGvgCpDAAhYDKGZUgPQfhPegE6O9dd3itZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UNJrVYS96xi7N4ImndK1RgTHzt5eOZ/G7amVkjm/PVZjvxRDk7uX9PWSU7QM/E0XA8mKW/V1YCw1Ju6ToWTp8PIUkyNb5VdCTBB4ftIydhTklDNk5tLZCZo7/sEhkDxpf2dyGquQxCH5x93A1xRH8c+ZoralLbxIqxM0gzZSfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayNpZfpB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F17C1F000E9;
	Sat, 13 Jun 2026 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372420;
	bh=fAxeiREc2lyi1v9mbqX0Y3brJ2fzgZS6O5N5CK6Jd68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ayNpZfpBXg/YV80k32erWhZnoBGp3mAyrZzsf1MajnNzeH/bvcZaFI0q47b2eonmD
	 FADYk80DC/AlQkgRkfqebSvA7MHgpk0lscAg2VcHLkXYP7dAz0JBJK9oYrGTEG0SyI
	 t3HTORDmS7S1vZs+8TyOltUikBVPFStrcPeo2cA9j/cCcWNUDrXaGmcY/m920nchBm
	 sEmAMagbQyvc0H6QaQYU+JJ0o4q6S/Sg5PDsSc2co9JkiKkNMkATzU5sJY2MI4TrlH
	 LiR1XrUSboZg4S2dHckufU/9eb8LAcwqlBiYHAP/I+o5RtYkCQ1VtUhkDwjhFs0MSu
	 PrZMJtZxXLlHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A03A40FD9;
	Sat, 13 Jun 2026 17:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137241663.1545867.905991055392408270.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:40:16 +0000
References: <20260612045842.122207-1-rafdog35@gmail.com>
In-Reply-To: <20260612045842.122207-1-rafdog35@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, pabeni@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298999-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB95767F30D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 04:58:42 +0000 you wrote:
> Replace the open-coded backlog check with sk_acceptq_is_full().
> The helper uses > instead of >=, which is the correct comparison
> per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
> backlog changes."), and adds READ_ONCE() for proper memory ordering.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock/vmci: use sk_acceptq_is_full() helper
    https://git.kernel.org/netdev/net-next/c/4ff2e84ff1b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



