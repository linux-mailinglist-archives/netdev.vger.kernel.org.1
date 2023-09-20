Return-Path: <netdev+bounces-35281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AB7A896A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84104281CF9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC73E469;
	Wed, 20 Sep 2023 16:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86F3D3BF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:28:51 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB19F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:28:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-274d68dbb70so517587a91.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227328; x=1695832128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k35UWECj7WF1cs3JBeLrryMw3yMVvMXAvRDPAx352t0=;
        b=Xnb2BnwjR/SIhb1V5BksLVwhCe3xAVqP5oVkoQ3d2qgiiOJUEuJap2N9kJPSRoGbkk
         R+7SRkQ8sd5+4FabwVDu2pkHkX7u0ZtfxiZIQA1JbeGH9IZ+xmdzjYhRAQjgolc1kZQc
         6yYpizmvIAt+OSlsphbtS5mAvDtRThf2zecZKMOZLHoZAqcYmp6Cn/3p+V+TxUJxoQgO
         Wn3R95u9CFd+Cgg+Xe+v89NQ08HubOxxikp13pq7E3Zx8sQcE2yC5cCcyT4C1OW61wyJ
         9MN5tXmfu9EIpTpEISdKhUdcYlqibIu+Jdf22zljIMyWsqWeOuAvcTIRVVPCDmMwrUF2
         Eo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227328; x=1695832128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k35UWECj7WF1cs3JBeLrryMw3yMVvMXAvRDPAx352t0=;
        b=vx+KrVOrmnEXMzYHBonTRRdqPF9dsmssTAUdSZrhkBXitxfmUezJk9+wXF2TqN2igC
         1MGU6Zm2xRPPCIlis7zuLNZ2OCLZW1XDBscB9AVucaLyZmE3rD5ZELLqyIXSwgP3B9ac
         pCUwEFmtq+/wDUSQM5GIrnjQuEqt5LEWd7ksaG0dIpqeFdjcn2KTUugPNYetbfHK5tfO
         CHsoWXnI8XtbgQ4eMR3ixYi0Z1LstMOf/bt6FNCfXTm622jPUoBmXj1kQtQfp4Katvsb
         n3ZuVKLuVF7/3bRm+PFk32uSjBqlDAU7ndc3ThYv96t3B7u0Kmr0dcLSike0kw4DUSKF
         JPjA==
X-Gm-Message-State: AOJu0YxBWLaaka0ebu3evIky0/RD7SiNI3BRc9C9q61tWMbrJNcF9QoL
	7WX6zzGwb7fHfp391+UJbtiCWfZGqAGCCN6OeQ0=
X-Google-Smtp-Source: AGHT+IFZEbn22Uwh177ckEOUOn6U2LQcmyI8zW9orPyuYxWs0OvryaagJDEZkWayPLMI3LQwe9lqXc5N67WmIcKH32o=
X-Received: by 2002:a17:90a:4984:b0:26d:40ec:3cf3 with SMTP id
 d4-20020a17090a498400b0026d40ec3cf3mr3086940pjh.0.1695227328397; Wed, 20 Sep
 2023 09:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch> <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch> <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch> <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch> <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
 <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch> <CAOMZO5BV3MucdxhEXhLy+XTo7yh5vGDHuA1r82B8vdrexo+N6g@mail.gmail.com>
 <bcc0f229-fbf9-42f4-9128-63b9f61980ae@lunn.ch>
In-Reply-To: <bcc0f229-fbf9-42f4-9128-63b9f61980ae@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 13:28:36 -0300
Message-ID: <CAOMZO5BGB4paCc=r7H9w1nq9ZCetkmjQBowSAro5WjLW5EG+mw@mail.gmail.com>
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

On Wed, Sep 20, 2023 at 11:52=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> We have the helper mv88e6xxx_g2_eeprom_wait() which polls both bit 15
> and bit 11. Maybe we should use this instead of
> mv88e6xxx_g1_wait_eeprom_done()?

I tested your suggestion as shown below (sorry for the bad formatting):

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index a73008b9e0b3..6c93f2da5568 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3012,14 +3012,14 @@ static void mv88e6xxx_hardware_reset(struct
mv88e6xxx_chip *chip)
  * from the wrong location resulting in the switch booting
  * to wrong mode and inoperable.
  */
- mv88e6xxx_g1_wait_eeprom_done(chip);
+ mv88e6xxx_g2_eeprom_wait(chip);

  gpiod_set_value_cansleep(gpiod, 1);
  usleep_range(10000, 20000);
  gpiod_set_value_cansleep(gpiod, 0);
  usleep_range(10000, 20000);

- mv88e6xxx_g1_wait_eeprom_done(chip);
+ mv88e6xxx_g2_eeprom_wait(chip);
  }
 }

diff --git a/drivers/net/dsa/mv88e6xxx/global2.c
b/drivers/net/dsa/mv88e6xxx/global2.c
index ec49939968fa..ac302a935ce6 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -340,7 +340,7 @@ int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip)
  * Offset 0x15: EEPROM Addr (for 8-bit data access)
  */

-static int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
 {
  int bit =3D __bf_shf(MV88E6XXX_G2_EEPROM_CMD_BUSY);
  int err;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h
b/drivers/net/dsa/mv88e6xxx/global2.h
index c05fad5c9f19..6d8d38944b23 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -360,6 +360,8 @@ int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chi=
p);
 int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int tar=
get,
        int port);

+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip);
+
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6250_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6390_watchdog_ops;

If this works for Alfred, I can submit it as a proper patch.

Thanks

