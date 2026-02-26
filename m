Return-Path: <netdev+bounces-261152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGX4Ks+5n2n5dQQAu9opvQ
	(envelope-from <netdev+bounces-261152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:11:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633E1A0595
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFDB13023783
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0A38759A;
	Thu, 26 Feb 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1o9nfNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E13815D1;
	Thu, 26 Feb 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075411; cv=none; b=UqqQfZWa5Kv2YNkFX0ANJc0rb9V/+VptN074XPXXdVdDt2Kg8LTJRUJaU/uoHbvTgeVWSsffiPDc4OSy59dXaZ+O476TNfidbUUiOlMRSMZfKpf0SuSoGWQSzLM/fbicPN+gRx3d70CcqCL7QS6oi1wToUFOpzEMFJFSmzIGlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075411; c=relaxed/simple;
	bh=9y2X9NVB2pzNbHqipUSWuvBc3Db8CLsGCSON2WIFajY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRys8hJk5TCSsCHttzHvdq2Eqo/SGuZQg4qyS2x4G8hg2d9yFP4bGpkZTGztbWcG9taB3qLuoqtyhKjQ1W87kjwf2OqWlDd5k18EOPfYhpz7THjTTW3QPLkQY6Qnm5FAB7NSNrfkh5k9cC+utp9wCfhgoM6h3BWqS20AFNozmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1o9nfNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A1BC116D0;
	Thu, 26 Feb 2026 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075411;
	bh=9y2X9NVB2pzNbHqipUSWuvBc3Db8CLsGCSON2WIFajY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1o9nfNY/PTQpqpoatO6E+pJhQtgGIQLyuATHXq3LkNjNlriGSRosF9go3QgxGZgm
	 KvrlEQu1zZ1jkV2cLLE8uV1PbQ7ebnh2Snu8xC5kHPn+GqcRt5Wi0qipLZOZwC7PeJ
	 X28k5oMgTmoHKoPPRSeE57f3q+FsegUaB7QbyN9UpBbOHwFFSHMWroKp8wVV9rSR4i
	 6a+H0kwrASdxM81xO6kErhIoia/Rmolkuyk/tSixPMx71mQFocquXIpVrhA8RFF8Za
	 e38Zt0LeFkOhMJfFegSttE/AvdXMOSwtXJEnPFXvCkZBJDnCBzwF1JLICyr08igRyn
	 JUzg83WemC0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC0380A94B;
	Thu, 26 Feb 2026 03:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: Use container_of() to get net namespace in
 sysctl
 handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207541604.1014739.11994521335982441841.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:16 +0000
References: <2026022318-rearview-gallery-ae13@gregkh>
In-Reply-To: <2026022318-rearview-gallery-ae13@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sgarzare@redhat.com, stable@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261152-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0633E1A0595
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 18:32:18 +0100 you wrote:
> current->nsproxy is should not be accessed directly as syzbot has found
> that it could be NULL at times, causing crashes.  Fix up the af_vsock
> sysctl handlers to use container_of() to deal with the current net
> namespace instead of attempting to rely on current.
> 
> This is the same type of change done in commit 7f5611cbc487 ("rds:
> sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")
> 
> [...]

Here is the summary with links:
  - [net] vsock: Use container_of() to get net namespace in sysctl handlers
    https://git.kernel.org/netdev/net/c/5cc619583c7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



