Return-Path: <netdev+bounces-258598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADaWJMP/jmmOGwEAu9opvQ
	(envelope-from <netdev+bounces-258598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:41:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DF1352E2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13240304ADB6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83634A3DA;
	Fri, 13 Feb 2026 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAdbZlLl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29110352C2E;
	Fri, 13 Feb 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979230; cv=none; b=mfSOSMiMkk1Z+xmrEYS8eag/fBaavLLCkeHsTwq26WPSifNE7dnm2ZWq6yoOQus9tiY8n7phy1zSvRp04/NhX2cPA/6JDcMFLwsUemyrmp7B12shHZJF7J+8946Sdj8Axi1x8IgFieGiK/BSjEBbPomoEKG+Z6GNbAGa21l81Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979230; c=relaxed/simple;
	bh=SC2ovmnTmN31BJMgWSDQstBBBIerODPENfDec9d9YDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3ZlsLbtYmkKdh4m8BaK91ryObnUi74AvjEDIGC4Arc5t3g1MblYyLhHsJ+ovyDVqNrqL0hRB/M7BejbORDK8xGFvSYtY8aipVYjTpaPAsSlHkTz/+peH3jlbiOO+TZs+giIRQV8tddFnfBO23PWyDAZCPhltdE+OSlLsMX4aZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAdbZlLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD8C116C6;
	Fri, 13 Feb 2026 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979229;
	bh=SC2ovmnTmN31BJMgWSDQstBBBIerODPENfDec9d9YDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAdbZlLlE2sYlveU4i9kF08qSHcQUHP3CpPs4Zj5+WqKzalKAeEPuvX3K6k4peRql
	 gMK+S09NxnEhq0iJwR0aCKlws6UHTq3w2hQIQ84G2TlbZpnYApfNxmGSSMCa0CNrBs
	 2S0ZMe2kAWouyXlIlaffTcNyEdDn7SzDB89hFurup7S6g/iBz0nuX0VImNEJtXP0Mu
	 TqpfuXbE+xaDpMelpayQ7cAy4ED9vDGY53FTrfuHKvlFRl+MBlZB4jBii+bv/KMlmf
	 2RSUbDfzvtovAQ8+N0BuOxsMz+P/ZEDFUGYQun0kN+scYNscoHdeboWsYY1hPMBzN3
	 yT5cvSKD0p3VA==
Date: Fri, 13 Feb 2026 11:40:27 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH bpf-next 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY7_m0CEjL9zTQ45@lore-desk>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
 <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
 <aY60QrE6DpXVecze@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwJIGiRKX8fs1N5o"
Content-Disposition: inline
In-Reply-To: <aY60QrE6DpXVecze@mini-arch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 345DF1352E2
X-Rspamd-Action: no action


--qwJIGiRKX8fs1N5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 12, Stanislav Fomichev wrote:
> On 02/10, Lorenzo Bianconi wrote:
> > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > checksum will be use by devices capable of exposing receive checksum
> > result via bpf_xdp_metadata_rx_checksum().
> > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > eBPF program bounded to the device to retrieve the RX checksum result
> > computed by the hw NIC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/netdev.yaml |  5 +++++
> >  include/net/xdp.h                       | 14 ++++++++++++++
> >  include/uapi/linux/netdev.h             |  3 +++
> >  net/core/xdp.c                          | 29 +++++++++++++++++++++++++=
++++
> >  tools/include/uapi/linux/netdev.h       |  3 +++
> >  5 files changed, 54 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 596c306ce52b8303b20680ff0cd34d4fd9db0e48..58eda634668a07860447a65=
d9fc2284839af6244 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -61,6 +61,11 @@ definitions:
> >          doc: |
> >            Device is capable of exposing receive packet VLAN tag via
> >            bpf_xdp_metadata_rx_vlan_tag().
> > +      -
> > +        name: checksum
> > +        doc: |
> > +          Device is capable of exposing receive checksum result via
> > +          bpf_xdp_metadata_rx_checksum().
> >    -
> >      type: flags
> >      name: xsk-flags
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d=
4f32544d8b9a30b63 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_in=
fo *info,
> >  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> >  			   bpf_xdp_metadata_rx_vlan_tag, \
> >  			   xmo_rx_vlan_tag) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > +			   bpf_xdp_metadata_rx_checksum, \
> > +			   xmo_rx_checksum)
> > =20
> >  enum xdp_rx_metadata {
> >  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_=
L3_DYNHDR,
> >  };
> > =20
> > +enum xdp_checksum {
> > +	XDP_CHECKSUM_NONE		=3D CHECKSUM_NONE,
> > +	XDP_CHECKSUM_UNNECESSARY	=3D CHECKSUM_UNNECESSARY,
> > +	XDP_CHECKSUM_COMPLETE		=3D CHECKSUM_COMPLETE,
> > +	XDP_CHECKSUM_PARTIAL		=3D CHECKSUM_PARTIAL,
> > +};
> > +
> >  struct xdp_metadata_ops {
> >  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
> >  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> >  			       enum xdp_rss_hash_type *rss_type);
> >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
> >  				   u16 *vlan_tci);
> > +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx,
> > +				   enum xdp_checksum *ip_summed,
> > +				   u32 *cksum_meta);
> >  };
> > =20
> >  #ifdef CONFIG_NET
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index e0b579a1df4f2126acec6c44c299e97bbbefe640..d20da430cfd57bc26b5ea2f=
406c27b48d8a81693 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -47,11 +47,14 @@ enum netdev_xdp_act {
> >   *   hash via bpf_xdp_metadata_rx_hash().
> >   * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing rec=
eive
> >   *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
> > + * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing rec=
eive
> > + *   checksum result via bpf_xdp_metadata_rx_checksum().
> >   */
> >  enum netdev_xdp_rx_metadata {
> >  	NETDEV_XDP_RX_METADATA_TIMESTAMP =3D 1,
> >  	NETDEV_XDP_RX_METADATA_HASH =3D 2,
> >  	NETDEV_XDP_RX_METADATA_VLAN_TAG =3D 4,
> > +	NETDEV_XDP_RX_METADATA_CHECKSUM =3D 8,
> >  };
> > =20
> >  /**
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index fee6d080ee85fc2d278bfdddfd1365633058ec06..e51346ad3031f28d11c11f8=
205da6cd954da82de 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const=
 struct xdp_md *ctx,
> >  	return -EOPNOTSUPP;
> >  }
> > =20
> > +/**
> > + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> > + * @ctx: XDP context pointer.
> > + * @ip_summed: Return value pointer indicating checksum result.
> > + * @cksum_meta: Return value pointer indicating checksum result metada=
ta.
> > + *
> > + * In case of success, ``ip_summed`` is set to the RX checksum result.=
 Possible
> > + * values are:
> > + * ``XDP_CHECKSUM_NONE``
> > + * ``XDP_CHECKSUM_UNNECESSARY``
> > + * ``XDP_CHECKSUM_COMPLETE``
> > + * ``XDP_CHECKSUM_PARTIAL``
> > + *
> > + * In case of success, ``cksum_meta`` contains the hw computed checksu=
m value
> > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NON=
E`` and
> > + * ``XDP_CHECKSUM_PARTIAL``.
> > + *
> > + * Return:
> > + * * Returns 0 on success or ``-errno`` on error.
> > + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> > + * * ``-ENODATA``    : means no RX-timestamp available for this frame
> > + */
> > +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> > +					     u8 *ip_summed, u32 *cksum_meta)
> > +{
>=20
> Any reason not to do enum xdp_checksum *ip_summed here as well?

ack, I will fix it in v2.

Regards,
Lorenzo


--qwJIGiRKX8fs1N5o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY7/mwAKCRA6cBh0uS2t
rPcoAQCb7m6pbv19sIu76bYil26EtBbnmmstPmm4RPxwfLKneAEA63LE9ex6Lo4S
bBOpGzrQF7VzBTabcYLSnAVzI5jkiQI=
=YHsg
-----END PGP SIGNATURE-----

--qwJIGiRKX8fs1N5o--

