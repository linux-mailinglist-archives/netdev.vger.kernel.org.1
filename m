Return-Path: <netdev+bounces-296256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lqt/OPOXJWqyJQIAu9opvQ
	(envelope-from <netdev+bounces-296256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:10:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33132650EE9
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:10:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=DrA2cCVQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296256-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB153007F47
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66822E736A;
	Sun,  7 Jun 2026 16:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADB284682;
	Sun,  7 Jun 2026 16:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848624; cv=none; b=L6SM9O0xgUAKMSkMSOHS6xQni4SBAdguyKf21CbQPaLUWim9ysycqIcSzqOa8PekrZj/dWWFPAZeDym69N4MU6jsh6Y2YdaLFZmJ8oMChV7JomO0rPKTqdogUevHOlPfV1ryfjtieuME/B+Wu7BuxtPdvrP/fpGY+dcWCiousfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848624; c=relaxed/simple;
	bh=g0Vo+tXEBXKyC94/HxGuD5MiElCQ917r14BJU87XAWE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGyDNFLlkolmLuxMzi8BfxmKKqx1K3s2w91OMXVoeJ1MC0d2aBZ+SZ7DyzYCEJ65vxaCa52NSZU6gPEMPvUzSStTmz8I78yjrrS8YiR3RktB5kh5YDmGVPsXVboOkWPCqNj3IegV1Bxrj/B5TSn8zBtnHfNo2GtJZGSEJ28f/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=DrA2cCVQ; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780848598; x=1781453398;
	i=markus.stockhausen@gmx.de;
	bh=s90ND1ZkkdsB+sZqJLNOn1cTofoH5b9g01atXc56HFU=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DrA2cCVQ1RaYgDEFNLeUPShWZh/btGv5RnlA/2yxQ+t8+xAcrIvf6pK4InvNP2In
	 T25AGbkQ3pGWDArJxSEQlnqRjOkyTyNLl4O/bFr1ROY+kIxk0cO7d50HxynI+DcxC
	 LhKo8qUZWl7x72Peo84nfAwq0LGella0Fs8eONqpP5xXLFnE4qwDBLFFk1ubXoHpq
	 30GcaQG4VfyneVGDKkK3Vi/NvYCg86No9pgPJA7RRY9Z5jOpnk3LwQnK7o9ydjt8w
	 8wck9uLF+aV+V94tDCjytXOWV1i110u78HX3/kAMNesTDpBC5zyXjcEc/2PdFu01m
	 iOO97ULEIZYVQGTRPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1xQGOo13O0-00tmoo; Sun, 07
 Jun 2026 18:09:58 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>,
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
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260607125406.2853607-1-markus.stockhausen@gmx.de> <20260607125406.2853607-2-markus.stockhausen@gmx.de> <0bbe9ff3-5d42-496b-b777-8eb657b6e6a2@kernel.org>
In-Reply-To: <0bbe9ff3-5d42-496b-b777-8eb657b6e6a2@kernel.org>
Subject: AW: [PATCH net-next 1/5] dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
Date: Sun, 7 Jun 2026 18:09:54 +0200
Message-ID: <003b01dcf698$16788010$43698030$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQIUbFKmgVOGcbhv3p98ab92Sqq5PQIsQ4yOAlsnLGC1oBvGoA==
X-Provags-ID: V03:K1:t+na+Z6kyu9uh8SBCuSJvsQaRRFinCpRqkJ+LpJvt9xEF40u1OY
 62pX7zyFiK5JpKoqfjkzM4UWfcinF4AkrIZBNp2uveZHvvetqYX+QcmfnVy8ZB1T/LyNjAE
 P8rysIT4mDB2rITSM5avJmjGbWc8CkvUY4a0IM2SmpL2+HlExAi/O8ZKdxDVgZttenb0le/
 U8jxc3WjGbQR0JUvi0LHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KhrXKFPwc44=;lqrzOri+yjV1GKyAz/ZPhjqI5jK
 aS/nINWXa6zLpdtS4WVXRxTW1AEREApy5j4F1GEyllzP37MalPJOxdsSb/fQQhtCqjxItqFlQ
 98Js/Lek/WZbzYgrDCLAxD/KpR13VA8zFmP5vMPQxFOUBk0EHIrmmwgCLsyLFI3DCW+dBOhVF
 1oxpgdflt1jusgYQnZRcZQmEBjQHOzNWyGmRMX8wmR48X/CrxL2w5F4JsClaIwZtOrWn3W7d6
 mgsI/afZKVtZ1Jx+X+koPtmYeQQ4V4ABH/2d7FHJDvfYz2CcvOwxxIp8YrelJHswK49iZzPrE
 3MypPQc0DVjg+5wmu71Zz/WAYddfPlw9uurAq2MWpunD29n8VU76RyFIHIK93P8SgyZHx8cx7
 jC0y6x8FhzJtpo1+55hF2fILolwB8bojp/WDji8+DxPqU6zSweCNO/YUdmDPgVcrc7l9rLlNc
 TwRshK7GGNgEB3luypV3Ijacy3teJ1S/u7+0gB0hjW1Mf3khlo+vcZCrlfaLhusg9jRGhLFb0
 QFyPSYPpD/mwCLakuPbAq5hZYOhSRRKXwiQa5NSVFYNaAFcFv/FTTJ8L0tLJgPEnat8z3x0dx
 cXpIM1WVyjMiH5Q+PsbbckcoLV6HDejP6lBlAn3I8JOz5VDkVByQSn6SuWciIOkpfb2R4z+Xv
 Qh+apU4Mq0l9LcfgEbNbev/BmwcIjOa3o2Qcy4vlHJIZM9KawHXDAS2gBjQNDcUyuFjR1n67/
 lNwqsb85H6wl0XpOID2rINELAMaFn17Grs5EKAndk+QR0zhKelndt0h5NWPsumR23OlX0UIkJ
 9xM/yzNzt8tCpbcGcy/AxjJrUOMYrQdDBRHHQuhOwKYR5HAMNOERxs2rmwqUqbX/EOUHWJ8eJ
 NIHAX00bphlEXoS5TB7PzC0VHEscnY7t0eKMwP+0R0gSNbB6c5cvolHtq79mxazJYONxJdWn0
 U79yKLQFKgqByIKxkf0uQSC1tyWYNtTYvMvmKTuD1tITOJrwS5nrMl4dhKhDExGgw3P8G/4d2
 lNS8YJMHiZjd4UY7AhTAjZ4DnBMzK/+dgiQH7lWfsAEsI5MtSGhMKQ1Glf9HlOHAx4ckfQaNW
 pLt2CoBxJYciczCLlsaXkXCuAcT/qq2TkFF2uOE1pjO5gnenye3Oh7fY3RM1BmItuQhfMyIIo
 MsgX8DLAzmfl8+Hw1ezEyk5dKYkqTWJXn6V45ZQZ2tjzlm1cWKI10q9uPEMkg5pI5cZGDQSgi
 IVO+O1UhTKtwlDbeOxwzhhqHZuL5fYWtHMj44LMHCgLvAODjiKj9Ct0Ja7p78KgDib5ukUUiH
 KjP2IQyLlUQwt/BhCnaSF81Ta5w04U+a60EAmc7rjwQI8y4FMP/AhS21iUzbl3JRZwtuSVT/h
 E0c76wrIYN+7WWzmEglUFMT+oMggMUs72YCCgKHBMCP6XH+mW/YsFpp4PhuVapFfJLGTApG3T
 o26/v0sqI7wLLsZD/++SP9OVmJ9SFYgez851RhxBc+8QeWEpr1M6Z061BeE5YH0XuGB6+0NFY
 OT+U+fLMnz8ooxLWaR7wSh9H0d/1PCk9Rq9eM9C3gSL1tVR2tXlaEgVFX917Py8YHqmWQg6iJ
 vaw4L7zJopjMm2vtJ0AiHmgoi99XnkQU9zIl7pX8FCjYmZ65/f3bsWOUiJVSPbGAVHd9ISeen
 zgI4kaXuosTlKb8I7eNYo6hJc0BtKVKApsHQen7fK+3Amj8J4d8CvmPcMafxVYppULpMhKZ+b
 kWD9OkQpqwfDmRnJ7Zpq7AvSUFqyD9A6QR+548r11sCVPSMKqPsuv5+DzC3PKzS0mtAj56iNM
 3DfEf3xEFDCho542wMI5JG8K81aFR44+ldnTOuFzK9/NYr0dZfiLDK9xwcrmi1Q0L54YK6fP+
 dnq3YVAL9ceQVnfODT2NFnUvXMIwTQlAUNjPiHCP9cRs/cz0+xulXCqFUATjh8ty899yGZbFr
 FjzYFsTBayAP/ZKpPODqY59T/fBJZuDGNQ3Lgx7axqHj5IcghkIlCR7HhjwjnQ7bG/XN6/R+O
 vtQG7sPkK25baM3KLnUH/8hLB+rTPu1vDkr0JS6/nceraay2QybiP/E2iEI7YOmdIdAe8PiBm
 11AVjaW8k04ggfIxQdvT7myf02KdI9sv0zZYnnGd51Do8mQ05L6DWZIv5qBDLAdUHxvioWp82
 mweG1upKipE9mdmUxnMl93jXJ0hjs0080Mh4PZzfVyasrYm65bffU5HWcN1q1HtTD/jpEU+XO
 B6ULVxqa6JRRg4VuWfLKSJpvfNyRMpIB85m5j9ONw5K9dI0ABAXKsgLNqbQ03OYN748uzs2Hr
 zhjnXVTqfV59dLgpIxJ13i8cUrUrBKTZ8WY/1WeHAwnqovKPW5hDWul2sXjMVTIkib6LDyt7c
 eGUpdLIZgbTEhpbyu2u8SCuyN0Hwvnn6rO+REOlnniIVR/nhC1rzbDT669XFUkxpGbKuhquhj
 SUDIjkZXgqKAV10slQ/oHvFJf4ePU45cl+kZlyWoxLahx5O19mgaC/SdhDf6xiJufybN6x6VK
 J6ay6h83G2tGa7XofELMVrHHNj8x3efcWAA9BfTX0/18OODN9cbjMSD5PwX17zq39UyEb+HzT
 w/vdeQ9SeVkfNWsQo23rpWZW4+eJ8HxoYtqXsxKPeRl70SSRiMu62sU2m7foRWrwd8jq0wYmT
 ebVEVBOaoO1IDuZ1mfkczK3oLTnLDfUnNCrgqqhd25JVqKOmRZZekBL4//YsHSAh2D0T0K17j
 rgf19LG+IZBAUgE8tr1saDRMloLQTdmWfoGHtGqnLHlLPIgHioQJwuYDwsAFZ/9cyvW4mgzxO
 B2t3ZL29pqdYrWSN5QDMDBh0O65PvB+jjVgWdRtb3QLBTDylATTrJ0T4aj7tWExC4aeTDxf84
 yRnRPM9yiFc0JpkG8NfG3V7OjQJ+6CJNvqnwhR3hOAlgNV7NjQ/IHEaAV3eVU2yq9JrJ3kFzj
 1iyC+hXKYBDNX1MhQ5r0fDd5/0GwhULgqvus0vzgiwpofXtkrKdOWJCPt77jrM34LFWTE1BUz
 VlJpN9XdN5swgvhHQADnBY+D89HS+dvA9ln4NKhQKp/+E3kh+dbQarOzJYbLrj4bLYNz0Rpsw
 OmbJGJoitkICBTsfSme2Cqo6KXTXG1ACV4Z1ViYsbtXwbyzuUHXghxOettcZHzxRI3cdEID+U
 4HX8yS0KgY9qMhi6+TAnjg/f9sad2fMI/6Dk3o+ZXmuzXPmW1CQLxZ9lHXHSY2yqq9Vrej/h0
 kc0iv7F2b+c5qeUTzOPR0XB+dAXwrz/TY7a5pLMbwCsR+yzWTyMrXIgiVSe7S0OdWAavlObJ6
 fnyhesGP3LZ2kt4JLOVQj/3EHrA/k2jo6xWYVFcDx0PV4A2rOotrZj+6reRmPfegdgBLf68l5
 n2BADFM2wXPVrif+y6r5Y8lBRJUtyrB5eawjE9M9YUx8rk4pBYq6uJGGcjOCWkKZVuMcit100
 dfYqskFgXbpU2LQ9oE+oYpkP7R4zkbomZkiSKS1H3otBvHLkI8Ww7Y1+qldsojQDHADW6i+EQ
 2l5OQdqg8EAZ/WLjva/3TiikqPsouGyq6NkfFk6fY7klgGJuz3gvoC+jXYhKJmtGvW0tPd+Nd
 7AfINNsVNDxtGYMQMztVk6ni0eCNX74KSgRjQJjT6QJfcRypky7LGtlZiNdJFco+bNklZUjKF
 XqmQ6UqfSnpnNyYt9aQBhNRCv89wCngpnZqPccws7KmK+MYJyBlU/yNttjWHvIfzs7IoMeoC6
 R792YVrpZ/zgt0I6V5f8Fjr/0QRBbxv5ljTtg8Za6NzxoA4v+5Zhc9wV8SXhAi25skJjgebiS
 DJsTKqK9ShXC/y37CarNyQzmuNtA1+HPOLXwJfukpwOq8jCecCg4J25z3xDdNbEqEil+XHlk4
 nWLw0EQRxbUbOMTJstNDXKbptFtK4cp8eFG4b6ik7e8hK/XNo8kfPnnozC1kc8i+znsdBOtUY
 UaaG/cqfIGKqQM8OHFp1KCzJs/KVYL02fxEJZLgLYHEFnA0c0MS81+m8adetx6j4eGdgqmvY7
 lN5x2Dk0lhPjWFbIyVA4klIBmd5m3LsXElAgisgaNu0LRzh/T3qEAOiHqCditc/FWX443kniE
 P7UZEOTdBL8X/qqJXRDoIAnzRuEej6Mwclojg5YsNMyhLtBI5JNZEFNra0CO0stLwUFD16aWO
 BWhNioDKVovJy7cGaotOLyR8btR/EDANWXJ8P4n0sY7ZSk8wZxR1dc9rnrkGCsdM3p3/K+Lzm
 79GK+C0Serj5t451kWO4326Do6sv33sptsy7t6mq8e+pewduGsovVv10ARw4y3L/E0kfnfVfB
 DQ0hCbr9wm0xmDXhcmbtBEhDbDN2nCGN3XTniFLTyUgfb8mu6W+z6Qk2ry/GIruQyAMtzFIlq
 2a4WeSk9r4vrEFUlhnahkevqfCX8HheN2GugEX5wZF69A30nWnZF1/PySCwF578bzdrG/lqLV
 1mvR3uLCd4fiK3hjFJXwOoTfdCY7pHDgd14bKWyW7aCY0X28gtK+tSyroO0OghT8acBVYyAaV
 SWP2fX/4dplocEU7GeAz0YH6PW/F3JK/B94Z7VP8d30P0qXz41pn7Tt9Gm9y+mRnAryfp8X/K
 eZebEuhb7RtM0I0XB1oxgobzjOeydVWpW7HPGeXIL1rkimpQCjLy7CDzxebgcTiZIS0BCGNss
 BBd2/kOoEC3IEqI6SDVdNNt6OO/iMxeubzIkov1CB2+B7RBkVSUY5QkN7hY+HAsNxS0JdJSQz
 h0tvXYkWO9zTn2sfg48yPyf9PY0ynFRo86JA4lEYp9XcM7wP2/rK4Rih1e/21K1Ooq1pyHcrY
 xRI0YRRoyTw7by33lA8RtuMVYHxphHZgSb2dySHfIwHuyjebyOZUzxxzl1vevfYTXfhoczIzB
 C0bbRnOl76fUMC/5GGOzJONwQNHKWAMH88KUgAFk1gXpJKu+Q45I5WSqktsdYgOdUEHbZ3M/B
 5Vof8IGK7A/aoTaycQ8BR3qd9fesBgjfb2ts0i99WSH83xlR12RUDw37SIthBrwmtAqO+7ydZ
 DK/rjKfUbmI/EWKU9Ogb5W7/hyznzOjgz/dpNI2DBqL1dkiXFPZnZzku4E0bjFOoJFvI+QvBB
 aB/IuenLrJGEV/JmrtBi6O9aNIP9/0L4lrrzxLC7oOhnDnJkRpWVwXX7/98ITLi0LMYMFkXmT
 GSmTB9bFTyw/hC2Tkplsk2L7fR8xswwu+THmZj5hLnEWZCDuvdJgf/FGk0HyQU3pKzobVesCt
 VdpMi/yTFt2+0QOwpUyl16CtI4t0llTX3fau5K/tcucWNRsDJIQZuI6aWroQ3j7hkUAesA7g0
 ZZA3flyR0tDf4iv9NTH2Y/BoZMimDddDvE1RQbf6SM65LWybuTg/hJVqER+xNj+Air36063/v
 2pBSG3jdwG0/ZgIn3cOEGm9jhOEl+c+oCllSVRf9xMlXd1lEcDD6OTi3TgEU4PsjxcjBVCWl6
 B5HxJ5U5kp6ILvcqcAbbWav66D8i6LGTnUkSqR+nLCVKBEgMf9yGxFWk0pTLAC5nIeWET+PIg
 EmNdGmd6hUUm/Z6dF2T+n4sdFr5IFp8xNHhfMlzuYjMGryIyZzhJ8Aa4gjPPOSU1YVm7EXsTW
 asz8bmm/nzqE8Zd2PRuvQxvbW3yvaT/pI5DoRnP
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296256-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33132650EE9

Hi Krzysztof,

> Von: Krzysztof Kozlowski <krzk@kernel.org>=20
> Gesendet: Sonntag, 7. Juni 2026 15:11
> Betreff: Re: [PATCH net-next 1/5] dt-bindings: net: =
realtek,rtl9301-mdio: Add RTL931x series
>=20
> > On 07/06/2026 14:54, Markus Stockhausen wrote:
> > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> > ---
> >  .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml       | 6 =
++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git =
a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml =
b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > index 02e4e33e9969..494c92601e09 100644
> > --- =
a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > +++ =
b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > @@ -19,6 +19,12 @@ properties:
> >                - realtek,rtl9303-mdio
> >            - const: realtek,rtl9301-mdio
> >        - const: realtek,rtl9301-mdio
> > +      - items:
> > +          - enum:
> > +              - realtek,rtl9312-mdio
> > +              - realtek,rtl9313-mdio
> > +          - const: realtek,rtl9311-mdio
> > +      - const: realtek,rtl9311-mdio
>
> That one is part of enum with other single entries - rtl9301.

This way?

    oneOf:
      - items:
          - enum:
              - realtek,rtl9302b-mdio
              - realtek,rtl9302c-mdio
              - realtek,rtl9303-mdio
          - const: realtek,rtl9301-mdio
      - items:
          - enum:
              - realtek,rtl9312-mdio
              - realtek,rtl9313-mdio
          - const: realtek,rtl9311-mdio
      - enum:
          - realtek,rtl9301-mdio
          - realtek,rtl9311-mdio

Thanks in advance.

Markus


