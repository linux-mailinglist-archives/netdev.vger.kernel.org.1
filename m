Return-Path: <netdev+bounces-294148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHACBfa4HmrZJgAAu9opvQ
	(envelope-from <netdev+bounces-294148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8762D1CF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F05CA3004CAE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC783D6485;
	Tue,  2 Jun 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="O3utnCCi"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22423D903E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397458; cv=none; b=iEiT6VlRw4sEhX7fgf1FDmvtrv8fSyjjq6GrE7Q8EtoymdRkJgfGUweGPJmyTU9DHIzR2+8K35gnCg3vfIuryeq97oi5OyDU8euChpD+IXH/1kA7oeKqkvOjwu3o0DvTpMAITcUhwEzsvWs8kPazMK4ie7jMddvYLFAyO37Guf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397458; c=relaxed/simple;
	bh=qVOVl+9GUP4xNLOjOuIFC0BqBaXCmuJVTEDHOfgOGuE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8H1/MMVY38XJNhH32ufkwQnQQekfvVsRnRNKCmh4w1MNRDE7qbd0i+Hn6fTa/HX7k3Cdqvgn+QmOG4QdJEfxLCMCcTQ+r29J2i8uGFwvvV320got3PZzodgkTDLbvHJlkv/YzG+8FVysFMqazhdCFxAP3w3ZJBnmSyySI1BVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=O3utnCCi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780397434; x=1781002234;
	i=markus.stockhausen@gmx.de;
	bh=KN3qkLWVCgelmr1CCWuS/YCzJe544lzNHHwQArOdczM=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O3utnCCi1Y+Wa/+wszaSfvhfut5u8iaciChIFVALns4RMXMwVw+tqCroMnPbzy2M
	 TmwPISUIkr5fTZCelYC6otUm7Hf7tB5R6KwdpHfSwPPH1i5ytBgBbB3Uluzs7j1ne
	 RimdXy0AxgjDoDreSw4zj/gx/hoeZRLGi2bPs/K62P7vn77TZsUv17iiyM4GmnM7e
	 PVuc/Hwgkd1g3uY6l+a2CZziu/WdemFGtxGiWnTDMlZOfIqd9PiRGp8GBlJ9gtSs9
	 yfhcbIdEula6DFhFmKUbFQe8F5s1GF4hOs0Kvr+An6qSFuUiHTV04O2xTOHDa3RGP
	 vN3JlqWPabBU+kaRIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1wqNeU0gz2-00Kku7; Tue, 02
 Jun 2026 12:50:34 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jagielski, Jedrzej'" <jedrzej.jagielski@intel.com>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-7-markus.stockhausen@gmx.de> <PH0PR11MB590280FD1EBFDE793A92A97FF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB590280FD1EBFDE793A92A97FF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
Subject: AW: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate topology setup
Date: Tue, 2 Jun 2026 12:50:31 +0200
Message-ID: <017101dcf27d$a37cc850$ea7658f0$@gmx.de>
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
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgFzUwJSAUMTDRS4k30XsA==
Content-Language: de
X-Provags-ID: V03:K1:MZIEow19XZhRTry2dFL2zfyJ4VH95SmZ8wk+3i5oinqZCXZKm9N
 MNOVOucBV/QsRx7ADuHtNBjQmzjsFYI2LV0ifPn9x9+6SpRstb3cEeRbrVp7DtpNc1TUXtc
 FuhymggkRzrdvrX61QKjTon5iA7zr36X+mLKGqszEBDSgBTRPCEQPJKlmy69ZvQv00C9dh/
 9EZbcEs1CSTswwiINbTKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DH+ZAIGFH8k=;pyWbNnLuSBNuCQ2eBZU8DjYFExO
 e8+R1ewyeGgTeZJV81ciwDISHHQvBUxBrkbOaArL+LIVDymlBgIQQfZvB5fn24n9fiGMJ8o/v
 izu0pIr/KZNIX/P5k8JiOhEsJPwhWA+ENi3HCUXf1Jy6xQXvptY2hgx/HiqjyM+tu5IB/HsOG
 HwVa674ZJKuBLnqCZNZ2hLOtWs+QfegX9pgYHSc830uR2nZP5zPdPMw7E3ZViBy19U/hskZzM
 iXGDFgNzHZxCVzzllUntqDDt2XLq5QbAonCDNJZS11NFYIOXlUAZVEc8Q/AqbOOSrwDFlbEoD
 kOljH/jnslX1h+XelkDBklVLqM1HsJEadC1Qq0Cc/uBEUHUzgIOPrfko7R8b6JRfYCh/dP9bh
 LFKI9SNL1GMW3crC6dDyQQqrtfTxoAOhtDQzlLAL6YY8nT2UCBjdYHYazKl5iFai1EvlM8/Ia
 Ed5IgcJMqIRH/xZZJK3mAMNQFoPJgc55Pza50ciqJIXbbr9oeFcGDaHa0YLNGkz5DR7Gbt/yW
 zUwCTzoizUXyncCf7wdX60R9w2Zrffwgfli2BS+kqYOBiXPW49zFuqJQlQ2uwYDFGjNtF0s/6
 40HiPm7HlpmbZFrtvy4TxtW+61voNQm1sCsidZyEK55rPZUUeIEq4NfqBygraFLPV8+IZ68uN
 yZ7f6kYVrXlFoeEfQLD868r36K88AeSED+pny/r+GtFXzrlgpW1f65j8DOVAQ1n7yrQ5M+cMg
 Eznl8KNUoTmtJX1asmd2/kx4QNPgLUsq6/L8XRNOdFBmjGMgm4qhc8P/uZ8t9zg3Srg+WMNuY
 1qwwTiFi6AmaW0QbIyWCJLrgzBdbbtE4koVOnTTQR93AdV7Jnt8ShRtxXYD/G5rH5zf3NQ3uB
 bmxLPmQ4S25LsYTW4Srn2tmPWV0ZpIiFUzYPlMe7TcYzclUAD6jn1I066r8wCEx12YQLFUoCd
 AQTE3d42fu/Nvy07i3dKFchNQMddyS24Yazkss4QI1t4zonjsCo5LavHx+9FaJIJNLfcg16xq
 lvpUyXYmTbbqKcEZ+K4ieeePG30mNymGTbSAjjjPvwHNzSDseyNitCYdN3XLcHouRqVSmydBQ
 32bjtvYldT9cwnPVIOHOKEFG4tEQmC5IFkZZRupwDAj/3Fkr6+pPu1VCJUhpuFRgjtciWW4E5
 NwBGhFq2CcV7YqOV6nYP/hTlpKAIi5rW+7T5fcCaj3efuinYMUVumJnI4+Wj0d9YuVVOqYSx0
 hur0mbs3gKHsvHuYIkhdieJjuvdY6UTget+UuoRnnwhxRG//azpLrkPyi/gccG2PfMX6+D0EN
 wifMN07iW5aP2R5BcSC2A+fJqjBDvecewe+Lhqz8T68HIqIUZIFGxOHkLhZNKGNnV+Yaxz1PL
 hD/1tcdGt/7cke6NUgCGUYxN6K3B+7i4SIASEOifKbX6f53g19G0/PGa0t5ZghSKkrBxMQxrI
 vW0WwuItqMwoWEOOP8vH9RtoP2BunPG8B5DILilb50syVNOabRJwlz/dKOY5p8heVzBfYl9Bx
 YHiuzHEeUBn5VPjeNAgmNiqKd6jimw/KlHnV2pb3c5oma3DS3BK6p/rXX3koP0Ik9h0l8glIp
 7nw+qOjLB5hgrAlbkIEAXLSjBqDzUSeQCIk+pewbOX4vbIsupQXPWFd5VFSwqfx3LZntNc/Lv
 PN34cTzZw05DpTM5zZkvHa0uXHM+mJtFCid7nIDJ/2iEQDwrjNyZeMCbbcEnWp/XatrobIpk+
 mdDIfX9q4MvCJ+o2c2d1YQQQ84SqkKq0mdEZsvJuZ750gEh7FlTy5hWbwYhAKcERABEzCxXl9
 6dBHE9exoYNhuN4ppNvpGXLcw+QZPaBynU9g/mF0dUDLiAD+WgNQ37DzGROMeAUBlI5AKcTdR
 PNTfbE9xu7zG30RMSYBH8mEitHi0FypguHWJpTsEozwEpZSKh4f7/jBRI1gaApzxcxjoz8UQB
 YgVjMwmfqWmAOeclx6WPXY5Pqmvb4ZGAuk+s1jjNm9Ti882yQnH1HsMwh8FcXtgus0YBgUbyu
 kn2V00750sxEgOEQk1N/ZnLinYJhgMrmeUEcFSwYXTBCsv80O333WhkB1nLcHpJ7nJyZ+U8mB
 /lS0Q94LK4vJ22yj8FpJbwVQBRA4uRgNYEJTuv1udUxQqZ8xxt0pYLKyP0iZoRm/LfbY0+uNH
 sMtzhHpX2DvtWYNEcbdb6+iTK7ePBMVY5C1s4VpxfTTJmxSqbXQp/sbCm7AgsbSL49ERWcMSN
 HaLJSmhOtGANGpeft4ROji+SNDK1+kav9jqUyEbo5HRiwz8VVY0fySzC9UpeYvOPMEL2LrfzL
 eq/9XBKSm36BTxHAZNLWSDSGa/5o+1V6bL/9PDAyEtPI9845WwHN3pYkCMRPzKhSU6Nk/BTHT
 QP+GFGQhD/f/mQBrI1Mjp0IEbW2C/gl5mGq8d4084cjY7ML+0GvF1m+r/YVJCKL5M0U5CKyew
 29i4tGe6yRXFryhS6TNPQpHdU2y5w9efrbyAOrGr+Kq6bQvkNfis20hLXwbC3rNguUrSWVbP5
 XbYfClGvkCIH8zKfu4pX2h4yar0iBJvymAKLHyXPXjF68/DwjvQJMEsKCW95CT9Nq0GzXi1eO
 AzqHOpu38WqskkXndo5KsHI53t+CWoencMxq7FeG8BO4k0uwVsLQVch7WOlGyhZBQzPSg9N8f
 RDidqQaAAtAubdqCK3LDo8D6KbQVOTcl460vlcqJkaS9vzqL5P49G7IEUGGyU72N4YPdPrHip
 wpZVNu72jCbH0E3HLIsU7vSA5jZsGb0uCzrPQSCttMzuDQ6Ctpr1nk2DDfelMhC1d9dPPs6oj
 LbsppQb/Vx3EyCx4UqRzRgDi001YrjcpjQSQkegQ+7/mDwVM/etRwgHm4zbGWkHWJEHhBA5UQ
 ESRyhQa7iCFzXNBSa+/6h8OdbMh6Z9HfqxRVhit0M1ecs6hvz4cg23MsPuX9BFkqmYY/2Ocnp
 HzdAoCIzof+3pB9uBtYOWvR6SdVKYwqrFTcVRqg3zgQDxS4oS/kGGoIzA/Rs7dYzMK+mjSs5V
 MWyCpv2EQtsbJMWXAItA2DJgiFDkrjioijmruLTFowwOFa2wUUPj4wi2ZHvN/8/H8zwE8G4Go
 V/2WeSBMw7h0M0YhOAMNhYLbxmB1sFRVxcxklcLVUO4tb9KFOs+35ag2+ZSRJLMSf65tX1rgr
 r5JioYrJbf/b1afXcpFKacqF9G7WSz7Sujb8+F0247TUGSbPtqXjxk+0qXu1GRwClRqfzdQB2
 dysv+e5+bloe3XstJwQBdfxAB2Czgz1GLgb0BBKeLGe4wr7iR48zkWRQtjxcH5yYoaVXVYYGN
 T50W2WecjRll0RFnjGVRdB8q2AszK7pc5VSrAnBmiQJsV/oL/TID2TqIs2PqrUV+htM7gkjE/
 ZppR0V7RzMTK08DWIAGxgh/+WeYr8/FN7H6MlzGBN7ITnBUYz7VDirRjtbm5442I9r3K1z1DF
 FQJZZgSxC7B0byT5TDzcmrmiNv2ZYDw9wDzDcJVmsg7XZTHaqiQNFFzRNES3CYKIPKkdtsvRR
 aDV8oMpaT0/8Sq3UsNTa0MSvNpClBvUUxrpJkb6m4xeON9H+xVP+03zwJK45vHaaZgbRpJjk5
 GvwYex7M9I4BLNxxrhpVAJ1NNOLMC9N5hUVu1W/ZGgru/zPNec6FZG5ifklWuVR19YRaFuWKX
 qzpTAdJm2eX9b43DZp9Ao721DXHXpranAosVv2tcMtAn7L4ZscnJ23oWPAAYGdvUMUNF0gB9f
 N4VRrroBJySRiafmlbiXqKYY7gsa5sJPrHLlTx3sFLfDLJsejKji74CXwd759eyTr80Ch3ubN
 bcu/igk4jcRSuV20UCxfxzzRBE6BnaIuq8EDh2qvijuUVzhqxi9ThqcaJGWpZjVO8Y0WLpb2a
 V11/kg+7z24+it+/G2g/XndWavoZMVaWeZtO6N8T2+U0DnkESM3Nk/+4h/BrQSsRF35/RdDPc
 Ld6k8mUW4Jx5fCchZznAfd7sGRvE9m2Y6EhTXbCETk7WZp0hbKEijsb7/QznAmqEffuBXEcsL
 PAM9VI36aYv2FvDuvikK0BLuW3DsL2bYK2WTYhnKFzusWKRYXccN9W2yEwB3LRU3gQfcAgTzL
 tXbm2mOmaGJBJLc8q2L5cVXJJ/9183rxlnYpz0ol1Vvi7v1MJV1MYQBVEDHemRHtMqQBYf/or
 dqD2VL4f06LCQq2F0GdHcUEWxdjSqWgw1+AXMNL+bg9hXWxQkBsLqWJK9RjOuFlDy/+lXKqAu
 DGDe81zr9L4l02QSL/35x0AF5L0JMttuOgApPxxeyCc5Ibh4BWXA+yktBfj/bk+E42DEoF8io
 TXRDSkdScHMHgWiV0oMbkImYgLrm1RZDHZb5qIg7eSHXidRfGQZpCVQnzHls6YXniV10rBZTk
 f/MAjw5EQ2P15CaN3Bkz/509760meYGMVbCCLvgzKp2+5auEZ+3+JnEWPTKpUH2yEhoi78En+
 u/Ha8KsH+UbVQdd47J1xbC4zOqPs94KEqaEh5Lq33zinjFJh5bn43DqzX8ikrBBAvbL+aS689
 2nxaFzYQPXW/cHfqr5lU1zDcEo5qwL7sIZIfZ40puh8MBZfFO0ZzLj5UPqYNP/tnB7/DK+DQL
 gwaJzXTd7FftLsvhqaF3LVmKkEowgtKg58zCfwlkuYM8WQgVQzKjhYa4fI+Di7GnGlkwnCai9
 Afz/M4B7OgF3oHZBhC7x6lOuvSsMKSvHWu7RhNhA+dssgY32yShEgGcdnODLoliudDGD5OcPR
 aTvwxB/9d/0zIGGzaty9k6u+6SPbFo/c7I4QpU29LeAR1QC0RYGj0dFxh4Sa4kXyPXcqblfE9
 alOtlor5hG1mZry3ybkFUNwSPLodMwVdk5p+bBF3j0yUBweIDps/oPdnnBOLip05WI6q9h8c8
 413HNVv++EMlAubABcUocmRsguDNBAPomDYyDjKV7rndJ3syd7ZiroPGkfK6lXo6Kd0ZRAIOs
 mHbXLzJT9l9gHQ0yFOHQDUE5pyO6/PdxC2oyCiJzmcVu1rbCqoZ29b1oDkgSuR1F5TOHZwAxe
 cuE7J201lFaZB8lN1JWYJY9rdSkgD/C3kq3ePE12MDRocPCY3CC5J9IEGS/LrRYA9L2Ry+v5X
 PJ+gWuYyuc7QqyOLWMsg8a/Av9W0zERTlYTbHMGlMKhgW+mR8sSlIuSMe0Ianu5tBrHh7Xp9q
 MukYx3BHlTjW1zjRyai/4udTPna+S+Y/6H3VNqELedqLW39a+L5nNWuY+zuvClFU2Z8WMHtWS
 KnUn0T70ggfcGaq4Tdrc8JOw9XahWdHzzZhh2IpImSdvNSULj/P4T3Lx81ztYiNpIE86lPQ0o
 bxfsBTrXdV1WFd3OpMhMuYrFmRPqzRjM6LQd162Srnn4CYiCy9JAt8+jXlzj1NhxSG5AYADfL
 AFBowWIqlQsnU7+tYZWlF6H9pKJpfcm7AS/+B7QwfYr228PRDX2s2yOnBNgBIdmsxN/Gvngrq
 EWjfRERI1MJl2ZEkZIH1BUaji25OU/ZiAIdid+2RXlw0Uu3SZG21bxdhzLmaLFCvW9/2GbZPh
 /lKO8SUw4ui3zXUVx/kSelgjvmRXBJZ4DINYn9SBWadMlZ4fs/PJl4bUFyGF1jZ7/XH0zyWqc
 hNU32XzFSoq41zqc/x+Jeqk+dp5r2Y/W0/THD9z
X-Rspamd-Queue-Id: 37D8762D1CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-294148-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.de:dkim,gmx.de:mid]
X-Rspamd-Action: no action

> Von: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>=20
> Gesendet: Dienstag, 2. Juni 2026 11:51
> Betreff: RE: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
topology setup
> ...=20
> >-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
> >+static int otto_emdio_write_mapping(struct otto_emdio_priv *priv, u32
base, u32 port,
> >+				    u32 ports_per_reg, u32 bits_per_val, u32
value)
> > {
> >-	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
> >-	struct regmap *regmap =3D priv->regmap;
> >-	u32 port_addr[5] =3D { 0 };
> >-	u32 poll_sel[2] =3D { 0 };
> >-	int i, err;
> >+	u32 shift =3D (port % ports_per_reg) * bits_per_val;
>
> are we sure @ports_per_reg cannot be equal to 0 in any scenario?

This helper is only implemented to make the topology=20
setup code easier to read. So this is never gets a zero input.=20
I can rename the function to clearer indicate the tight coupling.

> ...=20
> >-		pos =3D (i % 16) * 2;
> >-		poll_sel[i / 16] |=3D (priv->smi_bus[i] & 0x3) << pos;
> >+	for_each_set_bit(port, priv->valid_ports, info->num_ports) {
> >+		if (info->bus_map_base) {
> >+			/* 16 ports per register, 2 bits per port (bus index
0-3) */
> >+			ret =3D otto_emdio_write_mapping(priv,
info->bus_map_base, port,
> >+						       16, 2,
priv->smi_bus[port]);
> >+			if (ret)
> >+				return ret;
> >+		}
> >+		if (info->addr_map_base) {
> >+			/* 6 ports per register, 5 bits per port (PHY
address 0-31) */
> >+			ret =3D otto_emdio_write_mapping(priv,
info->addr_map_base, port,
> >+						       6, 5,
priv->smi_addr[port]);
> >+			if (ret)
> >+				return ret;
> >+		}
> > 	}
> >+	return 0;
>
> Magic numbers appearing here and there, what is discouraged in netdev i
believe
> Any chance to replace them with corresponding defines?

No problem, will ad that to v2.

Markus


