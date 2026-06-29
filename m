Return-Path: <netdev+bounces-302697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kFYbFNSQQmpj9wkAu9opvQ
	(envelope-from <netdev+bounces-302697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CA6DCC12
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=M4aV9eIu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302697-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1203101EA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898242EEDA;
	Mon, 29 Jun 2026 15:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655541C31A;
	Mon, 29 Jun 2026 15:24:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746654; cv=none; b=fuC6oV+5CJKp8aTjUannU+cil8vjNiB1McxhW+46fJLSY4saKA3Nv+j1LkzeHstQTuDuN3Z3lVtIW1QS/3J+Q/9DgMedWgRn2l3joh1sSMqP8aIFdvzF5hM/yacWd20EZPAC4jiChgI2U/IUMH2rZb2F+i1fQKhmYJNEOdF4LfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746654; c=relaxed/simple;
	bh=VlkIaIHuCtUIfDkBKhMv4gq1bjNrVw5crGMpY+P3BRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZhyqujoAyhRIbzqjtVcm388xXx/ZfK8ujSAufrm1o4InZnYxqSnrarxF3gQmlGTI2aIXzAb/npYL6K+Rlrcs85EPZXRihXvN76Qg6azGgiQs00KNy+s22llmL1Vag8rh9QFVhaBQXgFr/gXQjl3Ds3xCd5SnPFch+uPI1QoHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=M4aV9eIu; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746633; x=1783351433;
	i=markus.stockhausen@gmx.de;
	bh=9JYRyXB/0JPrmKWaT5jbsq1O5cTQxdt5qTP9qaosKd4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M4aV9eIuJs34teIhsBLG8YICenIciRekuUS8jeyi8d5B02U/DedCztzPRdklIchS
	 cp1OeZX74SYWja9mNtO0LPIrX3eVsqgpsWBRCEM39DPezJ+LCWe7Nn7mpadQ63w2W
	 KbGgBlsOMdo9M8cTMbUhImtWgBC8m93fkGmGqHKFhZeld2H+GNrLBVM0UBAzz/74G
	 XCJxswX8FDKWFxpmlHLoECqAg/Xt2Radq3+sDV6gRnPTCterp3w/D0UpmJENO2jlv
	 tX0IgQf+F56sCPfHF8mUmD3COsQVuWZb927IS80V4TMiKYoMokDiBG9R3MYl4WRN7
	 ev8pbDNBrZmsr/aCJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1xJtJZ0Dgu-00nfeU; Mon, 29
 Jun 2026 17:23:53 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Mon, 29 Jun 2026 17:23:34 +0200
Message-ID: <20260629152336.2239826-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GAl9elp+XtOwvX0wivK0l7h0Pgi/7ML5u1Phjp1r+oHHte14HuJ
 SwigyClYk1MHlDCXD5/7OyMFSh7fEaO7kEqE++HIiRFGd/gCuwRyq7jYbMIsrKdUESF3Das
 Uq9oNopnjSdUHZ20rcm4jYRsyJoFZDrCgbhfJids0vTEfNQMHBO7/FUye5KfrZHirjjHOU1
 VJwg8Us3mBb9OAz+QSiEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1R3uwNJAGNg=;2EE8X3Zai4r+LHVEiQLkrdXkjCD
 fCKCCVO9P6EHxsRNlcwm9FyWKuaJSe4sNljI68GeF4kjbAou1TcvyFgLGjkxKsVcYMDOerEuu
 1UXbqJ2Om0uxtruKE91zlOYNaFmaiesKS3AMSs5KQkACcFu7Z1z5BQeO8iFMQxqSJOLu/s1zO
 v0CYcfQJ/UdQrrdyKN8/YUhUFsf7DEKcjfflrOYZprhjwnD33WaCzykxNzmWIBK4Kqarq5JJ5
 Csj7ygUwmPyDiFJrrDMj145U1yeK5PWp94oiNJ5i5lV9BtLfwRUjkhWj9IAFDvr5XG8KcXcYo
 xwODiYl/r8DZMXYGA9GRjd/bWcJnxR6iOE7CCtYTe9lzoiiHIhoO52mUC1uLrextD/4QPFD/t
 PNH5DloTVnLlJkpOvNrtauWLi87REfgCugycsMz47GT7KR3i/zU7zl+n1mZ1Ky2peaz2ozQQW
 D5kct5jhUtL5pCLAZ2teEHr6uIqkzq/YjF2jnzx6aeOB1/OIWhwli+mcM8EhwS86Yh8GCkQb4
 QRILE2U9lknnX6IGGuY35K9pHtjL0msoqC3cv0PFqefhalcuP4f8R0dd/KeBdN4f+ZPDGwOFj
 IHLOif4cy0ow6HlwYOIqy2gAzKjw0EARgna3TLUILZg1CjcWB98L6AM9VDWp321A5ElVAun1j
 A3mxVii7ZQoDB63tR/wc2uljpnKloT+ITMIX5LB4QdYcgMnykNRsS62MaOUAHKxkq8s2yyxIR
 uQ0irz889zyJMai/dibhfSozFTduWC26YwNCzfot7ORuijjI5dT/lh6B9FBlKt+nElsRJvzry
 7j3D5tRGkhVKgTCt8ppba7NplLE43p3T/uNaTHmuBbTUDZkM1ccytSTH01wz5xKAxONti5Eh2
 FItHUbfwgwetJI/jbfj3gJ+m0clmXHcDwinaOJYM7PFdghRRlvnT94+n2NB6jCJexuaqhwrDZ
 nnK828ws88VhEonPKY72zkuHZQxCdoLd13EwUPtDtnSroTXn9L4YMZzCCQ1M65Mc8v/7slK4L
 MA8iXElmg+pk1Qm35RV/FnVN4p4X9qTjBMeSZroyzw4kiAotUxA0g98jmyD4QmsWzozxIuSqm
 R93mNPHvl4QxPqtvlL2ENMj6/wF/LtNJhr+CJfzwSyj87ugX4ug0epkXLQkHclQa/Q9kEIGgc
 tmVz3Opqd7eMePrSyE6PY6br0Tr9fgnJe+49fFBl1C1tTCJU4SRR3AW2UiLyM9djWEycYj+it
 iqTfmj4Okk+7/UvIPFdFN53h5ybGOCsMGgPTIy85EX1nXyI/YZc1b3guLxAezYpRBFeb+LhXU
 h3sgGXjHTHurYeHU4n4/3PUTeU3ypYjUvSNYf5ZwevVawZEXOZP2DqUvW27k1U6VFjcrVHO4C
 om6DjFE7+0reCLUu2ZhERAoONGUu6uLJ6pOen08hnMgd0P1sUE371K1bcOLZ5xFQEB0xxceDu
 HDCbAnXSmwmyipvv1kce8NHSdm1YSTI54l0HKK4+U7Key1EfzEIISA2XDrJigmQb9zpv9tDA+
 AGRgQwHhRFoclGDzJj4LnldQR2rOtwZe7qJnBmfglmxBs31m/7LQiYdKxXwgXkKqQtMswG7fi
 5gLWOUdbAd6Jmvm59383sWcDqPbUQkWt2GlZicyXvCTjiJGJOGUfZtnXChZLIgTWv6stXI89t
 9hnWdPVWG/E5kzD/GcLVIXRh/9/hNelgE0mOzv/XdDjHJjAIidAf+QOPArvqNx5VFWymT/KTl
 OQKci/1WmThwgY2y2tP2D14PqG0JQDaLjsCSmRThnTjH06XnME5RT5ovPxLwKFw72fSbrMVjv
 FiXcKwdPJd46WZYPbMrXTSbb+pSAIDuBnWmyvphIBLCZLaOULAYGFLIanWkoOuruiNP/zeSrk
 kNpRYMbSNOBXYQ7/2bbGXP98nF31o3nVGAHu5RX542VXZZLsA+8MXSJwEdqPxfuvcQ5VEofMf
 F+7Hd9U/aA7uhGyfodxiSVXBpZcGDdTjk+Yo02p6zGh78jgI1ZoJ+9WNw6zk1eR+o8NmLfoXT
 +b/dVk4m4oq3J1cT8dZKM+kcspblTkH5pxYXtAWR7JKb1et3K0IXPDxSZiUIe5xBO23+CyMRB
 Zc2kCezlCl2ATfulCKUv4A42A40xwFLvYD+cxI0nEFEG6fqTL1+SUEr/FmkOyodqQI9K81Zm+
 FfRQVZhW/HT6SfoAhZ8SARVUEu4ILtXDuw3F6CFtrtZytMVSuA8OyAvyESsEiFMVZdRAg4pOe
 rnBBlYfdPHEL9sgqMrcHBYwsvWGuUSlibpXb5c3N+iSxakyuLI6ikut75qM0gd1GhJrRftuRX
 LnZgLsNcIgJd7uDTVZTeJcsPm0/4dacGgBCwE41u7zERYOb1G6nFuQLUDfWFkL/zV14nfKhdU
 paXbbNlgHiYnDb3fENbsnCpxS/s5Bw4GDjTGTImaklnnZMScHsoECYoaZyPQFhLiXFnCGmJmZ
 yqDRS8hTMfGsoDxij/xCAIwMYj3jymUrdECVZYQQM1drvSk3sjqO1yAqp6jTckTfR2eLNA3dj
 MyGoK8rjt3V3R05ERX+E0MR0zRnv4+Uu7r1A+vn5s7d3quwc+nyZqGZi0DJ+sy6jPnHCbFj/y
 4v89Hui3V6aH+xGaHXvExhMp8T4hAGfWO8ul7lf7qEktzOkqsO+LxXiyn/K5lPdYUGsDQ71X9
 QnmHAhuJ5OFbgb1DcM9emonRXNJR9tL7FAeRkeuFpCrkhXKAnYzGk4sVYC075P609k5wNib7z
 xcQO/0j9Ruo9uYIP8DfqWI698wxQAje6oPOt4B3DCtfBkIvG2DeX1nWZulRb5gFDf5fSRPAYC
 n57woOS0KiI2Zl7FtkoBJOrAcjnJmnK26LO2ce3CrGwZWIuIqsR/GxKGW3eRpNTkqdGkktd/p
 byV8LvWU7eYxJY4JehdNgZZ+NAdx9v335rVjp04jq1P3VLHmA6/9cozZI6lYDKs4OZP0weJIC
 qHGRKEMmu4O7wDhMScb2CIBGomUn+xD3TW5gvKFBdSK/ChwF24b+ROQL1HLAJyefNECANq/7+
 /evbonEx+23WSLKKWz5Z8loCQDVlSnDboCcZRL7qYfx4LTFo100noFORKosPIf4wsdnGZECT4
 K5YYrBcevmDrbeHcoXpTBnv7Vp+6Iwg6fYUCXHAmPUnzLBE/JXbPPRBndPUtWVKUGXfUOvRPh
 sXJgC+VEQTrVj1nYuBBWXUF++cjqiLYZETvwECqL7rt1AHDH9YHEDjooRj2QAn68u+lAziZWg
 Ip56IufdeKbfI6YkbSM3oJHCrLQO7iro2q1eY7Li59qaQbCb7vGuKvJZWZg3hbMkDc39nJHJW
 STkrUbMiQQJit26f0OwOt2ZUUktoq+Fda6hK52EhvNqrQEQl/J9ZzF26x/GTghHfBxEhRsePX
 GTRmaTojvwUz/H1QA29MksYD+KX9iuOx3Mm/q0k/qZVW2oDLvtv8Uh4lLDbjwT3Z1XbolpAqV
 o7Bos0eNOFsShCKJtuxPArJiop3RmNSnP8Y+dGWYHfHAQ/9gaif93PESUC/9O6kPlTihkvSbC
 XFZna9IX6cVaiUChwCiUYnvyHFt0SICsBB7oaRnEGGhLQLu3vHemReQTOTBnuop3VVQX4g50H
 8vFqIzldlHjgHoHZqDZbnjjEnUzfnfD21jVseg2CiV43xkribKz1apDNIw0f9vDvZ3pcrV4os
 xjoThd7aWUh2prYmbW9xfeG1hab4zVYHQnWdNgY6M4o7qX1Ha4BRujxAC8IyI/cahwLTP7sV9
 1bAEX55moyFPjwMTjWHw7goC1kSmYY5UWy2d2JWsXjovaenqXCpKgd5MXnFJ8HuXFBgPl8M7F
 6cyijiNPPWM42UdUwR1Z4anQAPyjL4fpQxegknfVprrTI7COhJmvkqSo08fXyWDeOTui6tT+Q
 lR9lN40jtkHs5zVEsAZUv1qBHcCXpFCz1j9EdnZ/hRsxwpmNdkdwcC8zLxm1yyZPVAi+6DTdg
 j1iz///MESTbbtQ3W4DKDmprf7IiuqFqyL9xd+W1vtYygLuUE1j9DQGVCN3+wcUOO8ooNOhK3
 JjVfG4I/r5wSM0jEzcZXX/Yi7ramLT3g3u4fgr0HcfBVM8L76JWI3UWznr7oA78UmnWWWJTj6
 PA/5u1NFarph99kSPc1WgN0VDIPOcf1v3t7OlsSyR4b7KS4oqag/OyJJxPiEawqrJThnA6yJn
 oFkx+lFAoGAgCKUjwtQACLH8/SOi5c707yxz9N+Z3bMv8W9SybY6GAbWqH0P5Y35ZsfhzN56l
 EboLhAVbW4iY2PgDTtYXl0Fi9cYQU/7xN4rRZgyiMYI3Qojxtc8r0yAPt3/Jpx9F3zZzxPf0t
 H9S9r4dyzAYrlCDxHmxOC0rTkBdJ+MK39wwQ1rUsN4FlQI/N0rY561GQ6AHZk7oxHuY4zm5H7
 RcS2dxxTJbnfV/8igMkUSXIEdCqNIlbTdyhMrTUDM5LVQVcq5zUw2i5my1/lantWuhdNsV22H
 4oY0x6AZpM4eTf93/5GnbQDlTOOg+LqAF7toZnUM5fWxncqGkPcJw9wvpKsgqNrhlhykvw+LR
 ZrzhHnDl2AMYNBXkqp7+bND0hjgefnO63ImQA2G6tFSgtj2pbo/wf2OwD4/7fK854pcv6/PZe
 erNKH0GtOiSHt3+6JnDIojS4CIx2jLBO4F4VPondhHfhPF2/bxY2dUsJbHW5c/N74gQb5JBnI
 US0ldU5Xdy1arh8zVRA9pAo0r59DROqXxXnQW0/xi/oXlNusKHvGsQ6x+hb3xzCQeWpuynu1A
 iGPCJ4obCyHpceBH3VcK39/pPQb5ctdzb9RF1o15pS8ImYYqkxUcEIjyrh/YkM9wIE5GuIMM1
 dLuHwBAfb9HB8D3Z/gXBHlznrrdETaLsW2ML5xTsjee1o16hIsYxIeTd5CtX0oeFT4oRV9Dqi
 x3XZfyqkTGQ712SCfrKxj9luuh8eTiLpRg3l3dkAM1QOUgB2nUKNf7Xgn0civwwTRlbn7qVGs
 khORCJkaVtjltiAU0puEr2Y+57Ab7iywJfcqIHsUZDXvOR2RLK7DZoSEa9hqxS6gnhoXPGAcB
 k14UONz1fJKs7rcY+PNGPOSrDrhyaVAbRzOkz6XcLgcbbKyjh7nqVs987grMrQi0hIpcKWv3P
 yPJo2pH5M3y9fXSo5CXb9YBb4vzkf72302E+PIkblBFtqb/lhtzK4CWeuL0EEN5g0c6Nj1o4A
 hKKPIFBemMKDNFEPaLQt+567X5ZaV2c9lX7rbiXn38dVBXs86UCvRDxPh5gQPEJTh60Dzf4et
 oPDTh7zdr4bCVt7FmO+gOx2ud6Eoo1p241SgvvXBwJUZCcsGoOu2C09n/JwDJDwL7SeRKMROz
 mTaavv35mTRqZ+wxJ8LHf0MJZNzdTGnnS1Tawv/xTfEuuv6N2Uh6408LeVb0ktjjizvmIpRfT
 bvZKwYbyoW2aenJ65nhRYT6ndsJSAt6MjY1r6Tk1nw80oOlTh1teqJSHnuhO2vmTHI55HOnNz
 0c/AocMqxxrtSyOu9+bTuS9TEkhjUtxarDZ6jFoihZ+P+gTUMuMk0f0bMaS47icDrFNrowC3O
 Unijg0l1BXnyTZSIZ9pzQm8UG9e4mQ5oxWkuIFHxH2iv8Zpr/gxYprHvoGb4TFNPsE19HeWlw
 a6mV5SOe1OSVUeQSS2lXw9gE9nPcrA1RyWj6yRM
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302697-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB0CA6DCC12

RTL838x devices with 28 ports produce PHY access timeout errors during
one of three boots while waiting for MDIO command completion. This is
currently set to 1ms.

Background: Access to the Realtek Otto ethernet MDIO bus must wait for
a free slot between two hardware polls. The polling sequence consists
of at least 17 commands on the RTL838x devices. This delay can be nicely
seen when disabling polling completely. The following times are measured
on a bus running on the default 2.5MHz. Time measured is from the last
register write that sets the command-start-bit until the hardware
responds with the command-finished-bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

For this bus frequency the bare hardware runtime for a single command
(32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
some overhead. On top of this comes the fact that the RTL838x devices
are low on resources (500Mhz 4Kec core with 16K cache).

Increase the timeout to 10ms to be on the safe side.

Remark! In a future patch the bus clock frequency will be made
configurable with a minimum frequency of 1.25MHz. Setting this
(e.g. for debugging purposes) doubles the command run times but
will safely stay below 10ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 8b60645093e3..206f4e85b82d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -310,9 +310,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
@@ -352,7 +352,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.54.0


