Return-Path: <netdev+bounces-15079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3474585A
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA231C208C5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD432101;
	Mon,  3 Jul 2023 09:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924451C2F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:29:43 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CAE54
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:29:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so4886400f8f.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1688376578; x=1690968578;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjkMBQlWLVK/85bx/mxLHJJqdAqWMtYrx3dCfFnSH70=;
        b=WmMw/8F0esNbxrTKks1ydLc8m4kEZC6ygCyQTqJTNvmv5S9yrp4uR+Jc3xbpWAsv3b
         ccS3q3B0+ysrblX2V9Z9hgTt+0do4OGlKawoMQVUU9iZEdXGldO48fd9aSwLY7jk4QIW
         AQhYn3Sl1xE5y44Puj7e8qCHBOu5p3DyoxHmF8ECbN44LHSwvobMAI4BWwqTE0bzluTJ
         nM4Fo6HuPlMjqSk2m5AlBfJ9QHDXPNQMgxiIm6XEziKUprX80LqHZuBNKRupg+elLH+d
         jr+qykVVb1Dgtliq51KZ08t7vLBHFOlE+xUAs4PN6D1cEWKiP4WCnIAJ6QrH/IaThlph
         IeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376578; x=1690968578;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjkMBQlWLVK/85bx/mxLHJJqdAqWMtYrx3dCfFnSH70=;
        b=kgDTCwu3rFUbwih2DXq7vFj95HQGToQNjWvL1qDHFUTQlUHUTj5ellkGsh8NWVMD6H
         KgADGis0Oa4K7stegZuOLy/iJT1c+J2RwQY6DBmGh94S3lYXsQgujP7G7HshpFUfDDrW
         R7fehNApm0YN5ohfLVKRoF5JPEjS4JmBcmLw184oVJweqmNkPLMiJA9PZKxLB8Ahjxok
         9KSWQ3Ps0pWnX5smpvqW4R26WcBDtkSyffBHjv+jRy6ZIeyrzD5Q46DzSKmpaUHkHJR+
         JaTdVNTVhVrrf1+HIh9WtNIluzNF5RZDgCc+6VECHPQYV4Bp6XILwNIKJepTS1vMQ4ih
         UbMQ==
X-Gm-Message-State: ABy/qLZGm+4yxMRXF3T1d0h3c/PJ+oKTp20GSY3TfokhWmpEzDCPm1A3
	ceipshfGxuwYCdInd6W1be+9FQ==
X-Google-Smtp-Source: APBJJlFf1m55zA3YfVaqelh2ZMsCMufAS3V18tlG9cL/1NUNuriykoMcQlpAhGTiIgcCmBaZ3Vbwug==
X-Received: by 2002:a5d:58cf:0:b0:314:3503:15ac with SMTP id o15-20020a5d58cf000000b00314350315acmr2987020wrf.10.1688376577667;
        Mon, 03 Jul 2023 02:29:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31? (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id x18-20020adff0d2000000b003141e86e751sm9216161wro.5.2023.07.03.02.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:29:37 -0700 (PDT)
Message-ID: <3daee015-1192-5dc8-14cb-8e6988ddd2ee@smile.fr>
Date: Mon, 3 Jul 2023 11:29:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: TR: Linux Kernel KSZ9477 Driver Questions
Content-Language: fr, en-US
To: Lukas Rusak <lrusak@skytrac.ca>
References: <e6d383fa901d4d1abcb2a436de41d98b@skytrac.ca>
 <20230701150223.GA15522@pengutronix.de>
 <DBBPR09MB3560393990736BDCC65F4A049429A@DBBPR09MB3560.eurprd09.prod.outlook.com>
Cc: "arun.ramadoss@microchip.com" <arun.ramadoss@microchip.com>,
 Romain Naour <romain.naour@skf.com>, rakesh.sankaranarayanan@microchip.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <DBBPR09MB3560393990736BDCC65F4A049429A@DBBPR09MB3560.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Lukas,

Adding the Linux netdev mailing list in Cc.

Le 03/07/2023 à 11:10, Romain Naour a écrit :
> 
> --------------------------------------------------------------------------------
> *De :* Oleksij Rempel <o.rempel@pengutronix.de>
> *Envoyé :* samedi 1 juillet 2023 17:02
> *À :* Lukas Rusak <lrusak@skytrac.ca>
> *Cc :* arun.ramadoss@microchip.com <arun.ramadoss@microchip.com>;
> rakesh.sankaranarayanan@microchip.com <rakesh.sankaranarayanan@microchip.com>;
> Romain Naour <romain.naour@skf.com>
> *Objet :* Re: Linux Kernel KSZ9477 Driver Questions
>  
> [Vous ne recevez pas souvent de courriers de o.rempel@pengutronix.de. Découvrez
> pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification
> <https://aka.ms/LearnAboutSenderIdentification> ]
> 
> Caution: External Email
> 
> Hello Lukas,
> 
> On Wed, Jun 28, 2023 at 03:39:32PM +0000, Lukas Rusak wrote:
>> Hello All,
>>
>> I have some questions about the mainline KSZ9477 DSA driver. I'm saw
>> that you all are actively developing the driver via the drivers commit
>> history.
>>
>> Chipset: KSZ9896 Kernel version: 6.1.34
>>
>> I'm wondering how fully featured this driver is currently. I'm trying
>> to switch from the out of tree driver
>> (https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FMicrochip-Ethernet%2FEVB-KSZ9477&data=05%7C01%7Cromain.naour%40skf.com%7Cecf917241db84b04712a08db7a44313e%7C41875f2b33e8467092a8f643afbb243a%7C0%7C0%7C638238205539119182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=qkCsvUhZldpTtDwOlJ0Sq1bV3qEahbuJ%2B7SFLSVXRm8%3D&reserved=0 <https://github.com/Microchip-Ethernet/EVB-KSZ9477>)
>>
>> I'm running into an issue where our switch ports are only running at
>> 100mbps and I'm not sure if it's a configuration problem or something
>> missing in the driver.
>>
>> ethtool reports that 1000baseT/Full isn't advertised from the link
>> partner (but it works with the out of tree driver).
>>
>> Thoughts?
> 
> Hard to say something without debugging.
> 
> I worked with KSZ9563 back for some months with kernel 6.3.
> 1000BaseT/Full was working as expected. You seems to use different chip
> variant - KSZ9896, which I do no have. I hope some one with this variant
> can response here.

I checked on my board using the KSZ9896 and all ports are running at 1000Mb/s.
But I'm still using an vendor kernel 5.10.x where the driver has been backported.

# ethtool lan1
Settings for lan1:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Half 1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

[    5.423736] ksz9477-switch spi1.0: Found KSZ9477 or compatible
[    5.423736] ksz9477-switch spi1.0: Found KSZ9896
[    5.425628] ksz9477-switch spi1.0: Port5: using phy mode rgmii-txid
[    5.433868] ksz9477-switch spi1.0 lan1 (uninitialized): PHY [dsa-0.0:00]
driver [Microchip KSZ9477] (irq=POLL)
[    5.434783] ksz9477-switch spi1.0 lan2 (uninitialized): PHY [dsa-0.0:01]
driver [Microchip KSZ9477] (irq=POLL)
[    5.435638] ksz9477-switch spi1.0 lan3 (uninitialized): PHY [dsa-0.0:02]
driver [Microchip KSZ9477] (irq=POLL)
[    5.436492] ksz9477-switch spi1.0 lan4 (uninitialized): PHY [dsa-0.0:03]
driver [Microchip KSZ9477] (irq=POLL)
[    5.437530] ksz9477-switch spi1.0: configuring for fixed/rgmii-txid link mode
[    5.441680] ksz9477-switch spi1.0: Link is Up - 1Gbps/Full - flow control off
[  209.212463] ksz9477-switch spi1.0 lan1: configuring for phy/gmii link mode
[  212.343933] ksz9477-switch spi1.0 lan1: Link is Up - 1Gbps/Full - flow
control rx/tx

> 
>> Device tree snippet:
>> ksz9896c: ksz9896@5f {
>>         compatible = "microchip,ksz9896";
>>         reg = <0x5f>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&phy_pins>;
>>
>>         interrupt-parent = <&gpio0>;
>>         interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
>>
>>         reset-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
>>         status = "okay";
>>
>>         ports {
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>                 port@0 {
>>                         reg = <0>;
>>                         label = "bcx";
>>                 };
>>                 port@1 {
>>                         reg = <1>;
>>                         label = "maintenance";
>>                 };
>>                 port@2 {
>>                         reg = <2>;
>>                         label = "cabin0";
>>                 };
>>                 port@3 {
>>                         reg = <3>;
>>                         label = "cabin1";
>>                 };
>>                 port@5 {
>>                         reg = <5>;
>>                         label = "cpu";

This label is not needed, it was removed from the ksz binding exemple.

>>                         phy-mode = "rgmii-id";
>>                         rx-internal-delay-ps = <2000>;
>>                         tx-internal-delay-ps = <2000>;
>>                         ethernet = <&mac>;
>>                         fixed-link {
>>                                 speed = <1000>;
>>                                 full-duplex;
>>                         };
>>                 };
>>         };
>> };
> 
> 
> DT looks ok.

Agree.

Best Regards,
Romain

> 
> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       |
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix.de%2F&data=05%7C01%7Cromain.naour%40skf.com%7Cecf917241db84b04712a08db7a44313e%7C41875f2b33e8467092a8f643afbb243a%7C0%7C0%7C638238205539119182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=5Clj59OK1rFfV9vJYaY6b2PJNUg0Rr4yBcvb%2Bb8%2FuGw%3D&reserved=0 <http://www.pengutronix.de/>  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> The information contained in this email is intended solely for the use of the
> individual or entity to whom it is addressed and may contain information that is
> confidential. Please delete and notify the sender if received in error. SKF does
> not accept liability for any damage arising from this email.
> 
> For information on SKF’s processing of your personal data, please visit SKF’s
> Privacy Policy available via www.skf.com
> <https://www.skf.com/us/footer/privacy-policy>.
> 


