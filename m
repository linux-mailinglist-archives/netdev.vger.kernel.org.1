Return-Path: <netdev+bounces-13366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC5573B5AF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D16B1C21197
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D23230E4;
	Fri, 23 Jun 2023 10:47:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC115A2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:47:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF1172A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687517229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nETh/Lw2W7SGnjP8wll2BApCkVbghbtgYtpCp4VQbqc=;
	b=PEm3EDPJI/+EoTRF6LrawFCqhZp7uF8Y+tSPcMr9WWSxF52/XDjfInduJd2ndDhIa7rceH
	hXPVmCshHXTz0ebKNrAip3u8wX8MeY7ml9DUpsfBoOdvV5NKWBzhjQ8GUvNVH5dHZyojHl
	LHwshBVGzHlO/zulgUqemnTrTc6k9CY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-1CXoNoimOJ-YGFhRqsGavg-1; Fri, 23 Jun 2023 06:47:08 -0400
X-MC-Unique: 1CXoNoimOJ-YGFhRqsGavg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f8283a3a7aso1490561cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687517228; x=1690109228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nETh/Lw2W7SGnjP8wll2BApCkVbghbtgYtpCp4VQbqc=;
        b=F1+CMlBP8SpI16gKpUVn+ugG6Bo6r8qfvH0UXW5sz2ZN4hP7G/J9cWpup+jLyxnqOH
         uUYZ0Q5X+b2vl5gKf3Cu45NwnVRydfprs95BAFlVDKqN9lisJ5gX2k/AyIrM23N2OCu7
         ayeQ0+XTlX4XsxgztpvPl6C1RUFWSXma6Ayy5fupTES97nqJwS10Tq2qHdj51BUzKMM4
         ng6bUcAeYVYvbrK0OxSZTkZqFaK+t/rIFzS6qyjIchkQ2Jr8/SDImjhtws3WDVYpb5i4
         OlyTUMpqB+OzMuNF5jjH04UZvOvpto82dn42+h2scQu3YZe+k9W02vcGIA9YOFfOVLtz
         bGJg==
X-Gm-Message-State: AC+VfDyp2rRrAT0w6YgZ4wQfOgUljPRBhJBh1n/96DdoZXhLYr4GAwqE
	W7z1q3rbbOf2BgqW+SugeJXaT8hpk5bIP9f43MJU/W3ccT4kH9wFplGXcAj/tMdtWvXcIVS3JQW
	Qa/8+aitudNnA2jGQNuq2FW+W
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24784481qvb.0.1687517228227;
        Fri, 23 Jun 2023 03:47:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Gm/squTSMy9m40LaCvD2ysHBrcrQMuf0NjH5HLwOA+J3BPtQWIe8ZqgMcE5l2uSP+Lrh7Uw==
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id kd26-20020a056214401a00b0062deda34333mr24784475qvb.0.1687517227996;
        Fri, 23 Jun 2023 03:47:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ce391000000b0062df95d7ef6sm4833803qvl.115.2023.06.23.03.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:47:07 -0700 (PDT)
Message-ID: <5d71f0f5dfb2c12b6658e4804af3c364c182dbd5.camel@redhat.com>
Subject: Re: [PATCH v3 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
From: Paolo Abeni <pabeni@redhat.com>
To: Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Date: Fri, 23 Jun 2023 12:47:04 +0200
In-Reply-To: <1687388443-3069-1-git-send-email-Tristram.Ha@microchip.com>
References: <1687388443-3069-1-git-send-email-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-06-21 at 16:00 -0700, Tristram.Ha@microchip.com wrote:
> @@ -258,6 +265,249 @@ int lan87xx_read_status(struct phy_device *phydev)
[...]
> +static int lan874x_chk_wol_pattern(const u8 pattern[], const u16 *mask,
> +				   u8 len, u8 *data, u8 *datalen)

I think it would be nice adding some comments here describing the
implemented logic, for future memory.=20


> +{
> +	size_t i, j, k;
> +	int ret =3D 0;
> +	u16 bits;
> +
> +	i =3D 0;
> +	k =3D 0;
> +	while (len > 0) {
> +		bits =3D *mask;
> +		for (j =3D 0; j < 16; j++, i++, len--) {
> +			/* No more pattern. */
> +			if (!len) {
> +				/* The rest of bitmap is not empty. */
> +				if (bits)
> +					ret =3D i + 1;
> +				break;
> +			}
> +			if (bits & 1)
> +				data[k++] =3D pattern[i];
> +			bits >>=3D 1;
> +		}
> +		mask++;
> +	}
> +	*datalen =3D k;
> +	return ret;
> +}

[...]

> +static int lan874x_set_wol(struct phy_device *phydev,
> +			   struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *ndev =3D phydev->attached_dev;
> +	struct smsc_phy_priv *priv =3D phydev->priv;
> +	u16 val, val_wucsr;
> +	u8 data[128];
> +	u8 datalen;
> +	int rc;
> +
> +	if (wol->wolopts & WAKE_PHY)
> +		return -EOPNOTSUPP;
> +
> +	/* lan874x has only one WoL filter pattern */
> +	if ((wol->wolopts & (WAKE_ARP | WAKE_MCAST)) =3D=3D
> +	    (WAKE_ARP | WAKE_MCAST)) {
> +		phydev_info(phydev,
> +			    "lan874x WoL supports one of ARP|MCAST at a time\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rc =3D phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR=
);
> +	if (rc < 0)
> +		return rc;
> +
> +	val_wucsr =3D rc;
> +
> +	if (wol->wolopts & WAKE_UCAST)
> +		val_wucsr |=3D MII_LAN874X_PHY_WOL_PFDAEN;
> +	else
> +		val_wucsr &=3D ~MII_LAN874X_PHY_WOL_PFDAEN;
> +
> +	if (wol->wolopts & WAKE_BCAST)
> +		val_wucsr |=3D MII_LAN874X_PHY_WOL_BCSTEN;
> +	else
> +		val_wucsr &=3D ~MII_LAN874X_PHY_WOL_BCSTEN;
> +
> +	if (wol->wolopts & WAKE_MAGIC)
> +		val_wucsr |=3D MII_LAN874X_PHY_WOL_MPEN;
> +	else
> +		val_wucsr &=3D ~MII_LAN874X_PHY_WOL_MPEN;
> +
> +	/* Need to use pattern matching */
> +	if (wol->wolopts & (WAKE_ARP | WAKE_MCAST))
> +		val_wucsr |=3D MII_LAN874X_PHY_WOL_WUEN;
> +	else
> +		val_wucsr &=3D ~MII_LAN874X_PHY_WOL_WUEN;
> +
> +	if (wol->wolopts & WAKE_ARP) {
> +		u8 pattern[14] =3D {
> +			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x08, 0x06 };
> +		u16 mask[1] =3D { 0x303F };
> +		u8 len =3D 14;

'len' is never changed, you could use instead some macro with a
meaningful name.

> +
> +		rc =3D lan874x_chk_wol_pattern(pattern, mask, len, data,
> +					     &datalen);
> +		if (rc)
> +			phydev_dbg(phydev, "pattern not valid at %d\n", rc);
> +
> +		/* Need to match broadcast destination address. */
> +		val =3D MII_LAN874X_PHY_WOL_FILTER_BCSTEN;
> +		rc =3D lan874x_set_wol_pattern(phydev, val, data, datalen, mask,
> +					     len);
> +		if (rc < 0)
> +			return rc;
> +		priv->wol_arp =3D true;
> +	}
> +
> +	if (wol->wolopts & WAKE_MCAST) {
> +		u8 pattern[6] =3D { 0x33, 0x33, 0xFF, 0x00, 0x00, 0x00 };
> +		u16 mask[1] =3D { 0x0007 };
> +		u8 len =3D 0;

Same here, but now 'len' is 0, which makes the following
lan874x_chk_wol_pattern() a no-op. Was '3' in the initial revision, is
the above an unintentional change?!? Otherwise it would be clearer
avoid the lan874x_set_wol_pattern() call.=20

Thanks!

Paolo


