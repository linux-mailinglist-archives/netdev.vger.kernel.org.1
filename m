Return-Path: <netdev+bounces-101301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7C8FE147
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141D21F24396
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2513C821;
	Thu,  6 Jun 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f9BkKMe0"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAE19D89A;
	Thu,  6 Jun 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663301; cv=none; b=KTjkc2hJqxR1Zz8wwRwTcruTfbfmLRijIBfyzV8nvlEd/FTPHh/Ka3XfyvNcO80Ti76O5D8Xk/+oeSqT/jmmZHMGYMgUos9CTV4gb3ld3sKmoGqPe0+KU6Q/QvzjfoRtmH5aRNbnKATrFSPgRhJVf9cs/J5+tsAlEMX1NUPpHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663301; c=relaxed/simple;
	bh=EoyaGw1A4h+VCG9rJx8NmSKJzlh6fEw3DCXv7QkXl2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvYJUp6Z+YnIoHVtsITe3Vf/TiGPN7yllqzwRdB5Xx6M19RSyYJnhJ7ZHaxho4zjXiLLXuzJ+wKS3WyR0lNV23SdALaw+ztk8ORC8mahObm/eUHhkjtO2YHKP7LrxeDGeYsnEFUzlvbbrH3RdcTBzJBd+WOQ+MPlz6uUNOnamiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9BkKMe0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEBCBC0002;
	Thu,  6 Jun 2024 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717663291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMtvqFFLEqL2SjbNwyELJMYS5t5iIw2nNf41UsERVgM=;
	b=f9BkKMe0PdFR6PJ5U/70w1adfe0YuIzB0MeSC1RxKfJu9RbReWEeeK+mD7zHCILpSYGrfJ
	tAPdtU4NWgRZH1iF1vbZtfrhrOqVNag0PPReZxAWuZF37fZKQH7KupxwK3kZOMwFk7ieik
	n4izgVeKiZ/O66riUbr0IF2SVrmjXPZmzkdFmanIvhADdoz+BIAeuSbfIAKb+2OPL+40xI
	OEqUcNWp/Yh6F+U4QAO4KKz2RW5arwvpJssbHTppWZvc4wyRoOSFuhEqPjaEb3EaIE6vfw
	nhr50aTz4WbQ3b3fZmodZjT6ScoNE4DURregM4fgqeXg8KU5o5k63zC7vNnLdA==
Date: Thu, 6 Jun 2024 10:41:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v12 10/13] net: ethtool: pse-pd: Target the
 command to the requested PHY
Message-ID: <20240606104125.4ece706a@kmaincent-XPS-13-7390>
In-Reply-To: <20240605124920.720690-11-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
	<20240605124920.720690-11-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed,  5 Jun 2024 14:49:15 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> PSE and PD configuration is a PHY-specific command. Instead of targeting
> the command towards dev->phydev, use the request to pick the targeted
> PHY device.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

