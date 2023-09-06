Return-Path: <netdev+bounces-32182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4896793566
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4C11C209CA
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688467F5;
	Wed,  6 Sep 2023 06:34:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B402362
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 06:34:14 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F5CE2
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:34:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso2178244b3a.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 23:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693982052; x=1694586852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/xNVRv/SqaHopWDKjRF80DLYLu8IYyZILAs5U9Seag=;
        b=A6I7Ec8zyyFvTusdD8nEkZfU9ymJZteJNZ9gsf/HczFgqXfLZyv9+1Gj+ffpyV9o/M
         mmoDuWjvABJ4yXBNNuEZAKDp7OC/t4+kLJikdwUyivBKKqM9NFMuWDWIFhjggHaRMpOY
         laZAZdRhsE1nYv+gRAHSDbU8Hso3BHBYXOvj3G9ypGDfvElSPuZogIY914SmTy3UcLv7
         nDLaeAfkCedDox8ojRbw7+Rk/0g7ozLsa4ugLY/cjz04qITQI4h+ZbdclJgVWPgrgEO2
         BElBC+mEU3P5VVfiCcG87rFwwkMGRlKWvxkLkr7u4OVWYFUdnONFPw+3sl2gtEmqPtlv
         u+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982052; x=1694586852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/xNVRv/SqaHopWDKjRF80DLYLu8IYyZILAs5U9Seag=;
        b=VaqngPyPJYlyN66ujG/q+poWRyme5zPMKoqIZLgn8S4oB64YBiSSlL76nIBdyO+V0a
         EPT5lCY/3uoPNosWNBRuBo9Dg80ighqxcCX9S+96iZW8E4mkJGDO6S38Fq8fJ5aO/+no
         hK6Ir5nAscyScFChuzEibO4XdUtqXAf9gd+SFTG8RFmQ64LEFZPkT8s49aLsOHw0GoxZ
         O5S0EOtmSKU2xv1uEVDTaeNhO7nLQ6+W4WG2plZ6dF68HJ0mrqMF2tVHhPTJfuSBHglI
         RR9Twd/EPIjEpBo5/Zq1vGY/R3rS//m40L4Gozw8kJrKuPb1oEIhmgRKsvzcNb0c1IcQ
         onvw==
X-Gm-Message-State: AOJu0YwvhMVAJN3zsw2i3NEB2RzS4vyuQLZ/9lvn6q4MD5RHqfZkodcO
	m2mJiY5uxqb+d+0oN5hAnus=
X-Google-Smtp-Source: AGHT+IH/RriFEFYW7WonxKkeG4ce7TtqNkjS+GIRUrgd6n4W8eJGiUttBPJWMeoBDROQGz102R66EQ==
X-Received: by 2002:a05:6a00:c93:b0:68c:1a7:7dd3 with SMTP id a19-20020a056a000c9300b0068c01a77dd3mr16032121pfv.19.1693982052334;
        Tue, 05 Sep 2023 23:34:12 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z3-20020a63ac43000000b005658d3a46d7sm10689578pgn.84.2023.09.05.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 23:34:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id CDAFE8CC3855; Wed,  6 Sep 2023 13:34:08 +0700 (WIB)
Date: Wed, 6 Sep 2023 13:34:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net] net: phylink: fix sphinx complaint about invalid
 literal
Message-ID: <ZPgdYPNSgRU5mIA-@debian.me>
References: <20230905234202.1152383-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQ8sQ1e2Ewdh+nTG"
Content-Disposition: inline
In-Reply-To: <20230905234202.1152383-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--cQ8sQ1e2Ewdh+nTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 04:42:02PM -0700, Jakub Kicinski wrote:
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 7d07f8736431..2b886ea654bb 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -600,7 +600,7 @@ void pcs_get_state(struct phylink_pcs *pcs,
>   *
>   * The %neg_mode argument should be tested via the phylink_mode_*() fami=
ly of
>   * functions, or for PCS that set pcs->neg_mode true, should be tested
> - * against the %PHYLINK_PCS_NEG_* definitions.
> + * against the PHYLINK_PCS_NEG_* definitions.
>   */
>  int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	       phy_interface_t interface, const unsigned long *advertising,
> @@ -630,7 +630,7 @@ void pcs_an_restart(struct phylink_pcs *pcs);
>   *
>   * The %mode argument should be tested via the phylink_mode_*() family of
>   * functions, or for PCS that set pcs->neg_mode true, should be tested
> - * against the %PHYLINK_PCS_NEG_* definitions.
> + * against the PHYLINK_PCS_NEG_* definitions.
>   */
>  void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		 phy_interface_t interface, int speed, int duplex);

The fix LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cQ8sQ1e2Ewdh+nTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPgdUQAKCRD2uYlJVVFO
o93fAP9kQka51SrpgxNcO7Q+KK+bYwS7yVIda70QKJgtq07tywEAvdnWFhYMDY+o
yPgyyWzKainnGezqjqmNNb/6lTMi7QM=
=yAKU
-----END PGP SIGNATURE-----

--cQ8sQ1e2Ewdh+nTG--

