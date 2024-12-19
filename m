Return-Path: <netdev+bounces-153521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1D9F87D0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE8F1897CBD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BE1C2439;
	Thu, 19 Dec 2024 22:25:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EF1A0BE1;
	Thu, 19 Dec 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647129; cv=none; b=VXKLtuabNFTqZVtyI7mDVg07273k5D32vmRmVOSF+oF30loOyjH3nTWaAjYJL+/epbsrjbaZpDNL7y2KgDIWkfnsXv5QevHMiDPO6QzvobdpJsVR78z0aiybovF8mEE/3vaqwvhYcQd8IXYFhjCRCZeW84AWAL7vyfTAAJntQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647129; c=relaxed/simple;
	bh=pAvKmAkWFIS656AUQXsSeFsvmDHmu2n3Ou19Cqpo95A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4Ngw15TPf5UbUyN+MAtYKE1NhQKXWDy1XM7UVRFOjHU2wgIiLfn5DspmLTDR/GBrWM7ZTesvBnZu/FZ9mKOJ1jKz4Qa15zYXKy3qqFxiy0EUpQiwZIEbuHxjLEUzwUzzUvj8oIleas1+Ex02q1vrfrPOX1tjPyPdmnW9KNOW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tOOdj-00BsdK-1O;
	Thu, 19 Dec 2024 22:05:03 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tOOdh-00000000gFz-3pLM;
	Thu, 19 Dec 2024 23:05:01 +0100
Message-ID: <d36de97f4a1ff574b8ac1f530af550fab5331480.camel@decadent.org.uk>
Subject: Re: cpu_rmap maps CPUs to wrong interrupts after reprogramming
 affinities
From: Ben Hutchings <ben@decadent.org.uk>
To: Caleb Sander <csander@purestorage.com>, David Miller
 <davem@davemloft.net>,  Tom Herbert <therbert@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Eli Cohen <elic@nvidia.com>,  Jakub Kicinski	
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni	
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Thu, 19 Dec 2024 23:04:55 +0100
In-Reply-To: <CADUfDZpUFmBCJPX+u3GYeyFUbQ3RgqevvCpL=ZE48E4_p_BpPA@mail.gmail.com>
References: 
	<CADUfDZpUFmBCJPX+u3GYeyFUbQ3RgqevvCpL=ZE48E4_p_BpPA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-w2NzAwitRBWlthnpcIkP"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-w2NzAwitRBWlthnpcIkP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 10:18 -0800, Caleb Sander wrote:
> Hi netdev,
> While testing ARFS, we found set_rps_cpu() was calling
> ndo_rx_flow_steer() with an RX queue that was not affinitized to the
> desired CPU. The issue occurred only after modifying interrupt
> affinities. It looks to be a bug in cpu_rmap, where cpu_rmap_update()
> can leave CPUs mapped to interrupts which are no longer the most
> closely affinitized to them.
>=20
> Here is the simplest scenario:
> 1. A network device has 2 IRQs, 1 and 2. Initially only CPU A is
> available to process the network device. So both IRQs 1 and 2 are
> affinitized to CPU A.
[...]

This seems like a misconfiguration: there shouldn't be more RX queues
than CPUs to handle them.  I probably never considered it when
implementing cpu_rmap.  Still, I agree that this could happen as a
transitory state, and the reverse-map ought to become sensible once all
the RX queues are assigned to different CPUs.

But I haven't looked at that code for over a decade, so I'm probably
not the right person to address this now.

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.


--=-w2NzAwitRBWlthnpcIkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmdkmIcACgkQ57/I7JWG
EQk+Zg//ZFJXVWaLqCDW7/+lt7v2aOSs+kr97uAzw6Gmw8nGoJC7FNHGHrYruaan
sslpueEsr8Hpz3gt2WjzfcnHQYGP2ALSShrYTXxKC8jl3Tb8yluJ+KczS8dfUJ+O
/6pP6L8kznNNNOwpAKay1VMP9VV4VJOcSoG+D1A/MvJ5r/DePwSpw+QOapZjoUSM
3wrNjXe6KbmEZ2O1JOKXNB8sp5tImctA8ePQPpE2Mp0KF1GiXHqOMi5r8GTLArer
evXhksY7RFrjBTMylyKgdL/MfDKx9eBuBlJmhhoRRPx3B1SARxO3tWBvj6XE/RIk
kO9y9n269E5YeI9H0q4AaKit2jBnygGnTpslOetjxNqP8zRD/gggi0UnKWZ0D/zS
WssUUv/jtCmoe5e8Y8nMnf9kdaqIKWzRxnicttPhmr6DgxDHD8DaRPNugJFQKJLK
dTTQ0xB8SKEWHL9XMih3Q/3tPbmr1jRO+objfQz+mrNWw3BjgG30SXwK4ddgLWlv
5aAlYbsp+a15pKJoFXnH9/n29mA1wBv+slCSul7r0sGRJempEHKIx5pBD4UgiFn1
FXNzwVASJ+S2Py1eUYuhSOioqp7lXxBkJx//8SGlODKbQOTFNThbkcDt8AV1oxSM
Kie56nP7VR9tf9v2kmR7q6DQVJs/FfqP4zadAPt4PgAYdMFUJV8=
=A5qp
-----END PGP SIGNATURE-----

--=-w2NzAwitRBWlthnpcIkP--

