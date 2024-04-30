Return-Path: <netdev+bounces-92504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609EC8B7972
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FC128154D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2C174ED3;
	Tue, 30 Apr 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL5xa34f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFE174EC9
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486956; cv=none; b=AwBPe/SV//bOR/N5KyGb6RNhEJ3uOJv9501Cmclg5iiQ++zkjDQTlGAnW7BtDnPnudA7Tt/plZ0n+0dhejVfAcuK+ZLLXVKidV7uIAuwjA4iwDNhqawaEmmXg7CLBTF9VaOyizCEDG8lJ4yIbcivz0NDIKHc71DOrtqCBgrvM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486956; c=relaxed/simple;
	bh=lUMJhCdjVpCX+lUWglQ+tJroxPECPx4hjaKGW9Q7CNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckhA+NE7p3sHD4fQctzPr+sUOlzjGN8niK6noOXgFfCdNy6ULsXPjitrwk+AanxpBFfIWugIrhH7YwpVnO3a/sJbS1+Y+/kQGoLFYlJVZvv9CtAPEMeuYrtrCIE3cfeX7kSy/57yMXvSELQqzX+V8GEkMjFc/m/ts+RmrIdXBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL5xa34f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90F4C4AF18;
	Tue, 30 Apr 2024 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714486955;
	bh=lUMJhCdjVpCX+lUWglQ+tJroxPECPx4hjaKGW9Q7CNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QL5xa34fUk1ex+CC3kFnPdNSjjKXRo93ENJjBfzZCguRMn4cTA/pyxlBcKmm6o5p0
	 2al4olz36E8ZdqsDRmOcTJ6DaImgxsqHIE7q1E2EiX15bCIDQwWQ40kgGwBo9KxgYR
	 /WA7kQ2/I4HPBQMndOQhaLTUR8W3flpjwJZRy4aeF4WYlAR7VZKHm9rC642Qro/9S0
	 g45NXE5Uq4X91B8oTmrpqw8014yrU8PP8vJpgwxORr20AZ8obdFffaM1Ej4PU5gKtP
	 lniNp5kToOcExMDbEx9WbVJ+gA+3xstD823BVcQs212QgalATwndl2OyhlGgbg3WbU
	 0p75/9O9Wt0NQ==
Date: Tue, 30 Apr 2024 16:22:31 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: update the unicast MAC address
 when changing conduit
Message-ID: <20240430162231.27fbd03c@dellmb>
In-Reply-To: <20240430003108.4dyjlavsledkbvot@skbuf>
References: <20240429163627.16031-1-kabel@kernel.org>
	<20240429163627.16031-3-kabel@kernel.org>
	<20240430003108.4dyjlavsledkbvot@skbuf>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 03:31:08 +0300
Vladimir Oltean <olteanv@gmail.com> wrote:

> Hi Marek,
>=20
> On Mon, Apr 29, 2024 at 06:36:27PM +0200, Marek Beh=C3=BAn wrote:
> > DSA exhibits different behavior regarding the primary unicast MAC
> > address stored in port standalone FDB and the conduit device UC
> > database while the interface is down vs up.
> >=20
> > If we put a switch port down while changing the conduit with
> >   ip link set sw0p0 down
> >   ip link set sw0p0 type dsa conduit conduit1
> >   ip link set sw0p0 up
> > we delete the address in dsa_user_close() and install the (possibly
> > different) address dsa_user_open().
> >=20
> > But when changing the conduit on the fly, the old address is not
> > deleted and the new one is not installed.
> >=20
> > Since we explicitly want to support live-changing the conduit, uninstall
> > the old address before the dsa_port_change_conduit() call and install
> > the (possibly different) new one afterwards.
> >=20
> > Because the dsa_user_change_conduit() call tries to smoothly restore the
> > old conduit if anything fails while setting new one (except the MTU
> > change), this leaves us with the question about what to do if the
> > installation of the new address fails. Since we have already deleted the
> > old address, we can expect that restoring the old address would also fa=
il,
> > and thus we can't revert the conduit change correctly. I have therefore
> > decided to treat it as a fatal error printed into the kernel log.
> >=20
> > Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and cha=
nged through rtnetlink")
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > --- =20
>=20
> It's good to see you returning to the "multiple CPU ports" topic.

Didn't have time for this at all until now, unfortunately :-(

BTW, thank you for all your work on this. It must have been a lot of
time you spent on it...

> This is a good catch, though it's quite an interesting thing why I
> haven't noticed this during my own testing. Especially when the platform
> I tested has dsa_switch_supports_uc_filtering() =3D=3D true, so it _has_ =
to
> install the host addresses correctly, because DSA then disables host
> flooding and not even ping would work.
>=20
> I _suspect_ it might be because I only tested the live migration when
> the port is under a bridge, and in that case, the user port MAC address
> also exists in the bridge FDB database as a BR_FDB_LOCAL entry, which
> _is_ replayed towards the new conduit. And when I did test standalone
> ports mode, it must have been only with a "cold" change of conduits.
>=20
> Anyway, logically the change makes perfect sense, though I would like to
> try and test it tomorrow (I need to rebuild the setup unfortunately).
>=20
> Just wondering, why didn't you do the dev->dev_addr migration as part of
> dsa_port_change_conduit() where the rest of the object migration is,
> near or even as part of dsa_user_sync_ha()?

Because I didn't think of it. Of course it makes much more sense...

>=20
> >  net/dsa/user.c | 45 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 37 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index b1d8d1827f91..70d7be1b6a79 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -2767,9 +2767,37 @@ int dsa_user_change_conduit(struct net_device *d=
ev, struct net_device *conduit,
> >  	if (err)
> >  		goto out_revert_old_conduit_unlink;
> > =20
> > +	/* If live-changing, we also need to uninstall the user device address
> > +	 * from the port FDB and the conduit interface. This has to be done
> > +	 * before the conduit is changed.
> > +	 */
> > +	if (dev->flags & IFF_UP)
> > +		dsa_user_host_uc_uninstall(dev);
> > +
> >  	err =3D dsa_port_change_conduit(dp, conduit, extack);
> >  	if (err)
> > -		goto out_revert_conduit_link;
> > +		goto out_revert_host_address;
> > +
> > +	/* If the port doesn't have its own MAC address and relies on the DSA
> > +	 * conduit's one, inherit it again from the new DSA conduit.
> > +	 */
> > +	if (is_zero_ether_addr(dp->mac))
> > +		eth_hw_addr_inherit(dev, conduit);
> > +
> > +	/* If live-changing, we need to install the user device address to the
> > +	 * port FDB and the conduit interface. Since the device address needs=
 to
> > +	 * be installed towards the new conduit in the port FDB, this needs to
> > +	 * be done after the conduit is changed.
> > +	 */
> > +	if (dev->flags & IFF_UP) {
> > +		err =3D dsa_user_host_uc_install(dev, dev->dev_addr);
> > +		if (err) {
> > +			netdev_err(dev,
> > +				   "fatal error installing new host address: %pe\n",
> > +				   ERR_PTR(err));
> > +			return err; =20
>=20
> Even though there are still things that the user can try to do if this
> fails (like putting the conduit in promiscuous mode, and limp on in a
> degraded state), I do agree with error checking, to not give the user
> process the false impression that all is well.
>=20
> However, this is treated way too fatally here (so as to "return err" with=
out
> even attempting to do a rewind), when in reality it could be recoverable.
> When moving the logic to dsa_port_change_conduit() please integrate with
> the existing rewind flow.
>=20
> Keep in mind that the RX filtering database of the switch or the conduit
> may be limited in size, and may really run out. For that reason, your
> dsa_user_host_uc_install() call should be placed _before_ the
> dsa_user_sync_ha() logic that syncs the uc/mc secondary address lists.
> Those are unchecked-for errors (partly because it's very hard to do: you
> need to synchronize a deferred work context with a process context), and
> they could easily fill up the filtering tables of the conduit. So let's
> prioritize the (single) standalone MAC address of the user port.
>=20

OK, I'll send another version in ~2-3 days. In the meantime, have you
had time to test the change?

Marek

