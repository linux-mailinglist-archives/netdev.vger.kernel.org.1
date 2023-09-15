Return-Path: <netdev+bounces-34134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800AD7A243D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDCB1C20AC3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5A1426C;
	Fri, 15 Sep 2023 17:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D311125B0
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:05:39 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E73F3
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:05:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso470798a91.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694797537; x=1695402337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qKpMrSJ/og89OfULkbxRwNCmQAg/JMj84HKaMwb7ro=;
        b=eUbXQzzQKCKn2VCiTp9z9rh+71vSK7dahq5OG5bZRLW2NCgN27gatwuf6EcE3Yuk+w
         1sbB2BHUM2mreu4yMrV/ztdpnA8vCHZcqgBEFQiBO2+yTVMT4l5GHNTS8yjqIxRd8//N
         vSLMMlq3zsDalEhT+5G3jKtHWFYH0tpVkdJP2izk9IjEYOx+oOlIr4ID5/0ZzJgv8GkS
         VV5z2nSLMcId7EtCyNn21it5X++Qf3XGHMpvXVxXNPmHzxrVLWAZEQyPJnPT+o/0MToH
         ofeXkhpMra9Vgy77vQsXkEf8Zof+hFJBvaX3jgvHMRNsaYWwIvyP5ItiCRr5/EHr6hIU
         0/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797537; x=1695402337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qKpMrSJ/og89OfULkbxRwNCmQAg/JMj84HKaMwb7ro=;
        b=Ec0mD9ZnRarw5ubUKC+u55e25cc5AZxVuQBLrV+nBgh61Dq6eiDtmUYYsIAIzWmQqW
         j7NQhKQ/c3fgprUULruYgCifFpZnJuItBUXhODISH1WTZg+rnDTkEvNbmAzNR2CRLw8U
         7ZdkbdKh7P97JrVR/Yp+ZGuD/c3MRxUWtfggoywIUDqH2YMJ0CYzUrnbpKADZDXgo5Yq
         nWhKCD0JQxas6X4LdT95EAFCIokQv8+B0Zqr6y95++bQ3Vh/BmIfi/gY9e0tMuxOP30i
         ybl3pdFpvl1GkBwBFICmKHLWVHYNOMbAUDm/tx9e6e4fOx972qnusYCLyLEqm8XTxyWF
         9FFA==
X-Gm-Message-State: AOJu0YyOmeXn0LQo202Z+h0Md64dKlV6whkZ6dw23tLZxlJZTBRwxHcl
	F3Ifculo7NpBSDBS5or7koL7Byn3/+iHwTMWypc=
X-Google-Smtp-Source: AGHT+IGZnm1vaS0unKRkYnyRUJ5rhi407h8XxTGQ1DSL9+ssLT+dL+KwIdEQ3uPPo3dAuEqHo1NrKNTnF+wHn9DO/Dg=
X-Received: by 2002:a17:90a:1787:b0:26d:412d:9ce8 with SMTP id
 q7-20020a17090a178700b0026d412d9ce8mr2081622pja.0.1694797537512; Fri, 15 Sep
 2023 10:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch> <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch> <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
In-Reply-To: <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Sep 2023 14:05:26 -0300
Message-ID: <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 11:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> As i said, we do a hardware reset later. All we are trying to do at
> this stage is probe the device, does it exist on the bus, and what ID
> value does it have. I want to avoid the overhead of doing a reset now,
> and then doing it again later.

Now I see your point, thanks.

Back to mv88e6xxx_g1_read(): should we check whether the EEPROM is
present and bail out if absent?

Did a quick hack just to show the idea. Please let me know what you think.

diff --git a/drivers/net/dsa/mv88e6xxx/global1.c
b/drivers/net/dsa/mv88e6xxx/global1.c
index 5848112036b0..0e8b8667e897 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -12,6 +12,7 @@

 #include "chip.h"
 #include "global1.h"
+#include "global2.h"

 int mv88e6xxx_g1_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)
 {
@@ -80,6 +81,13 @@ void mv88e6xxx_g1_wait_eeprom_done(struct
mv88e6xxx_chip *chip)
        const unsigned long timeout =3D jiffies + 1 * HZ;
        u16 val;
        int err;
+       u16 data;
+       u8 addr =3D 0;
+
+       err =3D mv88e6xxx_g2_eeprom_read16(chip, addr, &data);
+       /* Test whether EEPROM is present and bail out if absent */
+       if (data =3D=3D 0xffff)
+               return;

        /* Wait up to 1 second for the switch to finish reading the
         * EEPROM.
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c
b/drivers/net/dsa/mv88e6xxx/global2.c
index ec49939968fa..e75d7c029280 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -411,7 +411,7 @@ static int mv88e6xxx_g2_eeprom_write8(struct
mv88e6xxx_chip *chip,
        return mv88e6xxx_g2_eeprom_cmd(chip, cmd | data);
 }

-static int mv88e6xxx_g2_eeprom_read16(struct mv88e6xxx_chip *chip,
+int mv88e6xxx_g2_eeprom_read16(struct mv88e6xxx_chip *chip,
                                      u8 addr, u16 *data)
 {
        u16 cmd =3D MV88E6XXX_G2_EEPROM_CMD_OP_READ | addr;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h
b/drivers/net/dsa/mv88e6xxx/global2.h
index c05fad5c9f19..5bb6d6d7ca86 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -331,6 +331,7 @@ int mv88e6xxx_g2_get_eeprom16(struct mv88e6xxx_chip *ch=
ip,
                              struct ethtool_eeprom *eeprom, u8 *data);
 int mv88e6xxx_g2_set_eeprom16(struct mv88e6xxx_chip *chip,
                              struct ethtool_eeprom *eeprom, u8 *data);
+int mv88e6xxx_g2_eeprom_read16(struct mv88e6xxx_chip *chip, u8 addr,
u16 *data);

 int mv88e6xxx_g2_pvt_read(struct mv88e6xxx_chip *chip, int src_dev,
                          int src_port, u16 *data);

