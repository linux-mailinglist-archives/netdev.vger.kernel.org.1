Return-Path: <netdev+bounces-174735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB61A6015E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB97421B02
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB26A1F37C3;
	Thu, 13 Mar 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgePn02L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2A5464E;
	Thu, 13 Mar 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894716; cv=none; b=KOGM3A4X474Qpdhvul1uz3y5Rn6EL05cRgmZw2KtTDbIIW5qxa/pOCymPAs47Frmydz3U9v++YlPFcuH4XOAcEDBs0ZIYJMavDHfnv46UJtBKZAs0yqNnJAU6WYUsugXR6l2cAVdyUYWgbCcCk4x6QogClOHNBCMG5hfBsSIjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894716; c=relaxed/simple;
	bh=PJN9kuJafuaBlwl0mjM0aRG/llBd01Ca0mxiWYCJ1xE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XMsCyITj6OEzBAMboM1eVHrGrnQjFqAG2MiGVFQ4DTUKsGPzUPoBHfclLNyl7cXOJxGZortzU6d3A9dZ83evU6MMWN6cfVyiL80XVkdSQM82mEKubsYeHsz3klG8DilGWddevAQ5BVucKGE7GuqVT4wlq4wm92rE0WWmqy/ad30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgePn02L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08813C4CEDD;
	Thu, 13 Mar 2025 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741894716;
	bh=PJN9kuJafuaBlwl0mjM0aRG/llBd01Ca0mxiWYCJ1xE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BgePn02L7ieIWEOaT7+/eexPFW7pLTaLtdJF3ZTkBUzL2vwOwFJvLR9ARKMyfaoZS
	 IfaOCBDlEM7pRKTB4t0kzLU/Yv1jP8MimRiq413dQIavNlrQbqQ/MjGqL9d+ouVBpi
	 xl+ZKqfSMK6NyeZfb9Z5fpsI9pKmdqT+unXOdileCflox+Y93kiP2hCXK34kZTGxs9
	 9u5ZyOK63DEIa0uEuyWp68kfiIQ4akwd9iZ1ekEwgl/5kZUzcmTKLHjJwIB6GozQeS
	 T0gnGDXOj+s1fvdTcIx0WVsOCXPUFtbaS/sALs/CMm2kmHk8ZyTN6FgS7P/aruJ3mx
	 3uW+VL+fR8oiQ==
Message-ID: <be795c50ef61765784426b4b0fafd17b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ih7hu6nyn3n4bntwljzo4suby5klxxj4vs76e57qmw65vujctw@khgo3qbgllio>
References: <20250226232320.93791-1-inochiama@gmail.com> <20250226232320.93791-3-inochiama@gmail.com> <aab786e8c168a6cb22886e28c5805e7d.sboyd@kernel.org> <ih7hu6nyn3n4bntwljzo4suby5klxxj4vs76e57qmw65vujctw@khgo3qbgllio>
Subject: Re: [PATCH v3 2/2] clk: sophgo: Add clock controller support for SG2044 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>
Date: Thu, 13 Mar 2025 12:38:33 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Inochi Amaoto (2025-03-11 18:01:54)
> On Tue, Mar 11, 2025 at 12:23:35PM -0700, Stephen Boyd wrote:
> > Quoting Inochi Amaoto (2025-02-26 15:23:19)
> > > diff --git a/drivers/clk/sophgo/clk-sg2044.c b/drivers/clk/sophgo/clk=
-sg2044.c
> > > new file mode 100644
> > > index 000000000000..b4c15746de77
> > > --- /dev/null
> > > @@ -0,0 +1,2271 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Sophgo SG2042 clock controller Driver
[...]
> > > +};
> > > +
> > > +static struct sg2044_clk_common *sg2044_gate_commons[] =3D {
> >=20
> > Can these arrays be const?
> >=20
>=20
> It can not be, we need a non const clk_hw to register. It is=20
> defined in this structure. Although these array can be set as
> "struct sg2044_clk_common * const", but I think this is kind
> of meaningless.

Can't the array of pointers can be const so that it lives in RO memory?

