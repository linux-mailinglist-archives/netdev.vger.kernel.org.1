Return-Path: <netdev+bounces-128713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA297B26B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2101F26C29
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646116087B;
	Tue, 17 Sep 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LhfZjrW0"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41100535DC;
	Tue, 17 Sep 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588441; cv=none; b=Jspef/DDOaWyB1cF7kPDOmpK7UR8ByUuAUxB3pSYcJe3GzLMJ7AxPO43c2bCVzNApwruwKPi4y/w5AOsJYr/6ueadFTLWOms6ACJKg+W1KnnqrMZV5wcbtc3Q4xA+NVdVmE1hxnOVRaf0Q4W7t9e0InDvJUl5yjBVLu8iE67wo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588441; c=relaxed/simple;
	bh=uhkLZUSOLUZBz7idZogLg/DtfL6K0Zm3Tmj3xebr5MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuiavwvKq0M0LT0VR0MHQWgkfkV+EGsrFVyr2HCiUpt6F2iyU75yK7rbGrSiyy3Q6OhHHQF9a4Kox2TUH7PsdgWtPVU5U9lndgSz1kJeEuJaqC46r4pBpcIZ0A9BiqQmvIoExJ2YWWkcl2bmJp4NvQaXhYPMBXY54/4/uKDIXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LhfZjrW0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73D7960003;
	Tue, 17 Sep 2024 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726588436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhkLZUSOLUZBz7idZogLg/DtfL6K0Zm3Tmj3xebr5MQ=;
	b=LhfZjrW0DxZ3THj4hDMF5sfVmHbnyidqSx0ZtgKlwonI88NvIEkQ2et3LU04onUzk2A/ML
	RY6p9wtBmeeXKeu9kf2g16Y4yHI6QGcgFO2oiuu6wZNUaqj0aZpkQ6y72mCrs0ZX/cUD/S
	qQtI81Ngfk+z+IHtHFPUxN4akXrIrd6UzLJw3Rqwnw1Fx88pib+ET6I7S0K5P43oqh+sY1
	OSVqawWOA50sH9NNnA7tMBmqcYo+sEOwCQQ8vUTxC9aLfWnBEpOHHTOvO0wibhuRH7ODIi
	Ui5RR8ruwfgKXcvfuUs9GyhHJ6mte7u7rV6vY6C7oIBNxedpBJK1zeRC1/tl1w==
Date: Tue, 17 Sep 2024 17:53:47 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Heiner Kallweit
 <hkallweit1@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>, Edward
 Cree <ecree.xilinx@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <20240917175347.5ad207da@fedora>
In-Reply-To: <ZuhsQxHA+SJFPa5S@shell.armlinux.org.uk>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
	<ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
	<ZuhsQxHA+SJFPa5S@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 16 Sep 2024 18:34:59 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

[...]

> The best place to decide to notify userspace would be at the
> module_start() callback - this happens when a module is present,
> and the netdev has been brought up. Note that this call will happen
> each and every time the netdev is brought up.

As we are brainstorming, may I suggest an alternative approach ?

I'm currently working on getting some way of providing userspace with a
representation of the front-facing ports of a netdev. This would
include SFP module ports, RJ45/8P8C/BaseT ports, BaseT1 ports, you name
it.

This would allow to represent with a bit more clarity use-cases such as
the MCBin's ports controlled by the 88x3310, the combo RJ45 / SFP ports.

The other case would be devices which have several PHYs in parallel.

The way I see it for now, is that we would have internal kernel objects
with a name such as "phy_port" or "phy_mdi" or just "mdi" (I'm bad at
naming), instanciated by PHY drivers (or phylib through generic helpers
in most simple case for single-port PHYs), as well as the SFP
subsystem, but also by NICs that have a front-facing port that's driven
neither through SFPs nor PHYs (through a firmware of some sort).

These phy_port would have a set of callback ops to get their
ethtool_ksettings linkmodes and could be added/removed dynamically, in
the case of SFP module insertion for example.

The notification I would imagine would be "there's a change on the
front-facing port" or "there's a new one, here's what it can do" in the
case of module insertion.

I already have some code for that, and I will talk about this exact
topic tomorrow morning at the networking track of LPC [1]

For the SFP case, the notification would trigger indeed at the
module_start/module_remove step.

All of that is still WIP, but I think it would reply to that exact need
of "notifying users when something happens to the ports", including SFP
module insertion.

I plan to submit an RFC shortly after LPC, I still need to iron some
things out, and I think that RFC will itself trigger a lot of
discussions, but do you see that this kind of work could help resolving
the issue faced by Daniel as well as the need for SFP-event
notifications ?

Thanks,

Maxime

[1] : https://lpc.events/event/18/contributions/1964/

