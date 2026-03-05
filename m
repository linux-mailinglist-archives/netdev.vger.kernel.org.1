Return-Path: <netdev+bounces-264400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J0LEWiLqWl3/AAAu9opvQ
	(envelope-from <netdev+bounces-264400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:55:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8512212DBC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D6E30BFA93
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A23A5E88;
	Thu,  5 Mar 2026 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vhjkxXVN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D83793AF;
	Thu,  5 Mar 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718846; cv=none; b=PmezVK93ht3qfzpdJc0Z8PnPCZd6q/MlHBwgvzpcvTIAg34/7i9+bfsdLy6S6cgIwRIfdQfQ8M890fax070kYuUuDuVHtFDw+LkDpLRs+sUkfC2xSfWWiv8aLvobBsDzgsGENQ9UNGGkFdRgCn2O9qSvASST3NHFON9QlDsXfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718846; c=relaxed/simple;
	bh=tCl6/GMKmQ3BxAmgEOZu6/xM8rVKQDzWssWhsDrZvc4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H8S9QSPlXdw5IkYPhvm+p/WOV9AUdJCLZQ1QiS5q1BOs6lZEOiSsYkl/dUqTfGXqjcwYBojUwzVYC+JY3FBPbfM5Rl4nQDeM5alSxEbKSX2sxEl73gIlAszI7o/GHWHXkFkWdxUVt7ViAn/Zh7Hj67LeHxeyZwoJ//tr+cDf+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vhjkxXVN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772718845; x=1804254845;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tCl6/GMKmQ3BxAmgEOZu6/xM8rVKQDzWssWhsDrZvc4=;
  b=vhjkxXVN+/8N8ZRBTVelvn3AB+5ReXdmntzesgQ5g6TMuMmSukUaHhWi
   eGz9U1eiBuPWCVwvAChgaKrQnjo8bWfvvvxTNMF5lIXape0Riq0Sgjc5h
   MmJgxBV39ug1YicyaVveNqF5hB5dpaPBoYhvKwsmP3blorAkwT/qlfDBg
   /fcL7uSt8Uu32SiSZrPPvPpQj+Ze/F25ObO2VlwxnXRvB35bf55dYabI7
   27jnypsigqGpM/Iv+ZTMqVAOOEp4nJPQ6EYIucPqKjxRJCh+vWhITtUBv
   crLEO9qBXpBdDInjhOld0IDnGKv7OLM/GE2CuOR8YvGKDYU+1XtiRLx/t
   A==;
X-CSE-ConnectionGUID: 53Fw462UR1+dIo39tzfrSg==
X-CSE-MsgGUID: x9GW6meWQA6aIc7I/EugbA==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="54264246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 06:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Mar 2026 06:53:50 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:53:47 -0700
Message-ID: <3811e2284c284a3260cf7f746e97fd28426b8ef1.camel@microchip.com>
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 14:53:46 +0100
In-Reply-To: <20260303161147.bgbltslwrl2gtd7p@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
	 <20260303161147.bgbltslwrl2gtd7p@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B8512212DBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 18:11 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:27PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Use long prefix on extraction (RX) and no prefix on injection (TX). A
> > long prefix on extraction helps get through the conduit port on host
> > side, since it will see a broadcast MAC.
> (...)
> > The format can be configured asymmetrically on RX and TX.
>=20
> Do you foresee a need to configure the prefix length? It would be
> possible to do that by changing the tagging protocol. But it implies
> that the "lan9645x" string as found in /sys/class/net/.../dsa/tagging
> becomes user ABI that is set in stone. It will mean long extraction
> prefix and no injection prefix. Otherwise user space will get very
> confused (libpcap, XDP, whatever else might get written).
>=20

That is a good point, so the prefix choice could be baked into the name lik=
e
lan9645x-long? I do not forsee a need to configure the prefix. I wanted to
mention it because it is a difference with the ocelot driver.

> > +static inline u32 lan9645x_ifh_get(const u8 *ifh, size_t pos, size_t l=
ength)
> > +{
> > +     size_t end =3D (pos + length) - 1;
> > +     size_t start_u8 =3D pos >> 3;
> > +     size_t end_u8 =3D end >> 3;
> > +     size_t end_rem =3D end & 0x7;
> > +     size_t pos_rem =3D pos & 0x7;
> > +     u8 end_mask, start_mask;
> > +     const u8 *ptr;
> > +     u32 val;
> > +
> > +     end_mask =3D BTM_MSK(end_rem);
> > +     start_mask =3D TOP_MSK(pos_rem);
> > +
> > +     ptr =3D &ifh[LAN9645X_IFH_LEN - 1 - end_u8];
> > +
> > +     if (end_u8 =3D=3D start_u8)
> > +             return (*ptr & end_mask & start_mask) >> pos_rem;
> > +
> > +     val =3D *ptr++ & end_mask;
> > +
> > +     for (size_t j =3D 1; j < end_u8 - start_u8; j++)
> > +             val =3D val << 8 | *ptr++;
> > +
> > +     return val << (8 - pos_rem) | (*ptr & start_mask) >> pos_rem;
> > +}
>=20
> If performance isn't a huge concern, pack() and unpack() certainly seem
> simpler than having your own implementation.
>=20

I did see pack/unpack, but I had some trouble getting gcc to inline them.
The performance on the CPU port with our development hosts is less than=C2=
=A0
expected, so I tried to make this reasonably fast.

> > +
> > +static inline void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
> > +                                            struct net_device *br,
> > +                                            u32 *vlan_tci, u32 *tag_ty=
pe)
> > +{
> > +     struct vlan_ethhdr *hdr;
> > +     u16 proto, tci;
> > +
> > +     if (!br || !br_vlan_enabled(br)) {
> > +             *vlan_tci =3D 0;
> > +             *tag_type =3D LAN9645X_IFH_TAG_TYPE_C;
> > +             return;
> > +     }
> > +
> > +     hdr =3D (struct vlan_ethhdr *)skb_mac_header(skb);
> > +     br_vlan_get_proto(br, &proto);
> > +
> > +     if (ntohs(hdr->h_vlan_proto) =3D=3D proto) {
> > +             vlan_remove_tag(skb, &tci);
> > +             *vlan_tci =3D tci;
> > +     } else {
> > +             rcu_read_lock();
> > +             br_vlan_get_pvid_rcu(br, &tci);
> > +             rcu_read_unlock();
> > +             *vlan_tci =3D tci;
> > +     }
> > +
> > +     *tag_type =3D (proto !=3D ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S =
:
> > +                                          LAN9645X_IFH_TAG_TYPE_C;
> > +}
> > +
> > +#endif /* _NET_DSA_TAG_LAN9645X_H_ */
>=20
> Why do these need to live in a separate include file? Who else needs
> access to them other than the tagger?
>=20

You are right I will move them to the .c file.

> > +static const struct dsa_device_ops lan9645x_netdev_ops =3D {
> > +     .name =3D LAN9645X_NAME,
> > +     .proto =3D DSA_TAG_PROTO_LAN9645X,
> > +     .xmit =3D lan9645x_xmit,
> > +     .rcv =3D lan9645x_rcv,
> > +     .needed_headroom =3D LAN9645X_TOTAL_TAG_LEN,
> > +     .promisc_on_conduit =3D false,
>=20
> Initializing with false is unnecessary.

I will remove it in the next version.

>=20
> > +};
> > +
> > +MODULE_DESCRIPTION("DSA tag driver for LAN9645x family of switches, us=
ing NPI port");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN9645X, LAN9645X_NAME);
> > +
> > +module_dsa_tag_driver(lan9645x_netdev_ops);
> >=20
> > --
> > 2.52.0
> >=20

Thanks,
Emil


