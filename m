Return-Path: <netdev+bounces-214710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C84B2AFC1
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4DA7AC63D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E982D2494;
	Mon, 18 Aug 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/PUpVI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997F2D2482;
	Mon, 18 Aug 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539341; cv=none; b=QlL+ubeCR65WJQ4Jp1iMBNscNcNS/Rw/gHrgxfBh6/OHqC2yfvdmkTnGTKw9taescsO4vgR3q8brQj/Lm+qV/D+EM7d812ol+bSpEzLZElXzbsKsr29juR95XTvCwbCsyZQH0TahmXSxSM4DWjr5dU99wr8lvDRTbtXY1eCIKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539341; c=relaxed/simple;
	bh=yzg89wI4WRGyBpC4fKo2pvNxEu1GN0EWvVjsQRCbtcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHvMjikUyw65FtViIF5vwCJQ/iUmIe5xjNM0Cqk57iQXDQc5JdOXftglsMHJ/Al3ag4PwtSgKMAyBQFZm1XN7mrhEqiiqH918nNU2Y0bsBkXCabHrqUqWhNjUBCBvpdSBsJRDsc7c4yGCLbRoc2J0k5D4zIYiF3ZeifFsVHEadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/PUpVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF82CC4CEEB;
	Mon, 18 Aug 2025 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755539340;
	bh=yzg89wI4WRGyBpC4fKo2pvNxEu1GN0EWvVjsQRCbtcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0/PUpVIsr0FxfF03cj7AiRvp2SZa1QBYuWG6Vd6oxCrqWOMGAutg91pLETYR3zzO
	 HRoKTY3lkhWGy9O/m9h1LvohwkN216kD9hhXdZWGdDi+ayC7thnLVWt+1bqH5S4s4D
	 Qf5LVxIb4FLTmE3OfSBp+QfEM9BbjwaICINlttAVBBYBYOtvjchqhe8HX+ctp04O5n
	 dHjVpw2vHUt4KFgNUkqTGbJTE0ucmPhFj30GcX6h8FjssBaMBcQD7gM94mq+J3bi4n
	 bzi9l5ehsUCItwSw4584+vtAvInOZubUl9ktrOqXYqnnKRp9bwZ46LjWxB+0JQOQWd
	 qhdD/RcR5gaJg==
Date: Mon, 18 Aug 2025 18:48:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: cdns,macb: Add compatible for
 Raspberry Pi RP1
Message-ID: <20250818-quack-lid-59e71737f242@spud>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wajkoaFh9Mksd++G"
Content-Disposition: inline
In-Reply-To: <20250815135911.1383385-3-svarbanov@suse.de>


--wajkoaFh9Mksd++G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 04:59:08PM +0300, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> The Raspberry Pi RP1 chip has the Cadence GEM ethernet
> controller, so add a compatible string for it.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--wajkoaFh9Mksd++G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNnhgAKCRB4tDGHoIJi
0mjsAP97kK0IfQ7Ov50V5elnbXgZcegx4hBcq+cQedRkxNgC6AEAth4I1+sps9OD
bT0La5XO5WyCakSYJpYh7050t8S+0gY=
=9lyu
-----END PGP SIGNATURE-----

--wajkoaFh9Mksd++G--

