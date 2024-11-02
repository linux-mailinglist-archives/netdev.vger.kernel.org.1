Return-Path: <netdev+bounces-141234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43B9BA1BA
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6245E1F21651
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A716DED2;
	Sat,  2 Nov 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="s9KMDmyi"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82A4EB50;
	Sat,  2 Nov 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730568659; cv=none; b=jEWInAlyxAcX21QQNDc42C2h7OpmKaEIb0vltcgQ6o0JnMzpY+m0KDB/w2qFbZS9Jp5bi2C+OmsGXfftoimiyabSdvokmt26KRm+c72jL0FefFhM/RgRXRwP5nrzpojeGQuVcKqt/Z0mhQXo6eVat+C4xjqTDA7j9V+G1BiQIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730568659; c=relaxed/simple;
	bh=QEjLdGSqdqsQxZsvatxuqZSLE+aQoVLZvHnOqV6Fkgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgX7AGzWiKVIEnb1QJp6y8ECNrUtDTiRDubtWko8tS0ZSpwhRXalG8WcfExPOXhZliNTgzbnUXdSkCtVXTWUmkufBFbXtpFekyeYloxCYF0Ago3nFoORKVJHuG4NiK8gsaKW4D3qyyNhyiq6ektScXmXMXAw54B4Wvfh0ehZQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=s9KMDmyi; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730568626; x=1731173426; i=markus.elfring@web.de;
	bh=kx5Io8K8wJlg4vSJsuwGcgwj0x7OwKY6orRaelQ8v8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s9KMDmyioIc1/16pGgBYJ15rn/UD5/q+1VV3GAwHaoZGFebiJE7sQTRJ/OetyPMf
	 HqAHsjUhcVqkl9jdDZJSWa56viALruzMnvr5LA0bqA5IO9hmBG3sLhzL+Ijj4TBRi
	 1/xgPz7TV7OcwBTSrfgvS7Mn/pc35dHUk+DrCiFat8TB522koi0iZtz+ZU85JalfI
	 iT2T7gezZ2QzGk+iAOT+wk4uI7i6MEBE0Cy8UB46q7mKFPCuhMKeaeADEpx/T6Hci
	 bZ16/SXjm8hH2iRHIT4wJeSUqEHWksU8DDwQRpRjiQ18cGNdp3c5lI18rt3ad4596
	 AvMPTl+GbgRqdqm74Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1tDdk11Ezb-00ARP5; Sat, 02
 Nov 2024 18:30:26 +0100
Message-ID: <359e4cfa-d1f4-41ce-a986-89440fcf66cd@web.de>
Date: Sat, 2 Nov 2024 18:30:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: ip6_fib: fix possible null-pointer-dereference in
 ipv6_route_native_seq_show
To: Yi Zou <03zouyi09.25@gmail.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, 21210240012@m.fudan.edu.cn,
 21302010073@m.fudan.edu.cn
References: <20241101044828.55960-1-03zouyi09.25@gmail.com>
 <feac7231-5563-4f68-8554-483c7030b50a@web.de>
 <CAH_kV5EXr6B3vU3mbwHYaCHdSeCcVw9DiNT4on5rNwiAE+svRg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAH_kV5EXr6B3vU3mbwHYaCHdSeCcVw9DiNT4on5rNwiAE+svRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8hoHBIowGhlMIEo2kNNYhGcnCN34OkCxFyRF1lYF4SLvVPGlSw+
 khk1I1rTtGZ/OlScv66btrDTmNaIM0zjdhAQYAarWiwiau/TCShrpK4+8Ez+jwrhZKI6Yro
 520rqQRHIkcvcjNXDCqQFhNhGg74hIgQ5WgrLVGxeKaD7WHirM5Lb0Q5ZVLNMESi4/RwNFf
 BT/C8CfsmWKBFk039UabA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4tvy1g6j+d0=;yTi4Z8bxyJ3BNcF8qH5359jEQTJ
 61k7ffOMkZg7Ou0PbXFeLl00qHOqzvf8sOsHvtw6IA465SRVOUhfoXykmasTaqm/Y9CurPzdQ
 ZT9AjIaRU0RftyTdulfL2h1GuU+cBz1AJYwmOHubQgObSrPcblAuPSdKgxEoRn/ThfmYB8yFA
 PRH6dFYDR3bx5gpR001AyvwFTmweJ4pbVHbv+mMzCJLERP4HIm2AyQ/vxfBETsnzr9K1PN7eS
 kksK/og+yrklWddUZSYea8we5n1pTdJPwan0V5H8HGa3Ksctd+N/Ux8xidNKGshxi3XPj4Dfx
 BdiidPCOiIqwVnH8Rf2LrMS/gULGNZb7dvRBC+y157eC0KKcAS6X9scllm3jGGcLqyp403Mx8
 TryyckecUslEz0UfXeyZQtrKkETsjXB5Dk42PmrKJKaTC9KsomI+EEvH61CMDRTdlb7fBhRBn
 4wvimtmKaEj90y74kRYuu92cEJMdcGF9E3zcSvOr4Xsi03Ql/0kOm9sl6MnaWw9xqSrPlI5ry
 926aEGPKxiNJh7BuBxXJKDhquDhDbpU7vyYnsGbuVvGi04UD/pnl4hBCxdRoYf+28RBkBcAnP
 DxBaedWlfgBQimbgYfXzD3ehUjacM7D17vdAJ/tfOnaT/7BB/AthxcvpUZInAC+D/DScAEsob
 RvPeocQizTsGBRrJ4FqeyROoiqRYRjC6EjbofWhkV481/IXtI0kkLQpVCDbU0cNrdYBRJjjyV
 872krupqsVjTLVj4sC1mykNAKRmG62WV/1R3TX79klvX7iylQ66G734aKcZColQGGKWtV0kGE
 IRuuf3YFerJ7JSywo90kPLgw==

>     Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
>     in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
>     Assign dev as dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
>     handling when nexthop_fib6_nh(rt->nh) returns NULL.
Would you like to send another improved patch version (instead of a reply)
according to a change review?

Regards,
Markus

