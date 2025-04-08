Return-Path: <netdev+bounces-180197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E87A804C8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DB1895693
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C526982F;
	Tue,  8 Apr 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLfZEsyz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URE34VJW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F011AAA0F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113868; cv=none; b=GIvQ2fSmfttNcqzXnoU2kIIE8dsasha/fIQzHK+NSxC3oo2cN2GrNjA1bEbYrLIOIxqG44ZanVWf8EUnOEmjK0hrrokwMMdwk6pYKxxFFrd+SI1Oxk8/BjRJ8J3mfU4c0dkGGeysSEyDLP4fcS3Q45jz7MuO3mxWSrEp2ZnBBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113868; c=relaxed/simple;
	bh=VJ2KHIqduJVeD2yn5RmypYFPNq7nH2d/R/Js1HXgqrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCKT1nYkxoowjL7fbBYDuRfJdOUCkDa1TOILsCYDSp7iMpTbBV4H25uQBsV9jhAJjIsV74BoNk4zqJITbv2CwFI8ABhCHltJC7hQDBZqCNXi+z10YeriDG5FE845JBzx9Oea6+s9PtVe5xcZVzZkn12OZZbxNdXwieOvwTJrnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLfZEsyz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=URE34VJW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744113863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUIhkfxLW/XlWJKlZW3tDkzpsaxUijtWfsWVavFzJgw=;
	b=nLfZEsyzOb7FAC+IqSA4Wr0ondG7gmYFnOdVjb7JQpjiL2O4Tc6ANK/vKP6KDHQ3rFyR/Y
	p8tsA4pWgz7OlUM7kgfeCV7Q908QiV3XOf5oy9vLv7nmEbfRn59eUdWiwxXizoj6iJMyvu
	2WUhcxtZmfBeVczk/t5SmsmIkcqBWrSf+MchOE29b38d3DY/rcqqz09AF28naqG+L4OMGB
	i1JABEXvLZtwiD1Io5z0mBvEPg2+9fz1OlZS/bu6+j4QyEG7AFntUFrC/r0bpzwB7V9CDV
	RBVFDB5BrF8L+yovCQwcdUu6Ru4qSt6nzzlhOgtp0SlwfjBx1oqrch71nb96+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744113863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUIhkfxLW/XlWJKlZW3tDkzpsaxUijtWfsWVavFzJgw=;
	b=URE34VJWFHwTsxTG+5n7ywKdsXUjc1UCcHYYmQqbHICpTZZWbl0SrxNZjQyWvxgKPCyZJm
	qTks3sMk2aL1R3BQ==
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 1/2] igc: Limit netdev_tc calls to MQPRIO
In-Reply-To: <20250407124741.GJ395307@horms.kernel.org>
References: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
 <20250321-igc_mqprio_tx_mode-v4-1-4571abb6714e@linutronix.de>
 <20250407124741.GJ395307@horms.kernel.org>
Date: Tue, 08 Apr 2025 14:04:21 +0200
Message-ID: <87mscqsvui.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon Apr 07 2025, Simon Horman wrote:
> On Fri, Mar 21, 2025 at 02:52:38PM +0100, Kurt Kanzenbach wrote:
>> Limit netdev_tc calls to MQPRIO. Currently these calls are made in
>> igc_tsn_enable_offload() and igc_tsn_disable_offload() which are used by
>> TAPRIO and ETF as well. However, these are only required for MQPRIO.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>
> Hi Kurt,
>
> Thanks for the update. And I apologise that I now have question.
>
> I see that:
>
> * This patch moves logic from igc_tsn_disable_offload()
>   and igc_tsn_enable_offload() to igc_tsn_enable_mqprio().
>
> * That both igc_tsn_disable_offload() and igc_tsn_enable_offload()
>   are only called from igc_tsn_reset().
>
> * And that based on the description, this looks good for the case
>   where igc_tsn_reset() is called from igc_tsn_offload_apply().
>   This is because igc_tsn_offload_apply() is called from
>   igc_tsn_enable_mqprio().
>
> All good so far.
>
> But my question is about the case where igc_tsn_reset() is called from
> igc_reset(). Does the logic previously present in igc_tsn_enable_offload()
> and igc_tsn_disable_offload() need to run in that case?

This patch moves the netdev_tc calls only. These do not have to run in
this case. The hardware configuration is still applied in
igc_tsn_enable_offload() and igc_tsn_disable_offload().

Thanks,
Kurt

> And, if so, how is that handled?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmf1EMUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgn55EAClsf1y2fAQh+R9zer0mAjHGDqIJB/I
yByUgRD3zZ4pqHAF5SCwhc46V5PNautDo0OD8YhXrsDFXloNu8TXo15NzzckxFQh
gB8M/oNhdVOWlvfTkDRCe/6GJRvsQa+aQZwQGLW38bLzU1+4KX770p/xHJqHj1B8
o//TTsUJuS6UrPj2Y3yR1dNt9fPMEpeAJZyiXekX9bNyvA4gbsu5MLm+/dd8uhKX
1w+L2nnAX6r5i4E+MfpiQnfyovxZWQPepqeCpQPGfsBQuI9XDquSe2qb/hnYmth5
tWzWnKgSumcp+OumNEv5Fe8VSrsazy1TM8FcBMX+RTNO3JZXDRi6ZO8WjZ/kOT5c
Nl9FOWFYmd8EQPjAT8JPPYmopbRCy/P4WrEueMhehKblq89pJYLJs1WwNRlfGe5z
WJA/lj5e4RtVVqhxgPB6ohn9z3dl7PMomKYUrIOEq8hMjyraI5xaZJLZ82nJ5TXv
0JnEHiuEJqvU8w1eg/IsJdhsxPOx1OwjYx5pUwSopW8Iy+aLtqEt/pSJfFcoqnHF
b7KRkG/aHjTEJsSWDSPJj+GaFZt+LQYPDairp1kaJqpKCt1F7G3VqrjRN9q5xnmc
hOnZGt9Ly6ytXqRURhuS11HR0gAyYXuh9Dv7xig6zBG0tWaoO5A4PiUs57huZf23
w4X2PdPIA/kWlg==
=miv5
-----END PGP SIGNATURE-----
--=-=-=--

