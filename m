Return-Path: <netdev+bounces-28824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6049780DF0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033531C2147A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF218C1D;
	Fri, 18 Aug 2023 14:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B018B09
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 14:21:31 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C04685
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:21:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so1251260a12.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692368468; x=1692973268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp3D2MsYGuIC471tUGfUT4+hNfJGeSTaBW0Z8Ynq+3w=;
        b=hwms58HYeW+BhIokmCUyqnpZ4ic+mQXlcg9ZetWw84UKViIAUFTQVGh5tGz8Uz4jOE
         Ln+/KQ2GlCAj493rbMgnJ91j5bbMaypegYiP+oJfF47pcIvuTHfhtWDNSy2/ffMMeDm+
         +Ux8+LSgODd/HBKRMwQAtmNTKGGPEKQQFlV0/axNlHoKhrgJJkKngXQNWmDRiax25gos
         MNeVw0gIrx8mRi72VFSYCA9k4EZPsjJ/GREdcNywS271b3AV5CDvUgleNTu4R3+oVR2b
         uRAQKDTm4HWPWvHKDWogFKyCQ8tyucRhiWvT06t9rr/S+YNq85mEf0Nl8MfQPK4bEg08
         hdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368468; x=1692973268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp3D2MsYGuIC471tUGfUT4+hNfJGeSTaBW0Z8Ynq+3w=;
        b=NodUheSR0qHWZRiB7mZF7AW21iFvyGW9FJwr+yGzQHMTHGKJiAFbyLFh88K/xjtz3m
         99GfK+aHqc3Q6HSNDZxn/kl1Xt/2v78OgGmpDwijokd5GTo7LOJ3fi/AkKMG5JXajrPL
         aUsSmsgQ16yueZk7vG8G1U6x6CXzENSj/6tBant6Kr2tIf9cgMGtJGP9gFOwoW0S/psS
         X4hfyEbQlYDgoKM1h51zcIFLWnRT97QaUO+cAyhzufbLv/wY655ynJa9xkJief13BB3W
         fy8VpI/9Ff84DZJSMbxgLiCebRy/WmPcGR3SFgid5h2PR3MjJbS5JOCG4qcdtQtm42e/
         O5OA==
X-Gm-Message-State: AOJu0Yw8xmjSVxAGj7WNtr0SLRPglUqXaQN9jha7XE27Vb91m0b/kSNS
	dsVnVNNU10wDhQD9H1jvZo0=
X-Google-Smtp-Source: AGHT+IHsDFhkt0EWA2OyaxJRPixtdEUBEBkAt/c6M+tnaLr+I3E3tprKSlzmlo8wCLfnQABHBFrMEA==
X-Received: by 2002:a05:6402:446:b0:522:4c7a:d5a9 with SMTP id p6-20020a056402044600b005224c7ad5a9mr2634282edw.3.1692368468372;
        Fri, 18 Aug 2023 07:21:08 -0700 (PDT)
Received: from skbuf ([188.25.255.94])
        by smtp.gmail.com with ESMTPSA id p6-20020aa7d306000000b0052574ef0da1sm1109020edq.28.2023.08.18.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:21:08 -0700 (PDT)
Date: Fri, 18 Aug 2023 17:21:05 +0300
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
Message-ID: <20230818142105.kpbdqmm3lckeja5z@skbuf>
References: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf>
 <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf>
 <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf>
 <ZN9tvW6cbnjJo/9M@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9tvW6cbnjJo/9M@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 02:10:21PM +0100, Russell King (Oracle) wrote:
> > > One patch from Linus which changes one of the users of the Realtek
> > > DSA driver to use "rgmii-id" instead of "rgmii". Do we still think
> > > that this a correct change given that we seem to be agreeing that
> > > the only thing that matters on the DSA end of this is that it's
> > > "rgmii" and the delays for the DSA end should be specified using
> >   ~~~~~~~
> >   I'd say not necessarily specifically "rgmii", but rather "rgmii*"
> > 
> > > the [tr]x-internal-delay-ps properties?
> 
> For a CPU link though, where there is no "phy", does specifying anything
> other than "rgmii" make sense? (since there's no "remote" side that
> would take a blind bit of notice of it.)

I'm not completely sure that I understand the question. I think you've
answered this yourself, at the end.

> > As long as it is understood that changing "rgmii" to "rgmii-id" is
> > expected to be inconsequential (placebo) for a fixed-link, I don't have
> > an objection (in principle) to that patch.
> > 
> > Though, to have more confidence in the validity of the change, I'd need
> > the phy-mode of the &gmac0 node from arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
> > and I'm not seeing it.
> 
> Gemini DT source is hard to follow, because despite there being the
> labels, they aren't always used. gmac0 points at
> /soc/ethernet@6000000/ethernet-port@0 and finding that in
> arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts gives us:
> 
> gmac0 specifies a fixed link with:
> 	phy-mode = "rgmii";
> 
> It would be helpful if the labels were used consistently!

+1

> > Looking at its driver (drivers/net/ethernet/cortina/gemini.c), I don't
> > see any handling of RGMII delays, and it accepts any RGMII phy-mode.
> 
> As discussed previously in this thread with Linus, Gemini apparently
> has the capability to add the delays in via the pinctrl layer. In
> this case, in the pinctrl-gmii node, everything has the same skew delay
> so the Gemini end of the link looks like it has no delays.

So it would appear. The skewing capability is there, but the skews for
RXC/TXC and RXD/TXD cancel out in that particular configuration. In that
case, it's pretty confusing why they're there at all, to be honest.

> On the Realtek DSA end, we don't know how it's strapped. RTL8366 (*not*
> RB) has the ability to pinstrap the required delays, and read the
> pinstrapping status out of a register. That register address is used
> for an entirely different purpose by RTL8366RB, so we can't easily
> find out that way.

I see.

> > So, if neither the Ethernet controller nor the RTL8366RB switch are
> > adding RGMII delays, it becomes plausible that there are skews added
> > through PCB traces. In that case, the current phy-mode = "rgmii" would
> > be the correct choice, and changing that would be invalid. Some more
> > documentary work would be needed.
> 
> It could also be that RTL8366RB is pinstrapped to add the delays. If
> RTL8366RB is pinstrapped for delays on both rx and tx, then that would
> be equivalent to a DT description of e.g.:
> 
> 	phy-mode = "rgmii";
> 	rx-internal-delay-ps = <2000>;
> 	tx-internal-delay-ps = <2000>;
> 
> on the DSA end, and:
> 
> 	phy-mode = "rgmii-id";
> 
> on the gmac0 end.
> 
> I believe the DSA end in this case should be "rgmii" because there are
> no delays being added at the CPU side of the connection, and in _this_
> case in gemini-dlink-dir-685.dts, it would be incorrect to change the
> DSA side from "rgmii".
> 
> Whether the delays are added by the switch or by trace routing is
> something we can't answer, thus we can't say whether the CPU end should
> use "rgmii-id" or "rgmii", nor whether the delay-ps properties should
> be added on the DSA side to make a complete "modern" description.

Well, if we can't distinguish between the PCB traces case and the
RTL8366RB pin strapping case, I think it would be best to keep the
strategic ambiguity in the device tree alone.

> > In any case, I wouldn't rush a change to arch/arm/boot/dts/gemini/gemini-dlink-dir-685.dts,
> > and I'm not seeing any dependency between that and your phylink_get_caps
> > conversion for the rtl8366rb.
> 
> If the DSA side is changed from "rgmii" to "rgmii-id" then only doing:
> 
>                 __set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
> 
> means that when phylink_create() is called with
> PHY_INTERFACE_MODE_RGMII_ID due to Linus' change, the phylink_validate()
> in phylink_parse_fixedlink() will continue to fail (as it is today) and
> if that bug ever gets fixed, then rtl8366rb.c will break.
> 
> This negates the whole point of adding phylink_get_caps() for realtek.

Speech can be so imprecise :)

I can see how "I'm not seeing any dependency" can be interpreted as
you've done, i.e. "there is no dependency in either direction between
the 2 patches", but that isn't what I wanted to transmit.

I just wanted to say that you don't need Linus' patch to make progress
with the conversion, that's all.

But of course Linus' device tree patch would only work if your
kernel-side patch puts all 4 RGMII modes in supported_interfaces. But
maybe that should be done anyway, with or without Linus' device tree
patch.

> > > The second patch is my patch adding a phylink_get_caps method for
> > > Realtek drivers - should that allow all "rgmii" interface types,
> > > or do we want to just allow "rgmii" to encourage the use of the
> > > [tr]x-internal-delay-ps properties?
> > 
> > Same opinion as above. As long as it's understood that the RTL8366RB
> > MAC, like any other MAC, shouldn't be acting upon the phy-mode when
> > adding delays, let's just accept all 4 variants, with future support to
> > be added for [rt]x-internal-delay-ps if there turn out to be
> > configurable MAC-side delays present.
> 
> Yes, I think you're right, because we could have the situation where
> the CPU side is adding the delays, and the DSA side is not, which
> should be described in DT as:
> 
> 	phy-mode = "rgmii-id";
> 
> on the DSA side, and e.g.:
> 
> 	phy-mode = "rgmii";
> 	rx-internal-delay-ps = <2000>;
> 	tx-internal-delay-ps = <2000>;
> 
> on the CPU side. Yes?

Yes, this is the situation I was thinking of, where the DSA CPU port
would have "rgmii-id" to denote that the remote side has added the
delays.

At least, that would be the intuitive way for me to describe things
according to our definitions from the documentation.

(open question: if those remote delays are added through pinctrl-gmii
rather than through the MAC OF node, would that count towards DSA's
phy-mode, to make it rgmii-id, or not?)

Though I agree that I can't see the exact phy-mode breaking anything
with a fixed link, given this interpretation, even if it's "wrong".

