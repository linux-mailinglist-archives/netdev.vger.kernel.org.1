Return-Path: <netdev+bounces-27401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA177BD51
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CBB1C20A51
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A486C2E6;
	Mon, 14 Aug 2023 15:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100BC139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4DFC433C8;
	Mon, 14 Aug 2023 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692027806;
	bh=4M4QSrCs/4eFD+3ggQCLqZfClvZElawWXoDFuEO/OYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ab+QiJnd9e3G8SiFdFoOEP/XbNKL8qJQqAW4Yeiadho7J2rqandOYUldSHXC/vwH2
	 PxX5OH21fJurFxXKLwyYX2xXzKGtRn9SyKvN/SR/diwrKmgv9bHc9U7XP3s0iqBf/c
	 0OVvPbUQ19bQ1aN/lWaGUY8q377xFS7R3FulDxkUDcijo9P4+FBPfOUuNa0UsNaXFl
	 QY1VhaxDWCzMFK/lt4B+mmd0a1696x3DJIzH//VntHLkq8JgsQtjZqrITKxm25+1B4
	 L8Q0igwV9WqrTCSsv7yqrUOpeKl6i6tVOI9Rzpw/9J3y+OTCpnxnZg8pGtxPXylqbC
	 nBeFzBuBAa4iw==
Date: Mon, 14 Aug 2023 16:43:20 +0100
From: Conor Dooley <conor@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230814-quarters-cahoots-1fbd583baad9@spud>
References: <20230814100847.3531480-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sO9y4wGyKLEBtlMT"
Content-Disposition: inline
In-Reply-To: <20230814100847.3531480-1-danishanwar@ti.com>


--sO9y4wGyKLEBtlMT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 03:38:42PM +0530, MD Danish Anwar wrote:

> MD Danish Anwar (2):
>   dt-bindings: net: Add ICSS IEP
>   dt-bindings: net: Add IEP property in ICSSG DT binding

For these two,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--sO9y4wGyKLEBtlMT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNpLmAAKCRB4tDGHoIJi
0u1xAP9M5o6AwHsPfJpPcLSWCn9wBcTEpc3Zj86fHWMLdbZPEgEAjh9E4Pq/sFfU
6Ps4YLG/mOYxU1csU9sn9aa8hj6t0gc=
=EJFy
-----END PGP SIGNATURE-----

--sO9y4wGyKLEBtlMT--

