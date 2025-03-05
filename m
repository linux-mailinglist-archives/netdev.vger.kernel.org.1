Return-Path: <netdev+bounces-172170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA45A50762
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B0318935C4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157AE24C07D;
	Wed,  5 Mar 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q9Q9oB5z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F0250C1D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197435; cv=none; b=p8TurPHFUGmO6LNNzBVi17Y7o0e74xeJBe+0bIpko4wn79gU9lX/NgT8RE2xcrY7d3y8JXCrhOAYLdzpOdjYIjhs8BylX4kwBjAc+yOPag88wwNrpVh7yJERcAkFqj59OCpUVvOAH9hiZNxDxA5Jy6EKZp4U9E3MMiJnwannlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197435; c=relaxed/simple;
	bh=tQI8Iaa53ZjRVGy8Lb1Cc41I9xa31OxUOdo+Cv/ovOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgpHsQuu69hNjX54npkWtwA0IH4ltgqyv9JtswVwDZM9SLF6DxN37UYPib+k9hN4+e/3a7LYaFFKubUVFRopaXqrNno/IyjSVKxw7ZM5KzgrfR8EvZ6UbT6NBQMlgTgav7fOHTTXDvelt2ohlaGW6SLlHIuPwusdCltFZ6q+it8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q9Q9oB5z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oXYYK6psKGQovX90rdKMWsTaGIrXwVz2qfLGwrnkFwg=; b=q9Q9oB5zm+ZTC7EjbxiD8Ly15h
	NHoDOSuig1Uo8uB+7w1iVcwXs1C7WHPFyk0Ve823uTCjTlD2Dr5JCjKBqNn8Pe1Fpo0OmnkKh6yOm
	8TvOUhebdAaMoCdc0MtkYbnGOjZ3XPhKZdawFdumTXWGPgti0/H/iHqBdUx/gPRGR30k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpszV-002YKS-Pj; Wed, 05 Mar 2025 18:57:09 +0100
Date: Wed, 5 Mar 2025 18:57:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: max.schulze@online.de, hfdevel@gmx.net, netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
Message-ID: <621e6614-d2a8-4f7a-be53-9f24b1768040@lunn.ch>
References: <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
 <b2296450-74bb-4812-ac1a-6939ef869741@online.de>
 <9aede328-4050-4505-83a5-c0eeb67d1fc5@lunn.ch>
 <20250305.084858.1138848711250818607.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305.084858.1138848711250818607.fujita.tomonori@gmail.com>

> > From my reading of the PHY datasheet, it can do 1000Base-KX, but there
> > is no mention of 100BaseSX. There is also limited access to the i2c
> > eeprom in the SFP, so ethtool -m could be implemented.
> 
> Yeah, I have not yet found a way to implement the ethtool operation
> that accesses the SFP and returns the appropriate information.

There are two different ways you can report the i2c EEPROM
information:

struct phy_driver has:

        /**
         * @module_info: Get the size and type of the eeprom contained
         * within a plug-in module
         */
        int (*module_info)(struct phy_device *dev,
                           struct ethtool_modinfo *modinfo);

        /**
         * @module_eeprom: Get the eeprom information from the plug-in
         * module
         */
        int (*module_eeprom)(struct phy_device *dev,
                             struct ethtool_eeprom *ee, u8 *data);

I don't think any PHY driver actually implement these. I've been
intending to remove them for a couple of years, but have been too
lazy. I would actually say this is a dead end and you should not do
this.

What i think you should do is fake an I2C bus. This is how all other
boards work, they have a Linux i2c bus device, and phylink knows how
to use it to retrieve the EEPROM contents and export it in the
standard way. You are going to need phylink involved anyway to manage
the SFP cage, determine the link modes, tell the MAC driver what to
do. The PHY driver then needs a sfp_upstream_ops which it registers
with phy_sfp_probe(). See marvell10g.c for an example.

	Andrew


