Return-Path: <netdev+bounces-258624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHvPAsxBj2k5OgEAu9opvQ
	(envelope-from <netdev+bounces-258624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB471377B7
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A5B305582C
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732EC363C41;
	Fri, 13 Feb 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGw9ILGu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4A3624C2;
	Fri, 13 Feb 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996126; cv=none; b=gjXXn1b/VEvux37RJFxuPaBr/pbovqFCdviwtUKGcld6Zia4tehncEF7+VpcLv6PTfR4LORzWYwVOdhA4tG1FCbPeIU33ziarHotVPXxrQiwg1eWq3DcYCPLnMaZjOWJDyHX8zKBPtS8yF1et4nn8Z8S27hEKBznjYyPd2yWQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996126; c=relaxed/simple;
	bh=uiXKGrta5YSlOI9oj98H0JbtZs40BXq+md8wHRRZ+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXFMiQHODd+BEacJwGYMjaFkw9bJhlzWIozAhCqdVOij1GGWfVKfO9RahQ8aWJfuJbd5cBZBE6WO6MM6JWwy7WQPLpe/CMRxqBI6v0nKJNoTSbZoKYOxysnhj8GtaCliKSYsgWYuLu78ePcoUo7sFdxvgmwib+Jv7TLlNJWWG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGw9ILGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D33C2BC86;
	Fri, 13 Feb 2026 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770996126;
	bh=uiXKGrta5YSlOI9oj98H0JbtZs40BXq+md8wHRRZ+YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGw9ILGuBrof3W4ID1AXaRcRnWS+kvUe3FQSoaOotADVb3P1+lkFpDJx7SZ/rsNLP
	 lbQwMFYHr2exFPdbAgOzH5VWP0xmXnQzWKbVS+WVH9riUpsC2RnaK4VyhlWYiHeJRE
	 XeD7rthBaCh+xiTm1VJ6cGvPMlcnwWKjwkwUsnXUmf0gazK3hOApJrYbEkDJyzcNqX
	 5gUxrcwaI0X9ilHL6V/SODI9T/awsKhEh2niVe4F3mCPpT50kuesxEol/Z5Ck0wf5x
	 a+kNvDip0saLJHQFWVlr/jY81zF6sc2vP+ZW1+052sC008Vyyf1H8FqdiRmfI4UbIP
	 ZnZWYmY77zCvQ==
Date: Fri, 13 Feb 2026 16:22:03 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
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
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 2/5] net: veth: Add
 xmo_rx_checksum callback to veth driver
Message-ID: <aY9Bm0ewK6lLWpqe@lore-desk>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
 <20260210-bpf-xdp-meta-rxcksum-v1-2-e5d55caa0541@kernel.org>
 <IA3PR11MB8986DFE4F3C0D804F50B0A56E563A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HFmkBUtLTk0X/kCd"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986DFE4F3C0D804F50B0A56E563A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258624-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8AB471377B7
X-Rspamd-Action: no action


--HFmkBUtLTk0X/kCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Lorenzo Bianconi
> > Sent: Tuesday, February 10, 2026 6:22 PM
> > To: Donald Hunter <donald.hunter@gmail.com>; Jakub Kicinski
> > <kuba@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Simon Horman
> > <horms@kernel.org>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> > Stanislav Fomichev <sdf@fomichev.me>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Andrii Nakryiko <andrii@kernel.org>;
> > Martin KaFai Lau <martin.lau@linux.dev>; Eduard Zingerman
> > <eddyz87@gmail.com>; Song Liu <song@kernel.org>; Yonghong Song
> > <yonghong.song@linux.dev>; KP Singh <kpsingh@kernel.org>; Hao Luo
> > <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Shuah Khan
> > <shuah@kernel.org>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Cc: Jakub Sitnicki <jakub@cloudflare.com>; netdev@vger.kernel.org;
> > bpf@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> > kselftest@vger.kernel.org; Lorenzo Bianconi <lorenzo@kernel.org>
> > Subject: [Intel-wired-lan] [PATCH bpf-next 2/5] net: veth: Add
> > xmo_rx_checksum callback to veth driver
> >=20
> > Implement xmo_rx_checksum callback in veth driver to report RX
> > checksum result to the eBPF program bounded to the veth device.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/veth.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c index
> > 14e6f2a2fb7783334d8f6afd54e658cf9a0e6f3d..38b70ad62db7e92cccc6c6c9ed1f
> > 5573d8baf48b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -1693,6 +1693,25 @@ static int veth_xdp_rx_vlan_tag(const struct
> > xdp_md *ctx, __be16 *vlan_proto,
> >  	return err;
> >  }
> >=20
> > +static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
> > +				enum xdp_checksum *ip_summed,
> > +				u32 *cksum_meta)
> > +{
> > +	const struct veth_xdp_buff *_ctx =3D (void *)ctx;
> > +	const struct sk_buff *skb =3D _ctx->skb;
> > +
> > +	if (!skb)
> > +		return -ENODATA;
> > +
> > +	/* For locally generated packets ip_summed is set to
> > +	 * CHECKSUM_PARTIAL.
> > +	 */
> > +	*ip_summed =3D skb->ip_summed;
> > +	*cksum_meta =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops veth_netdev_ops =3D {
> >  	.ndo_init            =3D veth_dev_init,
> >  	.ndo_open            =3D veth_open,
> > @@ -1718,6 +1737,7 @@ static const struct xdp_metadata_ops
> > veth_xdp_metadata_ops =3D {
> >  	.xmo_rx_timestamp		=3D veth_xdp_rx_timestamp,
> >  	.xmo_rx_hash			=3D veth_xdp_rx_hash,
> >  	.xmo_rx_vlan_tag		=3D veth_xdp_rx_vlan_tag,
> > +	.xmo_rx_checksum		=3D veth_xdp_rx_checksum,
> >  };
> >=20
> >  #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST |
> > NETIF_F_HW_CSUM | \
> >=20
> > --
> > 2.53.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

@Aleksandr: veth implementation is quite different in v2 so I will
remove your Reviewed-by tag.
Can you please take a look to the new version when you have some free cycle=
s?
Thanks in advance.

Regards,
Lorenzo

--HFmkBUtLTk0X/kCd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY9BmwAKCRA6cBh0uS2t
rM9GAP9pqasZqU5mkbE9HeZKaEA/3fmJnoxbUinX2RuFECIihQD+MfrvsdLGCvNi
SmxAUR2eFsKybJxZcgoL96b8QXXhzgQ=
=09aw
-----END PGP SIGNATURE-----

--HFmkBUtLTk0X/kCd--

