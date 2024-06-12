Return-Path: <netdev+bounces-102816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2964E904EC3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1021C22398
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EE21649DB;
	Wed, 12 Jun 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mKCmaav+"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A912B89;
	Wed, 12 Jun 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183297; cv=none; b=IBBCiBrRUudVxjKWmK78dqAG/WO3FmCVc6OA3RHKh7fof1KMMPz+FAQSushc+qN+ddEuMGlydkQ0lieJD4RfDEuneqjNgjYcbjF8RpoVDibQ96BleaMTg6dSkBz2GASQ+z4GESygPtP4umw7MnE/BBatqAolLgmFIpbachuCm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183297; c=relaxed/simple;
	bh=oGz+2MKh1s8xC7PcDyuwrGEgelZKhmmNpiMHi4axiow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXMv1o3gWRtN/iwdzWBxFaOIYvo5n0y59yCP6NTWpMQyHhFtvFXNrKccdm02gR8eKYGeqCRMSLd0bCC81QJL4svsyPBX5uMQwcP1xH4820tF8KMGdHIRSdEus/KBCYddo9WMCJWPiaQTuhGqp8STtuy0+evaBIwcZLd7ue//aMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mKCmaav+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BDE9E0007;
	Wed, 12 Jun 2024 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718183287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGz+2MKh1s8xC7PcDyuwrGEgelZKhmmNpiMHi4axiow=;
	b=mKCmaav+NzUX3Ds7NJOqrM3/k491Gi4CJSjDmpqcJsd3QU0xpAAFlOY55Gn+jePpFMZIlO
	KiaaMCguFtk0ANk8c4f45Fm6R7YZgo5ojpjZmvYxpLK9AP8SJQKgX9Wh3v0dAT85FYacyZ
	NEB+p4AkWAX70qBBZ8uwBHqXUIkfJoZp4ydK4bq8NtOmTxowCFNYiIba6UrIjmhPuGAqxb
	doTFjG0CZ+i9Db9sObD+MA4Sx7XR0XN0wh9aV/nUfiwD0y28mVF+KSZ+Q31RwjUyPQpW3S
	jUJnd63byHZxuZk7WOWkGifHxdY8NymiG+JHPGm134/Z51t/Cqa6txtFwC/xwg==
Date: Wed, 12 Jun 2024 11:08:05 +0200
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
Message-ID: <20240612110805.04b4f553@kmaincent-XPS-13-7390>
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
>=20
> Here is my proposal aligned with IEEE 802.3-2022 33.2.4.4:

FYI: It seems your are using an old user guide for the PD692x0 communication
protocol. The one I have is based on the last firmware version 3.55.
So don't be surprised if the next series version will have few differences =
with
your proposal.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

