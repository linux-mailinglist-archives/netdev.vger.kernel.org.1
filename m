Return-Path: <netdev+bounces-304790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NleBEQyISmqpEQEAu9opvQ
	(envelope-from <netdev+bounces-304790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D370170A928
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=VAeYlx2n;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304790-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304790-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D55213013489
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF42F7F17;
	Sun,  5 Jul 2026 16:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D02DCF45;
	Sun,  5 Jul 2026 16:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269353; cv=none; b=GUn68pRWJSWvZ5LG6LV2zOikdElB5brIOuwqt+id2nECAsze+V7PyqSE3UvNUAzNX6StVsgRLZe+4I4V+THNW+BvLa9jlJ6yt2sL/PFIkMvIFn14I4qJ27GOxP0mKbPt8KcM4KIf+lBnXvu+YYETzFDiPXl8kLTbD2/nFwv30Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269353; c=relaxed/simple;
	bh=uzvOeyBIGJ0zH58vlG6UTeG2oa3ZaqKUvQ/CpRjhHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRqIwWkFvYaiyZHElra5z5iscopFAOGTAsI0w/HKR98YkPQr5DNHdpSr7+Aiv9nxbxCRE4B+Dg0YrB2vdGABfkoAp4e3QsXfmG+MKV7zxrwXCCcXnvjFXIwod2EHlLOm9gXRXAYTAQnCSgwXLAa3+UMLj6g1GRBjIMGdNKUal4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=VAeYlx2n; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269348; x=1783874148;
	i=markus.stockhausen@gmx.de;
	bh=/RDVHMovIXh5DrYkL3r1VHqHbiwSP7QSB+a/pojgNQE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VAeYlx2nLFljEkID69MQw1Js87qNaaPk2D1Po0CtM/OnGsHkcZsBA+v592SCTxUM
	 7kT6wFVMR8fDcRuegnT4OlU8nuuO9msNFmlaS7Q863UlTtzFQTEAlGFN8yTgQyIzX
	 S1/M4rBh69osTqzAapPlRELADYzGs3tCo0B16k1cFYP5TfpKLHq7F1+wrQKCFQTe+
	 HeWDaFuBkyzzaHTZyGmK8IMxqcLpsVEewugDK8WXpv87CwlswrCJJ/T/iDxWtsieB
	 lZiTpKLoQ8yJi0bgKrhRPKcK+foN/TnsU4mR30Rjgw4YdtwacPQ6SLLNW9p47kBt9
	 1SEkkjh0OzRVjmG/2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzjt-1waDbG412P-00YVAL; Sun, 05
 Jul 2026 18:35:48 +0200
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
Subject: [PATCH net-next v3 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Sun,  5 Jul 2026 18:35:27 +0200
Message-ID: <20260705163532.2853959-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x6RBfFu/ur6sfioWB4UmnVIJl9Bx0VodHWaVmcL3aWAF+wycg3e
 LrtOhb38dljbnCMljrvtzO+w2D8iOleW4rvgLslhFdcqgu3odEuifLp5ycPu28ABLPHlrab
 tntty1AeA56XjyDrDJNews9xNx1Uyyvd0IQS7q0Kq8lsiF+BX1AVbs2OCQQJ7nktcfDiD+q
 nl4hN+aSeK+ji3kN/Hn3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UYy3nXqVsCk=;BnqZIKX8/Tny35UOwL7o0v0fsId
 d1/6u53dKRtA6ZepUwj55Q9fAKGMGbdajFC6dzeBy75ecEVrUY8G6CZwItZri3g8UUwVdt0GJ
 f59CKLROqnsA1SOmUlMbAglt1lpR+qWhkcoDQZ4E+vlakirV890O9jEajUN+rH7WIDKj51NOp
 cB+2XOsbO9OYlZSZcP+qFgJP6F+kh2iRqBu2hF0l/IUJ3R0ctRgbxLRBhwV6e6if1cxilDimo
 /zYxo1RCG7P0WTi8Gs0corXDwQIBDiKzJYZbQLgTq6VQv0xYKW6kbwfq9NBbP38onlnzeTAaQ
 eRN9ztD1ApPkDEBGNEHRsbYmwBXnzYW3QxDWFxmqgCrD1WaMS9nn2JyOEeHK05uKM9pElSazK
 VOVT4zJ3BwpaOBLY33H022Lb76igdPfUhbBeRU/9P11yFGrvlKAchoqvyhfPLvj5HdDJBD7Xr
 BoasLXHtyQqVm9YAthcPlaKegEh8OYzPqVCaZcmRVOp6JZCeAizfJhDVzWloaG6mLiEgbbl+z
 eGUf9hlOj+FqA6hSRTQCaA8N8MQPSjFHgwG6tXFVoKfUNumawOVI1yEF+i6ED1YB1pUWvMyfy
 og/ePVBeROZawK3qbWHI1CchPY4iV4ZGypVM1DuYvS/w3XA0iCtf0dYBD8V1c++9xYr72aOtS
 PsnQNMxoDzkEIa16D1+DkDUyzTzWJUkfgY8z8U2jlSI1PixCctMc5OMpqYJjkCugBpDxpMcdx
 nh4ElltLZ66mw/dtHWoI3OYlMDKhpSiYVhwi8srK2/eHW+n4lf5bmoi761+bT3fBLM6bGGX6y
 TFnRllSu52NLb+4xppRmAppUMslHsOavZl6cUj2qkW3TT1kNcoYuD9DlY30xWWiyZp4OG7cQf
 xYyDBOH32AZOwV/hgZSdHhxty1OwbJd1xj0jnf8Q7BfLE6R0EJLpwpcGQIq4ersvNqkQNZdFH
 UQnlUq+TsBq2dwHo/Ukbnf07VbmuFNY7OUyBfZ65mKfTAlOiyiATxPL1CAC0/v0IqYH1I52uF
 UYgF9MRgili4+yH/eDLBt5SCyTIXHLki/yF0WE6hIvonBA7Rj0w8EVhf+3MlwEIO1mLMogyc8
 z7d8LlnV3mq6v43XY+6WmN2pC7bYUPVPZXO49L6WCoIU2K98WT1/ugaPkFGwIPFUwOubzM1Ml
 O/dkIT37Rjk2XhXTBhO4QUjb6Fq5KVoNw9/6of/CQCeMEcTJn0Q5tUFPvMWax/10RG1b2Vg8J
 jl/wjdWuIH5mw749XuY/6Xow5vxup68rO5nTGB6DkEcRIxMOMjYBrzdBUrouAXlrYHBA+9JJf
 u2WPxNlvulHDBNzg3xQ+MunRZ/O0xb1N8y/e6r4gSTBEL16ciIZMp33fkdxp9mfP02AG6I7Mf
 7rnAnzETMCNWLId2jC6M1LPCpDs6Io7XRh6+9fV+F1gP5F9UDduZjupLT4ZGiubW+kYqYprqd
 HP83A/AjZ7ih3UyqdPqETEv4LMV4EMP8PrzdO8LU6t9X/8GHHWiKk6dzlp4o0lTy5R5x5Tnj0
 EQZKF86tkQqmlRi4bPZ/3wwDfWHKFCJvzlPBal8dHrHf1etyaQE0DdMRSgeByp1WOXK494Bpu
 cU4eBMLHWiR34BfGYoJ08CT/25Vy/f7xpaQOJdAxl3zDUo9AuKuj8v/Yw4j5IBCpP3PdUlDc9
 VoXxkROBmv/c+yZQumNKo2wyMuPkBHM3F1BNbtiowTj3xHr2XPNGLknT8Cde7lCo06HbHTmWA
 SrTOlN2ELN6a5jyHqqb1SZhOFV+jaNEtn5b/FUHMZzzjwZGaMVcamRn+dvfu1XO6gZ9WFKPaP
 7ZyRpS+XiKdgdRNEDdfSdQRR2P3oBlxXcD9vLZYy79MNXdyQK0XF5Net732Te/uU+5VBaVr+c
 ADzkRC5tqijt9Xz+4Fp/TfCqKvSxl5xGNP5G/S+Ww30vPqi1HkeTZjhS8LGfJpSx3h6VC8V9D
 z/T19CBQKN6mjT3VUuuDg8BAy9C4WtIx8hpmod2qo1bT0DYMvrw2Nv9q396eGNXwag6txL2qr
 IfN6YoaAtpn78vtU9BLdBq4bNkIUcpOJrot/TcWWQrMAqqp+rscHAlZm5j9cHjX/6caOXSNc8
 bYxF3aOqVkmKDV9eHEywWO9yVMlXtVL+aQHT8k/RU/MFHSBjgCd50WXmX9uJ2Zk0VWcw+woqe
 MOOkLyzVl53OXuVKIQiIRZ6qrYlx/0k2Ny/xzAPVX37AB9itGtPaooWDw+4YwBDTcE1tY3uWh
 dLCWbQIW/7Of8hZXBRfJX0nyq4AbxL3S6lfATaeQzTAjwH/977lajP9PcH5qo1UmM0Hv6pgvw
 o9es89gSF9az6wrt6u7sKcvCrvTVJG/aoGZdOm4ALF0N3rcTXacdVwcb7+od/+4t+I4IGibmj
 tWQQ+NGSx/Kc4+0I5gDCSfiyjVTCEWtA5hyEne8lJsUV//lKYa6h5dD9YzKx1Au01BONmfepA
 Rj4vS6FCmbGp1dkGFjL95x5v+QZOtk2h3GkKDZBlDZutwNzE/x3Lv8XiZGJMgD4yGlf6w7UqA
 pYofEjs3OqH2o+mgH8vMVBXSoQ+08VnaFnPyyqpIVIL0ACNz5VSvEOHY1PqV8yCASLdRQs0e/
 mbvPW/lTPtvzSuTYUSYy+HahWwIM1k4yuWH2RVB21bpIzWqYzIVQZrTOepHUNgfGESX7rNseQ
 gWXCVUHH8NZ0uFOf8gaz+KIzUSIzcR8bRk79P/k/nCvoapK8HTMxS4YwIB5ldqJdm18OpHA2m
 y0XOop+2oJ9du8KiI1gG0e3rbQ1f0y3eEp6GeMuNn4JgKuBQfxewj84civwLtOTtjJeDPS70S
 734DbvoHExCOuijZu1xW/y0qa5VW+l9h1TFo0f8xL3Ujl8WNPdTDweSWL5G8NFMrcqpvJRPBu
 BADksoBYyvaZpJhFnvORiSqh2pj+ikKUzShoLSfZqXBPyqjhkWiAw8sV4RfIvZmOJLv25e7+9
 hOIE7QX7OxICfIc1/u81xJIY7/UxRq4V1X4T15qvWhypbMvafasEWG+h/LSa1eoD1vb8pNQgR
 oq8Cfly1+YhytOUGnnmR6N6bcK7Eb3K+h9pfMvtRtFErcQyhlmtkipx+H1krnxM26SAd49eKx
 n0ORbiW6zf+jG9pnLSRvYTKk82OPX4Je6/BOXX/NFa25Xe094hiQk2om0rUb09pPUjIhW+FOi
 UOmymABrubqfpcgQd7RXFgJL5G6erDrnPc/ShVLjrqXez9g3rPVzN52k/vfrIVBX4L3HgDlvB
 pskBylR8VOo5CuzEHpBHqEZnloAHlyS5s8IENr1/6Kt/6nLPk9BT9yCaB1qZ0Li4y2K/BS9Zd
 m6Y6lsFM4b23Igojc6xdNklxI+X4rGKEf2nzTMrCSjrd0j/fg2metYJSJT0CO/T176t73d0m3
 Ez31qphGFL/PGjBfuw0qlNCIisjGRNQDhu31t0jK0reDebhzouRrA6Y5Ai/PC1RltKyo02o5K
 lk4UmE9JnDYR0wcTaVHyW569H/8nLsXV38FTEXhI3h8NqzuwuNb5cRgHgkBiPl09Q8wY90XZH
 49FF12DziB7kS1bEvVlADWPDQSxPTZQZ1ba8oEAaT0j/EQh8qe7fb9gM0EPm8h1iXspnbnvhR
 SbTkolRjadJ84o2kwO1MHibUySkWd5C4sXf1HigBMavWql/h2yVj6XoEW3LLx5kRj4lzJJ/n0
 6QarjtM5bPqt7Qs3tetCSwRbFSBpy3LAyFR1Fq6XpDSv51r3yvu9r7LRqO/lfDIVxAKrSTodx
 2sD4jAXHSraVnn4LKyhNQCDzT6WHcLw0sFi63XGL34BLc+8YnCTDYBS02dzsZN82uuCrfv0qa
 1k6ypHPlo1PsMe92KmujpHjofv+eCQg8bNs87QzSoUJlHC3nivTsoeENWDaIB8V3Bn9sDphYV
 rBbl+APPjHIOGB04soPEyFqZWFO/iNbTNVCBTkyjWHzqIl/vVQFGxa04gNCvs+FTDCyJPV0Bk
 hfBVD0rop25jYp1zm4sRKF9hmNDI7hxJwwLKz8rXcRK5O6jUYw/ZJliaQ7teqwKdNuNdxwFm5
 OKYlFrXccn3xoEDKH2REaUG0ih0e4TKyT+h6PNvpVxblDZGhwH1zpkbRePKWGS7g0X8k9DOCv
 zS+lVgW1Zf3V5h/1LBPthWLMU7sLQeu6bfeB+lbkKO7AQBPcVUMbErY07H9MTqLspXwUxDh6i
 vYyqBz/oFluYC3X9ec7LEYxFAoKX6uvLQYERPt5j3K6p4hju2LkHvuYVf7BpLPPdKAyxVSjZy
 zJ1cw5fQ6P4Q+qhSpNuD/nXEiGbK6zJvoKDYv0wm52YEK7IxnsPcpAXjg2svtl988D9kry4Gd
 etdSKtxSL7H9l7tFhJ3NyYB+eWoILZedY0UYfmZv+6xpXLOVCmAL1sK+xygGgmKKaN+E5Tz1y
 HzrTJRXRVJHWQw+j/uFWcRY9eIuez2XOCK6pX+++PXTv8dXdMKCiI5cVQlJHpOJRhYHfUWC5K
 i/XwCvxpJFVCM5/50GX9G6FtTxfeCICryroE+lyQtYtPR5n+xmgWZ1/r07f3geAACyBJtJDFF
 dbxwNpLfoR3KtQi2iJQ020iGB7G0NKk1eVnD9hG1B/ox5msITPfcKpxLKD9LEAnGO69J30MDt
 F3wIkagGqYeyASxxJurwyfIm8abwvuz05pGzdaKvlAKsj6W25eqTeeO09fBo8nXVTAR2+htbc
 q7juvrxD+ETkspQ8piebKM2Me5FveC4QecimnEmW0kGATEu/NMlafjhvT6+DwIuX0uH93smNA
 dmEO8CYy2aIdigEP/ibPbz2eDdW7VSOAQ3UdizeNL9D1OvfK0ePp5coW01HIeHj8Nf8K0tm2x
 kdi71oqvauMrxdN/TwvWTmN3IuodSxukttUPEA2dZUeu0Pl75yyKSLcj7d5cbwEpd/eTGjoAH
 C/GCn8hsKyo/stRzL3wQfmM7eVEDoG+iZlGK0WfKqQVTolVFaopExZ1TyUYV7O2KJLmkzBo2W
 DxZ7rSYeihdV3ebPGqfCdfQCLBKBKsUVyuDQjft8QdUCZGS/C4WCMBr7yDICnSeWyyrEnVGUb
 VjH67dZkxh8YsSRp0cqGSjrJsBn1qBDf+/Utas791b7tkXC0dtw1R3hA0oxWosWiTwYXIgfcV
 Gm0lTAt4ESW3FT8JE+tBKuIJxM74RBUwbTtIDxzigMd1lBit/A/oZ5F0mZYr2/U1P4MJPcrO7
 0AwDFOARi6psX4xZU6ZbGQZ/PzM4nHwxSQ4dZY02CMYiygiXyQ2AfZ66wlrcSzmIB7k2U/rKo
 QIXK3VQcNOf0U90qkbm/+6Jx7stk27Yxjfjb9hGHJnrO3zSoZaJVYySh4aptfP6aP7P6KsdHl
 WFqq3ukkq2QbgyQ9bdjI0l3xdgOngwjs6PO/Se7BGQUfWziF2SQpUZFut7R0lkxC6bnWnVP/k
 16A6UzrmWxCGw36olhgZ3E0XDNenUMZbRMce9mwufos3G29nTBpnARYbydtvr8qt5WRfh7WPw
 jszRcHNPO89Gf8c1SHgRztQ1Ziq89AZTXern7z6YyEwqFaCxFmbq+jxtT+WObdW68Ze8nR7gb
 wXAulWeClzGEEwdF94gEbzYWRQYPjYcQHBwu8Yw8CUVSO+LzNgvR023KS0VuVLaIDd1qHQCPO
 GTE/W51cYkD3oqJZLFmIUdSryn7FgFElW3W9ISzyUXzO6fzUPoVhYuvSFYZKQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-304790-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D370170A928

From: Daniel Golle <daniel@makrotopia.org>

Some MDIO buses require to program PHY polling registers depending on
the PHY type. RealTek switch SoCs are the most prominent example of a
DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so [1].

Avoid a half-baked solution in the MDIO bus driver because

- it must reinvent the bus scanning to determine the PHYs and
- it must anticipate the right point in time (e.g. deferred PHYs).

Hence there is a need to inform the MDIO bus driver that a PHY is
being attached or detached. Provide two simple hooks in struct
mii_bus which are called

- right after a PHY has been attached
- just before the PHY is going to be detached

Remark! A slightly different version of this patch was part of a
former series [2]. The discussion already showed that an initialization
hook should be placed somewhere late during the whole setup. This
commit implants it right after phy_init_hw() as suggested. On top of
this it adds the detach hook.

[1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
[2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.=
org/

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 9 +++++++++
 include/linux/phy.h          | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..676cbf183350 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1876,6 +1876,12 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 	if (err)
 		goto error;
=20
+	if (phydev->mdio.bus->notify_phy_attach) {
+		err =3D phydev->mdio.bus->notify_phy_attach(phydev);
+		if (err)
+			goto error;
+	}
+
 	phy_resume(phydev);
=20
 	/**
@@ -1919,6 +1925,9 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner =3D NULL;
 	struct mii_bus *bus;
=20
+	if (phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
+
 	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
 		phydev->devlink =3D NULL;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..3160ca99deab 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,10 @@ struct mii_bus {
 			 int regnum, u16 val);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
+	/** @notify_phy_attach: Perform post-attach handling */
+	int (*notify_phy_attach)(struct phy_device *phydev);
+	/** @notify_phy_detach: Perform pre-detach handling */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
=2D-=20
2.54.0


