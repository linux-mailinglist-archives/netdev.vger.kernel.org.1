Return-Path: <netdev+bounces-255327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oETDIPRtfWmTSAIAu9opvQ
	(envelope-from <netdev+bounces-255327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:50:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A5C05AB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF60E300AC16
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DF2F60A3;
	Sat, 31 Jan 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ornCnMYZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BE2C21EC;
	Sat, 31 Jan 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827826; cv=none; b=ZSvm4u7L78lKzs7xPglE/dAc+T6AqTEqFd/jsLG3GTTx650QKqaQxwlMPt/EwRNFk2vmw89JvWvq80angbOrEm8yVxJYNnMkln6pjUTAVxGZWKZ/q24wDNMZzB72AsuDF96IHYM36ioY92UaUFGx5kfjWJBGWsX5muwO5V+Tu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827826; c=relaxed/simple;
	bh=/dJnqf13LmHgY8fbi86UB2L04yU1n3qwTzSKl+mpZlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ThrsyLvAbA2/LtfB+tM0FDwbWG0L9BcfqOR4oVZL3RRhnN+S8uni3L62AIqGw3h7G+qe4AcX4X4WsGKonhfZskiq7eEiIRSekSFe59BA5nTrNYXhrxFkosCX4P7zoIQEiZNNX7d5wAODoA1IOJAx2e75Ty1TascJ6iADpWNwoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ornCnMYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA6C4CEF7;
	Sat, 31 Jan 2026 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769827825;
	bh=/dJnqf13LmHgY8fbi86UB2L04yU1n3qwTzSKl+mpZlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ornCnMYZ47kIYmdOyuH8NGnFYF+5UY8Q0sN/E/GSqoDL4aU6EkwvvFxZL4R/z0Eq1
	 uS/EXlUtuHXh48PQG82YuMplqwPVrPtdoW47SqLaTnhwSXzUU8ulfXRfCwlggwvO/c
	 JprNF/abPrsAEINW93731OtzHgk4TYKStGnqENwkmGhADpU7gDKIxMeMs6Dq2CD8DZ
	 gQWTwXJdsQa+CkjT0SE/EPH0uId3RNQXa/A/k6fMyPf/Wb1v+vC0Lw94p0kCoN3dZH
	 ecbxL0Kcrcdz8xqMYJsIflCio0gKDow47H5V8SX3mWMDZnowzJJWijauK4hgZLxVTd
	 4ekkYN6poktVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BFD380CFFF;
	Sat, 31 Jan 2026 02:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] eth fbnic: Add debugfs for mbx and tx/rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982781785.3974876.3426939571454500276.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 02:50:17 +0000
References: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
In-Reply-To: <20260127200644.11640-1-mike.marciniszyn@gmail.com>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255327-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 004A5C05AB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 15:06:42 -0500 you wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> This patches adds debugfs read of the firmware mailbox tx/rx
> and of the tx/rx rings for each napi vector.
> 
> Mike Marciniszyn (Meta) (2):
>   eth fbnic: Add debugfs hooks for firmware mailbox
>   eth fbnic: Add debugfs hooks for tx/rx rings
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] eth fbnic: Add debugfs hooks for firmware mailbox
    https://git.kernel.org/netdev/net-next/c/ac7b803c2dd5
  - [net-next,2/2] eth fbnic: Add debugfs hooks for tx/rx rings
    https://git.kernel.org/netdev/net-next/c/df04373b0dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



