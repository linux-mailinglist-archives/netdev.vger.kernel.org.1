Return-Path: <netdev+bounces-264923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMaEJxxFq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:20:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E95227E57
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 699F0300A241
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DF29D273;
	Fri,  6 Mar 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY6A0mva"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D7175A95
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832021; cv=none; b=hMcMYdU9OF5LfPpyIEiCey5MBA+6JlRkP/x6bz3GzVZqK5ZWIGWXUknk6BzCqqihLQ/QJ4hKiSkNnzwNnITlknIBRdN5jiAme3xQsoVXbRSe9ZX6g4H+7UtJeE8HWuHlIVV2zKBWSHoazpt68W6g9+Kg7IMqxq0PdokvGnnXIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832021; c=relaxed/simple;
	bh=/jjYyUiuudx18VxvHHOiQdlKHrZ4rlrC9gyDgRJillQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G5GGi8+1XHDWzA7P0Ibfk/BVt/ZW88jbA7gri990r+NGuuCNIChCWAo4L6NYd5PtdRY/Sg4t2p3zTlcVc1uawt4zYcg/vKT32ejq5UBUzokqkmWQhS0jkDXvqtYjFMBQ/UFXS8O1z/hvv41Op88nY27nKWsvhWjSoeijKmQ6UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY6A0mva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53CC4CEF7;
	Fri,  6 Mar 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832021;
	bh=/jjYyUiuudx18VxvHHOiQdlKHrZ4rlrC9gyDgRJillQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gY6A0mvajtKgiSfCie93S2nOkhrl/SJdPejb5a/1m0laP9aK+mN0qZ8gY6pZa3VHB
	 pMXCJOp15fbOAUhBsX0CwjrOW6+qJh/CF9D2Xgp08ZWH2Nd+Bt8dBpjnbTt9tyjGs/
	 mX3Zcs/doidHBaYVZVnhqHL1EzXX31b5vAyfPBdSqyyCcRy2owPWZsjATh600w0THy
	 vVAYeAZ019CHwELtl4u161vb5Ck9sVKhvB1v9pEghcAK5kxYrPT6mYiEaPKAco2qwu
	 QD5+DLxIMW+KmswArVRNYpg9uFV+D+g9ULAtDyO2+hD9b/I5dgnGpbVUnH70+EKImT
	 m5/6Z1gMkfLFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1AA3808200;
	Fri,  6 Mar 2026 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests/net: add netkit container env
 and
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283202030.56009.14147672888349536135.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 21:20:20 +0000
References: <20260305181803.2912736-1-dw@davidwei.uk>
In-Reply-To: <20260305181803.2912736-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, joe@dama.to,
 weibunny@meta.com, bobbyeshleman@gmail.com, sdf@fomichev.me,
 razor@blackwall.org
X-Rspamd-Queue-Id: A3E95227E57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264923-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 10:17:59 -0800 you wrote:
> Add a new Python selftest env NetDrvContEnv that sets up a pair of
> netkit netdevs, with one inside of a netns, and a bpf prog that forwards
> skbs from NETIF to the netkit inside the netns.
> 
>   NETIF           = "eth0"
>   LOCAL_V6        = "2001:db8:1::1"
>   REMOTE_V6       = "2001:db8:1::2"
>   LOCAL_PREFIX_V6 = "2001:db8:2::0/64"
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests/net: Add bpf skb forwarding program
    https://git.kernel.org/netdev/net-next/c/01748996f649
  - [net-next,v3,2/4] selftests/net: Export Netlink class via lib.py
    https://git.kernel.org/netdev/net-next/c/68ab8ba92775
  - [net-next,v3,3/4] selftests/net: Add env for container based tests
    https://git.kernel.org/netdev/net-next/c/3f74d5bb807e
  - [net-next,v3,4/4] selftests/net: Add netkit container ping test
    https://git.kernel.org/netdev/net-next/c/37d24994a7a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



