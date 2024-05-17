Return-Path: <netdev+bounces-96974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CC8C882B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EFC285F40
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8C399;
	Fri, 17 May 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2tmIfLw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D05657C6;
	Fri, 17 May 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956765; cv=none; b=rM+aowf6aP1aVx7/QIYJDaq4NuoiakGlkRpeYq6L1N76TQ9EQmLIopkRk47HcVm2o7SjXGd4gDM6B265CaianR67UygRb1rXcmvss9wkHB/K5cpef/j+7XvMsVJt/aaNGfS6rpiO+GNKuL+d7pVoYSpMC84yUo0fWyg2ABQsV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956765; c=relaxed/simple;
	bh=3cdbI//fG9tefYk9dE1HYEleskFp8c3t8dyT3UHix8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKQWkaKo+n5AkNwsJOWMdRcgbmD9lv33Os64JC1dcdZzCI3bMToRJy27e54xkMTAUP0DIhiOJAUZdMZU0DkAGSw/nyUUhRGKeCOzWMvnRiqL2qRGE1pfupYl8t1ICp0J5OGzEdFukDzrB+DEr2OodBl5jA7w3CGXBvfhCLW1QSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2tmIfLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD3C2BD10;
	Fri, 17 May 2024 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715956765;
	bh=3cdbI//fG9tefYk9dE1HYEleskFp8c3t8dyT3UHix8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2tmIfLw5UuLh29Odt878FWDbCbSZLoYg0RSTNlyySrGFGMRApFn8XmrVAGWrWGqX
	 6uAgH/40n+pQ6I0S0BQ4goJkw1YCaEAQSlDW6I3/bCg2FESY4wcHDCA4+kTkiR9aMn
	 RNOM4PhSRClOzhXvWnAEx9y5jq9dY5Q4UPbuQ0Ep1lKFYdVtrmLwLRFr2OAyT9nwT8
	 6fDs55X0g5id9d2OqWU01mjyQLlBbD63wGQxT9TOyZjFKJl6aKqmWUb5Z2vmyE9t83
	 WGEMAT/sfSlBfCsMbzC1ZwnF/a8exox9jhFkMF6BMXrK7afj2F3GCllwhKitgCESYM
	 tA4wEyWfRx+7A==
Date: Fri, 17 May 2024 15:39:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240517-poster-purplish-9b356ce30248@spud>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFsU5jMUN2WDtALy"
Content-Disposition: inline
In-Reply-To: <20240517104226.3395480-1-u-kumar1@ti.com>


--BFsU5jMUN2WDtALy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for TI specific phy header files. This allows for Linux
> kernel files to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.

What's wrong with BSD-2-Clause, why not use that?

--BFsU5jMUN2WDtALy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkdsGAAKCRB4tDGHoIJi
0kciAQDK14E8urYqaI3ZlTzZh6PZzWSnKCy3CCLh+0+DDJIULwEAymLHRIHihVUF
V8M02LksJM6/Ar0BzCk+9r/bSAOmzgE=
=0N2C
-----END PGP SIGNATURE-----

--BFsU5jMUN2WDtALy--

