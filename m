Return-Path: <netdev+bounces-286500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA4rGC+KAWpJcwEAu9opvQ
	(envelope-from <netdev+bounces-286500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B591F5098D6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0948305EAA9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4A39936B;
	Mon, 11 May 2026 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRWrBWmV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B50397E9D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485263; cv=none; b=Dhc99nA7g144WLpMyQ10TzTJYwWxmJxoqR3lCi5MIXmQK9wxIB2wqDIvjikzBhLhutlJHHOBb1mmCLPPLat+iUVqBbX9+QegwSFLMDQd4h94DMzZJisL1cvSByOFCj4cY29QCiond1NXz2AFLCboGGZCYDJJPN1+HUiMAoqz5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485263; c=relaxed/simple;
	bh=xKA954NBjL/90R2cAO1Sx+/rGdCBD3dJWuPS4eVHIJ8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iNrqyVzbjGMsc+HidulidnyhsWyJzIRTqaauYnJp+XzV6snm6t/jDfcyiKLJei79K9sTNLxjr4J7YxkRkUSAnhC1YXp5RohFc88ql8pEeKSRPWUdZdQHxxE1A9P7H4hm/ygxXypxqu0zIDZibZM/jgDVXjYOZkyxktTXRisG7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRWrBWmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0AC2BCB0;
	Mon, 11 May 2026 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485262;
	bh=xKA954NBjL/90R2cAO1Sx+/rGdCBD3dJWuPS4eVHIJ8=;
	h=Date:From:To:Subject:From;
	b=eRWrBWmVcOZk2fcV7r9uYgHBQBd5fDSmHdphnRR8E7rfbxPUnTZNssa39EQ7PuSUk
	 IsqcBYTo0ZIpDvHmRvxfJ1jKBYG4DyMA9r4VNs2xp1bth8QuV5STbLnLklZ1UJLl2u
	 +/2PlvrNGS9D/fa0ui+f8C6syev5PdxJ2UFgxHyXDzON6prPttqdfVewDQaZFDae/A
	 i2xRSrzeldlq5sy/Kn15K4Dtbq2R/ZM/5Y5Ts78EITRZiKFmK81k2KHUnNn65cjU1U
	 DhPaYCmYx5ZPOTistr8CSU0G/ycdyLHTgcvED4co6MJqRGF85sZZKucETaLDyc0Gyh
	 jokn+7d6i8nbQ==
Date: Mon, 11 May 2026 09:41:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Subject: Fwd: Re: [PATCH net-next v5 11/12] net: airoha: Support multiple
 LAN/WAN interfaces for hw MAC address configuration
Message-ID: <agGIDD_B91cMXnZo@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5huEB/eopKkhfvT"
Content-Disposition: inline
X-Rspamd-Queue-Id: B591F5098D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286500-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:~,7:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action


--z5huEB/eopKkhfvT
Content-Type: multipart/mixed; boundary="8oYFmv0ov8O7OkN7"
Content-Disposition: inline


--8oYFmv0ov8O7OkN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+netdev

Regards,
Lorenzo

--8oYFmv0ov8O7OkN7
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: lorenzo.bianconi83@gmail.com
Received: by 2002:a05:6504:d85:b0:2ff:497e:1c93 with SMTP id b5csp1660658lty;
        Mon, 11 May 2026 00:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=2; AFNElJ/ZZmYu5OPpkxsakdcegxrAeTLHxIZoURaJZJ6hINNmNMvJCIFaqnNjsoJZgOY8wbEonf26AXEhoQvXv3om8LAVHQE=@gmail.com
X-Received: by 2002:a05:6214:518b:b0:8c2:f384:be1d with SMTP id 6a1803df08f44-8c2f384c3a9mr100149606d6.26.1778482967843;
        Mon, 11 May 2026 00:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778482967; cv=none;
        d=google.com; s=arc-20240605;
        b=cjlgt1pu+MwCSKmOTEPTwPxqs7xEtDzG/3zWpi245Awgj1HC8IE8Rs4o7tXX4krcdM
         GCi1GW+dAmz4DJRuNSmrMunfJqCAS1UgfDvNr1n9tR0bf/8pwKp6TOB1apas6IAyQlcn
         aOxRB6qc1sMbAc4pyOUKo51bQjwLn6m6jTTHmmTzlxXZxtlcJQgsA398/vs9V1Pf0lVb
         mZJJPdYAkZV7feUn49+Hm06SpGK5i4UQttQKOrp3dBpvlYvJcTGr4Q3/45Vlp9pW4LgA
         /kdLBBiXeo5m6g+vJEAEFfjWnNsK0gv5o5kNF1s9e7utEE0verklXHg1h6mEUUltgdbu
         0L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=qI0lBvXzbz27Xr5l6P0P+0ghQW9oVmn2XztMyM9qEb4=;
        fh=H+ondyo43fxz5RmWxL2tSHu8MHkOvgj74NNcu6hN+jc=;
        b=K127SKtlq9VpdXn5X9xd124Vm68iK0EBXzoptqFyfvxrzAF3qZkh6ljF4sKxzQbQKn
         vOShLZ8TWYRtpznj0ZAivMkK8G95oR6+csAGtslDIJx2H9lgTYoOiajbhz32F+zE6M31
         9ZY+OYLHeXss3+B+Mb9a7r9T+tqU1Wk6jdDjKs2HmFbeOisnCOnRvej0mfSvpMU3kM1c
         hgtV2QqqMF0MJ6ZtNuv958JlYNaJ8lMi9FgR5UdIA813othrHcfZ8hMJwY0svPi/Cqjt
         EqHTSZitRNn3DEKCZvnT/RtEyQ77zeOxnbGSTMr8IzfiXWBhsi8wIYHwe+Cr3jBhoIDW
         QYxQ==;
        dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=jDQiOyQp;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Return-Path: <lorenzo@kernel.org>
Received: from tor.source.kernel.org (tor.source.kernel.org. [2600:3c04:e001:324:0:1991:8:25])
        by mx.google.com with ESMTPS id 6a1803df08f44-8b53bcff548si394096226d6.236.2026.05.11.00.02.47
        for <lorenzo.bianconi83@gmail.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:02:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of lorenzo@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) client-ip=2600:3c04:e001:324:0:1991:8:25;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=k20201202 header.b=jDQiOyQp;
       spf=pass (google.com: domain of lorenzo@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom=lorenzo@kernel.org;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4911C60128
	for <lorenzo.bianconi83@gmail.com>; Mon, 11 May 2026 07:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 13F69C2BCF6; Mon, 11 May 2026 07:02:47 +0000 (UTC)
Delivered-To: lorenzo@kernel.org
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E4C2BCB0;
	Mon, 11 May 2026 07:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778482967;
	bh=aalilyopaoHLhz7HYdUDa8mJmjbUsfs76tdqWE+bA1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDQiOyQp4uOC78v7ySz4YgJg3cRZqaXIuiFhXReBKQEOEeT5CBQX08B1b0hgHKRi4
	 QJL7tFARgtsX032BZHH3kVS1Fdm1T8LYkQfqnmGUSgmxrLt+EqR8Azl8rpDs3x0XWB
	 SCu8TD1Rds2w1CiQCSizHx7nayxX1b4MgTkT9ixzHMin1gC+BJebbVbbyu9OPhCC5w
	 JjB8Gnx7k+JeTYjaY3irJ7VzbFkoHg5i5U6lHh3hNIQURwomA9phYlaM5XaGw13wOl
	 3ZeJ45JDE86BDmme+Cgvqzs3lJh2koR+Y4IalNOmL5ZDa7iNww5k4fsS/iKa1wkxXo
	 ZITPZrMmFhw9A==
Date: Mon, 11 May 2026 09:02:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/12] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <agF_FJBKBpmHHoVA@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-11-805e38edc2aa@kernel.org>
 <20260510140505.F219FC2BCF6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlIWd/tj4LYu8Qia"
Content-Disposition: inline
In-Reply-To: <20260510140505.F219FC2BCF6@smtp.kernel.org>
X-TUID: I77PTkNdCxLk


--ZlIWd/tj4LYu8Qia
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Probe fails completely when devices use randomly generated MAC a=
ddresses due to strict MSB validation.
> - [Medium] Strict MAC address MSB validation creates a configuration dead=
lock, preventing users from modifying MAC addresses.
> --
>=20
> commit d9f17b062a5dbe5adb3be07d9c3f501106b25dd8
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Support multiple LAN/WAN interfaces for hw MAC address confi=
guration
>=20
> This commit extends the hardware MAC address configuration in the airoha
> Ethernet driver to support multiple LAN or WAN interfaces. It calculates
> the minimum and maximum lower MAC address bytes across all devices with t=
he
> same configuration, and enforces that they share the same upper 3 MAC
> address bytes.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index fa37dbd76d579..623cac42dfb71 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *a=
ddr)
> > +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *ad=
dr)
> >  {
> >  	struct airoha_eth *eth =3D dev->eth;
> > -	u32 val, reg;
> > +	u8 ref_addr[ETH_ALEN] =3D {};
> > +	u32 reg, val, lmin, lmax;
> > +	int i;
> > +
> > +	lmin =3D (addr[3] << 16) | (addr[4] << 8) | addr[5];
> > +	lmax =3D lmin;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> [ ... ]
> > +			ether_addr_copy(ref_addr, netdev->dev_addr);
> > +			val =3D (netdev->dev_addr[3] << 16) |
> > +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> > +			if (val < lmin)
> > +				lmin =3D val;
> > +			if (val > lmax)
> > +				lmax =3D val;
> > +		}
> > +	}
> > +
> > +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> > +		/* According to the HW design, hw mac address MS bits
> > +		 * must be the same for each net_device with the same
> > +		 * LAN/WAN configuration.
> > +		 */
> > +		return -EINVAL;
> > +	}
>=20
> Does this strict MSB validation cause device initialization to fail if the
> device tree does not provide MAC addresses?
>=20
> If the driver falls back to assigning addresses via eth_hw_addr_random(),
> the randomly generated addresses will almost certainly have different upp=
er
> 3 bytes. Will this cause airoha_set_macaddr() to return -EINVAL for the
> second interface, aborting initialization and failing the driver probe?
>=20
> Could this also create a configuration deadlock when users try to change
> MAC addresses from userspace?
>=20
> Since tools like 'ip link' configure interfaces sequentially, attempting =
to
> change eth0 to a new OUI would be rejected because its new MSBs won't mat=
ch
> eth1's current MSBs. Attempting to change eth1 first would similarly fail
> against eth0. Is there a way for users to successfully change the MAC
> address MSBs once the interfaces are initialized?

This is a requirement imposed by the hw design. If two (or multiple) interf=
aces
are configured as LAN (or WAN), they will need to share the mac address MSB=
s.
This requirement is not needed if the interfaces are running with different
configuration (e.g. eth0 LAN and eth1 WAN).

Regards,
Lorenzo

>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D11

--ZlIWd/tj4LYu8Qia
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagF/FAAKCRA6cBh0uS2t
rDUAAQC42MjVeAQpBqx1CV5rx//gp30sR3/PT6pWl/C/wkhoEQEA5zUzxnW/i/E8
KPG2R49/1yawnEp+dMqpLYqs9pFzYAs=
=xF6L
-----END PGP SIGNATURE-----

--ZlIWd/tj4LYu8Qia--

--8oYFmv0ov8O7OkN7--

--z5huEB/eopKkhfvT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGIDAAKCRA6cBh0uS2t
rGWtAQDtVEQJLwXVJLRckSNNCQrUIIJuhB1CYKElMgju8Y4LXgEAjHU98JtwfaK6
vKRFx5Jkr0NzOBnrVH5Bpdnz0sQZcw0=
=PcFC
-----END PGP SIGNATURE-----

--z5huEB/eopKkhfvT--

