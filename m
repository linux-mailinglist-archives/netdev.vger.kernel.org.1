Return-Path: <netdev+bounces-260294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ6FHYcBnWnhMQQAu9opvQ
	(envelope-from <netdev+bounces-260294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:40:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892E18099A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC5C63077749
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBB2135AD;
	Tue, 24 Feb 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdZG6rrI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABD70810
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897206; cv=none; b=csRIz7USTxLVcyMkQ7MRweXtZjVzXDUJL2SoZGN6m58zcE+iqKU6yZuV73M9z0TOxgdQaBcRclmDnqnryUw1wuZxYgK0UXb3pkTa0YNj/N5Prfw15JiR1zYM/mtsUOa6snTXE+/EYBS6GrFXuUpwIQZsY7ZYZuMtoE8h+FPLg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897206; c=relaxed/simple;
	bh=xWP2G+ZUYzny6t22HR6ufbY7+zMP5/vmpdQLO1dQDUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bkyCaPpjJeqhBa3oaCqBS/sx2i/qsePIX3n0hxeMV2S1WjRCf2HszGnEg/e1KGpcM7YHJdbAckS+sqYiwRwpyOGhgebithT7j/HKpfqBM7HmonXkWKSwb/gsAw+jyMG0CEKTJMh4xOjWIgHuc7tdnhIYdYOZOU6KbRDezAE5lBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdZG6rrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3834C116C6;
	Tue, 24 Feb 2026 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897206;
	bh=xWP2G+ZUYzny6t22HR6ufbY7+zMP5/vmpdQLO1dQDUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hdZG6rrIh2yUyya7L0SMEx6EQEdhzAikhP0WtIl3+zf3p5qo+RJt1pT73ScNG1KEX
	 W7n4KbdfL9gpM6a0mEPOoU7GntV0cNzLBpv0NnPsceCJfVLn5o0I5BGxp+n27Hrdfk
	 349F9dEZtM68mYcjiXq+cRlun2UU4Li5qyaiY7NPS9UBzGS0YpTGwkC9awaFErPrxm
	 ffpSj7USTDizlFBN6DujyfQ6iLAgtEODQqqAcT7lpLpgckLv+UmGPhND19CAEdZko3
	 LczNup49hHbFbnRuRylurTQoalCABUpKqCOPgx50WDGvXjRR6uAMogC/9tQT8mH2q6
	 zUjsLbzxGkvhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE193808200;
	Tue, 24 Feb 2026 01:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] selftests/net: add test for IP-in-IPv6 tunneling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189721178.3267776.14622583690321996801.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:40:11 +0000
References: <20260221114806.1231666-1-git@sphalerite.org>
In-Reply-To: <20260221114806.1231666-1-git@sphalerite.org>
To: Linus Heckemann <git@sphalerite.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, liuhangbin@gmail.com,
 davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org,
 kuba@kernel.org, morikw2@gmail.com, pabeni@redhat.com,
 syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com, rbm@suse.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260294-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,syzkaller.appspotmail.com,suse.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0892E18099A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Feb 2026 12:48:06 +0100 you wrote:
> commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
> __ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
> (and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
> for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.
> 
> [1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [v4] selftests/net: add test for IP-in-IPv6 tunneling
    https://git.kernel.org/netdev/net-next/c/f77c7b960144

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



