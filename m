Return-Path: <netdev+bounces-284168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O0cKnxU+WnF7wIAu9opvQ
	(envelope-from <netdev+bounces-284168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:22:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551174C5F82
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E9C304224C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E643A0B13;
	Tue,  5 May 2026 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6kEzsL7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8039DBC4;
	Tue,  5 May 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947678; cv=none; b=U5EYgqAucqeWANSoqL7wjZqpJZOx+OISdJMBeFkFme3i3EBJvVPbnQRAsVuBj7V7pQsMawc0xAjDy1lgiwaoOi3XLiHC5SwB96lqm7Ke89yvvyPyXGiwuVDy3fqVfFjOjFAosT9EO2p0QIt7GHc/fJA7dKC0TH+nY7SWp8SLo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947678; c=relaxed/simple;
	bh=bYhkAcikBiv1KZod5juc9KxZiomx82Lk7KuLW7TR42g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rhFGGS7AzchuYDzBIAB0ysRZQDKGvbtLgkE+u1L8Q+jwHyUDA/PaLSKGYexA5J/TVeARj9XRZ75/zUMTOO8iwuyxmBT4P8qMJ7YI+LMJ7ahv1EgksmWbAcvni5NYHd7gkaOgQCuQACf0+n3jGb/lCpXtLyK1o9Se3vpu53gGmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6kEzsL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19ECC2BCC4;
	Tue,  5 May 2026 02:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947677;
	bh=bYhkAcikBiv1KZod5juc9KxZiomx82Lk7KuLW7TR42g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6kEzsL7zX+2StBbyMxIFjVqh4ZYXRKtTTAFUNg0gsDxsv08Q3fHy+WHxW+wPXL0w
	 y4aeYu+Vr0nvf6U/sv0HT1DXRglkRu8cIlxGRf3MxtzdD7EERLmo+rQM3GJYJlP3MI
	 zvaSY2DVw+3B+gx6ycxkeU9B7jAR4snzfnJFRg6rs85EQ8usOJJdURg+acruKyXNgZ
	 JNgAQJGHsWPG/slEiRV7/IaA+dra+M1kdswqhFRWpVWMa48eliv/bsMM+XX4n3MLeE
	 sQdSCEtGBUnECNqoUb9/+PSi4QiIzV4qJ8L9LwHwS9AVC509Cq4X/6M01hktrpP+eH
	 cp4P0rlJBYnjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA07B39301A2;
	Tue,  5 May 2026 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: Convert AF_NETLINK and AF_VSOCK to
 getsockopt_iter API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794762829.1391894.2572004770093303829.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:28 +0000
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
In-Reply-To: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sgarzare@redhat.com, shuah@kernel.org,
 sdf.kernel@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
X-Rspamd-Queue-Id: 551174C5F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284168-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 May 2026 08:52:50 -0700 you wrote:
> Continue the work to convert protocols to the new getsockopt_iter API.
> 
> Convert AF_NETLINK and AF_VSOCK getsockopt implementations to the new
> sockopt_t/getsockopt_iter API, and add kselftests that verify the size
> and errno semantics are preserved across the conversion.
> 
> I chose these two socket families because they are probably one of the
> most used  protocols,, ensuring that any potential bugs will be
> discovered and reported quickly.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] netlink: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/390bf43b7788
  - [net-next,2/3] vsock: convert to getsockopt_iter
    https://git.kernel.org/netdev/net-next/c/e21bf72954df
  - [net-next,3/3] net: selftests: add getsockopt_iter regression tests
    https://git.kernel.org/netdev/net-next/c/d39887f55d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



