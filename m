Return-Path: <netdev+bounces-220829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5BB48F9B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D11C22549
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59430AD1B;
	Mon,  8 Sep 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Poevc3iP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2078C9C;
	Mon,  8 Sep 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338245; cv=none; b=RQUmdMmgoemBLInjwIOuVe56+saBviKWjbUVl3AbPIeulJEBjDH2JzdvXeOci9pG7sE79XDu9THa0pwfJrPC5OgmrB/KHJk8Mm1AVk0GPdhuD2cTr04VFbXr2S4gQuveOAO1iPbPxXZ3cqXivroYwbP2BBZYwayNjfcUHMpf+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338245; c=relaxed/simple;
	bh=jAoRY9oBXknPAv64ifCBBFZsnXaBOzEeH4zKxNIIgJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgyStaYB/OAnP/tL0dJ1AoJ0jFdAbCMEIEuHey6fhMGWJXY1O/h2yyam6nlnURcW/2JMDaN/vuP8rxQDnzGT/CzKQjl9GRli6KoabYUB4ok3rv4p4i8j//jx2hu12DQLpIXgMNdMUAXA7kzY5Ctp1AR6S68O2+uV4TL6hyDWS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Poevc3iP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3KV0uQSnd9LarnkrFzJ3vNCBlsKS0olvvD1E3EQqAcI=; b=Poevc3iPRvQGkxpBjWfGw01Ud8
	hWEjmsYe/ur1vxYq7IVMb+k1dKfSi6JuTratQKMAy7ZKbTOvfnVhp5T4sJnw5XXSOtukTjlRK3bfB
	zv8DUcS1Q3E7bd+3JyHb+NucRPV6pPhS3OiRi2Wz0ty3cXQGGEpA3JNA7xevTt86UYbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvbx3-007fzr-Fd; Mon, 08 Sep 2025 15:30:33 +0200
Date: Mon, 8 Sep 2025 15:30:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <e17b65d2-5c66-4d80-84c2-26f2bc639962@lunn.ch>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
 <20250905181728.3169479-4-mmyangfl@gmail.com>
 <4ef60411-a3f8-4bb6-b1d9-ab61576f0baf@lunn.ch>
 <CAAXyoMMEUeqxJaAYb8fbeACp7N=hFOQrPbtk4LDJM4CZw7n6mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMMEUeqxJaAYb8fbeACp7N=hFOQrPbtk4LDJM4CZw7n6mA@mail.gmail.com>

> > The DSA framework makes no such guarantees. The DSA framework is also
> > not the only entry point into the driver, phylink will directly call
> > into the driver, and if you implement things like LEDs, they will have
> > direct access to the driver.
> >
> > So i suggest only having a high level lock, acquired on entry,
> > released on exit, e.g. as mv88e6xxx does. KISS.

> So you mean holding bus->mdio_lock during any operations instead of
> implementing driver's own lock? Wouldn't other bus participants starve
> if I want to poll a register for like 100ms?

No, leave the mdio lock alone.

The mv88e6xxx driver has a lock in the 'priv' structure:

https://elixir.bootlin.com/linux/v6.16.5/source/drivers/net/dsa/mv88e6xxx/chip.h#L354

Function which are exposed in dsa_switch_ops take the lock at the
beginning, and release it at the end:

static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
				  const struct switchdev_obj_port_mdb *mdb,
				  struct dsa_db db)
{
	struct mv88e6xxx_chip *chip = ds->priv;
	int err;

	mv88e6xxx_reg_lock(chip);
	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
	if (err)
		goto out;

	if (!mv88e6xxx_port_db_find(chip, mdb->addr, mdb->vid))
		err = -ENOSPC;

out:
	mv88e6xxx_reg_unlock(chip);

	return err;
}

There are functions which wait for the device, polling:

https://elixir.bootlin.com/linux/v6.16.5/source/drivers/net/dsa/mv88e6xxx/chip.c#L87

and we do this while holding the lock. We have a timeout of 50ms, but
it never takes that long, on average it is just a couple of MDIO bus
transactions.

	Andrew

