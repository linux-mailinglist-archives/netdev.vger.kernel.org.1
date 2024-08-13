Return-Path: <netdev+bounces-117881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53994FAA0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D381C21B03
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C15A38;
	Tue, 13 Aug 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmzohQk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEB80B;
	Tue, 13 Aug 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723508541; cv=none; b=gVUheQrJL/SBuBUT+TvUOT7jKJRY8XZHcm3sd+BmWkkgssULHrLrnaugV79pJv0ygJP9PRHdkrdsQhPuuibvmiOi1ILpb8jDMvqGFsS3d/HlaCcgcrxpjBF+3lW0LrM4xGBx9l/v6ftCZ9Mi2Qx/C0dwEPt8MgSDA3C3bRyRbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723508541; c=relaxed/simple;
	bh=DAz1B+3uwro0Q8Bh/N+Rxsq8lpnfn1mcP0ssTJXVg78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAuUcUmIT7UwBr+sy5ZVOZUH5MJApg2MTYdF6CC8wiikqir44wxhJXShhmV0t9z8AoT9f8UhfIY8LLZbsECXsf5mxjqWWKiJT1LD5u8V8WmOlvVuCYmHUFjqaAr6JsMP5ISFyNvmJVn8WB2vhzWixhZhe4EuAnew/a13NQgTStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmzohQk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A8BC4AF0E;
	Tue, 13 Aug 2024 00:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723508540;
	bh=DAz1B+3uwro0Q8Bh/N+Rxsq8lpnfn1mcP0ssTJXVg78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmzohQk+ArsxuT3eFBf94Tw5pbWFb34nzZfU8ttB1sI7pJOMxGz6pE6R7rBbkf+Ym
	 zB7Eqf9z8lm46wJDrI12c+Bo0YhasROIwjd4sGy4vGNqyXPRAPPYJgLyDOnYSEKWxg
	 h5zv8jYCm6r3pwVebsRMf9QSs6fRYINil3es/3I7YiiwwQHexCWTU8khD0V/AG8LDG
	 9sbtYZU6owp14LbkP7G0sXvCLAnO0R8ibXl8qO6OlxjC1OJ9yZ5rx0pXOaO6JsyJug
	 8B0DUywhCWQO+j1235peTpH0WKJOPL/fAUMI16NnWGv0S1qkIHICO5AgGGtBJAOBJX
	 OPoIrkkyjFE4Q==
Date: Mon, 12 Aug 2024 17:22:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, Suman Anna <s-anna@ti.com>, Sai
 Krishna <saikrishnag@marvell.com>, Jan Kiszka <jan.kiszka@siemens.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
 <srk@ti.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation
 for PA_STATS support
Message-ID: <20240812172218.3c63cfaf@kernel.org>
In-Reply-To: <39ed6b90-aab6-452d-a39b-815498a00519@ti.com>
References: <20240729113226.2905928-1-danishanwar@ti.com>
	<20240729113226.2905928-2-danishanwar@ti.com>
	<b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
	<20240806150341.evrprkjp3hb6d74p@mockup>
	<39ed6b90-aab6-452d-a39b-815498a00519@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 11:20:56 +0530 MD Danish Anwar wrote:
> > If the net maintainers are OK, they could potentially take the binding
> > patch along with the driver mods corresponding to this - I am a bit
> > unsure of picking up a binding if the driver implementation is heading
> > the wrong way.   
> 
> Hi Jakub, Paolo, David, Andrew,
> 
> Will it be okay to pick this binding patch to net-next tree. Nishant is
> suggesting since the driver changes are done in drivers/net/ the binding
> can be picked by net maintainers.
> 
> Please let us know if it will be okay to take this binding to net-next.
> I can post a new series with just the binding and the driver patch to
> net-next if needed.

Nishanth, could you send an official Ack tag?

No problem with merging it via net-next.
On the code itself you may want to use ethtool_puts().

