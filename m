Return-Path: <netdev+bounces-274133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCc5EWs3zWmxawYAu9opvQ
	(envelope-from <netdev+bounces-274133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0337CE39
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A12D3241EB9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59335477E22;
	Wed,  1 Apr 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HQNj5fq1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF944B687;
	Wed,  1 Apr 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054721; cv=none; b=blDAytQvqkj0dOJtOS4mNbbmTgoDk1F92Qu0Fvf2xFcr3gsMH9LBXaAPGGfamkaPxPWbb3st4tPPBheZvzBx8NJw1DbKiUyRINzuhelD+LJZXQDKlC/Zx0B/g2PkvV0NTGUdzYeQgRReRQZ71Q+I0UakZZZmzNaFA5RuGWctYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054721; c=relaxed/simple;
	bh=rddPStbzk+Do50n9A1ISbAAfQVSDvDOgkiUirreABp4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VegVHbTE/4RK++/MpaV/+grrWusfpy4LgChGdtMN4d8Bv/NbEKYqmb7DVknx+CiAbksEHV/Y1n0bYmbQ/yFkr+h6eCRRRifQuFyTU3JPbXQjd2lrsZEShA66z9weZw/XmXxWGqCkV74mpwz4ftxzDziZcne+yBEaJN+ynf+NNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HQNj5fq1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775054719; x=1806590719;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rddPStbzk+Do50n9A1ISbAAfQVSDvDOgkiUirreABp4=;
  b=HQNj5fq16qmUSAaiVZTTN1P8j1wVZJmjgkJHLThnkneUMnNOzpVn5f0P
   QK15FIXpabJShbfs2LlR2VOKW2zt2G9cTlKZPUdpSolOyF5CE86xuaqv4
   BsrlVpRJ6MDwqKmp0rmPuRpNBAgzc3QFr4zcLLx+dqmNUv5xLg/UEsWE3
   6WComMKzZh0yq0f5Ac6M1FDUdDYUrVbHy/vWyecrK7wSEprwg2+RZE3oM
   5GyI9IZF5/pZBO172Q712v6lQiaYI9MVEhymdIeutXCgrN/d1DALOap44
   rbH8YXME3mtiutNJQsua0Vt16KlrkFuuHxc3JXWePnswP516c6Z117KBv
   Q==;
X-CSE-ConnectionGUID: eZBMvTqiS9GvfE6aojStTQ==
X-CSE-MsgGUID: tctTgIebRcqhT1fg1N2Jzg==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="222802746"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:45:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 1 Apr 2026 07:44:39 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 07:44:36 -0700
Message-ID: <7cbf6ce794fa4a3831308f607b19d325572370bf.camel@microchip.com>
Subject: Re: [PATCH net-next v2 6/9] net: dsa: lan9645x: add vlan support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 1 Apr 2026 16:44:35 +0200
In-Reply-To: <20260329195633.2789187-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-6-f7504e3b0681@microchip.com>
	 <20260329195633.2789187-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274133-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81D0337CE39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: lan9645x: add vlan support
>=20
> Add support for vlanaware bridge. We reserve vid 4095 for standalone
> mode, to implement fdb-isolation. A vlan-unaware bridge uses vid 0.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index 599e589c4ec3..046c95a72242 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> [ ... ]
> > @@ -535,11 +536,54 @@ static void lan9645x_port_bridge_leave(struct dsa=
_switch *ds, int port,
> [ ... ]
> > +static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int por=
t,
> > +                                     bool enabled,
> > +                                     struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +     p->vlan_aware =3D enabled;
> > +     lan9645x_vlan_port_apply(p);
>=20
> In other places, the driver avoids calling egress functions on the npi
> port because it conflicts with cpu port header extraction. Since this
> unconditionally applies the vlan configuration to both ingress and egress=
,
> could this overwrite the npi port's configuration when the state is
> synchronized?
>=20

It is true we avoid this, but the vlan_filtering is not called by DSA core =
for
the cpu port, only user ports.

> > +
> > +     return 0;
> > +}
> > +
> > +static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
> [ ... ]
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > new file mode 100644
> > index 000000000000..0459932a626c
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> [ ... ]
> > +static void lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
> > +{
> > +     struct lan9645x_vlan *v =3D &lan9645x->vlans[vid];
> > +     bool cpu_dis =3D !(v->portmask & BIT(CPU_PORT));
> > +     u32 val;
> > +
> > +     val =3D ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
> > +           ANA_VLANTIDX_V_INDEX_SET(vid) |
> > +           ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(v->s_fwd_ena) |
> > +           ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(v->fld_dis) |
> > +           ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(v->prv_vlan) |
> > +           ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(v->lrn_dis) |
> > +           ANA_VLANTIDX_VLAN_MIRROR_SET(v->mir) |
> > +           ANA_VLANTIDX_VLAN_SRC_CHK_SET(v->src_chk);
> > +
> > +     lan_wr(val, lan9645x, ANA_VLANTIDX);
> > +     lan_wr(v->portmask, lan9645x, ANA_VLAN_PORT_MASK);
> > +     lan_wr(VLANACCESS_CMD_WRITE, lan9645x, ANA_VLANACCESS);
>=20
> Are these registers written with raw values rather than using their respe=
ctive
> set macros? This circumvents the register abstraction and might risk fail=
ures
> if the hardware layout changes.
>=20

Yes, they are single field registers. I can add the macro.

> > +
> > +     if (lan9645x_vlan_wait_for_completion(lan9645x))
> > +             dev_err(lan9645x->dev, "Vlan set mask failed\n");
> > +}
> [ ... ]
> > +static void
> > +lan9645x_vlan_port_apply_egress(struct lan9645x_port *p,
> > +                             struct lan9645x_vlan_port_info *info)
> > +{
> [ ... ]
> > +     lan_rmw(REW_TAG_CFG_TAG_TPID_CFG_SET(3) |
> > +             REW_TAG_CFG_TAG_CFG_SET(tag_cfg),
> > +             REW_TAG_CFG_TAG_TPID_CFG |
> > +             REW_TAG_CFG_TAG_CFG,
> > +             lan9645x, REW_TAG_CFG(p->chip_port));
> > +
> > +     lan_rmw(REW_PORT_VLAN_CFG_PORT_TPID_SET(ETH_P_8021AD) |
> > +             REW_PORT_VLAN_CFG_PORT_VID_SET(port_vid),
> > +             REW_PORT_VLAN_CFG_PORT_TPID |
> > +             REW_PORT_VLAN_CFG_PORT_VID,
> > +             lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
> > +}
>=20
> Setting the port tpid to 0x88a8 causes untagged ingress frames to egress =
trunk
> ports with 802.1ad tags. Could this break interoperability with standard
> networks that expect 0x8100 tags?
>=20

No that is not how it works. I think the comment which is left out explains=
 this
clearly. 0x8100 tags are unaffected by this, but it means an stag is not re=
written
to a ctag.

> > +static void lan9645x_vlan_port_apply_ingress(struct lan9645x_port *p)
> > +{
> [ ... ]
> > +     /* Drop frames with multicast source address */
> > +     val =3D ANA_DROP_CFG_DROP_MC_SMAC_ENA_SET(1);
> > +     if (p->vlan_aware && !pvid)
> > +             /* If port is vlan-aware and tagged, drop untagged and pr=
iority
> > +              * tagged frames.
> > +              */
> > +             val |=3D ANA_DROP_CFG_DROP_UNTAGGED_ENA_SET(1) |
> > +                    ANA_DROP_CFG_DROP_PRIO_S_TAGGED_ENA_SET(1) |
> > +                    ANA_DROP_CFG_DROP_PRIO_C_TAGGED_ENA_SET(1);
> > +
> > +     lan_wr(val, lan9645x, ANA_DROP_CFG(p->chip_port));
> > +}
>=20
> Does this overwrite the entire 32-bit register and silently clear other
> initialized bitfields? Would it be safer to use a read-modify-write here
> instead?
>=20

Yes this is intentional. I prefer this over writing all fields with rmw whi=
ch is
slower.

> [ ... ]
> > +static int lan9645x_vlan_cpu_add(struct lan9645x_port *p, u16 vid, boo=
l pvid,
> > +                              bool untagged)
> > +{
> > +     struct lan9645x_vlan *v;
> > +
> > +     v =3D lan9645x_vlan_port_modify(p, vid, pvid, untagged);
>=20
> Is it intentional that this bypasses the bounds check on the vlan id?
>=20

No, I will move the cpu action below the bounds check.

> > +     v->portmask |=3D BIT(CPU_PORT) | BIT(p->chip_port);
> > +     lan9645x_vlan_hw_wr(p->lan9645x, vid);
> > +     lan9645x_vlan_port_apply_ingress(p);
> > +
> > +     return 0;
> > +}
> > +
> > +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool=
 pvid,
> > +                             bool untagged, struct netlink_ext_ack *ex=
tack)
> > +{
> [ ... ]
> > +void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid)
> > +{
> > +     struct lan9645x *lan9645x =3D p->lan9645x;
> > +     struct lan9645x_vlan *v;
> > +
> > +     if (!vid)
> > +             return;
> > +
> > +     v =3D lan9645x_vlan_port_modify(p, vid, false, false);
>=20
> There is a check for the maximum vlan id when adding a vlan, but no bound=
s
> check when deleting one. Could userspace use this to delete the reserved
> vid 4095 and break standalone forwarding?
>=20

I will add the bounds check for delete.

> > +     v->portmask &=3D ~BIT(p->chip_port);
> > +
> > +     if (p->chip_port =3D=3D lan9645x->npi)
> > +             v->portmask &=3D ~BIT(CPU_PORT);
> > +
> > +     lan9645x_vlan_hw_wr(lan9645x, vid);
> [ ... ]
> > +void lan9645x_vlan_init(struct lan9645x *lan9645x)
> > +{
> [ ... ]
> > +     for (vid =3D 1; vid < VLAN_N_VID; vid++)
> > +             lan9645x_vlan_hw_wr(lan9645x, vid);
>=20
> If the indirect table access times out, the write function prints an erro=
r
> but does not return a status code. Will this cause the initialization loo=
p
> to stall for the full timeout duration 4095 consecutive times if the
> hardware is unresponsive?
>=20

Yes, I can return the err from vlan_hw_wr and return it early from vlan_ini=
t.

> > +
> > +     /* Set all the ports + cpu to be part of HOST_PVID and UNAWARE_PV=
ID */
> > +     lan9645x->vlans[HOST_PVID].portmask =3D all_ports;


