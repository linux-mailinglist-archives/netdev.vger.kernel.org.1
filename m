Return-Path: <netdev+bounces-28782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F17780ADC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567531C214B4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B2182B1;
	Fri, 18 Aug 2023 11:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42A14F61
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:13:20 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D0B3AAA;
	Fri, 18 Aug 2023 04:12:41 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7e68f4214so529213b6e.1;
        Fri, 18 Aug 2023 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692357159; x=1692961959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Khwz4zTp6MJ6PWK+A13n2it+/5tcAZGPGUfEiyppD6M=;
        b=mUCaI/ez38e9bNbQRf3z8GPGtiWc1nKM1Hgv/O0SWm8rGzSlZ0swl+XOvnOd87c+E1
         dzTPdjRnLm0e9jR43NR1B2Z1GXZ7LjXNA4+6efAJqqs/048z3YsC12hgo2cLoqLhLYlp
         FGptIeFpIwFIzvQMHHU1VBn4Fx2PJG9w+9EhzeR3OsmtZnzTf5FpLsOXxDFkXie2REDr
         Y2ldEPv7ejHIfgeD8hKIZ3y/CriKd3tJHHJSve6phTaLCtIM97qkLV46y6BzNwNxdabt
         OLAPsesWHhK4WD3c7BXN96r9C4Ckg3arAtzRcK6DDt9MLIygZyS4mWyzDZazdTVbQQvY
         oTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692357159; x=1692961959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khwz4zTp6MJ6PWK+A13n2it+/5tcAZGPGUfEiyppD6M=;
        b=G5+uS+gKjLzdUAHLS0tW/ADjwmp6nXAeczkoptSOOKqZL/ZEgeoNhNgIxit/DvR7rS
         u4HdCIKYlFbA8dDriKNrgz8QZ7qCTqsfwL1ST8Zq2yHwcqVU32p8hios4Tzyhrb4WLdd
         emjSOFokVUHCW/8FfRTBXMxhV56sheEdFgDAsUziMYh9PGcDk4K+PenTiVrc4X2W69sZ
         Z/spH7QH569mBei1d3/fS2E5eclPRg9i9rlbMIcTjwQR2073bV4SJ7QiFFs7x1YLB2dS
         zQn5kdS0SVpXTVtKS4c6OP/U+gbTNjd8xooxqD81S3D0VlegO//U/DWyao+rnlH59isU
         fe9g==
X-Gm-Message-State: AOJu0YxHHh6z9c/w+QhnukWqtNzTffQA2/CYbPFxTCJlLggq4TOaGHoG
	otQmlWrISI/eu0P8hPs4xwo=
X-Google-Smtp-Source: AGHT+IFEazWZG6MmX2ZZk7rM68ZYWmpLbl9yHN9X65owHjmeeVv92KZ4B++/1C5UXZjE7J5qBALiyQ==
X-Received: by 2002:aca:120f:0:b0:3a3:eab8:8c40 with SMTP id 15-20020aca120f000000b003a3eab88c40mr2157828ois.54.1692357157828;
        Fri, 18 Aug 2023 04:12:37 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x26-20020a63b21a000000b00553dcfc2179sm1282764pge.52.2023.08.18.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 04:12:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id C6A9D9DAC846; Fri, 18 Aug 2023 18:12:33 +0700 (WIB)
Date: Fri, 18 Aug 2023 18:12:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Fiona Ebner <f.ebner@proxmox.com>, linux-kernel@vger.kernel.org
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, jdelvare@suse.com,
	Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org, keescook@chromium.org,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: "Use slab_build_skb() instead" deprecation warning triggered by
 tg3
Message-ID: <ZN9SId_KNgI3dfVI@debian.me>
References: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvRWUCzAIjldd1ag"
Content-Disposition: inline
In-Reply-To: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--lvRWUCzAIjldd1ag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 10:05:11AM +0200, Fiona Ebner wrote:
> Hi,
> we've got a user report about the WARN_ONCE introduced by ce098da1497c
> ("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
> that the call comes from the tg3 module. While this is still kernel 6.2
> and I can't verify that the issue is still there with newer kernels, I
> don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
> ce098da1497c, so I thought I should let you know.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: ce098da1497c6d
#regzbot link: https://forum.proxmox.com/threads/132338/

PS: The proxmox forum link (except full dmesg log pasted there) is in
German, so someone fluent in the language can be helpful here.

--=20
An old man doll... just what I always wanted! - Clara

--lvRWUCzAIjldd1ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZN9SGQAKCRD2uYlJVVFO
o0TGAP93b0BAQsrPftlreCxezeMkGyoETtVZD/Bh6ikkhhbkmQD+LsOW9AHgHArX
CYWd86fU6Na6NAt8Hkpz0iw07tDG4Qg=
=RLLk
-----END PGP SIGNATURE-----

--lvRWUCzAIjldd1ag--

