Return-Path: <netdev+bounces-97646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E18CC861
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9B01F22574
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50F146A6A;
	Wed, 22 May 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JzCXvPNT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22014A08E
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415041; cv=none; b=qIGCrMFC/T89efQmKpGgdyJUv4NRwNOMb1z08fZfo4v5nSkXHT4+zITFSHYl9o3finxFf0x1KmQO8DT1kR9cm/LGnoaUzcc1JFQkrzaGj485Hr//xhg1ch8dJ4MuXwUBTxLuyhO/t3vW3cZ9S8PA2PCu6bxg9JEnaAXCYsca05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415041; c=relaxed/simple;
	bh=IVGg+//0CuZCyxFDdjSytZ5p10t8X61X8TYHcu5QxQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9wOdCTUe0aCpMxvU+8ZMaAOUUQWfM3kGPVSxJOnpugjdYXvJUOi1lSVjQCxQb01KJruPfA4vMhftk/CjZrtNwqWut1A4jPEStw3cnMGt2ekTtDLCbLCQHMKayZdrsIu1+zTWK5xWf2oPXHDaijqKBVng5WYmUSUhZTUlVfTbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JzCXvPNT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IkNOeY0n/vyl/rqxG1VAwztMolEM6kJT27JZ25leASk=; b=JzCXvPNTtnvdhtYautDohtF4U0
	26lKwZjVgvov8gZzxdWZdTi9XsMFlhh7q5QPapcwh+wjyFDxiO8WexfKTiZyWIJMHQZUMdMI/mrXp
	JZrm040ZaKtAFNPGaF3f1HLDq4fgkuRRRtIDG5JsD8gmssp3pLJr8Jv35UbaXp8avJzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9txS-00FqYY-98; Wed, 22 May 2024 23:57:14 +0200
Date: Wed, 22 May 2024 23:57:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Glinka <daniel.glinka@avantys.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Message-ID: <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
References: <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>

On Wed, May 22, 2024 at 09:14:06PM +0000, Daniel Glinka wrote:
> Hi,
> 
> I've been trying to get the SERDES ports of a Marvell 88E6320 on a custom board working without success. The SERDES ports are connected to SFPs. On the board I have connected a network interface (eth2) to switch port 2 via RGMII. The DSA switch is configured to forward the packages to port 0 which is connected to an SFP. The forwarding of the DSA switch seems to be fine. I've tested this with forwarding to port 3, which is connected to a RJ45. This works fine. I can also see that the tx_packet counter on port 0 is increased, when running e.g. ping. Therefore it seems that the DSA configuration works correctly.
> 
> The SFPs seem to be initialized correctly as well. The link is reported to be up and I get a link change when disconnecting the cable.
> 
> [  247.782415] sfp sfp0: SM: exit present:up:link_up
> 
> The SERDES connection is configured to 1000BASE-X.

What SFP do you have in the SFP cage? Are you sure it needs 1000BaseX?
Most fibre SFPs do, but if it is copper, it probably wants SGMII.

> The link is reported as down but is directly wired to the SFP which
  reports the link is up.

How do you know the SFP reports the link is up?

> Therefore I forced the link up in the port control register.

You should not need to do this. You need to understand why the switch
thinks it is down.

> We are using the 5.4 kernel and currently have no option to upgrade to a later version.

If you have no option to upgrade to a later version it suggests you
are using a vendor crap tree? If so, you should ask your vendor for
support. Why else use a vendor crap tree?

What is actually stopping you from using a mainline kernel? Ideally
you want to debug the issue using net-next, or maybe 6.9. Once you get
it working and merged to mainline, you can then backport what is
needed to the vendor crap kernel.

So, assuming you can use 6.9...

mv88e6320_ops does not have a .pcs_ops member. So the SERDES is not
getting configured. Taking a quick look at the datasheet, the SERDES
appears to be similar to the 6352 SERDES. However, the 6532 only has a
single SERDES, where as the 6320 has two of them. And they are at a
different address, 0xC and 0xD, where as the 6532 uses 0xF.

You can probably use pcs-6352.c as a template in order to produce
pcs-6320.c. Actually, you might be able to extend it, adding just
6320 specific versions of:

const struct mv88e6xxx_pcs_ops mv88e6352_pcs_ops = {
        .pcs_init = mv88e6352_pcs_init,
        .pcs_teardown = mv88e6352_pcs_teardown,
        .pcs_select = mv88e6352_pcs_select,
};

to the end.

	Andrew

