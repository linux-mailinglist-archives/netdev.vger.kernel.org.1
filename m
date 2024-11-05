Return-Path: <netdev+bounces-141730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA39BC211
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CACB21815
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98786BA53;
	Tue,  5 Nov 2024 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4V+7reuY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610718622;
	Tue,  5 Nov 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767045; cv=none; b=QKWX+Jl7B34CGrYZWXUB3P2QQl5hF730zu/K+bjSikRSTNu3pXM0hHDed7/hLMwMhBD4Osl0Dn7jF43//1jDz1drYCxfJn6kVFQU6q8m1WBcK1PZOYHCsCfEZokqbMrQqV6+/pa5TVt2KywDrZ19tKV4HJUyPOYJJhYozafJgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767045; c=relaxed/simple;
	bh=pdvc4Wr2Sp+fgK5bx9hyGXDQxDTd8pbwOnlLFYC5LVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6z1saQh8U4b5AtFbPWTwOzxgThIrhGBpTkCoLZQdFLnX/vtpdDPP38V7uUzYfMEcHgu7Vo1zT08Plc0JwgxyNzK7jf369+oSHLrDVVXXcHm97NN4/MNyTyeXjRj+OjEvBKj3h+qHKAMR1OJol2AdwrrmZz/CKwwcMQKsiaGtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4V+7reuY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wsCdaXVxhFLJ/19Yju+KPPKup4KE44LFd4V4VV/rTcM=; b=4V
	+7reuYm4PlQ6QoNHuBv8joZNNODKeI9dEQt9dmTx7aPcSJzM4VqvrM4FAJGsEg0ZkAORbmDbNZGu8
	iWzop4FPDk45DVN8C6NYoHGAs5Wh5DS88n6twCfeae873ifaFkp7tbdT/MtH582+3chN5ME1wmTwp
	Q2qz6E59fJQUBIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t87ZI-00CA8S-WE; Tue, 05 Nov 2024 01:37:13 +0100
Date: Tue, 5 Nov 2024 01:37:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alistair Francis <alistair23@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
Message-ID: <680bd06f-6a76-4a5c-b5d2-51dd172c8428@lunn.ch>
References: <20241104070950.502719-1-alistair.francis@wdc.com>
 <9ae6af15-790a-4d34-901d-55fca0be9fd2@lunn.ch>
 <CAKmqyKOX8gcRT2dSOvJY2o4bpoF+VuPmhaygJj7pTb1KesrFOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOX8gcRT2dSOvJY2o4bpoF+VuPmhaygJj7pTb1KesrFOQ@mail.gmail.com>

On Tue, Nov 05, 2024 at 10:21:15AM +1000, Alistair Francis wrote:
> On Mon, Nov 4, 2024 at 11:49 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Nov 04, 2024 at 05:09:50PM +1000, Alistair Francis wrote:
> > > The static inline functions mdio45_ethtool_gset() and
> > > mdio45_ethtool_ksettings_get() call mdio45_ethtool_gset_npage() and
> > > mdio45_ethtool_ksettings_get_npage() which are both guarded by
> > > CONFIG_MDIO. So let's only expose mdio45_ethtool_gset() and
> > > mdio45_ethtool_ksettings_get() if CONFIG_MDIO is defined.
> >
> > Why? Are you fixing a linker error? A compiler error?
> 
> I'm investigating generating Rust bindings for static inline functions
> (like mdio45_ethtool_gset() for example). But it fails to build when
> there are functions defined in header files that call C functions that
> aren't built due to Kconfig options.

Since this does not appear to be an issue for C, i assume these
functions are not actually used in that configuration. And this is
probably not an issue specific to MDIO. It will probably appear all
over the kernel. Adding lots of #ifdef in header files will probably
not be liked.

Does Rust have the concept of inline functions? If it is never used,
it never gets compiled? Or at least, it gets optimised out before it
gets linked, which i think is your issue here.

	Andrew

