Return-Path: <netdev+bounces-261678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H9oFY0AoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:25:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D01B2004
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E793048B33
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B302EAB71;
	Fri, 27 Feb 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcD1fvDt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502C8632A;
	Fri, 27 Feb 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159113; cv=none; b=gs6Jy0Xx5CUBxS8soAMSIuZGReYJNyyz9fyllDfZMG5hD/7obNSCakOA4RMVhibgYxR4sWahNxyP9R4rcyrOUt6Z9U/3+rCmf38z+hBwdkgVDILTj1X3ZdEjXC/PGm7hdedb37BvyzQWng15C0o2c+xC9Xc6vO4Doc7X4WAivEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159113; c=relaxed/simple;
	bh=eyrSIDsZ5QHi3TkgJVZHxpafO2KihE5BniAA72nJLW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t00XLfx/8iMb54MTpEMR5BAsWY8J7GwMLnmWNBM2lMbo47o3UogPCqdvCE4sdd2yos+iAYJ/KAGoyuFGv4xUzFq03ADkgzGVv8Ju8GVdIHN/nbaMm6TVOaa9cBTt7L0r5hfZZF/tQguaGzSbDoZRTOR79vOTwcXvjqH1B8fRHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcD1fvDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC40C116C6;
	Fri, 27 Feb 2026 02:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772159113;
	bh=eyrSIDsZ5QHi3TkgJVZHxpafO2KihE5BniAA72nJLW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mcD1fvDtIiYm+Z4aMDxWZtzT7vHvWjJsrTe+nujoAcqJBnuNLHKMIZ43e49feWG9l
	 Vl7KPpUGTLd82JLeTiHvKyNPq2+K5gf06eCImcJGtZy2Zw0oQd0bT/2cR97b4AzUv+
	 AXOzmWUAwh499TB/ISuurUJiUtcjRYx4gFBHpZJ2Jj8awlM4WNAuwPyKBySM2luR8m
	 4PGmB1jRVSvKxin1jFusXN5Akm+E3ExucNIvZUSr22KwCu7jTB0m9HU+3S6evMfrbg
	 o0nly42A6dpVSerY2a74elAGfn+sgWKUI4aIFM9aJ7UaDKTPtUcAloh4cl/XVkdhgq
	 dDCYnA7wDUcSA==
Date: Thu, 26 Feb 2026 18:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260226182511.0d33f9d1@kernel.org>
In-Reply-To: <vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
	<20260225150648.1542206-6-ioana.ciornei@nxp.com>
	<77f3e4e8-430e-4ae1-aa1f-8f70b4d8d3da@lunn.ch>
	<osswnpbiyy35ycs7ha2ufugj7dzmvpeq3x7vjq4j53qtwamkuw@ihwl5qjuydnv>
	<ph7vs3fsxti3nlypmmvm6wqvsnnsn76wct3qpi5omphggcjqrt@3any2dqzlgsr>
	<031c7375-0407-476a-92eb-0f894ec820f1@lunn.ch>
	<vcphjyyj3jezenqfgieqac7ayxhslupgeu6kh2ywfukaat3rtf@tsqaz33v4o7c>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0D01B2004
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 16:18:21 +0200 Ioana Ciornei wrote:
> > How about, fail the test if any are greater than 1% of the number of
> > packets transmitted/received? My _guess_ is, if you have 1% packet
> > loss, networking is not going to be happy anyway. It probably means
> > you have one end doing Half duplex and the other Full. That is a
> > typical configuration error you see causing collisions. Not that i've
> > actually seen this for maybe a decade!
> > 
> > Failing the test, with a comment about checking duplex configuration,
> > seems sensible.  
> 
> Seems reasonable. Thanks for the help!

FWIW the expectation is that the test should be able to run even on
systems / boards with a single interface. So the control traffic
(communicating with the traffic generator) will run over the same
interface as the test. 1% error is unachievable. I'd only check the
lower bound, and use some sanity value for the upper bound (2^30 ?)
if at all

