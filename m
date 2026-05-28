Return-Path: <netdev+bounces-292522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBmBJ7GmF2oaMQgAu9opvQ
	(envelope-from <netdev+bounces-292522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:21:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AD5EBBE8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BAF8304AC35
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDC2F5498;
	Thu, 28 May 2026 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyaTWit+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766542EAB72;
	Thu, 28 May 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934893; cv=none; b=mO7HzdDlHIfUQfWhAPvCHtOZSHnoFX7U4bcP/RU06SkCf/F3KQOsL+JRXnHXVkpyHvDHrHJL9vuMQczR5Gk73FSsoJmb/Kdt8/6J9dU+w4L9Lqf0LKUsZGyDcMuYJ/OWbxEz71mlXiYvLGCSPTUiqaMKjzXzUqW6DEcHlsxfR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934893; c=relaxed/simple;
	bh=dK60yFVR86W5hGG5jfY+yRcEE9ybI5Mf8ONVQV+ZVso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asfDIAC3o46CLaY+yedCCtjhmGqO6fnY6GmW8B8+3G1+Tdt97CqQ6rYZyI3qy1c0ZTAU9XG3TyM+S6/WbT2FUCVlg9kTvpit1JFT9Ti7QLR797muDxjtv06X+o/UpT8pZ+oA0VED691vyA9KpzGBLispyaSKOvqfJUkS77/Wh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyaTWit+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676FD1F00A3A;
	Thu, 28 May 2026 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779934892;
	bh=LB5jSSEDEd8ttTdSWGELR3Mewo9+R6WZhATO6rBa85Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TyaTWit+Hs/r7i1hVdfKAJe2iNe+7xGBiqePpqOAvCCa1yRtThRF4re7fPvzpCpvE
	 4rrgJ5aesn7igwrHHtzvi+HgyC5qDQxIlRIkFeFZHBQXM1VJpy2DNvuSps9a/bR84b
	 3GtFY39k7vU/WFdrJ/p8MDGg1afQIjliXm6fWPO8Xd64obG93Di/vg7iorqK61iMje
	 cBnnAIkKile9YEg6OaZJ90teQSCR+SDbIxp5JS5WRvKu7pPofKXAIOVYYSJhnnOH7E
	 pckPrT9YeHit/wm3kQTkZlr6DhkcWXwJO8EzyEJq3vkmJUMAHKYZB5lcWJlOsZkwB1
	 op0P84Jhg+CAg==
Date: Wed, 27 May 2026 19:21:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
Message-ID: <20260527192130.21dabf08@kernel.org>
In-Reply-To: <ahbAyBD584Hk9Mst@google.com>
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
	<20260525-binder-netlink-v5-1-a90e2923ebeb@google.com>
	<CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
	<ahbAyBD584Hk9Mst@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292522-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 188AD5EBBE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 10:00:40 +0000 Alice Ryhl wrote:
> On Tue, May 26, 2026 at 04:29:26PM +0200, Miguel Ojeda wrote:
> > On Mon, May 25, 2026 at 3:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote: =20
> > >
> > > This implements a safe and relatively simple API over the netlink API,
> > > that allows you to add different attributes to a netlink message and
> > > broadcast it. As the first user of this API only makes use of broadca=
st,
> > > only broadcast messages are supported here. =20
> >  =20
> > >  rust/kernel/netlink.rs          | 336 ++++++++++++++++++++++++++++++=
++++++++++ =20
> >=20
> > This should be added to an existing or new `MAINTAINERS` entry, i.e.
> > as usual, either inheriting it if the maintainers want, or delegating
> > it to a sub- or co-maintainer, etc. depending on what people want. =20

Good call, missed this isn't under rust/kernel/net

> Netdev maintainers, what do you prefer that I put for these files? I'm
> of course happy to be on the hook for this code.

Can we put it under rust/kernel/net and rust/helpers/net ?
And then add those directories to networking ?
Just so that we don't have to keep wondering with every little piece=20
of code.

> We can either add it under an existing entry, or we could add a new one
> along these lines:
>=20
> NETWORKING [RUST]
> M:	Alice Ryhl <aliceryhl@google.com>
> L:	netdev@vger.kernel.org
> L:	rust-for-linux@vger.kernel.org
> S:	Supported
> F:	rust/helpers/genetlink.c
> F:	rust/kernel/netlink.rs

Probably not at this time.

> Of course, it would be useful to have others listed here, as I'm sure I
> will have questions about how networking works if there are patches in
> this area. Or perhaps the netdev@ list itself is enough for that to
> reach the right people?
>=20
> With regards to actually merging code in this area, then I think for
> this particular series it is simpler to let Greg take it through
> char-misc with all the other Binder changes. But for any future changes
> to netlink.rs, I think it makes sense for them to land through the
> netdev tree.

SG, once acked it can go via any tree. Greg's tree make sense.

