Return-Path: <netdev+bounces-299006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pu9DDF6YLWpChwQAu9opvQ
	(envelope-from <netdev+bounces-299006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:50:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F267F3B2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:50:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PmK1MdWi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299006-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AD0B3004908
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE72623D2A1;
	Sat, 13 Jun 2026 17:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01691DED40;
	Sat, 13 Jun 2026 17:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373019; cv=none; b=K4GYMIZgSIi+WItyvzLDT25eRf/liWYJb/DsKq5rxKewwPi5YOiYSQCz9d73L4grvfLBW4+x5xpuTEP+0KTtwgjesJQVuMeALKHYHV3sVo9EYfer2kBO/JAM8NEd676qcd8AfsqEjz4z/FucYeCqSVi7oBEzdPzQ5fO7xpd44Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373019; c=relaxed/simple;
	bh=Ojtpoz10DZOse6xSu3USKi74btPPz//ypb+4/wcbUwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HHaV1g53YH9qznaSHULPj+uqwgk71N5SeuZINl0lojcEAhF+FYB3MjJjzlH5uReT4cpSSkIZoGVrQug4o4tg75dXIzO2ATFn5MTDUU0/GRCkon06C4GCAnfMzHqTyLdaVDsQ+Etkc6FR5TVsjU0QnYcsCcjsYQeBHT6Ds6idvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmK1MdWi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1CF1F000E9;
	Sat, 13 Jun 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373018;
	bh=mJ78KlwM4tTVGx8n1zgqLoQ/XZ7TN4MGIxkV+7xQoFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PmK1MdWilTyUnOeFQEkgNE9XNSv+2EFJ6zKclADJpBCfXLUIbimOFYiT5GK++SqK9
	 T7oe/fH0OSaIe/cwciQFyRb+4LYoJtlhdmNGCVQ5OZLmfVAZ37mXijNRtRNzOWUUKI
	 ZuhTZbqtl5ACXvi40Fm/AhxepWvIHkYfr9bf7/M5B4HJlpD9DBVGCYiHCUZq7ClUWs
	 qG3t4eGhM88IN0CqN/Tahg97X1pKRAhDAqB6g0M3Mxd5l1F381AmQloqFZvkdjPV3q
	 V32yxl3BB8AfgvUjGtY7LSxEtzLmsesUoGgbARDx8UZTkduaB7vZv510s6VJ1DyQd6
	 MPmD//eE9dFXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199BE3A40FD9;
	Sat, 13 Jun 2026 17:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] vsock: consolidate acceptq accounting
 into
 core helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137301463.1548981.4492805699954312196.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:50:14 +0000
References: <20260612045216.105796-1-rafdog35@gmail.com>
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, pabeni@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 bobbyeshleman@gmail.com, leonardi@redhat.com, horms@kernel.org,
 edumazet@google.com, kuba@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299006-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
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
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B00F267F3B2

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 04:52:12 +0000 you wrote:
> These patches follow up on commit c05fa14db43e
> ("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
> by consolidating sk_acceptq_added() and sk_acceptq_removed() into
> the core vsock helpers so transports cannot forget them.
> 
> Changes since v2:
>   - Add vsock_pending_to_accept() helper for the vmci pending->accept
>     transition, avoiding a double sk_acceptq_added() (Stefano Garzarella)
>   - Split into 4 patches for bisectability (Stefano Garzarella)
>   - Fold sk_acceptq_added() into vsock_add_pending() as a separate patch
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] vsock: introduce vsock_pending_to_accept() helper
    https://git.kernel.org/netdev/net-next/c/77eee189397d
  - [net-next,v3,2/4] vsock: fold sk_acceptq_added() into vsock_add_pending()
    https://git.kernel.org/netdev/net-next/c/a6fd2cfdcdf5
  - [net-next,v3,3/4] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
    https://git.kernel.org/netdev/net-next/c/6f6f9b65a991
  - [net-next,v3,4/4] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
    https://git.kernel.org/netdev/net-next/c/27fc25bb82e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



