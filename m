Return-Path: <netdev+bounces-28788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23C780B49
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D29C1C215DE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DC182C5;
	Fri, 18 Aug 2023 11:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F618031
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:41:03 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798C30E6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:41:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf1f632b8so103374866b.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692358859; x=1692963659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjOcPDGz0avLbN1YQ7XEMmQAuAORolgPH52bB96cGEM=;
        b=j/Hhj96JCzM4E+tAjcuVN44FXTK4yuZYN+FXIjdokOB9lyfFkl7t7RQtmnJzzFtp0g
         LSlnMhRuDNXKyLgMCo8TCyfteP0z373P/M08vxaIeNWqFeS0LMdakcmGX5deLIxob+D/
         GhPT7dYWEVUb3TTNwrUcdInhNV5D+EZcZxWWWgSC6mpI0MhIH5ZdKC50YZLWNOrUCUNL
         O+GueP1WJlviZ4fcteSZ/SHgzKQEmXo2HeMLa655QT+Lmjyj4C/USUD3/pq51RB51d/e
         N+R++I34Nz7M6MrqhuEjd6PmVdEDhTzrL2hlkFfjQsV6Lv2/j46kl1FNl1zTaBBzGpjk
         GjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692358859; x=1692963659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjOcPDGz0avLbN1YQ7XEMmQAuAORolgPH52bB96cGEM=;
        b=Hv161ELF3G4UADWVk2JRsLD+Ye/1NGvNfjsHtoQ7zNxTAtKTra+KZe6vgDgX3lPvPM
         ChiVp4Esm0dJ+DelwPqZJWiYVFLUxtf8FUQslb1GbqxZtjOrAzsB89FfmQ66kU8YG9VK
         E3vmRX8Fhurt6OjqZypE3i/Ehuev2aBcnK8FNGVoXRMfE9KGMbF6e3TZ4Wdk3E9+/xi8
         GOldBZpeAWCP4+uhLrnLQn8TVi2HvDiK82Ksl2++J++e9a8JG1gXZIVmBGA35M331FlS
         smvpL5zyArgeQ1W+g5SGhxuy0hslQbnyAVoZgAmfeaOQxmSvuUfCg05lrHZlC6EWeEvW
         zyKA==
X-Gm-Message-State: AOJu0YwHukqgc2ISgBTD3YmUUwkHRTQZLH0IsQ9v/E3/WwFZlnjPIt0B
	zrmYSkwPzxi/xGCUOVrxI3s=
X-Google-Smtp-Source: AGHT+IFVYIYsnbVVC6L2zlXIn4oT4ONTXvo5uF2TQfigJIVTNh1PPYKpEUKyiNMfgkdv7Sd6qU3Qzw==
X-Received: by 2002:a17:906:e:b0:9a0:9558:829e with SMTP id 14-20020a170906000e00b009a09558829emr1034702eja.52.1692358858702;
        Fri, 18 Aug 2023 04:40:58 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id fy3-20020a170906b7c300b009894b476310sm1059617ejb.163.2023.08.18.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 04:40:58 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:40:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230818114055.ovuh33cxanwgc63u@skbuf>
References: <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
 <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 12:11:15PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 17, 2023 at 10:17:54PM +0300, Vladimir Oltean wrote:
> > On Thu, Aug 17, 2023 at 08:52:12PM +0200, Andrew Lunn wrote:
> > > > Andrew, I'd argue that the MAC-PHY relationship between the DSA master
> > > > and the CPU port is equally clear as between 2 arbitrary cascade ports.
> > > > Which is: not clear at all. The RGMII standard does not talk about the
> > > > existence of a MAC role and a PHY role, to my knowledge.
> > > 
> > > The standard does talk about an optional in band status, placed onto
> > > the RXD pins during the inter packet gap. For that to work, there
> > > needs to be some notion of MAC and PHY side.
> > 
> > Well, opening the RGMII standard, it was quite stupid of myself to say
> > that. It says that the purpose of RGMII is to interconnect the MAC and
> > the PHY right from the first phrase.
> > 
> > You're also completely right in pointing out that the optional in-band
> > status is provided by the PHY on RXD[3:0].
> > 
> > Actually, MAC-to-MAC is not explicitly supported anywhere in the standard
> > (RGMII 2.0, 4/1/2002) that I can find. It simply seems to be a case of:
> > "whatever the PHY is required by the standard to do is specified in such
> > a way that when another MAC is put in its place (with RX and TX signals
> > inverted), the protocol still makes sense".
> > 
> > But, with that stretching of the standard considered, I'm still not
> > necessarily seeing which side is the MAC and which side is the PHY in a
> > MAC-to-MAC scenario.
> > 
> > With a bit of imagination, I could actually see 2 back-to-back MAC IPs
> > which both have logic to provide the optional in-band status (with
> > hardcoded information) to the link partner's RXD[3:0]. No theory seems
> > to be broken by this (though I can't point to any real implementation).
> > 
> > So a MAC role would be the side that expects the in-band status to be
> > present on its RXD[3:0], and a PHY role would be the side that provides
> > it, and being in the MAC role does not preclude being in the PHY role?
> 
> ... trying to find an appropriate place in this thread to put this
> as I would like to post the realtek patch adding the phylink_get_caps
> method.
> 
> So, given the discussion so far, we have two patches to consider.
> 
> One patch from Linus which changes one of the users of the Realtek
> DSA driver to use "rgmii-id" instead of "rgmii". Do we still think
> that this a correct change given that we seem to be agreeing that
> the only thing that matters on the DSA end of this is that it's
> "rgmii" and the delays for the DSA end should be specified using
  ~~~~~~~
  I'd say not necessarily specifically "rgmii", but rather "rgmii*"

> the [tr]x-internal-delay-ps properties?

As long as it is understood that changing "rgmii" to "rgmii-id" is
expected to be inconsequential (placebo) for a fixed-link, I don't have
an objection (in principle) to that patch.

Though, to have more confidence in the validity of the change, I'd need
the phy-mode of the &gmac0 node from arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
and I'm not seeing it.

Looking at its driver (drivers/net/ethernet/cortina/gemini.c), I don't
see any handling of RGMII delays, and it accepts any RGMII phy-mode.

So, if neither the Ethernet controller nor the RTL8366RB switch are
adding RGMII delays, it becomes plausible that there are skews added
through PCB traces. In that case, the current phy-mode = "rgmii" would
be the correct choice, and changing that would be invalid. Some more
documentary work would be needed.

In any case, I wouldn't rush a change to arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
and I'm not seeing any dependency between that and your phylink_get_caps
conversion for the rtl8366rb.

> The second patch is my patch adding a phylink_get_caps method for
> Realtek drivers - should that allow all "rgmii" interface types,
> or do we want to just allow "rgmii" to encourage the use of the
> [tr]x-internal-delay-ps properties?

Same opinion as above. As long as it's understood that the RTL8366RB
MAC, like any other MAC, shouldn't be acting upon the phy-mode when
adding delays, let's just accept all 4 variants, with future support to
be added for [rt]x-internal-delay-ps if there turn out to be
configurable MAC-side delays present.

