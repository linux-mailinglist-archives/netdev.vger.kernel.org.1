Return-Path: <netdev+bounces-215930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6EB30F6C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D75E584CC4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417523B607;
	Fri, 22 Aug 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsThBSg8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6794A1A;
	Fri, 22 Aug 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845137; cv=none; b=ZJp5S0rj6604vo6sI8fVLWqv53PV2C4ISznzWAinm04ULfYV1nZ/yLlBFWO2FgQ3HvFE+BFnLutIm9q2tdStwTthlQcNTr3V5LqCzmdwCYzRCMKk7+/ev+ZMSLEFADdYjxY+IIxCCSmEK2DqyuFpPjq4aSvsQ+5J83hpUdc6btQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845137; c=relaxed/simple;
	bh=omBsa6zg3zEkUZ8XPsuhRArPZBawinMCLE3fBZ3rG14=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=s0fzYG7Nsv+e+MEtVPM0khPBbSAF/XwOZ6tp/vT3pGNxLuBPRn3iU4c2lOzfFpy33b+KpTSiUdCzl4bYkK6wvVv4Je8SuccosKrbrKwGfkZxI+pfrzSYIrtoDNp9QajgsW7O1P3zkTx3Bxt2ro6akKzdxNDkWNtgKcT/asHuj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsThBSg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE66C4CEF1;
	Fri, 22 Aug 2025 06:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755845137;
	bh=omBsa6zg3zEkUZ8XPsuhRArPZBawinMCLE3fBZ3rG14=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=hsThBSg8GrU3PKC5cxqGeO8LunOyn2dLX2lVh0ZPC9a79U4RQ+mQvxZmuTO424p/k
	 L7nv+8601alzC1fV8fscnttFeFD4CWPhciqDf6Te8LYCL0iKgWPHSdJenhauAu8Gcq
	 cxl6HQHV2qlu69svNYSrLXjwU9gWz0nk53IBHl4DxQ//vHutTHeoYSIguF2ZY3jnKO
	 LqH6S3HDiwhHeaukhohRw6sCz+zxvXTznofMx+/p8iVakvvYBKodFL9rH+eNTMgawg
	 GIezinZZWxh0Ktbukw5T30xeg7eU0zwrR41227a6+fwTjldl9ygLbp+9smzGDtUV6K
	 9MP3P7F6yS9Ig==
Content-Type: multipart/signed;
 boundary=779a16bbfde2661f3fda3a5f16cb49374c69836b808b08825fd0cac1a722;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 22 Aug 2025 08:45:33 +0200
Message-Id: <DC8R5IJ2Q88K.YKUE9X9FZRNK@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Subject: Re: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID setting
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>, "Andrew Lunn"
 <andrew@lunn.ch>, <linux-phy@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <nm@ti.com>,
 <vigneshr@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250819065622.1019537-1-mwalle@kernel.org>
 <20250821181850.6af0ff7f@kernel.org>
In-Reply-To: <20250821181850.6af0ff7f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--779a16bbfde2661f3fda3a5f16cb49374c69836b808b08825fd0cac1a722
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Aug 22, 2025 at 3:18 AM CEST, Jakub Kicinski wrote:
> On Tue, 19 Aug 2025 08:56:22 +0200 Michael Walle wrote:
> > v3:
> >  - simplify the logic. Thanks Matthias.
> >  - reworded the commit message
>
> This was set to Not Applicable in our patchwork, IDK why.
> Could you resend?

Won't this patch be picked up by the linux-phy tree?

-michael

--779a16bbfde2661f3fda3a5f16cb49374c69836b808b08825fd0cac1a722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKgSDRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i5YgF/fKwXxjLC3WMRXP0gyjLT3q/3ejsVs+c1
xALeKL1JKMPm0+VQrKkqcL/DJxEDvmmtAYD0ySfqphFuONyMFycm77qU473WwikF
anbIYoYoQj6GCM034VCIOA0pLy4DLx3i7YY=
=wmNF
-----END PGP SIGNATURE-----

--779a16bbfde2661f3fda3a5f16cb49374c69836b808b08825fd0cac1a722--

