Return-Path: <netdev+bounces-243621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD59CA4759
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5573305D874
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7E2ED844;
	Thu,  4 Dec 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWU4cr3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33712D94AB
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865251; cv=none; b=U6MCWfbJ5gub2ZrUD0T3AnzwbCMRhhylOUIpLO1XNQcxl/w/qEX8dN/JTYTmUsOeuJT4bKliOE4En922RQk1Ccf9qYw1DbSibveEjndEb0+xCLU1ZVq9UNQCOJGmRuSr0azdkwKhdp811yxFEreGRANvlzi2qF3LZJp5sW3ryvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865251; c=relaxed/simple;
	bh=1AelSlKofywk9+qV521bJt8QJoFYFT4fuiDSvKptMWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPEI3LsgKtP1TFt6qGebiXYn14LsxfbW7cQ0zRN6UyB88ay+5CxWmrXYNwALJ6giTI8a7w/kUj3zMQMU88I+dR7+rJ/2yN3fEK9m0WvvnUEaWjMpkCTQ+XQr1S+k6tUb7NCveJrkqF21hfBLzsnJZ6bq7N3V78OQ1b8mwsgVP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWU4cr3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CBC4CEFB;
	Thu,  4 Dec 2025 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865251;
	bh=1AelSlKofywk9+qV521bJt8QJoFYFT4fuiDSvKptMWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nWU4cr3KZfVYpxqiEKqFfb8xzDByoTK8oge4ffLuVkQ/a2iK4WlEUsZOLrhN0w9o2
	 gyw5lZ+uV8JVsYkPIVrUYPcZRYBD6bSR35qNfMRXrKnAmjcdFX1rOE9XEx++aTO6By
	 jLLgRp0MYoN67D0SPdytllMT9xGhzJ7gwXj0xNfdoDfLxE3fz+unD4khEhpGD5SCXB
	 avjKswYcOVKtkTPcGcIgisLUnL+5yLdDll6ihJPHWoWJd/j6mVK+/WaNSCLLLuXCc/
	 GbyP4lEfUU/IoNaQLrLSdPlGYcDkQ3tA3OOClKOnCUSYfUYpsW+Z+3sHJoVkogenZE
	 1HpkctnARht9w==
Date: Thu, 4 Dec 2025 08:20:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 <adrian.pielech@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Krzysztof
 Galazka <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci
Message-ID: <20251204082049.1ecfd15f@kernel.org>
In-Reply-To: <20251204082001.561a5f3b@kernel.org>
References: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>
	<20251204082001.561a5f3b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 08:20:01 -0800 Jakub Kicinski wrote:
> On Thu, 4 Dec 2025 13:59:34 +0100 Przemek Kitszel wrote:
> > Hi all!
> >=20
> > I'm pleased to announce that we have set up infrastructure for testing
> > netdev on our e810 NICs, with more to come.
> >=20
> > Big thanks to Adrian Pielech who made substantial effort to make this
> > possible and to Krzysztof Ga=C5=82=C4=85zka for the initial PoC work.
> >=20
> > This work plugs into netdev-ci initiative by netdev maintainers,
> > to run kselftests (mostly functional tests in python) against current
> > proposed net-next branch, on real hardware. =20
>=20
> Thank you for doing this work! I really appreciate participation=20
> in the community testing efforts.
>=20
> > Our results are here:
> > https://netdev-ci-results.intel.com/ice-results/results.json
> >=20
> > with a viewer for humans:
> > https://netdev-ci-results.intel.com/ =20
>=20
> Very neat UI :)
>=20
> Are you planning to stay on the SW branch stream? I was anticipating
> that HW testing will need a lower frequency of branches hence the
> existence of the:

https://netdev.bots.linux.dev/static/nipa/branches-hw.json

HW branch stream.

