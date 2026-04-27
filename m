Return-Path: <netdev+bounces-281331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GNEFzFm72kIBAEAu9opvQ
	(envelope-from <netdev+bounces-281331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:35:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090CF47387D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA2A3030134
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E003C945B;
	Mon, 27 Apr 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHNjNzOd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306736B061;
	Mon, 27 Apr 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296853; cv=none; b=I5ffG4lK3yDZbES0FaUcUP4H1RJWYqcepoY7UhiKkHx7O9fL/Zz1Z7q315bI0Ii85cGn6Z4e4LTpzli2hD3y+cTIZu9jQCVpyNSYVrFqVST+kvUcw1qENt5ZNvWbRRMNtbyqQJtK4Vuy+aXazw7+uWdHdLD41ISH5BAb88JGJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296853; c=relaxed/simple;
	bh=1aWTbIbaCSHlvMHm8QDsZWgkNtn14T5Y6WWN+DwuFc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lody42Mut+dP8HximLuOIPqtNHiRtJlarap164gYSO7VIFhFsXkunSPDv5zZ3yl8pTfQc7dYhx0Pauu/S40ZVUoBDcz3g73eFqABAvMsc49zYlKFXbGPllgTRs0bW/yyhbIY+Xd9u370uLJcfQpj5lCygD184hVaR08wnUxb6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHNjNzOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A311C19425;
	Mon, 27 Apr 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296853;
	bh=1aWTbIbaCSHlvMHm8QDsZWgkNtn14T5Y6WWN+DwuFc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHNjNzOd2jT3nxQiLKK7QhNKx8luuXoldNL1uz/UHwCHFyZCHmcyQDGfrEovSmufu
	 co2H0sfNT5/D0E9jXoUxnkH048xE6xu0q0gGSpBgNH7V3O3K/RZLD445/rj2pQ9PJO
	 zpvZfQXdHy+hFr7ZHNwtGibOa0ACxinRYR1cGJexDqaJFNuqhTBv0k5xMXYRDS+iRo
	 h0uq2hvZEGoM3hCO2M+3YqmQWUVeTaUHRLcyFfPTyNLgHwHueqB/dRV9zXBSGWNfSu
	 s5sUNJE1cEkMJR1N78hCIKMNbxq3UPE+YGoR6WtykKYX60rKg3U9c7eXILyJrXWDke
	 9W2NnG3CPXSnA==
Date: Mon, 27 Apr 2026 15:34:11 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <ae9lXJ4vMyEQOaIs@orome>
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ieveytj5ntrjzxpi"
Content-Disposition: inline
In-Reply-To: <20260427132604.3754048-1-thierry.reding@kernel.org>
X-Rspamd-Queue-Id: 090CF47387D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--ieveytj5ntrjzxpi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: build failure after merge of the bpf-next tree
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 03:26:01PM +0200, Thierry Reding wrote:
> Hi all,
>=20
> After merging the bpf-next tree, today's linux-next build (x86_64_perf)
> failed like this:
>=20
>       CC      builtin-trace.o
>     builtin-trace.c: In function =E2=80=98syscall_arg__strtoul_btf_enum=
=E2=80=99:
>     builtin-trace.c:972:27: error: comparison of integer expressions of d=
ifferent signedness: =E2=80=98int=E2=80=99 and =E2=80=98__u32=E2=80=99 {aka=
 =E2=80=98unsigned int=E2=80=99} [-Werror=3Dsign-compare]
>       972 |         for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
>           |                           ^
>       CC      util/btf.o
>     util/btf.c: In function =E2=80=98__btf_type__find_member_by_name=E2=
=80=99:
>     util/btf.c:19:43: error: comparison of integer expressions of differe=
nt signedness: =E2=80=98int=E2=80=99 and =E2=80=98__u32=E2=80=99 {aka =E2=
=80=98unsigned int=E2=80=99} [-Werror=3Dsign-compare]
>        19 |         for (i =3D 0, m =3D btf_members(t); i < btf_vlen(t); =
i++, m++) {
>           |                                           ^
>=20
> Caused by commit
>=20
>     f7a6b9eaff3e ("bpf: Extend BTF UAPI vlen, kinds to use unused bits")
>=20
> I've fixed it up like below, but please fix this in your tree as well.

Given that I later saw that the build broke due to the other change and
I had to use the old bpf-next tree, this fixup is no longer in the tree
but it should still be fixed so that bpf-next can be merged into linux-
next again soon.

Thierry

--ieveytj5ntrjzxpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnvZdMACgkQ3SOs138+
s6EANxAAvKuyRRy+MJedxbh6F7g9KKaAv1V5xwiB/D8asKOTCfHlniCxm7RCT4jZ
ySsfVaEZo3s5ncfiw1+XHQCwDqAzvRBMx6IZK1kGFBlPhulnA6Dj08ueBiQz+6zb
GZDvowyyIgZcMu5hRFV5VbOiBFNdBKHcVZ2xfRLqjAE0kMXOKi7pOjQ7MbfJ+Sx6
/fmaqAPKsXAwU662sgAUPIGTED6/Rbrpop9Vzi6ertn2Ij9OWjO3GmC7nx8VdtQG
60wfF/J7jwhZDlpZqBTId/+Eg50lWya47wbWuAnbDT49FzHPywl9ev5EwPbS/Ma9
PAIShmmGbPoHtN418O2PYbCYjr6Vn/wCAiuHWNH2Rdi4WMIA4oGgAD9gFlTuqnRb
CnfwpJGSv3KuSevRgYWaL5GwH6kTCGFWVbCqBJov70sVDpwiRT7dwltkAdR5cjpi
GHkNsOilPXL2oRrdxK4SD6IL68sUfu2rWv5ytpXToqK8ACtHmJmfHxCX7nbH66K5
pT7+YX0dpCDg2gPr6wGyIomnTbIL7AmwPMaYB5oLWN3pdlh5d6DG3+nHVesElyiC
lXgq3V6wst/of63rD1fNoLV5znssU+CzU2RBAaqGBgwDIK3xX+Mv0MCSwd0LINRz
ZRw+Z2RAWAb3iU8TGT8dWcn3f8Ig5CUywGy4OKcK1jq7eJHzzzY=
=KWhs
-----END PGP SIGNATURE-----

--ieveytj5ntrjzxpi--

