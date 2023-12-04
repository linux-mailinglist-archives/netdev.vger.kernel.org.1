Return-Path: <netdev+bounces-53456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3F803079
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763441C20A1C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6282209F;
	Mon,  4 Dec 2023 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W7kWzqHS"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AD85;
	Mon,  4 Dec 2023 02:36:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E015C0013;
	Mon,  4 Dec 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701686203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWRVj9OK7hUSxLhwt1pyFNkS3HCNWPbhWMWb3LBA5hs=;
	b=W7kWzqHSMSWJb0Qf6yauIHA0xVfz+H18EZ0p9R7jr5nv/fv4h1MFVAU3Xap32qufOa56JK
	ptnLBMt5ntBQzN7FvrIdQSzwzBPbrRgBBdM/vdfo+YLUBVrcbtY6pjkItMjtHk5GaDj2oY
	6HhuDo+RqfQEQ32Y1HQ6Qq2Cww14FFbYUMaadq4GU0dm4hoGnJlEoLMi5wpIUknTCNPNAV
	rDW7WHPMK056ejsMd45n+DaLFT0Q8wrExnIWRaLs29TyHRRhzrAkERiSgemWpOlzSCbVPE
	fd+K/g3Vef4FJG7R+7axwHsi83MdVvxYb86C1K1s56EGbuTc1jKlVTmckXG4xw==
Date: Mon, 4 Dec 2023 11:36:40 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 06/13] netlink: specs: add phy-index as
 a header parameter
Message-ID: <20231204113640.508ac88b@device.home>
In-Reply-To: <20231201163704.1306431-7-maxime.chevallier@bootlin.com>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
	<20231201163704.1306431-7-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Fri,  1 Dec 2023 17:36:56 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Update the spec to take the newly introduced phy-index as a generic
> request parameter, and bump the generated ethtool-user.c|h accordingly.

Just saw
https://lore.kernel.org/netdev/20231202211759.343719-1-kuba@kernel.org/

I'll drop the ethtool-user stuff from next versions then, sorry for the
noise

Maxime

