Return-Path: <netdev+bounces-255267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COeVJdwmfWkGQgIAu9opvQ
	(envelope-from <netdev+bounces-255267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:47:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C93BEE03
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BBD301111E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECB239E88;
	Fri, 30 Jan 2026 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="dXMsWLBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7E1A724C
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809626; cv=pass; b=bh986bvusNfYGc6Y7fMUjIMdse8Sq34QMfPEOpXVM9BnDUCRy3a9poXu0aKeg3WrsYowlVaCJT8+L3QO5VaATu0MB8SGfY9FsnySELgFz7W+L34pXhX980F8HZh4vUweU5kYr5XAI3z9vGzKNzsbDdAyNbugYvEo8yoCovthctA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809626; c=relaxed/simple;
	bh=Q4nD7UCCOcyO84ggSU7EZ3P1HGwvMHRcL3uoiw1nRMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pwroN53U79EAWlmv5GfAEfi4qDlX7Vsiy5cOBuMoBczPZbgQMapymetWDTGGdGDmZMMjZVhE3ZbFZwi+abnA/b20sFkRpE3sVLd41KbyORqHXxBqsZuKqQMl9T2DT/8BDJOxi286fExjvi91bGrxAS+qkSXR5XspNz7OvXck1t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=dXMsWLBk; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662f4faf95aso1415484eaf.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769809623; cv=none;
        d=google.com; s=arc-20240605;
        b=RWsxnhZ8xa2GaZAYYt0F7ox9OK9WMkvHvADv0+oudxSxz1BAsqBmH4zq3SzHj0kUX8
         DfJUi/+pI+E0ii24Kaj75jQUiNMYfVB/lRLYErFVFeBoBa3DhfuLTpPO3gUp96bjRoAi
         5/BSEMXkWzddQiDrjWbhnGsvwSb8+jOFJr/+E0bxydpxmCh2EtSu5pOT5p2SvtsYX6lD
         x7e7LJJgYIQS8SIZtIhpJBKklKAbfEsNuAHXm5hDF5MtjthJp39a3O9t2OQnPf/qhnWh
         NEffFQMm6ZCipIhBYR1wrzkko0s5qLia5wRoHaJThgzIcb3hWt2kqV9vEO8tzEHgiZHr
         75PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nrbWrYsen6SS71db9n2MmpGBiPPu8Ru8ite1b91qIlg=;
        fh=y3x7o9vEuetsL6zCFSqByP/jd3REfKSE/CnSudXfy1g=;
        b=c9zxW88PriOTi0u2vBTaB/BsK0hGIqXfICfEWyaL6OMVTgkF60j8B3rX6k7BFujC+v
         9k5lZCyDeb3jLpiQ5rFKkneo8p/Dvn8c9AjndrcGRda1T1QWK76pratExDJAlgltHIpK
         LFZj+UxCGrozJAJRa03lbo66gm77/SmJ+oH5ZerDCzhZDenr710KpxTdF61/Xrntzl/p
         QyIGska7kH1UD8kxJOLpHSHADJJhn6HiADrtb9A49rz54wubIwg6Wtgd8NJzhajgQnXh
         jzyfFTENX2+97PruLny41DMzvaroWXSUClX1pHYnymHTAvjCKMGgeqlxIdnXsgq6MOzl
         JdXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1769809623; x=1770414423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nrbWrYsen6SS71db9n2MmpGBiPPu8Ru8ite1b91qIlg=;
        b=dXMsWLBkE23DR1MCeBGLJEDdNnRi9lu2leC8cutKgLRhWJxSO+8R2Q7OR2Zg90pL/8
         Kv9u3ibeppPFlfTV9GvPzA3rgRiM1fRE6PY5LmBm6RaRfGB6cCdwraCvYOuXDFGTJ4c/
         Lkc1SLHrkzmuj/PxJpkLDzz5WRZHBN7XPRlnp5XV90e/8ChJAtqP1VzfC11HGgNj1IUs
         YaV0XXXJgmjCBurxPxivSfUFhtHg4J/fP8vR4EbgzZgWqNeDks3TICRozOWY3tlhsiAi
         H5ZOrJw7l6QQMqKabo43P/a/nlKoQXR6IZ+/fsiALkk3iN6Cue4aD8qPQUn1O+SNKLkB
         1rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769809623; x=1770414423;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrbWrYsen6SS71db9n2MmpGBiPPu8Ru8ite1b91qIlg=;
        b=envqAe24byxHX6X75iS2oK9ZmczJzWSbXUNU1abBWmzy+qs2Ag5RPTuSXhjtGSsTSE
         hSK7YI0wi04zYP20qErzwxzzZSB61jOIlSNbtP9aSxxJXBEmiI1M8uqQ3llr2AFslBs0
         LUFp68Gc9JgKQCuvRc2Wwrt/OGLGBHmwL0bz0ZYp44oIuChMnztrGGfLWvO+f9nsETR5
         iK99R6kjWwSYm5fShJE+/p4OoBZvQx6MUOHpTQzB2FBXdAmtnxAFGjVyuhNQiclXHHgt
         fvgPaCSehI7XFPGgvcC+T37gPfRhjs3H8q7ynsUfR3Cm+U9o9EtG1tGxsMej/JkRp+po
         F0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXGkY325wCXQU8rA83VlX2LAJcccJom0PdJXFOuu+FLWsICjpVJHlmRtyzLGZ/wL9XzW6V6p8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+qw3qqcU/cQ66G10WgCoSeuEAMly4XzZfIoVwp6yW+FtKRVb
	jvpJ5eTrYjNcZJ+hx3rOJg8bt1H8SWQm8JcJ4cFGob6LU5kPi447oEY2kfJcLHbSZ0PNfuaiadQ
	dbUhMHE6RPo6LGgcSCVybmMG84R3SZ1iN7KDfCvkHUg==
X-Gm-Gg: AZuq6aJMAcTcMdIMTr5toEN2Smh//kPhw7YwWe53oXa99SQFrPRtyzn8Wo3wO+rOJzv
	nDE61POJ8iibmai92aHlxJpj1qRB5t2x5Tmas2uBou+JT4VmBWiEPRlVykNhyhf6+lRuW14J9vI
	yDqtawSssgBGQdmgEmUEjjh3EgWmzOak5PUKZplMBbGveNEKNgOa83b9+7hZriPkIHMkprHk6AX
	nhNomgKK4+VOCmP19Yv9+MgveoIv/KaXHJ5shxgqyP1/0QQ7VKb4R5D1MyH219oMcUiKOs=
X-Received: by 2002:a4a:e90b:0:b0:663:a6e:49a7 with SMTP id
 006d021491bc7-6630f04dea4mr2403875eaf.19.1769809623224; Fri, 30 Jan 2026
 13:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 Jan 2026 13:46:52 -0800
X-Gm-Features: AZwV_Qj4JfWMSOdJXzmdjZj4h4jHJU7Bg6VHcZ8gr-AGeFYqDyW_OTUNpXBwPI4
Message-ID: <CAJ+vNU2c+kt3vX6PzqALakdwzyb5qh6O7Oj4xyxsWnsXCAUaRw@mail.gmail.com>
Subject: Re: [v1,3/3] net: dsa: microchip: add single-led-mode support for KSZ9477
To: Heinrich Toews <ht@twx-software.de>, netdev <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gateworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gateworks.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255267-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tharvey@gateworks.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gateworks.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,gateworks.com:dkim]
X-Rspamd-Queue-Id: 14C93BEE03
X-Rspamd-Action: no action

>
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index e5fa1f5fc09b3..bef8ec51d9483 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -815,6 +815,9 @@  static const u16 ksz9477_regs[] = {
>   [PTP_RTC_SEC] = 0x0508,
>   [PTP_SUBNANOSEC_RATE] = 0x050C,
>   [PTP_MSG_CONF1] = 0x0514,
> + [P_PHY_MMD_SETUP] = 0x011A,
> + [P_PHY_MMD_DATA] = 0x011C,
> + [P_PHY_DIGITAL_DEBUG_3] = 0x013C,
>  };
>
> @@ -3241,6 +3244,14 @@  static u32 ksz_get_phy_flags(struct dsa_switch
> *ds, int port)
>   if (!port)
>   return MICREL_KSZ8_P1_ERRATA;
>   break;
> + case KSZ9477_CHIP_ID:
> + /* KSZ9477S Errata DS80000754F
> + *
> + * Module 19: Single-LED Mode Setting Requires Two Register Writes
> + *   The PHY Port LEDx_0 pin does not go low in the presence of link
> + *   activity when Single-LED Mode is selected in the MMD LED Mode Register.
> + */
> + return MICREL_KSZ9_LED_ERRATA;
>   }
>

Hi Heinrich,

Thanks for doing this. I have two boards I work with that have a
KSZ9897S switch and use single-led mode (imx8mp-venice-gw74xx.dts and
imx8mm-venice-gw7901.dts) that suffer from this issue. In my scenario
I take care of this in the bootloader but when ksz9477_reset_switch()
is called and sets the SW_RESET bit of REG_SW_OPERATION it resets all
registers and reverts to tri-color dual-led mode thus we really do
need a dt prop and handling for this.

You can add the errata for KSZ9897 as well here:
+       case KSZ9897_CHIP_ID:
+               /* KSZ9897S Errata DS80000759F: Module 18 */
+               return MICREL_KSZ9_LED_ERRATA;

And because this errata applies to multiple chips it's probably best
to describe the workaround once and refer to the errata # in the cases
statements.

> +static void ksz_enable_single_led_mode(struct ksz_device *dev, int
> port, struct phy_device *phydev)
> +{
> + const u16 *regs = dev->info->regs;
> +
> + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x0002); /* Set up
> register address for MMD */
> + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0000); /* Select
> Register 00h of MMD */
> + ksz_pwrite16(dev, port, regs[P_PHY_MMD_SETUP], 0x4002); /* Select
> register data for MMD */
> + ksz_pwrite16(dev, port,  regs[P_PHY_MMD_DATA], 0x0011); /* Write
> value 0011h to MMD */

These are wrong: The MMD_SETUP and MMD_DATA regs you are using here
0x011a and 0x11c are actually 0xN11a 0x 0xN11c (where N is the port)
so they port specific so the above only would set them for port0.
Because these registers correspond to standardPHY register 0x0d and
0x0e which are defined in mii.h you can just use those.

What you want here is to use ksz_phy_write16 on the port which will
call the chip-specific w_phy which will handle writing to the port
specific register:
ksz_phy_write16(dev, port, MII_MMD_CTRL, 0x02);
ksz_phy_write16(dev, port, MII_MMD_DATA, 0x00);
ksz_phy_write16(dev, port, MII_MMD_CTRL, MII_MMD_CTRL_NOINCR | 0x02);
ksz_phy_write16(dev, port, MII_MMD_DATA, 0x10);

Note on that last one, the errata says to write 0x11 but that's a typo
as if you read closely it says 'setting bit 4' and looking at the
datasheet bit0 is reserved, so the 0x11 should be 0x10.

> +
> + /* According to KSZ9477S Errata DS80000754F (Module 19) 0xfa00 has to
> + * be written to the Debug Register 3 to enable Single-LED Mode.
> + */
> + if (phydev->dev_flags & MICREL_KSZ9_LED_ERRATA)
> + ksz_pwrite16(dev, port, regs[P_PHY_DIGITAL_DEBUG_3], 0xfa00);

Similarly the errata specifies this as PHY register 0x1E (which is a
vendor specific register so not defined in mii.h):

ksz_phy_write16(dev, port, 0x1e, 0xfa00);

Your original patch doesn't work in my case (maybe it worked for you
because you were trying to address port0?). With the above changes the
LED's are properly configured on my boards.

Best Regards,

Tim

> +
> + dev_info(dev->dev, "port-%d: single-led mode enabled.\n", port);
> +}
> +
>  static void ksz_set_100_10mbit(struct ksz_device *dev, int port, int speed)
>  {
>   const u8 *bitval = dev->info->xmii_ctrl0;
> @@ -3977,6 +4006,9 @@  static void ksz9477_phylink_mac_link_up(struct
> phylink_config *config,
>   int port = dp->index;
>   struct ksz_port *p;
>
> + if (dev->single_led_mode && port != dev->cpu_port)
> + ksz_enable_single_led_mode(dev, port, phydev);
> +
>   p = &dev->ports[port];
>
>   /* Internal PHYs */
> @@ -5526,6 +5558,8 @@  int ksz_switch_register(struct ksz_device *dev)
>     "wakeup-source");
>   dev->pme_active_high = of_property_read_bool(dev->dev->of_node,
>       "microchip,pme-active-high");
> + dev->single_led_mode = of_property_read_bool(dev->dev->of_node,
> +     "microchip,single-led-mode");
>   }
>
>   ret = dsa_register_switch(dev->ds);
> diff --git a/drivers/net/dsa/microchip/ksz_common.h
> b/drivers/net/dsa/microchip/ksz_common.h
> index 929aff4c55de5..9900e9dd91810 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -187,6 +187,7 @@  struct ksz_device {
>   bool synclko_disable;
>   bool wakeup_source;
>   bool pme_active_high;
> + bool single_led_mode; /* Enable Single LED Mode */
>
>   struct vlan_table *vlan_cache;
>
> @@ -277,6 +278,9 @@  enum ksz_regs {
>   PTP_RTC_SUB_NANOSEC,
>   PTP_SUBNANOSEC_RATE,
>   PTP_MSG_CONF1,
> + P_PHY_MMD_SETUP,
> + P_PHY_MMD_DATA,
> + P_PHY_DIGITAL_DEBUG_3,
>  };
>
>  enum ksz_masks {

