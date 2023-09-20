Return-Path: <netdev+bounces-35276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA407A8798
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3199D282122
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57333B2A3;
	Wed, 20 Sep 2023 14:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CC1428E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:53:08 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1448CE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=UXcpfOxOQVMCugajegj4u1gND0cEAYn4ymHq9f7WI3c=; b=wW
	rAHXPP3hcor3pbz2XRH5gVeu4wWJfvU8RkkVrQQmx+hmexpn5/uhPcmD3/7ZkZw9J2DcUDWFgdmVm
	b5qUUYlOMsqmoPCf8NULwZKQsStlS7R3dh97+19JTyA/z1HOrgnFMEFQ7mpraQmTzKSVYoG1Ge9eS
	E/bpfVcY0SliUqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiyZW-00719k-4o; Wed, 20 Sep 2023 16:52:58 +0200
Date: Wed, 20 Sep 2023 16:52:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <bcc0f229-fbf9-42f4-9128-63b9f61980ae@lunn.ch>
References: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
 <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
 <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
 <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
 <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
 <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch>
 <CAOMZO5BV3MucdxhEXhLy+XTo7yh5vGDHuA1r82B8vdrexo+N6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BV3MucdxhEXhLy+XTo7yh5vGDHuA1r82B8vdrexo+N6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 09:47:24PM -0300, Fabio Estevam wrote:
> On Tue, Sep 19, 2023 at 4:44 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Good question. The datasheets i have don't actually say!
> >
> > I'm assuming there are two pins which can be strapped to give the
> > value of SW_MODE, and a value of 2 indicates standalone. But i've no
> > idea which pins they are.
> 
> What is the register I need to dump in the mv88e6xxx driver to check
> the value of SW_MODE?

This sort of thing, strapping, tends to appear in the scratch
registers. However, i cannot find any documentation about it. So i
have no idea where it is.

We probably need to go a different direction. Lets see if i understand
the issues correctly:

If there is an EEPROM, and the EEPROM contains a lot of data, it could
be that when we perform a hardware reset towards the end of probe, it
interrupts an I2C bus transaction, leaving the I2C bus in a bad state,
and future reads of the EEPROM do not work.

The work around for this was to poll the EEInt status and wait for it
to go true before performing the hardware reset.

However, we have discovered that for some boards which do not have an
EEPROM, EEInt never indicates complete. As a result,
mv88e6xxx_g1_wait_eeprom_done() spins for a second and then prints a
warning.

We probably need a different solution than calling
mv88e6xxx_g1_wait_eeprom_done(). The datasheet for 6352 documents the
EEPROM Command register:

bit 15 is:

  EEPROM Unit Busy. This bit must be set to a one to start an EEPROM
  operation (see EEOp below). Only one EEPROM operation can be
  executing at one time so this bit must be zero before setting it to
  a one.  When the requested EEPROM operation completes this bit will
  automatically be cleared to a zero. The transition of this bit from
  a one to a zero can be used to generate an interrupt (the EEInt in
  Global 1, offset 0x00).

and more interesting is bit 11:

  Register Loader Running. This bit is set to one whenever the
  register loader is busy executing instructions contained in the
  EEPROM.

We have the helper mv88e6xxx_g2_eeprom_wait() which polls both bit 15
and bit 11. Maybe we should use this instead of
mv88e6xxx_g1_wait_eeprom_done()?

	Andrew

