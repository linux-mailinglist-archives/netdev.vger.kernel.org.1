Return-Path: <netdev+bounces-267043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNksFtSxsmmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:30:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A28271C8A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B4F93003808
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A82561A7;
	Thu, 12 Mar 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRra3OIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70686214813
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318610; cv=none; b=VGCvGbERw5zVg5VWI5LE6zLK5jf/yOQQRFMVKdZ+qVJYl9PpX63AkSeqPnPsYNN8YXb25bp6hZm5Vf2l8OkJggU5Yc1wx9lepVNnaaCpE9Ra+NVZ2MGhjnOpCa7gBp6wLAuQZgV09v479LJHMOqroGsFLfjRgOIGGVZVXAw7dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318610; c=relaxed/simple;
	bh=Tx6ej+Kd2q+KQQaF8xKc5fehsusl7blKbd50C4SGxk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UVYt3t6t5LNqSq6asS6QWgo8kqlYA/ZmdC2MnWlgsh0kmV49Z5bO2v6aioIVih2Skwnm980QQbrBZA8e0EVwEMQCsa8hds2jx+2MiJJgZ34z145zBRB1f25fATIPuipe1V+UKcr9zgsaLdxQTBXVy6WHfyCPYgEmeo09a8kGM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRra3OIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1117C4CEF7;
	Thu, 12 Mar 2026 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773318610;
	bh=Tx6ej+Kd2q+KQQaF8xKc5fehsusl7blKbd50C4SGxk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRra3OIEImjCmMJGrmMmjUX+bhV/kXckF7SnC1NcTvYvNnBNevifLJ7eJ/WILaGu5
	 BynD7rWMlpj+yO+DUqAr1qjdLRvjGEXfNVDCYwZkomPNbUgL4bosuEkmEmfxp9hoK2
	 FPDN9qdCGNjMv6DGwWuNAWmeas9eS1lCaBVI23zsiJsGcpQVMcc8Slck4tU/MxYbhg
	 zorFAVpx94SF2im64PgamMVG/D1RxAQx2NHQWsfAVFAyyzgWhnEUyS+PoD4A7NzaOb
	 1qRP/v76ArIs7lPSps0umYLC8arH+IkqVBi//2WKmQOpGT5q97TGeoOLTFG+ZuA3jg
	 mlrNm9KgN3FEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F5B3808200;
	Thu, 12 Mar 2026 12:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add tcp_release_cb_cond() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177331860555.4080191.1012052892372259312.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 12:30:05 +0000
References: <20260310124451.2280968-1-edumazet@google.com>
In-Reply-To: <20260310124451.2280968-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267043-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04A28271C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Mar 2026 12:44:51 +0000 you wrote:
> Majority of tcp_release_cb() calls do nothing at all.
> 
> Provide tcp_release_cb_cond() helper so that release_sock()
> can avoid these calls.
> 
> Also hint the compiler thar __release_sock() and wake_up()
> are rarely called.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: add tcp_release_cb_cond() helper
    https://git.kernel.org/netdev/net-next/c/6f459eda8b60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



