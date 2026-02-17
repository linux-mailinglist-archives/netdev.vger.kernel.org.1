Return-Path: <netdev+bounces-258997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMDKOntDlGkgBwIAu9opvQ
	(envelope-from <netdev+bounces-258997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:31:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DA14ADE6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D53301F994
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4C324B34;
	Tue, 17 Feb 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciunqusi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFD324B31
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324216; cv=none; b=W7NMEbN1sUhRWNjTlfqJPPmS7HZ0AKQe7KiEOzjl64TiqChu8hmOsIctrJEhzkmoHvQYe0A33VprqcmTnsZDx9BYMz43wdDpWRn/b7gfT1uJruU+9pTkqQwD6ZCZ1917pDXdLUx197S7BDJcg6RG4r8jVQP6ejjIdEjuTt/b1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324216; c=relaxed/simple;
	bh=5nL92eyKsGopt7Iv29PLeESihORoc4w15da+HbXH6zs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MlaXDEtN3LobEPr5RX7dLAegyJ5iu3amlicUz2574z0d5qwSD2NuQeqk74Zj9MuVQSsIzE/bOwI7a3SZ2unlxaZuPWuVwyYo31bKeQzMs4A3CNsYLxAgaQtYfEuwsvh4UGrLAoEODpbv6x6lu+WJiJWRZmUdtdBCxWWr6t6ge38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciunqusi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7622C4CEF7;
	Tue, 17 Feb 2026 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771324215;
	bh=5nL92eyKsGopt7Iv29PLeESihORoc4w15da+HbXH6zs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CiunqusivbHfXJQ8ogT2cdwD2vhStBXzIPU5H8YXY5FUhhCOBekzOlvTnlgsvVxbm
	 Me29K8uvf1KO9olsJ74ne0HJeMgNI24ac9AM+n3ihdUlWolRCyEHYOis3P809QaAvf
	 p15m4JlmLTq2BlBGZW6b6F8DritdTY4OT95ipwP1Zcd/CIJO5gzQG3hDbANNQnVMOD
	 8b8jyKEC74ZxqdBwbkB6SAaN1GyGA5Vdry7RSS9sxVRn/7nuV8AOH6Az52ryO+mdYb
	 d9/669Hlr/7iX9CV0OlGjc5uSwhqR9scoDQbEdMslCXgfswDUdg3A/AkCNxW/5l0hv
	 197+wMM6G5vig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B44A380AAD0;
	Tue, 17 Feb 2026 10:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] ovpn: set sk_user_data before overriding
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132420783.11470.11574422843665569636.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 10:30:07 +0000
References: <20260212210340.11260-2-antonio@openvpn.net>
In-Reply-To: <20260212210340.11260-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258997-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:email,openvpn.net:email]
X-Rspamd-Queue-Id: 545DA14ADE6
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Thu, 12 Feb 2026 22:03:27 +0100 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> During initialization, we override socket callbacks and set sk_user_data
> to an ovpn_socket instance. Currently, these two operations are
> decoupled: callbacks are overridden before sk_user_data is set. While
> existing callbacks perform safety checks for NULL or non-ovpn
> sk_user_data, this condition causes a "half-formed" state where valid
> packets arriving during attachment trigger error logs (e.g., "invoked on
> non ovpn socket").
> 
> [...]

Here is the summary with links:
  - [net,1/3] ovpn: set sk_user_data before overriding callbacks
    https://git.kernel.org/netdev/net/c/93686c472eb7
  - [net,2/3] ovpn: fix possible use-after-free in ovpn_net_xmit
    https://git.kernel.org/netdev/net/c/a5ec7baa44ea
  - [net,3/3] ovpn: fix VPN TX bytes counting
    https://git.kernel.org/netdev/net/c/b660b13d4c63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



