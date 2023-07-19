Return-Path: <netdev+bounces-18883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C68758F65
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC75D28120A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242AC8EF;
	Wed, 19 Jul 2023 07:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6387C8C9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:45:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DB02681
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689752751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7xRfRSvgVVrhgxbOcK9k3MGaaEalRaBl97IvWBViA4=;
	b=UD12wRActMb/ZA2W+kOW5FHcvugbG2YlxCLSXovHW6M5OSMsRXQ519C7LqV2PqtvU7soGZ
	ZxFUf1yePsxUwciFSMPMywR89rBktrhsqlwHpE6uBZI7izY9fU6w2AYdGbHDL/7IoLmPzc
	wvAV+Tx8ALkaD57C+jp9jEUXErfgVlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Fj6UdUMZPvqqLZS7QytO3A-1; Wed, 19 Jul 2023 03:45:49 -0400
X-MC-Unique: Fj6UdUMZPvqqLZS7QytO3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so37022925e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752749; x=1690357549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7xRfRSvgVVrhgxbOcK9k3MGaaEalRaBl97IvWBViA4=;
        b=ZAUPsN6UyWZUzLwMWPoRnbukW7bicoW4iHus9cut/smLImxI3iFEh8UQgIOkTnJcTy
         iGiczqGITtR8IQxZq9WKY45FlKUJTb7dSfocwlcX93V5mkq/RLJAw5poPlbbLlfTfKzn
         RE4QG3Otk94lgcY/Oz5JW1OTzEDKxS1oMOstOOqZph2+sOLLUtL3y0O10g1wtxMM3ZSx
         80FyMy6wJoy9LgxddDES2401VYpIXnUkI4L9KHzxLLcJNNHkTBhibhwoE3fweKdtuVZF
         Rq55pxZ66fH9Da5NtYz+TBdafnzf+0Sz90wPCqX2ZeCsG5OfQOsMuEGXcxSRLLCACBS/
         fuTw==
X-Gm-Message-State: ABy/qLY/1VaJQL45IQPscuvLkz4oSl/GqVwwRMU9jXh+t822ey7o3dUr
	1kefGjwqLbtEorUfxOtbOR89x8FlDaRXFIv8vh028BjSOLP4PFHy5yhfDyfJJBChJyIWRoxAQxF
	Bx8S4YCCpSACXtloL
X-Received: by 2002:a7b:c456:0:b0:3fb:a6ee:4cec with SMTP id l22-20020a7bc456000000b003fba6ee4cecmr3820578wmi.33.1689752748813;
        Wed, 19 Jul 2023 00:45:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFMLZKSxq7F5LPg4Fx0AA5d2LL5/pFgLGRKxUm8gQCvGOZCvpj1Ssuw2aSS+V/KfG/hnhfaQ==
X-Received: by 2002:a7b:c456:0:b0:3fb:a6ee:4cec with SMTP id l22-20020a7bc456000000b003fba6ee4cecmr3820569wmi.33.1689752748478;
        Wed, 19 Jul 2023 00:45:48 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b003fc015ae1e1sm1019510wmr.3.2023.07.19.00.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:45:47 -0700 (PDT)
Date: Wed, 19 Jul 2023 09:45:46 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: always
 mtk_get_ib1_pkt_type
Message-ID: <ZLeUqlqHcHbUSQVX@lore-desk>
References: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ESqLmvJwzuWNyDyo"
Content-Disposition: inline
In-Reply-To: <c0ae03d0182f4d27b874cbdf0059bc972c317f3c.1689727134.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ESqLmvJwzuWNyDyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> entries and bind debugfs files would display wrong data on NETSYS_V2 and
> later because instead of using mtk_get_ib1_pkt_type the driver would use
> MTK_FOE_IB1_PACKET_TYPE which corresponds to NETSYS_V1(.x) SoCs.
> Use mtk_get_ib1_pkt_type so entries and bind records display correctly.
>=20
> Fixes: 03a3180e5c09e ("net: ethernet: mtk_eth_soc: introduce flow offload=
ing support for mt7986")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c b/drivers/ne=
t/ethernet/mediatek/mtk_ppe_debugfs.c
> index 316fe2e70fead..1a97feca77f23 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
> @@ -98,7 +98,7 @@ mtk_ppe_debugfs_foe_show(struct seq_file *m, void *priv=
ate, bool bind)
> =20
>  		acct =3D mtk_foe_entry_get_mib(ppe, i, NULL);
> =20
> -		type =3D FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, entry->ib1);
> +		type =3D mtk_get_ib1_pkt_type(ppe->eth, entry->ib1);
>  		seq_printf(m, "%05x %s %7s", i,
>  			   mtk_foe_entry_state_str(state),
>  			   mtk_foe_pkt_type_str(type));
> --=20
> 2.41.0
>=20
>=20

--ESqLmvJwzuWNyDyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLeUqQAKCRA6cBh0uS2t
rMItAP9cG5nx1x++wWRU+VItTbh4XWUmLjFZMBYxpuC6g2SryQEA9jlez1vrwO/l
iJfZu2dQp7s/Fe1wazOV2nLlYLp+0AE=
=r4Sz
-----END PGP SIGNATURE-----

--ESqLmvJwzuWNyDyo--


