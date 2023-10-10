Return-Path: <netdev+bounces-39549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFFC7BFBCC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA12281BBE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDC19457;
	Tue, 10 Oct 2023 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CN2CgoPT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72D179AD
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:51:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB2B4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2LEmzyUV0PpFY20pPT4B/PE2E73yL0nEhhSTeAtR9d4=; b=CN2CgoPTXlDsvxLa1vdrubho/Y
	UAW8GcjVx3kMjAcvymf0tk+WppJ9XUn0StghO/i7+87O24RCUwJIvlnme/fcybUZ2i7Kc6UE9NjU/
	rACxt2XIddbdJvmRZW61nXAnPv0t7jB0++WPeAjsbrkofBC1cGZVAIoxl+ozTgHj811E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qqCCb-001EUn-Bm; Tue, 10 Oct 2023 14:51:09 +0200
Date: Tue, 10 Oct 2023 14:51:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Venturi <francesco.venturi1@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org
Subject: Re: Nice to meet you; I'm a Highschool networking teacher
Message-ID: <c16e6bfa-2a3f-4ec0-922f-4fb56f491c50@lunn.ch>
References: <CACvgxrHamYWW2oj8CVETvBd79Vuep9Ra0epFnPF+S2am6Xdeaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgxrHamYWW2oj8CVETvBd79Vuep9Ra0epFnPF+S2am6Xdeaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:26:40AM +0200, Francesco Venturi wrote:
> Nice to meet you, my name is Francesco Venturi and I'd need your help...
> I've had a look at a presentation about ethtool and how to run
> ethernet diagnostics.
> I need to show my students these capabilities, but I need to know what
> hardware to buy.
> Can you please kindly provide me with a list of supported NIC models,
> both PCI and USB (and perhaps chipsets) that support most of this
> functionality up to today, including the "--cable-test" ethtool
> command line option?
> Can you also please point me to a Linux distro having access to a
> version compiled with netlink support and provide me with some
> guidance on how to install it without compiling?
> 
> Thank you very much in advance!
> 
> Francesco Venturi
> 

You need ethtool version v5.10 or later. So for example Debian
Bookworm would provide it, but bullseye is too old. OpenWRT seems to
have 5.16, so that should work as well.

Hardware is much harder. You need something which uses one of the
following Ethernet PHYs

adin, at803x, bcm54140, marvell, micrel, microchip_t1,
nxp-c45-tja11xx.

And not all members of these PHYs actually support cable testing.

The at803 is mostly used in Atheros/Qualcom WiFi access points.
The bcm541040 is mostly used in Broadcom STP with Ethernet switches
The marvell is mostly used with Marvell SOHO switches, some older Marvell SoCs.
The micrel is used in all sorts of embedded systems.
The adin, microchip_t1 and nxp-c45-tja11xx are all automotive.

I've personally never came across a USB dongle using one of these
Ethernet PHYs, but that does not mean one does not exist. I've also
never seen an off the shelf PCIe NIC. All the user cases i've seen are
embedded systems like WiFi access points.

I keep getting emails asking about RPi, but without a datasheet for
the PHY used on those boards, it is not possible to implement it.

Maybe others who have contributed cable test support for these chips
can suggest a commodity device?

	 Andrew

