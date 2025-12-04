Return-Path: <netdev+bounces-243620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20620CA4750
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C046E304E17B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AC2ED844;
	Thu,  4 Dec 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS4h5NKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC229BD94
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865203; cv=none; b=YIAkx8/YVd+QdSJOVd+Pg/CbphH/IBG5algGzR69lHIbTaADuX57q7gcXqTxGdt4ND0CgXG6NcNBY4Vy7UJw/2KQPFisZIhReEe77j01uP3tGaxj73h5eFx/Czs964ZX/FksUe3vtVJI2rJJUCd7NlJ11MQjsdSlPMzBeJHzSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865203; c=relaxed/simple;
	bh=u57tejH3ziyE8514FYcFiPLeeh+C6htGPe3gajhMtxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEBy8FK08SPDtEQpDXwfrIF3T8gSsJuwAo0h643ziTUEBqpb2glneUGA/PB427wzyDWeapHogxVg98ZmEgtgiM7UkLtRFp/daH+cRqbrcmVvkWY+fqrrzy7Byi1A1vW/k2OkGQFFoJN0V1AuBgtCJGWy/HLu1xvCKW+HdVaPBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS4h5NKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1BCC4CEFB;
	Thu,  4 Dec 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865202;
	bh=u57tejH3ziyE8514FYcFiPLeeh+C6htGPe3gajhMtxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nS4h5NKxZvuSMz0vL4EUSHgrMMa93APGW1Sn7U4/9XdshedNV/m4RYfcYJNNdyDJ5
	 nlsQ2RyL8wiOfE2RCwKN8kpOsUzOmH0CDeRbBehsGvMSIrdIYAjWD1z1+cEHLC3Gyf
	 U1MWGJKffKxTuEu91RNLl/KxPYSExql59sG2hifLiDr3NdYqByYMpue+AHeTtA34A3
	 f7/iXH/QpMB+egw+5Vhn7JjAGtiP4dz5EVKIXvYks8EWIQdKledxUJ3ghl0G4I2Az6
	 +FesnEuHBDZjSWmD0oIn9LG+dNgu3uPhb1AHCqPVaODaXouoA/ZMs4dUKms0TSD1tI
	 3xUN7uooCD9cw==
Date: Thu, 4 Dec 2025 08:20:01 -0800
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
Message-ID: <20251204082001.561a5f3b@kernel.org>
In-Reply-To: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>
References: <a0561c1f-f64e-4d76-b08b-877897d45eae@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 13:59:34 +0100 Przemek Kitszel wrote:
> Hi all!
>=20
> I'm pleased to announce that we have set up infrastructure for testing
> netdev on our e810 NICs, with more to come.
>=20
> Big thanks to Adrian Pielech who made substantial effort to make this
> possible and to Krzysztof Ga=C5=82=C4=85zka for the initial PoC work.
>=20
> This work plugs into netdev-ci initiative by netdev maintainers,
> to run kselftests (mostly functional tests in python) against current
> proposed net-next branch, on real hardware.

Thank you for doing this work! I really appreciate participation=20
in the community testing efforts.

> Our results are here:
> https://netdev-ci-results.intel.com/ice-results/results.json
>=20
> with a viewer for humans:
> https://netdev-ci-results.intel.com/

Very neat UI :)

Are you planning to stay on the SW branch stream? I was anticipating
that HW testing will need a lower frequency of branches hence the
existence of the:

