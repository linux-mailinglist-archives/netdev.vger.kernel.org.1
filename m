Return-Path: <netdev+bounces-258623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbeFe5Aj2nqOQEAu9opvQ
	(envelope-from <netdev+bounces-258623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:19:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2EB137738
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776F5301E213
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A3361669;
	Fri, 13 Feb 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnCx3SDc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788A1E32D6;
	Fri, 13 Feb 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995944; cv=none; b=bTHnURCET5t4PEW+kbUb67hEUgFS1JhbrUaXe21f2ONydgJuvSoMYDENyKQ3wweg3cTVHU+pehj7wzXslrSpsRDSHT6X64CqxcacY+CjYkruM9Ry/yC2HfidQh4MgF2tBA43AHhGQZHhp8lxXMqXifiyUr8HTtSDE+YiH9nX5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995944; c=relaxed/simple;
	bh=eiw7P98b9Y19G0mrHqahDozgDK96ClCh7LOvVh3Wd/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPuD0sNfGuMJNN6BddnVC81uCjfniYsxkr2OZGGWLcAPUDDTDD04GLmzUeArjTJMal5uaO2KTytpXzlWyhvmFF/MGMl0P5RtZILo3ruhNaQ8VVccVvpGaGyaz45wGXISwtU/EqgOCryPlBc3hBPGmVjUcUwlIvXK+4PSPOthrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnCx3SDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7CDC116C6;
	Fri, 13 Feb 2026 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770995944;
	bh=eiw7P98b9Y19G0mrHqahDozgDK96ClCh7LOvVh3Wd/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnCx3SDciUicyMSx7uOIbiKMefwb0JIgH3zrqfC6qFxFxnqqcBXWlN+DoROrCcjaP
	 KfzTRgaMb5mWo9LnAMquz1SDZEiXyIDiQ7T/jGtyAIE0NZ1Z9XP5PSe8K49ZTrnvTN
	 2E4xn3fG6heTFD9davXyPrRLiotB2fDEbaH1SRGzr0EnU9TiGiYOpAgGUz7RRPdrbq
	 YXZM6QIjQzlNKlqXr8BwCzb29vx044mnJthpe+cwiiPTX6joUOPip6JluCU/Yuhm4j
	 KrbFk/Oaga1oshLL8//hTJpbMjZOXyVC/yylilnEQk0pYzAbmbZejQS7ca0vf5X7cC
	 EG7AvxYceljIQ==
Date: Fri, 13 Feb 2026 16:19:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY9A5QiTKuu7Kypp@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
 <aY0zd4Esewxa-8hw@mini-arch>
 <aY4FB_Gf31V-VYiF@lore-desk>
 <aY6zxmRcBSt4ju86@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9b/WtXUSgY2WwYsX"
Content-Disposition: inline
In-Reply-To: <aY6zxmRcBSt4ju86@mini-arch>
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
	TAGGED_FROM(0.00)[bounces-258623-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,davemloft.net,google.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,vger.kernel.org,lists.osuosl.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED2EB137738
X-Rspamd-Action: no action


--9b/WtXUSgY2WwYsX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 12, Stanislav Fomichev wrote:
> On 02/12, Lorenzo Bianconi wrote:
> > > On 02/10, Lorenzo Bianconi wrote:
> > > > > On 09/26, Jesper Dangaard Brouer wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > > > > Introduce XDP RX checksum capability to XDP metadata specs.=
 XDP RX
> > > > > > > > checksum will be use by devices capable of exposing receive=
 checksum
> > > > > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > > > > Moreover, introduce xmo_rx_checksum netdev callback in orde=
r allow the
> > > > > > > > eBPF program bounded to the device to retrieve the RX check=
sum result
> > > > > > > > computed by the hw NIC.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > ---
> > > > > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > > > > >   include/net/xdp.h                       | 14 ++++++++++++=
++
> > > > > > > >   net/core/xdp.c                          | 29 ++++++++++++=
+++++++++++++++++
> > > > > > > >   3 files changed, 48 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Docu=
mentation/netlink/specs/netdev.yaml
> > > > > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7f=
db67c6b9ee3548098b0c933fd39a4 100644
> > > > > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > > > > @@ -61,6 +61,11 @@ definitions:
> > > > > > > >           doc: |
> > > > > > > >             Device is capable of exposing receive packet VL=
AN tag via
> > > > > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > > > > +      -
> > > > > > > > +        name: checksum
> > > > > > > > +        doc: |
> > > > > > > > +          Device is capable of exposing receive checksum r=
esult via
> > > > > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > > > > >     -
> > > > > > > >       type: flags
> > > > > > > >       name: xsk-flags
> > > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2=
074b70618a9d4f32544d8b9a30b63 100644
> > > > > > > > --- a/include/net/xdp.h
> > > > > > > > +++ b/include/net/xdp.h
> > > > > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_a=
ttachment_info *info,
> > > > > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > > > > >   			   xmo_rx_vlan_tag) \
> > > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > > > > +			   xmo_rx_checksum)
> > > > > > > >   enum xdp_rx_metadata {
> > > > > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SC=
TP | XDP_RSS_L3_DYNHDR,
> > > > > > > >   };
> > > > > > > > +enum xdp_checksum {
> > > > > > > > +	XDP_CHECKSUM_NONE		=3D CHECKSUM_NONE,
> > > > > > > > +	XDP_CHECKSUM_UNNECESSARY	=3D CHECKSUM_UNNECESSARY,
> > > > > > > > +	XDP_CHECKSUM_COMPLETE		=3D CHECKSUM_COMPLETE,
> > > > > > > > +	XDP_CHECKSUM_PARTIAL		=3D CHECKSUM_PARTIAL,
> > > > > > > > +};
> > > > > > >=20
> > > > > > > Btw, might be worth mentioning, awhile ago we had settled on =
a smaller set of
> > > > > > > exposed types:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa=
=2Ezaremba@intel.com/
> > > > > > >=20
> > > > > > > Maybe go through the previous postings and check if the argum=
ents are
> > > > > > > still relevant? (or explain why we want more checksum now)
> > > > > >=20
> > > > > > IHMO the linked proposal reduced the types too much.
> > > > >=20
> > > > > IIRC, PARTIAL was removed because it's mostly (or only) a TX feat=
ure?
> > > > > So no real need to expose it as an rx hint. And I think empty xdp=
_csum_status
> > > > > in that proposal might have indicated NONE?
> > > >=20
> > > > Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL =
can be used
> > > > even on Rx side, right?
> > >=20
> > > So is this for virtio (which I don't think you need)? Or something el=
se?
> >=20
> > I forgot to mention before CHECKSUM_PARTIAL is used for the veth use-ca=
se
> > when the packet is coming from the networking stack.
>=20
> But what do you do with that partial state in BPF? I doubt you're
> calculating/verifying it? Can we treat/export it as NONE/UNNECESSARY for =
now?

actually I guess we can get rid of XDP_CHECKSUM_PARTIAL and threat it as
XDP_CHECKSUM_NONE for the veth case. I will fix it in v2.

Regards,
Lorenzo

--9b/WtXUSgY2WwYsX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY9A5QAKCRA6cBh0uS2t
rKh1AP91nCOFfR1O8ToCLIB00RY8q43IM5a8fg8TFjvQVtKNCwEAl1d1VGfd5rN+
jesX7vIacybDs4i1SG/WmD3CH/hWeAQ=
=yFYG
-----END PGP SIGNATURE-----

--9b/WtXUSgY2WwYsX--

