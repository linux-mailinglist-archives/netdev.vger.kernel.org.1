Return-Path: <netdev+bounces-127979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B657C97762C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7382819A3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70E139D;
	Fri, 13 Sep 2024 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikABmw1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBC10F7;
	Fri, 13 Sep 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726188144; cv=none; b=Y+BijjVHwLj0RQD42eXycIC9de9jFLmo8tOGVtkx8znoNmFqiTxkkm+FRM0dGZxRIRHvRFcHKts4vMTt+ZE6ESVLgpm89MIuLtnfbvO9COw3lzXh7+8iZVkBfK7HSxhqy+NwcjjtVGQayLGb+rtVWo8atQMs+MEmhNnbRgPcmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726188144; c=relaxed/simple;
	bh=hwEO70+fmwgdu7QAwo87E6/1Hd/d5wRAwravRDMb46c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJD78jnIvkcLdkUxPLOeJK3jgIjuYp7Lez6Ese69DFphKNlO6Uk3CZeq1MFPyF/i6AIUDdL2x6WvjkfwRZUexj6IIRv6iZc1qlM2kdZQeYIMC58V5NnRIE41YMYuHU1BAuwU6bSZ0xK2oaf+ER5ePev7sI+yW2OKI/ilcUUfI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikABmw1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A8BC4CEC3;
	Fri, 13 Sep 2024 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726188143;
	bh=hwEO70+fmwgdu7QAwo87E6/1Hd/d5wRAwravRDMb46c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ikABmw1bgZunfRYPAcTylVOiG5bVmIE9tXtMvkhr/ZEmigt2ZjwtB6p019BMBuFwg
	 L7m82lrXz/+BWA2sibjGp+ZtcNL+BbnM40YNnjRrcTKtZlVV35Xd9GgljCq38Mus/H
	 km0U0Llq4HO+L5dDvXLDfjGGIgR7xNfuhtNOh5W1YGphnD52XcNEdX/dmi7UsH5m84
	 FIY4wZeXlFfu4OMT/HcmZvwejYYPUb5EHAADfexd+KiQw6CBGH4fOn8g4iEnE8X9b8
	 vVj/Gve9FF9NTqEfn9VTp/hRkYOwTIKZX2zm8nKFE6wyuM1nTPQT92Y8gqFqLypBze
	 +/QoP+99usTPg==
Date: Thu, 12 Sep 2024 17:42:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>, Chris
 Snook <chris.snook@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
Message-ID: <20240912174222.6de55d16@kernel.org>
In-Reply-To: <CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
References: <20240911135828.378317-1-usama.anjum@collabora.com>
	<ZuHfcDLty0IULwdY@pengutronix.de>
	<CANn89i+xYSEw0OX_33=+R0uTPCRgH+kWMEVsjh=ec2ZHMPsKEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sep 2024 17:56:11 +0200 Eric Dumazet wrote:
> On Wed, Sep 11, 2024 at 8:20=E2=80=AFPM Oleksij Rempel <o.rempel@pengutro=
nix.de> wrote:
> > On Wed, Sep 11, 2024 at 06:58:27PM +0500, Muhammad Usama Anjum wrote: =
=20
> > > The err variable isn't being used anywhere other than getting
> > > initialized to 0 and then it is being checked in if condition. The
> > > condition can never be true. Remove the err and deadcode.
> > >
> > > Move the rx_dropped counter above when skb isn't found.
> > >
> > > Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com> =20
> >
> > Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>=20
> I do not see any credits given to  Qianqiang Liu, who is desperate to get=
 his
> first linux patch...
>=20
> https://lore.kernel.org/netdev/20240910152254.21238-1-qianqiang.liu@163.c=
om/

Right, odd, is there a reason you took over from Qianqiang Liu?
Otherwise I'd prefer if they could send the next version.
Last thing we need is arguments about ownership of trivial
patches.

This v2 has an unnecessary Fixes tag, this is not a fix.

