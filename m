Return-Path: <netdev+bounces-273949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bs/BXnKzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10A375F80
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F9530C198D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BE386546;
	Wed,  1 Apr 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c9nnB7Jd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A28381AE9;
	Wed,  1 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028758; cv=none; b=aRPOtm3cvfKa7GACOeLdraxE5U6Kkm0GSYfooHmskuAQQlVzt9EvQHXVeMYm6uxJDeNb5vd60dF7eUalREzV/6wWCsEGBeWol79FJsMPBqG61RZHliYNVEGp8cXmVlmmxSow5i0ai74OZwtkNcf7fgEVPYc3zOZllofTkkM5ZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028758; c=relaxed/simple;
	bh=lAkJjjHd7gHpaqpH3Cr1BqQoEkk7qoY8Ml90OwFuqBI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnbB5Gv9rxFpyklDeIZKmByjF7sbj6grxCfLFT4SVlOsvWbu2UNQqg9Ps67QYBwdTPb8M3PO3DWkYkxDZl8IMCX71fDKZwcQtvWQglBCWyUhDWb1teIabUHo0nu/Gvml5+LUoO2QDfGfJtD/BEakhnSYUDzAgFTDcNMsbnkFS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c9nnB7Jd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775028754; x=1806564754;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lAkJjjHd7gHpaqpH3Cr1BqQoEkk7qoY8Ml90OwFuqBI=;
  b=c9nnB7Jd5ywjwzWUlkWOs8ceEDu7hv82rNHBapu+daxXLCt3+7NJ/Xdd
   i/6jKJ90Bo3I7/MAu2bRRii86MALvP/RdId3RSaO1CHaTflBJBIAAviKI
   uDmK9PjTVIAR1JSOWGk0BMx0WH+8fhh/BfLIRfFn83MMBzo9s3z20abLB
   emQQX2jbe5Twy7cWTakZjRPPCXWU5aIjgTrF3VmwJasc67VTdyn0OuVz9
   +EoJCte2YWp+rjlGgasLXp77v4GyMwS+TPlRKis5wwkcit3X6aMgCtDDO
   ul/MMBrqsUUPn1xfuYuBNjk9wVFLeT24Y3QeRmjzE7hjVIiYM9kilZVGr
   w==;
X-CSE-ConnectionGUID: UB3oepBeSxy1sJkvz5/npA==
X-CSE-MsgGUID: 43Y3VxG0T1i7Bt7g4RF5DA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="54768591"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:32:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 1 Apr 2026 00:31:52 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 00:31:49 -0700
Message-ID: <5b731463a01dc4dbeaf98fe914fede8719786560.camel@microchip.com>
Subject: Re: [PATCH net-next v2 1/9] net: dsa: add tag driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 1 Apr 2026 09:31:49 +0200
In-Reply-To: <20260329195620.2789042-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-1-f7504e3b0681@microchip.com>
	 <20260329195620.2789042-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273949-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 8E10A375F80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: add tag driver for LAN9645X
>=20
> Add a tag driver for LAN9645x switches using a front port as the CPU port
> (NPI port). The driver configures a long prefix for extraction and no
> prefix for injection to handle the internal frame header (IFH).
>=20
> > diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> > new file mode 100644
> > index 000000000000..9130fb0d61be
> > --- /dev/null
> > +++ b/net/dsa/tag_lan9645x.c
>=20
> [ ... ]
>=20
> > +static void lan9645x_xmit_get_vlan_info(struct sk_buff *skb,
> > +                                     struct net_device *br,
> > +                                     u32 *vlan_tci, u32 *tag_type)
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
>=20
> Is it possible for a maliciously crafted packet (e.g., via AF_PACKET) to =
have a
> length of 14 bytes with h_vlan_proto set to ETH_P_8021Q?
>=20
> If so, vlan_remove_tag() would read vhdr->h_vlan_TCI at offset 14, causin=
g an
> out-of-bounds read.
>=20
> Furthermore, if the packet contains fragments and the VLAN header is not =
in the
> linear data area, vlan_remove_tag() could corrupt the SKB when shifting t=
he MAC
> header.
>=20
> Would it be safer to use skb_vlan_untag() instead?
>=20

I think skb_vlan_untag is for the rx path, and will not make sense here. Bu=
t I
can add a check like

	if (skb_headlen(skb) >=3D VLAN_ETH_HLEN &&
	    ntohs(hdr->h_vlan_proto) =3D=3D proto) {
		vlan_remove_tag(skb, &tci);
		*vlan_tci =3D tci;
	} else {

so we know the linear data area has the bytes.

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
>=20
> [ ... ]
>=20
> > +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> > +                                 struct net_device *ndev)
> > +{
> > +     u32 src_port, qos_class, vlan_tci, tag_type, popcnt, etype_ofs;
> > +     u8 *orig_skb_data =3D skb->data;
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
> > +     /* IFH starts after our long prefix */
> > +     ifh =3D skb_pull(skb, LAN9645X_LONG_PREFIX_LEN);
>=20
> Could skb_pull() return NULL here if skb->len is less than 16 bytes?
>=20
> If it returns NULL, the blind dereference of ifh in the subsequent
> lan9645x_ifh_get() calls would cause a NULL pointer dereference.
>=20
> Additionally, is the 44-byte tag (16-byte prefix + 28-byte IFH) guarantee=
d to
> be in the linear data buffer (skb->data)?
>=20
> Without calling pskb_may_pull(skb, LAN9645X_TOTAL_TAG_LEN) first, accessi=
ng it
> via the ifh pointer might result in out-of-bounds reads if the packet pay=
load
> is in paged fragments.
>=20


I can add pskb_may_pull calls to ensure skb->data is availble.

> > +
> > +     popcnt =3D lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
> > +     etype_ofs =3D lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_=
SZ);
> > +     src_port =3D lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
> --
> pw-bot: cr


