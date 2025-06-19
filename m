Return-Path: <netdev+bounces-199330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F67ADFD9B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD58179ABB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AB246764;
	Thu, 19 Jun 2025 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rWE+SHUf"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1451DDC3F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750314241; cv=none; b=fzk2xodatag00eTbdPs5yGn0Fc2hsjVEnSE71H3ijZsiDyAyYFLZ/9C4BeJHMf+YCs4UA6ktia6u8Jgy1a557uBufNv4a5PqxZELj8Lyns5a489e+ES2JpuUk05XNJlBlbFxoYKozexOP07CTsuEIyRhv/gTkB4qR11ErkabXq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750314241; c=relaxed/simple;
	bh=5LjBWYRy8BJpfSBtYSfGdcTqWrFdMcrKCoXxBTM0GX0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=i149Fyk4RODqlikMU6PwPnHmcsYkEWStWqJSEqw17Uja4sK1FRSfPWoamneI9UimKGLy2Q4krzGVrCsI9YUNq45URaAiYGt/L+e8Ay3LWkOKSLexGq9Bc2BBSvbLu81su9NM7pUFMHxDv4ehuHf/JiZqFQwifTgyYydW9rACnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rWE+SHUf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750314200; x=1750919000;
	i=markus.stockhausen@gmx.de;
	bh=GL1UBtfdPT2szNCuEShxk4OH+o1CirpBDoa0cT1TwBE=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rWE+SHUfdRdmdbWIi8LN0Hlhd7XBrTNh/XkaCzFxXWS6IcngQmJMGR4b4BADgZI/
	 n2ExHjYVKPWyRy6apzxVDRviw19eEiDU3gOapUJlV3hPTC86cdK8M032JsYMpRDd3
	 dzBiQGRzw1dNO50qlt854CMv3IC7MrosuWhIyomIGeX9/hTK2Lq56l/vrjodv5egv
	 9KKmPbzkkoB6EnCGFJu5ZisKaK1eqcDOgYsj3KwfAv8nxeFWKe5o7YjKzF9fkBt3w
	 bOz9T2LqS7vfgK6v09SinNCCSZisGCywSCbHK433o00gL9J8mqy146X9W5T5xXzh5
	 Q2NQX1eGlF5uV5xibw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1uPOqz4AbS-00HF43; Thu, 19
 Jun 2025 08:23:20 +0200
From: <markus.stockhausen@gmx.de>
To: "'Chris Packham'" <Chris.Packham@alliedtelesis.co.nz>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<michael@fossekall.de>,
	<daniel@makrotopia.org>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew@lunn.ch>
References: <20250617150147.2602135-1-markus.stockhausen@gmx.de> <6e0e38b4-db64-4b63-ac36-4a432b762767@lunn.ch> <788b01dbe016$b92c4470$2b84cd50$@gmx.de> <e63c2332-ade2-4c93-be21-a550125c543e@alliedtelesis.co.nz> <5a1c5a4a-284e-47c6-af6f-cd95ac08b680@alliedtelesis.co.nz>
In-Reply-To: <5a1c5a4a-284e-47c6-af6f-cd95ac08b680@alliedtelesis.co.nz>
Subject: AW: AW: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Thu, 19 Jun 2025 08:23:08 +0200
Message-ID: <188d01dbe0e2$a6f73090$f4e591b0$@gmx.de>
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
Thread-Index: AQHIkk1ZwrMdRrTYJJUEkbagN+qSQAGXWE03AJQn/QkCcrSzcwKzQYB/s/YQzsA=
Content-Language: de
X-Provags-ID: V03:K1:keiHBJdQWkffSWzmFknn/f727SuzLTykJ6+F5RqE2S3hBclK51I
 sFaet+oK0PhKuHXxe0XZU58CiRWhufRP8NILR6A3ITbPeoe2bAKHv5Hv8KsLCVpkP4bQmGQ
 HTBAJ8KvCvYUyGlb8qcPBfpS3b3Xx8x8P+7idSJVeEFJtXH/EYx3MjlAz0nJUpq61aqYs1j
 fCjVNhZ9axrBfukGkQJdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CzWGslvaQ0s=;WsBbQWoKYo329aBGPPzbDsoQJPy
 SBh8qxnHrrKqgZ8ZEyOzg6hzprzXYc2KPAA8XmD+9W7UcnSIMA0UgM4BcUDadkwMleAa7kB8Q
 S+gDnRwp5T+8S+FMPROyuJ1OAt4L2ZBy2lwR81+foMeFVKPF0a0QGJLjAr2rSC8t7m8atqci/
 SU2RGcYmtQYsH1rhB0t8purTv5gALShW2+l3/GPnlBvNQPRY2kjo/ToebfcbyV/rQt+7d2+Lf
 KQ/REv+8Rrtekn3+g+FCv5C3VfqshU8FwOguD7UZZsjhsq4lkze79x6aoOjVwU/oNdOwI0unx
 z82ODhqaFJJcyNB5UqS248hYIgTbFzh3q8D/bUHlPrcmptvHOvqRZOPh4k6DJHhSwyTbyu+mN
 R/qFhvy/iDDBUE/EmFbgaDWdSypG9xvwkMlRxjL4h0+cTxzPZIuI770v8Ki+RDbwu3iIqEgY4
 YVJOLy5DM7d+v3WwE6I622+RO9TaeysmlbkBR134MWQ0jtMPX/1ftbwZDQov7CazQFQczhgfl
 yv+Wg0ZROXo5I+ks6yy0CQhO04rqqvmkRy/dU+PvkuTcLHn5nK7EGyG1zzD1D5wTQ9o5RnZkg
 NBvaMxt1ZM0adaj2ole66Qv4ZUhitz2i8XQyRjpKKTFfEIGYSN4GqAc0tDPTuxaNl0f72288V
 79hgJosOF3QUG1xj8leoqWHIhtL3OR1bkifK966s4RhRPOwA1N/DONdA3TLgtY4POg/liZUMH
 QrqzisFhQstqpE//MkiTbhMSRPWrZwM6EjJnzbr/P7WHW1xCJ1g3xYQnDGiu4HR+jIWXYZpfS
 zGUkaUHgiM8Wp7w38bGRqVj+wG3ZTgU9d1d+OFc4FYqAVnI2O7j0+iDcY609eCkffRmvAuD+c
 sbbqsOYEPToPdFhUTsuK3DSpo/n+b0Hoo+haQf6oTXPATQjGRlLtGH1o7HRjcACXv0xVa1dzV
 a0D2n0JS//dVo8tZcoT021zGvkkRXxUYree2nnmxmTyqsfl2xUZ9OiLbvQohnq4bfMw1g/6Xq
 8jV+joD3aa/xv7RtXFKnAyYmM1ZJ6P/mWtGHUx2yKVPNXYSj0SlIW3USulpOYTjKxm14cn9ii
 Zz7B/yJAHg0yLUNsGQQZeeI23tM6OurrgRHA3iagyaRK3jWaOabWfZqCWoio/YKWP2SFSJswk
 dGlbwBtco7jn1jpQMywiCeNPHMIp4dqNJ0setCOh3N4a5DoMMVYk6PYjh9TLQy9CyR/cLi/0x
 9NrK+XLteOHNjTXqHujiJeJlybJs3RH2Uxubkvy0kN+skh0TU8HlMdI2fY94WcBs2IMgSTDwS
 zsfSy69ruefMD18r5G9vF28/0yBCpks9dvNdsYhsohc+3FYqaqSp6BWSFWl6mM3JSuE+81hmP
 303x4Shg8ZmyH81HjNDsIaIdZPjFC5xeABfZBFGWMm+3zroUU64d6h/ajPaEwqhzi1u7wcwo/
 KtJuvz4u1sd7RyLFlBsk2p0m/yYwlQwuR8YX2G5hVWgpqxJrREr5ByheHJ536VKcXA/JV2Ffe
 xUqNDYDaSETJyFzAGSvJbN1uJ70negBo6YafQBIkwc7LmerDVwiQ5IM1pjklMCrekOI7wVCGd
 UpO4QUFVwQFySCm42mrvem7A4vpEULGhkawpsIwO5ZPIs1qxOACwcloe2/Hpp6gw1d9J3wsBh
 8eAw6dcvdzv4osAQJHisTWRJAq+JUdzFT5hFa5AZwpExM+sHm+1o5WyF0tRfbjI3wtwI8jr8W
 F8zDXiRtrAgqfeOwioxNIHzAYU1saA2YTL6kzMAfj5h+aFUsV5UVbg3Tk9HZisExzg1VllcYH
 TJNLFeby7oKzb9hEz3npmMuWqSmpGVzsxE4xQV4RnCdJ5+0v8kKu0WFZdF5Vhzn2rTpNFCLfh
 3b3xT8XnZtw0BigjuJXZDFsPb7HcYGE5VNUxHuoGIIDunLDrzyKwmZIYlNL1x7vfO+P4yUEuO
 7AyR8igmZDbjkqneNr1HZkzGkaTBYxglDwSQ6R4gbIIkmoBfJjo3DseUIC91cfnCn0f+wC3EY
 Ot4yqqWgQQFn2j+wg2q6BS7ZLr9Vs62yeoIDUBtDxr3US84MgDZYu8GlioD7QvmB8cvluIjkE
 4YB4Ae+Uf8PSWxxkylA+z6RgIdJkFfnU6IOyRcojyAu5kIFuhg8WbdffjbCt8O5i3fo3ItFHi
 JZIX8FEGdgcQB20q6a92RrGmC0wV1/7wa4ukuGOeWR4ZeNuoCOBlzg1g/0bCIk206CTxPEPCP
 gfZJiHvgP02+yneChLtv97bFQcQTP9O//6EqWVUTcKFQly4CWI5rUGRkItMCU6D+vLL9tsxZl
 0W7vEwrVsVeda+0QN2nMV2zSsTSPFB99CLSyuY+usSBlNvXA5e/nB9tSSUqHD2lSK5Ro184P2
 75p+V+X4bf41WOLmFKrwbJ0kCUXaWkD1vAMUl5lqMWZmD0KvUVKm9tNuExGSSOHrc6E5XxQEq
 nP1jaGVOomgdExPIN7dkYSxl/h8KizkesUOLHG36ZU1dts78YrZzb8G55K2RTxerfpK7j2B+2
 0wQEkptRC17u48DYAWCUTCJpoPnW7c7bHsfU+w2KDhC+TzZBPZt7gpaVn4grj12RmhLUqsgOn
 ruOqbjuS5PCdqhJ63d7agILUkhLESLbU2bUvobZ+Nf/qn+G3MgltnRcXmzikfx+iV+L+n8xdt
 +PALkJvokDyDHgv8Myzd8f/gz7fR6jzAdR2v3dDMZih23OveKHflnG9b4REdOQJdYqbc+2IE6
 FDt1pRMkdA/1um6JoodgOCl/X04K4OFQXpWTwbUs+YKcEjKTm+pBQPTARJs0oNOI1d7++6kFD
 bt/hMXViQyrrHJ99UXEzcbY5uNCwbFH1uR5+Pd1F8xjha0sIa1J/ggIhLMOmW0DpUgjHfpA8L
 QAgmcnPW/vzHmebkzOevkHuBqVSHA8L5Q+H6U/d0lLfYxHe9fz9Y14wyiCgrl3ansTmAroavR
 hY6gUhdIDsC8LyMr24MsEpo4x4lcsd9rBfHC2Gy+8AhkDuQP/XdJgh9EoSv00LlnBhOGHXj02
 3BNPRq4e1i+oy06eSuhEjCtvXsGYGSDE4XQAeLV4fYkRiv5s5LQMFTpG2lX7BAPf7LpdY5Rw7
 c2b4PMyXWvItCFAUsvyh0hnhy/GTDs0ZojxK7C3rFNhTD++WwQZZCG/sH7kmgmW5XyerF17aH
 UJuRuXi0Mefm+YoWRVtTFfk2A6gltkJ06mTC5l2uQ5VT0G+do6irVSiP6rprZZx7/oD6+8qWX
 Fo9hxZk/nPSzoUDEndbqX+DlbXOtuf1FMQAgOw==

Hi,=20

> Von: Chris Packham <Chris.Packham@alliedtelesis.co.nz>=20
> Gesendet: Donnerstag, 19. Juni 2025 04:48
>
> So I did another check. If I clear INTF_SEL bits in SMI_GLB_CTRL the=20
> switch will not detect the link status correctly. C45 MDIO access from =

> the kernel seems to work regardless.
>=20
> This is using the Realtek u-boot to do some HW init and my as yet=20
> unpublished switchdev driver for the RTL9300. Something somewhere =
needs=20
> to configure SMI_GLB_CTRL so the switch will get the port link status=20
> correctly. It doesn't have to be the mdio driver, if I remove that =
code=20
> completely everything still works (it's using the SMI_GLB_CTRL value=20
> that has been put there by Realtek's U-Boot).

Thanks for the test. This fits some of my observations but has other
dependencies on polling. Some c45 registers are still blocked. To find=20
a perfect solution that switches polling off/on and toggles the bus=20
c22/c45 on demand will need a lot of testing.
=20
See also notes from my recent addition:
https://github.com/openwrt/openwrt/blob/c9e934ffd87774a64fa0c8a2af92373ef=
1d0894f/target/linux/realtek/files-6.12/drivers/net/phy/rtl83xx-phy.c#L11=
72

To sum it up. On those devices it is only safe to stay in a single
clause access. Converting the RTL8226 from the current mixed  =20
mode access should be hopefully ok.

Markus


