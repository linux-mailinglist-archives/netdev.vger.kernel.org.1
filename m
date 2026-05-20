Return-Path: <netdev+bounces-289719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIaJBckaDWo5tQUAu9opvQ
	(envelope-from <netdev+bounces-289719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65E586D0D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F9A30479DA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7F29B79B;
	Wed, 20 May 2026 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCzwoCqy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF117BED0;
	Wed, 20 May 2026 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243595; cv=none; b=T/KxNex8wBVUa15q/yqfYaUuXdYMhqZvHXe8ur6oJxXfIGlZdSwlMCRj3pVd+YLJsilgfYcPMGc/7XHwpzmqEUo1FCe2DKucF2H+hEu4EzO1zqGRKYu0qO3HghD4kFCaQrsOPi7dAu6JMzt1KIHmc9gNxJIxN6mRcvUVW5zvRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243595; c=relaxed/simple;
	bh=okPCJZDFOA+hZpRp/uWWkg8pW1ClQ6MBr+kNRzZSrEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbSyt+rI23/LKw62EU6zHcKmGCa9XXmPU6ByHmwH2uvrwcO95/H0g1hFzI35FuKpbWzavowo4YP3TiKLsHISLqwXbyZ743wkdYqJdGx1i/LSQq8eMBLKgBJnEOZq48aIMEazNsgySPZGlQ5OpohfUK+wqGE5hWHljCz0pGgcT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCzwoCqy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8A1F000E9;
	Wed, 20 May 2026 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779243594;
	bh=+uiilYgxo6bsmcQyug6l6SMDBxOKEtiJiP+RCh0Sj0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JCzwoCqy/EZuL5fSs6Xtt/R2LwObUZETnKC3vD+5iLCnahr2G5Z2OiGy3fSdz+zEC
	 nchdAFUnvA9NIqq6+AhOjU8U5ZbyAl5+u7eUh6eYJQ8zV0AVqyPiWXjEnr9oGZzUV/
	 dFF6rjJzIRPcE8ID/A6l2F3JsR996aiFWf4p0ZjyPQyZKhRIiqW3itmrkwU4W/+A84
	 aGmf5mSY3OosAmqbKV1MVPV9i0TLzEbhnP4ChH+JKwe755dFK5fuLdoWkHl2SiiVpm
	 NEAB6OkNFIFDWg0/q1KzwwqDGxGhK1UiF6yx10R78BSPe3PtZP6oMCRwVh44oAUQGE
	 ngPwiGQA3AskQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D3383BF53;
	Wed, 20 May 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] net: airoha: Fix NPU RX DMA descriptor bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924360515.2953435.16053845694488333634.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:20:05 +0000
References: <20260518134530.3683-1-ansuelsmth@gmail.com>
In-Reply-To: <20260518134530.3683-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: lorenzo@kernel.org, kuba@kernel.org, nbd@nbd.name, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-289719-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E65E586D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 15:44:57 +0200 you wrote:
> In an internal review from Airoha, it was notice that the RX DMA descriptor
> bits and mask are wrong. These values probably refer to an old NPU firmware
> never published. The previous value works correctly but it was reported
> that in some specific condition in mixed scenario with both Ethernet and
> WiFi offload it's possible that RX DMA descriptor signal wrong value with
> the problem to the RX ring or packets getting dropped.
> 
> [...]

Here is the summary with links:
  - [RESEND,net] net: airoha: Fix NPU RX DMA descriptor bits
    https://git.kernel.org/netdev/net/c/0cb5a74faa3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



