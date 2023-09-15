Return-Path: <netdev+bounces-34155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B37A2593
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9708D281D13
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDA18AE7;
	Fri, 15 Sep 2023 18:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58D15EBF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:24:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61451FCC
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ixBY3PdQg6K9AmW2W5HVSxVIiOYYH+6HxfzyE7N2Nag=; b=Il
	GL7ndA54bg9BOaqwF9OOsEogkS4MUVAybJ0D2QuNV6oLT0oAycfMVZxEjb0xnNKqBB4tMKdBJAQT4
	HxfiPxhzNxf6CYuG1pY7lO/ex1yHWUMmEhYTKP7sWrias65N9TVZlO+4B7flCT8zZzLFbhJSvR+Sd
	aEMoNeUJ7TEH8iM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhDTq-006ZMj-Ty; Fri, 15 Sep 2023 20:23:50 +0200
Date: Fri, 15 Sep 2023 20:23:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
 <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
 <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
 <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
 <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Back to mv88e6xxx_g1_read(): should we check whether the EEPROM is
> present and bail out if absent?
> 
> Did a quick hack just to show the idea. Please let me know what you think.
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/global1.c
> b/drivers/net/dsa/mv88e6xxx/global1.c
> index 5848112036b0..0e8b8667e897 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1.c
> +++ b/drivers/net/dsa/mv88e6xxx/global1.c
> @@ -12,6 +12,7 @@
> 
>  #include "chip.h"
>  #include "global1.h"
> +#include "global2.h"
> 
>  int mv88e6xxx_g1_read(struct mv88e6xxx_chip *chip, int reg, u16 *val)
>  {
> @@ -80,6 +81,13 @@ void mv88e6xxx_g1_wait_eeprom_done(struct
> mv88e6xxx_chip *chip)
>         const unsigned long timeout = jiffies + 1 * HZ;
>         u16 val;
>         int err;
> +       u16 data;
> +       u8 addr = 0;
> +
> +       err = mv88e6xxx_g2_eeprom_read16(chip, addr, &data);

The problem with this is that the way to read the contests of the
EEPROM depend on the switch family.

linux/drivers/net/dsa/mv88e6xxx$ grep \.get_eeprom chip.c
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
	.get_eeprom = mv88e6xxx_g2_get_eeprom8,


> +       /* Test whether EEPROM is present and bail out if absent */
> +       if (data == 0xffff)
> +               return;

And how do you know the EEPROM does not in fact contain 0xffff?

What i found interesting in the datasheet for the 6352:

     The EEInt indicates the processing of the EEPROM contents is
     complete and the I/O registers are now available for CPU
     access. A CPU can use this interrupt to know it is OK to start
     accessing the device’s registers. The EEInt will assert the
     device’s INT pin even if not EEPROM is attached unless the EEPROM
     changes the contents of the EEIntMast register (Global 1, offset
     0x04) or if the Test SW_MODE has been configured (see 8888E6352,
     88E6240, 88E6176, and 88E6172 Functional Specification Datasheet,
     Part 1 of 3: Overview, Pinout, Applications, Mechanical and
     Electrical Specifications for details).  The StatsDone, VTUDone
     and ATUDone interrupts de-assert after the Switch Globa

So i would expect that EEInt is set when there is no EEPROM.

What strapping do you have for SW_MODE? Is the switch actually in
standalone mode?

	   Andrew

