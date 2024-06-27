Return-Path: <netdev+bounces-107308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211C91A859
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304921C21776
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D6194AEE;
	Thu, 27 Jun 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W6L8CB0K"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E691946BB;
	Thu, 27 Jun 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496390; cv=none; b=DeCIPGt0NLVkUv8li1lQy0Jlbgq8q54hhABVhA4qmx9zu5pYifaB5wcqwMzLtcB8Cvby0yXIr3fYe0yWQ+wXXfYYHui4LdyiKx9ZoDd4x1V1N65yCqzAdPcJkykO3d7V2pazoASZ/lJpfgittxoca5+MIvwvGiPPw8z2Zeyjo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496390; c=relaxed/simple;
	bh=5/ZC6O6bVKKOP0O0smfBn+JnsMkFDkA4dDnlBHWugl0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SWDItDN2UgzckvOSxpuHYoeZVrKZT9yWxNyVPBpFYHPG1JDY+2aoYBQvfxFivZsIju8xhyQcvdArygyRqv24R9nKj4pCcYwOCOxV8qWro7YNHrSRbCExDeKuzC/YT9XFaYkaqkgqoTdXi2KGofVnFXfa78JGCyaITn11+81Z3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W6L8CB0K; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719496350; x=1720101150; i=markus.elfring@web.de;
	bh=3myu8VtpYXyOU9OGhGPzbiYKZDpmLk6ezod6dMhXyAU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W6L8CB0KpU9OU2zG8ZjNOSkl2gGRJ/hjd++edjH+BTUHyLwqidWG9F/gkg/sZCz7
	 SU6y172u/0SjgzjzHeDTL+35dwWoQ3sMmqUEuebWU+qXTKqlhdKSIUjQad2vDPBNe
	 ZaYcxI+BsxbP1P4C/kih+IsmvL2rdtjBFVPV5/1J7IqjATe9TBMMn6QXCw8k/F606
	 wYU/sUoiph1OiUro4mwrn9QE1v8HnbAWkhcHt0/4szm9Rr8Cn7uAI//Ov9bw/g6lg
	 Ja0D+ccm3+ROGYyoNGxuneGMlQB8l2RWFP6qcOG/77YSGTdXo/TjDO58yR3qSLVSN
	 nuE3aucKCwBF1O4kUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1ssZvf0df3-00j8bY; Thu, 27
 Jun 2024 15:52:30 +0200
Message-ID: <cdcc4cf2-543a-4301-a445-5ced6a2d981b@web.de>
Date: Thu, 27 Jun 2024 15:52:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, Justin Stitt
 <justinstitt@google.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20240626230241.6765-1-ansuelsmth@gmail.com>
Subject: Re: [net-next RFC PATCH 1/2] net: mdio: implement mdio_mutex_nested
 guard() variant
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626230241.6765-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+xcQlQ3ETwDHgNKw1vt0XkxbVrdxdBzGk3jDArhxYKWdPAfuF05
 aSMrGw46GGHkxLEORh4D9Lz6+C12ihaDjJ5paoxeoxGV40wUQdgnkizR8qNVOkJkJjFbkcx
 2WMs5y80IEjV3hw+MG33MrqvhTwVm8YsFuNRjfGovcb4JrNgU+e2kDkJGjLeHtxwzMWvf8B
 A0u0Vcq3bckVvhTrnOg7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ajgkg7S3RCY=;9xM/jrv4TwQt/sKnhVKk44Uay+x
 O7S7584EIfrSYG4zUNZ7TFR6HJNjoS/n+fEJSzIUgXanlI0BU+DopWyO+fhYW8t2JWm4r0fwy
 U586LM+mCyUu68lT71+WdX1q8H4rtwMMzdEr1SFnlPCoUZpwotRjEf18R1OQ+FUEk/hV+TwEb
 UEs5Y9aVeafs5OUv12pd5SaSPY+dUPf7KItxPpKKBCplfLL+OwZ1jVJH82WJiFix/2JHYv4pi
 B91CKIK7XNYQfJM0eMSn0WKUjnRg5gSE/DuTSB+7pt0eMM8mhuEasFlO5s/CeLak1t+R1P5d0
 BzRdbAtuspT+cAWyz9PXygUXeVLF9coKyE89vpU3+CK6rJvEJvH1h1Ye+kHNSc5CY7u1YVVy6
 o8RKXkVIpXE+ESRjrvv2iTacE4+ciRw5JmBC2CRJggWMPHbjXOxbN0yOiuQ1NHt6FYtrStxmR
 LT3DG4A2jVelFQxpNYe5YzlBMjKB+1bAyeIHu7vR4tuuQ89mpPNr2/p7bxAWE66LfNwjIIiS0
 cqkZo33JdzKkLj4Bf+wz1L9EJAtaUCGmekA7DkhQG+qtu4JA4YSL755DIHk61YjJ0sGwg98jR
 lw6+H1iiO2bRMpBzp9P+0MI9jvWQbBQ6DMnIDcSkltUnpuMGNZGJiO21nQ2YaTid6P6wejAX5
 flCd+uotrOkRD/jgakswI8/v47F8GW+wcdxeHrpdYGQpJ7bZP9K6dT+MiUOfSdZzBhf28VzNo
 6ywtxQ66RlhL9QrLbW/5pNgA8P/2mo03kmhf0R8/DRXtZ11X5tLMeYojHT7eu3lf/P3RvLQjg
 Sx9IksWAGtqNnSxqURn4Xia+8bHOsUCHBIhUnaH1y00+Y=

> Implement mdio_mutex_nested guard() variant.

I find the idea generally helpful.
The concrete implementation needs further clarifications.


> guard() compes from the cleanup.h API that define handy class to

          comes?                             defines?


> define the lifecycle of a critical section.

  handle?


> Many driver makes use of the mutex_lock_nested()/mutex_unlock() hence it

  Several drivers use?                                            function=
 call pair.

Would you like to clarify any application statistics another bit?
https://elixir.bootlin.com/linux/v6.10-rc5/A/ident/mutex_lock_nested


> might be sensible to provide a variant of the generic guard(mutex),

  Hence it is?                                                      :


> guard(mdio_mutex_nested) to also support drivers that use
> mutex_lock_nested with MDIO_MUTEX_NESTED.

Another wording suggestion:
  guard(mdio_mutex_nested) so that drivers can be better supported
  with the call variant =E2=80=9Cmutex_lock_nested(=E2=80=A6, MDIO_MUTEX_N=
ESTED)=E2=80=9D.


=E2=80=A6
> +++ b/include/linux/mdio.h
> @@ -8,6 +8,8 @@
>
>  #include <uapi/linux/mdio.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>

I suggest to omit this preprocessing directive here.


> +#include <linux/mutex.h>
>  #include <linux/mod_devicetable.h>
=E2=80=A6

Further information is included as possibly needed.
https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/mutex.h#L2=
2

How reasonable is the added header file dependency so far?


Under which circumstances can remaining change resistance be adjusted
for further benefits from applications of scope-based resource management?

Regards,
Markus

