Return-Path: <netdev+bounces-171938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B07A4F882
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB701890FB2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3FC1EDA0C;
	Wed,  5 Mar 2025 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXiwMTb1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFY0t7ax"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699470824
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162615; cv=none; b=nAVN6srPq79c8jmrHEI0tsBhEGcS+HuYtsMHNhhkw7H9n+LwXsHS1QT2dwwX+5z7YBDLpobpGpA2q2GdUUUS1ho28nQxy5iS8YsqzTA1Yk/A6AJPyeg0oBv673R+6pND5h+z/DgT5Wo2ezqbCR3b2CZdhPI5eZATUqD3Rcg0dOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162615; c=relaxed/simple;
	bh=QStBYi6pwdK1Tb36EYQktQO0A7l90MX13f4+gcwwHC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxnuvh91mDSLlFFtfknbcM6mhJ5GIk1GIYhJ5gQKaR03eTT9UgrOrBSUGKFwnmqPe6/sWa6HyDXuzyWdteh7BwZDyuzRUvjquBDQasu2/cr8wHaj0vQfM4ap4cC+Gq+s+rTKG0FKnDGSi5RG23fYoUVvgasrQflOii9WfqK1SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qXiwMTb1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFY0t7ax; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741162611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QStBYi6pwdK1Tb36EYQktQO0A7l90MX13f4+gcwwHC8=;
	b=qXiwMTb1GNumeIUzRqx7+OwDkD+b1GgnGhUIlZGRC5DgMHDFDl3c9cTbK4jSN4r81FWk4i
	G2T9zI6vBanbigSyO2u0ijZyjaCbnx3A03IhtrHoBz4LED7Gx0oNh7phUS/7XTMWMXX+UU
	oK7quyWPTZs0mXbPH78+jar1y7mKQ+RcEtULNaFdMsUzTt7IO8oc1otyrYSR3lD5F0R84J
	9EMGCvQbb75jfTAcbcdDoHyAlT06tYBIjDW0/kHfGqcLPY9CYtw2D0Ehvv6cW+csUk0XfV
	KE3y8PZWWuNkbUrY1tQNB/GGuz8w1i0Rd/Llep4B+172MF7+6w3fQkaJBi9uZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741162611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QStBYi6pwdK1Tb36EYQktQO0A7l90MX13f4+gcwwHC8=;
	b=cFY0t7axV2rn/eAyp6C+uQFaHl5YntHsUQ3zTHHndsc8Rk33kBq3Bwemz8Mwve522oWwnK
	Ul8Hd7CgDpJftGDw==
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
In-Reply-To: <20250304173021.GH3666230@kernel.org>
References: <20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de>
 <20250304173021.GH3666230@kernel.org>
Date: Wed, 05 Mar 2025 09:16:50 +0100
Message-ID: <87a59zc2od.fsf@kurt.kurt.home>
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

On Tue Mar 04 2025, Simon Horman wrote:
> On Mon, Mar 03, 2025 at 10:16:33AM +0100, Kurt Kanzenbach wrote:
>> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
>> this mode the hardware uses four packet buffers and considers queue
>> priorities.
>>=20
>> In order to harmonize the TAPRIO implementation with MQPRIO, switch to t=
he
>> regular TSN Tx mode. This mode also uses four packet buffers and conside=
rs
>> queue priorities. In addition to the legacy mode, transmission is always
>> coupled to Qbv. The driver already has mechanisms to use a dummy schedule
>> of 1 second with all gates open for ETF. Simply use this for MQPRIO too.
>>=20
>> This reduces code and makes it easier to add support for frame preemption
>> later.
>>=20
>> While at it limit the netdev_tc calls to MQPRIO only.
>
> Hi Kurt,
>
> Can this part be broken out into a separate patch?
> It seems so to me, but perhaps I'm missing something.
>
> The reason that I ask is that this appears to be a good portion of the
> change, and doing so would make the code changes for main part of the
> patch, as per the description prior to the line above, clearer IMHO.

Sure, i think it can be broken out into a dedicated patch. I'll see what
I can come up with.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmfICHITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgn/RD/9KB1zcoSwrPck4K0Si/VAbhwwAmN0j
gf8SCmqPhp7HID5y+ECXInVfcSGXPXJ+95XTrY0IbP5UcAEhrr72Qu2EVfFqsiJb
dBhfvwSUDh1e1oDNvjsBg8+2AnQXQzZe0JWH94GBIsH0EDVEx1OnrJffvHkjeocm
L8/h43WlDBGMY9fgtB6O4oqkzb19eGnoyfhloMufpOZEms5DHa4Tf/nshZE+K1Vf
DCnazJd+af1dCKSM2gRXhcjD7eiLcPt3v4M0N6veKyDWCt+qPcV7u3eSIprEQ815
IrigR1RH+LhqAnYKfwULRnvlDc4a/JCNlMhLxvoOwRj1vwpwiTWTs+EIHBXWijCr
T/7P2G2sVvO0khkjTkIfd6JDxE9H+0W/PBfsMwx2R4ap3jjooP7YDze7GPlkk3G0
AHMfOcuc1rMjuas1VaITz1VdKYCqhCRkQ7rH6NaoFT6e+w3I49vdmw7PpjS2KirE
NGaw8DzVDPSEnuDWlDdCIuLOdexWa3QxSxYAMJb9F5mKK/eo1sPO7TR6ExrzPxTz
0+uxJSBfYzcc+pdDvNRXPifjqdGX+qMW6dWysDIOOiv3Y733HrpErKMUbebhF7pE
pNQqGjIXDe4rLjd7D0yXU41ueBAH5gmnvyR1nVRd7eeOYE/4XkCqhz/dgiPyIAk/
WzqHNTTsjjuxvw==
=ES86
-----END PGP SIGNATURE-----
--=-=-=--

