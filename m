Return-Path: <netdev+bounces-286982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MNODlHXAmppyAEAu9opvQ
	(envelope-from <netdev+bounces-286982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A446A51BDF2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419D1302F6A8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA603FF88D;
	Tue, 12 May 2026 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="abPetoUt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A247D935;
	Tue, 12 May 2026 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571008; cv=none; b=kNTW10uWOc4MTCPCmUEsuRVNYJCshpQE4Uctd5lkX0Ft2dU5QbgCz1v7Y1ovJAmvABbvmSJtyxwU8MnNkZ0eJOOPPlhTyZS0hBh1WR+3kK8Mt2IOt4JSoWwxHBdOrN88HW83buziHO/Io4Y3UoyorUhqOLc/URdFIJ8BXixDz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571008; c=relaxed/simple;
	bh=oNERn6uVrxPJ/VMXEUf0cH+o+njSNads3J87DXMXLbo=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoUafNo/MKyx69HOlvInLjm7/YFWgfNGkdfWECPfAXt4LueordIEq6c+0YhQHBX3uunQDi1hImfy6TvymahJG2FFptMvCLz0j1Mc81Rl5XmhvBy+l/j9ZOXBHmMKSoSWeuIEoNxDeTwjE4zpy/6msUJwJIgX1ToXcisNpulYp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=abPetoUt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778571004; x=1810107004;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oNERn6uVrxPJ/VMXEUf0cH+o+njSNads3J87DXMXLbo=;
  b=abPetoUtn1vsOw94Z1Doa3B6Obw5osfrMG7zPyAJx0E//R8jY98GHp8z
   aDQs+eU2EDTGqD1oIMoQIBLaVbwhz3p6JrvJB03eVvAhHoDstjHWN44Pe
   J/5QoIIBzwhd9jYXEgCg+6ZemYVf6SzLcnC47p6Dgim0ugBp9/GmX+qtA
   MZ9OE+Sr82tptoYwH4+UI+iGl2HbzaiZ79uMw3EXSgfo/snxV5CFohpx9
   2+Bg2f1+OI7qqocb5bgqOoqr0qhb/umiN20tADBX90nxNa2CqrHs+zCxy
   YLFcSHNmKIhjr6zj9KT59F8V3FOoz8Lb86eP+htLyernS1QWt1A5Vxp3T
   A==;
X-CSE-ConnectionGUID: EHFagO9nRyi9rdjnkMgyCg==
X-CSE-MsgGUID: sAAi7OJsT8aQpsoBrXcPBA==
X-IronPort-AV: E=Sophos;i="6.23,230,1770620400"; 
   d="scan'208";a="224611948"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:30:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 12 May 2026 00:30:00 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 12 May 2026 00:29:57 -0700
Message-ID: <c7dd8ba9f61899e7eab4b0551abcc379697c5152.camel@microchip.com>
Subject: Re: [PATCH net-next v4 6/9] net: dsa: lan9645x: add vlan support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 12 May 2026 09:29:56 +0200
In-Reply-To: <20260506014611.1616806-1-kuba@kernel.org>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-6-f1b6005fa8b7@microchip.com>
	 <20260506014611.1616806-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A446A51BDF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286982-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

On Tue, 2026-05-05 at 18:46 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add vlan support
>=20
> Adds VLAN-aware bridge support to the lan9645x DSA driver, wiring up
> .port_vlan_filtering, .port_vlan_add and .port_vlan_del, along with a
> new lan9645x_vlan.c that programs the hardware VLAN table and per-port
> ingress/egress tag handling. Reserves PVIDs for standalone and unaware
> modes to implement FDB isolation.
>=20
> > net: dsa: lan9645x: add vlan support
> >=20
> > Add support for vlanaware bridge. We reserve vid 4095 for standalone
> > mode, to implement fdb-isolation. A vlan-unaware bridge uses vid 0.
>=20
> Does the commit message accurately describe the reserved VID range?
> Looking at drivers/net/dsa/microchip/lan9645x/lan9645x_main.h:
>=20
>     #define UNAWARE_PVID                    0
>     #define HOST_PVID                       4095
>     #define VLAN_HSR_PRP                    4094
>     #define VLAN_MAX                        (VLAN_HSR_PRP - 1)
>=20
> VLAN_MAX ends up at 4093, and both the add and delete paths reject any
> vid > VLAN_MAX, with an extack that says "VLAN range 4094-4095
> reserved.". So in practice both 4094 and 4095 are removed from the
> user-visible VID space, not only 4095 as the commit log states. Could
> the message be updated to reflect that, and to clarify that "A
> vlan-unaware bridge uses vid 0" refers to an internal UNAWARE_PVID
> rather than to a VID provisioned by the bridge core (the driver
> silently returns 0 for vid =3D=3D 0)?
>=20

I will update the commit message.

> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > new file mode 100644
> > index 000000000000..854a2dde1ecf
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
>=20
> [ ... ]
>=20
> > +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool=
 pvid,
> > +                             bool untagged, struct netlink_ext_ack *ex=
tack)
> > +{
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     struct lan9645x_vlan_port_info info;
> > +     struct lan9645x_vlan old_vlan;
> > +     struct lan9645x_vlan *v;
> > +     u16 old_pvid;
> > +
> > +     /* Kernel VLAN core adds vid 0, which collides with our UNAWARE_P=
VID.
> > +      * We handle priority tagged frames by other means.
> > +      */
> > +     if (!vid)
> > +             return 0;
> > +
> > +     if (vid > VLAN_MAX) {
> > +             NL_SET_ERR_MSG_MOD(extack, "VLAN range 4094-4095 reserved=
.");
> > +             return -EBUSY;
> > +     }
>=20
> Is reserving VID 4094 for HSR/PRP appropriate at this point? Grepping
> the series shows VLAN_HSR_PRP has no consumer beyond its use in the
> definition of VLAN_MAX, and no HSR/PRP code is present in-tree for
> this driver.
>=20
> The net effect is that 4094, a valid 802.1Q VID, is permanently
> carved out of the user-visible VLAN space on first merge. Would it be
> better to only reserve 4095 now, and introduce the 4094 reservation
> together with the HSR/PRP support that actually consumes it?
>=20

I will remove VLAN_HSR_PRP as it is not used at the moment.


> On the errno choice: -EBUSY conventionally implies a transient
> condition that might succeed on retry, but this rejection is
> permanent for any VID above VLAN_MAX. Would -EOPNOTSUPP (or -EINVAL,
> for a structurally out-of-range VID) be a better fit here, so that
> userspace tooling does not interpret the failure as retryable?
>=20

I will use -EINVAL instead of -EBUSY in both add and del.

> > +int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
> > +{
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     struct lan9645x_vlan *v;
> > +
> > +     if (!vid)
> > +             return 0;
> > +
> > +     if (vid > VLAN_MAX)
> > +             return -EBUSY;
>=20
> Same question for the delete path: should this be -EOPNOTSUPP (or
> similar) rather than -EBUSY for a permanently reserved VID?


