Return-Path: <netdev+bounces-59968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B868B81CEA8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 20:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2091F23647
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE99E2C1BF;
	Fri, 22 Dec 2023 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="frtpxU/F"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CA2C19C
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1703272125; bh=J3Df0pD2ZAvbq6kJeXxSxrCRuf5Zt4j8HjW7VRjAAyg=; h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject:Reply-To; b=frtpxU/FBEdBI6sJ8ZtsNrl76Lj6yNFS0E3CpGWQ8V7Gs+XRV0vNM7DWC0RKVU8lG+EwT5zcC/nWFSSRZWo596xEyOCilL1M+7qgLPZp3Cvv6JArfsPiEsGdPNZXzSl3vjEinxGkSLGnX1H83FoO6qlT0ugQ2BjLnKohzvVrva4U6Jw+wZoqJAEKqe2iKTkmx8qN7SD6weRrOU3BVmkyMBbg8yHg4Yy3m91+8EJy5Lpc0FwpzUgK3hsvK/zb8zLKFnVPsco25IvbQJTI28yh/Ee9WuTLhfFO2odhKR5VNc+Qr7xpLImvgb0dvB+Liahc1E6Ul3bgJXnnIFqnaYDi7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703272125; bh=ddYn9J+QDRf4NG88vnapauiwEOBZ7BOvNyIgzgFYsal=; h=X-Sonic-MF:Subject:From:Date:To:From:Subject; b=DTi+8XjZjq2W73zTa1FPZGdskfCO4i8pRkwmGG6smApIvDtqdM6HxiuvCyPMMEB8RR3AleYlhEyYLC3+AD+7dUqE15ieiAaIOtMeEbcErZlDSC0FLhzRf4SaKAQEl/N6rfFzrRZFyr8S1L48NkF/gTX2ANcX+SHquCyb2XEUrSz5r+jDAbL/4sdm4jAEE0HiOaxX30dS2gnWJkQpxN3XZtwe0j+hCu5Nl62WwzA9QPMUKSYXGcmvuE9DhiLDkpQdatrLS/BMahFQ1QQUYhWhBinNVeY51qibbQTyiOlh45YBz10TxZ6d3otnLT+xuCqE8qBUDoRfp0WICPASZGiOiQ==
X-YMail-OSG: D30DZzQVM1nBzhkYOJNhE_QGfJkQ36BRg51xZiQAalyBJS6h4snd.V5uLBiJ4OQ
 f4NsBAcrN0U8bzLELSsAi0ydy6Sd3uWuWe5PuZu1odTGnoVSVaIaS975AFjgb6t9oyQaxvfWePdz
 YebZ.yrA2XDssiHUzQHia4UzbihNP1qU64QjVkIO_aiS3uH4.jVB4tf1AjeGu1uAZMxpxTtuVyNK
 JwD1t.ZkQu9WnEzNbv4AFuujtKcSpIF6hWlcmUVEYfB4xUtsknQSckTLn8FCMP6QdEiPCiZwC3VX
 7bCEZatoQS5fTMy2.xOUB9bA1XOHef_DeiZPaeg2NtZqu_.zZywLwk.1Dv_8KVC5KRuvRNRKOkh3
 xFEQ2DzpLc3OBind08JFLRY1JQ3OcKn1B.hGNY80bT98UnyEu4VzqCK3k5rNzL05UrOZTDFcMvON
 LcgUwUDJrGs1h8c277FThO8EC36kwNMDwbDH_L4OpotwJFhHIAi6fZfZXZnqHt5Tp_DWZVX7tNas
 COYbAi0VFJO8SHebueNEWt5i0k.N.QP1imUml.tlEk_SqQK1rXy0peqGB6YbegSSwq1KkbnorcPF
 Td7VgwueaoAdzYeKKz95G1.bhK.FUIPyZxlkmBkoWywkSjOH_4h4bn40c2c3USn0vez1i4.bzhu3
 NMhoeT1IKE4tzLEnjFJJhuEKd.qGVv_MrFROE0PJieKkBMYATfPfAWgwA4lIeayIN1uJgk6s5P.5
 VUCy6PP_CnEvgZAmUMZcbraYCQc80KniXNVB1WO.KTv5ggjhrozDbU.J4dyR42vAnTeD.K3aLE0Z
 narAQQ1IH_Zdi2gPAIp9Gakdeb.e0ON9H.xbDwQqtCoRs8P7VLalpMh3cJ34LNmwXVyywuWXM2vi
 UblzMigr75ggVZN3Fgm6deOT4WCD1SCLLIMbK2Zb6y92pI_YP5HCuDvExHFi2Qnv.4A9UoKhi7Mv
 7nLZyW27_FNlAZizRp1n1vtOJc3y3YYGF96FSlqe4EJXxFA7BDrkwXWRv77nN1IHFALBoLq58mgH
 611f3IONarU9b3HX3cGX3MP_pepPhC1EGSX5cPWEbk6T281j5tzyWWorbJ3iIWuUKc.MgKpPoJtS
 aQ84n8N4joyovR5rHdn_6Gk4NbLTy7DmEu5uLjHTGBdopVqtjO8v7sJBt6.TZpL1zYlV1_M7tGTI
 IHz4BNDIZK7nntk0oM4j48E7cTUqvfUJTZ_6t5jrpf9ysir9zP4___1_6Kse9Gi67JUIYJRS4i3j
 FAuWsE_toPdlvKjnmpaoY38mYGSggwGhI24etpskkK.8TX4tI6S_Lac1rk6vUhL80uy5TDXwCuV4
 C5XDlTdmJtTIdoP2prESMrEjA5k8JWuIuKfb4zFCx7RHeBz9Y5Rd.YgHIdiqIAX8Um4Yj1Ekve7a
 .697uZAVJENgSkig6zhuFqVes28fsGRO3Chwl9B7D0eLoHRFNjL143c6fEe56yZ4ipVrWyDCnR2B
 YAF8AYG_OfmdovhpL.xAmRYduJO3OqbZvgBHowSSyJCp7bbQJ6HsysUcsBTrP.PTZsMZCa1bHyK_
 uBUKHP7BjOJ1pnJ5r103YbTy9ei2Slzx2ATbJ5.AgueIPn3bvZobAY2nNDf486csyOYOMN50rAWD
 7_tRCSqYM_06UEAo4sCj.ojBg8LYh3Y6nvvol77.EFuIJ5_s_MPYO7lEv6C9P4lM6_T9V_QVLwpz
 F1oO3NWZf5ToN1zYddeFir_8hyFCwg2vwMLEe3hFXiP1GqYN8LMX1UEUOTs4FjRohNGfMrDk.nzj
 .prZ1fNv6PyvDfy80tmMV2bTDdkp9zt0aeD4YwXiOtfAnapMJBZpAbkPD5IDrJY0dI4qd0kn6syJ
 sm6uuq4_eiQ6hJwyMWQqUYpI2F4FNJdULSeSe9OZwG_Ci8jQwgKCkX17iqV2pgnxNggDvXKBqoue
 bF6qyBaajdWKlhe8Roo0I1Bi2rudn4iwVarWCyBgWVqL2vSsskA7mZqwxtFvw5EcYBbxzI61P7TK
 hcl5dhvgV4s_jg13dNsjkKyzb7DGmdxiWndLoKCh05dwR6CJ_hyJQBQExETNq0dNDQHrfFyw5J9O
 .8lJSj0ZA6wkwNdji6w1deSV2eX25yzp6QYSyI0A7o9Srhx.czto2fKZJe9.nHmJqInEg1_mB3qZ
 IKKBaApmmyhetfZIx6wuyu_3makOyH8f8XqilLnjyKklC52oEXyS193_G9D12VlXUEXDes8Ujys3
 XbCQ4O_wuzvjMibGGFbab0N21GLSERZPiNnA7TtLijj8-
X-Sonic-MF: <canghousehold@aol.com>
X-Sonic-ID: b0c8fb74-0eca-4c06-9694-d045025708ef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 22 Dec 2023 19:08:45 +0000
Received: by hermes--production-bf1-6745f7c55c-hxbg2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 67958ef5314ee2b111efec7b72844c00;
          Fri, 22 Dec 2023 19:08:39 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE
From: Household Cang <canghousehold@aol.com>
In-Reply-To: <20231222123023.voxoxfcckxsz2vce@skbuf>
Date: Fri, 22 Dec 2023 14:08:38 -0500
Cc: Romain Gantois <romain.gantois@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>,
 Richard Tresidder <rtresidd@electromag.com.au>,
 netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F568DE45-3140-4636-BCA6-24BB7140C6CE@aol.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>
 <20231222123023.voxoxfcckxsz2vce@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)


> On Dec 22, 2023, at 7:30 AM, Vladimir Oltean <olteanv@gmail.com> =
wrote:
>=20
> Is "rx off" actually required, or just "tx off=E2=80=9D?

Before adjusted the ethtool -K, the client upload speed is 880Mbps =
(download speed 0.6Mbps). RK3568 is acting as a router, so client is =
sending to eth1 via DSA user port, rx used here, and then tx on eth0. So =
this might suggest only tx needs to be turned off on eth1.

>=20
> The MT7531BE switch requires transmitted packets to have an additional
> header which indicates what switch port is targeted. So the packet
> structure is not the same as what eth0 transmits.
>=20

I understand. How many bytes are the DSA header for MT, 8 bytes?

> Your GMAC datasheet should explain what packets it is able to offload
> L4 checksumming for, quite plainly. Probably MAC + IP + TCP yes, but
> MAC + MTK DSA + IP + TCP no.

I hardly could find this in the data sheet for RK3568. =46rom the DMA =
mapping, it insinuates a correct ether type needs to be detected after =
the MAC header, besides an inner and an outer VLAN tag, if there are =
any.

>  The driver still declares
> the NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM features because it is able to
> offload checksumming for _some_ packets, but it falls back to the
> software checksum helper for the rest. This includes your MTK DSA =
tagged
> packets.

I guess the end verdict regarding whether the hardware supports checksum =
offloading on DSA frames is a NO. So this is going to use some precious =
CPU power I am looking to fully dedicate to ipsec. Though I am pursuing =
crypto hw offloading at the same time with baylibre.

Lucas.=

