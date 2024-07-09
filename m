Return-Path: <netdev+bounces-110262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678992BAD8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F21C21C56
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22893158D8C;
	Tue,  9 Jul 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eg0Cjm/T"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956D2B9DA;
	Tue,  9 Jul 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531248; cv=none; b=ilKh/6kXjR5RkA8aS1jvzMsq+5ask4ykaXt0aaHeo+PcjEzN8A2RW3Uf5rQYFCxFxBRAeHb5pVe+OmHR4k+9DVLriDJIju/pi/SaHBX83NmDcS1/Zxr2v2BxX00PVIAtuQoBovhz2fTQ7Y7+kvpnDkI8ZPOGGzX77OtUfwiFRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531248; c=relaxed/simple;
	bh=IWo9o+BR5hri80OXw059McKLXefmWML8DKmyfp52TPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlCJeJaZQ8n7fpR2jWh8+ke2fRY1ZHY0YUeJ1LUvZzMrtvwkvevrMcFZdZMdivd3v78eyvTBYB1Ye7BUJviioEKBc6LjBrjsgL0hJ+JqJ47DXQjNqfM/pT51znU9hWj+rIPBnwt5SBPf8yga6wrNiVUlKVqDPyC0F1E0ruLVNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eg0Cjm/T; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B18E1BF20B;
	Tue,  9 Jul 2024 13:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720531243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdgtcZmaR8+U0BJCpEZXKmWLsv2ubjnvbI1hvNLijts=;
	b=eg0Cjm/TBMLMJTS1BOIpLtUkMz04COoBTpzrwORid+BpxEyX+kDNujFxtgVc2TKgi/6s+X
	ZsQYZUVdQRO1F2olaO6cOrSqVISF8oPJdFlM0kXMx3QFu4eOENVEkOFMZBkDKg2LBTLBbK
	OwhnizFilnKwzPZCCR2kKpnElseJBhkd0kVqq6NtQfUfzX/zAP/yBrcu9QzMVCGtkzXWAX
	NJO0AQtf6fBqo7TgbU1q4WRitgzmkvmsqwmNhDZ9bBB7uMDIdwLtF1P4qAtmm6hB3qycjz
	0qCzV/9RVb3Wa2i/uyJ4HNvffzu8LoVD6q7E5B+SYUfbyBAvJOSnoAP8m8UoJw==
Date: Tue, 9 Jul 2024 15:20:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <20240709152041.7493ffc5@kmaincent-XPS-13-7390>
In-Reply-To: <20240708113300.3544d36d@kernel.org>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
	<20240704-feature_poe_power_cap-v6-5-320003204264@bootlin.com>
	<20240705184116.13d8235a@kernel.org>
	<20240708113846.215a2fde@kmaincent-XPS-13-7390>
	<20240708113300.3544d36d@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 8 Jul 2024 11:33:00 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 8 Jul 2024 11:38:46 +0200 Kory Maincent wrote:
>  [...] =20
>  [...] =20
>=20
> Don't worry I understand the code well enough to resolve any conflicts
> (famous last words?). And if we fix as part of ethnl_set_pse_validate()
> then there's no conflict, AFAICT.

As you can see in the patch I just sent
https://lore.kernel.org/netdev/20240709131201.166421-1-kory.maincent@bootli=
n.com/T/#u
the fix is not in set_pse_validate() therefore you will have a merge confli=
ct.

You could do this to solve the merge conflict:
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -256,6 +256,7 @@ static int
 ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
        struct net_device *dev =3D req_info->dev;
+       struct pse_control_config config =3D {};
        struct nlattr **tb =3D info->attrs;
        struct phy_device *phydev;
        int ret =3D 0;
@@ -273,15 +274,13 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct=
 genl_info *info)
        }
=20
        /* These values are already validated by the ethnl_pse_set_policy */
+       if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL])
+               config.podl_admin_control =3D nla_get_u32(tb[ETHTOOL_A_PODL=
_PSE_ADMIN_CONTROL]);
+       if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
+               config.c33_admin_control =3D nla_get_u32(tb[ETHTOOL_A_C33_P=
SE_ADMIN_CONTROL]);
+
        if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] ||
            tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]) {
-               struct pse_control_config config =3D {};
-
-               if (pse_has_podl(phydev->psec))
-                       config.podl_admin_control =3D nla_get_u32(tb[ETHTOO=
L_A_PODL_PSE_ADMIN_CONTROL]);
-               if (pse_has_c33(phydev->psec))
-                       config.c33_admin_control =3D nla_get_u32(tb[ETHTOOL=
_A_C33_PSE_ADMIN_CONTROL]);
-
                ret =3D pse_ethtool_set_config(phydev->psec, info->extack,
                                             &config);
                if (ret)


Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

