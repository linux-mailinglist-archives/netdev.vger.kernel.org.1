Return-Path: <netdev+bounces-231811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D145CBFDBA3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C93A7900
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9042E2EF2;
	Wed, 22 Oct 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm3RpiWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6322E283A;
	Wed, 22 Oct 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155768; cv=none; b=R3C/I+Eo4FW5iauN0XHepB8I+20ZengoFc3z2Im1Pqp1kdUkXMU+X4xkuDVm9sFjIOsQTNuwvaC1Uw1vItl9RlQiykSaKukgYZXQP63FHwDP7odkMBhkBhiKLXo8H644/ENV+95P2UFcgeH31DRWBziIQe+qVd4nRP7i4///rwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155768; c=relaxed/simple;
	bh=zLBi04RxI2O0RigdxNhStIqhpXBwVCCldfIsWnpvxxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y32druLrzblXd/hQ8unpqKliFW6eFbCxNDRhcdWv0922TsSG43B+byakIJAbZGegupJBKsgY0217DKLKB3xvJbK3xnFaqnz0oPs1PjGpLvOvgCeNNRpHD+gcu2IhlB9O3fOmDuuQXvXSvDxDMnNjmSDYRqccCo/t2NtCvv/ubOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm3RpiWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B06C4CEE7;
	Wed, 22 Oct 2025 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155768;
	bh=zLBi04RxI2O0RigdxNhStIqhpXBwVCCldfIsWnpvxxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm3RpiWi04aJLnz2ZZaO7BKC23T065gjcOqZ3/6CORMFzTwphQq5h09SnMwBTvUMd
	 ShVCsfZ31u6K6xC+WyZT9pQ44cao0zcXcGIC3LGprce5oyyOE3o9DlH/CK+VAywqVg
	 2TTtgXgikGdl7KixyDu+YWDONxoxJRqUiUN+pslnoupPrqdaV2z2EnSQOekDfJ9zM+
	 YyWTDjUlLPkddg+TFDS7SWyqVxjQmoOf92Xy7KHLTyQXA+CzClK45Ivn2Ofu+G8v1B
	 EHICJbnt5aMBBb4VzmZ5MioF1HAC7Yl2jT6y/pLCriQJNW9pbCgmsTmuPXx5hoJUmB
	 xO/4dw8OyXX6w==
Date: Wed, 22 Oct 2025 18:56:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3506
Message-ID: <20251022-splice-swimwear-b4aac8baa143@spud>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VGM0Y4Yfiy4ZRLY1"
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-4-heiko@sntech.de>


--VGM0Y4Yfiy4ZRLY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--VGM0Y4Yfiy4ZRLY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkaswAKCRB4tDGHoIJi
0rF/AP46l7hsdSxhsDVFRzb7xHY517Q3P8GvjAI1g97P6NecmwEA3jy2Q55+Tnav
n7u98UvqjNZV7hY6LGukAHjOHVj/tgs=
=DDbK
-----END PGP SIGNATURE-----

--VGM0Y4Yfiy4ZRLY1--

