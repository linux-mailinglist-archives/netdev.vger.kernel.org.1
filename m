Return-Path: <netdev+bounces-254534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCvvN4jZemkc/AEAu9opvQ
	(envelope-from <netdev+bounces-254534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:52:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048DAB84E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB56304D946
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646F3644AB;
	Thu, 29 Jan 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubRVn1Gl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8E352F84
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658635; cv=none; b=fjmfkPhTAYFVJxvEU97icI1kz0jSSMEYGp1py+GvmBdFYhD8muEI0h14qoLr+dSbthVz3am/SLa7aYIHhBe5jVwbefGyX2bksRI5cSMs/MeIhNxRBuJ2Fnyo7atmS5FwsO2vrrHMs+y3t8v4SVB7+iMOhap8D1FlBL+vT0wU4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658635; c=relaxed/simple;
	bh=U5ZIWiUibVtatpIhBXSuxPuqVze7NOt31mxYtln1czQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lFPgsyfedUUalPfgCafigQXfbXM6ZqfyFMjKes3U4MWmeh9BZm/Ss4+annfOjRuJIz9ORsnDXqh65MckXTrWgtivoRZ0UX8rdub/GGDp/ETs9kIz8+gfx6QOFU8yHZvNPhlCLGpnYHnOGH62Mz1yPWSjzizy10WzLzw13qtFUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubRVn1Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A18C116D0;
	Thu, 29 Jan 2026 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658635;
	bh=U5ZIWiUibVtatpIhBXSuxPuqVze7NOt31mxYtln1czQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubRVn1GlNPrI2GJPq5+uNeETEPLcRjixaL8FPhRKqo+n+GJH+zDOd4u2k4Vi3+y2x
	 /xZwVKx4LK7B9uMfqurhY9QA28Fx/RPdA5X4izoc8h4llWK6cbayziWvaEpVN5pUM8
	 4gNkuDS9D7zzgFMA5j1OYmSIF+JmnO4IqjPetr2fefvr9H3Vob9fTk9H44H3nY5HIP
	 n17FAh7RuIuiw+oW0/C8N7IedGPeFherFZfpaLO3ijXA4aYBqOwOkkSXXYv4Korkik
	 oET0X19EOzgc9cJKEhHld9WLI2JFqidovpxDlWFdoztbKIeBj5hPwU09yb0l83zaE5
	 Z1OID+umVWvpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B1D380AA61;
	Thu, 29 Jan 2026 03:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv4: fib: Annotate access to struct
 fib_alias.fa_state.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965862859.2339773.6279218479886130560.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:28 +0000
References: <20260127043528.514160-1-kuniyu@google.com>
In-Reply-To: <20260127043528.514160-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254534-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d24f940f770afda885cf];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5048DAB84E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 04:35:24 +0000 you wrote:
> syzbot reported that struct fib_alias.fa_state can be
> modified locklessly by RCU readers. [0]
> 
> Let's use READ_ONCE()/WRITE_ONCE() properly.
> 
> [0]:
> BUG: KCSAN: data-race in fib_table_lookup / fib_table_lookup
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv4: fib: Annotate access to struct fib_alias.fa_state.
    https://git.kernel.org/netdev/net-next/c/6e84fc395e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



