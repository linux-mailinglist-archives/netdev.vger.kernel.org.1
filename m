Return-Path: <netdev+bounces-247493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF6CFB44D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 23:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7960D3048BB7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA8231C9F;
	Tue,  6 Jan 2026 22:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351691D5141;
	Tue,  6 Jan 2026 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738986; cv=none; b=rKkdYy6rSo5BmI+jejUD0Ar6WtWE9kSA4YoOFf0bqZhdhXgSK1Gp4UzHZjnfRnH89nbfeZjqnHNdFWfktqP3FMgSF+fQS75rGDXLeRvcb1Q4El3SR5SoCkgIb+64JxpBsmwvV4EAicf7CtKzdFQ4xNRclT6Cs3n1fkReFZ5hm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738986; c=relaxed/simple;
	bh=qsmAbwbOihyhUekwomrrbABdRnpkI8wXIYpb1kzmsDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeUIqTa9s/C4RVLNUJAr6gEnvB8z1BZ80jbgbkmuAUDIbhDubroRxHyfnqhYC5UW2niblgJe9JIOv/54pxOXum+sAWh6IvVIEJMYwZSA/UObsZxKSROaSfr745SRcq2d/evMUQyZguHMSI4bh/fG6jaiW6elJcmAXnawkaVEIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vdFev-000000000PJ-3vrN;
	Tue, 06 Jan 2026 22:36:14 +0000
Date: Tue, 6 Jan 2026 22:36:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v4 3/4] net: mdio: add unlocked mdiodev C45
 bus accessors
Message-ID: <aV2OWT4g0jwfS548@makrotopia.org>
References: <cover.1767718090.git.daniel@makrotopia.org>
 <36fbca0aaa0ca86450c565190931d987931ab958.1767718090.git.daniel@makrotopia.org>
 <aV1MGQirTHyFdv7Q@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV1MGQirTHyFdv7Q@shell.armlinux.org.uk>

On Tue, Jan 06, 2026 at 05:53:29PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 06, 2026 at 05:14:57PM +0000, Daniel Golle wrote:
> > +static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
> > +				      u16 regnum, u16 val)
> > +{
> > +	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
> > +				 val);
> 
> Something doesn't look right here - missing a couple of spaces to
> correctly align? I suspect checkpatch would spot it?

Somehow those two spaces got dropped somewhere on the way. Strangely
neither checkpatch.pl locally nor on patchwork[1] caught that -- maybe
because 'return' statements are somehow treated differently?

Anyway, fixed in my local tree now and going to be fixed in v5.

Are you otherwise fine with adding those unlocked mdiodev c45 helpers?


[1]: https://patchwork.kernel.org/project/netdevbpf/patch/36fbca0aaa0ca86450c565190931d987931ab958.1767718090.git.daniel@makrotopia.org/

