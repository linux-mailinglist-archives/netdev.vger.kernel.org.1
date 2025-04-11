Return-Path: <netdev+bounces-181754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BCA865CD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610003BAF08
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8426FA66;
	Fri, 11 Apr 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D+kX0NeM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297325B66E;
	Fri, 11 Apr 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397454; cv=none; b=tgccpGwe0A/JtZVoIRC0Y2KKvmGZCUpnHbp+t40NZQAoAnPhbtUtEguvapfyxJ1+Ql9kXrhz+pf5xzARTuzR/rjPIDOLy+2JaAHOu1jBviYwHvYUWs0VbgYQbEbYwktRZ/KdptmitJ2BAfD5SAygSkdt4Y/c7UJxchs+03Q+1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397454; c=relaxed/simple;
	bh=j/LHHHbcMnZk1KJTJuanrKnstcRMs6cWWqPhuy5TS64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFt3x388CN3scW798Y5OA4+fxiyBZQGket4a/lwSTfC9Frf2dDNgUE1/2vErsjOlc9fSnfENmPqQbgfs7KrHsk9Vh2aph7fezrHwLYFxW3yY47iJfSEC+X/RTNp2kdOIzFQbPPgn9SMzTUqis5PhfPqg1r+IgItOPv0utWNK7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D+kX0NeM; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744397410; x=1745002210; i=markus.elfring@web.de;
	bh=j/LHHHbcMnZk1KJTJuanrKnstcRMs6cWWqPhuy5TS64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D+kX0NeMGu2SIgqIy7JeFjc84JSXM6O/HaIxZ84lKMXmwehSo8by64XgI8BjQndi
	 FuPFKcbebuyTNafL9ECm/XCR2CFE810afgb3RNwrSUpSIGw2qU8zJGgheejPJNDcb
	 OHtzIhjCkKlyS2YZHvU0TZKC4s75YeeMHsiA169pHrpRlRGDg6JBv52aALMztHf7g
	 DYvTNR1yQmEJuvsCldTCXjjxm4KJpeGLsaZnyw3C10y21DP+sRBz9if6+QBtmPAsR
	 0WUbGb6ReAafe00Ti2krUXl9xjtATTExbIrj9TmIxIfxkzTnm4i5pC1iB/Cxrlwlr
	 qwHwPRIfTUx//NAyvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.66]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1sxB4D3mx6-00xucn; Fri, 11
 Apr 2025 20:50:09 +0200
Message-ID: <d9189c94-31c0-42d9-aa9b-60871cf6b285@web.de>
Date: Fri, 11 Apr 2025 20:50:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxgb4: fix memory leak in cxgb4_init_ethtool_filters()
 error path
To: Abdun Nihaal <abdun.nihaal@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Vishal Kulkarni <vishal@chelsio.com>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
 <20250411145734.GH395307@horms.kernel.org>
 <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5+HvBGsFXatPNZH1oPcYt2OrylQGzaXfBwmIePGo85K4yqVqtK
 FQMlVp5zDKlWbNTFk12J3PXwc9YRzJ1GoyHMALG6dgmJezfg9o3IeaWRJWpQHZ+cfcTPpOw
 EB6lIWW8zVrKLiDLsgpF5OMDdoecF22BjwIdrpJ0DDQjZZZxHqGy24YVj0dFaKEl29/YswF
 Ckc+KtMNjGk8gCe8oDeIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NnL9bKWiZxw=;+g5rFdnXQwoC7qdOuq+g44Y2mLv
 G+WWAoOEY2tNnv0nAQ0kyjDegYUzSKSoyt8D2zfmsBG65RA5m7LS4QQQDvrs85apa3/jv4yvr
 9ww6cjPAw+4KUU9qBF51GZq48fWKSHFC2FPRD92qIe955I2CKeynfx+l8bKu7jL5ByeWIOM0N
 sPFu3EeovrQwSvAFcmEzvQcfu/1e9dZ65l+XMJgEoZB6clU1fZZ6J5OKuzWeB4uneFAyWvxWx
 InXYyB8XcvcgJKbclKd84x9CW9JM4sDDTPhP5nvvVyRHIX4zr6IHOuqbua+3qoceexnZkqiSB
 XStsWc35eVm5RS7jT5WAPO2+x8Wco1pwOaIM4YZcvHxtS84GKgnCAQLUFi28hbK2pqr916j10
 f0nq1PrEIsbTye/qQ5TFZAOiorp5UuWtuy57Xrhswfm04Aaxtnz/xC4SyMcP8/7QF0wNpO37X
 P+oaGbTOxcFw9QvZxfyT1hAHJB6CZOUEacHMaB8EYHV5AdsUqTEAyUvTn/M3x9z7jbJAYmjjT
 obWMzct6ClNQUhr4cYdf25Su9S7sYhX8fsjltlIKj169Q6oLxQScPOqfDcI3x9ZGMLieIxqYx
 0V44o1auQyF+8WbbOUMLAMPxsrZvQkD7zxieiUhutQmPYA+dLCV0TfDHzivAEbtLNF0+37zot
 4mv6W252nQEBpl5ScIi9NZyA+jCQmFVsJakeO/bTANxlQWHYBWfvNzuWkNM8DzvjynK5+fQ/y
 Gxz1vBQn8Taz45xsRDUxgfKj7tFEatDTLtv9EoM2H2uiPgts1ZT8idaqYTbnYjBFlHxlwDCB8
 RKPrZFxrZ0q7gyeJpFuqwv5+CkODfr80d4mJDdOqznYhw4DmYEftNDlacz/RuCascL76iFOju
 6pzUXW1Rj7eWweob/5KjbBTHb9r22D36c2wC0fd9mnEF7oE+kKjoQI+AqEhRpmliofeJnTht4
 n9L/Msd0bRcrJ96QVU5p6Uakg/pp8montrLalKj/OxppkvbrJqZNZiWQ1iFm8a5WBlD5AB7ym
 hb1euMziA8Ea+/+1hxSffqUqSPFJOu0SLzkLy3tEJcbWEgxXQKEZf7IY4U9+eidqXqLPYuRrr
 +VHqWAbFjVUWLWBxkdqqd3Fw+FWJpzbzps4UOB/fnnEZoySxf+C/dvH/tlmPeyUSQV+Bg9LmS
 kD2sSVEb849JLNh88ecPEp0odG+v785ebs2+2CY1V1MY2NuswqC4H7VsVYZQMPx0adtVK9oEE
 x2w7n5L3OA5eZ1jbBs52fXET3KOSJksHnrds/LLw+3Dr4wJzmJB+iZ+YFZgYRyPVJMXdQ3X+p
 kxXzLtw4SNoyS/useDVgblgpW1YpNYldZ5wHy9kMPUgVf8qgGxCxbHVdiyC5CSGIgriyqgBnx
 TK1MDejngeLejVqvXA25hxb2i6dtlxM0rGMU9GJGTtMrVnONdIe05x3kVLhcGp/OIZfUY/+Fp
 Otj4Y6tLnRj0YKbPgVo8wJ18jm60y2DWPKlUkjpSaTjvpIfFH

> I think what Markus meant, was to move the ret =3D -ENOMEM from both the
> allocations in the loop, to after the free_eth_finfo label because it is
> -ENOMEM on both goto jumps.

Exactly, I find this a reasonable source code transformation for another u=
pdate step.


> But personally I would prefer having the ret code right after the call
> that is failing. Also I would avoid creating new goto labels unless
> necessary, because it is easier to see the kvfree in context inside the
> loop, than to put it in a separate label.

How will development views evolve further here?


> I just tried to make the most minimal code change to fix the memory leak=
.
This approach is generally appropriate.

Regards,
Markus

