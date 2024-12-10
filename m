Return-Path: <netdev+bounces-150660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB619EB232
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40871889624
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875E1A2642;
	Tue, 10 Dec 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEcoBYha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F21A08A0
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838638; cv=none; b=HB4vEOSWGGMM8C7/0Sp4K9EUd7DpuByA+D/Socn3qyO7h8IKq1MKIofOmnYmy6vIhFd89lv1ZIzKFilJ0hsYv8B77BPxfwwKDK1OYik9yz6Nnym7M6GFqaf6Hb0SktArwX+vzpQTjNI9acjB5m3008ZNR20Rt8NluznbkSiXN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838638; c=relaxed/simple;
	bh=7EU67tCvOJazyKo8mGVkzs9Ka41GIQn66ofZREF/QMA=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=EKVrK6EOfAHMAkAXgqf0zKp1Q8iFxq5XE/aRz24DL7VtzoqrjT814z0lXGOs/WF5gzndXiqPY5Bv2EKjSYWHctc6zF3ZDJZGX7gLdGY1h2upMAmAMvb86biE3vL7FPncqvgZjPNHdAdOIQOgA52NknVKGrZwaPdJW8YHZ/yf+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEcoBYha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C8C4CED6;
	Tue, 10 Dec 2024 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838638;
	bh=7EU67tCvOJazyKo8mGVkzs9Ka41GIQn66ofZREF/QMA=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=YEcoBYharrzNhJ68SwGoj8xr3SH/FzTgdz/1fpVH/19E7eFuA1/cv9qkbCxCP1/6C
	 sQYmulgIkKeuewmO8oVIAwyqQq4xsVm0Yu7CJBfwyUj0K/nqoh9dTbPxcgh+ofTCv/
	 e6w2Sv5gRdsOboU57ITQTrAF0Cn5uabiAiM+FhpgKsoR/qdWWCdkZVCjYotzeGbE5k
	 ex2znWo5sMMgeJW/OyvuFk4Ti75tgBDRNdH8jbFMIaWf0m/BpXbJIbVb9hiM6YKAkD
	 K2LkR9bw0U2KOG+3chUeKVWQQuLHign6qClBLDpo345EnxmVQrNZtsABAoG/uCMSdU
	 J1MTRc+hf1LiA==
Content-Type: multipart/signed;
 boundary=ec7f30d4b36eb363bb3626bfabdd704cec6c3d3467c105c63b08970e9d26;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 10 Dec 2024 14:50:33 +0100
Message-Id: <D682I0FBTZYR.RBPXND1NUZFR@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew@lunn.ch>, "Claudiu Manoil"
 <claudiu.manoil@nxp.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>, "Xiaoliang
 Yang" <xiaoliang.yang_1@nxp.com>, "Yangbo Lu" <yangbo.lu@nxp.com>, "Radu
 Bulie" <radu-andrei.bulie@nxp.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: felix: fix stuck CPU-injected packets
 with short taprio windows
X-Mailer: aerc 0.16.0
References: <20241210132640.3426788-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241210132640.3426788-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

--ec7f30d4b36eb363bb3626bfabdd704cec6c3d3467c105c63b08970e9d26
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Dec 10, 2024 at 2:26 PM CET, Vladimir Oltean wrote:
> With this port schedule:
>
> tc qdisc replace dev $send_if parent root handle 100 taprio \
> 	num_tc 8 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> 	map 0 1 2 3 4 5 6 7 \
> 	base-time 0 cycle-time 10000 \
> 	sched-entry S 01 1250 \
> 	sched-entry S 02 1250 \
> 	sched-entry S 04 1250 \
> 	sched-entry S 08 1250 \
> 	sched-entry S 10 1250 \
> 	sched-entry S 20 1250 \
> 	sched-entry S 40 1250 \
> 	sched-entry S 80 1250 \
> 	flags 2
>
> ptp4l would fail to take TX timestamps of Pdelay_Resp messages like this:
>
> increasing tx_timestamp_timeout may correct this issue, but it is likely =
caused by a driver bug
> ptp4l[4134.168]: port 2: send peer delay response failed
>
> It turns out that the driver can't take their TX timestamps because it
> can't transmit them in the first place. And there's nothing special
> about the Pdelay_Resp packets - they're just regular 68 byte packets.
> But with this taprio configuration, the switch would refuse to send even
> the ETH_ZLEN minimum packet size.
>
> This should have definitely not been the case. When applying the taprio
> config, the driver prints:
>
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 132 octets includ=
ing FCS
>
> and thus, everything under 132 bytes - ETH_FCS_LEN should have been sent
> without problems. Yet it's not.
>
> For the forwarding path, the configuration is fine, yet packets injected
> from Linux get stuck with this schedule no matter what.
>
> The first hint that the static guard bands are the cause of the problem
> is that reverting Michael Walle's commit 297c4de6f780 ("net: dsa: felix:
> re-enable TAS guard band mode") made things work. It must be that the
> guard bands are calculated incorrectly.
>
> I remembered that there is a magic constant in the driver, set to 33 ns
> for no logical reason other than experimentation, which says "never let
> the static guard bands get so large as to leave less than this amount of
> remaining space in the time slot, because the queue system will refuse
> to schedule packets otherwise, and they will get stuck". I had a hunch
> that my previous experimentally-determined value was only good for
> packets coming from the forwarding path, and that the CPU injection path
> needed more.
>
> I came to the new value of 35 ns through binary search, after seeing
> that with 544 ns (the bit time required to send the Pdelay_Resp packet
> at gigabit) it works. Again, this is purely experimental, there's no
> logic and the manual doesn't say anything.
>
> The new driver prints for this schedule look like this:
>
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough f=
or max frame size 1526 at 1000 Mbps, dropping frames over 131 octets includ=
ing FCS
>
> So yes, the maximum MTU is now even smaller by 1 byte than before.
> This is maybe counter-intuitive, but makes more sense with a diagram of
> one time slot.
>
> Before:
>
>  Gate open                                   Gate close
>  |                                                    |
>  v           1250 ns total time slot duration         v
>  <---------------------------------------------------->
>  <----><---------------------------------------------->
>   33 ns            1217 ns static guard band
>   useful
>
>  Gate open                                   Gate close
>  |                                                    |
>  v           1250 ns total time slot duration         v
>  <---------------------------------------------------->
>  <-----><--------------------------------------------->
>   35 ns            1215 ns static guard band
>   useful
>
> The static guard band implemented by this switch hardware directly
> determines the maximum allowable MTU for that traffic class. The larger
> it is, the earlier the switch will stop scheduling frames for
> transmission, because otherwise they might overrun the gate close time
> (and avoiding that is the entire purpose of Michael's patch).
> So, we now have guard bands smaller by 2 ns, thus, in this particular
> case, we lose a byte of the maximum MTU.
>
> Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than M=
TU should send at least one packet")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Makes sense:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--ec7f30d4b36eb363bb3626bfabdd704cec6c3d3467c105c63b08970e9d26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ1hHKhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i2awF/UG4PPPL+YyYoEZbfOUzb41LwgJXzq8h9
xfIIOxF7bDGfRn3iDHxLko0kVbX9CxKaAX9kA69VVmgSYBO5zIR05qXHsWZ30vIj
9rLqJ9HSxefgN0YobYv5fd6VjIXZrCXCWcE=
=r2Gp
-----END PGP SIGNATURE-----

--ec7f30d4b36eb363bb3626bfabdd704cec6c3d3467c105c63b08970e9d26--

