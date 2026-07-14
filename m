Return-Path: <netdev+bounces-307531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RpFQODZtVmpb5QAAu9opvQ
	(envelope-from <netdev+bounces-307531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C0475737D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:09:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=byVwXbtL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307531-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307531-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC72302FAA1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08B39CD0C;
	Tue, 14 Jul 2026 17:08:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9A39CCFF;
	Tue, 14 Jul 2026 17:08:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048936; cv=none; b=rGckSu5q01QXqhnO9VLzMKVP7e7iUwGTrF17IK1qKemu8HcSCppENfpv4NI5fyeUY3YQzwyr7B7tGeQuRs11nYFYS9Nvu5NKU8OV4Bu8ThA3wkCUY9P1zCwSXgMSUy2s4XrBWc0sxPvtJsNg/Iwk3njGtxYGyLfot0cQUdZBQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048936; c=relaxed/simple;
	bh=pXbKaqo3/BQgyZxsoqQbZAzKiU+B4SdXcj/pETX3txI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Ys538H4xyAq5SRNo+7ZDdI7kIJLRPO7Qpi0f3uJXB9HSFR5WOUFrlA/o6WaY+eDIQkuv2VjUGC7OZSs5OJGmPbVStW9odnOxGomBjc4d+UURqTETU7XKklFg3wGU4QgdQKmnRJ41OPE+BRl90RdX6vXf8hmdcRm7Pwz9YJag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byVwXbtL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB86C1F000E9;
	Tue, 14 Jul 2026 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048934;
	bh=Kh2P97NR23r0bPnBVfJUq5G6C7YiA7uuewthu/bIN7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byVwXbtL6pok60WoSXAQqDT9TWgMfVeTqOGTrFMFwA6AltQP5sZCa7aNR3xUn08rn
	 98GWpxt2dYNmGN3CJfXbCsFPoQPyYPMQI3kXe6SG80ABed69gGNkY5Rp2sd/Lt2Awv
	 p705lkbKrb86dy2CiTMLuTug1WxXpWM//OVfutelgu9l8QdbINaOd00urKNlK09LaY
	 WVTNVNF88fHrRfCN7D+T5MpHamui9ymXS5/O9MsHoSNXn0GiIT+fAuFqoG9QVKh6l/
	 OPEf8UexSOkk1UttwLnKuzJutIP/3N35XinvooYC6gdBZqJYcBqsUWKs419va0ZZgA
	 RZQu0vRoP673g==
Date: Tue, 14 Jul 2026 19:08:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
	Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <alZtI782RGKb8y4Y@lore-desk>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
 <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KHFfhBMWGk3EjgnD"
Content-Disposition: inline
In-Reply-To: <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:deliran@verdict.gg,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:sdfkernel@gmail.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307531-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[verdict.gg,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lore-desk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36C0475737D

--KHFfhBMWGk3EjgnD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/08, Vladimir Vdovin wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > checksum will be use by devices capable of exposing receive checksum
> > result via bpf_xdp_metadata_rx_checksum().
> > Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> > the eBPF program bound to the device to retrieve the RX checksum result
> > computed by the hw NIC and reported via DMA descriptors.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> > ---
> >  Documentation/netlink/specs/netdev.yaml |  5 ++++
> >  include/net/xdp.h                       | 18 ++++++++++++++
> >  include/uapi/linux/netdev.h             |  3 +++
> >  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
> >  tools/include/uapi/linux/netdev.h       |  3 +++
> >  5 files changed, 61 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 5f143da7458c..6d0d90d3a614 100644
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
> > index aa742f413c35..e255ff786131 100644
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
> > @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_=
L3_DYNHDR,
> >  };
>=20
> [..]
> =20
> > +/* Please note the driver is required to invalidate the checksum if th=
e NIC
> > + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF prog=
ram
> > + * modifies the packet since it can change some fields validated by the
> > + * checksum.
> > + */
>=20
> Sorry, a bit confused about this part. IIUC this is in response to this
> discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?
>=20
> Looking at a few drivers:
> - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
>   bpf prog attached
> - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> - gve (gve_rx) - can do COMPLETE even with xdp attached?
>=20
> So none of the drivers invalidate anything (and nether the bpf machinery)=
, some
> choose to (correctly?) not report COMPLETE when there is XDP. So was the
> discussion about documenting this and giving some guidance? This probably
> belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?

Hi Stanislav,

re-reading the previous upstream discussion, I guess we should just documen=
t the
expected driver behaviour (invalidate the cksum for both COMPLETE and
UNNECESSARY cases when the XDP program running on the NIC returns XDP_PASS)=
 and
add a given kselftest for it. Agree?

>=20
> Also, can you add your new rx_checksum to
> Documentation/networking/xdp-rx-metadata.rst's list of supported kfuncs?

ack, I will do it in the next iteration.

Regards,
Lorenzo

--KHFfhBMWGk3EjgnD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCalZtIwAKCRA6cBh0uS2t
rGL6AQCi2BM+G5ULVwlhiTQ9mResmshhs2Y13j4jDPNLyIsVpAEAnHqdZsYDNeis
roaeeQ5EZov1q2vIZr/DExysvRJVBAg=
=iMpE
-----END PGP SIGNATURE-----

--KHFfhBMWGk3EjgnD--

