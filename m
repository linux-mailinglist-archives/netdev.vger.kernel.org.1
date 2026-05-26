Return-Path: <netdev+bounces-291929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hp8KsYLFmrYhAcAu9opvQ
	(envelope-from <netdev+bounces-291929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 258305DC9A5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127F73015486
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AB3C1F40;
	Tue, 26 May 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHknQda5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD73BFAF5
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829698; cv=none; b=RToqS57HlboY+ey0L46yfQnSZbsfNsoIIDwz2tWK48JvH8APqmILIFwQU2BSAt4F9gSidxgzXZECUolmk6Rcsg3lLJIKVNEHPVai01CL68Vz0ScHnHsw8Pxbi8914yTuCjCkNFhBxDFpYvvMSZtENKAs3e1BuwIOw19On6vQUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829698; c=relaxed/simple;
	bh=BjO37vgihnHtOM0z27OHzSTx5mNySfd4p7FBq7HL9dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYAMKySsAumeD4qG6lQyiju1TuxJmeeQEl1T7cPexMFCGLzziwDrLXoXzyx1nmWjnWFH5ofQ/ifjWB8xuRy9V7t6a7S+HnQeVCESqwr5Y8NW217qBSj6LOB8yEiV2tCA6SaN7PVaqoMrxpg43/yQYdzD3C/n6fMnYFhYVJN2l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHknQda5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20151F000E9;
	Tue, 26 May 2026 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829697;
	bh=QzwgwypkHaL96nsdzAkl5yH0GD0dCTKW1kcyCj3G6qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHknQda5xEYsK9IBnCJXCvpT/FS27W7drakg0GHskeVSZn3m8q0ZmlNMkcyN5h5YA
	 xhdm2eb6Kscy68HoKwokIZwV2L0HeGQBunFBGntDQr08jbMfr/gTrhBJfxzOT41nsZ
	 tFLfzr9nBhUwUXNS6QWyfM25blqoolgKL10jc3mJdn3i4Wkw2KThlx8zEwv999YSie
	 wbs5eXxXfCzy7MT7epDG9kC729+BkZYxdMRal8G/kOKFc/hpDZRRFli5njkIPfGi6e
	 OemMvy2bVODCYRN+x7au9+WjbNqWRWuJSg3jcBT3KVxTNjyDhl1I9j0z9zNBMl8wCE
	 xH8AmfaG2r4kg==
Date: Tue, 26 May 2026 23:08:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH RFC net-next v2] net: airoha: Add TCP LRO support
Message-ID: <ahYLvlIYH60cvkWB@lore-desk>
References: <20260526-airoha-eth-lro-v2-1-24e2a9e7a397@kernel.org>
 <7473204e-2ccd-44d8-b703-5a5dbcb29b61@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EScZYE8yc4PJ+rAl"
Content-Disposition: inline
In-Reply-To: <7473204e-2ccd-44d8-b703-5a5dbcb29b61@intel.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email]
X-Rspamd-Queue-Id: 258305DC9A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--EScZYE8yc4PJ+rAl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Tue, 26 May 2026 08:58:05 +0200
>=20
> > Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
> > driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware que=
ues
> > mapped to RX queues 24=E2=80=9331. LRO hw offloading does not support
> > Scatter-Gather (SG) so it is required to increase the page_pool allocat=
ion
> > order to 2 for RX queues 24=E2=80=9331 (LRO queues).
> >=20
> > Performance comparison between GRO and hw LRO has been carried out using
> > a 10Gbps NIC:
> >=20
> > GRO: ~2.7 Gbps
> > LRO: ~8.1 Gbps
> >=20
> > Please note with respect to the previous implementation, page_pool
> > allocation order has been reduced from 5 to 2.
> >=20
> > Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > @@ -587,6 +630,85 @@ static int airoha_qdma_get_gdm_port(struct airoha_=
eth *eth,
> >  	return port >=3D ARRAY_SIZE(eth->ports) ? -EINVAL : port;
> >  }
> > =20
> > +static int airoha_qdma_lro_rx_process(struct airoha_queue *q,
> > +				      struct airoha_qdma_desc *desc)
> > +{
> > +	u32 desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
> > +	u32 msg1 =3D le32_to_cpu(READ_ONCE(desc->msg1));
> > +	u32 msg2 =3D le32_to_cpu(READ_ONCE(desc->msg2));
> > +	u32 msg3 =3D le32_to_cpu(READ_ONCE(desc->msg3));
>=20
> Why are these READ_ONCE()s needed? Does desc come from the HW (sorry I
> didn't follow the whole code flow) or...?

Correct, ctrl, msg1, msg2 and msg3 are subfields of the DMA descriptor read=
 by
airoha_qdma_rx_process() from the NIC. I guess here we have a similar issue=
 as
the one fixed in [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?=
id=3D4ae0604a0673e11e2075b178387151fcad5111b5

>=20
> > +	struct sk_buff *skb =3D q->skb;
> > +	u32 len, th_off, tcp_ack_seq;
> > +	u16 tcp_win, l2_len;
> > +	struct tcphdr *th;
> > +	bool ipv4, ipv6;
> > +
> > +	if (FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) <=3D 1)
> > +		return 0;
> > +
> > +	ipv4 =3D FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
> > +	ipv6 =3D FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
> > +	if (!ipv4 && !ipv6)
> > +		return -EOPNOTSUPP;
> > +
> > +	l2_len =3D FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
> > +	len =3D FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
> > +	if (ipv4) {
> > +		struct iphdr *iph;
> > +
> > +		if (!pskb_may_pull(skb, l2_len + sizeof(*iph)))
> > +			return -EINVAL;
> > +
> > +		iph =3D (struct iphdr *)(skb->data + l2_len);
> > +		if (iph->protocol !=3D IPPROTO_TCP)
> > +			return -EOPNOTSUPP;
> > +
> > +		iph->tot_len =3D cpu_to_be16(len - l2_len);
> > +		iph->check =3D 0;
> > +		iph->check =3D ip_fast_csum((void *)iph, iph->ihl);
> > +		th_off =3D l2_len + (iph->ihl << 2);
> > +	} else {
> > +		struct ipv6hdr *ip6h;
> > +
> > +		if (!pskb_may_pull(skb, l2_len + sizeof(*ip6h)))
> > +			return -EINVAL;
> > +
> > +		ip6h =3D (struct ipv6hdr *)(skb->data + l2_len);
> > +		if (ip6h->nexthdr !=3D NEXTHDR_TCP)
> > +			return -EOPNOTSUPP;
> > +
> > +		ip6h->payload_len =3D cpu_to_be16(len - l2_len - sizeof(*ip6h));
> > +		th_off =3D l2_len + sizeof(*ip6h);
> > +	}
> > +
> > +	tcp_win =3D FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
> > +	tcp_ack_seq =3D le32_to_cpu(READ_ONCE(desc->data));
> > +
> > +	if (!pskb_may_pull(skb, th_off + sizeof(*th)))
> > +		return -EINVAL;
> > +
> > +	th =3D (struct tcphdr *)(skb->data + th_off);
> > +	th->ack_seq =3D cpu_to_be32(tcp_ack_seq);
> > +	th->window =3D cpu_to_be16(tcp_win);
> > +
> > +	/* Check tcp timestamp option */
> > +	if (th->doff =3D=3D (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
> > +		__be32 *topt =3D (__be32 *)(th + 1);
>=20
> Make sure you checked the code with sparse (sometimes it's needed to
> mark casts as __force, not this one tho)

$ make C=3D2 CHECK=3Dsparse drivers/net/ethernet/airoha/
  CHECK   scripts/mod/empty.c
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CHECK   drivers/net/ethernet/airoha/airoha_eth.c
  CHECK   drivers/net/ethernet/airoha/airoha_ppe.c
  CHECK   drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
  CHECK   drivers/net/ethernet/airoha/airoha_npu.c

$ sparse --version
v0.6.5-rc1

>=20
> > +
> > +		if (*topt =3D=3D cpu_to_be32((TCPOPT_NOP << 24) |
>=20
> Shouldn't this be `((u32)TCPOPT_NOP) << 24` to avoid sign issues?

I guess this is same approach used in [1]. Am I missing something?

[1] https://github.com/torvalds/linux/blob/master/net/ipv4/tcp_ipv4.c#L823

Regards,
Lorenzo

>=20
> > +					 (TCPOPT_NOP << 16) |
> > +					 (TCPOPT_TIMESTAMP << 8) |
> > +					 TCPOLEN_TIMESTAMP)) {
> > +			__le32 tcp_ts_reply =3D READ_ONCE(desc->tcp_ts_reply);
> > +
> > +			put_unaligned_be32(le32_to_cpu(tcp_ts_reply),
> > +					   topt + 2);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> Thanks,
> Olek

--EScZYE8yc4PJ+rAl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahYLvgAKCRA6cBh0uS2t
rD5IAQDm649Y+OIXgnX3tqPjEv0sZKv9Zt+HPJ2Car7wGP9blAD/QhomlYinsEb6
cOFaX+lWBwG7XoOzG8IhnE4orgKEuA8=
=Ypxv
-----END PGP SIGNATURE-----

--EScZYE8yc4PJ+rAl--

