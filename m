Return-Path: <netdev+bounces-35060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9835D7A6BB7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920B61C20A27
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE6341AC;
	Tue, 19 Sep 2023 19:44:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A121CF92
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:44:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09998F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AVccxiPXjM4X7f0iRjBoZz+mwyvLijpX0XdWl2CX9VA=; b=hs
	aQ7+a8Qg2MxQUhadOOjEJfxtQzIeElbeVvhH9O5F6oDhiYhbD1DZxZPQb7xDpqpr4djKI+DfJf6S5
	RUv27weq9ezTG2dFQrCC0Idq51BvD/G9CgGwI3uve7XzXw0KgStXTrkDvh/zA4WF7YWM830DxfU/f
	tsKKN4YR+bmcQJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qigdy-006wWA-Pe; Tue, 19 Sep 2023 21:44:22 +0200
Date: Tue, 19 Sep 2023 21:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch>
References: <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
 <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
 <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
 <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
 <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 04:23:01PM -0300, Fabio Estevam wrote:
> Hi Andrew,
> 
> On Fri, Sep 15, 2023 at 3:23 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > The problem with this is that the way to read the contests of the
> > EEPROM depend on the switch family.
> >
> > linux/drivers/net/dsa/mv88e6xxx$ grep \.get_eeprom chip.c
> >         .get_eeprom = mv88e6xxx_g2_get_eeprom8,
> >         .get_eeprom = mv88e6xxx_g2_get_eeprom16,
> 
> Indeed, there are two methods for reading the EEPROM.
> 
> > And how do you know the EEPROM does not in fact contain 0xffff?
> 
> The functional spec doc says:
> 
> "If the just read in Command is all one’s, terminate the serial EEPROM
> reading process, go to 8."

So reading 0xffff means we have reached the end of the contents, not
that it actually exists.

> > What i found interesting in the datasheet for the 6352:
> >
> >      The EEInt indicates the processing of the EEPROM contents is
> >      complete and the I/O registers are now available for CPU
> >      access. A CPU can use this interrupt to know it is OK to start
> >      accessing the device’s registers. The EEInt will assert the
> >      device’s INT pin even if not EEPROM is attached unless the EEPROM
> >      changes the contents of the EEIntMast register (Global 1, offset
> >      0x04) or if the Test SW_MODE has been configured (see 8888E6352,
> >      88E6240, 88E6176, and 88E6172 Functional Specification Datasheet,
> >      Part 1 of 3: Overview, Pinout, Applications, Mechanical and
> >      Electrical Specifications for details).  The StatsDone, VTUDone
> >      and ATUDone interrupts de-assert after the Switch Globa
> >
> > So i would expect that EEInt is set when there is no EEPROM.
> >
> > What strapping do you have for SW_MODE? Is the switch actually in
> > standalone mode?
> 
> Pardon my ignorance, but I don't know the answer to these.
> 
> I do have access to the schematics. How can I tell?

Good question. The datasheets i have don't actually say!

I'm assuming there are two pins which can be strapped to give the
value of SW_MODE, and a value of 2 indicates standalone. But i've no
idea which pins they are.

     Andrew

