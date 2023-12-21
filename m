Return-Path: <netdev+bounces-59479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D181AFB1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C28E288269
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE015AC3;
	Thu, 21 Dec 2023 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="P89LqL97"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-8.consmr.mail.gq1.yahoo.com (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E0156D4
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1703144440; bh=mg05y36DE7RxqcYS0Yg08PxNcX+uHQSyP8myVr6Z9SY=; h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject:Reply-To; b=P89LqL97iPvqOEygAP8jIsPZdMngoRwqUSc4npUBOQFiFGY3luRHEQLl7zdnk60r5eiAkuJ65HxLHV/QvjEjzQiKQ3YR09pxtJzu0S/SqVe62irq8ZQYCFWqnznCIJuUPA1X+4c35mBE8sCvrAETDIYEshAq+q3UkeUvmkOUuIKM7vVpiTP1C9SVA8OWKyjgZgkWzy/+rHCjt76FtOm1i1AKH1GtDhWYEiA5eSKc1fa46ZFd8ZYJHXC3xFw3LCwVEYeMxOhU+v5ut9eKZ7pvG05vPj2k+oidC2oCvz0s0gy4DaoPWs3UHiffdb1IXGSIHk6/rP7e6hpFP0/Ys+UMaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703144440; bh=bn6pI1tRgeo5pd9kjkdssNA1BveJ0C1MagLRtvwF3nw=; h=X-Sonic-MF:Subject:From:Date:To:From:Subject; b=It7cosj99/AVXTgXJhVRhXu147j60qbQD5XJY8Nvh6G+KfcRpgxmKIEtv7ECwUMiAHQTU+/f1jBvIppa9R6YbvRRN9mOo+4FQux/JbnxtajMtfYc9/zLarYVmGTWkqK2DV2t08v7p0+LI/w8qntcq28Yd8BxMbDGvQGRxFE+ntMLYE7h0P9RKJkrRjp62zxiciqdlOUPFZIIVbC0RK72cu84YGbcD0j5oA4P9Pd6EeoNB+UqJcd0IHJY9q4VUmk/3Yd2qVLZ2Ug+xlfvjKMVGBfORJTkj86rA1q6zu4MPGt1PXFl1Gavc2oQohIKqu1xTICEkuOSMBjcHIcxeIHsSA==
X-YMail-OSG: PAG3T28VM1nGfuDPV9.TECwvTjInXgMvQwaCMPmPJ6iCva9T.Qf6FVuEwvGMZlO
 1LKiVvCM0cFMgG6DpWTcDDwIwiL9n4Tjpa._Y_ThBXIaSY0NiVa12eObw.QLfjgSiq06lKsX6KNi
 maaeiGMStPqcCHcQddh4gQjOWoetAPU_sWocQBtnkLVkHgqs5Z94MuCqqBENEgF4TInKuOLFrEVl
 rPPPoL70dwUg_b_.PkKgFOi4iuzv__AfdpXJx_lopJSgqCGYJ.7SQVE3BOH9EtHKY1YS3fNSlKOZ
 hHZ9pQ9LCM_fxzEMYPNF8ZUdiLzohzy08SP09C3TXcCndhaPj3TLlEZAVJwF711gcWV1ODUzl3Nt
 vqbPw_2KDfGqyqX7IOkMvIaymI7lwv2ratRaM.98.DUqqXpJdApQUHPVVu.wPXyU4D6HG1YeoIJO
 6WNygVkskfCLdIhtljBwtObCNvdFJTCCitTZN7YXj0ebaI_5tMsvVYljObgmGv19.Y3yTbMBWBM9
 qjsddAZEQLLYc8p_v8J4lLuMzev8C8sWhyW6nmNGmOuDSc9KV23UbH.hh8ojlGapl5xmKdIF.t51
 Zat_pTSV1F8xUD7rZQk1hYz.s34Lew0zQq0B_9r5DSdBkuk7bLRINtZMgGjFP5yEUfXyUM5cdH7D
 7xIHIafIxwxwZZLmLArt3OvugYHs390oTJHkTK2Vrqqg_52F6f7pLlNnAEK.mOm0NS8RoGq5L56A
 .ApNen.PanGlzxMt266bki4ehmX1PdYkwdi4irJA62Op2SVpkKvNg2Gb2ca2kuloxqRyTQ2ikBtL
 2PqYA3iPYhUDl1GbH.2ooohO81oPedsFIHfJmAGqzJqifi5MXT2z6NRnJXaI1mo0074lvb3LBtQi
 Ymjh6rxUDSUv0yWzOjjhYgftNUNjwmarxw_0KQf312rs42WwP5l3qgWKZiUK50_btIGblokF_K1g
 abxK9Ye52MChv8i_o5oMpeQckiuWh.1gWGOHlJDFNewOzX8hO.fRTq1TA4U8hvLjuESFUG3JCoJ_
 CeowDJOGOz1oVp3Fwy4yvW.08p9uOCllPU6YJV1kcwsbIlFwfBSWa.kbSO5s3mcOhnmwLXUuHfsL
 nIsDs6yT7zFObHsKa5fdYmRZQH3QeWPd3UucXC8lVRkSQGdrP7RF0SAlaCV273JBGPWDyLgPuHXy
 cdVZD.vIm_7MQB8E3oHKXRW7ZrtvSxK33sjtJTY5.wdyjUD0vjpuxPjbNZrzwbBrRgUgvj.dvkQR
 RYnwNi4_YXGgqI8cPxjObzyC0X7irgVp.627SX6ur_.IuMmr7vtyYslKak0RIZcl03STKKl2W_BX
 u0KQGXNnSnaEI_xLGQIbnPud3Iyu_qx_qvmAM46.EAaWoeQgwioqOBzP5ZPmtEw4SlxITEANTpgy
 p4j8xbLseErASQV.Y7Cjs21lNtDe5o9nXskmdUTfwIb.4kqmv8G5GNQDgA.GmxooXSpIKzNOzWYs
 qdNTKL2aWTEAtsePcme6OSw1BbE5IHnfj51jRfL0BIQYjBFuqI92XawWuJ2XlbBT0q1Cxk6zf77O
 tuS5Zv5bzttZPzasW7WJ5YpSiBNa0_5_FKXN7Znnavcni0ERXlJ0pLTDxn9IapPFkow2wFZE8tEA
 YY.VIRaAolSK4qQJQp8PMb6y7YKpuF0_ZdNbsxnSX51AypLLD.RSMXX36CL3ufVWMQYiPrrilf_M
 McuF8mXKzQ2Z1fFS0sH5TOhrvWXEPDd8T7mdZYUVCy6Lo_OwIQFXJOFXYRv8P4.alp531gAO9LjD
 LCenYdGhB8ZQYx7KNEx6.RL0I6z5WRhOBxHX9A8g9LbeqSY3nRErv.h30Wh4Hfk9mcxm8RlIrwnr
 KTKzwgYOjOeVHHjZ9.9I9ew20FlZyWT4Mwx3jKf0I4eBYvw.x.1UY9V_KMuQ3CMWovvZHx6ykSjQ
 i1xnpfibWjkrjleteksmdWBumA3M9bRuzn6R7lc.Znt7eW0T8mdg7Gdw6ezJEWqG8NshDf3xkGe9
 ypJV09J5wM5U34SvPUL1XFrBzoR__JuAMS.o1F_2HcqOE50RToEUo6x0Jnd0AH_XswN3fV4VBpOn
 sCPs5wssfw_ozaD0DMTKhj7uw2DaN9mCGvoCPEfHavWbqFsFUt80I80Hb3wUP.wOZVq.sP_G3r0o
 8YnUxTAtLWoRDKs5D9ggAI_NB.j6wqqiI5xRtloQlk7tbP_Oulq7oIuAd3hgRYPnrOCX_y2GUUth
 XrAs0MsKHUHEkEepsxkgDBTzspTeOnCCC7jb1nSI-
X-Sonic-MF: <canghousehold@aol.com>
X-Sonic-ID: 74a468d9-748d-4e1e-91f8-922279871ff2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 Dec 2023 07:40:40 +0000
Received: by hermes--production-bf1-6745f7c55c-6hpmf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8eb59427d9a6f70ecffbb8b97d4ba1ed;
          Thu, 21 Dec 2023 07:40:36 +0000 (UTC)
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
In-Reply-To: <20231218162326.173127-1-romain.gantois@bootlin.com>
Date: Thu, 21 Dec 2023 02:40:34 -0500
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
Message-Id: <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
To: Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)



> On Dec 18, 2023, at 11:23 AM, Romain Gantois =
<romain.gantois@bootlin.com> wrote:
>=20
> This is a bugfix for an issue that was recently brought up in two
> reports:
>=20
> =
https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootli=
n.com/
> =
https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electr=
omag.com.au/
>=20
Add me in to be the 3rd report...
RK3568 GMAC0 (eth1) to MT7531BE (CPU port)
Current workaround for me is ethtool -K eth1 rx off tx off

=
https://lore.kernel.org/netdev/m3clft2k7umjtny546ot3ayebattksibty3yyttpffv=
dixl65p@7dpqsr5nisbk/T/#t

Question on the patch to be built: how would I know if my setup could =
take advantage of the HW checksum offload? RK3658=E2=80=99s eth0 on =
stmmac is doing fine, and eth0 is not on a DSA switch. Does this mean =
eth1 should be able to do hw checksum offload once the stmmac driver is =
fixed?
=E2=80=94Lucas=

