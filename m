Return-Path: <netdev+bounces-99061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCF8D38E2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE728B8C3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5E137933;
	Wed, 29 May 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fsdLGG8s"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5745137924;
	Wed, 29 May 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991995; cv=none; b=F51zK8k71FKsnuoEwkKb2S8sbCrGLuEJKkuFG8/bHp2A4YRRBCoTuWVCf8dClperSBREZai+VPH7vf6J8ZuQ5m9SaE3/W9eSXYoMvP/OCunTm6vw28PXXg+dnglHn7U4pjJ7vOOZXXYt6/LLMH8uTvIh1s3AXItTKXt8mhp1tQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991995; c=relaxed/simple;
	bh=XFD0kX0f1kuC0dkSlKIosyZm8FsxaqyVUaGzp2oMDZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLTjZH9aVZN5I41XBfW+mBqXdpB1XEZ35EI2pFTgt8A82/TN5mRKPdBbJhiN1rKKg/DqRaFsIl6iPNUcP0PzO6XSaPxA5Hunpq1dYE+Asi8KXfKaGGnsS0uQyuYHCI6oFu/YTuOW2/djm5FHjV7a6shczmalUW0R0tOg7iINDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fsdLGG8s; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59B0E1C0002;
	Wed, 29 May 2024 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716991990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCBuiE35HNaYO17qDDOpD9SCW+y3st+WxL3OV7dTPi4=;
	b=fsdLGG8sD3FSyjgFjgeq9M9XiZbHxrwXOWbXdmYTX2/oHpqWcpNQ/mM8DvbW8pxY9vm4Hn
	tIJ3CLKxibIRqWZZaijcUGWwSn3Gv4MQDFOWQ8hI3aXEDIJ3XgGegRmtWfMVPXqcSndOg5
	EqsKwSUgoWbmobhgG0nuchJXmLFHumcaW5rLH0p/J3kbXvIZVWa8tI4esOfAETux/j35fl
	+5nffYV4kO+XC+AJanU6Z4MubdKZNwl+uQmlBP/hLEcsOUvosKMZ+2ywN+LhYNjQc1yCjd
	l6jTa7mkLVSLCB1AQgX1rHLY/2OQ7vyLB3KlmtiMer1EUQVc0gWSfgxxMWYXJA==
Date: Wed, 29 May 2024 16:13:08 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH 0/8] net: pse-pd: Add new PSE c33 features
Message-ID: <20240529161308.27bad381@kmaincent-XPS-13-7390>
In-Reply-To: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
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

On Wed, 29 May 2024 16:09:27 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
>=20
> This patch series adds new c33 features to the PSE API.
> - Expand the PSE PI informations status with power, class and failure
>   reason
> - Add the possibility to get and set the PSE PIs power limit
>=20
> Jakub could you check if patchwork works correctly with this patch series.

Oops, it seems I forgot the net-next subject prefix, sorry for that.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

