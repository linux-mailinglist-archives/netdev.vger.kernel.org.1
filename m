Return-Path: <netdev+bounces-258171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE8YDS/ji2kVcgAAu9opvQ
	(envelope-from <netdev+bounces-258171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:02:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE991209E8
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37147304D1DA
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D22EB5A6;
	Wed, 11 Feb 2026 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxE1JbuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37602DB788;
	Wed, 11 Feb 2026 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775339; cv=none; b=jn1EiwY5eaMJqZvkDNMZv+elAjFMW/VdKL8P4ZVI4Hu+U0GFzNIflDOktJrlcGTSkBYCauew8Tf4lSEtaDo6BiPQ1jjDNqPY+VBn2Lsjs/l+Td7CreVeTCToCwh7WSdLcrQnvHHaMF78237F1tDUaI+OCAzBTDpLt+cNXf6eLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775339; c=relaxed/simple;
	bh=OaL7HmtY8PqZLX4O+1g7qbPlaK6jtij1faPJYo7M6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSsQ2YTosL4D0DRY8ZVaYBGnipN/j2LpbKMLMPbR5IhCqCZ+6RqMVYfGh0TnV5gMBU16sYLL+OqPtUxLw93a7KohfiJ7tYVYqnkEttCuQW6hVOFUMUrKBMRII43GfNL3Lapl+bxaV6fe7G2sdfnA4MUV3RBwfbbkFTC2QzXhBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxE1JbuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A19C116C6;
	Wed, 11 Feb 2026 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770775338;
	bh=OaL7HmtY8PqZLX4O+1g7qbPlaK6jtij1faPJYo7M6cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxE1JbuXS8wPbm1dDTh9Ig4ncqbH7TE+/RsRs23hStcbYsElRZI2XY529fcgfAi/c
	 R1UwvauzlXAosiWhA01TC9cFd95YvlFnVVYUGj1uL6dgvYP4QTyKGhBPjxTVR8KNWm
	 XE0Wt/z6JV9x7yQnTuHg1ljHE48vq0RmkVwy3FGrgqbti4ZvCklQQ84Q4vhVgidef4
	 59dRXj1fCCUJBev/zdXvVZCyDcLeI+5bPm6W+1y+m7x2DKFVW7SLkQI+syC7xYgfjA
	 4vAP29Vd32+9v7Ipr13i0WCn8WUZNpcUYqdZqpQGTOCyYR5+2udandhrRXt9KeKX7h
	 aKCC0nFldJTAQ==
Date: Tue, 10 Feb 2026 18:02:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
 "shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next] selftests: drv-net: port_split: convert to
 ksft format and mark disruptive
Message-ID: <20260210180217.3615df89@kernel.org>
In-Reply-To: <DM6PR12MB4516D06845B4A6D2691E46F4D865A@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260207012151.3972723-1-kuba@kernel.org>
	<DM6PR12MB4516D06845B4A6D2691E46F4D865A@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DE991209E8
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 09:54:08 +0000 Danielle Ratson wrote:
> Few comments:
> 
> 1. Before the change we simply ran the test without extra info, like
> that: $ ./devlink_port_split.py
> 
> Now the new infrastructure requires to run with:
> $ NETIF=swp1 ./devlink_port_split.py
> 
> While swp1 is an example for some interface in the machine using to
> indicate the real target device.
> 
> Otherwise, the test fails- if no NETIF is configured, the framework
> defaults to netdevsim (SW mode), and since the test sets
> 'nsim_test=False', it emits an error. So the new change, breaks the
> way the test was running by now.
> 
> However, I managed to work around that by adding a configuration file
> to the selftests dir:
> 
> $ cat drivers/net/hw/net.config
> NETIF=swp1
> 
> 2. The test fails for waiting for the carrier to come up. But
> actually, we should skip the carrier check. The port split test
> doesn't require carrier to be up since it's only testing port
> configuration (split/unsplit) functionality, not the data path.
> 
> I tried to run it while overriding the NetDrvEnv __enter__ method to
> bring the interface up without waiting for carrier:

Hm, I think we can risk removing the carrier wait for NetDrvEnv.
Only the "endpoint" env (NetDrvEpEnv) should really depend on the NIC
being able to send and receive packets. I guess I added the carrier
wait to the base class to save LoC.

Thanks a lot for trying it out! I'll send a v2 after the merge window.

