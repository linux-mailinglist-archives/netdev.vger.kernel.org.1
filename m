Return-Path: <netdev+bounces-287425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPoHe30A2rKBAIAu9opvQ
	(envelope-from <netdev+bounces-287425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:50:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADF52CFE9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76148305C019
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B933A1E9E;
	Wed, 13 May 2026 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLi8MPMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49833A256B
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644002; cv=none; b=WcAZItjHYj65qDSnakn9mpwhTRyafHkV5Nqgpl1EBLMysEP0pVY2j6nxKQp3IxWuJumletlGZuLGn/LaQFDRr5MQQFBm5oBSGs5zNw4ol0eXB0BI3gUXHnfr+SC4a2EPRTQr7+PCh8Eo7+SQz5nnXGfa8m7ebtskCLjBOrsyh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644002; c=relaxed/simple;
	bh=lLLV4GZVdWHB+PFC7+PErUWf6Jr4HoHhUNv1lODe+aA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hmKOdtEh8sZE+/Wn1TCDSTWGBII9bEz6VKF7oWoIO8TpW2MBHjy9conRolGTSim73ikbaODxsR0LqyIxBD5+jVwBFdkIXz75LW5iqukt3ssV+2J7IoXTHn2eGkT/zbchtBwh2rjJFsN9Quergj/8XYDgvuGABWszILSZhRf/2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLi8MPMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C55DC2BCC7;
	Wed, 13 May 2026 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644002;
	bh=lLLV4GZVdWHB+PFC7+PErUWf6Jr4HoHhUNv1lODe+aA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLi8MPMMhLxIfGUhbQ7vUcQxCCUNVDhNgetIp9QfhzCyeYxciw4koZCPGQaKsQWBm
	 FdcTraWZ3Ijt744rkpE+zP144lkDoWEdRvBf/Dxk23xEiRvaQmWZr4M82brRmZJAuF
	 jj4FgdgOjGz92hC6BpM8HCMW8Q89FDlJU6FeEeofDqSpHX+uLefb97OZzsUrTsuncY
	 vLhiR0Gy+hAG59Ro0Ww22QxeZE1BxrGvwbv73NrTEFL9JkGA1NhhOGMuTrn6ovArox
	 kNL1rDd0R66A7yYPFEgK0B6KXHTw7KwI9W9dS5Z/6WV6WXp15RETzNspz7Fxg0uov/
	 ho8HUck2MCMuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD103822D60;
	Wed, 13 May 2026 03:45:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] net: use IP_OUTNOROUTES drop reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394798.3173643.8934700558237549763.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:47 +0000
References: <20260511072310.1094859-1-edumazet@google.com>
In-Reply-To: <20260511072310.1094859-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 78ADF52CFE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287425-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 07:23:07 +0000 you wrote:
> First patch changes sk_skb_reason_drop() sock to be const.
> 
> Second and last patch add SKB_DROP_REASON_IP_OUTNOROUTES
> to both tcp_v6_send_response() and inet6_csk_xmit().
> 
> Eric Dumazet (3):
>   net: constify sk_skb_reason_drop() sock parameter
>   tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
>   ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] net: constify sk_skb_reason_drop() sock parameter
    https://git.kernel.org/netdev/net-next/c/5c4b709b5fc1
  - [v2,net-next,2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
    https://git.kernel.org/netdev/net-next/c/254084223f93
  - [v2,net-next,3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
    https://git.kernel.org/netdev/net-next/c/4a64f9732577

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



