Return-Path: <netdev+bounces-35040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6547A6988
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22EC280C60
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D033717F;
	Tue, 19 Sep 2023 17:22:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857A37173
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:22:36 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD149F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:22:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99de884ad25so788675266b.3
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144153; x=1695748953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cGNNyLACgJb4AD5nR+SBP4DdztAWfhiNOuK7PDwoIw=;
        b=RiMU2tFoMn4nopsAf0RYvIOHZyxETlgv9cO8YA+WM9qJGO84ADeZx61hp+UbKYYgZd
         aFEnT47s4p03h5ATMkitCrwusZN5VGU2/Z1ZP8EdGsJ0b0Sl8psVE4jDw4fH8K+NBhvU
         a4PH1bN+ptDU7PZuMKgIHc5YQnpDfORJ0bsgYEQ53PTKJTH06rH9yjwQzNHYGhp0kihF
         73LTYcZx9NcBqToWiOLGVFDpK7Y5rMyGGDTpNHq9tCRhTT2dSREKKHv5+GEFw6c5itI0
         zogZ/rYB5NLe/1q1s1tmxRTkFxiKFq41/iF75UWxREGRi2DAMhIxaWXzyAixuFyO6Uj5
         Tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144153; x=1695748953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cGNNyLACgJb4AD5nR+SBP4DdztAWfhiNOuK7PDwoIw=;
        b=KYL8lgW5cuuRA4IXFwueR0CU7LEeKNYQM/TxvvAlJXm7VNDOzDqfzZeSxqc7TSvJXE
         PUiqXItvdIUbKd2ooWzog8ewA2uHmW88ZvZ9R3ovP3vPCxC7xu0qOs3CJ4xZWquAkPO3
         gR7MItXSA48PO01h+LNriEYTza+xn0DyvJoSEPWo0C+u5+iHv1+qmi1OGepF0/1jsRbj
         7HSxdHb5sVkTuSEMvMCPYprGi58fCNa64wYAs/H2chkHUVIxOQ2fjQfeRjVrLhfzx5Nm
         gag0W9h/pDHYv9KbVUZJ9i+xKgcLNGfa6S881OtrEp2OmVaFlWFcGvscfdfh5sWvv5Av
         RqXg==
X-Gm-Message-State: AOJu0YzSUqRUBScMdY+C+PI2KQ4Zzz8xZ7wgndoW/xes2/UqdLStDMU/
	tcFCIVaTw4GuRPjtVL9LTfc=
X-Google-Smtp-Source: AGHT+IFv8smAnvNFarSKEjNvCp7t+rF8X2hnJd77OUxGbDfg7ce42ijsLqP+RJ7vT0FdhbTF+1rjDg==
X-Received: by 2002:a17:906:5dcc:b0:99e:39d:4fa7 with SMTP id p12-20020a1709065dcc00b0099e039d4fa7mr37618ejv.22.1695144153180;
        Tue, 19 Sep 2023 10:22:33 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id rp15-20020a170906d96f00b009a1b857e3a5sm8086138ejb.54.2023.09.19.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:22:32 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject:
 Re: [PATCH net-next 04/54] net: ethernet: allwinner: Convert to platform
 remove callback returning void
Date: Tue, 19 Sep 2023 19:22:31 +0200
Message-ID: <3254669.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20230918204227.1316886-5-u.kleine-koenig@pengutronix.de>
References:
 <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne ponedeljek, 18. september 2023 ob 22:41:36 CEST je Uwe Kleine-K=F6nig=20
napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c
> b/drivers/net/ethernet/allwinner/sun4i-emac.c index
> a94c62956eed..d761c08fe5c1 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -1083,7 +1083,7 @@ static int emac_probe(struct platform_device *pdev)
>  	return ret;
>  }
>=20
> -static int emac_remove(struct platform_device *pdev)
> +static void emac_remove(struct platform_device *pdev)
>  {
>  	struct net_device *ndev =3D platform_get_drvdata(pdev);
>  	struct emac_board_info *db =3D netdev_priv(ndev);
> @@ -1101,7 +1101,6 @@ static int emac_remove(struct platform_device *pdev)
>  	free_netdev(ndev);
>=20
>  	dev_dbg(&pdev->dev, "released and freed device\n");
> -	return 0;
>  }
>=20
>  static int emac_suspend(struct platform_device *dev, pm_message_t state)
> @@ -1143,7 +1142,7 @@ static struct platform_driver emac_driver =3D {
>  		.of_match_table =3D emac_of_match,
>  	},
>  	.probe =3D emac_probe,
> -	.remove =3D emac_remove,
> +	.remove_new =3D emac_remove,
>  	.suspend =3D emac_suspend,
>  	.resume =3D emac_resume,
>  };





