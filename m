Return-Path: <netdev+bounces-267548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMWlAPtLtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:40:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948D28837A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70EBF30156E4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DB13CAE9F;
	Fri, 13 Mar 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7jDdA5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A23C5DBD;
	Fri, 13 Mar 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423606; cv=none; b=FVoBz0XjndkyCSWBE4VRsa4S80FmpJTi4TDFqR1lID4V8Z5JpaDwp+H5wvRZz+JlWx1wMCGfBS3yQj7dGTgV5AZ4snAVwcc+GGVMbaMyfq8TWeoB6LyJeWDJLpatg6jh3wdVuPn+aHnGAmxyvj9httfDbSFz7c419FOe4PQzJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423606; c=relaxed/simple;
	bh=PDjv6lj0xs4XAnUT9GLFnTkZ2gh6Ra2uKalbK9P5GpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItEWncyJf1Jo4yyK5a2FhiPz6hbzG6CzuSrlvDWyV+P9C02GjzJBxOCNSU3g1XygGl0KkRa5/pckcJhxpXrnWwXEIntWztQznUXOhqwYLnQyz6etTuRiePwLU/i1oGhQ+jhBucuBvDtUqvWtuBgBBOzfs8bcKfxmQ/2jRVVmWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7jDdA5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7FEC19421;
	Fri, 13 Mar 2026 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423606;
	bh=PDjv6lj0xs4XAnUT9GLFnTkZ2gh6Ra2uKalbK9P5GpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7jDdA5hNBdPqR6CluugKTJvOAnuiKRttDzV9aIbeiuNP5DlzDXBzKdsTdJi+0UOJ
	 +YSaSYoQudfpgl87Hl6hzQGq+hUuzqE82xnmxpGi6/YF3zd0Ft8RQePkPSOWweGjb/
	 vYKmi1DRJ6IutTjJYn/8Cy8OpE/GA4Ye/H9t6xbBzAycQgr+4HWS/6asI5GPBmgoy0
	 j3OQIJ1MLXpDrNkyVq6GAJIp1aJ0ax4IqRZTI6N+XaikwIW4jfiWAGTKlgTqUPgzJY
	 pzyOlmuEm6Fw6jsnKv6PcNRAaMTNsLBj9t+dnoztdJV/tQHWBoqCrYndLxySPrvYkO
	 AdwLJTL5rNcRg==
Date: Fri, 13 Mar 2026 17:39:58 +0000
From: Conor Dooley <conor@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <20260313-stiffness-item-c451eaef970d@spud>
References: <20260313075234.1567-1-lizhi2@eswincomputing.com>
 <20260313075351.1584-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7F9kwIhbyHy1RjqW"
Content-Disposition: inline
In-Reply-To: <20260313075351.1584-1-lizhi2@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267548-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,eswincomputing.com,einfochips.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,nxp.com:url]
X-Rspamd-Queue-Id: 7948D28837A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7F9kwIhbyHy1RjqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 03:53:51PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
>=20
> Due to chip backend reasons, there is already an approximately 4-5 ns
> skew between the RX clock and data of the eth1 MAC controller inside
> the silicon.
>=20
> For 1000M, the RX clock must be inverted since it is not possible to
> meet the RGMII timing requirements using only rx-internal-delay-ps on
> the MAC together with the standard 2 ns delay on the PHY. Therefore,
> even on a properly designed board, eth1 still requires RX clock
> inversion.
>=20
> This behaviour effectively breaks the RGMII timing assumptions at the
> SoC level.
>=20
> For the TX path of eth1, there is also a skew between the TX clock
> and data on the MAC controller inside the silicon. This skew happens
> to be approximately 2 ns. Therefore, it can be considered that the
> 2 ns delay of TX is provided by the MAC, so the TX is compliant with
> the RGMII standard.
>=20
> For 10/100 operation, the approximately 4-5 ns skew in the chip does
> not break the standard. The RGMII timing table (Section 3.3) specifies
> that for 10/100 operation the maximum value is unspecified:
> https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processor=
s/20655/1/RGMIIv2_0_final_hp.pdf
>=20
> Due to the eth1 silicon behavior described above, a new compatible
> string "eswin,eic7700-qos-eth-clk-inversion" is added to the device
> tree. This allows the driver to handle the differences between eth1
> and eth0 through dedicated logic.
>=20
> The rx-internal-delay-ps and tx-internal-delay-ps properties now use
> minimum and maximum constraints to reflect the actual hardware delay
> range (0-2540 ps) applied in 20 ps steps. This relaxes the binding
> validation compared to the previous enum-based definition and avoids
> regressions for existing DTBs while keeping the same hardware limits.
>=20
> Treat the RX/TX internal delay properties as optional, board-specific
> tuning knobs and remove them from the example to avoid encouraging
> their use.
>=20
> In addition, the binding now includes additional background information
> about the HSP CSR registers accessed by the MAC. The TXD and RXD delay
> control registers are included so the driver can explicitly clear any
> residual configuration left by the bootloader.
>=20
> Background reference for the High-Speed Subsystem and HSP CSR block is
> available in Chapter 10 ("High-Speed Interface") of the EIC7700X SoC
> Technical Reference Manual, Part 4
> (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf):
> https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual=
/releases
>=20
> There are currently no in-tree users of the EIC7700 Ethernet driver, so
> these changes are safe.
>=20
> Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 =
SoC")
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>

Krzysztof might not yet be happy with the compatible naming, but from my
pov:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--7F9kwIhbyHy1RjqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabRL7gAKCRB4tDGHoIJi
0qJLAP0c1yh00ld+1PBzXG2QWRzTWLz4Bu2S3D1IL4VcXwRdmAD8D13YNNMzL8Jb
WJXhFrH1ZO+pCsRM64k+gar0NbK4lwc=
=pXlI
-----END PGP SIGNATURE-----

--7F9kwIhbyHy1RjqW--

