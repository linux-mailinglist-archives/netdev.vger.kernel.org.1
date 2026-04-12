Return-Path: <netdev+bounces-277837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNGWCQLJ22nzGgkAu9opvQ
	(envelope-from <netdev+bounces-277837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:32:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797523E4CCA
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BC94300E26C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9622DF128;
	Sun, 12 Apr 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EklKjrxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A772DC331
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011515; cv=none; b=Zj8CHgEG9Fskbv5QpjrQQE/0O4PnwDXZG8dbRIFE69ToMoQzt0DCvrSKFaJiSKT9xxCru3E5hE/c0cGvynRZzhZri0OkNofBAqPwqqYZd7FOPb/3voa++YpXAky3z/ulSQLFC761h9eRrZ59QknLaOlPERz9niVpNieOApMMuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011515; c=relaxed/simple;
	bh=dOQAwQbJ926QxaYVtg+aBNlAOK7kMW6PV1jIiTuRefY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRcOWWXJ5rNWQYAueqmi7xGaYhq2NJ4j5oLDODipJVWmz716O4RhMAs238mVjw1i32cX3ClqRBzINIhjTaTi4waHkDzM/RVTELWDoz3ZNmOfXYHThRdUY8Ae9RqA03M83J+RAx8dmLIaeA+94o31FhzPjUbF+HgrlbDcnvvXPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EklKjrxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0898AC19424;
	Sun, 12 Apr 2026 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776011515;
	bh=dOQAwQbJ926QxaYVtg+aBNlAOK7kMW6PV1jIiTuRefY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EklKjrxuoT1y+R0BEkdukdPTcHmAeD6HSIeL1jq7l4xW3ldlGGdes7Uk+zdSXeuGs
	 LRP+KsLTZWDX6DWKqfAgxSELW3O+aqmRl+ijNWUAQFO5tNbouEpq9D4zTOvdQO1ZT2
	 S+su/2l42EJ/SPnZ3+lR1ALv6jEM9g6oxTP6EC1xtulRAcHkuV6fspRMpm23rPDk1s
	 ZNVDMZEbOgP0ivUl9mSKhsAovM4To0MuJGl9DeVQUc+geZv/njOkvjMQVtsDXDKz6o
	 lOmfaCQ0TtUic7mXtc+ajZWYsOnt0RLb6cg2dUrtHxnG7/mKqDFe5/j8Xn7pLJsh+9
	 aEmp/4P8OL52Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E593809A8B;
	Sun, 12 Apr 2026 16:31:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add indirect call wrapper in
 tcp_conn_request()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601148729.3334175.1056015934299538224.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:31:27 +0000
References: <20260410174950.745670-1-edumazet@google.com>
In-Reply-To: <20260410174950.745670-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277837-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 797523E4CCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 17:49:50 +0000 you wrote:
> Small improvement in SYN processing, to directly call
> tcp_v6_init_seq_and_ts_off() or tcp_v4_init_seq_and_ts_off().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h    | 6 ++++++
>  net/ipv4/tcp_input.c | 5 ++++-
>  net/ipv4/tcp_ipv4.c  | 2 +-
>  net/ipv6/tcp_ipv6.c  | 2 +-
>  4 files changed, 12 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] tcp: add indirect call wrapper in tcp_conn_request()
    https://git.kernel.org/netdev/net-next/c/29703d7813f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



