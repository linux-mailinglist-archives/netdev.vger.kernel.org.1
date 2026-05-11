Return-Path: <netdev+bounces-286501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCULAkOIAWpscgEAu9opvQ
	(envelope-from <netdev+bounces-286501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9C5096BE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0064630054F4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FA39B95E;
	Mon, 11 May 2026 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZWYXkvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDD39A054
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485310; cv=none; b=QvmrvQHbBZQ4YEkrlB1YbxBsaZC2xCSj+goPzERoFPaQD66Ng3kAvoRGfZMJP7NtO6JqLUL1nObqeyH5CQzwlsPvCanDaWVy37EA0++u4piqYz4VamLCypizrvzjNw3WeMSd9ZR1Fqylpg/fScYq/0DZVL5YoCxZ8A5Cr4C0BzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485310; c=relaxed/simple;
	bh=ibpdvB/sDKrchmvVg45cobuB/AQfnh+eqr95DUIT1SE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZWDy4+ou7QQIbl2ei9C9C5qgJ2lyczBqgNH5Dfe8qA1SlfFlhYZddIqf6ARJevRCJn7ErEtOHhF+tyllLRU84l5X9KIPjx7nXZ/GNgZcNCuGY3+VclUEJuMkZqTBw+7KRio40j3bmJIZn3hie17Sak68HSVaMNvQrpexTUrqBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZWYXkvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73838C2BCB0;
	Mon, 11 May 2026 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485308;
	bh=ibpdvB/sDKrchmvVg45cobuB/AQfnh+eqr95DUIT1SE=;
	h=Date:From:To:Subject:From;
	b=iZWYXkvFNeUEUDVMKJdpJxG2g/kHS9fU7taG1h9qOTTyz0+X+xvTmCdZon1a0CqKh
	 UoNQ0hKBmNZfj5V7Qu3lmOZ4u9HC7Yb5bB2JsbEqVFLF5/LHlLNrLwvl/GEeYGAULa
	 6nPJhe2nEzg6Tlft3U7wMB506PAmcdfvxW0o6cK+q6hA+D1bAypZGLg9IFzt8bOpeL
	 fbCdpXny/ukizV2vwhgBHTLy+UM+WXWa4hhBG9kWYlt8MGIO0GQD2ICAfvSVDt7/rw
	 XQE6QGq+8nVuuVsRXSqJ9JIyjggd9cLF89xTacAmTHG2Rh3RsfxVrUfdbUzwsbS5r5
	 /zX88GQGYi5+Q==
Date: Mon, 11 May 2026 09:41:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Subject: Fwd: Re: [PATCH net-next v5 12/12] net: airoha: Better handle MIB
 for GDM with multiple port attached
Message-ID: <agGIOpoOLzeHqUUp@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CySmnG8yP2UzFd1E"
Content-Disposition: inline
X-Rspamd-Queue-Id: ABB9C5096BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:~,7:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--CySmnG8yP2UzFd1E
Content-Type: multipart/mixed; boundary="SUJg/1OohrSX0AT5"
Content-Disposition: inline


--SUJg/1OohrSX0AT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+netdev

Regards,
Lorenzo

--SUJg/1OohrSX0AT5
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: lorenzo.bianconi83@gmail.com
Received: by 2002:a05:6504:d85:b0:2ff:497e:1c93 with SMTP id b5csp1656174lty;
        Sun, 10 May 2026 23:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=2; AFNElJ961MTQID26LCoMt+5aRYo8AmVEzH9RTAMHlChg69FQtJpLpTwiekaQUktZZ5jbvHvOlr+5hY4a1NZA5FXKnIrpUfU=@gmail.com
X-Received: by 2002:a05:6a21:e098:b0:3aa:f9cb:d41a with SMTP id adf61e73a8af0-3aaf9cbde2amr5270770637.19.1778482269826;
        Sun, 10 May 2026 23:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778482269; cv=none;
        d=google.com; s=arc-20240605;
        b=ERZFRPrSsdrvSGL01/TJcOlWxbImud16uetS2cUd/archo2RXh7JMLIfgCy5elyrj9
         hDKt1zEjhx6rY+Y1hdf/wXLSFf8sy+JbZ4mWJK8/4MmezKHsLClma5cUoAVFH4QLLDQM
         tZUFJU3jBg3Wu//QlgQR2wOzX5061wJA2bI0lOOGg6pQcF2b0jxLimBTeNDJLQx37z7s
         lXH+4qqLUqvHQQ7XibAKQv/At0asq+4Hk68+SDoEDaOct1kg2l+ZOzoeNdDbTJ4wmET2
         norfZL2DVUEOk+ot0X2/Xi4ecxr0SbEMzZwFoNUnGyq/GODYsTY4+bV95acx9nR8iB5f
         wquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=RFgqIeaShXa5BG0VX8+ZB5smnHzxFARpf9cydZVuDco=;
        fh=+uU8yHGCCo9WYubKXepIIIb+EaV8PrrTYVnAHrrpsxk=;
        b=cIRswcO4s2oANu0nHWCWCqcV5yYct6MqngJAALZ3PJZ4qvU14gqE0KGo7qSVXu6W2t
         Z/Dq8PQkWCQM9tJlhHr+IsLV/0NzDPSbqIAPpBpUwuJn6mkjP36GzN2BK0v0PYQxa/F0
         kCYETzP8k9XvNH2M44L0uCfFoNYdoLRoXk8hlSD2FD0Iyaz/tZezdomuvPXYFzc06mtP
         uWDv+rsB8WCFGmiedkQnFC8+x9KxBcHBDt0+FLl0oD3pZ95IFZNvEOx82CKD754mx9tA
         8iDiY5nAu57z4ImUzKK+ciCyefA96y7OBO38dH2XD1g0YxmWALF/7MXaeNeVxOL4AwGS
         gzbg==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=sgoQUKY+;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Return-Path: <lorenzo@kernel.org>
Received: from sea.source.kernel.org (sea.source.kernel.org. [2600:3c0a:e001:78e:0:1991:8:25])
        by mx.google.com with ESMTPS id 41be03b00d2f7-c82677768f4si16797509a12.310.2026.05.10.23.51.09
        for <lorenzo.bianconi83@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:51:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of lorenzo@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender) client-ip=2600:3c0a:e001:78e:0:1991:8:25;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=sgoQUKY+;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F6C9401DC
	for <lorenzo.bianconi83@gmail.com>; Mon, 11 May 2026 06:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 75E50C2BCF5; Mon, 11 May 2026 06:51:09 +0000 (UTC)
Delivered-To: lorenzo@kernel.org
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C666C2BCB0;
	Mon, 11 May 2026 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778482269;
	bh=wqD98MO+dMAu60i5VFJSDqQmQqZN+ELhw7sRVp/bcAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgoQUKY+dNMX4qe0bwx56KsZt1+o1oCVmbamrfA/i8MIeLcGzKOOvlUz5fT68zfDg
	 Nx2R/065A3nb6QP5ZvZUpYbhj8aWIZxc48+p2DswiOs2l/JSJSb9AfXjQb9JrBN/Rg
	 9/Fpltgjic1sELX+YeNVUp1AYC0MyLLjF0nvZz4bBwxcUed5ZKieXCpmFwgleng3HR
	 Is3Ks7DwuWa9kJQ8QLAxhYYzZB4BBB541SewjgYBO8rAor4e+Az3MvJpFZV2cqru9u
	 ezYLWloIvOQ31eU8noTtxp7Cer0B0KJ4ODGR+hud7ZVT0LH0sxpsRPq4PopcnDoHyj
	 VzkNWD37CLi1g==
Date: Mon, 11 May 2026 08:51:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/12] net: airoha: Better handle MIB for GDM
 with multiple port attached
Message-ID: <agF8WhrU8lTIyOjX@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-12-805e38edc2aa@kernel.org>
 <20260510140506.DBBDCC2BCC9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yak5kKSg5+tzS0K4"
Content-Disposition: inline
In-Reply-To: <20260510140506.DBBDCC2BCC9@smtp.kernel.org>
X-TUID: 8X79iVaMa9Ab


--Yak5kKSg5+tzS0K4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Moving the statistics lock from the port level to the device l=
evel introduces a race condition on shared hardware registers, causing cros=
s-interface statistics corruption.
> --
>=20
> commit 29334a9bde18f0777df549f0d135356a4b8bd3ee
> Author: Christian Marangi <ansuelsmth@gmail.com>
>=20
> net: airoha: Better handle MIB for GDM with multiple port attached
>=20
> This commit enables a split MIB feature for GDM3/4 to track counters per
> hardware channel instead of per GDM port. It moves the statistics structu=
re,
> including its protecting lock, from the port level to the device level.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 623cac42dfb71..b1a6586293457 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1621,143 +1621,150 @@ static void airoha_update_hw_stats(struct air=
oha_gdm_dev *dev)
> >  	struct airoha_eth *eth =3D dev->eth;
> >  	u32 val, i =3D 0;
> > =20
> > -	spin_lock(&port->stats.lock);
> > -	u64_stats_update_begin(&port->stats.syncp);
> > +	spin_lock(&dev->stats.lock);
> > +	u64_stats_update_begin(&dev->stats.syncp);
> > +
> > +	/* Read relevant MIB for GDM with multiple port attached */
> > +	if (port->id =3D=3D AIROHA_GDM3_IDX || port->id =3D=3D AIROHA_GDM4_ID=
X)
> > +		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
> > +			      FE_TX_MIB_ID_MASK | FE_RX_MIB_ID_MASK,
> > +			      FIELD_PREP(FE_TX_MIB_ID_MASK, dev->nbq) |
> > +			      FIELD_PREP(FE_RX_MIB_ID_MASK, dev->nbq));
>=20
> Does moving the lock from the port to the device level introduce a race
> condition on the shared port MIB registers?
>=20
> Because ndo_get_stats64 can be called concurrently without the RTNL lock,=
 if two
> CPUs request stats for two different devices on the same port:
>=20
> CPU1 calls airoha_update_hw_stats() for dev_A:
>     spin_lock(&dev_A->stats.lock);
>     airoha_fe_rmw(..., REG_FE_GDM_MIB_CFG(port->id), ... dev_A->nbq);
>=20
> CPU2 concurrently calls airoha_update_hw_stats() for dev_B:
>     spin_lock(&dev_B->stats.lock);
>     airoha_fe_rmw(..., REG_FE_GDM_MIB_CFG(port->id), ... dev_B->nbq);
>=20
> Could CPU1 then read the hardware counters for dev_B instead of dev_A?

ack, I will fix it in v6.

>=20
> [ ... ]
>=20
> >  	/* reset mib counters */
> >  	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
> >  		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
>=20
> When CPU1 then clears the counters here, could it wipe out the unread
> hardware statistics for dev_B?
>=20
> Is a port-level lock still needed to exclusively protect access to these =
shared
> hardware MIB registers across multiple devices?

ack, I will fix it in v6.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D12

--Yak5kKSg5+tzS0K4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagF8WgAKCRA6cBh0uS2t
rLKuAQCVHo9zxxc0/M/2vdNjL4owOrzT2rbvhRnV2L78lFsMGQEAwZmw0aUtbQ2O
JQuPuqSO4Bf8fRR28FMUTzXWBp1DRgM=
=4akk
-----END PGP SIGNATURE-----

--Yak5kKSg5+tzS0K4--

--SUJg/1OohrSX0AT5--

--CySmnG8yP2UzFd1E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGIOgAKCRA6cBh0uS2t
rMCIAP0UwUvCfp/k1pyhikZgvIm/ktwrleTaqGVha2Q0D0TRiwEAmeRSj3RxPBjl
mrCF835jnxJhI7udf/YSJy8T/mLkUwI=
=WNZG
-----END PGP SIGNATURE-----

--CySmnG8yP2UzFd1E--

