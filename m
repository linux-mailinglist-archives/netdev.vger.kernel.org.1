Return-Path: <netdev+bounces-266891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBQBGEUzsmkuJgAAu9opvQ
	(envelope-from <netdev+bounces-266891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E126CCA8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 606CF301394F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1C31E84E;
	Thu, 12 Mar 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avoQawPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AD282F18;
	Thu, 12 Mar 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286211; cv=none; b=HqjIlOJy0ve8nu5aquvt9Gh7QiAAISuvgZFMaci/9qYa/SGXFf6cIwktt2BO8qXrke5fBF5QmEChgxjFi4O2lTdFbxRzYkA+oquKVm6YWckWMwjkqHZmndTs4OS2hTQ+BsrE8RrwbQxn6TGTzaDYxe208Niux4II65DxzSRtPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286211; c=relaxed/simple;
	bh=Ks5LhpJlfawDaxNlujGegTgFEgSnXfcwDeud4KfIJao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BinzDMfEqlwaQEVheOV7ntnvHxyCKo5nQvdHX/+EDpQi3yjA7mzPifanjR5nknzWZlSRI1nI2XiFXWBcD6k7pWyF3y3rXaiyocIfsPnI3t0fIz5F7zqAShFN+tbjYqqmAmXcoEZ3SWIDXNdPWLB6IXVKSlYUdhooNhTh4VBTFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avoQawPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81333C19425;
	Thu, 12 Mar 2026 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773286210;
	bh=Ks5LhpJlfawDaxNlujGegTgFEgSnXfcwDeud4KfIJao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=avoQawPDewBEKkl8CqHbHESGEhWHvTIFC614Bb9S1mJJiEgwc+g6rFvIlSDQgMLjo
	 a58bYLJqDaOhdO3ktdMy9ZwG0XV7PJMgJ7qBNsemW6HLeJZ5MYS49yN3j3WDDlCQQK
	 EEJJj4bj3aF2hAN5muzAPgEo+lWyiaJjk0KPDd5WiXVwVVvJq7m0hPbgAatsz8KTF6
	 k7p0jW3Ey5OOgRQXn/YLZJ5bahUUrzsX/Hy98vxtoQqjwB18VmxUG0Zl8nHlLcFggF
	 2uuTqlG/otXCMi/0p8GzVX+4ryCM08uB2MJVQXIVLtTj2RUV4M87vR0dclM7ugh2dV
	 i59GJ/cSo6Prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA23808200;
	Thu, 12 Mar 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328620599.3925958.840926397317769429.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 03:30:05 +0000
References: <20260310012604.145661-1-atwellwea@gmail.com>
In-Reply-To: <20260310012604.145661-1-atwellwea@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266891-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF7E126CCA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 19:26:04 -0600 you wrote:
> Commit dd23c9f1e8d5 ("tcp: annotate data-races around tp->tsoffset")
> updated do_tcp_getsockopt() to read tp->tsoffset with READ_ONCE()
> for TCP_TIMESTAMP because another CPU may change it concurrently.
> 
> tcp_v6_connect() still stores tp->tsoffset with a plain write. That
> store runs under lock_sock() via inet_stream_connect(), but the socket
> lock does not serialize a concurrent getsockopt(TCP_TIMESTAMP) from
> another task sharing the socket.
> 
> [...]

Here is the summary with links:
  - tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
    https://git.kernel.org/netdev/net-next/c/dc9902bbd480

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



