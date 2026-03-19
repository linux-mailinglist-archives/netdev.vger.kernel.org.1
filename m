Return-Path: <netdev+bounces-269629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP+5NWFRvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:41:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440932D1C0F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1823008530
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BB3D5675;
	Thu, 19 Mar 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb9XlwQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E9382291;
	Thu, 19 Mar 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949276; cv=none; b=Dc7A4JoytHhQe5/q2dzA6O73fZAHWgHXdgXYyxtvE1fvkvGciCSAjZN5uhEItPXikfD7zKOyAZ9LdV+uoWLmgAlUX2q3j7eE7NG1bm447Jqpw6tbDqfN3pRI9Jf+WiOXGI5a6vJMljeFPBTi5WzN5jDmVhH18ILArMSobTtaxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949276; c=relaxed/simple;
	bh=TdlVJRwwkwahwEi8GZmgOPq7txdAgkP9t4ENRmXm/X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk4ofEkRlHyQJmFEAIhD/8XEZSDhFFUOfutHe25haZP/sViB6yDkR0KU1WD5wZTvNspEwcFiqUTUFl0kGUTqu1OZc/Jvz4HIodWlswBknjXCaHJuNp5T/CNZyx+I53P5EFtgdVLd8/2gcsqxGpZ+yWkK6L8a5QR7qRpU8NojjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb9XlwQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4ABC19424;
	Thu, 19 Mar 2026 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773949276;
	bh=TdlVJRwwkwahwEi8GZmgOPq7txdAgkP9t4ENRmXm/X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yb9XlwQ5MNFqWqNL1DThNRuKpTqi6R9x3HGXLZztGXb4FgXi3fePOIJtLhLKDmrm5
	 Kq4F6djmSPlN6Ss2IO0ZTgPkjLH/A0XXp095FYQPD5aErjCXnls2XvZunvpQeZyMQH
	 OSDvjmSxDn3URptf3RVB+0vF0bSiG1uo6OZ5QVW56Vag/ILZy0YjmKFo9Eu5FgprgG
	 2HN8gCqpl6YC4nZngYG9PYfxQSlIDV2maBw41Ob3sv2wvpBjg2U2Fm0cywFMe5Pqkc
	 B5KYUaPS3k/JH7ISYp0oAFpS4NX+CLZ1AgRb7FCMzkxV8xgYNVgqRQrvmtZiiL+C9c
	 MltmNSvx7OIrg==
Date: Thu, 19 Mar 2026 12:41:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 8/9] selftests: ovpn: add test for the FW mark
 feature
Message-ID: <20260319124114.42f91f72@kernel.org>
In-Reply-To: <20260317104023.192548-9-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
	<20260317104023.192548-9-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269629-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 440932D1C0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 11:40:22 +0100 Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Add a selftest to verify that the FW mark socket option is correctly
> supported and its value propagated by ovpn.
> 
> The test adds and removes nftables DROP rules based on the mark value,
> and checks that the rule counter aligns with the number of lost ping
> packets.

Hi! Now that the other fixes are in tree we can stop ignoring ovpn
tests :) This new mark test is failing, looks like netfilter is not
enabled. All CONFIG options you depend on which are not in defconfig
should be listed in tools/testing/selftests/net/ovpn/config

Our CI currently builds this config for ovpn tests:
https://netdev.bots.linux.dev/logs/vmksft/net-extra/results/565721/config

Please add to tools/testing/selftests/net/ovpn/config
what this test needs.

