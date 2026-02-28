Return-Path: <netdev+bounces-262061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOqtOexeomkX2gQAu9opvQ
	(envelope-from <netdev+bounces-262061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:20:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A271C01BD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C238303365B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93C23E334;
	Sat, 28 Feb 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqbR1EIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CDA1DF980
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248808; cv=none; b=XNtugcZRRpq7e+2aqVEHAxl8fRWf8/JP2Jzf3ptLCo0weSeZ8GDi2fuHOgGnHzP6KjPIYCEEcFeAVNyVrdXEhh/xdn3+5uVF8iqpH+oT4V3W8K/NNrt28bpmnEyUQgePbXBCdkRNTAkGVjWqPlCibls54uV6RInra6cO+FMZfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248808; c=relaxed/simple;
	bh=0K3ggO4fpBOT+5Gyk2nsEoxMv9aDTJ9vJMAYCgul7Kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kfdl563JhXOTvgJONkl6X8ziKzJZAzSZwp4EwSvvuCvhUwxDndHjhxZqXCdsq66FTPO+dmGgqzuQZuwdc82VU7P39naVnuefRXmaHvl5lwlgOhniVfo/8/R86QE0d2xPU/AzBqg8+hcrJShVLlB/jkmmKZGVNkg3IyTsczCStOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqbR1EIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15A4C116D0;
	Sat, 28 Feb 2026 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248807;
	bh=0K3ggO4fpBOT+5Gyk2nsEoxMv9aDTJ9vJMAYCgul7Kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqbR1EINC8A40HR7kzCy/hdtILy3uQcOd8OTtZfod7ik4UxAaG3twNcz5/rskPnQi
	 FWhJW8qR03+qhNCUYvhSKTua7LjbmkWuBamO24w69a2TW2erYlVVnMwZfD3NlTvzUV
	 l2YKkqTTJfWlL+J6D8duK9x2t5P/yh96YGBAn6OVQBOh4q5mWMh4MJP0t9+/XnM8ff
	 vhi2mpffthhXVvg1g513iwDDLsbnpBg+Ie2ki5VWKLXmrd45dzlJpHXCzb+fKh+fpq
	 dixrb/ZnOESjcPRkl8tAz+SgiliXC+74b219SG4M1v8/DJOfzgx3SYDmTAsuiXNLIt
	 QWNRLj0lBR0Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFFC39EF96C;
	Sat, 28 Feb 2026 03:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv6: discard fragment queue earlier if there
 is
 malformed datagram
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224881128.2851960.13487790635140793923.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:20:11 +0000
References: <20260225133758.4553-1-fmancera@suse.de>
In-Reply-To: <20260225133758.4553-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-262061-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8A271C01BD
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 14:37:58 +0100 you wrote:
> Currently the kernel IPv6 implementation is not dicarding the fragment
> queue upon receiving a IPv6 fragment that is not 8 bytes aligned. It
> relies on queue expiration to free the queue.
> 
> While RFC 8200 section 4.5 does not explicitly mention that the rest of
> fragments must be discarded, it does not make sense to keep them. The
> parameter problem message is sent regardless that. In addition, if the
> sender is able to re-compose the datagram so it is 8 bytes aligned it
> would qualify as a new whole datagram not fitting into the same fragment
> queue.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: discard fragment queue earlier if there is malformed datagram
    https://git.kernel.org/netdev/net-next/c/9ff2d2a98370

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



