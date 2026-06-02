Return-Path: <netdev+bounces-294200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e2GEOY/NHmo7VQAAu9opvQ
	(envelope-from <netdev+bounces-294200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9B62E0C2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:33:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=EoKBzTrJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294200-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294200-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FACC300EC6C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1D3DC4B7;
	Tue,  2 Jun 2026 12:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32439891F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:29:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403400; cv=none; b=UHXI+Ta2XhsmppT7h0dgsavk0RBOsdIxBkdfUUVbbfSTld0+IrkPOQm9eF2bdjSqAAqLSu7NIEuecoFz8YmI8DAccPkeVcKSXZJ35fsC5aAey3WHFH+FaeGb1sUbBlpKFuhUxPhdqEmtc0PvLyjRVaZYzDCK3QuG+yEWyJjXm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403400; c=relaxed/simple;
	bh=H8ir0Lxk5PBrwKUGjcjSDIVegghpPJpmeF4xxUmg4U4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBdm2u5BIu5DagG5KtFSYXi045CINbViiGR8n90nyoR8IQjR1F4xSZ5+wfE+nR9kul97C2jAE6P2oSasVfX+2+MKwbsweTpVoHFLTR+Wyyn/AvSjyRvE/gNxu2Fl718WEqdSP/XnvNaWRX1mF+1wGNFkJ0BGErgnzmhv81Jt9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=EoKBzTrJ; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780403371; x=1781008171;
	i=markus.stockhausen@gmx.de;
	bh=KaA3Pmo0Ucpag/EYG6vIzPw+u5awRqWpSRCa5lOI03E=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EoKBzTrJR71Z/89VlCA2qs4i0jJZerrlGIkL5lofOhSacTy99DQ0XwVXUJty/7Qy
	 AwE9hCDJlTL+SXn18z01eT6b3Jyi4Ha+SUF1oVquqvJKWoh0YsKJG+949pf79pT2H
	 EQ3bkTBvPAJMiBiM66ksHHEU3p4XyaYg5pL3ZOV3tlBusRPpuLCJO6+qMY/wPUutW
	 sSPajxaC2YJBzIEhZNxCARzyWsYzhspbbYdHy82lXeo5UYcJR6QTRk1tHknj4zHTq
	 ggRUez3V4EC6DXf9piveU5AhzZ9YHyqcK3Hd/5Lnrn+KgD6q7seaSZCgaWtIhERCZ
	 DRhGteqT3k98tEmFWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1xBSIB3qj7-00fNIW; Tue, 02
 Jun 2026 14:29:31 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-2-markus.stockhausen@gmx.de> <3b54c1f3-b60c-4e97-8e14-fec10cb1030a@lunn.ch>
In-Reply-To: <3b54c1f3-b60c-4e97-8e14-fec10cb1030a@lunn.ch>
Subject: AW: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to fwnode API
Date: Tue, 2 Jun 2026 14:29:23 +0200
Message-ID: <027401dcf28b$760ad6b0$62208410$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgDFqLYVAlPhdku4kHyRkA==
Content-Language: de
X-Provags-ID: V03:K1:OqsPpJPaR4bX7eVNhDH5YUIdUDMo2nwanVzWzobP7d3CoJkUA3P
 qbzaB4yrOtUz5OLIwBWCQL3vdzdd7z6ZfzNblV99lpQT8NU2idjABoJnD2VcqIBUpwvR9L+
 gWtrRbekh1jiPxBwEyOZXVmRLcKFPMOll9nD8CmLf7d7/FjJc59eKxc1DYFhEoRD4T3Aynz
 zn3On5Uksl7kLl/E5o2+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3Poa/8AT5FI=;Ouok1MIM+gDqKFxZNVjVn/UcVvm
 2SG9FqrsdPxj066+0fo3vqGwft08w8KPwESO/8ch9uWKlPL/eoadnQsA57QqsAmBp0evqgBCv
 7BhZIo5tRjbAHgMMqM4eDFsQG+mMw/rk0MJ4xvNpBBzuJXgsNOfXNzIP4guyiPXocxG1Ar+xb
 JFWX122cfUTj+AYBqlfv2kzqJuk7Sx6GVf4RV1MJmPBhomYzWvldNKbNE9VipoC30w909S8+o
 IMxnsuoqHfmNh3VSa1S6IRrlrq6ymnLowmK58mXC+Xj0Dbs+MLb3MGi0kiZiOYFSfSM3tv4ci
 0XUfJhmh3a6Z8LfvIMIhW/W2QoXr9fl4fQRfulUNFkXOzNDy2DKuw7g0HA6D9Hxs9MISbzKdo
 4PDgo9o2hy88LbsLJSMm1Ek5yDVn/O/RfsKkvRyNrzTANhaf6b0bpBTU1uThIIkDPSvuanRvc
 mt5Bk1pn7xBRolNksz0HE3L3shETY+FO9L79kRxA34QH0zKw6Vva0IMJi6UxmDkHNa/DGyVVr
 0TPSOjkwa/AI4U49Ol/DkiKr5Ptka26lovv5OXNVoZSjZ8EHJl74te36YmKyYxH+ynmO2eILR
 pV4YO4dvMNF18iN5PG8zJm3HM2sVRpv1TgTWd3Uhsdp+6xNC+ZlljtgIVRrv/k9RM2ZGbiYAy
 FKlV3vFOxlaQODz17adJR0EaLm10Puvz+JYL1cpMe68csgmTyRAAsF/vXOUfWH+kupf/xpq7S
 ARVpgH8Od9x8+yUhFtYXNbVlHnxICXdnYoQ5iiWbWrAhH5yOj/m2NuXwGryrQhtxdxXhbEQHR
 Ewdt7R4fbCzEx5IkNKNq+l94BnB+VHabM3hqLeugT6Kef0Zr7PX7s+em+RtvU25cXRpJ3FfaV
 h1MunonOTHhzNW3rZ/iC0thjVd3c5YDFxZUMy/3avemfsDt0iqexE/9wcWszm25SmVBJPDLPh
 B4SH0atd5+JMuauO+godgSEGU9ffxoBBrwLiHax3PQX5UdWnSw+Pi2qNbIptKDoVXxIklX7Br
 zGOFGqU5/PuVqg8b1EnExeDdcK3DAUCvwlCpm7+1sOXPISyO+xQ4BBqBCEgYbhbZj843kU4JV
 cmNZDk+pX5Orfwa0S8bJ6YkoFPzDEQ28WDedSPsmTtHOg4YNwKl3Wy7fJvudJ+s3F1UVd42Dx
 f8aWfQUZoV8ryYTgFFPowlut5JSAr0Gom/qIpvAjE0UVmRyxIaWVNitlCroUPHRaAYU814Bqy
 tSTxV2I2cwEUKZ5z5+RgdvNpPiHa2JotAajErSnGuMwA8AT6J11+7cf7C0SMzgm4LooN7YgUc
 gj7mv7YGM2MdrZfD91AXe0KREAEB7Dyg2BvwXusIIUVOVm7WhsvqkbkZMSoRv98daa1/fSVMQ
 fM6PU5nPl4hloh9bxx9CRT8I3L1YL0+MdXpVb39UBdtPCbPFUt7veq4N5zF+JsrQZ3AQSZP6D
 9MQ3m6+1oIODse5d8TNMUJUlaJGcCmvktm9UyDCEF/EW2nOqXc0j0sWsLoj3OMiXIEr712HY2
 mQ5QPNmKzF58OqvirrIldapT4mKXVJ5zEEi/kz0YxS6RDBUwYMA0SZWS+pSZzcj2Q7tMeLqmk
 Wpt4T8jeLe7cS2naVAaPbBY78C8pZePbkBlrKF7VKX6j4K2y4odZNGzasRf7QIGL4+06wV7vw
 lzW6wZEOtxqlGGzBQUcCLwDaHAbMDHN5Tjhp3o/BGf5w/yaSX9JuWfTTWHNBUTNw/lza5iSw5
 MU+I8Mug32VqLZeOWrPdnfA+qeJegCCumSQmrvappaqrLEJnkxr+p0AIynEqiKNa3Pz+v7zq4
 m2X2qDZbUNMV7OYQWgbzY2KHAfLZB12mifQuboheb6rza/7Fi4TH+9K+aup1DK4WitbWAshI6
 H2o0nwGbjSU/2A882te49mQktCfum/fpesMgg4Vm6zPkMptvYxoan+SwgQiK8/+LmvARLBWLR
 o+P0Ag5gJuEpzEWl2kb1xvzdsenXxN2nO7fpCV1P96hwmGmyiwtZrCg7glE5rJ5w8DAdJR7T1
 g3AWcl9SXJ7/QYafzW3hG3FdjZxxXhetAPbWPzq4M25R+tET6hKrdnLQ40eQp1PytWy9lNxfV
 Pj/Fru7qfhBZiJ+XlA9zAbl4JaA2HuIoPsSVM2/9P9qrtE3/3V1RfK69wlsmGv2t5NVidDtRT
 MxJeFbriGEAE9kRmRA72GUP7YR9oy6Av/ENHolZDlbu1RiFuMmtrglZMmh3UD2xaYoG8uAs8Y
 L0LCafCSyx2xUn7D/vrJ2jxXxvr2WElcC9967XD392AOM/b0xN8PtDzk7YWD9F1cvxO1PjRtO
 gQSmhMCHbhzZt6vXLMnuEUYJ/8BYeK8+mkgj/dr5Ypg7/SdsTpudGtEzhfH7zHzXIJ9UIIw0S
 ZQHzA3j5KDoixk9kqBZFXvgD9uadUTe/u6cvmDY59uduCJo89ELAhkxw36yG78pP9xR2y7ksk
 0cZjc5mEq1FvpGERMqm7ntaxDbnFks1N5K3H9wfBEba7G6V5d5aohIcJgSMnP7HAnP6t50MO9
 h3HBZlOTMagNU9tn4EcaNOOYE4xNTTzbkyuicBtpa0uUu2TwOVUO3DhGHBxdGj1Rzr8o0AoPS
 BUhytgH5R38743F3EvxAg0jbfKBCirQ0NPLawgusDeonvMSeEH4VG38yzrrwzndLDYJ4JRhG+
 +WUCskgadkL3f5RwGdl9IwwLfH4WUIBooVrycK8WfVF33blkjCGKipnezbpebiksFwweTrN5Y
 qtG+/Cx3IgbtZ0k0YqrA4k8D1bT6Y50VG28sF2AFWAfxhpOa1qUNkPDF0hQimyBfoe8uWYGvx
 dEGN9nibzGqyn/j4QmN6Js6tbZhQMsh4vzxhdEYcW4SPas5YLwzulAMWwo+dhomNm174yqFnF
 cONoisa/r1/7oqN23mEil3KqxrVNVA+jd74+dCu+mpe5mI08MU7az3ZBXFgzAIXX/30nY92OR
 NgZNZ6qNVNG1HWjsCuMb0+1okNu0G5xsx0iu01BBzqLkK7QyvuqkaCBLUSNbDOjyQffg1JiEF
 qJBFRTTujmhA0CMPk+v3a9vbK+6VfmykhwCrCwai/FI1grk74hnlOR6Oq9UQNZ688CgA5+Gpk
 U3uXfXMOkGtlk3b2+tZBpfB0gUQfjKISL4R8dmA4pLGGIIjSeDzf1TGjhE5G7dQYAw8R5spl2
 UYUt6MP/fGjqfGdmXDvyjqGFyZHJnUxuvzDbWgP8WjHa3nB4HUbrPA0dtQLm/NXWnN2wAcG4h
 YwOvsrAecFhGYlABxiHjQRf9dnST/Tm9On7ZZBu7ZM9LCvFH4J4/eTJ2SLy41ylYN7m0r5p0F
 g5Gc7M67UOOPpeJsS8oKGrDJpUgoejRa7YE/6/xZ6wppoDnN3e5V4mywYCnGhGQMh9pCArYKa
 qNJiVScd7wz4mB9NNuoXa7sdmAT9XoKBzgTSQJ705kqfLlmmXBhHcMPq4M/wi+++ca6N11O5x
 zgIr6KASJbJlKjGIPRHl2nmbjVAYVU+LrSZb0QIQNfWO9VGrVWCTLKcz3KXEQ2vE96bmrEpvm
 YkH/PxYLajeWgQR4EOG/wx9IapNDgOGX0Cn6mzOaFw4iBKjAmL3qTJpehDJt2+V6RwTHg08SI
 SL3g+1RW8tV1Ao+6x3mNUBAmu3+XhtgbIJU8o3eWdBnoiWzP1wyi6PCk8Lo3tULqhhgw3xa4Q
 p7p+9KiS0D3pMEA+18CD3dHdmozXod9YhF8nKluqusb7skxuIaWiY6qn2P4HDVv2Jg1jncND6
 XE//a9bKTPs4vQJKKFTVMUQ/stYLGcLTjmno3gL5ULnjS02/+T+MAPP7TtlaiJXvVcOp6FuK0
 vewI845sxwAGOHiPFlDbFXabcmN9db66xNzvYoj3XyinRqjVFnCokLEPVsg8QPqN+AXcrtRzU
 l9dIMtLTWayeviVheYXb6smpwuiL++Ci3ALb6v0IGymjZtmZptEUB2rSK25Guyq3CEe9Dpod3
 Qi+AE4uWrzCSkuKxrvJf5ircbre+YydWR55qWI+FDRL4IYN1F3y/jIi9+tdIM1cea9FULqOvG
 AWh/fU8tcg4PmpXR1uJzAAS0MpkO+0kQmsT/MpvpLoBxRfMgy2hX05j3vAuSFkRxJR50gWNak
 fSrwrhxRAPDbZBttmm70r//qHrUNJrnIiXON/HD6CF2ws5XH5RzMFYtObEp8QPKMrxjEKxJ02
 KDMekYU8xMsaxF93UvkI7P19RrMZgTnLshzesiptZtWRynxXmScjU8nb0k5Gry6/wP9/hF1p6
 lCF2yPnV5feH4pyblyA7UW5Qie54MhhVDreKty++GpAEJJIZErC7rGOEJa3Gj4E09eqWj13un
 pj5SEHf6qSN1GQJpZqEEJnYsyynQSq0rQuLzsY03Fbpv9GE5YzdcFLVLk3rtSEkO2H1WE6OOD
 9uNxh6JbnhTw62H7kN38NJsD6Jum5/5zkXoa2E2e3LRLyD2eV21vooTvOcnopJ4CqKtEgvVC5
 SvUawOGuTr4VpsvIabwKgrWWR74d8shsv/Aid2LL2NVhU4BgX5G5zDl5iO+aD+phvrBEJjek2
 zZkaUgPeHDsh0FEIyi48p6XUUvB86xaMghfPPNO06Y2tjcU4F42g9zy55q+eziN303BvyOzrv
 4/jB6p4oPbbwpQ2L/k1BtNJepNheT6tVfEbQdmA34i0p6VIOahM4l7hvjmo1PssXE72BD7FAT
 evJvj3R5xAhpKg3E4dQ8w11NFZ7FW1KXnR43xYaRbq3b4SSIpUsTywTZWi8idW/ZnNvk1hm/9
 6jCWp2iSUHowEguzi0foI3KiRWQP9mSs0uW+s4WHbKHiSo5MqfUOMA01cpAObHtQhcWuxVa7v
 VmcTpaDeoMOHAoqugiTCG3TYP1ztKBUUbXOKzk3jhXR3NhDBEMgMnhwAABsb1/K2dIjmqvcJB
 qjODPHxT/coIw55emoykXeqNv/AFCotB0qP1godJ5HF9ck9TnIWZ579kLCrKHiAiivZILLo4D
 knCn1ZWFR1fVTCz/4slwQwJrQ2vLNiGIqZ6KO2csDw2w6n9C/wxCNJwqRBh4ksDmj8xQoSZHG
 JvuUTn2/g+8tefsX5wQc2CoEe79sLgcZrFlLiz54Mc5Ca1GLf1FOMhXLFrFtzApHMmYda3P0f
 sLOxIr3Dqz9EHL8EQ29mswaFnFB90zd1VEDtwScPmCpG+tcOsoO1qogOy4LZkEOTS8uqTTDeA
 pNuXfIIKOBlDzTQpMZuWu54M+3zekQ746AappDl6la0LoZ3kdHfb5tAAixsYqawI4OnufIzEv
 E22iiVwh1npPwkBPwZrlUtOu1aEtah8xkSllA3MQhD0p5oBmgONIKKBkNUuUvAeSyQHAPr0Me
 kXlLjQnW6TD+ajtu9bc2rtKk8DqVwL1UD1QrqAwlz4APfIQ6cRdwks7Bxgw124ik+Bfo3c2B9
 DKQI3GeKDUu1jJy5C2NYkOsD4WJS/jPcJ6xznVwzySCOEUIzFZX8yzv8oxTMQBB9g9c5VQWzA
 JKDyTZ4fdGE/wX/tmgx5A2mYQZMDSxPvSOlvOyyYkYIIfB8dTBxNA5WQ5pnYim6kELTZ+w6yh
 bVvJqdj4RJFO8hjfmGvBZDZa9pjufwPX3f1tHqDHY6vXCEHvSnjNmfWt44DhlUMN4t7EkGXoh
 G2qVjZRodtoCBqjr9s=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294200-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1D9B62E0C2

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 2. Juni 2026 14:06
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
fwnode API
>=20
> On Tue, Jun 02, 2026 at 07:26:33AM +0200, Markus Stockhausen wrote:
> > The driver still uses legacy "of_" functions to determine the port
mapping
> > during probing. Convert this to the modern fwnode API. With that also
fix
> > a subtle lookup bug in the original code.
>
> fwnode does not exist because it is modern. It allows you to have
> other bindings, like ACPI binding, using the same code. Do you need an
> ACPI binding? Have you documented this new ACPI binding? Has ACPI been
> tested? Are there any OF properties which as listed as deprecated
> which have been converted to fwnode? A new binding should not start
> out with deprecated properties.

As I'm no firmware expert, thanks for the note.=20
I came across this mix in the old code:

	err =3D fwnode_property_read_u32(port, "reg", &pn);
	...
	err =3D of_property_read_u32(mdio_dn, "reg", &bus);

So I decided to get consistent and opt for the=20
fwnode version. To be precise: We are using=20
device tree only here and we do not need to=20
change any structure or properties.=20

Leave all as is then? If yes, do I use "of_" or "fwnode_"=20
for new functions? E.g. for patch 2/8.

Markus




