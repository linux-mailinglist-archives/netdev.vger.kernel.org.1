Return-Path: <netdev+bounces-274820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIqEBCsUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780C38FE1E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CED45305B491
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955C282F1B;
	Fri,  3 Apr 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiJdAVMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786428136F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178651; cv=none; b=tnBAEEbUXkOjTnIU2sjf1YPU/KuCRIDUdchHK04S/h4j16orR4cCTZQ5rnvAyuSk51PX5QK8kdbUHrtokRJhUH+JYQ5STpTOJPe4V1OYGTSweUwRgv6IGH7mXmQHhuvoIqYArvRnQ4RGjwXEyTcirfdvJWOQBt601zzKyNl+V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178651; c=relaxed/simple;
	bh=C7+rsISTK/p2GI1VvmgeiR/8X6BMtiQVFADKm3TVNXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ilcbNDM2xxQJYAKoqy9q9FQqODyYZ+dy4iPYLx86MFJwRR95iXTaSg8sbvEakriv/aZn4QrT4eBX/j1byI5cRr6OCybGBENiP5Nek8UoTqUmmZ9Hq6SA0Ag2rVXhVHA5IHKM8pLT0hp5XcIJKKxEskc9OKV390KW+ZrV/Ud/vPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiJdAVMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B169C116C6;
	Fri,  3 Apr 2026 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178651;
	bh=C7+rsISTK/p2GI1VvmgeiR/8X6BMtiQVFADKm3TVNXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jiJdAVMDW47n9TkUm98dcedvbyXdAl2i+jvu5Kk6NeqxsXsrwRSJ9egG+qKEpZcGw
	 s7QGnrNJbCLfEXvmpSCAvS36Nc6CN2QpN9BKDcjSPwncIkRNQyEwklf7PhU27xEKvo
	 jBnaD+rIqU2xbVZh/pV4gylFNOwJDrTMZLmbLIcTKQaX+zfphXYj/NsYBVNRpD8ZQ3
	 HKD3h6c1/gfnAQ0RrHJvQJDs/A8y/U0u8huh34jBdRGnsWVWNfwVtwSUQHKpFRDMbh
	 f7NiNi5XxsGeyU+Gj7kovYtTTe5NeHTtBx6ABr4MRKWMVx6mNXpcIaakVol+cVTKip
	 gVNGPxQ0o1EEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D4E033809A09;
	Fri,  3 Apr 2026 01:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] macvlan: broadcast delivery changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517863378.685228.12413129137929925316.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:33 +0000
References: <20260401103809.3038139-1-edumazet@google.com>
In-Reply-To: <20260401103809.3038139-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-274820-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6780C38FE1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 10:38:07 +0000 you wrote:
> First patch adds data-race annotations.
> 
> Second patch changes macvlan_broadcast_enqueue() to return
> early if the queue is full.
> 
> Eric Dumazet (2):
>   macvlan: annotate data-races around port->bc_queue_len_used
>   macvlan: avoid spinlock contention in macvlan_broadcast_enqueue()
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] macvlan: annotate data-races around port->bc_queue_len_used
    https://git.kernel.org/netdev/net-next/c/1ef5789d9906
  - [net-next,2/2] macvlan: avoid spinlock contention in macvlan_broadcast_enqueue()
    https://git.kernel.org/netdev/net-next/c/0d5dc1d7aad1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



