Return-Path: <netdev+bounces-288542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJUkHmzFB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E789559B49
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7FD530098AC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1EE7E0E8;
	Sat, 16 May 2026 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWVzftvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1C171AF;
	Sat, 16 May 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894185; cv=none; b=UP3xDDgBGELxWR83xDK2cECUbzC9oiw8TxQoEX5CdEQcd+V429Tfk2pB7fUkYSURwa6Ff9hJdY/kGA8Q8U1ew90OQbkVtR1BDHrIf4+ds4AvWpB6y3Zb9r2264MYGF5gZerAZPlqz4IiJCzWmOw8VMVAnRE9vNszjtPQIR0kgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894185; c=relaxed/simple;
	bh=LjtG0cq3tc+oYX8UP5INN6Ba1JgDmi3hokOGghsAnfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaThFYn+e4HvWG6+aRZGDQ9NwSLw1x+CKlvEEnceArfqzg6mjO+3z/zxsmj3ZHBvItHVFV8+4PM8bQMYGSdbIE97Pim7Eju0kl7JE4omEDeRfZjAh7IMfvy3cQkHk8JZN10DFHXdFtuiwe7WMUp9MM4lpwiy2FPNNsBlLd5b+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWVzftvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D0C2BCB0;
	Sat, 16 May 2026 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894184;
	bh=LjtG0cq3tc+oYX8UP5INN6Ba1JgDmi3hokOGghsAnfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWVzftvi5gV+xlN5Qfe3OmsQ0BSOeiqvLcrql2hEb0tdsceOo6tBUHjLcBW4SPcC3
	 tueo4DgaKRloKUXBPcd6aZyrThT0GtAT54Z7a8v2j14cPl17xv1JSwfFDSyGnbWvIf
	 7mx8DLqhjG5j/Be6a7QDLxNFRhWoRvmyxs700DIHIBVM21DG75sp6O2yM9onAgpVve
	 FnypbyxVRgmU2KUB+NOwNDuwg253WUgzrpHDOVoyA4iB+7+NUkNTA/2eTL0eh6r708
	 6V0+825v5n8UpqSg+qAJBXG5ZyUuG659TC4ConmXh+VW1ZiuXoOkNvhv/u4NLtDZkd
	 c8O6+wXQo5prg==
Date: Fri, 15 May 2026 18:16:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4
 devconf netlink notifications
Message-ID: <20260515181623.5a44140e@kernel.org>
In-Reply-To: <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
	<20260510081528.5257-3-fmancera@suse.de>
	<20260513193544.47970cb8@kernel.org>
	<bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
	<20260514162429.366b94c9@kernel.org>
	<f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1E789559B49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-288542-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 10:02:50 +0200 Fernando Fernandez Mancera wrote:
> >> No, AFAIU, iproute2 does not expose devconf settings. The main user of
> >> IFLA_INET_CONF are netlink libraries and other userspace tools that
> >> heavily rely on netlink operations like NetworkManager, nmstate, nispor,
> >> rust-netlink..  
> > 
> > Isn't this ip netconf ?
> >   
> 
> Oh sorry, I should have clarified it. ip netconf only shows/query them 
> but it cannot set them AFAICS.
> 
> Usage: ip netconf show [ dev STRING ]

Oh, fun. anyway, you gotta find a better way. Or just give up on the
selftest, the YNL hack is too ugly to live

