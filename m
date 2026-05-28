Return-Path: <netdev+bounces-292653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOV8EjEeGGocdggAu9opvQ
	(envelope-from <netdev+bounces-292653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421045F0E72
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00DD73004CBA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA263BCD3F;
	Thu, 28 May 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UDa0q30J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0053BE621;
	Thu, 28 May 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965112; cv=none; b=EIVlTAIqlUPynWC0HVVWMU/qkg6fboFe0+iF7Sfma0u7fdzaaMMSkYRJvN6+prIU8MQjI1dL36Bw5sZG0yewnD3M76ptHa19puSKPGxeTdDJEyThcYhHUmIOFdcgR4IDaJf9gU02iJucnLyZMlbNQ7vETcjGwiDyYamOX3IIxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965112; c=relaxed/simple;
	bh=xCvcxBoi6sSQp5l96sULqTiUk6uS/yJkDVs5eSxOPjA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjIzFgKT5W8kS2kAvgGmadfV7+LtScXDh/kPRQTLzulo2Pni1RsBZAtE+SFV9JvADp7MQmcGLj9POhflDhxtSSq1Yu2E7AdO9kV3j90Zpz1bw8u19OI69KEGO/R9rTwX2lUpwZ/wkCDW4+8UankokPZW6DtlEAvxGCTulhAAfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UDa0q30J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779965110; x=1811501110;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xCvcxBoi6sSQp5l96sULqTiUk6uS/yJkDVs5eSxOPjA=;
  b=UDa0q30JC21MX9eQGEsefiX3D85CII8XDTCW8I6qM7ALBM1ftZUAC+OG
   yhO5tcpWAey2H/00IhGot3IJy9H28rsK7wTFF6/ome0TyYy4bvt+6A8aH
   1U4h0LM+/SdaU0lgQ1q6IDKTEOCoT7EKUe5FJnNeV7quH1fkKpPmnM/gC
   MyQVMZ43697NAPI23bSjn9iZRCcDcdcuDYl7AdNp83s0h0f+y31X6hzmm
   TIzXBskS5y2pLl1UBhW/P452jU+pz3PgYsprnpYdnz/SMiw0rGLzuZC0u
   4UfJfPdDQbdSZ7wrCD/ggdSHGv+t657ADZrMS5bLto7YsAQGTpzsx08X4
   A==;
X-CSE-ConnectionGUID: gNyFdhNbTf+LTQLa/3jT3g==
X-CSE-MsgGUID: K/c9KGiKRO2P0+D5lkFyzQ==
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="289564143"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 03:45:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 03:45:05 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 28 May 2026 03:45:02 -0700
Message-ID: <58b1f1e49e97e8cba6611440419c3a9412991ced.camel@microchip.com>
Subject: Re: [PATCH net-next v6 1/9] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Thu, 28 May 2026 12:45:01 +0200
In-Reply-To: <2bcddaf2-e3b4-4f72-ae2d-1ac22c2e7553@gmail.com>
References: <20260527-dsa_lan9645x_switch_driver_base-v6-0-4d409ae64f3c@microchip.com>
	 <20260527-dsa_lan9645x_switch_driver_base-v6-1-4d409ae64f3c@microchip.com>
	 <2bcddaf2-e3b4-4f72-ae2d-1ac22c2e7553@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: 421045F0E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-27 at 17:39 +0200, Jonas Gorski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Hi,
>=20
> On 27/05/2026 16:49, Jens Emil Schulz =C3=83stergaard wrote:
> > Add tag driver for LAN9645x using a front port as CPU port. This mode
> > is called an NPI port in the datasheet.
> > Use long prefix on extraction (RX) and no prefix on injection (TX). A
> > long prefix on extraction helps get through the conduit port on host
> > side, since it will see a broadcast MAC.
> >=20
> > The LAN9645x chip is in the same design architecture family as ocelot
> > and lan966x. The tagging protocol has the same structure as these chips=
,
> > but the particular fields are different or have different sizes.
> > Therefore, this tag driver is similar to tag_ocelot.c, but the
> > differences in fields makes it hard to reuse.
> >=20
> > LAN9645x supports 3 different tag formats for extraction/injection of
> > frames from a CPU port: long prefix, short prefix and no prefix.
> >=20
> > The tag is prepended to the frame. The critical data for the chip is
> > contained in an internal frame header (IFH) which is 28 bytes. The
> > prefix formats look like this:
> >=20
> > Long prefix (16 bytes) + IFH:
> > - DMAC    =3D 0xffffffffffff on extraction.
> > - SMAC    =3D 0xfeffffffffff on extraction.
> > - ETYPE   =3D 0x8880
> > - payload =3D 0x0011
> > - IFH
> >=20
> > Short prefix (4 bytes) + IFH:
> > - 0x8880
> > - 0x0011
> > - IFH
> >=20
> > No prefix:
> > - IFH
> >=20
> > The format can be configured asymmetrically on RX and TX.
> >=20
> > The IFH get/set functions are declared as inline. All the field
> > constants are compile-time known, so when these calls are inlined
> > efficient code is generated with branches pruned and loops unrolled.
> > During testing it was observed that without explicit inlining GCC would
> > have trouble inlining the functions, which hurt performance.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
>=20
>=20
> (snip)
>=20
> > +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> > +                                 struct net_device *ndev)
> > +{
> > +     u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
> > +     struct dsa_port *dp;
> > +     u32 ifh_gap_len =3D 0;
> > +     u16 vlan_tpid;
> > +     u8 *ifh;
> > +
> > +     /* DSA master already consumed DMAC,SMAC,ETYPE from long prefix. =
Go back
> > +      * to beginning of frame.
> > +      */
> > +     skb_push(skb, ETH_HLEN);
> > +
> > +     if (unlikely(!pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN)))
> > +             return NULL;
> > +
> > +     /* IFH starts after our long prefix */
> > +     ifh =3D skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);
> > +
> > +     popcnt =3D lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
> > +     etype_ofs =3D lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_=
SZ);
> > +     src_port =3D lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
> > +     tag_type =3D lan9645x_ifh_get(ifh, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ)=
;
> > +     vlan_tci =3D lan9645x_ifh_get(ifh, IFH_TCI, IFH_TCI_SZ);
> > +     qos_class =3D lan9645x_ifh_get(ifh, IFH_QOS_CLASS, IFH_QOS_CLASS_=
SZ);
> > +
> > +     /* Set skb->data at start of real header
> > +      *
> > +      * Since REW_PORT_NO_REWRITE=3D0 is required on the NPI port, we =
need to
> > +      * account for any tags popped by the hardware, as that will leav=
e a gap
> > +      * between the IFH and DMAC.
> > +      */
> > +     if (popcnt =3D=3D 0 && etype_ofs =3D=3D 0)
> > +             ifh_gap_len =3D 2 * VLAN_HLEN;
> > +     else if (popcnt =3D=3D 3)
> > +             ifh_gap_len =3D VLAN_HLEN;
> > +
> > +     skb_pull(skb, LAN9645X_IFH_LEN);
> > +
> > +     if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN)))
> > +             return NULL;
> > +
> > +     skb_pull(skb, ifh_gap_len);
> > +     skb_reset_mac_header(skb);
> > +     skb_set_network_header(skb, ETH_HLEN);
> > +     skb_reset_mac_len(skb);
> > +
> > +     /* Reset skb->data past the actual ethernet header. */
> > +     skb_pull(skb, ETH_HLEN);
> > +
> > +     /* We must deliver the skb so skb->csum only covers the data beyo=
nd the
> > +      * real ethernet header. The fake ethernet header in the prefix i=
s
> > +      * not part of skb->csum already. We must subtract what remains o=
f the
> > +      * prefix, the ifh and the gap.
> > +      */
> > +     skb_postpull_rcsum(skb,
> > +                        skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_l=
en,
> > +                        LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
> > +
> > +     skb->dev =3D dsa_conduit_find_user(ndev, 0, src_port);
> > +     if (WARN_ON_ONCE(!skb->dev)) {
> > +             /* This should never happen since we have disabled reflec=
tion
> > +              * back to CPU_PORT.
> > +              */
> > +             return NULL;
> > +     }
> > +
> > +     dsa_default_offload_fwd_mark(skb);
>=20
> Does the switch (by default) also flood link local traffic (e.g. STP, LAC=
P,
> etc)? If not, you should not mark these as fwd offloaded so that the kern=
el
> knows that it needs to do that in software if requested.
>=20
> Is there is a bit in the header that says whether a packet was flooded or
> trapped to CPU that you can check?
>=20
> Best regards,
> Jonas

No the chip is configured to trap these frames, so I think you are right th=
at
at the moment we do not honor BR_NO_STP nor group_fwd_mask. I will fix this=
 in the
next version. I plan to just use is_link_local_ether_addr.

Thanks,
Emil


