Return-Path: <netdev+bounces-253661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJUJKWEjeGlcoQEAu9opvQ
	(envelope-from <netdev+bounces-253661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:30:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B88F05C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 129443018BC1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39182580CF;
	Tue, 27 Jan 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdhCV6el"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301911DC1AB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481049; cv=none; b=Z9A+3RB/ht4gXkkLQ6kuIT021lWXYRnzmTMrFzlB5VBRrl6s2mUDzCdZF5qR/8wWySHeSRB7wXbNHhCd4KawFgZ4Wx56lfq3auWN8KR4ujX2z8cL5GuoVP6ClofiRW6fkumO8uuhg+ntRWh37BfHF6rkVYMTy66A+77udamf3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481049; c=relaxed/simple;
	bh=KHQTMcbGWv838jeHXPgV8dxHgD873Pl7gf8BNEh3ljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIQRaSauelbl5pJxrIIhoxuthGshJvNEkRZQOHj7DvT2iOpIksXBeSDKBcPVh7ygRBKlToS0khRfVoVpTbqcB4uhQoheR2tYmJUtBaYi4CaR//ZOb+g5X0c36F+fpuJ+IPE016svsptX9TZdiVk/NUO7WrPhFwt1KNmS5BTqLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdhCV6el; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79274e0e56bso51130717b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769481047; x=1770085847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D31caj3N1Jxdsl7gn2LUCTtkhdOIGiiafmFtbNg3P8=;
        b=hdhCV6elPH6QMYqIGvqzcjebzTt+heU9y99STI21AaP6zDHSTnVZ+hopEFI+L3g/rc
         djUjeUZxPSf6vKPl+iYSXWARYc/t1yPx5qCQDoNi6ev8L3OyQrBM6IP+Ua//WqWfIv1K
         UXoUidhJHbHm2vY4CMHdgx4HOcCUtdhbGCNN6aXdTm2CaMUzYi132Xodjtyld5HG6+J/
         DA+uLybXVsTqpAMkif9tTVH8yJbkPk0XpaWloHbvmMPohXFpk5gmeRAC8ThWZZXm12kp
         tVUBhBzySxggtJxIjc72tNQjbJUtjtnu1cXmmlQRL8z0ZgjOlxWPTvOanGxpIAqTNPAa
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481047; x=1770085847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D31caj3N1Jxdsl7gn2LUCTtkhdOIGiiafmFtbNg3P8=;
        b=mCDS05eWR3+LDA7WlwWBFjl9Wl35p7UXkxEUrluFbgVC6sYODQpgZ4JEg7ZJTZVPI2
         S7CIr8/+f/zB7Yc1pVzWU0NNCDY+iCpPgotmxH0ig+rkJm6F6Piyzn3NUvQFwV7ZcAxy
         T2GgzpxPeMQili1+8FOLHsDvW+c0D7wV4SfbYtR87w1dtDt1TbEAZ+LqcP/yEP8iPmgz
         enUsqHjsWE9/g06BBMq1qEp2SnFsn9/NmvqaRtYXP68Q0XL/QadqjwXtLM87/5v1NZLr
         e/fcY91QtnVvs66qpTIRgg5aKbQAfMDFQBgOXckZX86lQzlwLTLJvx4CjtpVX3XQeKJw
         gSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb0IGbcXyR2HPk01GUjrw0nViuHhA0TTef4w90YymZRApga2RkQ+18b/BnFLtRQwSSRCL7cGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkWS7CqemLFeOekrCVoLcY3L7/qwSShM4+Y6XS8tJaSgI3FVY
	g5IeJoqO8HiS9X/WL6QZTTs6NG8H2QekVHsU9jM1osmk7reDsW/2r4/C
X-Gm-Gg: AZuq6aIyD7mrueTinRVyZVGrce3jR4wqyW2dWj/cKoEcOCr2sDvMHv9jdFmCQ7RjmDf
	Cbv/mjn6rZYzPQzQLUw9Od1UIqlMitFez1oNRB96HZZi0TLh2xGU4wVEx0VyPDLM7SO7WfCNESh
	mxF+RbuMI92bu2cvqvq8oS/yzmUwubydhDzzprLXjUb0/Xwe35mrfczEKVB3hrn/rmOJ88+qBOY
	x4BSe8KAO94KiYiLYLedEtYBP11m65d4sAfiYA57nZMov5DlEtbA3avd/bzdbV0rX076tgngYo5
	lcVoaP11G/KXPpPxzPPRMX/7IoS4PglinPh452kf3qrn1VDR1LTMwGPmD1cMo77XJIIW/JCVfPp
	fmADo7OV/eka2Xigtife9L8td4m9nNI0dYIGhf9y9XHLEKdKvRp+pCsjMPIUt+RGtz0AYvqmQYk
	3sPuF2147USeQs9ZlYTBAV+iVJWFTX3I2DbPo=
X-Received: by 2002:a05:690c:6813:b0:786:a0fb:fa8e with SMTP id 00721157ae682-7947ab157c5mr1045097b3.15.1769481047156;
        Mon, 26 Jan 2026 18:30:47 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2bb70dsm55711407b3.45.2026.01.26.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:30:46 -0800 (PST)
Date: Mon, 26 Jan 2026 18:30:45 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org>
 <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org>
 <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
 <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
 <20260121194615.33dc0812@kernel.org>
 <aXGib0OcNdHTLyZN@mini-arch>
 <20260126172646.2e5af2d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126172646.2e5af2d4@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253661-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[devvm11784.nha0.facebook.com:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 018B88F05C
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:26:46PM -0800, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 20:07:11 -0800 Stanislav Fomichev wrote:
> > On 01/21, Jakub Kicinski wrote:
> > > On Wed, 21 Jan 2026 19:25:27 -0800 Bobby Eshleman wrote:  
> > > > Good point. The only real use case for autorelease=on is for backwards
> > > > compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
> > > > or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?  
> > > 
> > > Hm. Maybe let's return to naming once we have consensus on the uAPI.
> > > 
> > > Does everyone think that pushing this via TCP socket opts still makes
> > > sense, even tho in practice the TCP socket is just how we find the
> > > binding?  
> > 
> > I'm not a fan of the existing cmsg scheme, but we already have userspace
> > using it, so getting more performance out of it seems like an easy win?
> 
> I don't like:
>  - the fact that we have to add the binding to a socket (extra field)
>    - single socket can only serve single binding, there's no technical
>      reason for this really, AFAICT, just the fact that we have a single
>      pointer in the sock struct

The core reason is that sockets lose the ability to map a given token to
a given binding by no longer storing the niov ptr.

One proposal I had was to encode some number of bits in the token that
can be used to lookup the binding in an array, I could reboot that
approach.

With 32 bits, we can represent:

dmabuf max size = 512 GB, max dmabuf count = 8
dmabuf max size = 256 GB, max dmabuf count = 16
dmabuf max size = 128 GB, max dmabuf count = 32

etc...

Then, if the dmabuf count encoding space is exhausted, the socket would
have to wait until the user returns all of the tokens from one of the
dmabufs and frees the ID (or err out is another option).

This wouldn't change adding a field to the socket, we'd have to add one
or two more for allocating the dmabuf ID and fetching the dmabuf with
it. But it does fix the single binding thing.

>  - the 7 levels of indentation in tcp_recvmsg_dmabuf()

For sure, it is getting hairy.

> 
> I understand your argument, but as is this series feels closer to a PoC
> than an easy win (the easy part should imply minor changes and no
> detrimental effect on code quality IMHO).

Sure, let's try to find a way to minimize the changes.

Best,
Bobby

