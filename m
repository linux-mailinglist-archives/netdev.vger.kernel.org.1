Return-Path: <netdev+bounces-109961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6611E92A813
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208BA280D8E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3661494CA;
	Mon,  8 Jul 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovbQ7qeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78C148FED;
	Mon,  8 Jul 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458619; cv=none; b=Wy4HamL2safaBFigyvY/ycRQjiSqzcTR59FXdSC+m4murbuj0+PiWtP20Y6DfR5DGiPNVgpLhhqyWMyQmSDF81OloUfQzbFog5jUSoj7/+KZyCuhsbzvjzXTWf7a4CfODsrKTo4t66R/oE3hUhTR0iaZqAPz2UKa5+8jCrGN9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458619; c=relaxed/simple;
	bh=EoBYZ2wYoOgkBX7O+AbPYANnMMKtKHC70TexwJ93RT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcvJm9DzKQNqpUMmJvlunfWtGbb043QcPb3JJPtGvJ9iOLIv6r0u+BDIpTRGCa+fEldpJ9cVSoFcLGj5+klIGUZRDDhlDCQsp047uZYM32gU7DpFGlLL3arzPkf2b+TALs8MYnRrQxoydisik4F3n2p7mIz4idKegrG1YTIs12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovbQ7qeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0D7C32786;
	Mon,  8 Jul 2024 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458619;
	bh=EoBYZ2wYoOgkBX7O+AbPYANnMMKtKHC70TexwJ93RT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovbQ7qeSc/FSQpWMKlY0AFMgFanwOO9T9wZx2d0DzkLPW0mi0ONlO8ivn3VEC4V40
	 XezEoL7Ako206L2pjNeMhhKKa5JEeRx7zLWbH+xUUt4TClIUNBSD7Am4PsAGmPXunZ
	 7U1XQt7Tatho14qVmYEba8waenVjWsMuyc2qg+xZID8RMbeFUzzIlw9s3FzAOmsr0U
	 M2qwI+yhhlQ4enCTvuHxgBMXTIcTejhK38Ez06fFdMP0xRZRikw+TN68LHhEBiSuxP
	 olZstNunF8PpPF4+WOyLRQW+94TNpZlClOh7SrYTJGjGOBu2tn7N/YV0pEnieHQLvX
	 ggMT6gwz5cQEg==
Date: Mon, 8 Jul 2024 11:10:17 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE QORIQ DPAA FMAN DRIVER" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/2] dt-bindings: net: fsl,fman: allow dma-coherence
 property
Message-ID: <20240708171017.GA3458907-robh@kernel.org>
References: <20240704161731.572537-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704161731.572537-1-Frank.Li@nxp.com>

On Thu, Jul 04, 2024 at 12:17:30PM -0400, Frank Li wrote:
> Add dma-coherent property to fix below warning.
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: fman@1a00000: 'dma-coherent', 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - Fix missed one rob's comments about 'dma-coherent property' in commit

What about the subject?

> message.
> Change from v1 to v2
> - Fix paste wrong warning mesg.
> ---
>  Documentation/devicetree/bindings/net/fsl,fman.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

