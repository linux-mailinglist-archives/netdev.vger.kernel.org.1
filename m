Return-Path: <netdev+bounces-102571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB934903B4F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 14:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CA11C2385F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06626176237;
	Tue, 11 Jun 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjrT0zA6"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F114F9E4;
	Tue, 11 Jun 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107286; cv=none; b=gYP/MEXwLKuGzBOj4nDIC8hbeBX7Pm3zGjUouzjAgjmAKHiG+QpX5EViZmKGU28Lsms1NYb9hUdAKmpwV/vXwdvfmMvobA8MRxbP4JbXjPUJa6vkXn1s4czYWhlPB9GuPhcYX70jD+L/bb2EZ8cMa5K0o0uZ3yXArsWahF8QKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107286; c=relaxed/simple;
	bh=Zix90JJZPkY0LLrFX9F0TYZzTEx6XBUzy2tS9s+6vZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDObJLpx3BN/i5B5ePXoZS5oDPs7Buu72PyNQtivz+E7vHqTEU/7GHnIcRkzCPjTxpfNvFxFccS2AenfyZT20h8qcJQe2eUfUf88AQoLNMPvaCqBFejJzRSw5VEnO608cfhX7kbXCHrAyYL2rq3UtvX0xNRjaprnFv7S/i/PkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjrT0zA6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F24A41C0005;
	Tue, 11 Jun 2024 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718107276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zix90JJZPkY0LLrFX9F0TYZzTEx6XBUzy2tS9s+6vZo=;
	b=OjrT0zA6QibB5CusNH85occjMBlrP6MQKaCMNyIoKNt05KrYw2oRXDKkXX7nlW3/H97wm/
	8tWXFFiTzcjy4LL8I5HJCP80rBkyYlDOYHIZI+/9/58+MNDrxosShqzMx7fRBwiiXXUreb
	zhj0eowSnq1BJY4lpZDTendl8jk5r3D/flE6RBDYRy0Sj6qstnxVGCWbdR8oJlJdWEp5dm
	ZyQiYocC5cLciRPgyWaB7R2D2XeaNlkq0ftCY7b0grhixvojDBn77hSZHJ/qMW3fbdTGP7
	ckZwfe0vKBOvL3yQMTz81rdIedkCpoy+9ocjynct4iyNvUrGSRVM4qhnGmSV+g==
Date: Tue, 11 Jun 2024 14:01:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <20240611140115.4e857e46@kmaincent-XPS-13-7390>
In-Reply-To: <ZmgFLlWscicJmnxX@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
 <20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
 <ZmaMGWMOvILHy8Iu@pengutronix.de>
 <20240610112559.57806b8c@kmaincent-XPS-13-7390>
 <ZmgFLlWscicJmnxX@pengutronix.de>
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

On Tue, 11 Jun 2024 10:05:02 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Mon, Jun 10, 2024 at 11:25:59AM +0200, Kory Maincent wrote:
=20
> > The enum errors I wrote is a bit subjective and are taken from the PD69=
2x0
> > port status list. Go ahead to purpose any change, I have tried to make
> > categories that make sense but I might have made wrong choice. =20
>=20
> Here is my proposal aligned with IEEE 802.3-2022 33.2.4.4:

Hello Oleksij,

Wow! You fully rewrite the netlink UAPI.
Thanks, this is more standard complaint than my proposal!
I will remove the PD692x0 specific description and update my patch series
accordingly.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

