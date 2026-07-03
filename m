Return-Path: <netdev+bounces-304526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pHO0HnamR2q6cwAAu9opvQ
	(envelope-from <netdev+bounces-304526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E82702354
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:09:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CaOGDkFg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304526-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304526-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1A4D301D4D5
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB63CF688;
	Fri,  3 Jul 2026 12:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022A3CF205;
	Fri,  3 Jul 2026 12:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080547; cv=none; b=Mq1jckTFetNz6ekkT+CN6kNVVlbY6RoG7XUj5I4gBIjggly+XJfC+JwHJxfB9H2+rfmXriNR6Hb3gV7+dt5wHSGGtqWhpztVvxtTckmBNYhRS9JKvvjnLVAd7yyrqRBm1Kmb8qlTz7DCIEoNP17VdRskyiOAat2gkzAJDLdWie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080547; c=relaxed/simple;
	bh=udUq4HWdcioxH0swzBPKGvyqzy7TPhGFUHRL0fVMT7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9P8YcZrnqJ1QK+VkwgyKI4amz54JwHvgi+Byci1OR9CPl7268o5bt+ZUJ/z0tPXjZy9GbinV39EnLJ1GLB6WlmLo2UCWLFYd2iRxvZIwr9pBM+in/CevdKd2nC9/g8pwDbfeOElXD+pklNjOFxg0GLoUhBWMuQ1fxIK8TD40K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaOGDkFg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED4E1F000E9;
	Fri,  3 Jul 2026 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080546;
	bh=GC8PsR9/PCWDcvIvXSdq46Jm/kYGDdiFqHWOf2WfiBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CaOGDkFgUc46K0bGdJmegK5lOtr3g3FNzMaA7vjk3pZtL4ICU9o0tRSwX4ewRrsHc
	 lnotpeoy8BcP3QQUGaX0JNkHdFzhwq4IZa7UU6P4MVvHqZmn678ApLz50E/56i84cv
	 S03KN85J3vs/ENLYyMQQTlEKkJHRyr+HugDPQZ8i+vvWoud6Rm1a9t5ZOoQcHAZsMb
	 m818MNIPjRwdyvVSbAwP/9p7AsSQu+TMi8gySzZzSzRxfymjs3k20LfgEe9DsFh08j
	 5ON3ZYwpmH7TjnejkR3DieKqqUdQ+5/EODEgZx+OMghj/nvAf9OBoHgtgut8sqqOpE
	 5lumD8a9r5bXw==
Date: Fri, 3 Jul 2026 13:09:00 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paolo Valerio <pvalerio@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 13/15] net: macb: re-read ISR inside IRQ
 handler locked section
Message-ID: <20260703-faction-system-20af97e12412@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-13-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eBN7m2rhb9SGAbaE"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-13-00268d5b1502@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304526-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11E82702354

--eBN7m2rhb9SGAbaE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

I'll admit to being a bit confused by this patch..

On Wed, Jul 01, 2026 at 05:59:16PM +0200, Th=E9o Lebrun wrote:
> The IRQ handler reads ISR register into the `status` stack variable.
> If empty, it early returns. Else, it grabs bp->lock and iterates on
> the status bits.
>=20
> If we tried grabbing bp->lock while already acquired, we might have
> slept and the status might have been updated. Our most likely

This mention of sleeping I think should be removed, it implies sleeping
is required for the status to be updated.

> competitor in this race (condition) is a swap operation, used in
> change_mtu and set_ringparam. It is the only MACB codepath that resets
> interrupts and HW inside a bp->lock critical section. Other codepaths
> that clear HW IRQ status do so outside the bp->lock critical section.

Where do change_mtu and set_ringparam take the bp lock?
As far as I can see, they don't. The commit message should reflect how
the code behaves at the time of the patch, not at some point in the
future after it.

> We can only detect spurious interrupts before grabbing bp->lock if
> MACB_CAPS_ISR_CLEAR_ON_WRITE. If we don't, then we only read ISR once.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 7245c345c78f..5a32d5cb759e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2184,13 +2184,21 @@ static irqreturn_t macb_interrupt(int irq, void *=
dev_id)
>  	struct net_device *netdev =3D bp->netdev;
>  	u32 status;
> =20
> -	status =3D queue_readl(queue, ISR);
> -
> -	if (unlikely(!status))
> -		return IRQ_NONE;
> +	/* detect spurious interrupts without grabbing bp->lock */
> +	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE) {
> +		status =3D queue_readl(queue, ISR);
> +		if (unlikely(!status))
> +			return IRQ_NONE;
> +	}

To be honest, this check feels like penalising the likely^2 case* with an
extra read favour of the unlikely case where there's contention on the
lock and the contending function is capable of affecting the status
register. Could we get away with just the single check of the register
with the lock taken?

* although I don't know what percentage of hardware supports this cap,
so maybe most devices will never run this code

> =20
>  	spin_lock(&bp->lock);
> =20
> +	status =3D queue_readl(queue, ISR);
> +	if (unlikely(!status)) {
> +		spin_unlock(&bp->lock);
> +		return IRQ_NONE;
> +	}
> +
>  	while (status) {
>  		/* close possible race with dev_close */
>  		if (unlikely(!netif_running(netdev))) {
>=20
> --=20
> 2.55.0

>=20

--eBN7m2rhb9SGAbaE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakemXAAKCRB4tDGHoIJi
0qTPAQCTy+birlN+1ozXrUVXFghSBXjQNLvuCIaXwyz8nsQyJQEAqBfqa6TMe+g1
CTMa6usOrOpYB8sNRUcQ2XZ6tkVZEQw=
=SyKB
-----END PGP SIGNATURE-----

--eBN7m2rhb9SGAbaE--

