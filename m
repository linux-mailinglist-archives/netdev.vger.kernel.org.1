Return-Path: <netdev+bounces-141070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2D9B95D2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F469284137
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A6155324;
	Fri,  1 Nov 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G5e3v06M"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3671CA81;
	Fri,  1 Nov 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479566; cv=none; b=MbiUBHS5+uCtw0kgnnLC/X0TxmMYeDkzg3IQXcmZ2W9dzK3K8cVGcLam/eCmm8u9PeNmQMy1/qgKSilma3C24OHb2TknyDdo0IKfVGqE3Anwrd6UhV1dJea0pXXVB89UnkYN3rpM5wKFJVoDYIb6nAkKMIzOWm/TmM2PxHhPYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479566; c=relaxed/simple;
	bh=lCjxAOo03fX0mkrZ3oqu3YDGLatu8BTDboScTkmZjzs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=W9GXembqBCV9pzJjkMOzJozeo6ouqFjpm9JU31hFCgKsBQizzVMtye4jw8GSg6/EdJK4f+ox8VcN80Ekkxzy+Q71GBvH4r1roXK3JvtJhrEpAfoIhtvGjaBCjHMBhuwAP9arX0OBBA3J6dY8vPWuiTqrN7Z8enbhPL3wE99FSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G5e3v06M; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730479543; x=1731084343; i=markus.elfring@web.de;
	bh=kaksipcSDTEyCM1cENFazHTVtUsnXvmooZxjFwZ0RTw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G5e3v06MXoSEEffCbyCq5GZaI7MAstyFWkvwVx5ejxj2jZpZ6muPcvTaBjtNVPel
	 Zox6ls6TUrixsyhLqkFHLYc5NXBKrnJmQGX9ClxSkVz1UTKRy3PgqXV8g9VpWAC2J
	 prKuviMHz+McJS2ugBVKjZQDJINuQluYj2L5m3xc0BUYtGByhI6d0o/Sb7gFginSM
	 G8uMTejHAO6TV5SCBgC88ZSAHDJlZtBRwUUfz4UvHbuoOwjS3/Khv92DOOvvlwoHZ
	 xnmDx6eZ7nPn/k8pbXX8YmVQGbVSU+V0FRa/oNRJ45vRdkNDPCLFVrLrssb/gi9rI
	 slMjKqBfAULH+gbqUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1tPxlY1vxf-00Vp7J; Fri, 01
 Nov 2024 17:45:43 +0100
Message-ID: <feac7231-5563-4f68-8554-483c7030b50a@web.de>
Date: Fri, 1 Nov 2024 17:45:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yi Zou <03zouyi09.25@gmail.com>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 21210240012@m.fudan.edu.cn,
 21302010073@m.fudan.edu.cn
References: <20241101044828.55960-1-03zouyi09.25@gmail.com>
Subject: Re: [PATCH] ipv6: ip6_fib: fix possible null-pointer-dereference in
 ipv6_route_native_seq_show
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241101044828.55960-1-03zouyi09.25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C9/LMvIwitMk/ebqIfgkNZc/L0ZpXW58f6+5H0KPxfIRXBO+vfr
 pH+rBhgLdova9QKuiN5BvBhfC38jdTEo4ep8DOBTAScSriuiCfKr7bNi48NU8Lj22Mhs1iP
 QjZuxIl3K5OftAIb3IwQP3tOdp8vu/ysxsgCApTHhSBhO0Mm4VwSJl8Tu3AcoThp9zfmE+B
 VmU6vLyYbRLlXSFl/cLjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mjV2+RYPTW4=;B/tnfHDIeaFoFj2EFrirLXlv6Yc
 /QxDUrF5db78mKyMZjnuEfctfzTGTbGFdzTC3dMZPF/V9XVj9p/AunjusnCh+sdI+dSfN9q6s
 FOK05WD8VtBQQpWVG4N7BfMgLkDxNcpQ1WJoDgjkzv0AkyslCrD4HoZJsGWaBiNA0X7EP3rdz
 4FVsbxnIHEhoI/LALQz4DboKYl6+DCjhlv0mYQjPDKzlcMJrwf9uj44NzsZp/+zR31KB1ihy9
 wrniXF/e2mFcLdRgZlwoveWTrwKOFWGuS8tyPWbflKw5WTpPlBs5QUIkvLf3LSg4XDFKdfFgY
 QrKxaDWneO3p06601doiBL/604/ViPTrhOQzVJmKwu3Kx5XgPhnXqh2sQk8h6iuK3R85aPLQE
 Rse7h9oejJUHGGurc2RCuI40na7BNvLWjW4uA6ElrlvSwNkySrCTKlvvvzd9preWcbFKXgOJ6
 NwY3nFUTapJrkSZ2xQl+2fSKj44X6q8PRwz9iZwDz6JCH6Xk2lzo1zSPtkCl4UiWCwRag+RAY
 4Z8bqy20CBUrESsT25iDKVxsngQ4wm3zhzoqZzyzvu2Rs1XTP8yo3WNStYdKjvSpq2a6ou707
 vvehGoM29o+t068kqqJkqH9qhFlmG2LGrnQ7AihojjI6MGF0LuikY5sOM9JlUQBt47HgnZJie
 O2QIq+NUUY/MILo0mhlrxUT37A0O0Zq36c+N0hPeV6wz7m7QqUmG6+oL1u3fqMYkfN2AtwNXl
 YJHh5yCrOg4MvS2sW4u2eaNqqy/I128y8D6jV5OFvlkTr0pztVSNdLN1xJu99UYwfEBdB6CA4
 BFTkggYNpjQP7EuQvfc/QyeQ==

> In the ipv6_route_native_seq_show function, the fib6_nh variable
> is assigned the value from nexthop_fib6_nh(rt->nh), which could
> return NULL. This creates a risk of a null-pointer-dereference
> when accessing fib6_nh->fib_nh_gw_family. This can be resolved by
> checking if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_fami=
ly
> and assign dev using dev =3D fib6_nh ? fib6_nh->fib_nh_dev : NULL;
> to prevent null-pointer dereference errors.
=E2=80=A6

* Please choose an imperative wording for an improved change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94

* Would you like to append parentheses to function names?

* I suggest to omit the word =E2=80=9Cpossible=E2=80=9D from the summary p=
hrase.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n145


Regards,
Markus

