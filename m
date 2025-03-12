Return-Path: <netdev+bounces-174276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2444A5E1B1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE20189D9F2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AF1D5174;
	Wed, 12 Mar 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKFe9MIr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8E1D5166
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796570; cv=none; b=hGTgU/rmCUEUz5ftVne0LAwaNOgxL9SDpgvaS8FD09EqvbtOFU57uznYFjrheWPMbe58RTnWZP2jpA9NZmp3sRs3T7QgvXhT7PyV55xYPjzc7//ioShFwJw7deM4gmo5nnu3x+T7RvIuJJXqQZL8tuGh1afNGrxI3Xd+thf+efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796570; c=relaxed/simple;
	bh=MEYh0ZT0sRe83r04PfTWCeCt/YnrQXMWxe3GyRoEARE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVJeDvL8edCLqE+ybwflJdBeqEAl+jNWbQTWDcPn1IwEdBlQY4lwlXYRmLkiWvn5BT7aeQNEF1/M2uSB456Cok2nBp7wDagcCtcN5rDAH8AY31RtX5Rg5oF/fgly8IepQOEatUNJTEMHdmy8/fSYgt60TFUK2/i1aCm71aAxxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKFe9MIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B8EC4CEDD;
	Wed, 12 Mar 2025 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741796569;
	bh=MEYh0ZT0sRe83r04PfTWCeCt/YnrQXMWxe3GyRoEARE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKFe9MIrBw5OOtfUqC1N7gEzlOhCyCC1sTBRTou7khycxelf//sewqK4MxituQvf8
	 WRk359xTuyn0gn3SvIv4yBbXj/9a/5IGHcRULX2DwvAU+KkVxUtzMDK8CrYqXwqeZv
	 G4IvuJsLejXYD94CxBWFBUaQlG1DvZWXXH0QUUsE8dVk00K2ddbU31FAahUlIFv5/M
	 8lK6bTg0QnVtrO1wtYlMQLYQKghrCjMy07ClmZ8/s0zkNbEgpZ8gDF/rwqsLpEpGxX
	 2OKpkvo3NCdk7iLNc9P6JBtPVezXkiF4ahzXR0ZGPa07A+Jr2T/L5DoGTc2pglbA1u
	 uRaot17Vvdgpg==
Date: Wed, 12 Mar 2025 17:22:47 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9G01zGCpbw1YHNs@lore-desk>
References: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
 <Z9Ga7gx1u3JsOemE@localhost.localdomain>
 <Z9GgHZxkSqFCkwMg@lore-desk>
 <Z9GtKwAuEx+7HKjR@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aCGyFJzoSWN6SOr5"
Content-Disposition: inline
In-Reply-To: <Z9GtKwAuEx+7HKjR@localhost.localdomain>


--aCGyFJzoSWN6SOr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Mar 12, 2025 at 03:54:21PM +0100, Lorenzo Bianconi wrote:
> > > On Wed, Mar 12, 2025 at 12:31:46PM +0100, Lorenzo Bianconi wrote:
> > > > The system occasionally crashes dereferencing a NULL pointer when i=
t is
> > > > forwarding constant, high load bidirectional traffic.
> > > >=20
> > > > [ 2149.913414] Unable to handle kernel read from unreadable memory =
at virtual address 0000000000000000
> > > > [ 2149.925812] Mem abort info:
> > > > [ 2149.928713]   ESR =3D 0x0000000096000005
> > > > [ 2149.932762]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > [ 2149.938429]   SET =3D 0, FnV =3D 0
> > > > [ 2149.941814]   EA =3D 0, S1PTW =3D 0
> > > > [ 2149.945187]   FSC =3D 0x05: level 1 translation fault
> > > > [ 2149.950348] Data abort info:
> > > > [ 2149.953472]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > > > [ 2149.959243]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > > [ 2149.964593]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > > [ 2149.970243] user pgtable: 4k pages, 39-bit VAs, pgdp=3D000000008=
b507000
> > > > [ 2149.977068] [0000000000000000] pgd=3D0000000000000000, p4d=3D000=
0000000000000, pud=3D0000000000000000
> > > > [ 2149.986062] Internal error: Oops: 0000000096000005 [#1] SMP
> > > > [ 2150.082282]  arht_wrapper(O) i2c_core arht_hook(O) crc32_generic
> > > > [ 2150.177623] CPU: 0 PID: 38 Comm: kworker/u9:1 Tainted: G        =
   O       6.6.73 #0
> > > > [ 2150.185362] Hardware name: Airoha AN7581 Evaluation Board (DT)
> > > > [ 2150.191189] Workqueue: nf_ft_offload_add nf_flow_rule_route_ipv6=
 [nf_flow_table]
> > > > [ 2150.198653] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> > > > [ 2150.205615] pc : airoha_ppe_flow_offload_replace.isra.0+0x6dc/0x=
c54
> > > > [ 2150.211882] lr : airoha_ppe_flow_offload_replace.isra.0+0x6cc/0x=
c54
> > > > [ 2150.218149] sp : ffffffc080e8ba10
> > > > [ 2150.221456] x29: ffffffc080e8bae0 x28: ffffff80080b0000 x27: 000=
0000000000000
> > > > [ 2150.228591] x26: ffffff8001c70020 x25: 0000000000000002 x24: 000=
0000000000000
> > > > [ 2150.235727] x23: 0000000061000000 x22: 00000000ffffffed x21: fff=
fffc080e8bbb0
> > > > [ 2150.242862] x20: ffffff8001c70000 x19: 0000000000000008 x18: 000=
0000000000000
> > > > [ 2150.249998] x17: 0000000000000000 x16: 0000000000000000 x15: 000=
0000000000000
> > > > [ 2150.257133] x14: 0000000000000001 x13: 0000000000000008 x12: 010=
1010101010101
> > > > [ 2150.264268] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000041 x9 : 000=
0000000000000
> > > > [ 2150.271404] x8 : ffffffc080e8bad8 x7 : 0000000000000000 x6 : 000=
0000000000015
> > > > [ 2150.278540] x5 : ffffffc080e8ba4e x4 : 0000000000000004 x3 : 000=
0000000000000
> > > > [ 2150.285675] x2 : 0000000000000008 x1 : 00000000080b0000 x0 : 000=
0000000000000
> > > > [ 2150.292811] Call trace:
> > > > [ 2150.295250]  airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
> > > > [ 2150.301171]  airoha_ppe_setup_tc_block_cb+0x7c/0x8b4
> > > > [ 2150.306135]  nf_flow_offload_ip_hook+0x710/0x874 [nf_flow_table]
> > > > [ 2150.312168]  nf_flow_rule_route_ipv6+0x53c/0x580 [nf_flow_table]
> > > > [ 2150.318200]  process_one_work+0x178/0x2f0
> > > > [ 2150.322211]  worker_thread+0x2e4/0x4cc
> > > > [ 2150.325953]  kthread+0xd8/0xdc
> > > > [ 2150.329008]  ret_from_fork+0x10/0x20
> > > > [ 2150.332589] Code: b9007bf7 b4001e9c f9448380 b9491381 (f9400000)
> > > > [ 2150.338681] ---[ end trace 0000000000000000 ]---
> > > > [ 2150.343298] Kernel panic - not syncing: Oops: Fatal exception
> > > > [ 2150.349035] SMP: stopping secondary CPUs
> > > > [ 2150.352954] Kernel Offset: disabled
> > > > [ 2150.356438] CPU features: 0x0,00000000,00000000,1000400b
> > > > [ 2150.361743] Memory Limit: none
> > > >=20
> > > > Fix the issue validating egress gdm port in airoha_ppe_foe_entry_pr=
epare
> > > > routine.
> > > >=20
> > > > Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload supp=
ort")
> > >=20
> > > The patch has "Fixes" tag, but it is sent to "net-next" tree.
> > > I think it's rather a candidate for "net".
> >=20
> > The offending commit is just in net-next at the moment. Do you prefer t=
o drop
> > the Fixes tag?
>=20
> Oh, I didn't realize this is a new driver in net-next. So, I'm OK with
> the "Fixes" tag then.
>=20
> >=20
> > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/net/ethernet/airoha/airoha_eth.c | 16 ++++++++++++++++
> > > >  drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
> > > >  drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
> > > >  3 files changed, 27 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net=
/ethernet/airoha/airoha_eth.c
> > > > index c0a642568ac115ea9df6fbaf7133627a4405a36c..776222595b84e4fba6a=
e5943420e0edf0d0ecf8f 100644
> > > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > > @@ -2454,6 +2454,22 @@ static void airoha_metadata_dst_free(struct =
airoha_gdm_port *port)
> > > >  	}
> > > >  }
> > > > =20
> > > > +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> > > > +			     struct airoha_gdm_port *port)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> > >=20
> > > You could reduce the number of lines by moving the declaration inside=
 the
> > > loop:
> > > 	for (int i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> >=20
> > to be consistent with the driver I prefer to keep the current approach.
>=20
> OK. That was my suggestion only. Let's keep the code consistent then.
>=20
> >=20
> > >=20
> > > > +		if (!eth->ports[i])
> > > > +			continue;
> > >=20
> > > Isn't this NULL check redundant?
> > > In the second check you compare the table element to a real pointer.
> >=20
> > Can netdev_priv() be NULL? If not, I guess we can remove this check.
>=20
> I guess it shouldn't be NULL since "devm_alloc_etherdev_mqs()" was
> called, but I'm not 100% sure if there are any special cases for the "air=
oha"
> driver. Maybe in such cases it would be better to check for the netdev_pr=
iv?
> Anyway, such checks seem a bit too defensive to me.

the dev pointer can be allocated even outside of airoha_eth driver.
This pointer is provided by the flowtable.
I guess we can drop the NULL pointer check above, and do something like:

	if (port && eth->ports[i] =3D=3D port)
		return 0;

what do you think?

Regards,
Lorenzo

>=20
> Thanks,
> Michal
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > > +
> > > > +		if (eth->ports[i] =3D=3D port)
> > > > +			return 0;
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > > >  				 struct device_node *np, int index)
> > > >  {
> > > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net=
/ethernet/airoha/airoha_eth.h
> > > > index f66b9b736b9447b31afc036eb906d0a1c617e132..c7d4f124d11481cd31c=
1566936cd47e3446877c0 100644
> > > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > > @@ -532,6 +532,9 @@ u32 airoha_rmw(void __iomem *base, u32 offset, =
u32 mask, u32 val);
> > > >  #define airoha_qdma_clear(qdma, offset, val)			\
> > > >  	airoha_rmw((qdma)->regs, (offset), (val), 0)
> > > > =20
> > > > +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> > > > +			     struct airoha_gdm_port *port);
> > > > +
> > > >  void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
> > > >  int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *ty=
pe_data,
> > > >  				 void *cb_priv);
> > > > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net=
/ethernet/airoha/airoha_ppe.c
> > > > index 8b55e871352d359fa692c253d3f3315c619472b3..65833e2058194a64569=
eafec08b80df8190bba6c 100644
> > > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > @@ -197,7 +197,8 @@ static int airoha_get_dsa_port(struct net_devic=
e **dev)
> > > >  #endif
> > > >  }
> > > > =20
> > > > -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *h=
we,
> > > > +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> > > > +					struct airoha_foe_entry *hwe,
> > > >  					struct net_device *dev, int type,
> > > >  					struct airoha_flow_data *data,
> > > >  					int l4proto)
> > > > @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct=
 airoha_foe_entry *hwe,
> > > >  	if (dev) {
> > > >  		struct airoha_gdm_port *port =3D netdev_priv(dev);
> > > >  		u8 pse_port;
> > > > +		int err;
> > > > +
> > > > +		err =3D airoha_is_valid_gdm_port(eth, port);
> > > > +		if (err)
> > > > +			return err;
> > > > =20
> > > >  		if (dsa_port >=3D 0)
> > > >  			pse_port =3D port->id =3D=3D 4 ? FE_PSE_PORT_GDM4 : port->id;
> > > > @@ -633,7 +639,7 @@ static int airoha_ppe_flow_offload_replace(stru=
ct airoha_gdm_port *port,
> > > >  	    !is_valid_ether_addr(data.eth.h_dest))
> > > >  		return -EINVAL;
> > > > =20
> > > > -	err =3D airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type,
> > > > +	err =3D airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_typ=
e,
> > > >  					   &data, l4proto);
> > > >  	if (err)
> > > >  		return err;
> > > >=20
> > > > ---
> > > > base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> > > > change-id: 20250312-airoha-flowtable-null-ptr-fix-a4656d12546a
> > > >=20
> > > > Best regards,
> > > > --=20
> > > > Lorenzo Bianconi <lorenzo@kernel.org>
> > > >=20
> > > >=20
>=20
>=20

--aCGyFJzoSWN6SOr5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9G01wAKCRA6cBh0uS2t
rAJdAP9/lHGRkoKhGH2x4fHlW0jK9IvFzgyjJ9EUjL/nOh7KYAD/QcVvRqIeuGEj
+mtgacLay0fGwAUX2ye1SVygsBpVPAQ=
=KWwt
-----END PGP SIGNATURE-----

--aCGyFJzoSWN6SOr5--

