Return-Path: <netdev+bounces-14519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12391742411
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B328280CFA
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CEBE5F;
	Thu, 29 Jun 2023 10:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EE15C9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:37:59 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5561FD7;
	Thu, 29 Jun 2023 03:37:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9920a6a6cb0so63932666b.3;
        Thu, 29 Jun 2023 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688035076; x=1690627076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XN5V8SfO8qHsuFFue4HRYt+RlC126GyX62QDFnswAVo=;
        b=CCrVOrQgcuNioz35cjKkVM5ts8pq7891DKa5/606kAiPw/HLBPCdfVqLU7Z2KV9IqV
         m369sLfQXQRQk8D/9I/Oa6b+TXU4HSk+kLVAgN74aAd/ZzrDdncbYteX6vTklLdRu3Md
         m3qHY3ixEhl5pT63ByANDaoQlQIOfqRUF9p4cjYSnyhczQsWjf2uL15wo3YGVDqeMzlN
         sgsrnMuxnxx1RqzRwyQmAGau+5/mqazw8MS2BDs9r1zzhvnz3cLN4xxd5wjs/RQwDZeZ
         rtRr6U0MX/89dSrkY6IYMnC8KlagEA0ap2ICmCvEL6WAsq+FfAuH6lMgFknp/C5y5Jcj
         dwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035076; x=1690627076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN5V8SfO8qHsuFFue4HRYt+RlC126GyX62QDFnswAVo=;
        b=E8LYN0KXSqhUarwpRMKjQJkBw4MxGAIgrwYDPYCNFYg8fNzjtUY8rc4+1XCXIV2S8H
         7aLt7y8XwouxY1RfFrUx7jg6N7/wNs8FMtb6othP4PLrCyLAGyY7VN3LmsyCfJJ4zJoW
         09wRNEAM24cerIWoe7zTKCzqaNDncUMQ6EQYyg06EOPXE1FCjZZAuF14qG+8Z2vjzhZV
         sK4QMjXlMFDphsIQNa3FiH2Qs/ICRrbOXVoHSZ6oUPiZVO46kPSTFxC2ppZ6YgSaMkFy
         oxluSBEPEyJe4Xi8xkhWpIAfjgPzZlLXU5GiYUfkZJNoZhLKgZ9rmqjj0Q7zHz+N7svg
         a8rg==
X-Gm-Message-State: AC+VfDwfp7oFQ5xXTWzS4tT/KHfKc8BKVpyTg9B6zYtfYo87Y+yjcz/N
	qWinWH9TQ+wAjDH/szeVW4o=
X-Google-Smtp-Source: ACHHUZ5fnHrl/tJfcI54MYO46wn+FeLkyvXyZuNwRPHYdlChqA2eBR73HKVAr1uWlqPieYm89QM7LA==
X-Received: by 2002:a17:907:2bc7:b0:98d:e696:de4f with SMTP id gv7-20020a1709072bc700b0098de696de4fmr11347296ejc.26.1688035075781;
        Thu, 29 Jun 2023 03:37:55 -0700 (PDT)
Received: from localhost.localdomain ([185.215.195.243])
        by smtp.googlemail.com with ESMTPSA id m5-20020a170906258500b009928b4e3b9fsm1420728ejb.114.2023.06.29.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:37:55 -0700 (PDT)
From: Davide Tronchin <davide.tronchin.94@gmail.com>
To: oliver@neukum.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	marco.demarco@posteo.net,
	linux-usb@vger.kernel.org,
	kuba@kernel.org,
	Davide Tronchin <davide.tronchin.94@gmail.com>
Subject: [PATCH] net: usb: cdc_ether: add u-blox 0x1313 composition.
Date: Thu, 29 Jun 2023 12:37:36 +0200
Message-Id: <20230629103736.23861-1-davide.tronchin.94@gmail.com>
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

Add CDC-ECM support for LARA-R6 01B.

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

In CDC-ECM mode LARA-R6 01B exposes the following interfaces:
If 0: Diagnostic
If 1: AT parser
If 2: AT parser
If 3: AT parset/alternative functions
If 4: CDC-ECM interface

Signed-off-by: Davide Tronchin <davide.tronchin.94@gmail.com>
---

usb/devices file of the LARA-R6 01B module in CDC-ECM USB mode:

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  9 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1546 ProdID=1313 Rev= 0.00
S:  Manufacturer=u-blox
S:  Product=u-blox Modem
S:  SerialNumber=1478200b
C:* #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 4 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
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
I:* If#= 4 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 5 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

---
 drivers/net/usb/cdc_ether.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 80849d115e5d..c00a89b24df9 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -875,6 +875,12 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET,
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* U-blox LARA-R6 01B */
+	USB_DEVICE_AND_INTERFACE_INFO(UBLOX_VENDOR_ID, 0x1313, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
 }, {
 	/* U-blox LARA-L6 */
 	USB_DEVICE_AND_INTERFACE_INFO(UBLOX_VENDOR_ID, 0x1343, USB_CLASS_COMM,
-- 
2.34.1


