Return-Path: <netdev+bounces-213192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC6B24155
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF4B94E0EB9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5327D2D29D8;
	Wed, 13 Aug 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HzBv5nVG"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E52D1F5E;
	Wed, 13 Aug 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066103; cv=none; b=pwzYA1kLfDhOlK+JHtrLHpIwdAR8MdByeIQXn4Vn3pJsN+qHMJ71tqDYV8wzqT7I4YUSkIsrcKxI8M4RxB5e+GIWrpdco7+88VGc+0unIOtpmGv7drZPbKxZ02xsxgLe8zmPoO2JKF64Hqf0zbGJAy+SFfDEYE0OrcrBKGalrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066103; c=relaxed/simple;
	bh=R7BUrhaHlE+9M6miAsWQi4bAbzafiOq8uvLGBAzIAq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSwYQl3aIJPP7hU0p679fhJ6GrYPyDGQo6y+lDpN7apF7/RivymgbRR/3OEvq9UIVTduiJAB0CU1ZIIy36Dn8ZjddimFIF/Rpe8BkYiaKusg0BUHSZ99yFYE4LAE9BolgVi1FZSghQBAncLLSX/laHtqLHOg8XQHtbunrYHlXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HzBv5nVG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1yv037m5z9tqW;
	Wed, 13 Aug 2025 08:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755066092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7BUrhaHlE+9M6miAsWQi4bAbzafiOq8uvLGBAzIAq4=;
	b=HzBv5nVGPMRSRR+YMjdElj5iR8abwMaCcLgwvslaKMttaQtz7TZWp0D012lWeiC0mBQwP4
	iEL5a34Oq95fDINHh55H2Gp7jkqaaQDR2IoY2pokHWu4pSBw6ljpXomuBNJb3QZzNPkOnT
	XR9ZatcRvodI6+Svxi0KIw4EICZ1PAc7PEuURzjEL8lObPgg4eaARKRYl87L6chkacD1Jn
	JDLK3BkUw1CijUJOVH3FsvTXVTTft2t35KdDYvwZwlKvtai6T28u7VZEJMocO+eKxPJMW7
	ekajwyq1V5ZRzZsCgN/IcnmItCdxb0onu8FoR+FwzFm/AszAdNJ912RsSsJJyg==
Date: Wed, 13 Aug 2025 08:21:25 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next RESEND v17 00/12] net: mtip: Add support for MTIP
 imx287 L2 switch driver
Message-ID: <20250813082125.7ccb3089@wsk>
In-Reply-To: <20250812185044.4381fae8@kernel.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
	<20250812185044.4381fae8@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: uwo1t4bs5scuz11ixqc31chge76m7mni
X-MBO-RS-ID: aec305653413cba275c

Hi Jakub,

> On Tue, 12 Aug 2025 10:29:27 +0200 Lukasz Majewski wrote:
> > This patch series adds support for More Than IP's L2 switch driver
> > embedded in some NXP's SoCs. This one has been tested on imx287,
> > but is also available in the vf610. =20
>=20
> The arch/arm patches don't apply to net-next any more.
> Perhaps we should take this opportunity to drop them?
> We will really only apply the bindings and the driver code.
> dts and arch/ code need to go to the appropriate arch maintainer..

Ok. I will remove them from the patch set and resubmit to arm tree.

--=20
Best regards,

=C5=81ukasz Majewski

