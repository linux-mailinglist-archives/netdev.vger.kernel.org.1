Return-Path: <netdev+bounces-259437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOxsEV7ulmngrAIAu9opvQ
	(envelope-from <netdev+bounces-259437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:05:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E207215E25A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EE80300AB38
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AEF33D6E1;
	Thu, 19 Feb 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAtAjWUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9833D6D4;
	Thu, 19 Feb 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499099; cv=none; b=I79NDM4bVplWeDtKH48uKVPj3jguR80bVbfU+Rk7AKhEYeX8lAZ9MY0DxCRLxKW7+FGSTg96ij4/g0hk7g90LI5oT6Agt0nNvQ5r7cVtnk0GK4/hih5IFowgXraGywRIG/wK0izNkGvhoGmtNzp9EcOomQYw4R1x73WgpSf1X3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499099; c=relaxed/simple;
	bh=dypEWTVlE89/7xWq0IMW0YOdKTTzDMNo3Lyu5x3skpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqdy75vjS/wuHdF8z7SIOzC+3oqwvhUjrk2eOhxo8mwFkVRhIeq/BZuPc9qAlV0DXAiAB+FXMW8erUd6NdzUdoGOuK50BzHgvnU7dRLvrelcZY1euHPK6YiYm1Nu9P7AVpoTW3HFBZSEW+8WqdaKoMZDhM+9x/tfofhZ90PjZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAtAjWUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6CCC4CEF7;
	Thu, 19 Feb 2026 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771499099;
	bh=dypEWTVlE89/7xWq0IMW0YOdKTTzDMNo3Lyu5x3skpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAtAjWUvVDmTRToDssVu6nnZikmwl3JN7acRo2iLd0lEvmhvgfXflHnTynALA9mrq
	 nTHeuHwRaRZY615Y8GKhJcQeL4r4a64YN20cDYuJFOE46yhNoSyO9SQ4ld+5JYiR3M
	 N8RLdY8Ha/7M69wnFNBNtL95Y34OFoZi03vsTgYT97t5cJvJ20Ys+HF67rNOuxooQR
	 8jN+mOTIvtulLGPfmGWSn/cmg79C1iRwlPkT8P6G+XYIVviS8c6h4pa1rFzMlJIiIc
	 070DFDc3uDPap4Rjh1pjsjApp/txIT6RjA3087C0vptI1egOPum1zhC/Sc8rsfhVI2
	 HAnIbLUnh/1Sg==
Date: Thu, 19 Feb 2026 12:04:56 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aZbuWBnmh_SQJyVf@lore-desk>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <20260218174742.62a4074f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7EEdEqOMZc2AsItl"
Content-Disposition: inline
In-Reply-To: <20260218174742.62a4074f@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E207215E25A
X-Rspamd-Action: no action


--7EEdEqOMZc2AsItl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 17 Feb 2026 09:33:56 +0100 Lorenzo Bianconi wrote:
> > + * In case of success, ``ip_summed`` is set to the RX checksum result.=
 Possible
> > + * values are:
> > + * ``XDP_CHECKSUM_NONE``
> > + * ``XDP_CHECKSUM_UNNECESSARY``
> > + * ``XDP_CHECKSUM_COMPLETE``
> > + *
> > + * In case of success, ``cksum_meta`` contains the hw computed checksu=
m value
> > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NON=
E``
>=20
> It's fairly common for NICs to report both csum complete and
> unnecessary. Which one should the driver return in that case?

Do you mean what is value for cksum_meta if we do not report csum_level for
XDP_CHECKSUM_UNNECESSARY/CHECKSUM_UNNECESSARY use-case? (as suggested by
Stanislav).

My original idea is:
- if the hw reports CHECKSUM_COMPLETE:
  - ip_summed =3D XDP_CHECKSUM_COMPLETE
  - cksum_meta contains the checksum computed by the hw
- if the hw reports CHECKSUM_UNNECESSARY
  - ip_summed =3D XDP_CHECKSUM_UNNECESSARY
  - cksum_meta =3D csum_level <-- Stanislav suggests to drop this one
- if the hw reports CHECKSUM_NONE
  - ip_summed =3D XDP_CHECKSUM_NONE
  - cksum_meta =3D 0

Regards,
Lorenzo

> What if the user prefers the other one?..

--7EEdEqOMZc2AsItl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaZbuWAAKCRA6cBh0uS2t
rK3sAP0Y8MEfTYmbOSyx5stUp9dR847DtJFisjm3SerE8v89VgEAxRUCoRfB45R8
ogSiJLBtXUXr8+9VJlQ99d28Dja/LgY=
=gmGu
-----END PGP SIGNATURE-----

--7EEdEqOMZc2AsItl--

