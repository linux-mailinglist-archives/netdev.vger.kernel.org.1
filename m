Return-Path: <netdev+bounces-259191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBEBOCsWlWkELAIAu9opvQ
	(envelope-from <netdev+bounces-259191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:30:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05A152874
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9D6C302FEB4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3D224B12;
	Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENi4CT6J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B92045AD;
	Wed, 18 Feb 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378215; cv=none; b=mi8AfgPuK1KxZRPfD3Jk/Ibbq0NSPm1mjSpA8Ye8Kt24aMSklnBuWoRiSuIdDUIx301D1GELBTy8oA5x1xwqaFLyRsUxaONKOmGr/Z8v7Elt0/nsP2YV6TpckG5JeblA7AO1aIrG/0n/20ecGc0LTyeLviGh9+u4XEKl1Tpu7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378215; c=relaxed/simple;
	bh=xkxgtwOqTuscVznoPfqbn+834pLIXjwcEuelZLOm+HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FZNZO/HO8Ircrnj8ZNptoAaAqMCRVeQ8BJw1ONiSEO2qoQ1rD0rMt3jdQ7G5nI13kZLaUdVw9zaudE9LeISngvKP6I3YMzAZn8/SDUmLYH5tFF+1QuhjRSGq/q/s1b+HCTqlzQL4egKK4Ojd3awoNH/YclwvHghP03ye+bQMvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENi4CT6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A4C4CEF7;
	Wed, 18 Feb 2026 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378214;
	bh=xkxgtwOqTuscVznoPfqbn+834pLIXjwcEuelZLOm+HY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ENi4CT6JlGxice07AIasrPLdRak58LNBs/+TUaGv646F/Vze35eGVEOntTXdspALo
	 VwafnERMnImcSBQQpHDairpogMeLcpLMRAIJJmPkiyyDCHtqjzrmsOyahoTOuWhUuc
	 c4msPLW7c57/f3PFdfKGlCvE3UuoUz7fqAd625cRGbwlNVJBkVJAe6zpH2kEAkUa+w
	 6E8Q7/7OPk4kWXIRqewBotGZQmpHkik7We7/EgAMr4tPCTFRhUcANWwwIYlnFhFmKq
	 0fSoyp0sZay8mGR3EDzB7HhapLRGeKhep++ZFXNLObzVBHXJLHfzxzUhdmiZzcxPY5
	 KdmfcvjFTDVxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 853F63806667;
	Wed, 18 Feb 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock: document namespace mode sysctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137820633.768688.8259297791486279198.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:30:06 +0000
References: <20260216163147.236844-1-sgarzare@redhat.com>
In-Reply-To: <20260216163147.236844-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, skhan@linuxfoundation.org, bobbyeshleman@meta.com,
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259191-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A05A152874
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 17:31:47 +0100 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add documentation for the vsock per-namespace sysctls (`ns_mode` and
> `child_ns_mode`) to Documentation/admin-guide/sysctl/net.rst.
> These sysctls were introduced by by commit eafb64f40ca4 ("vsock: add
> netns to vsock core").
> 
> [...]

Here is the summary with links:
  - [net] vsock: document namespace mode sysctls
    https://git.kernel.org/netdev/net/c/a07c33c6f2fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



