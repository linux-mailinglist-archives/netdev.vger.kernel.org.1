Return-Path: <netdev+bounces-298066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+paHOOJKmoBsAMAu9opvQ
	(envelope-from <netdev+bounces-298066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9B670B9D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XdTlFu09;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298066-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298066-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8086301B92D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DE3BE147;
	Thu, 11 Jun 2026 10:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89612375ABD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172617; cv=none; b=SI6mnwiTfDs7ZmqNgpGmPqBvgFsWR+miqlzDikD+ofUHiJPSFQjYrb3eYo7S3vLORBkaa0HB5SU214etpFEvP/lzUKJsbFiSJvvijfUV4y3R9hUwBXqCndCPRMlSUj9BoTCpze7BFtvZpj1p8YkNNdNUusfzbVVeApRnCuf8lxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172617; c=relaxed/simple;
	bh=av22SeNebyn0QbxnP/wIpPnKwaYtTmF/3Vcm1S1kbC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pK2oN2GrvkhLIac2navallkQvKEvtfqvmLPU11gRgjP6xXN5gcYoZWz4fAxYRPH6qs4kPAmDg/OzjTj/Q1uoqb8OkeZ5J5GvslM8HGsSfMA+2HHBrBLYycqz7f5nv+aj3JabUcn8t6JPex3GFauqw1APMGjUurehlcqgMz0YGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdTlFu09; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E311F0089A;
	Thu, 11 Jun 2026 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172615;
	bh=B/jHK5KBk6FTXaKZirATCYzoCzwuhdPMg8uuUt8C4/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XdTlFu09aYFviKS2rUNVV7c4wHxNbfCmbu0ycNSLjXNFXXx70SHkSeNcrR17Lqf3j
	 fjxCR0dX1I1W3uMG6zEETS7u1pQHU/GywubZmMPlq4nII1yAYsb0i+lSRDH38jbQcj
	 8Qkn0mevHq3UL7yP1jW1UApOgSlWSvdZdlmcGs1raXrHQ9BBjjNao4FnuBiv8sOsgH
	 agIeabKG4xjVMupKc/gtgJXXylPckydCb3JuhW/CbfVLvwc9gfCciqiVV5zhUEpGNw
	 1ENp18fGxrcnDT8ikLshIdvZNDzvdDjbW0Qeim9GbY9X7uE9NnYyJ/mq6kIQ0JZxzv
	 5gQQtH9CIW18w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197CB3930E3F;
	Thu, 11 Jun 2026 10:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117261264.3873654.13917983982730489581.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 10:10:12 +0000
References: <20260610140800.2562818-2-steffen.klassert@secunet.com>
In-Reply-To: <20260610140800.2562818-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298066-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADB9B670B9D

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 10 Jun 2026 16:07:40 +0200 you wrote:
> From: Takao Sato <takaosato1997@gmail.com>
> 
> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
> 
> [...]

Here is the summary with links:
  - [1/6] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
    https://git.kernel.org/netdev/net/c/e9096a5a170e
  - [2/6] xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload
    https://git.kernel.org/netdev/net/c/eb48730bb827
  - [3/6] xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()
    https://git.kernel.org/netdev/net/c/7f2d76c9c032
  - [4/6] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()
    https://git.kernel.org/netdev/net/c/c8a8a75b7334
  - [5/6] xfrm: espintcp: do not reuse an in-progress partial send
    https://git.kernel.org/netdev/net/c/c381039ade2e
  - [6/6] esp: fix page frag reference leak on skb_to_sgvec failure
    https://git.kernel.org/netdev/net/c/26aad08a9289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



