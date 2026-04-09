Return-Path: <netdev+bounces-276851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPbpDq5J12neMAgAu9opvQ
	(envelope-from <netdev+bounces-276851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FD83C6A39
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE247301AF45
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103533F598;
	Thu,  9 Apr 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qmps4XpG"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094915CD7E;
	Thu,  9 Apr 2026 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716766; cv=none; b=MBjNknvr4NbWNpAqnHW/JCL5LJ7ZQxk57SAAwhMlZ/JLwLUgmo1MfWJBdbL9rlCQa+Fybh8vPcvMyFfUOyLwTveHBZ6X+BlCe5+A/RB4gP6dXZMYAHqx9j8WMWBcrKPbu8POZsAz/DsBvo8093dB7AMffnAzdeyVrMoBmNivSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716766; c=relaxed/simple;
	bh=74VzkGV83BWoX8z8+LO2G4pCGPCz3yJXzJTL+M+dzqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU7fqPbSPtC56XT6y10fskDfmJ/e7HBpmz3DEvTjpQFEU6B4ew8w7uSnlzA/mGGYBdGr0EIsHs1dgZvUgQLGZ9zCnwErt94QKuxbW9IlZUbdUrWLvJtqhvqevSWwgrNproXwVJPJ0ISKpnUxxY52pFYZmF1a+dJp/QLq9KK3lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qmps4XpG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4frqzD063gz9t2T;
	Thu,  9 Apr 2026 08:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775716760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7gTcZ8RZuTIQuUibtvl6DBuexxrFNmg8TRoODrApDEk=;
	b=qmps4XpGbjeYPiCsxfK7giJzJW4Gst/g41E4xwp7U/g9n08E7KxjU8AWm8LSNkIih0mnez
	Ndrz9eIHPyEQj4i4M24tC6s9chlQwmztQRszDB5lTVqKGmMwTKxk6X+aciz1EGx0bAiBnv
	v2BhU0bKt3/DLLtA59z/vPTj7e1RxGfqXn6h1NJgMYDLC7czu4SG/I814VFrUpvVCnCzMc
	KKoQM1mwsMEp/vomRsjLFWc1CCp9bgCptirkbHtLNzUO8KcrOw3exT/p4K9EFzdYo2aVaG
	QxjxhxI+bkCHYlk1X7XTKlI2QxcTHV4zWFvSLWfFxGM9eqBxEvx3rU8/8YbUjg==
Date: Thu, 9 Apr 2026 16:39:00 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Michal Luczaj <mhal@rbox.co>, David Wei <dw@davidwei.uk>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Xin Long <lucien.xin@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] sockptr: fix usize check in
 copy_struct_from_sockptr() for user pointers
Message-ID: <2026-04-09-sulky-hectic-boots-corks-HJQldo@cyphar.com>
References: <cover.1775576651.git.metze@samba.org>
 <cfaedbc33ae9d36adaabf04fa79424f30ff1efdd.1775576651.git.metze@samba.org>
 <2026-04-09-carried-furtive-washer-brail-mNQ6oV@cyphar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xt4aatg6wgaew44"
Content-Disposition: inline
In-Reply-To: <2026-04-09-carried-furtive-washer-brail-mNQ6oV@cyphar.com>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276851-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,chromium.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90FD83C6A39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3xt4aatg6wgaew44
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] sockptr: fix usize check in
 copy_struct_from_sockptr() for user pointers
MIME-Version: 1.0

On 2026-04-09, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2026-04-07, Stefan Metzmacher <metze@samba.org> wrote:
> > copy_struct_from_user will never hit the check_zeroed_user() call
> > and will never return -E2BIG if new userspace passed new bits in a
> > larger structure than the current kernel structure.
> >=20
> > As far as I can there are no critical/related uapi changes in
> >=20
> > - include/net/bluetooth/bluetooth.h and net/bluetooth/sco.c
> >   after the use of copy_struct_from_sockptr in v6.13-rc3
> > - include/uapi/linux/tcp.h and net/ipv4/tcp_ao.c
> >   after the use of copy_struct_from_sockptr in v6.6-rc1
> >=20
> > So that new callers will get the correct behavior from the start.
> >=20
> > Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> > Fixes: ef84703a911f ("net/tcp: Add TCP-AO getsockopt()s")
> > Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> > Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malfo=
rmed user input")
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Cc: Dmitry Safonov <dima@arista.com>
> > Cc: Francesco Ruggeri <fruggeri@arista.com>
> > Cc: Salam Noureddine <noureddine@arista.com>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Michal Luczaj <mhal@rbox.co>
> > Cc: David Wei <dw@davidwei.uk>
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > CC: Kees Cook <keescook@chromium.org>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-bluetooth@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Stefan Metzmacher <metze@samba.org>
> > ---
> >  include/linux/sockptr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> > index 3e6c8e9d67ae..ba88f4d78c1b 100644
> > --- a/include/linux/sockptr.h
> > +++ b/include/linux/sockptr.h
> > @@ -91,7 +91,7 @@ static inline int copy_struct_from_sockptr(void *dst,=
 size_t ksize,
> >  	size_t rest =3D max(ksize, usize) - size;
> > =20
> >  	if (!sockptr_is_kernel(src))
> > -		return copy_struct_from_user(dst, ksize, src.user, size);
> > +		return copy_struct_from_user(dst, ksize, src.user, usize);
> > =20
> >  	if (usize < ksize) {
> >  		memset(dst + size, 0, rest);
>=20
> It is a little weird that this function open-codes memchr_inv() --
> check_zeroed_sockptr() exists and does the right thing. Maybe it'd be
> nice to fix that too?

Ah my bad, I didn't see that you already fixed this in patch #4.

> In any case,
>=20
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

--=20
Aleksa Sarai
https://www.cyphar.com/

--3xt4aatg6wgaew44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaddJhBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/X3AEAlMpBWzYh2pieUqyUvmjC
zsPWawgyqMug71DCUIAAGX0A/1IpSELhjfkgPIrf8ZOFkMtRAOcA6lgtNw66DpJp
nMsO
=B7LC
-----END PGP SIGNATURE-----

--3xt4aatg6wgaew44--

