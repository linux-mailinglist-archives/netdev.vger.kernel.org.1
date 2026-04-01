Return-Path: <netdev+bounces-273872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH6uJ56PzGnXTwYAu9opvQ
	(envelope-from <netdev+bounces-273872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD62374429
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8193F304014E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996A31F99B;
	Wed,  1 Apr 2026 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0luM+IG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3E30DD2A;
	Wed,  1 Apr 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013628; cv=none; b=dleDpVXBIeaxAfjYVuM/qus8DRVEraVgcfggxQ18hua4zV8Ue9A2NNBlZbrqgpbYEHa978SKAiOdl28vVM4c5w2ygEQEpH2TUBcrkOwM6vajzCfeW4QvzlFQaojOZDajk/zg6FOuxI1yba7W6m7phVvNfaZRqlkA/VZQGk4nXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013628; c=relaxed/simple;
	bh=2PGK59Y+wpXNQ9Vo496JGT9NmpEw3p3yn37lzw4BKQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hFY3dJCAcAkGQg+YI+k7y0lQz8AmfVeQrSWnDWH0wAkLjyaoZ/bPgbwQpCZCwgRjezHJBNtM0XDpQ+Brs0VYwy8Jj3sUYrQXnH3b2t73xSdahrxxiUZiRwYH/xIx2PQXPbdblpxJq9aSC/uXbDUdyBbA6izt41A9jax1vNaAN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0luM+IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B35BC19423;
	Wed,  1 Apr 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013628;
	bh=2PGK59Y+wpXNQ9Vo496JGT9NmpEw3p3yn37lzw4BKQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0luM+IGWvoFS8zBznmIkXucn9gla0cWl0HOJ2FoRBQ6SfVsZdeGtmAWgvwM//2lg
	 7+neAiPEbfPLS0SPm+7ydZdL8Z1IuswWyHHh7VFlc3TCV5NwmI91Optz2JmwLIABqK
	 niIULejvJESv18Sbmk0YcKH/g/fiuhZ+QgPhxHme8BHHMjV6SNzD3cbTRGbGdsPEel
	 69Hkes3MguT3Z/Locw4MN59GAIALg81GeyL97e4rQfPgTy5eL9/bMyplT7vlzo6sh7
	 cMICIgvMf/uUg29OVB/olcvGf+Pxr29NH8u5rU2czk4P09wH+dz52heaABljHW3Aod
	 zfyHRooPr+00w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D143808203;
	Wed,  1 Apr 2026 03:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/iucv: Add missing kernel-doc return value
 descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501361178.3053582.15867964661733976035.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 03:20:11 +0000
References: <20260330114436.2010108-1-wintera@linux.ibm.com>
In-Reply-To: <20260330114436.2010108-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, twinkler@linux.ibm.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, aswin@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
 nagamani@linux.ibm.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273872-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFD62374429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 13:44:36 +0200 you wrote:
> From: Nagamani PV <nagamani@linux.ibm.com>
> 
> Add missing return value descriptions for several functions in
> net/iucv/af_iucv.c and net/iucv/iucv.c to address kernel-doc warnings.
> 
> Warnings detected with:
> scripts/kernel-doc -none -Wall net/iucv/*
> Warning: net/iucv/af_iucv.c:131 No description found for return value of 'iucv_msg_length'
> Warning: net/iucv/af_iucv.c:150 No description found for return value of 'iucv_sock_in_state'
> ...
> 
> [...]

Here is the summary with links:
  - [net-next] net/iucv: Add missing kernel-doc return value descriptions
    https://git.kernel.org/netdev/net-next/c/f1359c240191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



