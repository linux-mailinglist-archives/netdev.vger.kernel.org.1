Return-Path: <netdev+bounces-252129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Sq0ZFd9+cWmnIAAAu9opvQ
	(envelope-from <netdev+bounces-252129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:35:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C560628
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A610C4FFEB1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E312F12AE;
	Thu, 22 Jan 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR4tYdgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE22147E6;
	Thu, 22 Jan 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045716; cv=none; b=Qq4pBj6F7R+Oxv7VYCgIz4JzrR64Q/qcFhyfmM0XYvEsluyoU86IzL0engz/GQbhrPcH+QXY3K4nuJptQBlT8Bw4ZqwbRhvvM33+biFmdGuyMwa7LWeR7a9ojUMnQozHFx/W+bHxURKl6h7AihUUDredw+HZqwv2RoX4XuaNqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045716; c=relaxed/simple;
	bh=HGxtfHWe3WixENDmvXLbR55lrlOhLVAb+Q1rS7sz5ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTwZjxjp5Tv6MFd4Q+NDwat7Ubppeu9wqL8fq+IOQjyoPoMCrjeUZPm8ojpNPz6r8tfp9krrVUZo1mPdYMOcFHij/XOMg1IvVJQzfFHyPCdLsNhmNYu86tp/q1YT+J+faUSNOwc8dn2B18NzmT3tve4lNLJW0qZ4nZHdL+2NahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR4tYdgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B98EC4CEF1;
	Thu, 22 Jan 2026 01:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769045714;
	bh=HGxtfHWe3WixENDmvXLbR55lrlOhLVAb+Q1rS7sz5ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NR4tYdgUMwuBNbx6LKAkhYXEDJSjmJCXMBgPU9715glFq8CNYFkmKS+CowgJ3KAuV
	 8DL9zHjrv1QW7M8eH6sC62Lf1oleho+yxAuyMDQoSaKczKQfgCqoEUPFRtWmOBznh3
	 UXsVyhZIQgJb9wLLc5jkLbWJ8UGbVCyNskKSIWYT56c55VR9JXjnTlE66K6gkUIiZW
	 nseJE9jzGs7kcYGmN7J5zRQwDzID3qV/9hfZeqOqBBsjEAJnzerk/Bp2QCHvYlR2lW
	 JMAtNUFkbkE/te4lrM/ZrUusn1z7bn3DKYkd/ZhW7/XJkbROi4j+yXMiR8TAqIzMWG
	 N/e6O/uOi7NvQ==
Date: Wed, 21 Jan 2026 17:35:12 -0800
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
Message-ID: <20260121173512.748e2155@kernel.org>
In-Reply-To: <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
	<20260120163650.5a962648@kernel.org>
	<aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252129-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 060C560628
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 21:44:09 -0800 Bobby Eshleman wrote:
> On Tue, Jan 20, 2026 at 04:36:50PM -0800, Jakub Kicinski wrote:
> > On Thu, 15 Jan 2026 21:02:15 -0800 Bobby Eshleman wrote:  
> > > +- Once a system-wide autorelease mode is selected (via the first binding),
> > > +  all subsequent bindings must use the same mode. Attempts to create bindings
> > > +  with a different mode will be rejected with -EBUSY.  
> > 
> > Why?
> 
> Originally I was using EINVAL, but when writing the tests I noticed this
> might be a confusing case for users to interpret EINVAL (i.e., some
> binding possibly made by someone else is in a different mode). I thought
> EBUSY could capture the semantic "the system is locked up in a different
> mode, try again when it isn't".
> 
> I'm not married to it though. Happy to go back to EINVAL or another
> errno.

My question was more why the system-wide policy exists, rather than
binding-by-binding. Naively I'd think that a single socket must pick
but system wide there could easily be multiple bindings not bothering
each other, doing different things?

> > > +- Applications using manual release mode (autorelease=0) must ensure all tokens
> > > +  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
> > > +  leaks during the lifetime of the dmabuf binding. Tokens not released before
> > > +  close() will only be freed when all RX queues are unbound AND all sockets
> > > +  that called recvmsg() are closed.  
> > 
> > Could you add a short example on how? by calling shutdown()?  
> 
> Show an example of the three steps: returning the tokens, unbinding, and closing the
> sockets (TCP/NL)?

TBH I read the doc before reading the code, which I guess may actually
be better since we don't expect users to read the code first either..

Now after reading the code I'm not sure the doc explains things
properly. AFAIU there's no association of token <> socket within the
same binding. User can close socket A and return the tokens via socket
B. As written the doc made me think that there will be a leak if socket
is closed without releasing tokens, or that there may be a race with
data queued but not read. Neither is true, really?

