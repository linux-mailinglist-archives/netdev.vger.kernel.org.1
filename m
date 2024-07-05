Return-Path: <netdev+bounces-109468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94765928958
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD91F24C1A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7E14AD24;
	Fri,  5 Jul 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UqTgt3ti"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCB14A619;
	Fri,  5 Jul 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185028; cv=none; b=gTAORqXd16pyrY0xl+rwxNO3uwC3MAATkgM+ptX4xwYPObTmzVS0BPqZi6CvFshZkunt3lIkre2kOm9d8NNRXX9t0VWhAZsgdsTocJa0FEjPh3kuJbj8XGbI9r/53NPz7wR2muc/EPojOYL+1Dv2PnUavU1brlIDnelC0g+kU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185028; c=relaxed/simple;
	bh=1NDNe0a08Jnth+SdKcwCDFDYfxeqRXMg5lxLsang5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1BNWYTw1JwIjrWv1eHGpMa7G320o++eLMlUiDB2MehxGPV8TjdI2k/Tp2jlrRWdxTHl+I3icorBNFrg14UoMmxMiz5DSzkbCV2FCnHgu+qWlouO04W0ipViwDrT3iZIn4dsonMeRoYqPDL3wQanPiuPJevBfmDmW68vx4845Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UqTgt3ti; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42E5EFF807;
	Fri,  5 Jul 2024 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720185024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYswkeNhIkiKbPsOhdlvG/mPzP/JJ+aTpbYIr4ilp4E=;
	b=UqTgt3tirLSxBoVd30G6TkCQ8Zo6pxAcnUTPYtXnD6V4prW4uiIXrADY+Zj0sD/tHleNoD
	dzpkdyOu++g049MFg6H707X0PzVtmvNa70PUCSKMnk9Wv909Vn2zYLksA91DXGH2UqwCqF
	kg0vvLJxhZu3XpNz66iR5aMz7JsbFjE0QLjNM0BKnIMIdnPDaeaRt37jBBORllS5wrd25F
	rJpHiJPqxxA6jHY4213gnWTyAAJvYvoF1mBW+w588Km4i0Ymhn9Xoj20zsPIKiX5w3ztrV
	evQCk+KGS23sNborZYPpz9KNg3sPOZRxjft/mpEEZT3ZQLVoRWDCjwuhHXgqgg==
Date: Fri, 5 Jul 2024 15:10:22 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 linux-doc@vger.kernel.org, Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [PATCH net-next v6 0/7] net: pse-pd: Add new PSE c33 features
Message-ID: <20240705151022.0634c34f@kmaincent-XPS-13-7390>
In-Reply-To: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
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

On Thu, 04 Jul 2024 10:11:55 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This patch series adds new c33 features to the PSE API.
> - Expand the PSE PI informations status with power, class and failure
>   reason
> - Add the possibility to get and set the PSE PIs power limit

Hello, any news on this patch series?
Nearly all the patches have Oleksij Acked-by tag.
Is there anything that is missing?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

