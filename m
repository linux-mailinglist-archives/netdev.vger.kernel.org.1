Return-Path: <netdev+bounces-97925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D28CE19D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 09:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B657281F20
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6D127E28;
	Fri, 24 May 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c0MCuzvA"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AC9475;
	Fri, 24 May 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536398; cv=none; b=qXBVkEeRAGJyPlmhYy5HBzhiVoLERKDTPI6GRbOfWyqNzpHbYxLZPtzhtTZZTnRtMQW0J7s7ZDTNoMb8nZaguwtKxiim5KrVPRHVDZNa/fdxT0MbQVJ//6DYCKpKPJWMFok1vIlmpQUYIG3zAEa6hdH4TAllhHJM+tvtaRC+krg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536398; c=relaxed/simple;
	bh=q4ijQgKF32lB7PvxRzNvw/zlrLwTb9nj6LptN/ARhPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzodiqZWjm6a4s3Ir0j/Wn0UWK6QUc2T8Opzt2UDef9OplXOLZNc7EDSdkOkBeZPPBpeKxVlB2QcJboRVhRqbcvEoqUxmCrkXPD2pJisOeVIw3b1nf3b2YGCy7iPAqO2DesV2FYcwGTSPJ/lXYe3NyNCptAr9ZKeChMVBMpfrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c0MCuzvA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 756A01C000A;
	Fri, 24 May 2024 07:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716536394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4ijQgKF32lB7PvxRzNvw/zlrLwTb9nj6LptN/ARhPM=;
	b=c0MCuzvAwcU+WR9XDDU7/TGIny3RJGUj3DtBLt3mku/6XvpWStzn1bZ9pkDTpQSawFGmrF
	XmxrAwQIdwl4RsbpVvlGQsY8DsBc+mMjzjTqRmyGKHnyta7kqO6k/QcBgVEuUQUuo803Cq
	in/TOIXjoDvssAXqskglduQLVlRWPRrwjM/BMjogIfBtrKGbF+xwOW7D0LnlMv7d7CcAGr
	RVUpwLTlyag5CU9sGaNDDXi+2LcFGNWe6DRVQWUzYKjglK8RJkkn7PpkaKNI44K494DTqs
	404gSPwRiLzoYTF0EvlNJtk5dEt+Drascx9WW1KlMKw+X9XgEZd4Nrh9GoRpNw==
Date: Fri, 24 May 2024 09:39:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: pse-pd: ti,tps23881: Fix missing
 "additionalProperties" constraints
Message-ID: <20240524093950.323b8c44@kmaincent-XPS-13-7390>
In-Reply-To: <20240523171750.2837331-1-robh@kernel.org>
References: <20240523171750.2837331-1-robh@kernel.org>
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

On Thu, 23 May 2024 12:17:50 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> The child nodes are missing "additionalProperties" constraints which
> means any undocumented properties or child nodes are allowed. Add the
> constraints and all the undocumented properties exposed by the fix.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

