Return-Path: <netdev+bounces-34075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB67A1F82
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449AB282A4E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74C10952;
	Fri, 15 Sep 2023 13:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB1101EB
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:08:37 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F21713
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zVjwPM45IGEkiY7NbUCpkjVMxV4lpxHCQIo62c7Hia0=; b=qs
	gW5y9m3yC+Gs+zrvfNKsogWFR3/MLhTDirarUqYl3Qu2RhTjVtuykfAyX23RvnhJ4RQbb72REmFNF
	K0LrOg8ay+TtbRrwSg3tgKVHRNhoWmLa75vIYTvmYHMe9iqkp3LwMFrHTFEEz2CS/b+bauKxzIsgH
	CQtMFjm3HtFnLpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh8Yj-006XjN-DS; Fri, 15 Sep 2023 15:08:33 +0200
Date: Fri, 15 Sep 2023 15:08:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
 <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
 <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 09:40:05PM -0300, Fabio Estevam wrote:
> Hi Andrew,
> 
> On Thu, Sep 14, 2023 at 6:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Unfortunately, none of my boards appear to have the reset pin wired to
> > a GPIO.
> >
> > The 6352 data sheet documents the reset pin is active low. So i can
> > understand using GPIO_ACTIVE_LOW.
> 
> What does the datasheet say about the minimal duration for the reset
> pin being asserted?

It is a bit ambiguous. RESETn is both an input and an output. It says
this about input for the For the 6352:

     As in input, when RESETn is driven low by an external device,
     this device will then driver RESETn low as an output for 8 to
     14ms (10ms typically). In this mode RESETn can be used to
     debounce a hardware reset switch.

So i would say it needs to be low long enough not to be a glitch, but
can be short.

> > In probe, we want to ensure the switch is taken out of reset, if the
> > bootloader etc has left it in reset. We don't actually perform a reset
> > here. That is done later. So we want the pin to have a high value. I
> 
> My concern is that the implemented method to bring the reset pin out
> of reset may violate the datasheet by not waiting the required amount
> of time.
> 
> Someone who has access to the datasheet may confirm, please.
> 
> > know gpiod_set_value() takes into account if the DT node has
> > GPIO_ACTIVE_LOW. So setting a value of 0 disables it, which means it
> > goes high. This is what we want. But the intention of the code is that
> > the actual devm_gpiod_get_optional() should set the GPIO to output a
> > high. But does devm_gpiod_get_optional() do the same mapping as
> > gpiod_set_value()? gpiod_direction_output() documents says:
> 
> Yes, this is my understanding.
> 
> >  * Set the direction of the passed GPIO to output, such as gpiod_set_value() can
> >  * be called safely on it. The initial value of the output must be specified
> >  * as the logical value of the GPIO, i.e. taking its ACTIVE_LOW status into
> >  * account.
> >
> > I don't know how to interpret this.
> >
> > Is the first change on its own sufficient to make it work? As i said,
> 
> No, it is not. On my tests, I needed to force the reset GPIO to be low
> for a certain duration,

Is you device held in reset before the driver loads? As i said, the
aim of this code is not to actually reset the switch, but to ensure it
is taken out of reset if it was being held in reset. And if it was
being held in reset, i would expect that to be for a long time, at
least the current Linux boot time.

   Andrew

