Return-Path: <netdev+bounces-239283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63666C66A11
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 733A7298B2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62ED1E521A;
	Tue, 18 Nov 2025 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkgr9+h0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC141D63EF;
	Tue, 18 Nov 2025 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424883; cv=none; b=nOt0+zWHyehL5HVlQMjIrXlPYbxu+sSDD2M1z9uZDApv8bOYxN1DAW6Bn+qF/zmkZlZqA3CiQ6SpyHeFqfHqzd3IfM687rZHZw9GIP01pEZ6poPUIZXQgWjDU1qrk3UlW+qOA2jvpEHhiPSi3/AjVslBp4wtXbcu9qxriR5JprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424883; c=relaxed/simple;
	bh=eYXQMSeFcZ+u+ZKvoXphlDHsDa+DwPrWrlI1Op91Rd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDoD3E6BdMqF7NIP9tWBlnys3va3pvzeWQSero7gZ1SKCRFiqqZn6kYHKPAoUKMLM9S/2yVAov+EGRLm4mzDRBh7jhY2kxCh96GMpJXLWu1fadZToSaT+/Iw7YjXY//vuuvhEqq3+LctDYOD7bzNczV/JcVP4Vm459GHc0w2azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkgr9+h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA2C4AF17;
	Tue, 18 Nov 2025 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763424883;
	bh=eYXQMSeFcZ+u+ZKvoXphlDHsDa+DwPrWrlI1Op91Rd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wkgr9+h0j9JVyiANP7SA1+ZnJTkYChA9p/F04dLjes126EfDcYm7XSKTh229CPgU+
	 y7Oo3SrIKMmaIq1SeFB0nCu79tcIhiI3jlukolxTVN530tgF9hC9JIwewMMIutl0/5
	 RxYGOENJHVgoPcrd5X+HKYF01uUXbyPzLnlneRtgDbCU2X+ECQ0dJDDz3WHkq/R1oq
	 pB0AO1iUBOlYS3ICN+awOXETe2qjzdmxz33W6GVfOZc7oFfmOQcNf8RWUAjkREQnks
	 tKfaQ1ihuwBZAQJ7TlLUn6mkYQOVfcywrhKj9An3cRpDG89VDGfOPVwdbPy2B+xdSW
	 s+Dm9PeQIGt5Q==
Date: Mon, 17 Nov 2025 16:14:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Message-ID: <20251117161439.1dedf4b6@kernel.org>
In-Reply-To: <aRQGIhazVqTdS2R_@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251110180746.4074a9ca@kernel.org>
	<aRQGIhazVqTdS2R_@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 04:59:30 +0100 Jason A. Donenfeld wrote:
> On Mon, Nov 10, 2025 at 06:07:46PM -0800, Jakub Kicinski wrote:
> > On Wed,  5 Nov 2025 18:32:09 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wro=
te: =20
> > > This series completes the implementation of YNL for wireguard,
> > > as previously announced[1].
> > >=20
> > > This series consist of 5 parts:
> > > 1) Patch 01-03 - Misc. changes
> > > 2) Patch    04 - Add YNL specification for wireguard
> > > 3) Patch 05-07 - Transition to a generated UAPI header
> > > 4) Patch    08 - Adds a sample program for the generated C library
> > > 5) Patch 09-11 - Transition to generated netlink policy code
> > >=20
> > > The main benefit of having a YNL specification is unlocked after the
> > > first 2 parts, the RFC version seems to already have spawned a new
> > > Rust netlink binding[2] using wireguard as it's main example.
> > >=20
> > > Part 3 and 5 validates that the specification is complete and aligned,
> > > the generated code might have a few warts, but they don't matter too
> > > much, and are mostly a transitional problem[3].
> > >=20
> > > Part 4 is possible after part 2, but is ordered after part 3,
> > > as it needs to duplicate the UAPI header in tools/include. =20
> >=20
> > These LGTM, now.
> >=20
> > Jason what's your feeling here? AFAICT the changes to the wg code
> > are quite minor now.  =20
>=20
> Reviewing it this week. Thanks for bumping this in my queue.

Sadness. We wait a week and no review materializes. I think the patches
are fine so I'll apply them shortly. The expected patch review SLA for
netdev sub-maintainers is 24h (excluding weekends and holidays)
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

