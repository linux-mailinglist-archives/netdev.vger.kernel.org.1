Return-Path: <netdev+bounces-276849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAPzEkZI12nDMAgAu9opvQ
	(envelope-from <netdev+bounces-276849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D43C69CC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27A30300E03F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56059339719;
	Thu,  9 Apr 2026 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="mWkhiJrl"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FA33F59B;
	Thu,  9 Apr 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716416; cv=none; b=oJeZJxyhGn+JqwWTi8SPUZ01lEo2YZjRzDq1JR38duKvW8pA7wcn0Hp0BSnDL5lcXT1P+isVDROZXd6C/FU6cYO+C8tfnmEff8o/FVSTllvtXP8NN580o9eKjHiD38+spKmCDKjSIdE80BAYNXBah2n3l1qsJFvzbYEni2kUjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716416; c=relaxed/simple;
	bh=BndKMO1J0bsDgk/kZD08S1uS+ayoaxEG5ezN2FA+njY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBjBZi0fvJyzDVsxgGAlTf/zxYykTHHruG8aqQ8J9tAF9HKV50VjQQexFSQ0op3u/ZFd3yAU0o4SvXJwHEzvWrxWm0r+pP69XSYMBbI2DGzVBRj6r7/x8yXuYx3Brk8gepNdAc37r1t5x4lKpH3sZMSQH7jdObSqbEVuIXnPVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=mWkhiJrl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4frqrS6D7Cz9ssx;
	Thu,  9 Apr 2026 08:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775716408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BlqEDad+MoIO9T2PduifHwk7xNYEDr7RnNQgh29XBM=;
	b=mWkhiJrlcDJLIgHnb+0CK4IZxgXA06Noao8mIWfKw7r9pARQw49tcehqYmD1ZYBpqbewEm
	i9AwbJ2AWOH9wcs+Lqa+688MNySM0iejQtFMbO++c2Uxa7kMuGEx0/Spg+9xOWVdDymZOO
	C+7flyHL8SUYc+5WMOYmscN6rsBRL80s/2CRc64Ea8S7sPTQbpYy/FwwoXjIy+EVIDLuYC
	fEss2/yB2sTOrNJT810vEgheR/x+03hj7Y3eiH4EV0RCUQf8g4xt8SD5R34ptdikJ9rGKd
	BLT3n4MMV8Cp7furKPS8CTdvELRMnn6WYK7zXzbTNKfeQZY3lzZEHKZM8m0c5Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 9 Apr 2026 16:33:03 +1000
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
Subject: Re: [PATCH 1/5] uaccess: fix ignored_trailing logic in
 copy_struct_to_user()
Message-ID: <2026-04-08-ditzy-organic-yowl-croc-yWsgIE@cyphar.com>
References: <cover.1775576651.git.metze@samba.org>
 <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzufnxb5jxfhelyx"
Content-Disposition: inline
In-Reply-To: <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276849-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 169D43C69CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zzufnxb5jxfhelyx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] uaccess: fix ignored_trailing logic in
 copy_struct_to_user()
MIME-Version: 1.0

On 2026-04-07, Stefan Metzmacher <metze@samba.org> wrote:
> Currently all callers pass ignored_trailing=3DNULL, but I have
> code that will make use of.
>=20
> Now it actually behaves like documented:
>=20
> * If @usize < @ksize, then the kernel is trying to pass userspace a newer
>   struct than it supports. Thus we only copy the interoperable portions
>   (@usize) and ignore the rest (but @ignored_trailing is set to %true if
>   any of the trailing (@ksize - @usize) bytes are non-zero).

Good catch, though I want to mention that the current API design for
copy_struct_to_user() is a bit of a compromise -- I was trying to think
of a way of making it generic but what information you need really
depends on your API.

For request-flag APIs (like statx) then you can just unset the bits in
the response mask for fields past usize and so it is a non-fatal error,
but it requires knowing which field offsets map to which flags.

My initial idea for ignored_trailing was for it to return the offset
memchr_inv() gives you -- but unfortunately, this doesn't help in the
more generic case where you have multiple non-zero bits that need to
unset multiple flags.

Out of interest, how did you plan on using it? It might be a good idea
to rethink this API before it starts getting used "in anger" in a way
that leaks to uAPIs we can't change.

In any case, for this patch feel free to take my

Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

> Fixes: 424a55a4a908 ("uaccess: add copy_struct_to_user helper")
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Francesco Ruggeri <fruggeri@arista.com>
> Cc: Salam Noureddine <noureddine@arista.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Michal Luczaj <mhal@rbox.co>
> Cc: David Wei <dw@davidwei.uk>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Christian Brauner <brauner@kernel.org>
> CC: Kees Cook <keescook@chromium.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  include/linux/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 4fe63169d5a2..1234b5fa4761 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -505,7 +505,7 @@ copy_struct_to_user(void __user *dst, size_t usize, c=
onst void *src,
>  			return -EFAULT;
>  	}
>  	if (ignored_trailing)
> -		*ignored_trailing =3D ksize < usize &&
> +		*ignored_trailing =3D usize < ksize &&
>  			memchr_inv(src + size, 0, rest) !=3D NULL;
>  	/* Copy the interoperable parts of the struct. */
>  	if (copy_to_user(dst, src, size))
> --=20
> 2.43.0
>=20

--=20
Aleksa Sarai
https://www.cyphar.com/

--zzufnxb5jxfhelyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaddIGxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG8uYgEAoP6BSZvClRWbH9O0ai+X
6ovNvDcTydf4aLirx20qXmEBALTldLxsgkSpGZU42zdQYgI2Ew0hoWw4iZq1ZgJl
pQgO
=jGIC
-----END PGP SIGNATURE-----

--zzufnxb5jxfhelyx--

