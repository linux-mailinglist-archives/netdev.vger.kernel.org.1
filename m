Return-Path: <netdev+bounces-252181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNkHGoaecWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D842B617B6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5D96824236
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ABF41C2E8;
	Thu, 22 Jan 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTzK3DL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9D2F25E4;
	Thu, 22 Jan 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053577; cv=none; b=NqmSVItR2N+GtlhNtgybL7qE1Gh0ftM7nTRyTAZOuVJQreQYnJ6cI+PFivaXa+Svy4YZgFAGKVRwkBxiDn954cg2hWhSiFzRPG7z5mfh/f35wPyWGflY2xSkderhkEMNk6jxyS1TiDVX1DciNUjm/4voPI80Ty0cQWGLaQ2XnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053577; c=relaxed/simple;
	bh=ynSRihxWim5+EusyB2i7EzOv0G25NDdmVPfcT0SpmjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYDfSFuwdpRYtfvON+w2/lOwXYf+JH9DoUgyqnh7Kl+QWh+6fxGhNJvkOz2WxSJmEy8NBzHNtKcx1Oau44EVbghpIshQJUu9JUXeZZgKDL7LG/7zCkumaK+SjWRmaYVDug2EH+Y6f8wm76iS9nPHMWMslorS7i9XECQbcVE/AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTzK3DL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A6EC116C6;
	Thu, 22 Jan 2026 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053577;
	bh=ynSRihxWim5+EusyB2i7EzOv0G25NDdmVPfcT0SpmjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTzK3DL5J130YmWOp6b7es/wRK1DmQ+o7wgYSuCQfXJa7NXw65UD7/olKRv5FRrKV
	 abDOVDa4WAmJ2ODdtvSMCixwNRCWJzzEpffJUxTToRmbi7bBnZuYiGkePf1P5fsUsC
	 SL65nWlBRhLW4WJ/o8n+HLtai9m3yzrUqTe/7vvp9B0IjWBj6ejpqCPhTqZbb0gqj6
	 TmKF1taxXgSwKJo2iFUncQ9W50G/6/BvGhhKONon5yCvbYrLntUER48QtpymoBA38K
	 jFcDF9VqoadGtdXHEtHKPy5b3x7SwgwOuau1PRVY6Iq1k70rYgFc4vkCEEHvz6md1P
	 qcGku8tnlRVvQ==
Date: Wed, 21 Jan 2026 19:46:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asml.silence@gmail.com,
 matttbe@kernel.org, skhawaja@google.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <20260121194615.33dc0812@kernel.org>
In-Reply-To: <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
	<20260120163650.5a962648@kernel.org>
	<aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
	<20260121173512.748e2155@kernel.org>
	<aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
	<20260121185021.446b00e8@kernel.org>
	<CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-252181-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D842B617B6
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 19:25:27 -0800 Bobby Eshleman wrote:
> > > That is correct, neither is true. If the two sockets share a binding the
> > > kernel doesn't care which socket received the token or which one
> > > returned it. No token <> socket association. There is no
> > > queued-but-not-read race either. If any tokens are not returned, as long
> > > as all of the binding references are eventually released and all sockets
> > > that used the binding are closed, then all references will be accounted
> > > for and everything cleaned up.  
> >
> > Naming is hard, but I wonder whether the whole feature wouldn't be
> > better referred to as something to do with global token accounting
> > / management? AUTORELEASE makes sense but seems like focusing on one
> > particular side effect.  
> 
> Good point. The only real use case for autorelease=on is for backwards
> compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
> or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?

Hm. Maybe let's return to naming once we have consensus on the uAPI.

Does everyone think that pushing this via TCP socket opts still makes
sense, even tho in practice the TCP socket is just how we find the
binding?

