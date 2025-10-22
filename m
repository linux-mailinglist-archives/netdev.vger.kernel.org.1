Return-Path: <netdev+bounces-231599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B241BFB2D4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6728118C6F97
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B9288C2B;
	Wed, 22 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ohsb2QDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EB78F4A;
	Wed, 22 Oct 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125718; cv=none; b=a8sVhMz2vV4mjJMHH1DgNvb3T9lyvhWWqbZCETS+/HplP9ahGj6SmyNLbwwsrOlpVIJEZ6JaAACNOKsH8KRkmPNgOyztB7LJgemW9OJAGjnShdNA43Letcy12f6pQbEnY9fS7YBxvRb961hColYY9WwsY6aALa+GBoYsLay//pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125718; c=relaxed/simple;
	bh=gAGTYlrv3peCnoKoKyQkmGHD1Y4H6wFcmuTQ2CtK1KI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=VMHxuZIfcfOEUlMlABm27PyWJCZQ6kAmsVQolBsvja/fcbBRvn1ZeJxb+1zttSNUL/BugchuuF3qqhlFGuXkVkHRQin4zMZ4eOVghbF+Yalwrthz5J7S+u9rGQu8H1xNBTDrTv9+q9bB0iXPRcg7d0V68Mcumvz5Vy9oNb3qdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ohsb2QDS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 596241A15CD;
	Wed, 22 Oct 2025 09:35:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22C3A606DC;
	Wed, 22 Oct 2025 09:35:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7FC6102F2393;
	Wed, 22 Oct 2025 11:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761125713; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iz18myQGlANOuMjPJ93wuoMnm9zIKbiW/Ro470MHKvE=;
	b=ohsb2QDSPfs68sPgSK2YMtGS8IvoAEsRIv4REzPmbXPUXtc0jPxe8nr75Fh02JiwuJ8x1V
	OQu1/vlIuZVkIhQ6DaBvDZAwcF/wX4TDHBKb9bU66DqXHErrKbzATmZvSmpl2Qt+r0Trei
	4v7/5VE+WKT5OboQRk0j9Ub4LFvtEsRMI+sONPyEd3j89LDTb+ZYIoK1UdeNkw/hSJasey
	7ydYsRI5iMhGIirptX1UerdCzV7CGtIRR1LAhe/K27BcASQ5yBEywY9tEbi1xlTRJ8vIp2
	EKnSspugCXbLgk5cXcfV+1AGW5OdAIxtc9PoLaskPBnlnGH1Yc9MAOvxpNTDYg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 11:34:59 +0200
Message-Id: <DDOQYH87ZV1H.1QZH1R36WMIC6@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Russell King" <linux@armlinux.org.uk>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
 <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
In-Reply-To: <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Oct 22, 2025 at 10:09 AM CEST, Maxime Chevallier wrote:
> On 22/10/2025 09:38, Th=C3=A9o Lebrun wrote:
>> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
>> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
>> that must grab a generic PHY and initialise it.
>>=20
>> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
>> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
>> the first users of bp->phy that use it in non-SGMII cases.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> This seems good to me. I was worried that introducing the unconditionnal
> call to phy_set_mode_ext() could trigger spurious errors should the
> generic PHY driver not support the requested interface, but AFAICT
> there's only the zynqmp in-tree that use the 'phys' property with macb,
> and the associated generic PHY driver (drivers/phy/phy-zynqmp.c) doesn't
> implement a .set_mode, so that looks safe.
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Ah, good catch. I checked that both !phy || !phy->ops->set_mode lead to
return 0, but I hadn't checked if other PHY drivers could have a
.set_mode() implementation that failed on this new call.

Compatibles that might read a "phys" DT property:
 - cdns,zynqmp-gem =3D> no DT upstream
 - microchip,mpfs-macb =3D> no DT upstream
 - xlnx,versal-gem =3D> xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
 - xlnx,zynqmp-gem =3D> xilinx/zynqmp.dtsi, &gem0..3, PHY attached in
   xilinx/zynqmp-sck-kr-g-rev*.dtso. PHY provider is &psgtr,
   "xlnx,zynqmp-psgtr-v1.1", drivers/phy/xilinx/phy-zynqmp.c

So as you pointed out, only xilinx/phy-zynqmp.c is used according to
upstream DTs. I also checked lkml, no patches adding a .set_mode().
We shouldn't be breaking upstream DTs with the current patch.

Thanks for the review Maxime,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


