Return-Path: <netdev+bounces-271939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDc6EfT6xGnz5QQAu9opvQ
	(envelope-from <netdev+bounces-271939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:23:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF133237C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 166E930423D9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3F3B2FD5;
	Thu, 26 Mar 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBEjJSu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FB3AC0FA;
	Thu, 26 Mar 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516218; cv=none; b=BcdReD8Extz/ngMz4OAaaGc4YQS8OVd3CXHdeHH93WntiJ0hI6I2U4PyjiutmfN/Y8A+gwpup2kgFICofGXOx0XdU9XGXjJ7mrQSM437aL0dSYHhLw3wUKyv3Nuf7AZuhSOxKMkhS1nhDjBwj21+BE6h+uWMGAGbE4CQehfOQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516218; c=relaxed/simple;
	bh=/1xRfd6xXT565etnvNqkfEEgLZJv7ZZbnDsBkKOaf1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8+IZN55XW6Ensjnqos9xxpL1YxmvJmTXTZSkOgXKi/chc3q4jXctIYQkQhczUf8weBYu9AoUx3ySF6Kr7GtRyhEGiMo/6U29z3kgKSMyKBXJk9s9tmr/sL4p04APySF5iyl5MrQf0O6t1JLVQTj91Hj7UWTPnyQuOb7j4QafHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBEjJSu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422EBC19423;
	Thu, 26 Mar 2026 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774516218;
	bh=/1xRfd6xXT565etnvNqkfEEgLZJv7ZZbnDsBkKOaf1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBEjJSu6vUj+TDp1IJRwJXWKLb0TYeuUeuqMIwGmh4nfq9Ltey4x5dU3Et8tPQZAP
	 OrdgA6MzKyL0T8pP5/LF5YeCNO+qGHAXQd5D2f6Yak4Ew5Oq/bzaUsrjq7Zp8iPDjw
	 GxREgMOFWlHYyJZ+7M2+Lpw0VQ4iMzNMoh7HhCtB3p4rCrKknDqnUwYu79SUHa5D1I
	 OlRQvbTezqif2QWio10hv/w2STk1Swc7tBgPXTfxMjnO8j7K8xNQVudSPKxqaVshAt
	 RcPERg5iZypSzS61kvlDFC17fp5pnEIa3asYmJW6npWmP5aeXduP/OZ4daJP8Nb3hy
	 e2F5wfZ4u3Uow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF33809A1C;
	Thu, 26 Mar 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] TLS read_sock performance scalability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177451620504.2447831.2574474654524015767.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 09:10:05 +0000
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com, hare@suse.de, alistair.francis@wdc.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-271939-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 60DF133237C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Mar 2026 08:53:22 -0400 you wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] tls: Purge async_hold in tls_decrypt_async_wait()
    https://git.kernel.org/netdev/net/c/84a8335d8300
  - [net-next,v5,2/6] tls: Abort the connection on decrypt failure
    (no matching commit)
  - [net-next,v5,3/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
    (no matching commit)
  - [net-next,v5,4/6] tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
    (no matching commit)
  - [net-next,v5,5/6] tls: Suppress spurious saved_data_ready on all receive paths
    (no matching commit)
  - [net-next,v5,6/6] tls: Flush backlog before waiting for a new record
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



