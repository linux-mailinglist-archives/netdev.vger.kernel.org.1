Return-Path: <netdev+bounces-252588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B5CLRvQcmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:34:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F076F20F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4153300669D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5209037A4BC;
	Fri, 23 Jan 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouqwo04l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083832C21EF
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132057; cv=none; b=kbXTaLI9OrLkqJJdqWtAvdmdtCqvpF0YHznHt7jIKrdWs8q2qp2KOyYzMGAOhKtI1L5T2Hm+p9jPCs9yNhVrrAYQOU7VlvPjyH9l16SUq8may2+uJwLndQRyqq9W2jYR21yU/7xUvdNOUJTm7lt7eccVm2iIZNIG5NA/DcFxqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132057; c=relaxed/simple;
	bh=3NUYJCPlBRrrHA8iG6ku0Bn98IXK0/3pgg2s+mYYlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSK1WtYWbP5Z/32jwaPlqOntjuDcivkz4Z60ZLN9BwVE1W7fPNSYMd7431M20cirNjaTdWkcIOKv9nOgK3yBRLbCIeNa+RbeQJZGnX6pTSja6GkfBz0luJMOKXwTzXGu8Rfybclpw8QbKW0SBrlEHeu19hXvMjwQpZLTQdbggug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouqwo04l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D648CC116C6;
	Fri, 23 Jan 2026 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132056;
	bh=3NUYJCPlBRrrHA8iG6ku0Bn98IXK0/3pgg2s+mYYlVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ouqwo04lbzGVfXOcHn/JF/3g/Uen1cU6yRmn5czfId/UkXzyzCfCO8YS6tZqsWLoR
	 78L7zh0Y/uwkQTyhUUgYc0/acG9/tBhjPJnQfpaXzAADtFzSmBvywsEaL7qB8U1cWb
	 uOUXhdKhzF+3mImuGglMokcS3WgnyGLrWpfuTYLvHS2LXKebi/aratlidvIG78pKU7
	 xtQnC2RBVm8wpxZFz72Z2V5d7oKrWtPzqVfXEYpNPpWwiKYryvGKbbbV/7jJpwKqXq
	 MHtYLmcwThTJ6gP4HWkfUBG5mCvsTZhy2PtGTCRFoK4tDCsCNXfFj/q1xS6ZF94W5/
	 /QAEfZ3WdXJbA==
Date: Thu, 22 Jan 2026 17:34:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
Message-ID: <20260122173414.52ce472f@kernel.org>
In-Reply-To: <willemdebruijn.kernel.166500a9f06b7@gmail.com>
References: <20260122190349.2771064-1-edumazet@google.com>
	<willemdebruijn.kernel.65df45c3b4fe@gmail.com>
	<CANn89iKtX7Omh7qXwt7A1=Q3nQ4VgVOAzWfgNBO-t0xWP7RKpQ@mail.gmail.com>
	<willemdebruijn.kernel.166500a9f06b7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74F076F20F
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 16:16:43 -0500 Willem de Bruijn wrote:
> > > Iff respinning it may be informative to explain how drivers intend to
> > > use limits beyond standard Toeplitz. The tunneling that Jakub
> > > mentioned. AFAIK there is no Linux control API to configure the device
> > > RSS block in that way?  
> > 
> > How the NIC does header analysis and RSS computation is up to the NIC vendor.
> > 
> > They provide some knobs, but not a way of using user-defined RSS
> > hashing for some particular encapsulations.
> > 
> > Some NIC use a TCAM, and they do not use the RSS keys in sequence.
> > Say if one 4byte member of the L4 4-tuple starts at offset 130, the
> > NIC will use rss_key[130-xx] :rss_key[133-xx]  
> 
> I see. That is no longer RSS as defined. But that's moot. The point of
> the sysfs interface is to be able to share keys across netdevices for
> consistent behavior. For whatever algorithm it uses.

Perhaps stating the obvious - the first ~52B of the key still have
the well defined semantics. So for normal traffic / non-esoteric field
configuration user can still use the standard calculation. Unless we
bump the limit, however, those NICs can't use netdev_rss_key_fill().
Well, they could copy in just the 52B and then append some extra
entropy after but nobody bothers...

