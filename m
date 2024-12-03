Return-Path: <netdev+bounces-148448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8F9E1AEE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1906CB27733
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B261E04A1;
	Tue,  3 Dec 2024 11:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D01E377C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224814; cv=none; b=TZK7JJUvHKUQMKAmMeYM/fHEh74wzrwFHOO1Csc0beoYKHH2ZtCGOX0zceih+xG0tJNNHa7Vz5GDbpDiitva3jmtR4Y/IlmMCroSwbnSozfe6Zt57wLY6Uj1OSvDnqfBhZMrapUk9jfoyGhjIlq+kVmv2WHDSAl7h2fu5quGBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224814; c=relaxed/simple;
	bh=xxB5eT/PDAcuDICGqGMt8FVxmu5wEVaevgCwd/b2Pzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmx62Rh+xdITEVK6gog9bUDympsxcgUybMr+DUrDVW/4rPbE50Pz1AfuF2cst+hiHejYGmi5jW72AShiA0qi91353rBHAWY3HHxuAjcLOUfqRKTiNbsi7p1EtiyiFPIu+PKSfsHS3KG76i8s+RHGBtuprzFcXz5X5mFvwtGgjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIQwo-00021j-K0; Tue, 03 Dec 2024 12:20:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIQwn-001SwD-04;
	Tue, 03 Dec 2024 12:20:05 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6E4F93847C0;
	Tue, 03 Dec 2024 11:20:05 +0000 (UTC)
Date: Tue, 3 Dec 2024 12:20:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, entwicklung@pengutronix.de, 
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, 
	stephen@networkplumber.org
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
Message-ID: <20241203-calculating-offbeat-cuttlefish-1812c8-mkl@pengutronix.de>
References: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foac5pniaaxhdgcc"
Content-Disposition: inline
In-Reply-To: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--foac5pniaaxhdgcc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
MIME-Version: 1.0

Hello,

can someone take the patch? It still applies to current main.

regards,
Marc

On 01.11.2024 12:50:40, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
>=20
> ip -d link show [dev]
>=20
> The querier state shows the following information for IPv4 and IPv6
> respectively:
>=20
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dc7fa1d9b1fb179375e889ff076a1566ecc997bfc
>=20
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>=20
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pf=
itzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.=
pfitzner@pengutronix.de/
>=20
>  ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..9c01154b 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,66 @@ static void bridge_print_opt(struct link_util *lu, F=
ILE *f, struct rtattr *tb[])
>  			   "mcast_querier %u ",
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
> =20
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER=
_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET,
> +				"mcast_querier_ipv4_addr",
> +				"%s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET6,
> +				"mcast_querier_ipv6_addr",
> +				"%s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
> +
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>  		print_uint(PRINT_ANY,
>  			   "mcast_hash_elasticity",
> --=20
> 2.39.5
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--foac5pniaaxhdgcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdO6WEACgkQKDiiPnot
vG8DCAf/ed94RCRS10AEDTPrgRMXEcjirpCqPGOV1aUU/rdHnYgUDCpRZ0qpAm7W
7Po6EARhzwRE99NVuO50WhP1FVIBh+IVGyU5ekX15rf7cqSHETkIrdwnH+yHwzdd
iSdRbqXzhiK5MZx44igOOQqmOFTT14oP+mkKkKvsp8RMSKvT9kODqcSDn4mjE03U
DvbHqo0L6wlBcBs5fQk8s15I+70I+ZQnN+O7ZVYDwKoznZ/TZ/U5QOQ3FI3guELw
W7GzPybhytsaEXxfcLJCYoLgzZ8Du9XihzfJaUkiphdg8x5au1Eku2GC8hNbhD8O
29YQmlFrsuAWlGCmzBbh+voRDt2lIw==
=UcVC
-----END PGP SIGNATURE-----

--foac5pniaaxhdgcc--

