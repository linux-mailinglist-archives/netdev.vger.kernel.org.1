Return-Path: <netdev+bounces-129002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B897CE3C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259551C22808
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC4455885;
	Thu, 19 Sep 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RO9kC8ys"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E0524C4;
	Thu, 19 Sep 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775455; cv=none; b=K+uYjR4Soe5FETzTTWcBtdWBY5Cs0/kzAKKHKa9NkyYhYOUuRfPyNw5GMe2t9Dy6+ig+IBwMSnGKcGJUTv354DyrSGjmlAn70cSIwoIiczgUnOE0KJUGRItPnfKr3Y4PBael7gNwiJSJNRb53h4llqNdqCw8GDOGfIKKGW74FnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775455; c=relaxed/simple;
	bh=es2tH5HR85ULg+VhL6Z13FNEk4ZnaR7pE1WXubqilL0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HetRX56u3YsozJ4h0nTyhONrXi12Cim8DUSILfKdMY1Dzez5LHoXTizCiPsY6m2saHsg/kXa/Wt8YC7cLLxt8EOT/oLdotEwTH9lJ7mahUKgErZxw3AB4d13JpxU6m+IdT+93RPWftR4Hzf1LkH9PEPG/xfyFk/c64Jqtda8Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RO9kC8ys; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726775420; x=1727380220; i=markus.elfring@web.de;
	bh=vVgLztpRxZMJV1LNxTel/o3SB6yp+N77eZ3BONwPVYI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RO9kC8yssHLYJm3wdAJQE76SlT/0P7uZB4JMaDqWUTcZOFyWGG4OeCeC7wRB40wS
	 Khq7G3rWQBL4m7YOk8Bgjku0SpM99RanmtQJPvjz0QxA0EmxIkPXTk9Uex0Y8J/3c
	 BCP8hZOmvG9ZIax3OoI9h58zwYlRYyFcf8/g1MBr4/614zfdUXQsdoNfOrFY+8ayO
	 Gaxf4Pkum+5xMQqnbKTd7ouDn6iI4kW6UiNXsUtNuMFAyQ/xrsVbZFgKZR6EWTnTS
	 EYfjH1BWFMfzaa9SNfWjwJmUrneSzNSNRcXhLgFIaQ/6dmsemv59FEhcfxEr8mScl
	 YlfZbRaU08OBYVczpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1skZ7r21ol-002yBe; Thu, 19
 Sep 2024 21:50:20 +0200
Message-ID: <7c98349a-bfa5-409b-847e-ed8439e80afd@web.de>
Date: Thu, 19 Sep 2024 21:50:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Himanshu Madhani <himanshu.madhani@qlogic.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Shahed Shaikh <shshaikh@marvell.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Manish Chopra <manish.chopra@qlogic.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] qlcnic: Use common error handling code in four functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3jABXlty3BYOJnBWTdWUwXhQnKEO+rrzvq7Mn/F/JwQOyYeIAzt
 kfvg5+qyzPTWNrGue3BZgqbs+R1K3vHzslvj0pbAULnkL3XpEk/hkuhGUGMSvNHiRGn35JC
 VMtbpQI2hrx26AlWr/l6/fos30dJ+Plwzmuu5lxVBYU/FfBGVWyndw6XdUCthXO3tW7nkqc
 q/goHY8dYp0thSHjCX0zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:08z6dr4bPrs=;dMAySk9U+BbPwRvsn3RzvGxYeiN
 v64L34CZtUp9/SdebX0Z21Nw5stzVznBkUXFbibNh5Yqh+09NouHuSoc2qELGn4auI5Z3xTyW
 0d2Gy1hDqzCW9WTVwD+O/bivjpBVHeOVP9Cmn+dc6cfkFUwAFXG6d/wxUFHSW22dx9VJhDUHa
 Trrkg6oMrlFeZC8/FLMVBwRX9qPgxtaW7AAGopXmUuWv79PPzY1IDDuYMyrFnoxXj28+AGXCC
 1y9XNHG0LBKt2PyITuc8v1CnGyjQUblms3n/cJ/NUVaNlG2/0wO3OgF5sTj+b/U5MRvb6Mw7k
 +IlFzuW0vtXOxTQ8uXahXODCM2/9Fe1WDx7bwsXRDwAiJTIaisrh3PveNUKt79n5slQKsrt4I
 O47mM0viyZWMXhyPMaIIEetZomkOLKEJt4BuDrF4NRFvhPrxm2CfZ5SlbOljrAWoLNVZhBWZY
 3OXB466LiJ4Nyrmt5azsOL01spgLpOYcn1fzJ6RtC8KbjpdUfnv1KC9n2gYmrJes19YybUaW1
 mG2ZTWputWnjaTWlkTgu/I1b2u6zltm8q4ROnFCEVLj9BzAyndf/AZT1XyipmrSEWZPe8/AHF
 JkVYk6dOD2IH1Bxw17TD1biElGvHuAPn7QNMyhLG+iyMM9XZBZgfuq9P7xI7+lTQX2/QYWE5V
 E+Y0hgUrWduASaUuqaRx84bEPe1Jg887nUjmosVAvta7w1HWOQkh0PIxhcPwV9Nj/urQnpGPG
 Kczj3IVcaSr7sONreLEjzxuRV+vV16TZAFcXXbpdVjanTdROv0l+NDzThyBlYsxqXQkc7vfdC
 ESnOEd+3LdCtg2BNzfp/s/hA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2024 21:30:45 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of four function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 +--
 .../net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c | 86 ++++++++-----------
 2 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drive=
rs/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index b733374b4dc5..a8eaf10d9158 100644
=2D-- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -1333,17 +1333,13 @@ static int qlcnic_83xx_copy_bootloader(struct qlcn=
ic_adapter *adapter)

 	ret =3D qlcnic_83xx_lockless_flash_read32(adapter, src, p_cache,
 						size / sizeof(u32));
-	if (ret) {
-		vfree(p_cache);
-		return ret;
-	}
+	if (ret)
+		goto free_cache;
+
 	/* 16 byte write to MS memory */
 	ret =3D qlcnic_ms_mem_write128(adapter, dest, (u32 *)p_cache,
 				     size / 16);
-	if (ret) {
-		vfree(p_cache);
-		return ret;
-	}
+free_cache:
 	vfree(p_cache);

 	return ret;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c b/drivers/n=
et/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
index 74125188beb8..da1a6e68daf9 100644
=2D-- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
@@ -959,8 +959,8 @@ static ssize_t qlcnic_83xx_sysfs_flash_read_handler(st=
ruct file *filp,
 	if (!p_read_buf)
 		return -ENOMEM;
 	if (qlcnic_83xx_lock_flash(adapter) !=3D 0) {
-		kfree(p_read_buf);
-		return -EIO;
+		ret =3D -EIO;
+		goto free_read_buf;
 	}

 	ret =3D qlcnic_83xx_lockless_flash_read32(adapter, offset, p_read_buf,
@@ -968,8 +968,7 @@ static ssize_t qlcnic_83xx_sysfs_flash_read_handler(st=
ruct file *filp,

 	if (ret) {
 		qlcnic_83xx_unlock_flash(adapter);
-		kfree(p_read_buf);
-		return ret;
+		goto free_read_buf;
 	}

 	qlcnic_83xx_unlock_flash(adapter);
@@ -978,6 +977,10 @@ static ssize_t qlcnic_83xx_sysfs_flash_read_handler(s=
truct file *filp,
 	kfree(p_read_buf);

 	return size;
+
+free_read_buf:
+	kfree(p_read_buf);
+	return ret;
 }

 static int qlcnic_83xx_sysfs_flash_bulk_write(struct qlcnic_adapter *adap=
ter,
@@ -996,18 +999,13 @@ static int qlcnic_83xx_sysfs_flash_bulk_write(struct=
 qlcnic_adapter *adapter,
 	memcpy(p_cache, buf, size);
 	p_src =3D p_cache;

-	if (qlcnic_83xx_lock_flash(adapter) !=3D 0) {
-		kfree(p_cache);
-		return -EIO;
-	}
+	if (qlcnic_83xx_lock_flash(adapter))
+		goto free_cache;

 	if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 		ret =3D qlcnic_83xx_enable_flash_write(adapter);
-		if (ret) {
-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
-		}
+		if (ret)
+			goto unlock_adapter;
 	}

 	for (i =3D 0; i < count / QLC_83XX_FLASH_WRITE_MAX; i++) {
@@ -1018,16 +1016,11 @@ static int qlcnic_83xx_sysfs_flash_bulk_write(stru=
ct qlcnic_adapter *adapter,
 		if (ret) {
 			if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 				ret =3D qlcnic_83xx_disable_flash_write(adapter);
-				if (ret) {
-					kfree(p_cache);
-					qlcnic_83xx_unlock_flash(adapter);
-					return -EIO;
-				}
+				if (ret)
+					goto unlock_adapter;
 			}

-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
+			goto unlock_adapter;
 		}

 		p_src =3D p_src + sizeof(u32)*QLC_83XX_FLASH_WRITE_MAX;
@@ -1036,17 +1029,20 @@ static int qlcnic_83xx_sysfs_flash_bulk_write(stru=
ct qlcnic_adapter *adapter,

 	if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 		ret =3D qlcnic_83xx_disable_flash_write(adapter);
-		if (ret) {
-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
-		}
+		if (ret)
+			goto unlock_adapter;
 	}

 	kfree(p_cache);
 	qlcnic_83xx_unlock_flash(adapter);

 	return 0;
+
+unlock_adapter:
+	qlcnic_83xx_unlock_flash(adapter);
+free_cache:
+	kfree(p_cache);
+	return -EIO;
 }

 static int qlcnic_83xx_sysfs_flash_write(struct qlcnic_adapter *adapter,
@@ -1064,18 +1060,13 @@ static int qlcnic_83xx_sysfs_flash_write(struct ql=
cnic_adapter *adapter,
 	p_src =3D p_cache;
 	count =3D size / sizeof(u32);

-	if (qlcnic_83xx_lock_flash(adapter) !=3D 0) {
-		kfree(p_cache);
-		return -EIO;
-	}
+	if (qlcnic_83xx_lock_flash(adapter))
+		goto free_cache;

 	if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 		ret =3D qlcnic_83xx_enable_flash_write(adapter);
-		if (ret) {
-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
-		}
+		if (ret)
+			goto unlock_adapter;
 	}

 	for (i =3D 0; i < count; i++) {
@@ -1083,15 +1074,11 @@ static int qlcnic_83xx_sysfs_flash_write(struct ql=
cnic_adapter *adapter,
 		if (ret) {
 			if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 				ret =3D qlcnic_83xx_disable_flash_write(adapter);
-				if (ret) {
-					kfree(p_cache);
-					qlcnic_83xx_unlock_flash(adapter);
-					return -EIO;
-				}
+				if (ret)
+					goto unlock_adapter;
 			}
-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
+
+			goto unlock_adapter;
 		}

 		p_src =3D p_src + sizeof(u32);
@@ -1100,17 +1087,20 @@ static int qlcnic_83xx_sysfs_flash_write(struct ql=
cnic_adapter *adapter,

 	if (adapter->ahw->fdt.mfg_id =3D=3D adapter->flash_mfg_id) {
 		ret =3D qlcnic_83xx_disable_flash_write(adapter);
-		if (ret) {
-			kfree(p_cache);
-			qlcnic_83xx_unlock_flash(adapter);
-			return -EIO;
-		}
+		if (ret)
+			goto unlock_adapter;
 	}

 	kfree(p_cache);
 	qlcnic_83xx_unlock_flash(adapter);

 	return 0;
+
+unlock_adapter:
+	qlcnic_83xx_unlock_flash(adapter);
+free_cache:
+	kfree(p_cache);
+	return -EIO;
 }

 static ssize_t qlcnic_83xx_sysfs_flash_write_handler(struct file *filp,
=2D-
2.46.0


