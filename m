Return-Path: <netdev+bounces-153806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC829F9BB4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E54188C0CE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB632236EB;
	Fri, 20 Dec 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AT9dn6pu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/EcLD1k"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020C6FC5
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729187; cv=none; b=Z3940TzD/vtxS+C8L11Z7LZ1gCgJpU+E8XQmsUmOzkoNVvCsdferpremHQ3dsUBsiD4wf7eK62PFgBNSRjbc/SO3FjJxVhqC6Ly/PaQUj1qzUwwstlx9cngfUK1QRZsfQ04RTZwl8iNGojI1F1xiCYCzbX0aBNanCb98pIldSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729187; c=relaxed/simple;
	bh=WORGs+7ZdZkPLJRa77byBD3gYifTWZ7J1qfc1dKIv3M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kKDInCZeFVMEZ7zYVR7PDtQAu7BOnHaYe097sA4rmfRSYQstQ8AWBbj+jwEYSp9VW1VoQrWB2gP2yZpLvO0dsVb1FwM0Ojw8kt+753m0Hmx0kvs7Z8QxVHfCdyEC1AG1dhlLj5pPdGHya8atEJU26L0ggfF7ZiphKiCk/JjCmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AT9dn6pu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/EcLD1k; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C43F1140136;
	Fri, 20 Dec 2024 16:13:03 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 20 Dec 2024 16:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734729183;
	 x=1734815583; bh=+Bb+F5o+R6pJPL6zbhHxG222Zlirt9+paL0IftESb5M=; b=
	AT9dn6puPBSKS38lCYpCjB9FklV5Ujp3cmosEor+uSlUvcbmzfqrpmhCf1nJ9nET
	FgHA8QtFq9waqMiQTa9Ls4yYwaFbi/bs9Vb43kDxHXH/S6QVQz/vI6I3QUa1/aAR
	s1CvuuMN4lnfutqhPklwW+b2+keMXjb2xXLQ8TKqFbMGxZHSvFzEDw/D93Nbw4BF
	R1TVH6e74Tuc72tpghR2mbUDHBiW7AV+gQhxRLboetJy2Roxg5FDNezNkI9QHg0M
	D4yCWhftgFpA7LeWH/BnmJWX+QdLIaTqHpOPwME/MrMV6nx/x3z0T0E6vslN03lK
	df2L47W8OJmX5Nkx3c9cJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734729183; x=
	1734815583; bh=+Bb+F5o+R6pJPL6zbhHxG222Zlirt9+paL0IftESb5M=; b=c
	/EcLD1kRZ9Rpg8+uy954VtpL1ctH5gntqvUUHLOBKAuoE/7tljGgIXLWshkxNnVj
	UtOchQ7JekK8qu0kyDLMf/lKZj9xdjpVrBWBd1Wv3Q78cLco0zaonKpCv3NG/RYh
	qhD3lQw96dfaHGpZNUr+/XyxV4WBJTgNGsnCV1GNP4NxsAMa9mOnvmTvx9BIDeDB
	naJNfJohs8+i+DEZRA1aPEMCKfbQf3cUqf8CcqlyuTLM+TTjNukaJCcN0Te6bvrW
	amKEP3jOUk0pFZA227C2T8DF438G5lQ+te/NKkihK9zTQ9cNS+IxwNdCdp6dx9NT
	3VJsuu2wgmPS5D6438Vvw==
X-ME-Sender: <xms:3t1lZ61P-LGjOs6M-QXBhLP1UdEoO0oVXwn8LugHLrWTQMt0NJMmZQ>
    <xme:3t1lZ9F2wZ9Sy0quwGoB2Sec_nsmlDzzAnr3w2Zzm5cyu6JwqpZ6uBLSdaM_6gyXy
    LT--_KmqTDgGtU4Gf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehouhhsthgvrhestghsrdhsthgrnh
    hfohhrugdrvgguuhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusg
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3t1lZy61K5RGY3SW7RMRZzCQXcsTw1ZNEU92xwuQ0uM4uEwEQJbxNw>
    <xmx:3t1lZ73kroq_g-buSVpFiN2yJ_YJBA23PbZM7p7X6KKdK8YjkOPLlQ>
    <xmx:3t1lZ9H2eC6ys-daJH5jniR9l0r6T-Ia1MA4_L2ypPbM0ot4QJnINQ>
    <xmx:3t1lZ0950759yCYsS0QZ4MQ15b6mht0SiZ2smvUgylXJb3pBPDId6Q>
    <xmx:391lZy76fMbiLohltHkDWShTRofcgY6JaG24Pyst8SlXZqxqAFRUBoZn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB6F32220072; Fri, 20 Dec 2024 16:13:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 22:12:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "John Ousterhout" <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>
Message-Id: <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
In-Reply-To: <20241220113150.26fc7b8f@kernel.org>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
 <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org>
 <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
 <20241220113150.26fc7b8f@kernel.org>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 20, 2024, at 20:31, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 09:59:53 -0800 John Ousterhout wrote:
>> > > I see that "void *" is used in the declaration for struct msghdr
>> > > (along with some other pointer types as well) and struct msghdr is
>> > > part of several uAPI interfaces, no?  
>> >
>> > Off the top off my head this use is a source of major pain, grep around
>> > for compat_msghdr.  
>> 
>> How should I go about confirming that this __aligned_u64 is indeed the
>> expected convention (sounds like you aren't certain)?
>
> Let me add Arnd Bergmann to the CC list, he will correct me if 
> I'm wrong. Otherwise you can trust my intuition :)

You are right that for the purposes of the user API, structures
should use __u64 or __aligned_u64 in place of pointers, there are
some more details on this in Documentation/driver-api/ioctl.rst.

What worries me more in this particular case is the way that
this pointer is passed through setsockopt(), which really doesn't
take any pointers in other protocols.

I have not fully understood what is behind the pointer, but
it looks like this gets stored in the kernel in a per-socket
structure that is annotated as a kernel pointer, not a user
pointer, which may cause additional problems.

I don't know if the same pointer ever points to a kernel
structure, but if it does, that needs to be fixed first.

Assuming this is actually meant as a persistent __user
pointer, I'm still unsure what this means if the socket is
available to more than one process, e.g. through a fork()
or explicit file descriptor passing, or if the original
process dies while there is still a transfer in progress.
I realize that there is a lot of information already out
there that I haven't all read, so this is probably explained
somewhere, but it would be nice to point to that documentation
somewhere near the code to clarify the corner cases.

That probably also explains what type of memory the
__user buffer can point to, but I would like to make
sure that this has well-defined behavior e.g. if that
buffer is an mmap()ed file on NFS that was itself
mounted over a homa socket. Is there any guarantee that
this is either prohibited or is free of deadlocks and
recursion?

      Arnd

