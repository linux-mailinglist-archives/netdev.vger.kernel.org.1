Return-Path: <netdev+bounces-261713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNddAO0SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:43:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8351B25A1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A7831632D4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7C333436;
	Fri, 27 Feb 2026 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+lNvoXt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85668333725
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163607; cv=none; b=LS1SyLDQDKqKAFOOljrGb2uoVVFDxJ86YJedWRJVKofKA6YQEjMigJSe580nDPuCYX8InvCFBpPpQ89CBF5hVeXhII+r7nKsxP3fnbxn1/WK1RU/BCcyohFvHBIj64gLPer0tUPJxO/hqeLPTpgczLAMtkGKrQ5Sfog2n13pmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163607; c=relaxed/simple;
	bh=grMY7p7XxH6NyebWLabnHMeEWObzHoPkBdmQOVQOrQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hMnCnyXAry6JcpUAe5MxIYlbQkSjCpPqRj+WoOPAlSJGXNei31+qDTcvUpUKyVIwy5553jt3fbbkvQAnDYDN4hyrztoOj/yLkcmYAw8bHOdTdls1+UEzbNtbsv18op8YxH8qpwizdGisbP7fNeY24yZz90dwCIfmQ2yzP1+p5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+lNvoXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6905BC19421;
	Fri, 27 Feb 2026 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163607;
	bh=grMY7p7XxH6NyebWLabnHMeEWObzHoPkBdmQOVQOrQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+lNvoXtO42peSdncvHjD8v4iU6YpXcdjDZocKfHvhC7Lkcr/ERBBHn7EeYRZIxyH
	 Qc3WgQz/U9Yx87Ft4j2ppo9OGuuPAFFbOsT9V/VnIestoSKerSNpGzcV2Ml/mDokUW
	 Rp9XIiXz7mTHb+bspSXF/LtpHvaVh8ZigH6HqU+zaNP9M+xjGKiKBu9HcJwd9LDmga
	 BgtiBtkzYIIcXeXT+KMWQJGYRC0EV4ncWVIDuMFi/Syn5/JpzDeAAQIJyz8pTXr/hs
	 y3xq83pQnZTanY3qWs5bj84fK35ZZYuydun1Qv1Px4cOfTVQDaNhJ8j4DZMmaOeS2A
	 kjnsh3nomFn8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9D393109B;
	Fri, 27 Feb 2026 03:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: annotate data-races around
 sk->sk_{data_ready,write_space}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216361129.1960351.7747994191402885743.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:40:11 +0000
References: <20260225131547.1085509-1-edumazet@google.com>
In-Reply-To: <20260225131547.1085509-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, jakub@cloudflare.com,
 willemdebruijn.kernel@gmail.com
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
	TAGGED_FROM(0.00)[bounces-261713-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,iogearbox.net,cloudflare.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,87f770387a9e5dc6b79b];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,iogearbox.net:email]
X-Rspamd-Queue-Id: 1F8351B25A1
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 13:15:47 +0000 you wrote:
> skmsg (and probably other layers) are changing these pointers
> while other cpus might read them concurrently.
> 
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations
> for UDP, TCP and AF_UNIX.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/699ee9fc.050a0220.1cd54b.0009.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: annotate data-races around sk->sk_{data_ready,write_space}
    https://git.kernel.org/netdev/net/c/2ef2b20cf4e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



