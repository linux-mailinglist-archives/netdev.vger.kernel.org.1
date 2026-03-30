Return-Path: <netdev+bounces-273084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK8/NFsiymmu5QUAu9opvQ
	(envelope-from <netdev+bounces-273084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 09:12:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2A3564AE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 09:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E1323005ADD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADC39527A;
	Mon, 30 Mar 2026 07:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337B24E4B4;
	Mon, 30 Mar 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854743; cv=none; b=ofT5o6PWiGy5S1okjvqA2wdX2PqdCM4BsDqjvvZhKuUhrhqOjil4gbjTpGZl8gwHO8Coj+kHFXES6gCdOj9iGRGCUcOYsR7/6mmG1RsE4GUieKtxIXx9cVW93JlZWG/DQ9Y+dWd31EpdcFvxeOPEMouqWtSFRuTfx7fWSSSIo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854743; c=relaxed/simple;
	bh=rZRZNnj+SWl+nEX6p5ljgjH/OFu8jr4+GWCEBdSVUQA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojDwo3KQwMM0UhejCy8W3loG1O+66h4yB/Z0SudUkFo+99eGKjT4fcydtuW1ggZJq8lpFRyCWMJFHpMo4+WB7kIIsXUQ2VE/aMJfV1+Y60bSH+xzFWxfBsS34Ur6Yi5BicnuU3H/NEt6ig4lnz/Snrcy8TOHXU3f54OVYRpABcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1774854731t870t42468
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.224.139])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 968294333165646595
To: <patchwork-bot+netdevbpf@kernel.org>,
	"'Conor Dooley'" <conor@kernel.org>,
	"'Conor Dooley'" <conor@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<conor.dooley@microchip.com>,
	<Valentina.FernandezAlanis@microchip.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<daire.mcnamara@microchip.com>,
	<pjw@kernel.org>,
	<palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>,
	<nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>,
	<richardcochran@gmail.com>,
	<samuel.holland@sifive.com>,
	<devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>,
	<dave.stevenson@raspberrypi.com>,
	<sean.anderson@linux.dev>,
	<vineeth.karumanchi@amd.com>,
	<abin.joseph@amd.com>,
	<theo.lebrun@bootlin.com>,
	<Ryan.Wanner@microchip.com>,
	<haokexin@gmail.com>,
	<netdev@vger.kernel.org>,
	<conor.dooley@microchip.com>,
	<Valentina.FernandezAlanis@microchip.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<daire.mcnamara@microchip.com>,
	<pjw@kernel.org>,
	<palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>,
	<nicolas.ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>,
	<richardcochran@gmail.com>,
	<samuel.holland@sifive.com>,
	<devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>,
	<dave.stevenson@raspberrypi.com>,
	<sean.anderson@linux.dev>,
	<vineeth.karumanchi@amd.com>,
	<abin.joseph@amd.com>,
	<theo.lebrun@bootlin.com>,
	<Ryan.Wanner@microchip.com>,
	<haokexin@gmail.com>
References: <20260325-unsterile-flail-4c7729750dc4@spud>  <177482042554.472023.12757157452690281696.git-patchwork-notify@kernel.org>
In-Reply-To:  <177482042554.472023.12757157452690281696.git-patchwork-notify@kernel.org>
Subject: RE: [PATCH net-next v5 00/14] macb usrio/tsu patches
Date: Mon, 30 Mar 2026 15:12:10 +0800
Message-ID: <06a701dcc014$86def5b0$949ce110$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQF0vN16QhDCAi1TInuOp+Z4l0ZKlwGT8tMStooKEUA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N+qOsY06OnyolDfmxY+LUvXZaPJpBkQLIMQzbmmBgfZQzUP5iogZHril
	PkWbnnrfyzGj2kYIXb/+4TTfAK4AXX2kLGIXmGykAIQwKF8Ag02Yc3Vqv9cF+8tytlmsG/u
	fDOyg7hRWGbnft+WpkSxLqEfwMqYeyo3St2MED84LIKk2Mgn5ySc/VKDva58FfpPU/xUrNy
	Asoz1f8NBbbbKqAu/BLHmn8nTEZ2eMzaNYRSb65t3UPVbIj7XwGxt9gaM99AlKOf4JofAff
	oM+eyUs5LXVn+YxP+BSIOn0M2QHs+6j0x6+LoQst3LHQWvrnk1a5YCM+QzhGVtp3hw3i3VO
	R9MF28Scm+jdj1tIENMZQAxzv1yzZ1CC11ZcjADsBUE5crSX9WqJkZ4tuzVeXuf9evNMMlM
	qPK1KmWdrMhXu87+c7YcVHJTdcHWS8kBNM5b8r/5reKcxZLbheT5UtlAKc5woyl61FXUXGg
	R3Hr5NayvU45vtiUWOqaxeNdGHDi/Q7YMd297qGgoZERJx6DBJ2rHUahsWha6bQvfvzycph
	+3x70TOuvI5kduF/TlnTf4AYQKkLWisTT6HuJfmg/D6FHdIXyPnIqZW5RUBcQ0d69UqXedc
	KcQSLc4RpkYI8XLhP13RnPDLwuvm2qGIMLSP6a9YQ7AtUwxHIZ0QRZI6xb5FDztprZaWVW5
	B0ehrLtByrEA8NZ0kQk2XHAEOeKTkqzLEaFOhTF3DQBFUVjcYJMUMhXO5u1cRZ0gHWOb///
	1HalMZV2SefshSekKJvGpXpX7AcqodZTexrpEeYDcLOHJv6PmUEedbrmeQsSY02cFyKOaoA
	jycQ3AghFgMhtrH5wQuKKlW/OnLNVGzQl1Vjx1frhpLl4O3mwzcvXWbjYMNKZDqsryvRZt3
	QlgQ95eAQ2g0InOoZyNxTO9HLmKLibS68ju17aHuPhyKXBFHLWpl1Bok+3UUagPkzGCCyzs
	Mg0Jp+PleY5KSDoELnOfAlwa4a7PwDsLwOQPh81r2Xjqo8j9ta6tJVzQHRWu4JyUiVz26ni
	aMlZmqyFYupf1O671Rknty409UE3Wj3zbY6BFCDg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-273084-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,w-ms-7e16:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 26D2A3564AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hello:
>=20
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>=20
> On Wed, 25 Mar 2026 16:28:04 +0000 you wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > Hey folks,
> >
> > At the very least, it'd be good of the soc vendor folks could check
> > their platforms and see if their usrio stuff actually lines up with =
what
> > the driver currently calls "macb_default_usrio". Ours didn't and it =
was
> > a nasty surprise.
> >
> > [...]
>=20
> Here is the summary with links:
>   - [net-next,v5,01/14] Revert "net: macb: Clean up the .usrio =
settings in macb_config instances"
>     https://git.kernel.org/netdev/net-next/c/8ccf062c6770
>   - [net-next,v5,02/14] net: macb: rename macb_default_usrio to =
at91_default_usrio as not all platforms have mii mode control in
> usrio
>     https://git.kernel.org/netdev/net-next/c/a17871778ee2
>   - [net-next,v5,03/14] net: macb: split USRIO_HAS_CLKEN capability in =
two
>     https://git.kernel.org/netdev/net-next/c/039f185a0060
>   - [net-next,v5,04/14] dt-bindings: net: cdns,macb: replace =
cdns,refclk-ext with cdns,refclk-source
>     https://git.kernel.org/netdev/net-next/c/dfa36d7e860c
>   - [net-next,v5,05/14] net: macb: rework usrio refclk selection code
>     https://git.kernel.org/netdev/net-next/c/6c5b565d7d41
>   - [net-next,v5,06/14] net: macb: np4 doesn't need a usrio pointer
>     https://git.kernel.org/netdev/net-next/c/826cbe636e10
>   - [net-next,v5,07/14] net: macb: add mpfs specific usrio =
configuration
>     https://git.kernel.org/netdev/net-next/c/c711311d6ba3
>   - [net-next,v5,08/14] net: macb: warn on pclk use as a tsu_clk =
fallback
>     https://git.kernel.org/netdev/net-next/c/3fe13d858f83
>   - [net-next,v5,09/14] net: macb: clean up tsu clk rate acquisition
>     https://git.kernel.org/netdev/net-next/c/b698a1e397ab
>   - [net-next,v5,10/14] dt-bindings: net: macb: add property =
indicating timer adjust mode
>     https://git.kernel.org/netdev/net-next/c/09a6164a4f1d
>   - [net-next,v5,11/14] net: macb: timer adjust mode is not supported
>     https://git.kernel.org/netdev/net-next/c/41adda8764fd
>   - [net-next,v5,12/14] net: macb: runtime detect =
MACB_CAPS_USRIO_DISABLED
>     https://git.kernel.org/netdev/net-next/c/47c86c463612
>   - [net-next,v5,13/14] net: macb: set MACB_CAPS_USRIO_DISABLED if no =
usrio config is provided
>     https://git.kernel.org/netdev/net-next/c/32fc6a9f6e75
>   - [net-next,v5,14/14] net: macb: drop usrio pointer on EyeQ5 config
>     https://git.kernel.org/netdev/net-next/c/cd1082a96f9a
>=20
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Hi,

There are compilation errors after merging this patch set.
I believe the error occurred where the CONFIG_OF is not set.

root@w-MS-7E16:~/net-next# make C=3D1 W=3D1
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC [M]  drivers/net/ethernet/cadence/macb_main.o
drivers/net/ethernet/cadence/macb_main.c:5755:19: error: =
=E2=80=98at91_default_usrio=E2=80=99 undeclared here (not in a function)
 5755 |         .usrio =3D &at91_default_usrio,
      |                   ^~~~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:289: =
drivers/net/ethernet/cadence/macb_main.o] Error 1
make[5]: *** [scripts/Makefile.build:548: drivers/net/ethernet/cadence] =
Error 2
make[4]: *** [scripts/Makefile.build:548: drivers/net/ethernet] Error 2
make[3]: *** [scripts/Makefile.build:548: drivers/net] Error 2
make[2]: *** [scripts/Makefile.build:548: drivers] Error 2
make[1]: *** [/root/net-next/Makefile:2105: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


