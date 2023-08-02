Return-Path: <netdev+bounces-23584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49176C96C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60191C21204
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12E5693;
	Wed,  2 Aug 2023 09:25:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004B5691
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:25:12 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D629171C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:25:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so105056611fa.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20221208.gappssmtp.com; s=20221208; t=1690968308; x=1691573108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6+LT5AnXJWqsBFrgMPzoYnhOomhM/UwugjIu3qBxMM=;
        b=39a6Q/vaKN8itJqe0SnYz5BpgwVJjKra/huKGTY9PvFtAMZuDYJIJ7gDjPXur8DQ4Y
         HhHzvtk53fS7HAS6ZQG3BeW/4hXHlRHgnIyuSZ7opHsk6n3WkF4hKHCixK+DhgjNmr5V
         xtKcaSKwDOsSEsyyV6LZePEwOzFCMnmNslOLs8tCZmQElBtxZiCgbUhZxtRTCd2yqUFJ
         7d3ZYk54Aan2B3RuF9diYg91GhaKOdo5gWyqyUEPuml8YcvGPHJmC8GE0ES31XO3AZHF
         Biz93nKubVj1wVVGVqgR4BhLgFWD+iQQ5RGF0QVTVK6LnWDFA2/MM4gU1jTIyNANXUrs
         UrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968308; x=1691573108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6+LT5AnXJWqsBFrgMPzoYnhOomhM/UwugjIu3qBxMM=;
        b=I7y2zxlRoMgSkXus6b8fZMxrtltox8xScnbREkZF4ppsflrP2Kd1+Cr5shmkE2uJzM
         Xr+8IUR5WIaBPYvh+PtZ03RoVo0WmHAZOYGSoxMabD1A2cOr1J1Ui5Dta3Gtig4cgyN9
         3NeCGqodukwdz5rr3wG3vyu1pzwc0GlPrV7vAqb7A0xIJw+8wD7+PLYeO9F36BHYRo6o
         clWcPnwJMl5zksO5X4iP5wtzEq8/5Sl6+byGHXAuwBr5aiMnri2KjoWBMacnj8UAUrAU
         52j20B9mAE5oS8jYRbXFiUcjTJf8MEwqWPSLP2Ej0y96qJr2QlRKWKAackAujySxAXlJ
         h0Hw==
X-Gm-Message-State: ABy/qLbt7VqZ4A4pI5JLBgqymBkop2yY9ZSaHGVT8XghuFTFpOicVgXM
	/9ymKozoqSajmJaxjPhEbMW6enOZoGe0+QOLvbGtuwlz7y7R0nwBh+hB1YbYjhK9s8FrQlU0Dmn
	euwJbn2P6MQ==
X-Google-Smtp-Source: APBJJlFDRnTyap4fSmGp05DOOvvuyDmRWQi1MlOW0KAriUKx005/o4JVevyoooLIxdWg+WuGBepv2g==
X-Received: by 2002:a2e:9049:0:b0:2b6:c61c:745b with SMTP id n9-20020a2e9049000000b002b6c61c745bmr4599283ljg.3.1690968308366;
        Wed, 02 Aug 2023 02:25:08 -0700 (PDT)
Received: from localhost (dslb-088-076-253-094.088.076.pools.vodafone-ip.de. [88.76.253.94])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fbb5506e54sm1136084wme.29.2023.08.02.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:25:07 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Taras Chornyi <taras.chornyi@plvision.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vadym Kochan <vkochan@marvell.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] prestera: fix fallback to previous version on same major version
Date: Wed,  2 Aug 2023 11:23:56 +0200
Message-ID: <20230802092357.163944-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When both supported and previous version have the same major version,
and the firmwares are missing, the driver ends in a loop requesting the
same (previous) version over and over again:

    [   76.327413] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   76.339802] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.352162] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.364502] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.376848] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.389183] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.401522] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.413860] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.426199] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    ...

Fix this by inverting the check to that we aren't yet at the previous
version, and also check the minor version.

This also catches the case where both versions are the same, as it was
after commit bb5dbf2cc64d ("net: marvell: prestera: add firmware v4.0
support").

With this fix applied:

    [   88.499622] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   88.511995] Prestera DX 0000:01:00.0: failed to request previous fir=
mware: mrvl/prestera/mvsw_prestera_fw-v4.0.img
    [   88.522403] Prestera DX: probe of 0000:01:00.0 failed with error -2

Fixes: 47f26018a414 ("net: marvell: prestera: try to load previous fw versi=
on")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers=
/net/ethernet/marvell/prestera/prestera_pci.c
index f328d957b2db..35857dc19542 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -727,7 +727,8 @@ static int prestera_fw_get(struct prestera_fw *fw)
=20
 	err =3D request_firmware_direct(&fw->bin, fw_path, fw->dev.dev);
 	if (err) {
-		if (ver_maj =3D=3D PRESTERA_SUPP_FW_MAJ_VER) {
+		if (ver_maj !=3D PRESTERA_PREV_FW_MAJ_VER ||
+		    ver_min !=3D PRESTERA_PREV_FW_MIN_VER) {
 			ver_maj =3D PRESTERA_PREV_FW_MAJ_VER;
 			ver_min =3D PRESTERA_PREV_FW_MIN_VER;
=20
--=20
2.41.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294


