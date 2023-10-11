Return-Path: <netdev+bounces-40174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B37C60D8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194DC1C209C9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF722301;
	Wed, 11 Oct 2023 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XB667GuA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQFBzarC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8984249FE
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:08:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF2A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:08:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3268D1F45F;
	Wed, 11 Oct 2023 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697065703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5fuOHWTPYIPUsuq4ER4fOn7OVZRS2D/2cd0ZoV+av4=;
	b=XB667GuAL+1fh/1Owea/tQ+PMf/Wk0srFJkgn7dCmfmT9+kPtmQe7XXOaU138mue9zrDlK
	ZNyWnwqRw3zqZr30YVjm6jdZwmOcsNOGYvLEGY4vTsz+m7Yl3rp4ONFqkcUA798sPUZgOp
	15TRPwwLNXcDfwcDYaSf0cOPhBEaJWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697065703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5fuOHWTPYIPUsuq4ER4fOn7OVZRS2D/2cd0ZoV+av4=;
	b=SQFBzarC5418csHb3qzAJJKvJNwr0pWAreHwRi1qEFWF8Ryq10dOfJgxCuRlBUVVKzIRxm
	XWZo/eslJ6wcJFCA==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn1.prg.suse.de [10.100.225.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 67FF62C7FC;
	Wed, 11 Oct 2023 23:08:21 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 5C7642016B; Thu, 12 Oct 2023 01:08:21 +0200 (CEST)
Date: Thu, 12 Oct 2023 01:08:21 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, opendmb@gmail.com,
	justin.chen@broadcom.com
Subject: Re: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Message-ID: <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
 <20231011221242.4180589-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iqr6bzc5noldlfbg"
Content-Disposition: inline
In-Reply-To: <20231011221242.4180589-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--iqr6bzc5noldlfbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 03:12:39PM -0700, Florian Fainelli wrote:
> Allow Ethernet PHY and MAC drivers with simplified matching logic to be
> waking-up on a custom MAC destination address. This is particularly
> useful for Ethernet PHYs which have limited amounts of buffering but can
> still wake-up on a custom MAC destination address.
>=20
> When WAKE_MDA is specified, the "sopass" field in the existing struct
> ethtool_wolinfo is re-purposed to hold a custom MAC destination address
> to match against.
>=20
> Example:
> 	ethtool -s eth0 wol e mac-da 01:00:5e:00:00:fb
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/networking/ethtool-netlink.rst |  7 ++++++-
>  include/uapi/linux/ethtool.h                 | 10 ++++++++--
>  include/uapi/linux/ethtool_netlink.h         |  1 +
>  net/ethtool/common.c                         |  1 +
>  net/ethtool/netlink.h                        |  2 +-
>  net/ethtool/wol.c                            | 21 ++++++++++++++++++++
>  6 files changed, 38 insertions(+), 4 deletions(-)
>=20
[...]
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index f7fba0dc87e5..8134ac8870bd 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -207,12 +207,17 @@ struct ethtool_drvinfo {
>   * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
>   * @sopass: SecureOn(tm) password; meaningful only if %WAKE_MAGICSECURE
>   *	is set in @wolopts.
> + * @mac_da: Destination MAC address to match; meaningful only if
> + *	%WAKE_MDA is set in @wolopts.
>   */
>  struct ethtool_wolinfo {
>  	__u32	cmd;
>  	__u32	supported;
>  	__u32	wolopts;
> -	__u8	sopass[SOPASS_MAX];
> +	union {
> +		__u8	sopass[SOPASS_MAX];
> +		__u8	mac_da[ETH_ALEN];
> +	};
>  };

If we use the union here, we should also make sure the request cannot
set both WAKE_MAGICSECURE and WAKE_MDA, otherwise the same data will be
used for two different values (and interpreted in two different ways in
GET requests and notifications).

Another option would be keeping the existing structure for ioctl UAPI
and using another structure (like we did in other cases where we needed
new attributes beyond frozen ioctl structures) so that a combination of
WAKE_MAGICSECURE and WAKE_MDA is possible. (It doesn't seem to make much
sense to me to combine WAKE_MAGICSECURE with other bits but I can't rule
out someone might want that one day.)

[...]
> diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
> index 0ed56c9ac1bc..13dfcc9bb1e5 100644
> --- a/net/ethtool/wol.c
> +++ b/net/ethtool/wol.c
> @@ -12,6 +12,7 @@ struct wol_reply_data {
>  	struct ethnl_reply_data		base;
>  	struct ethtool_wolinfo		wol;
>  	bool				show_sopass;
> +	bool				show_mac_da;
>  };
> =20
>  #define WOL_REPDATA(__reply_base) \
> @@ -41,6 +42,8 @@ static int wol_prepare_data(const struct ethnl_req_info=
 *req_base,
>  	/* do not include password in notifications */
>  	data->show_sopass =3D !genl_info_is_ntf(info) &&
>  		(data->wol.supported & WAKE_MAGICSECURE);
> +	data->show_mac_da =3D !genl_info_is_ntf(info) &&
> +		(data->wol.supported & WAKE_MDA);
> =20
>  	return 0;
>  }

The test for !genl_info_is_ntf(info) above is meant to prevent the
sopass value (which is supposed to be secret) from being included in
notifications which can be seen by unprivileged users. Is the MAC
address to match also supposed to be secret?

Michal

--iqr6bzc5noldlfbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUnKt0ACgkQ538sG/LR
dpW+RQgApPieVB1wFP0IzdOjPTophfQfEiiEfRN1y9xKYt1rviWmQaR1q3xplS/7
GY620DfpjCwWpCQ2AMWWcy3rmld2fJQUgvdlyKfMPT4YAofLlaWHzX6rQkmp05lA
E9+21TN1IIJXbe+61r+p8pVCBdyPMM1IHP9kcSs3wMd+Hq5oV4j1VlBqVHwY+aEx
QX7ztvD1zUk6zi2JcTH7ouF3WJA9Pjm9jeusEi0BC3ryQ1Q5TG/Ec25aJRqnOiNk
8z+wXuDBOjQQVyGbIsJ5Nrt1NtW2Aqbp53V7rVSYpWUm5Uoa7GDE20yW53hk+yWQ
Z4nkk80FCjCWMLknmJ/vHQmideKHaA==
=kN5u
-----END PGP SIGNATURE-----

--iqr6bzc5noldlfbg--

