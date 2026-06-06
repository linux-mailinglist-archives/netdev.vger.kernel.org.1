Return-Path: <netdev+bounces-296122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fMhEDIpPJGoO5QEAu9opvQ
	(envelope-from <netdev+bounces-296122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 18:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944964DF02
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 18:49:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=FrxgbLGx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296122-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296122-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4610D3007287
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839229B77E;
	Sat,  6 Jun 2026 16:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3543284B37
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 16:49:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780764549; cv=none; b=rL5RREKaWt88wlOtmEm7N9jOotwf4BsY4soMAIwJmEbKrNwloBeMSrVlSBV//mv1DRQfYMP5rrh6nmEtjOss+JNmN22AHNBvMWMjUS+B/EBjDtWQYUHO704Ed4yR1zSkJMdDzv10N3DNeq4ao+mlH3jWKQoEAe137sqxZYoPFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780764549; c=relaxed/simple;
	bh=DF8iW5CwEAcT6n2X8m8HxktGK3eLPXvUOXXQJ9X0xV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=djdoZ/GrKc/CCKGHGvRRXS/RS/ANchd3I7BehVCZcSF6EPp0d+njyxfmFd0ne57vgfGyYpGyJGj45UMyl+yyEgCmflKU/Tr4AsZ1v+4T0EuougWpDz4CWiw7sMmhWt7fkhNw9tSPQPvcehi7X+npuySezY7n9/1/jmvdX4sJ2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FrxgbLGx; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780764520; x=1781369320;
	i=markus.stockhausen@gmx.de;
	bh=aEqXwTUJuptoukTscDXck+9F6r/HrLEBjDJmVfWiXp8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FrxgbLGx1y4jaN36J8OUN8jXiYvCtJkm/+3tSrtr763NSmHU6hSvqE4MNwNuDZ1J
	 8DlTKx1UgCAUVPBJFEjJQ3CHvpvpCmRC6hY0D5yRQFy0fJMarJIZLQKP1vmyMpbe0
	 8ZpakJrG3Ywd8kJeklw0n3q9Ack0sjmxcY60M65gKd5cB1aTloCxQgIr2QlJcD+qL
	 yUo3AFybshJRL1TMLVwOqtfNQgxonc37KlnYV0lpcdJ3ePNaHplE4Hutup4cAU8Oq
	 kbDbfAAW0PDRPoIlNVppaUDAB4vEH4dMrIEdiMGemp2W2+h2xbpL4u2uTiTJKJPiT
	 dMRZDvpxptYgUFtrTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1xGkFO267m-00xj0Z; Sat, 06
 Jun 2026 18:48:40 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	"'Jonas Jelonek'" <jonas.jelonek@protonmail.ch>
Subject: Realtek Otto PHY hardware polling
Date: Sat, 6 Jun 2026 18:48:37 +0200
Message-ID: <02d001dcf5d4$540aad50$fc2007f0$@gmx.de>
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
Thread-Index: Adz1zYYEOCgRHU16SGKqftGc6HNR/Q==
Content-Language: de
X-Provags-ID: V03:K1:sf/fXhZ2nsbuSET07EpiitGvTCoagUfeZeXdA1ZKPnCcbYU6CFw
 GPoerfYNKISszDkVpdyI9takeWhmfzGyVyNdhEE4FBqNkRrm9bDTx9EjHoNIISPiy103nD0
 ScH0p/2CICEQmVJ3o5HMV+L+EzxR4zs2y88bvzczSOdeFQqEqA4r/VHh2b2gjlg4C29ISoR
 Q7dMLwwUIoINMkyETvi5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0rGzS0ElFSw=;USl1PINetaJVOW/vaLpjemxv6cf
 ZjvbvNkgcgqxj5zCQd8f3LdQSW6dAkcb8VEFqjP4eUAxLbmCGgd33p6vodLKKjCrDZx1aV6xS
 s89QP3bcadq2EVKtZdPOFdyEXHx+GWjk1GNJl0WfGwbeJJqS+mjsscG9GooGr925oDX30sPU/
 AUSBmWmzgj0KuBTWvndCN8Sj0Oate62PDkWWIoDbObtLvwIFMWISVuALtO6JUo2ddvFaPG6Wx
 ACc9EV8poOhXI239YDOYVDl6AL2Z8LAvPTae0+rNuHrrQtyThdBiMnhp++sbspEo3OTn5ZNd1
 aGZRhD0O+Lkpt8Lp2zI/FFL/exUJwIHkIaqX7GVnIAEpz4lQBZjeMXUQZ7a6MOEg8ic10lneX
 FNzhaGmHMlotfV0dnu4zH9ANCfAjgKEKOaZcz2tZKv6VsUU5vJ+YaGeosLqUf3T+IOseET1RA
 AB1huB/dh88WxvsMTgBNCp8MSF5uF4Z+vbtgg/nSikjymytDDobdUOGBH+ijLDWMpIsioe5Te
 JmVRhtOJMQmb4DKkoE/ebg+/AcsjAvLMaGc3iUW2myNzrV7Uzm8FrdNfxJV27ExJkhx6Qg8U5
 BUWmqyOiaeUgo4xCQPogCZjoAOYt331B8WTeg3r9BojvJF+J7dHqsuthVtCYIgWKMa7A19MiR
 QBQ40q2jPizKRsCTmXZ4ujMaj9J7+X22rgLTq1ZOiJq+UbdB/UAuLKjNSZOAEH60aoNl052uY
 pWuzzGo7JW5UVts8hnWkIXKsl5RhiMTge+XPuFfx0uwNszYZTelvu9iGdC49R1enDTu9prxYm
 Wpb9vhJz94Z09250UpxExYk86FiRRCDbFy4UopZHCPHPCDPGYlppL+W4G8D212l9rT1q1ac7u
 apdz2qmqCAl+OvAEB9aaoNjG/iqi96/P9TpTQ8UGcuoMQc85xWRojb44IhRKAvsB7naajt051
 +i7vw5V2PPNVpUhqhHuSadOD3KFtvW0H3GBusnGHodV+KzCAfV0mcG9UrzuYhxS+f7vA2wycQ
 zwpINDzvgAeHO02GbAqP/uKvqM/Luf5kqCBAt27O0Nb7v4YBG4xucAw61DwLnW16s2Hh9P+du
 nNA+vwC7ulIbedgP7kjPleMs9X/B/m0ulvX/6GiJT5aLqxyevJa9grhBIczhsGl8yBXYrsVnX
 uTfU+NhUbg4mKqn4CAuskQxJv2aoCyEIRH9WK0SHE4D5DDItgpcZS8PiMW0tSL1kYfHwDOK+y
 3nC0L9nk1BKEDPhEQMA3nZdgyuwVhQw+UIy9KQLbq5c8ndp8FIKyk7aNAlN9dLL7AvbDTHsMa
 ePcxAAdep90PEhjkSC5MuHkehsryG9YkbF+g/t3fXzf4V4ll7qIAXEmsOx0w/SEfk+pmI60EG
 iMmkrXfJfPxU6VvAUi2MA+e9tlXboRrD/hsODV/N+KtQQSireTpAXEA2tNgZCw8KpVnePE9ZI
 GoYn8w7Z3WjLjspUgGYU0tMZ89XfeYgC9l0ER8MAcjf42bl+2oVraWp60MK0vyaXRA6exanEz
 8z16rHcOWTwup429e9w/6ZcEhH21dsmcto77ip40ok8SKc9vxSt1QI+uR8qsZnZTiQ0EEjmPc
 I7gEOLN65TUrJebUT7PI9x11kB3GxecYboqNYF9OGH6bdB2UyvcSjYmMiT2nlaqJp5UyxEprs
 BJPEbS/MdbcH3oTZ99o5CiNrYmmVVr7g9AHqbru+F+zPmfVQEE5YX7HkRGCoZrn/jg64FRtnX
 02siZYQxzxMa1Ma+GXK+svixc1msC1MpyYBgyuHTsAnvMFkHFYFZHrZMXcrh3U8N91XpKbREe
 TQ2tV3MvmnaYKGIStx6GW0ZrTra879Gayq/vYNbub5aS1fziZVso6lyhczXDJE3VwdzjQ1h3g
 ck/Nc4oTfEJvF7AZyhtOgodtNmdKcApLXy1KnE1yaCi2uaA5+9wyocBR5JXUrEk8MW43oyIyN
 hf2F+w4LG04RE4OFN4p1II6p3WerNPFLD6aaACCZ7E50yvDixDh2jSgH5GBWr/BG97zWZGXFp
 v2rrifofPWnKV0kSYuL4PY1TJ8R861jVnAUr1/X+vm/KIJRcwcherwi9SC4JUot4AVPuzCgbM
 thFiO5HCBTLkLsrbKb4kuKhWkoBTyzuxR+eJCMrCAoh4pGJox00lgZHHiTpEJHu+oOUAZ4DQ6
 PLjiUY3tV9A8iTNNCmemBpIIMa2wVI9CbwcJRt5cgRSLYdI+uNS03DhWHUCzTs59zBeJ18cNh
 gWdwUAzdBzr+mEsjpPWabrGSTiP7JG89q8Rt4Dy1R4OeI4ssQriOxmE0vS9mr2GqGDQ02rqi1
 N0hmeZJ6qGeM4l2wIwgH33wNKPTRNlDl39tlve2td+x1Ax5zoIKT7eX3kuNdJ+rDLstbUP1v4
 AlA+/veWbnc6GPxaU0ifBHdZHLormYCmItlYRegpciHF03I+uRSQ1XL53DWx6LXr3cx6948qd
 dJpb95itYyTZ1ZTMbeIebUQAcQC8z0gjLYZvgrfojrlQTUqb5NzRnrytVLc8a1qIlCWDiq3+z
 nvmKBmEvQFiUQGX7xU1xCVE0LfQ5St33upRgGqUWWW1oZNLFE4vG/1s478SEYErMMMTzKQdE4
 kFrr6OThI92PuM2gOAWTbQs1b7++L1yfvwbkA/Zt/UYJCEn2WV1YP7FEMGMT1nBN2wTgq/0q0
 EyPYKF+TwvT3ZPe6fMPh7E2Oa/WPVrrhIarACpjIfs2Vk7CUpZaOrRhWqxMCt9bbXlvHkwVj6
 gGob24sklk/72d2DFTioO1cHyRc7SEnMjCMGrJK5VkPtpLnmVUjfXSlfoJhAPRIRA7RrOoxg0
 OC8bsTzuEKwJnGOwqLMCyHU60ZsEs6OfFT6O2QZPSG2Fwcu7/M5dKugHiZdMDND73dlbnq31y
 MUaLzYYettC3wOfrg8SMmi+U9apx28GBm27uvQFHQEfhEmfQSFqdOfLW8g2HphDk8NknKiQCK
 kGD4euOJDfCeLaCnWvS+Y91T7xuWh/Q9vUzNhWgdIg5YStYYtviWW+8Ny42GRt7WAa6qIWD7G
 lCvcWNl8RZKNLhhazlr5TM416/Na707WV36CwFQAR3CKI+GZzianTQ/pF5zGtKyF1hn3LqB2U
 JDi01sfyNc3hxdblpCjnLqRxg0fsps7RBnqmPwpV+F+fyoXEJSdhFUVr7saaOI77GKrn+prtS
 cL3hZrjd1qSVAFgcXwL7Zm9LHy82amdNcx7js3lRG5PQJ85rjRYL76lIYnUuJJa/3YoVwyLSE
 0ywyh2hDc/wIfcLr2zZyBo8EkywxX7Lm/+ORkITbqECA3qElFJVgOmzp+2uoiYUU1zWz1aG78
 uY3pfYNExTXkLDq9qDCjm9O80kqe3gfAK0GiQdvau1A2W0ASNfX0EmTlwGmt2coK8mXtNpRoa
 D/KMk2MChT7TwajW9MMTy9TE++gqmSMqn0v2Bra2ksrThgmp5XCzlci8XV1MBRHijXcMVjJmy
 y57BqC/Whn6Zlg25vO0aKBMcfaDsrmd0ylTfruDsXOV7exmlAuJu3PSy7VhGxmj60sl62IALo
 UBZqgkXZVTPBc0IUqMh9+N///zCNR4m8Fd6NyWu191r1US15mWgIrQDkdEM8CHFvQ2/Sv5N6E
 7Qle7rEvmYn4gA6W1g1SCP/y01y5QY+2DTNe4vB/6WYDHXIO4P8/7XsiUb33Xot8mTh8r0NWY
 kiUiAfqLW/69icDz+OVKTECQgWbGGBztC/1rL+h4o+fZ2m87c35gZ3CBIELXaF6P+oMCezGXG
 XvpbxkE+2z8KPeU2oep+25GsgOQj2mt0WvYj+hZScIzBt8EpxRVVAa0IDbJ4rnm0cJchhNBUi
 Jil3dwUy16+i/PwkE9nDUtnrifX8GS9fYDUbxfVYitjLDVSJc22XzbonGlclEA9lmI9lvnUNC
 umdSUP10YYXi1hpQ+wUQoE1baO4/d47AJBzxfPSPblsf68DXZn5JjPuW16fx1GgEqAkoLorp/
 zgxG9w5l+l6hMv94EOCy6lOZ+0uAG5ebda3R6r66+BLUo5e0PuFIM6P3SwOajJl/jqMp1CetI
 tSQef6Ye90CjEmsiO27YlcgIrqlAGsH0Gm8gNRbCQEsNzqU01j8Z4MRbCclJzMG3ICywIY4Nh
 KQ6sEtpis4yUWU1vnpuvdWyli5UeaevG57m+zaXP5Y6sTr2PdZ/flDS/hFluZzw0E6IL+5E2M
 t5doChlSjPcDjlkrK0c58OqzRwqdUEOUjUOxPpFba16y6SZwBV39VGObtfJyjm4Io+kUkwoko
 PPVOMKlnWxAoe7iQXBlav5aGvLhmDwMCHQ57Yzm7vLWDMiE3CUw3N0nhfhM8KrIbTV+etIESm
 nirF+JsamUcnqbVxiIeRB+XVeNf0BQIAnLkbxtBOPjfEo3IYRjy9S7rURROqIrnQ0IgQdE+u8
 PkaJM17ExcofC+c/YThQ2eYcC1lN6Yl7e4LRg/x3WEDXcorx/njL0UfhTiDsl+ShrmSXAKMNP
 SBgWdE4CQhS02FbDpwilVrOlJLo6/gXXb8+lZFPcdJdnV0N9NuRoGfO9B60/5UFXdtBQHs4Pt
 Y6b0BC7PiBmdlUrkoQNJNJ4gPJ+B/8vLmg2cYsKxzidv5dFMiSy1cmvAl0VT2L816HhNMchFM
 zVN/bPTixMzbFQUr7IejYLdOvsrYB8ns8pche8pZb9HHleMh9Qcmzs4nun2oC9y72RlcJhSmM
 TW3m/WNDVzfMdWtzXTZ4DYjNzjAfxjSNvxLMCONJPmkyDRG26JgMS7qZo7oXQ2kXVOH1kT8nw
 zEAgj/ehASyUNAApbVKEpI8dx+aHYzp5cfJdUNjG9+53O1u3e6YbvL8ix9i6e79DHtQbmXrmj
 OV2zAVHtagDFShcAy2UQzqXjBqsKh4Rb7uxgumZFa6uYqp5pDpR4+8zxN5Zp7tnYjNn1E1ps6
 LaPoUTu+goCNUO31OqJbCTT4lXC6MLdRzKYzs/j1MTvRrYL72M623+8wu2l+r0wphl3SxyG0V
 qc8JmDTfez0z5V6RIbARmQ7hHl96Vj6YVqrVgvWc4X9MMb5Uv9hbmljT6RTVcDeaT0BbQlOiU
 f+pz6baKijp9wxIADUPMG1Hfw0s40YePtvx0aq2rnfJ3Au3uyfqliGG7q6E72I34o0U4l9cwm
 h+MJFJc14Ca89t169mAoCdrau9SD4c83n5YWU8/zxsZ3/iCQYxUPYOiL4ywsj6b3cj//xngd4
 lG9Ry1iw8TXET+zUW2gSTaWg7CJwkuAKHSI/zJlVDXB292c6Vpx23wSJw1+0qRkrBbpqtvCA6
 1NHLZlXhrEK0Js2WHXCxVXuSvh5cA76U6rEwIXQezOyhh+nZ60IOZWSs0v45Vxu41I9mSOjE8
 zIujSNFp8YkE9cVRDVe3dpoiCYEaoG3TeVk2ds2Df10hYjymiufOe5jDzXTZyCGQf+eAEsBto
 8Yd23mW36/Yw9Jjwxab8K+P6ty8LtLnbgY59QMRGai9TK8s6pgP2EUPNrRc//pi3dS2GOF2H5
 8YrU4s8yj2wicLQeiXKOQL6s9WyoJaT4MoBF4r9aEj1tL6q7FD2nxvSxal1rFiBSIPCwzrdfQ
 qGBJgw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:jonas.jelonek@protonmail.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296122-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2944964DF02

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 2. Juni 2026 22:30
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
topology setup
>=20
> > The hardware polling in these devices is very important for the DSA
> > driver. Especially as a port can be either PHY or SerDes driven. Some
> > MAC operations simply do not work if a wrong state is reported.
>=20
> And you will get the wrong state if the timing of the poll is in the
> middle of the PHY driver swapping the page to read/write something.
>=20
> I've not looked at what PHYs you plan to support, but code like
>=20
>
https://elixir.bootlin.com/linux/v7.0.10/source/drivers/net/phy/realtek/re=
al
tek_main.c#L907
>=20
> could be called every 50ms to blink the LEDs. That changes the page,
> writes a register, and then changes back to the original page. If the
> HW polling happens in the middle of that, it will read from the wrong
> place. If that HW poll actually changes the page, without restoring
> it, the write made in that function could go to the wrong page.
>=20
> So, in order to be able to use the Linux PHY drivers, you need to
> ensure the Linux PHY drivers has exclusive access to the bus when it
> needs it.

Thank you for the journey we are on together. Today I took a a lot of
time to get a better picture of this. First of all the hardware polling
is tightly coupled with the MDIO bus access. So by design the software=20
access to the PHYs is automatically synchronized with the polling.=20
Basically there is no need to disable/enable polling for an access.=20
We are running OpenWrt with polling enabled all the time without=20
major issues.=20

As advised I hammered the bus of the RTL9300 with several=20
access patterns over a few hours. I took the upstream driver that
writes directly to the PHY and does not cache the page like downstream
. So even more stress and chances of wrong pages on the PHY.=20
No issue occured.=20

While doing so I checked the Realtek SDK regarding enabling and=20
disabling of hardware polling. What I found [1]:

- enabling/disabling polling is more often in RTL838x and RTL839x
- It is only used for special functions (fiber, EEE, hard reset, SerDes
  calibration).
- Usage is mostly for the RTL8218B / RTL8214FC PHY
- And another twist: RTL839x can only configure polling for all ports
  at once with a global flag.

=46rom the not yet ported SDK code snippets I read today, I'm even=20
more convinced that we only need some sort of controlled polling=20
enabling/disabling for specific access sequences.=20

That said and from over a year of downstream driver evolution I can
only say that in its current form it fits our needs. I'm even unsure if
this is only some kind of safety for engeneering samples or older
chip revisions. So I will try to stay with the lockless approach as long a=
s=20
possible and only use it during bus setup when the PHYs are probed
and spooky initialization sequences are running.

Will give this another test on the RTL83xx when upstreaming that code.

Once again thank you and best regards.

Markus

[1]
https://github.com/reyalo/Realtek/blob/31ad7755468e4b72cd9473b4a545513de82=
88
f47/sources/rtk-dms1250/src/hal/mac/miim_common_drv.c#L1054





