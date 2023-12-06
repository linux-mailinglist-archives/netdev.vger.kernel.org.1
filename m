Return-Path: <netdev+bounces-54185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33722806341
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A94F1C20F52
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62219F;
	Wed,  6 Dec 2023 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fgftFM4v"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F718F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZVKCt4UAuflXPdqJx+euGe2FWdc9Wr0YtNTgOoUNRRY=;
	t=1701821549; x=1703031149; b=fgftFM4vcS1cP5ukc+VSuyScw/kmuyXi/+NRG0Mveq9oL2v
	aQWxMhyLxfQ4Ta/zHjaX2rmdPC0+gErKt2yVNBynamPHCAu1moSFUINggbnhnZLY4xes0v3Ts2z+L
	jvp6sY88YMcQ9wvYnU+XeUFjEkqFl0+fEAAcCVmOwaX8DTl3kduIBooC8Gq6rK9zHZqGuX3hWC50R
	ZtY56+bsPrjNtRx86qXwBw3xPgFBhnf6qaOahUEYd2CMVwxRJSJ/+Ve2/1Z6G/8saGP4/Kb/Schm3
	Gkl7KpM/rY9sEc995g8akHEnVdrFPAUtFem7peyXV2rG6MYYUvjhZA8Iq3dM9tLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAfWd-0000000GfqG-10K3;
	Wed, 06 Dec 2023 01:12:27 +0100
Message-ID: <a840db62053cf5d3594effd9b1da8761be5676ee.camel@sipsolutions.net>
Subject: Re: [PATCH net] net: core: synchronize link-watch when carrier is
 queried
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Wed, 06 Dec 2023 01:12:26 +0100
In-Reply-To: <20231205161103.3bec2036@kernel.org>
References: 
	<20231204214706.303c62768415.I1caedccae72ee5a45c9085c5eb49c145ce1c0dd5@changeid>
	 <20231205161103.3bec2036@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-05 at 16:11 -0800, Jakub Kicinski wrote:
> On Mon,  4 Dec 2023 21:47:07 +0100 Johannes Berg wrote:
> > There are multiple ways to query for the carrier state: through
> > rtnetlink, sysfs, and (possibly) ethtool. Synchronize linkwatch
> > work before these operations so that we don't have a situation
> > where userspace queries the carrier state between the driver's
> > carrier off->on transition and linkwatch running and expects it
> > to work, when really (at least) TX cannot work until linkwatch
> > has run.
> >=20
> > I previously posted a longer explanation of how this applies to
> > wireless [1] but with this wireless can simply query the state
> > before sending data, to ensure the kernel is ready for it.
>=20
> Are you okay with net-next?
> The previous behavior is, herm... well established.

Err, yeah, sure! Not sure I can tell you now how I ended up with net
there.

johannes

