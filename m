Return-Path: <netdev+bounces-253669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBz3J9IreGl7oQEAu9opvQ
	(envelope-from <netdev+bounces-253669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:06:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719B8F5FE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 782883008C39
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87172FD1B6;
	Tue, 27 Jan 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU47TRk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B12F659F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483213; cv=none; b=bX+4KFH2fW382yZtvG5WplOYhMaLLPui27Dmp/aocpW7+Piyk10WHwHVfjS7JcyNAE/mhvTH14O2AADHEnE5XFbYZhH+vxLfPSBDTywNue00RizpJ4HeDqCpV/RdfF9GfGNatanYE8yyR4rK6wG/29J7IKnHJvPPakDVaJbJJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483213; c=relaxed/simple;
	bh=wYEcUgNuD+lPf2tV7/btjfFjqrI60S+N7nj/8yNW7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb8PfMvaAQnfOXbBjFq2kNNpnekv1JuNs3Svg7op0cMZATEn1kqGPM42YGT/DMrsSA+UeDHLPuutXreEz/195bPBGbtdWpqmwYQydim8pw51TjXiupNixhZZhtoGEdLTEVlOuoc4aMgo/zLq3y+tdzx/7eyaqArLKETQ5LR0F8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU47TRk1; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79478ec4cf1so2125617b3.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769483211; x=1770088011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtcTamun/anyrF+4xJBkkNRqAbEPEhjvU9VCmmVXBeM=;
        b=IU47TRk1K97pPGLqScYNmy4ieeG4lxxAnlN6s9T5ZO8WFpCbaJanHJru4scZJ/CbVl
         SmKDr9/06OWQzItbsOcZI+uuqTGVB015Uq996Jb2kNYlwbiOMYACKf7wpL7on99kakp8
         H415wOaurydKRZ4sP9l2enHfr+aDhBIQLMuW4lazcPnGyJSzVcerSo7WtZbSYgxzA2Oa
         QO4OHhOH+mGDtYKpF+GBlnJl7CLwjkiQn5iSJ+HXjjPExlu8ajNLuurTzkaoirbPsbtK
         DlHwskRWVw1SXw5/65rCtlEOiLMAt1gKOqNEs+NzjdM4s9c5TnNXAnoeWZKbrmDCYpXH
         NxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769483211; x=1770088011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtcTamun/anyrF+4xJBkkNRqAbEPEhjvU9VCmmVXBeM=;
        b=nZqlOcJOWr27kB/AFNGxg1V/VltqMncwglCxLOvZ4wHfI1bGTtGreB/MbdRRzPofXo
         ZNo/evRIHgQkQeATvJ7nE+It5gZSDriQ3CIgSEjIU/tc4ASptYBoesMTWz7gYeg0aIuR
         G79MJGp+RxMJIe+1svc4j78yYsztIy2eYflNC6AwyxQubjsNT2W0h6iWOrMAK8G/CW0k
         S5yKyvsCohKiOHY9IUQD5Y26ZYGi5lcmQN4c557NUqLbLlsItrCcTFWKczytZtsQl76Q
         Pr4pB07FdQ458jOfa+VMWQkbIoj/vwVcIWrced6tJNCvaY6BgpGyeRn4oO6/n82gwyJH
         HYbw==
X-Forwarded-Encrypted: i=1; AJvYcCXa8qvH0K44HZXvKlChbEzkBfYVVecSqdnyN73GxWvb/pCudpw1KB8G1Bn853pEPz5tlvndoIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxuYnmwnZR00N7dXXzGUlcgveYfVOLtyDNMgECcDJXvbwySTS
	ZSjgpDYRhrZT3Pq7MsQ3A3VH/2vP7KNhtC5l/7yEMZS/PYg5tqffhlXr
X-Gm-Gg: AZuq6aIAvLoq5obI1yf8de/uPjDO+2QGDFaCuVu28XpBjnJ9Rwg/3AzktQixSrWt2zt
	Lm4RijhovVA1A9mmiAk8z09NOjw1wE6fCXIkNCsNE02Bzlc7c0C90L1jREwfWG7kVdfTeqflIcN
	DhfAiHSZ2wIxWOvGXSjnICXuIfEdBjZ4ng1QpJk7BVfGe/h9LTszHCG2MH9Ww8Y/XXY4bpwNuYM
	pQh1pP55TIk8ZGAcMtq2Yw0I6CbrK0TtYgMrdbJi7A48b+zHoJGuzNir1S+4WyG9C3xPDGRnJO4
	tIRGqmQhfX6gTsxFyFul647lOu+QL+G5BOo+x02tVjCUGVsd549H8v7oRTG6/LeEzC5y1SBncBX
	2Jdmjw88+2yw7bSjhzq6aI2f1vnkHvko1e+4scDAvS5RT2T2XpukoTK5mWSjVzfk0f+ALQ8fj86
	4L8YJOwjSIGYb11iWrMt0wTVH3aJQMhIjF+w==
X-Received: by 2002:a05:690c:f02:b0:786:7a54:4635 with SMTP id 00721157ae682-7947ab3c172mr1656687b3.21.1769483211400;
        Mon, 26 Jan 2026 19:06:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79475c0212asm5994517b3.2.2026.01.26.19.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:06:51 -0800 (PST)
Date: Mon, 26 Jan 2026 19:06:49 -0800
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
Message-ID: <aXgryaSx9CzFR7kv@devvm11784.nha0.facebook.com>
References: <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org>
 <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
 <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
 <20260121194615.33dc0812@kernel.org>
 <aXGib0OcNdHTLyZN@mini-arch>
 <20260126172646.2e5af2d4@kernel.org>
 <aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
 <20260126184440.755a55b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126184440.755a55b2@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1719B8F5FE
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:44:40PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 18:30:45 -0800 Bobby Eshleman wrote:
> > > > I'm not a fan of the existing cmsg scheme, but we already have userspace
> > > > using it, so getting more performance out of it seems like an easy win?  
> > > 
> > > I don't like:
> > >  - the fact that we have to add the binding to a socket (extra field)
> > >    - single socket can only serve single binding, there's no technical
> > >      reason for this really, AFAICT, just the fact that we have a single
> > >      pointer in the sock struct  
> > 
> > The core reason is that sockets lose the ability to map a given token to
> > a given binding by no longer storing the niov ptr.
> > 
> > One proposal I had was to encode some number of bits in the token that
> > can be used to lookup the binding in an array, I could reboot that
> > approach.
> > 
> > With 32 bits, we can represent:
> > 
> > dmabuf max size = 512 GB, max dmabuf count = 8
> > dmabuf max size = 256 GB, max dmabuf count = 16
> > dmabuf max size = 128 GB, max dmabuf count = 32
> > 
> > etc...
> > 
> > Then, if the dmabuf count encoding space is exhausted, the socket would
> > have to wait until the user returns all of the tokens from one of the
> > dmabufs and frees the ID (or err out is another option).
> > 
> > This wouldn't change adding a field to the socket, we'd have to add one
> > or two more for allocating the dmabuf ID and fetching the dmabuf with
> > it. But it does fix the single binding thing.
> 
> I think the bigger problem (than space exhaustion) is that we'd also
> have some understanding of permissions. If an application guesses 
> the binding ID of another app it can mess up its buffers. ENOBUENO..

I was thinking it would be per-socket, effectively:

sk->sk_devmem_info.bindings[binding_id_from_token(token)]

So sockets could only access those that they have already recv'd on.

