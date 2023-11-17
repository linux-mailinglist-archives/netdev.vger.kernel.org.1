Return-Path: <netdev+bounces-48682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FA7EF37E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DE5281268
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848C30CF7;
	Fri, 17 Nov 2023 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OWVZZU4a"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FD10D5;
	Fri, 17 Nov 2023 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700226503; x=1700831303; i=markus.elfring@web.de;
	bh=iZYfyA85WBO41mIJWajYdm+66zp6Smj869NjgfI995I=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=OWVZZU4ad9bIVuYSWUi+4xtwKYx9hEdmknfy7WgxMs1XWHHCxQFiBDylSaXf7eUu
	 3JiDluNOST0hny9812v+8ObZesB7RRvl4yTJ0Wp1NLmvKYlUhM2nVCNmrfYV9D/I7
	 spEmHsRnEY3l128uEe7M7Ubmr7TnAoydrY5HjiK4+vAk0mKO1DDT9gdp4mrKi0dOK
	 esuSOUhp5qHQJari9qL/nKgfLgib7Mp/6xnyKRCohMH1gi9IK69HDb4t6n4/lqd1t
	 uUKaZIQ26AYpBinfJmq9TIHwwb/jugpOdI0NaRf/6Hixtowujq4GEwj98dZ7kR4mZ
	 zkesh26UwHMyVzOgCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1rflWC0J9z-00oImp; Fri, 17
 Nov 2023 14:08:23 +0100
Message-ID: <2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de>
Date: Fri, 17 Nov 2023 14:07:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dmitry Safonov <dima@arista.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paolo Abeni <pabeni@redhat.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski
 <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>,
 Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Dominik Gaillardetz <dgaillar@ciena.com>,
 Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Francois Tetreault <ftetreau@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>
References: <20231023192217.426455-24-dima@arista.com>
Subject: Re: [PATCH v16 net-next 23/23] Documentation/tcp: Add TCP-AO
 documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231023192217.426455-24-dima@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8FSoGo8zdqcp7mpZWq477RGhG5Hqd7w+By7DXykamyPi+Noo7Vt
 vVSD8kF/TLgjanN0k33t82HAauWC9lOSyztubyi5snvX+a93ra7snpLVaZJHwMkHjmQG9AP
 o+BTP+d0WFLCHjMz08bTl5W+ZFWiBI4k0DnijEsVF55eb3p8Hqw3x9hdMDgBpfV1zxwnevo
 pgFtPwH7l19MaQkcwpl5g==
UI-OutboundReport: notjunk:1;M01:P0:bUxgAhWCPss=;iKMNGM0QHwl6Ll42MyaU2Zdo2hj
 qlU0gDDLYZtkpKwRkrYShyOzipomjCrzNaLYtBlwJMRyy8SwRYiwyd3NqWOKZAKZFQ9B0waW4
 d/Y+ugttBNPg2HRD6vb/P0RwiXXXWl3rKhs9g9J9k78lgUE0b0GvZgqLhpMMAhYWQYajimvtL
 xG1OJch7ytNFWm/GTqdwD/pk8Ffrz20kAZVikF4i7GFf1mwU15jdgEjgea7mYBpakbsv8yT1h
 ZileBZYvCV90QrSIxpDaieUB3fU6WJCFWiEJzSn+L/3X2TX3rB8z9mwRyievM2g04MGeilL6T
 vY7cUpbg958ZL8BypOCfYx1N6ActPS+MHeD3mDQI2kci0v1zHk2ylQzVgShwCiCVeJZ88KauY
 wSAirNtIV9QtaOcwabIF5hwjeeluNoOl13S8F40CafdpwpYSpMpzW6mfqNPauIIEfJ8TVuNTR
 40Z5bvy5w2vTCzAYJb+rJFYvWEe+2I1g4WD0KvpgZy0SI20r+YOS/JCGkvntedjuYbgTc5qkl
 Wuz7b8SJ+s1vUBCDtdnx77iLptzfXHe3DsTNhYoUqL+P9f0gMh0hwnssP3gnHJivPFj7lBkLZ
 iHajLsbGdCJ9jReEeoxt/SSYAIxAvqzo41bkV048iYxRdVpFKbbnnbP2KOX7Wt6mYUBpnJOxC
 C548MES1ddI7j/fQLjz7gARDwSbvgOHEMRuUotDa05uta+cN7sUI4p+zwZ8SBSJ10dq+C5tf0
 TwmUNQdu+OLvhmoulzelccPB3krwcSjiMLBO2v1jk7yrRGn2s694aELOVPLbZd0HE1brm6WgJ
 akIKv3bp76Kiq4sDM2P974h8nNWJ3kN1QVpWH79+QY+g4LZjtp8gPXNvZn5E8JR2V+ls2n4Or
 wz9178pqF1zOW37Vwz3+OjCmv/C2W9IZfyzBnFBDrdBe+FvJ74ogY0RB3m/COZQ4bPeKobdfp
 jb+ohA==

=E2=80=A6
> +++ b/Documentation/networking/tcp_ao.rst
> @@ -0,0 +1,444 @@
=E2=80=A6
> +                                          =E2=80=A6 failure. But sine k=
eeping
=E2=80=A6

I find this wording improvable.
How do you think about to use the word =E2=80=9Csince=E2=80=9D here?

Regards,
Markus

