Return-Path: <netdev+bounces-13922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8473DFD9
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62CE1C208CA
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9148C1C;
	Mon, 26 Jun 2023 12:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620517F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:53:54 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5190
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:53:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fa08687246so2313301e87.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687784030; x=1690376030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJySR/HhhqrW+hTvdmOdNCtnyUfU5rcSxZkwGfkW1qQ=;
        b=AsaMasMlkqlqh9rPHBZljr0KW6AbQQBdHOvzYP/6ctgdpUruxdIx4UGhYn7mU1N7Xw
         Vtt6oj42dmztoxtgluztDvknqmv8A5ZsfCgp4+bG3XR0WK8nJJwRIrKum5uUiQkovE6D
         WpJSMqO7e47HvIQUt5G9T5i3y5xsK1P9b14hk86cbbcRv4VTr2NfQqng8xlrcRWuEkx2
         qwROEuYkw2pg8r61dQfkxbhz8Ur8GM00h9o193braBQLBc39k+bG3UIUrRZbswnZdtnV
         NJnHF9/rp9bDEcJYWnT6cbm3UR/qfnMUIGH0xgxkpA4IFHY4vpXjSEYXAnAt3ayCPisR
         sdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784030; x=1690376030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJySR/HhhqrW+hTvdmOdNCtnyUfU5rcSxZkwGfkW1qQ=;
        b=kKiY5nGyaJi+8abMIZeDSc5V7AxO3/2Tfb2wieeDZOwo2HSuwYkJUksDuxmlXQK0H2
         yn/tOo3W0hBrupnL7EsJZ0PyD5fNm99rhiCTPbmpYtu7btKqLqkwHj8sD+C+0t1nbdop
         BtITWis/CeGzDhh/nqL4dQp4mUvccMc0Fev5HKII/wY7mdADVn4pPNwIGr3gI6OTCMFE
         votGyJYTwf1DOeD2V5iG/F2l0PHrG6Pl/Vqvhjh/zCkcdBjY5P5v3T0kk2Y96hak+XBS
         o/p1+z7m2V/j7w35hKDBhAT5Pg2sRb6GVrtXoU3q1I4/i7SVbiNWnXUeiUpoYhQQw9TT
         cgSg==
X-Gm-Message-State: AC+VfDybPl6/rlH6NzaiZN5XI6u3n9gqBXJvYbGL2WlJB5fcAB9zsU14
	nZT2YfIzX56N673zlsv7IAY=
X-Google-Smtp-Source: ACHHUZ65YjPHBt8caMX2djxpPGOVmGH1Z6ZzB83pE+m0UzQHV/6XBLR0SW18TWWVJXdbIwySGiIuPg==
X-Received: by 2002:a05:6512:3b82:b0:4fb:7be5:4870 with SMTP id g2-20020a0565123b8200b004fb7be54870mr393844lfv.46.1687784029898;
        Mon, 26 Jun 2023 05:53:49 -0700 (PDT)
Received: from localhost.localdomain ([185.215.195.243])
        by smtp.googlemail.com with ESMTPSA id i12-20020aa7dd0c000000b0051830f22825sm2825707edv.90.2023.06.26.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:53:49 -0700 (PDT)
From: Davide Tronchin <davide.tronchin.94@gmail.com>
To: bjorn@mork.no
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	marco.demarco@posteo.net,
	Davide Tronchin <davide.tronchin.94@gmail.com>
Subject: [PATCH] net: usb: qmi_wwan: add u-blox 0x1312 composition
Date: Mon, 26 Jun 2023 14:53:36 +0200
Message-Id: <20230626125336.3127-1-davide.tronchin.94@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add RmNet support for LARA-R6 01B.

The new LARA-R6 product variant identified by the "01B" string can be
configured (by AT interface) in three different USB modes:
* Default mode (Vendor ID: 0x1546 Product ID: 0x1311) with 4 serial
interfaces
* RmNet mode (Vendor ID: 0x1546 Product ID: 0x1312) with 4 serial
interfaces and 1 RmNet virtual network interface
* CDC-ECM mode (Vendor ID: 0x1546 Product ID: 0x1313) with 4 serial
interface and 1 CDC-ECM virtual network interface
The first 4 interfaces of all the 3 configurations (default, RmNet, ECM)
are the same.

In RmNet mode LARA-R6 01B exposes the following interfaces:
If 0: Diagnostic
If 1: AT parser
If 2: AT parser
If 3: AT parset/alternative functions
If 4: RMNET interface

Signed-off-by: Davide Tronchin <davide.tronchin.94@gmail.com>
---

usb/devices file of the LARA-R6 01B module in RmNet USB mode:

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1546 ProdID=1312 Rev= 0.00
S:  Manufacturer=u-blox
S:  Product=u-blox Modem
S:  SerialNumber=1478200b
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 2e7c7b0cdc54..417f7ea1fffa 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1427,6 +1427,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
+	{QMI_QUIRK_SET_DTR(0x1546, 0x1312, 4)},	/* u-blox LARA-R6 01B */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 
 	/* 4. Gobi 1000 devices */
-- 
2.34.1


