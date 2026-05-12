Return-Path: <netdev+bounces-286966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEdeFL/IAmrmwgEAu9opvQ
	(envelope-from <netdev+bounces-286966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BD51B065
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05B4300903A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19114E3769;
	Tue, 12 May 2026 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vxamPC5x"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B0357D19;
	Tue, 12 May 2026 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567355; cv=none; b=YxWZ2zIP9s5Ht+C2UDHrUj49UQlOkfpmShwO3aZVUWnvMpe9h/1avWIa7L9EGCaw32w9HTLM2/odeBl/stVc6qx5FT0i7/lx/CprfKDve/1AN9dC5LAHq7TRsLp+UvrOWfWA71Q+DEnF8alsr4LsfThtP4itws59tRkIykEGjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567355; c=relaxed/simple;
	bh=Oo+KTjYKYfxwig/IKUE/DuqgmKu3ILJeUNkunDT+mHQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPFm/nHIgkqwX1DnrK3e+YlAHwsquALIV+yBFvyUQVAZY32CHTR1nFlUSGeiplgfn6N+R1YbSpIG01Pzyx1sm06AUQj3UjPeIRzp21bOihhX57CauSJ9IZzqRai6RGVxDoBp18t2YxqmoENYi927OrIEZWiuqxlXWZYTl7oGTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vxamPC5x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778567347; x=1810103347;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Oo+KTjYKYfxwig/IKUE/DuqgmKu3ILJeUNkunDT+mHQ=;
  b=vxamPC5x7Jn+ob9qxFZ76FdB5760npGncd5TCwRvO6uJt4Kv8Ljem/0N
   5+yWqAa5DkMfkjb0EgKPVAnhlY6fqA9TkXxu/jIX6BEW9epb/JualBIlB
   5TjiJ+cYvexlUdamNk/2csCVLZdTmuvFm/dh4P1uKeOAxhbsGOWUEMe75
   g9GBKNA/1jxa4P6A5NeMnmh7NVG8CL1LlJK6st3i/QwdicinFJjHOw+CM
   8WzUwS+Tr0CNe5seLulm0xAhPyp0LmVs0wqYNSMwpSz/2wxwO04bI04Tm
   Rm6j5RJZljB2lTu8pgNIkOObN/dm9EoLoc1kcZxdXcfooPH0vsPKF2FMP
   A==;
X-CSE-ConnectionGUID: rbouXjx3QOGRKvFETiyjeQ==
X-CSE-MsgGUID: j9+9l88vSauU/Pg6jiP03w==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="288736053"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 23:28:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 11 May 2026 23:28:50 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 11 May 2026 23:28:47 -0700
Message-ID: <5d440e2a4647a578c277e303a8ad7f0f4bc96767.camel@microchip.com>
Subject: Re: [PATCH net-next v4 1/9] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 08:28:46 +0200
In-Reply-To: <20260506014552.1616551-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-1-f1b6005fa8b7@microchip.com>
	 <20260506014552.1616551-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: BF9BD51B065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286966-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:45 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: add tag driver for LAN9645X
>=20
> Adds a DSA tag driver for Microchip LAN9645x switches operating with a
> front port configured as an NPI CPU port. RX uses a 16-byte long prefix
> plus a 28-byte internal frame header; TX uses only the IFH.
>=20
> > diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> > new file mode 100644
> > index 000000000000..81e7a78e0f81
> > --- /dev/null
> > +++ b/net/dsa/tag_lan9645x.c
>=20
> [ ... ]
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
>=20
> [ ... ]
>=20
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
> > +     /* Remove the long prefix + IFH + ifh_gap contribution from
> > +      * skb->csum so the stack sees a checksum consistent with the
> > +      * real Ethernet frame. skb->data currently points at the real
> > +      * MAC header.
> > +      */
> > +     skb_postpull_rcsum(skb,
> > +                        skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_l=
en,
> > +                        LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
>=20
> Does this skb_postpull_rcsum() call subtract the wrong region from
> skb->csum for CHECKSUM_COMPLETE frames?
>=20
> By the time lan9645x_rcv() is entered, the conduit's eth_type_trans()
> has already pulled the first ETH_HLEN (14) bytes of the long prefix and
> adjusted skb->csum accordingly, so skb->csum covers bytes starting at
> offset 14 (the remaining 2 bytes of the long prefix plus IFH plus any
> gap plus the real frame).
>=20
> At the point of the skb_postpull_rcsum() call, skb->data points at the
> real MAC header, i.e. at offset LAN9645X_TOTAL_TAG_LEN + ifh_gap_len
> from the start of the originally-received frame. So
> skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len points at offset 0,
> and the subtracted region is [0, LAN9645X_TOTAL_TAG_LEN + ifh_gap_len).
>=20
> That region includes the first 14 bytes that eth_type_trans() already
> removed from skb->csum, and it stops short of the real MAC header which
> also needs to be removed. Shouldn't the subtracted region instead start
> at what skb->data was on entry to rcv() (i.e. post-eth_type_trans) and
> cover LAN9645X_TOTAL_TAG_LEN + ifh_gap_len bytes from there, so that it
> matches what skb->csum actually covers?
>=20
> For reference, tag_ocelot.c (cited in the commit message as the
> architectural model) saves start =3D skb->data at function entry before
> any skb_push()/skb_pull() manipulation:
>=20
>     net/dsa/tag_ocelot.c:ocelot_rcv() {
>         ...
>         u8 *start =3D skb->data;
>         ...
>         skb_push(skb, ETH_HLEN);
>         skb_pull(skb, OCELOT_SHORT_PREFIX_LEN);
>         ...
>     }
>=20
> and later passes that saved pointer to skb_postpull_rcsum() with the
> total tag length, so the subtracted region exactly matches what the
> NIC's csum_complete covers.
>=20
> Would saving skb->data on entry (before the initial skb_push(ETH_HLEN))
> and passing that as the start argument, with length
> LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, produce the correct result here
> as well?

Hehe, this is what I did originally, but in the previous version sashiko
convinced me that was not correct. I do not have a CHECKSUM_COMPLETE=20
host to test it with unfortunately. But after looking at mlx5 it does seem
the original was correct and the (real) ethernet header should be subtracte=
d.

We can not save skb->data on entry, as it may have become stale. But just
swapping the order of skb_pull(skb, ETH_HLEN) and skb_postpul_rcsum should
give the desired effect. I will fix this in the next version.


