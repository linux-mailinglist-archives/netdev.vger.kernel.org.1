Return-Path: <netdev+bounces-304791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qEDuNCSISmqwEQEAu9opvQ
	(envelope-from <netdev+bounces-304791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BB70A930
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=OhjSRw+G;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304791-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304791-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E78B63018AEE
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEE72F9998;
	Sun,  5 Jul 2026 16:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D726E173;
	Sun,  5 Jul 2026 16:35:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269354; cv=none; b=O+Gkw9X1p2/CkFC2y/BjKNcCEi95Rwp7wzdrUnJhWCQtQcUKchwjczrMYhv16LaRMNNlCTLTcptY7Rz5vm2MEkHSuNylOP1c8hLeirxOW8lDi70gosrodQVDUpQUS4ichEheMA7UiETnQP6W477y07WyCzfrcG2kTyhQgY1L6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269354; c=relaxed/simple;
	bh=E47i0SSXFwWuK426PGxA2sz/seIjSlXjFAapjoj/U2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kB/aROVm63VYmLcaO3RfueFi5YCt7aCksMbwRxI4Iv9Y9pdzoMvFCITNFPCtg/wilW9v0TtJd2/MzYfvgpiDVLXnCrhyFcVLkgNZB3924ut9IsEzjdGFGEESwgmICmPTIyeT1BeAx0FU0GExUnTjwiWiiiMvZimJpGnaflGsxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=OhjSRw+G; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269346; x=1783874146;
	i=markus.stockhausen@gmx.de;
	bh=/crMaH0MdmDSWTd0oImDd4b7e78mg/iE6zE/eWUMwDs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OhjSRw+G0PS+bC1O3wU1XF5QzO2bMQmgfgXRixpMC0m26uC6PCWLkrAlvRyMT8I6
	 aPucjnGoR12zA5r0AUeMqPxKfBy7WONGZ8jZOe0BijHoT3khE1uQoGNbZZ8XiP8fD
	 WSR+5j49DtPJQMyqsrySWpFnhJrBnqKZJCpBeAvoRxjSlZuOAMnEe4zE27Rb4bjaw
	 1XKJzfBUjHrMyNrGdNiITd9jiroxojBcDSE2Op7IESZCfpv5BnaNrwjB9fgPOohKf
	 VVj5iKwHCd9/fnz/WFbdp4qkY3OdjVZQ8pqeu9auOZJcBDCUVSjeInVDCqaDm1Lcq
	 7vd7Zzh278PwUU52fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1xFkVH2u6z-00ai29; Sun, 05
 Jul 2026 18:35:46 +0200
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
Subject: [PATCH net-next v3 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Sun,  5 Jul 2026 18:35:24 +0200
Message-ID: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wXVQjAgXfhoeSJetZdeC4kS7/MFIP/gkZONQh4Edcxo9fUAuAji
 /4taq/XOm77X4DUesHTsj88AtqfEybMw1arTb73J8VW3knZ8JaOBq/1+U4wBAPR9gHETWQe
 vVM8zV0/po5GVugZyDOjf0KJ06cl4/Wzr3lbPfxI9T8DOby+uq5IlfAbrKyYxiUGLl2gKG4
 VGtDGIdOHJ+f3CL7G1CFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rkcF2LlpzK0=;WQJPuvWJ25zBy83HNGFmDAd4Lu8
 JqB6K2pNEp890oC8WIYzaGUm2M/25P0F4pw3yEkal/vtydhEA6N3yGiLOFBuVuZEQSwbil/Bo
 djAeD+jEhGqAx9wz5b8c53v52obHEIb3bDlEYnA/Ef9nBvX3bsR9GoMwixM3ZxPElcuR/9vD7
 C8g0CPhUK/Z1PP31s2qB1wb8rqnrfKcIkecTp8O6UzyA26C2V7uojKOd8f67QwEqK0qvPFiE9
 w1CBsVoYVn/Q6wKg0/Ix97Z3XEL2dl0m0RiRjkj5e1HmrVRqahqfmecEbSTOpW9jF0OsWDL7R
 DXz9RbsigrLDvg3DU/NZMEtcbo5iXQ4VPveAsTYXtsk8Fp939p3imOgPCFrFEPxAN61a2tv3s
 l/DmBwHXQ2JnHGjm7lZjxd9FSlJV/Ba350AIkRkzK79DQut2HJXJE5uGoDy68SfVjAzJ13jD/
 2I7iJVQpax+bjv+nh3O3xyB8W8oUOL4auq3Ih8muZDEden3TgclTdYc6IDAh4j09bYnbMOYNY
 dhVqfZ6HMTP0L+7V5XqLlF1/VIBPb2pmIckuCR/xpTRVsQYNlySGVAoxyJhzkshRSflIj9VgK
 LaskqLBkccQg/7R0y/CB8liOxfP832TzKaTCKQNQ4E8yihqjAFyK3ZPsq0D6m1HhBKJSPbLQ5
 J17rCnxISVZRPyqrDAK7QwuKMp4+Z1PLrnKXQb5c7JEdOGWD9G33LWtV8I27aqw8F4JcM7IcC
 mW0weUyY6yX2wLi/xY/0fjqrHnLNp5uWK54VYhOqHroZeRQRrfDuhjo1i0z8gredkvlXm3D39
 gxet4ydXSTX2NiQ+8azjtvEd/Z9tYUaGy5OXcA4qhAShbLm8rz+mWjk7cgB2mTW1aHJXrs7dH
 lwWDYSn0/3aQob4f+l/iUR1UXqsrDcU6PpuI+iMShVkQwXMqI0A5TG9vVgA//K7HzApyteY47
 HyQtx0MBRWMIrNlqsl9So92kFDwRuM5Ai+a9a2fMsWJkYb8uEXy49M+wmTGocVNTh9NviVQkN
 0PpMzED7RdvyG1iH4kdELq4Vq4Hm0nf5LO5ntE/hLxVTIQiteQQdeW6q9uf1TZMgU+NzDnkMA
 A9f6drmnyn3+ICPlf2Qx+51b5TxmKyjv0o5F1K6ZzOkIqHn3s+OpdFjcuzaLjFK5qv1GCbSk1
 foyuF3vtgwmzrPLITYsatEEgDb0AjjH40tmXJWmVpynPeePD+1mgYALHtuZYms+Uv57hhbcmS
 JGzAeB1eU/PdnfldYeiKEgcGnz+MN+Xz4T0dEhTzsYF3E2dMjSNKC5L7MKrfhocFUTllIqDHE
 2qaQQ7LUMQf6JVLzWa39mzGONrGQseI6hJVGO+UMJuMhr/ua0FLSV6cKNmna4NQrw6RQSz9tM
 FBmqbMnfSa4dcIk8cLxaSg0UVlBfJuoareb2r1T6Yrw4VEgg0/DIJxD4TOSZfBdoUkegR9cAS
 YANS2gNPd98OT+808SwLWcr98uE0zHKwF+ShycBsJ6/XV/lCU6SLNcIlye4QJ4uZLbJkKINPG
 gxogmPpX4Fo8VcY+eRlt+bI4S5xRE4JshOHWjrQ/CvzTLHgv8v00K2k9aKywwatXkeJfIhWmX
 gdYNxZS0KWqtPVvYE2xh5s9EnD8ob7Aq6WTM5kOfG09MJn1uyWt9R5dTN1/pLI2+HHFoWGWWa
 YJnOI8FzAifUVjg4B1Tx4pUUGAIfC6yC3f/9F3x6Uf6p1+XoJkIIZa5iQNAXCoYz0DNkKAjVf
 QkaZVSfyXVybhDo99MlX44LsbBrG1o9SarMBF6RniAP4TOuXprXicuIO2SqeESLkTiRIhGkIP
 i0tA0VCgBw1gkVpLHBXDtwjGRatxVJskBsWf4Ubv+/neRn1SRz0RdyWcGP9m9nEqasEmuZ4fG
 Yg6/kHnqOA2xGALVUlu2Xo4tXz1/383JFUPtHwOKFWINxvy5G4CjaoFEgTbGQIgqRJb3fLeDd
 dd+pRhGoiiv0FY2kiTQt2v8JiwGYepgkkd94gfIEvYNXLN9qmdCqgs7SP72CrpJod73bKwpUm
 Z5biDH62Ncjy1/EE+rBhsC6nRDCIlQn67u4GRUnHpRyDhsuSuPn51t/2beFaLkqpBy/cMPYyG
 ERrUUVgmg/7/eVQuIca8WZgkz+n4f592vxp9Gawb307K0h5uy7ToTad6ArSmphHB8SIG7jKJ4
 0ksvgV86i+vxWem3cdVfeYUH+G0LHjw/YUGT+oRsok/xdJE0WiF0mCiMAha03OMNytO1S/HX/
 sru7d/DmLTsWLEo4EMJsbQBdnb8uXJ7e18ya/QR6/EC7rEcPDqPvEZ9sKdL9fCPJSCILGu4oT
 G+d5qEVeC1LFCP+3MUpWPRo2BvbSkawEDyyGGWiOA4XXr+Znhq/wwS++bZKAnO4ayQBNRlqJf
 crT00NGIkAE7tGIYzQey7l0EEI+pPtt5SAj5kN1nF2pxA7WtkyAdbEp9klBDnkfaQeudpT9ac
 9XosDYNIMN6vH9TzU0GTASyyYc1GVFyTqPQ0zNnmB6ZcqeWcSELmDGc37o2vPp+AqPcXRIVY7
 MXc2RPrmXAenekBefC3YwfmCMSKsoSF+lMr27LiO8CuNMtoHZYpMZVdHwEJIZmb5CeLVtgDMV
 Lrf9S8r0wMPraLAmUpkvN5wjTsyU1FXEqwQEhuz+Of6XLEXs4OraycOqrwiglNoeOurpAHqwz
 uZIwgcmPoqWdKZN3SuZtwxETVc1sNtTKTWzn9gSYRnzoxtEfonrRZq9XBjlDiu9hT5os/UgOO
 Bbb6PwezfuerWgTLVs9QurRCpkxLFHpVdgnaLK2hGpcpNL/1U5jPV8M8MEi2Syzurk6C0U8C8
 WMc7qivaZacgxxb1uMDL/gwtwM9iK1CMMlv9CtnREXN7+YRUu+rf+Ktm4xo4JzdzQiAXeXjL/
 CQiI99oo9z+ko3jSNHiH1eTikFD9oaoeX9/sd5r5/vp9rIYgT9ZQaogyyeQulSvuqiyXPye5O
 +3CTWGjf6DcbKoQFzwCuPXHIR8AAtGPSoiZmVvdSscediKSfoJsxv6GxepREoEUq5YbpKGVrY
 FOy7T3CUi7NjmtS4Xa6+624lJq5ufKTnzSCGj9LtuyC3UEyXKsTToyWnUZrjQCOw0QThZEBSI
 X+Y5bzz+rw4p7HIXM7iu1cwVj0KFRcIhQhq044jkwHohVEWwCgMevJjnPXS/E682b0hc7NtAF
 TasZlZqf2cblawC7g1/WLCBl1NMycxZq3UfI654zWibn5L2Dx3p4C1prr0uNbAie2HDz/YpAL
 lxIBbXsGcLRViGmHxeTSTzmgcL+h6ivXUZOvX2QAg96fdS91dvIkE8athh9iIK3yyypJe7com
 9Q+Wf6T2GshUlpIQyfnGhYgSd09jOFHIX5LVBY1ZI5pDlwBQOZxajZazIZJzXjeoIiApZbeKM
 Bji+bpCrGLDkzGaKQ3EAB2gLAisXhcc0Hl4IApMmrgzMNEcy5jlmUajiH/i05SHnWyaMLF02/
 E0qITSCDcPSKcqhnYL7e0ckyrRiEE+8FsB8Z4ZGWV3eY+neeeYemsD6FzoC5SRDhl1vmRaDdy
 fnX43Uww6iAUys1J2vvFy7xV/U48qKPj+/oEhwR1iDnTfbtmkxV2+NsHXyg+OjZjKqPrNy6Cb
 D0vvATV2oH4js1rmLin0X76yPyg3ty14KApGQlWAUVCixbAJGe6hXWlBYeyqal6gEcHSxlDnm
 y85+s29Vwe/gNTu0jx5cG4s1B0UccHgd0XVi0GDTgeGSHHs2KlamC19m9CyufHarMhefcczCl
 22/4HxYkU4d/1cgGs92Z1vRLdDSM2QsIBYiY/YzI3Yty0lGYcRDXV70DEnQJP2o6+icG+6EZl
 F9OjAm67E2mXchua3rTTj47CemXK3WN88qvEfbwJ8ulv9sHBb0/Iep+d/W1FwBkYyeU+u/dez
 U+2bjNvq08nX2OfPVIU6sEBa9dgQ5c4G3Tw9EN16yeK8rDsOuLZlMIO5k+OmrHI3bZxAs2SAK
 DeRkMJAFKTnHMWIGK3dG1HhF6QhHqlvsHLE0R7MmvKP1OjtKKN73ljQ1FBRTTBJUqLdjWfgZc
 djDK4JvpeaBV9Ie1v9WJMMxOft7xXQB6INW4XMJHdIp1WFemJy42apqgIkO5/QDJXSyHNODSW
 OfGeYPuzYR5BakCgFu5gjAXw4SnYktOuyWujoshseZvOBbvEQW6jOc/GNDV1R3lfEs/mLcaOQ
 h0kLVl3YXVsFgj2skBJfTOuJaXty7Kf+FL9lXtq3c+laXG4lhUqVSmRQR4/38nFfTxm2AyRzO
 ZfjjplQhmFeDJ4ZtyvhFKILBW+kqGjhrI4scH/PexhfiPvr9EONXpog91E6bxEgbnYxjvMsy5
 JuVuwfzGOby2Zpp0KhcSS6ETNaX3FnUv8/bTSG2op8B9nBe1QepaJ6f7WfxWvoSiyRGe3ZsBG
 ar4srIMh2XMwkkB8I0QGUNhaztkjneMP/mx5o+RHJ5ef+ysotCl0ssKTR8UqrhB7jWf5m7L8t
 zqcDdlTIAVu4EUTk7W3/SJEHpQM72XiMeXaVz99walgEaWvdsHWqqVtj9uDJzpCbpI/R9qjJA
 Gtey9+PvG2PmOJJcRiYvF3Nvd0uEXJbW4i3IlQlxp7OkocrtSI20Xmeq1YmMyxBg18areM87R
 HGBNflL8tUI0VVMW0/D4xMLxvVyaDcxHkBvpKZUw6a+0oLmbAlrUfOzl4JN7V63vAIcNfx1+B
 vWWTD/tlR3TnPD57YixSvqbgDptKF5YRzxwuG5SWlRLkvUfAsaenfX+4SydjHYHjBri548iEO
 +G6DDZfo+98v93rL+cO72VA+61B7ONg7peXId6DnY2Xg+N9LRUOemID8X5OkCG2kZ68fSbmmP
 +9n+EruloSSUM8gBTfYfMr+F6Oj1e7qNjpnA5hPnISuUTui6ygI4Q7GLPBM8/+7Ygze26MA3k
 6NWaIYzF355zZD/Sk/+khxQnBldlaOcTeQrf0Lz9WZSNVTuD3s6EdtbRIMZQcm4jwDy2pYF5r
 PEJiHXHQUjZzqpNdxRWz+GRPMKCCDPOpljfe/Z0F3zAR0ZclYUHLQm7os+uUS03HwbtxOEEfm
 mOal2yRZ8BCPlpoQAlTduLsuUW8D/5JOcifafdh61ZXsm2mw56vRMOt7kC1ssLON+P1ayWqIx
 glVdDsgFT//RGooUfz65r6eSyuswwDnhQvPmC6/2dZFPbYZ5QIRo8gQGXsjfdi7noKSWnqnhO
 cMBiyM4VUkTr78RBKPLELslCLPGlDMvuZuVEHWaAze4khhAY8AwskUcS9iCEpsKvflRQKSurN
 +WmidCOr6lgLrQYk9sOaeaBjJa0xxI1fPyi99S8shR6NFBK2VhrNyfJpXb13cDMV+IpDkcPu5
 qlgFI2UQlJiHRfEbxjIQfP3PMRaTapC/NMjIwlT75zq5znnWXszrmLpwAQg0FitvWtMvpmTiq
 dix7a7SIqo2PFCJ3wnEXESLtLl9u5u++coDrqw8KW/d13+YyhzdFtfevVO9KOIeojW/DyY/7v
 E2r5QscLh826EJ3mPCJoCXuoZErWD9gkydknIBxbrgNRw5FUi4xjo6mdm09zTZuTp6mSthyb0
 aO1+yvhCXW/xqdRBrgnBrf5BRolmMUdvujl21kFkiVRvy7QzpSEx+Qr5jcyFyrDe0xb5G9OIA
 VdAawAHqNLTZdcArIc=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304791-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 666BB70A930

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

While the MDIO hardware polling unit and its necessity for the MAC=20
layer was always well known, no detailed documentation was available.
For this series the MDIO bus was inspected with a logic analyzer for=20
a better understanding how polling and kernel access interact on the=20
bus. All this will be explained now in the driver comments.

This patch series adds support for the RTL83xx devices. For this

- Enhance device tree binding.
- Add special handling for limitations enforced by hardware polling.
  These already have minor side effects on RTL93xx devices but are even
  more critical for the RTL83xx hardware.
- Add RTL83xx coding.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v2 -> v3:
  - Enhance documentation and make clear that the driver and not the
    kernel must handle the bus mess. (Andrew)
  - Block non-Realtek PHYs on C22 buses to avoid issues with driver
    internal register 31 handling. (Andrew, Chris)
  - Drop C45 over C22 patch. This would need a bus lock/unlock design.
    For all known hardware designs it is not needed. (Andrew)
  - Drop tune_polling() and init_polling() from private structure.
    It is not used in this series and only produces review bot
    questions. (Sashiko)
  - Sort patches for better logical consistency. (Markus)
  - Add device tree patch that was missed in v2. (Markus)
v2: https://lore.kernel.org/netdev/20260629152336.2239826-1-markus.stockha=
usen@gmx.de/
v2 Sashiko review: https://sashiko.dev/#/patchset/20260629152336.2239826-1=
-markus.stockhausen%40gmx.de

v1 -> v2:
  - The polling activation logic was refactored. V1 simply activated
    polling after bus probing. Now a dedicated phydev/bus callback
    takes care of this and also handles deferred PHY probing. (Sashiko)
  - Run MMD prefix helper before register 31 (aka Realtek page register)=
=20
    handling. (Jakub's bot)
  - Always run MMD postfix - even if the c22 register access fails. This=
=20
    ensures that the MMD state machine stays consistent. Adapt the error=
=20
    handling inside the postfix function to not overwrite the real MDIO=20
    return code (Sashiko, Jakub's bot)
  - Drop unused RTL8390_PHY_CTRL_PARK_PAGE define. Like on RTL931x this=20
    field must not be set and thus can be ignored. (Sashiko)
  - Change title in device tree documentation. Because of this do NOT=20
    add the Reviewed-by of Krzysztof. (Jakub's bot)
  - Fix wrong use of RTL839x in commit message of patch "c45 over c22=20
    mitigation". RTL930x was wrongly named RTL839x in the list of good=20
    devices. (Markus)
  - Fix typos (e.g. c22 over c45) in polling documentation (Jakub's bot)
v1: https://lore.kernel.org/netdev/20260613112946.1071411-1-markus.stockha=
usen@gmx.de/
v1 Sashiko review: https://sashiko.dev/#/patchset/20260613112946.1071411-1=
-markus.stockhausen@gmx.de


Daniel Golle (1):
  net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

Markus Stockhausen (7):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 395 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  |   9 +
 include/linux/phy.h                           |   4 +
 4 files changed, 412 insertions(+), 10 deletions(-)

=2D-=20
2.54.0


