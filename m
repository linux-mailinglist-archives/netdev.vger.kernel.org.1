Return-Path: <netdev+bounces-276850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNt0DIRJ12neMAgAu9opvQ
	(envelope-from <netdev+bounces-276850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2683C6A23
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9763033A95
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FB33F5B4;
	Thu,  9 Apr 2026 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="its3yjgm"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B033F589;
	Thu,  9 Apr 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716702; cv=none; b=FIaWGLYgH+24M3uQAQgOTdYZC+dDN8vCEfUsbS/bJv72ZzeguC/9mAcUMqv80T7k4dDNX8D1FQzUa1ewPHk+r/yuH9uaOENNd6hR9swRT3oPLCEQIT5GYsHvCKd3/iDxS6YTEDyKsyVVw3z0CUH1oohkUtOhtQXiHtV0RO0UwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716702; c=relaxed/simple;
	bh=UbtnkNkXhcu7zDaD2XSUnj7iooAkmSP+91mYLW03E50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr7jNiTudt0NdzI2xRVVJ1uxTyGxjezrsaox/zzfrq2kxzpTf0nuMTl1VRpjxoVVoHGZIborCRzso36XGH6yJAJUxkMzRDvUCdZF0xvki7Ca2LqxY264FSR2LPXA4XTFo2tFAbXMLIJpgC/G9dqlBZrS+XxvDNPxPTp+6IYBpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=its3yjgm; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4frqxt0NXfz9srX;
	Thu,  9 Apr 2026 08:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1775716690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM2ed99lDXd37GBj/HnBXxqlnPM4a2QBb1Y+5uudOX0=;
	b=its3yjgmXQJZqxehHhgYg9jOqxhWyuMaoe2kBAqPfe6PRbpxLP2tMJjka4zX1rncEO7WIF
	cfudY0lClyPLPj0Jtpl+9QWMSzUz5NMC/utCYvCKR1n57WqBIZ6HiECIKUKclrcCKU/WR5
	8y+edXTif3GzapMNYD5rN6D4/jwj6rl3vFeOvsT1XE1dEZcp0dcyD0GpazFf7L7sWpmeIB
	uk0FBRJcSvYuJnfFqz5CiGOhaMUEAXv5suCxTMvNJa0OgqbW87hh3157bqINMFMEUUJ0MJ
	EwZ2AsbRSuAGxf0PZNGxa9h8kcIR9WNUcdGrQ82UH5XimvxBMUu2lhLgoISfzw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 9 Apr 2026 16:37:51 +1000
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
Message-ID: <2026-04-09-carried-furtive-washer-brail-mNQ6oV@cyphar.com>
References: <cover.1775576651.git.metze@samba.org>
 <cfaedbc33ae9d36adaabf04fa79424f30ff1efdd.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="clmk73kctnv2nf4q"
Content-Disposition: inline
In-Reply-To: <cfaedbc33ae9d36adaabf04fa79424f30ff1efdd.1775576651.git.metze@samba.org>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276850-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE2683C6A23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--clmk73kctnv2nf4q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] sockptr: fix usize check in
 copy_struct_from_sockptr() for user pointers
MIME-Version: 1.0

On 2026-04-07, Stefan Metzmacher <metze@samba.org> wrote:
> copy_struct_from_user will never hit the check_zeroed_user() call
> and will never return -E2BIG if new userspace passed new bits in a
> larger structure than the current kernel structure.
>=20
> As far as I can there are no critical/related uapi changes in
>=20
> - include/net/bluetooth/bluetooth.h and net/bluetooth/sco.c
>   after the use of copy_struct_from_sockptr in v6.13-rc3
> - include/uapi/linux/tcp.h and net/ipv4/tcp_ao.c
>   after the use of copy_struct_from_sockptr in v6.6-rc1
>=20
> So that new callers will get the correct behavior from the start.
>=20
> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> Fixes: ef84703a911f ("net/tcp: Add TCP-AO getsockopt()s")
> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malform=
ed user input")
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
>  include/linux/sockptr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> index 3e6c8e9d67ae..ba88f4d78c1b 100644
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -91,7 +91,7 @@ static inline int copy_struct_from_sockptr(void *dst, s=
ize_t ksize,
>  	size_t rest =3D max(ksize, usize) - size;
> =20
>  	if (!sockptr_is_kernel(src))
> -		return copy_struct_from_user(dst, ksize, src.user, size);
> +		return copy_struct_from_user(dst, ksize, src.user, usize);
> =20
>  	if (usize < ksize) {
>  		memset(dst + size, 0, rest);

It is a little weird that this function open-codes memchr_inv() --
check_zeroed_sockptr() exists and does the right thing. Maybe it'd be
nice to fix that too?

In any case,

Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

--=20
Aleksa Sarai
https://www.cyphar.com/

--clmk73kctnv2nf4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaddJPxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9DigEAi2JzwlxQRoD0GuaHkvYo
bKv3sBpGAak8jX/66eeL3DAA/1Hd9qHOBAv122dRbfwiP9YkGgNN8l+0B596N/oJ
WZwL
=0DvX
-----END PGP SIGNATURE-----

--clmk73kctnv2nf4q--

