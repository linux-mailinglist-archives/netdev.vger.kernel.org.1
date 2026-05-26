Return-Path: <netdev+bounces-291868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NykFe3bFWpzdQcAu9opvQ
	(envelope-from <netdev+bounces-291868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F215DADDA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 152383014361
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60A41C2FF;
	Tue, 26 May 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="stKci6Dc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524F40911C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817449; cv=none; b=b5JaJ1owK/HT1Jc1070wGWLhrJ8wXnOuaLJYHTFvHoc9h2RxaZ1CCzoFZMCgBdHselqWWTySKMMNaiqvscp46CxeKFHvARbjMzhMhHZfKq1dauY3bcfvgKh6+8W39AarMMV4yDP9yG/QhcR1B7Hwsf4cnfMIA87wULsVoE3kEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817449; c=relaxed/simple;
	bh=TKBC+GEcKyPZO4n1FTeRbqGgxd4oMyYNL6mOHh8xOCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4qudgJRDi7df1TM8LhrYeSTc9Vvl5I7v8M7yOVSC0d2xkd0gQ1w5dX2L+V1/xEo9Y/1OMB9+/goPEPfbBwO3vks9Bbn59btZbjhkoJjsAKrte1Hnx8jdD2p55ppNghnRqNpIBdEurrBk9Ax8KOIXlphk48kUIX6swCR5WmGYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=stKci6Dc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817445; x=1780422245;
	i=markus.stockhausen@gmx.de;
	bh=cvEkjpBnpVjZhFzhPLh+UtzhPBN6XYmZhQJvajEQFfI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=stKci6DcwxbRuQuYVXKyA/OenMJLSO4pm0PegTp5icdz7XV7sQJ84k5bBqn9b3P2
	 RLY3OADpMsu/itfydYIjcaqirMx3Il7BFfqCZ2yWAKEzftMmrpa3JUT7UCHSpRSLd
	 kgHR81iX0Q/dkQdMWJnhXQU3nLO3VhSZw2ufIswk2qjpXDHTOJiM4fseIdk7QnD6t
	 +RwiKs6YvjslX6lD4Zezax1rJCtNV1WSCTzqZU6bktt9wP+IMFUcnkfDH8M7qq6Tg
	 p+MudlS9rEaJLOQ0du8pSQPbBlsxt2Nm3DLUZQhr1VbTONkV0s+PH3qobCPBXdQof
	 1eA7IVAVfAAM6hsrTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1x7K720PUH-00i0fz; Tue, 26
 May 2026 19:44:05 +0200
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
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 4/5] net: mdio: realtek-rtl9300: use command runner for read_c45()
Date: Tue, 26 May 2026 19:43:43 +0200
Message-ID: <20260526174344.1186832-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LTim4vD9sTTwe4VHvm+D0n/Px6pK/mbvAFzwvxa3i2cWqpDpKjf
 B4WqEwF6foMzyr4/oaflxhQiZP/UEEIFAasM1r36jcj0NT/yEfz5Vu3Gu4EKKfYMehjh0zd
 MqzZqYwebM4bqnIaXrYcM+n8rQhtE6f84h/pXirXpTKniuSuQaA0ep75ENjJi6i+o6cQccx
 /K5kL+H61sB5iQ7RcW7xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JIFka1DyNzA=;QIgXXhi1mJVLl4ToFZDte1h3xzl
 kGQoSJ0E6Pgt5C11IyhjspezMETqylF6UAktSd8ogohptrFBG9/qpDEun/EayleTSvX14KaEc
 75ve3K/dhr1hHejvQYNSCYKfj7jADDwyHPjYAfwkL13Q9RmD9gpOL72HTNsnQxCTWR4jaxbQ+
 GgkiZZ8pzPS/8x9sIZD25QCM1/D3jvu7YKdYbzpJCqvQWI3qgu+yhP0NUfC8cdogJYT5xZI+k
 KbETXrGCCLfZcDpR0t+Nqop0fm/DYVISZKnI1n8cTEifQj/MKknnBnB85CFa1q0NY6LgjhJfR
 hUn1ySKyBKEcPF1e9hWWNtV/iohDaQFOPllcLHsN5KgITnKwtO8KxIHKTcvJHY6RxtkUed9wM
 5+kRNGo8CUGCauLciNVQm2fiWWTeFXoNbsXaN36IZE6osWvKy/K4w/c/FxDIHSv0G7WhXd72Z
 LeiQYFOtRPDl572Nd4T5cuC5DjnamhHd+FDlmjIyFQEh3pouk1TUCfCnVGgg351UINsHDxMCl
 P5Uib7RJVxjidlbfIYEVCdfHU5Tpb1C0erNUa17mh41CM5SGGJ+IgJ3WFkX6/1s2u79fEp1FR
 HzUg9+HqyAfrQ+8c29lVe11lptiH/egpZkJ/j1xvkruXOls7NdQ3lBjBt2YC8BJHAw4KE4KJf
 Hyi21xvCwgWNfoDcwr7Au152Rk8Sadp05NXvBoR2KL+nV8HJmh57hm5ZRKDRt3pDP+Uxr2rQu
 j6yD1/0csDJeaTf0CxwQI/tIOH/z7Q6OvF/sE/SL7YzusUJ5Am+sO6RKbK8275NcyKR9q1n6R
 Nxlz2kHp0RJ5iKNrG47nhUT7SC6Ztc7Xtmg9MNPD9dcgeOjUpIySDOqpUy0SUSvcckkwkL3Zs
 XbqRYIiuIaedxzl0pUkk3NNUqcql3gnL7N4EEz17/myf/JU1D0Zk2Sy8d5vi9g6mC7Lziy41O
 DSzErF/Tkj4yyp70m61u24UDMyS//7QXgNJDoZjuxuo5O2jNXc6IpSlcTOC7s5Btmkm1SIEQi
 jr3x2E1f8z5t5sDEye+2i+IyFdpDSUFU87adbYw8NzeGwvH3Ba1aQMq4U34QMwhXA75Q2zEFD
 rK+Tyka4uXfW0AqZSbqweWIgU2PgzMWvDsH7mw0G7U0jKeptFx8CQKFkX0Ek2tum4tvw9iwBd
 AAmtez/AGfrPEN3DPZ2h7sehk3JKir/t1DwmO4vFu8AloPe7JkuhTwjMKT8YPcun891EEJCnC
 Vvb/1iKe3jk10D8O1K1eX5YKQ8kiSivi3u5diLzgG8GywTJi91MKLEhsoZ5xcoek6sB4TGJc0
 dkrpliBtzEQRXAmLyFTBPwQTy8NdlXQ/aDey6zRuxpaf4zqj7EFkUaOcbnpN+Rcq5DmPG5Ppv
 yIbSFyn28KPEf9+mPX06NYJJ1wo/uFeoHMOZnT9lY4lWShmC/bx+iIdTS3dokOl668a7Hv4aJ
 G2ZQJQt4PI8Daga9kcDQzA8E3taT8PDHSpuMNs0zJ0CI1Op0fEfYuVbdgizkZZFvq2iYy9pxd
 7j4UCffVAliTVUjqleVglPM/E3V3KgyYtGEVz37KZr0UQWxV85qUIGClJHAm3fAE2zbH2SO8V
 AGR093VYbFHyjBsA8ozMsm7y1rnSyfiniQZfFPwXIWsg1wTOq3or3ietqYnMfhFc+VVSfWNJ9
 dQKYUWMnB4BwqQoa76dGaNlfCjrFnIzS3F87ya9TT4czZXVlo58XTTBiSOWXu43eAsRyZ2P+f
 zgU8DS39XuQLoFhIwCppGlHNgb9r7KyaR2GvXrJ4Rw63NqN8zOT/xoj//ohjVcmLBAkhdvNC5
 Cnc8qVRqHw0Vp5nZgtRIE6/mUGmtoz0FYLkDoEg9u0juhSuVKCzKsl3U9HfSiJq68Ssqy/1UA
 Qzfj9zK8vTsoF5oJIzdvO8/Ii7Il5DkWqZdsKKDHghT65sBIUIP/7YB17yTmv8kRKsOJbhpPL
 CnYAq7R4FJOoMMpXgkYtbZFHaa0zLmEFIwiGRr9Nu17sybJldGqVckz+wx+TcTaQrTGgsC4r2
 pnu/g9Geml9c5J9n7aQFEV51yYgj+6C+J8g6t4gSwa/wWM0Wtzy8+l3vtz4H7IZQhh5LxoEL3
 CGyOMSHYhaVsLN2eEMdTaIl3k5NTR1N4/RSLzhsWL5oHOX7TvLIc80twMtIKu+EoPbOqUuHyY
 /qtOymiyq9H6iqx5bmlu3Gbfu9RY7+iwpTPQFr4+WZjb4ybYZ6fS6gpaoEk4YNUThEu8mAqEh
 WAGKtnolUmNDO6bnSpmOPSBOW7ChWygjcLumsM/ojCZW2NSVuLN9f5xEyHkKYd8PBTExMGytO
 mmRBsQc/FCWwo/reFZfs+YMQTH43H7eIDVcuEwYa2244qyeVKiBe9n6ImhTpzZfni7zwrY6TP
 p3p2VHvFshJd60fVxIRMxDxR8z2gQY7IQI0mEcHU+P41V7N3m7VAP2DuHqPKcan6gASIfxtcv
 +K9tN+Y8hrglja9FTVNRlQ1kEQgQdo8SiecYUzxOGRfrdkAItRKpsaxUj3xT8TCqlX5oc/gtg
 NgJU9Ig5vfaRlyr8IF9+U+7BTd+fAybQEw2QrQAk6Q71uywNglCUFuOn5xW/+B8kmCRXSofet
 oSSmbop8L+x8sKnhjUOOCSQfR+s+2KUftxpdWFIXQpFqf579kLD2RfaeHEyWe0GTqIhDESE6j
 B7Qv0V/mQTZ7IWIA0F65wV7r5lLy2D0PycNsI0OKRoKcgtADcNWHO8vj7gqB0Wwu/h92iixtR
 7wvYWFc7ueTlGV0v4QOah+sAl0ZiKqccrCN9FxWi5sAv9d9qdCyQ5JMIC/MtPjhJ9xUeHJn8Y
 VIU2Mc3z4q7dOQgW6uuR8jzX66lvD0tOAvYT4RAQWBPoSaVpFlPl0f3EmTuxU1/WyKldakDyl
 Govcw0Y0PWUzPh1kp/J8jU17zWx+UbPMNpwfDY95bOVoQ/1DDgWoFDtSM3jQGaAXxG7w84BvT
 40EvypJmTSwG1AwThb1dBU/szwepEdL6xbMEZS7D4vaMPddhYFMg+59OpusD/L2TeQQizU/5G
 /7fAqruUgvOKCTACOsOWkmRD6Jet+8ZSpwNDYAHmONAisO1rwrtVphM12Bj4iDcksnt86QicW
 t8aLR/ZyRDdxwcW3d4t76QoWp8haYFofudHq20ayIMEX7IcrRoP4L1Ka+rqvWycR7sQ9zI0wf
 o8BtBMzz33Eomr+tj9GiCthKdPjCl+4q/Zk6ZtlI5h79hdPfbvfTeAYTLREb80C+nODI3lVay
 S6ghJBEQ1grNj15OOiVYuJTGNv8MUnIbZfC+khTAPHiThw/7NY0RIS/lVyGLXA2NBi0VCZMgO
 JFdMelygVEBGzAi1gARA5r6IDR55UJjA8x99gVi3AW0qQv+RPTvOEVA622nGQg96motKo5A8D
 PQ8drvNHKJEVNnqTklvhdEGakeY5Bfdj/wQXBQSElbNxIJbomiQLg5A0Qdb9HMXIpbZnGHpXv
 EhuiKdkOGQqFbFiYjLeMaXzi+bc6d2VXX6+MWbsXxwHQZT18ge5kg3oGmBrHnZn3tqsRVOFrz
 BLt0v3UTJT3DJsHtxb1R3RAP646vCVgK2mZp1wCZZ0frTruPWa4VUaTbiFgAF28BNGo5DmZ1a
 M/NpSigCWEeB9Psxe63twfVIivFe2CszorIXloyINqrX2uhoLuxiwMhTZNeMD9k4IPVKS6LaB
 g4zuuCWmKGBU7tSqD+I1OgRzyV2qXAis6LwS7QAlwb+fOE+t8v3pkNGG/bwHx4B4JLAO0UqIS
 QbR7hPoiYR1qgzOojAMep1HVntJkptnrIY8Jngc4mTvSo5LT2EjhL88tOaLyrFVML+tXaj7E2
 hvuvbARY5bTkSO6qGck4yLHCFK7kEbH/PD+T6jnIk9VyDwK0iqo3kJas8MZB9upIjip70KYct
 iUZ7pZrjNT2LV2iF2TpwqBp39OmqEXK3+d4X34wMzAppnZOwr8j/7E8XeWPOHmL5FgTzxXMh0
 c4ai9IPyXzFEbZFiCPxSXBYUZUVRHad0Nbcnzmv60Vi58N5A0VgAiAwAnHCQ2Z4vqUf4K1Tr2
 MtIhK1s1pPRPDUgR33TNLqBnkUWZ8olOTP1a0UIkF85LOFQRXOz+X/7lbRr9q963MjkO2GBjq
 7BUI1bA8reB1/g0HWMcYAxrZPLZhVouWCU3W+Anuqpcm49y6y9t28a9Lbf9sAAVTqennFI/RH
 Wo3gBoXvyMVeIEmArOIQOkChOnIB1MXWuastVhHVuqjS6v0sN11DB+/aozJWj4hP+HEhQDU15
 jQdVFwSzM4wrBY74XK1i3G9K5VQi488vLnmTvbdey0JsEYoxoteh1e2LamQ3xyXdvpyF7KgnP
 hki3ZVc/LlKi8wcnBrVAKUgvmrJZ4eHSLR4d3XG4F7y3TPuQ48Yl0LXGqU+WH+IG4muWKVVgO
 1zeG04edQme/Wcm1cud95FM+7zQzVyAnCOs5SLNVeAtXEnKpxx5wnfqAhnf9guqVm8yC84bOj
 0KT2M0H/N6UXYi6PwgtQAPoVq0/lvLqOsqLXwzEKCEpvBxgV72q7h19M2F9xVonFp+CApYNPp
 JCiCOzUUi5xvUzwqFTATWHfFHJMLyo0OtQl0ifUIG57F1u3Nne7/hL1F5AkM/12fXsDLcoU1Q
 3SakpKuo5OL9DZf10jz4vlXaC/t7/lIoVVcf5j1sxAxBmv7fGLmzMR1QlfWy97KmL4JXTruKd
 p7QRyQPmwP1R4EwDymxryK8Q1zuKpidQyXARByW2PLavO70oAS/L3k7Em8245YgTF00nQRZ1c
 WZQaF5vquhjPplsqACfO2A5Eol4fiM7q9kuKX7MbcU8WZ81Gla62TTWr4o6Wwe/Ha0SNbmf1p
 Zs18QIGaw6jjy3SaXVVDC9A4k35fWwLiUQz3jLWobrhntldfvhu5p3m2QXY+/7igAObbqKNyF
 cCglfun66qY/vZA8IhEZKvSm9j42A1LQ0bqhNA+46VUQWmnucI/dGaxHgFnuAdBeOf29RX1ID
 vBMFjlleK4QIPYgOH5Jll/PsEWCocO0xgMLMxLPecPwpb5KrLKpd4rIpsfsj4+Hoi5IO4qeM8
 eP3aTYSiFh3FjI/4i12re1M14+O+1zbv2Fe5Mi8qm7edHl1uOXv3n2UC2ypdRPyV+INHIDgQT
 a4mBmUB+RztZrZI5wevpDKwxG4ou7IDiTgPSw+bWhdPivvALLmejnuDLyqWeM8clZZe+ZfWua
 lwVP0j/BnydvvXQNQ3a4OlrqLw/1rniHOcOOGqBrSsCUHmrq5UPq1HTvuzFzO9zaionEncY1q
 d/HnxybidxXoVb+ChWC0Uk0cgGPo/C+QJspbaE8R3sp3L0H+IH5/I4QoRqsFU4Y7KxKIrPZMB
 sWl5MnjOPX2/4oub1cBQTNZtNOqy53StRzvogJczt46lvM1HpDHw8A9MebW64s+TD70phsqmG
 MiDzyaOLs/BzbNfaCN/P3QEPvb4P3rxa97s212ZHEsgq1R7PcakuCxfUSHExyipJ8cEELXcDn
 SCCX7FW+quWCdiS82zHSOCOWELVfTjvkZk6xB9DOvfbG8MBjw1qKmkvHW5B7YWwmwpmbbJwKW
 +lbsRWEcnpz9C/v9M31jFz1jgePf3Ejf3oC7stAQxdTCdfjL5iAUslPAcB1L1653ZNocuBJ1S
 s3gUWmkQlSdRiNIW4A=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291868-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2F215DADDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the read_c45() path to the new read enabled command runner.
Do it the same way as the write C22/C45 implementation.

- bus calls otto_emdio_read_c45()
- this handed over to SoC specific otto_emdio_9300_read_c45()
- finally the registers are filled and the runner issued

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 78 +++++++++----------------
 1 file changed, 26 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 6f4affe0696d..10a433e497a1 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -96,7 +96,7 @@ struct otto_emdio_info {
 	u8 num_ports;
 	u16 num_pages;
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
-	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
+	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
 	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
@@ -268,58 +268,16 @@ static int otto_emdio_9300_write_c22(struct mii_bus =
*bus, int port, int regnum,
 	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_=
regs, NULL);
 }
=20
-static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
+static int otto_emdio_9300_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
 {
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
-
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	port =3D otto_emdio_phy_to_port(bus, phy_id);
-	if (port < 0)
-		return port;
-
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_INDATA, port);
-	err =3D regmap_write(regmap, io_reg, val);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
-	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_READ | PHY_CTRL_TYPE_C45 =
| PHY_CTRL_CMD);
-	if (err)
-		goto out_err;
-
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_read(regmap, io_reg, &val);
-	if (err)
-		goto out_err;
-
-	mutex_unlock(&priv->lock);
-	return FIELD_GET(PHY_CTRL_DATA, val);
+	struct otto_emdio_cmd_regs cmd_regs =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_READ, &cmd_r=
egs, value);
 }
=20
 static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
@@ -350,6 +308,22 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	return ret;
 }
=20
+static int otto_emdio_read_c45(struct mii_bus *bus, int phy_id, int dev_a=
ddr, int regnum)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+	u32 value;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D (*priv->info->read_c45)(bus, port, dev_addr, regnum, &value);
+
+	return ret ? ret : value;
+}
+
 static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
 				int dev_addr, int regnum, u16 value)
 {
@@ -439,7 +413,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D priv->info->read_c45;
+		bus->read_c45 =3D otto_emdio_read_c45;
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
=2D-=20
2.54.0


