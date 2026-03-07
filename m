Return-Path: <netdev+bounces-265012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO/HM7mGq2n/dgEAu9opvQ
	(envelope-from <netdev+bounces-265012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3CC2298D3
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9F530297B9
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2D21D3D6;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6aOEVuv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AA18787A;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848812; cv=none; b=GD2ulD/bJF2LbHlJPXQSCft4f12NL2noX4s4d9jAgXNL/abtv7wIp/hpIdOLhEFu1CuYAq9Mq00l5RQpGB0yWv0XQxLGVR9vvtj6K2hoU+QY3m9rL//uMUbuNiNzUMik7LiKFlzWjVjfMcT/gP+i+ZjVPL+lnfj4Q1RRIX1iUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848812; c=relaxed/simple;
	bh=VijgEdxT0vRaeLpxh7yCMedpS5F6JbxQlXL3z5GtyCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KyheirV5fztDOTeA6URO/ciOPQq6cSa+bzo99SLJJe48yPYRnxifCjruti0O8PKOyy+0cWy4Y/C/hM6tvCwZss2nOF9X2J67JanLVP5lZlDlpgS4F6LYx9/9kFD9QLGm3HV0bCC9frdEkaARsILVdkwNQmDqORyudZDRndgSSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6aOEVuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37095C4CEF7;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848812;
	bh=VijgEdxT0vRaeLpxh7yCMedpS5F6JbxQlXL3z5GtyCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6aOEVuv9hpLjL/6DS4cKXM0zrf+nGPu/aU8fV1ybx+exBoo/0gP1RvcLpSdrkKLy
	 iccdL2T/SeHDvMCmpfeStr+c4iKdoUsZVg0hameWD9qg2PG9YXY+zfGXcx6y2rC6bR
	 hdC83kAlO4Ua9TPc/zR4JtKbAToRS1xJI57IgXhHbbuNj97cuLUBgYu6tbC4XE7FW+
	 nBm9VUpTfV84AcjaIOx4PiXylumKMnqDLS3pVDEZTrIGaH4dMVQnErqDoQYpxdQerL
	 kyNMsdNoHfeTDD7DxfIcIQrzEGybfTzwFjNDgV1PiusRQfx1tM9w0rh1QSY2xeibys
	 fOd05d0i/FjuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAD3808200;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc,
 afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284881104.123899.8488535259917331846.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 02:00:11 +0000
References: <368272.1772713861@warthog.procyon.org.uk>
In-Reply-To: <368272.1772713861@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linmq006@gmail.com, marc.dionne@auristor.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 3F3CC2298D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265012-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Mar 2026 12:31:01 +0000 you wrote:
> rxrpc_kernel_lookup_peer() can also return error pointers in addition to
> NULL, so just checking for NULL is not sufficient.
> 
> Fix this by:
> 
>  (1) Changing rxrpc_kernel_lookup_peer() to return -ENOMEM rather than NULL
>      on allocation failure.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
    https://git.kernel.org/netdev/net/c/4245a79003ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



