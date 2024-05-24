Return-Path: <netdev+bounces-97924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D58CE19A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCC8B203F9
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B112AAC2;
	Fri, 24 May 2024 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hmIrQbMf"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720E129A9A;
	Fri, 24 May 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536309; cv=none; b=H4edNRnA18jyt8pCx3J8D6Dz9IYhGY6IVMZs13mbVjEPWHJj6ej5oMDDPzkyY2enMPR24oxtgiwpTwAKCr8GIBYsVTqwCeSn4fYoxJ8q0pWWulzs5B4HOJxx99fRnOsjhEfIPyPI4h41jNhRZMSLAGoUrER2Ldziwlj9e0tbEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536309; c=relaxed/simple;
	bh=zg9rzX2CkzaH5NrTvRPMDSY7CUUk9rliAxQ0tkcFviA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1tz/T3sWyl1YxdHO1Xa3P1Hmg7kZrODMg4xTsrnspxM0tlr8QzhNBpcre9Lm/lfFnhKYBUpFn4ytOaDglxbKjy/4JBmhBlKYubkCnzseDE5UeeOljEC8OS/pxdvUfk0qsf5Bk/Ls8HW9Q2m8rNDRS0q0wzpKirMQbb/FR3JG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hmIrQbMf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 851E924000F;
	Fri, 24 May 2024 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716536299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zg9rzX2CkzaH5NrTvRPMDSY7CUUk9rliAxQ0tkcFviA=;
	b=hmIrQbMf2WedDiG8w5y6ouL4nF4XzbgCLUHbseSCnXfEhkjhKl89G3pSH9/QUXh1Zy6NSe
	CBBS5uk3dgEBTQ2JbYeXJdH8APub0uNEk4siIPpLOLfuJsYGtK+S365vPHt4VKiGDh/Uk0
	twVJldME00Z7DZ4Fm8ueYXS7QrSc/wPetqczVKJzy0Xu6rNghBjfxJjACeQIoPBrA3rnmU
	gy753MtIfBUS1o9aLApJfaoGlsLx7hO64yN38iTxcmiu1zu+Qhv/MdUW0RA/yBBgFDHzCr
	LhYUzmzcpqSsTS74DU9oIqRxpbn+r3FR5qdwDOPILURFxybN1lL7o6VZaKurxw==
Date: Fri, 24 May 2024 09:38:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: pse-pd: microchip,pd692x0: Fix
 missing "additionalProperties" constraints
Message-ID: <20240524093815.46e2432a@kmaincent-XPS-13-7390>
In-Reply-To: <20240523171732.2836880-1-robh@kernel.org>
References: <20240523171732.2836880-1-robh@kernel.org>
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

On Thu, 23 May 2024 12:17:31 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> The child nodes are missing "additionalProperties" constraints which
> means any undocumented properties or child nodes are allowed. Add the
> constraints, and fix the fallout of wrong manager node regex and
> missing properties.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thanks for these fixes!
Didn't know that "additionnalProperties" should be set on all child node, b=
ut
that makes sense.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

